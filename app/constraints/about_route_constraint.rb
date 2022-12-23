class AboutRouteConstraint
  def initialize; end

  def matches?(_request)
    AppSettings.show_landing_page
  end
end
