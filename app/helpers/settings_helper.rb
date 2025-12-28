# frozen_string_literal: true

module SettingsHelper
  def login_layout
    case AppSettings.login_layout
    when "ILLUSTRATION"
      "body/login_illustration"
    when "COVER"
      "body/login_cover"
    else
      "body/login"
    end
  end

  def interface_layout
    case AppSettings.interface_layout
    when "VERTICAL"
      "body/vertical"
    when "VERTICAL-TRANSPARENT"
      "body/vertical_transparent"
    when "OVERLAP"
      "body/overlap"
    when "CONDENSED"
      "body/condensed"
    else
      "body/horizontal"
    end
  end

  def color_mode
    case AppSettings.color_mode
    when "DARK"
      "dark"
    else
      "light"
    end
  end

  def theme_base
    AppSettings.theme_base.downcase
  end

  def theme_font
    AppSettings.font_family.downcase
  end

  def primary_color
    AppSettings.color_scheme.downcase
  end

  def corner_radius
    AppSettings.corner_radius.downcase
  end

  def multi_tenant_mode?
    AppSettings.multi_tenant_mode
  end

  def show_landing_page?
    AppSettings.show_landing_page
  end
end
