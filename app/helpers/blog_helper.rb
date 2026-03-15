# frozen_string_literal: true

module BlogHelper
  def blog_path(post = nil, page: nil)
    if page
      "/blog/page/#{page}"
    elsif post
      "/blog/#{post.slug}"
    else
      "/blog"
    end
  end

  def formatted_date(date)
    return "" unless date

    date.strftime("%B %d, %Y")
  end

  def reading_time(content)
    words_per_minute = 200
    word_count = content.split.size
    minutes = (word_count / words_per_minute.to_f).ceil
    "#{minutes} min read"
  end
end
