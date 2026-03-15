# frozen_string_literal: true

class BlogPost
  DIRECTORY = Rails.root.join("content/blog")

  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
    parse_file
  end

  class << self
    def all
      Rails.cache.fetch(cache_key) do
        posts.select(&:published?).sort_by { |post| post.date || Date.new }.reverse
      end
    end

    def find(slug)
      all.find { |post| post.slug == slug }
    end

    def paginate(page:, per: 6)
      all.slice((page - 1) * per, per)
    end

    def total_pages(per: 6)
      (all.size.to_f / per).ceil
    end

    def categories
      all.map(&:category).compact.uniq.sort
    end

    def by_category(category)
      all.select { |post| post.category == category }
    end

    def cache_key
      return "blog/posts/empty" unless DIRECTORY.exist?

      mtime = Dir.glob(DIRECTORY.join("*.md")).map { |f| File.mtime(f).to_i }.max
      "blog/posts/#{mtime}"
    end

    private

    def posts
      return @posts if @posts

      @posts = []
      return @posts unless DIRECTORY.exist?

      Dir.glob(DIRECTORY.join("*.md")).each do |filepath|
        @posts << new(filepath)
      end

      @posts
    end
  end

  def slug
    @slug ||= begin
      File.basename(filepath, ".md")
    end
  end

  def cache_key
    "blog/post/#{slug}/#{File.mtime(filepath).to_i}"
  end

  def title
    front_matter[:title] || slug.titleize
  end

  def summary
    front_matter[:summary]
  end

  def date
    @date ||= front_matter[:date]
  end

  def published?
    front_matter[:published] != false
  end

  def category
    front_matter[:category]
  end

  def author
    front_matter[:author]
  end

  def content
    @content
  end

  def rendered_content
    Rails.cache.fetch("#{cache_key}/rendered") do
      BlogRenderer.new(content).render
    end
  end

  private

  attr_reader :front_matter

  def parse_file
    file_content = File.read(filepath)
    @front_matter = parse_front_matter(file_content)
    @content = extract_content(file_content)
  end

  def parse_front_matter(content)
    return {} unless content =~ /\A---\n(.*?)\n---/m

    YAML.safe_load(
      Regexp.last_match(1),
      permitted_classes: [ Date ],
      permitted_symbols: [],
      aliases: true
    ).symbolize_keys
  rescue
    {}
  end

  def extract_content(content)
    content.sub(/\A---.*?---\n*/m, "")
  end
end
