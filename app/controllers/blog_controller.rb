# frozen_string_literal: true

class BlogController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show categories category feed]
  layout "blog"

  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @posts = BlogPost.paginate(page: page, per: 6)
    @total_pages = BlogPost.total_pages
    @current_page = page

    fresh_when etag: BlogPost.cache_key, last_modified: last_modified_time
  end

  def show
    @post = BlogPost.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @post

    fresh_when etag: @post.cache_key, last_modified: @post.date
  end

  def categories
    @categories = BlogPost.categories
    fresh_when etag: BlogPost.cache_key
  end

  def category
    @category = params[:category]
    @posts = BlogPost.by_category(@category)
    @total_pages = 1
    @current_page = 1

    render "index"
  end

  def feed
    @posts = BlogPost.all.take(20)
    response.content_type = "text/xml"
    render formats: [ :xml ]
  end

  private

  def last_modified_time
    BlogPost.all.map(&:date).compact.max
  end
end
