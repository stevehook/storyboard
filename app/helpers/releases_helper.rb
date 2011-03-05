module ReleasesHelper
  def burndown_data(release)
    # TODO: Get the real data from the statistics model
    '[[[1, 300],[2,243],[3,221],[4,198],[4],[5],[6],[7],[8],[9]]]'
  end
  
  def velocity_data(release)
    data = '[['
    release.sprints.sort_by{ |sprint| sprint.order }.each_with_index do |sprint, index|
      # TODO: Need to filter this to only include stories that are DONE
      data << "[#{index + 1},#{sprint.points_count}],"
    end
    data << ']]'
  end
end
