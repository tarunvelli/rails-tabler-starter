class AboutRouteConstraint
  def initialize
    @show_landing_page = Rails.application.config.show_landing_page
  end

  def matches?(_request)
    @show_landing_page
  end
end
