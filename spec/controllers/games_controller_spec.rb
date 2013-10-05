require 'spec_helper'

describe GamesController do

  specify "#index" do
    GamesController.any_instance.should_receive(:index)
    visit games_path
  end

end
