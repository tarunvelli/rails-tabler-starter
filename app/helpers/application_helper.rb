module ApplicationHelper
  def nav_bar(&block)
    content_tag(:ul, class: 'navbar-nav', &block)
  end

  def nav_link(path, &block)
    options = current_page?(path) ? { class: 'nav-item active' } : { class: 'nav-item' }
    content_tag(:li, options) do
      link_to path, class: 'nav-link', &block
    end
  end

  def user_spaces
    @user_spaces ||= current_user.spaces.order(:name).filter(&:active?)
  end

  def abbrev_name(name)
    name.blank? ? '?' : name.split(' ').map(&:first).join('.')
  end

  def login_layout
    case @login || Rails.application.config.login_layout
    when 'ILLUSTRATION'
      'body/login_illustration'
    when 'COVER'
      'body/login_cover'
    else
      'body/login'
    end
  end

  def interface_layout
    case @layout || Rails.application.config.interface_layout
    when 'VERTICAL'
      'body/vertical'
    when 'OVERLAP'
      'body/overlap'
    when 'CONDENSED'
      'body/condensed'
    else
      'body/horizontal'
    end
  end

  def interface_mode
    case @mode || Rails.application.config.interface_mode
    when 'DARK'
      'theme-dark'
    else
      'theme-light'
    end
  end

  def interface_theme
    case @theme || Rails.application.config.interface_theme
    when 'COOL'
      'application-cool'
    else
      'application'
    end
  end

  def multi_tenant_mode?
    Rails.application.config.multi_tenant_mode
  end
end
