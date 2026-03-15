# frozen_string_literal: true

class BlogRenderer
  def initialize(content)
    @content = content
  end

  def render
    markdown.render(@content).html_safe
  end

  private

  def markdown
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)

    Redcarpet::Markdown.new(renderer, {
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      disableIndentedCodeBlocks: true
    })
  end
end
