# frozen_string_literal: true

module ApplicationHelper
  include ConfigHelper

  def nav_bar(&block)
    content_tag(:ul, class: 'navbar-nav', &block)
  end

  def nav_link(path, &block)
    options = current_page?(path) ? { class: 'nav-item active' } : { class: 'nav-item' }
    content_tag(:li, options) do
      link_to path, class: 'nav-link', &block
    end
  end

  def settings_nav_link(&block)
    options = current_page?(edit_space_path(@space)) || roles_page? ? { class: 'nav-item active' } : { class: 'nav-item' }
    content_tag(:li, options) do
      link_to edit_space_path(@space), class: 'nav-link', &block
    end
  end

  def roles_page?
    controller = 'spaces/roles'
    actions = %w[index new edit]
    actions.any? { |action| params[:controller] == controller && params[:action] == action }
  end

  def user_spaces
    @user_spaces ||= current_user.spaces.order(:name).filter(&:active?)
  end

  def abbrev_name(name)
    name.blank? ? '?' : name.split(' ').map(&:first).join('.')
  end
end
