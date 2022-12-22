# frozen_string_literal: true

module ConfigHelper
  def login_layout
    case Rails.application.config.login_layout
    when 'ILLUSTRATION'
      'body/login_illustration'
    when 'COVER'
      'body/login_cover'
    else
      'body/login'
    end
  end

  def interface_layout
    case Rails.application.config.interface_layout
    when 'VERTICAL'
      'body/vertical'
    when 'VERTICAL-TRANSPARENT'
      'body/vertical_transparent'
    when 'OVERLAP'
      'body/overlap'
    when 'CONDENSED'
      'body/condensed'
    else
      'body/horizontal'
    end
  end

  def interface_mode
    case mode || Rails.application.config.interface_mode
    when 'DARK'
      'theme-dark'
    when 'LIGHT'
      'theme-light'
    else
      'theme-dark-auto'
    end
  end

  def mode
    current_user&.pallete&.split('-')&.dig(0)
  end

  def interface_theme
    case theme || Rails.application.config.interface_theme
    when 'COOL'
      'application-cool'
    else
      'application'
    end
  end

  def theme
    current_user&.pallete&.split('-')&.dig(1)
  end

  def multi_tenant_mode?
    Rails.application.config.multi_tenant_mode || current_user&.admin?
  end

  def show_landing_page?
    Rails.application.config.show_landing_page
  end
end
