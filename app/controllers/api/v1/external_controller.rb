class Api::V1::ExternalController < Api::ApiController

  def list_stories
    render json: Story.cycle_for_mobile.map{ |s| s.as_json( only: [:created_at, :source, :points_text, :href, :originplace, :is_new, :altering_of_the_points])}
  end

end
