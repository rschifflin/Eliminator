require 'spec_helper'

describe Season do
  it { should have_many(:weeks) }
  it { should have_many(:games).through(:weeks) }
  
  let(:season) { create(:season) }
  let(:week) { create(:week, season: season) }

  it "has a year" do
    good_season = create(:season, year: 1999)
    expect(good_season.year).to eq 1999
  end

  describe "#on_season_start" do
    it "starts the season" do
      season = Season.new
      expect{ season.on_week_start }.to change { season.unstarted? }.to false
    end
  end

  describe "#on_season_finish" do
    it "finishes the season when all its weeks are finished" do
      season = Season.create
      weeks = [double(Week, finished?: true)] * 5 
      season.stub(:weeks) { weeks }
      expect { season.on_week_finish }.to change { season.finished? }.to true
    end

    it "doesn't finish the season when only some of its weeks are finished" do
      season = Season.create
      weeks = [double(Week, finished?: true)]  * 2 + 
              [double(Week, finished?: false)] * 3
      season.stub(:weeks) { weeks }
      expect { season.on_week_finish }.to_not change { season.finished? }.to true
    end
  end

  
  describe "Adding weeks" do
    it "should set the week number of the week to the most recent" do 
      create_list(:week, 10, season: season)
      expect(week.week_no).to eq 11
    end
  end
  
  describe ".current" do
    context "With no seasons" do
      it "should return nil" do
        expect(Season.current).to be_nil
      end
    end

    context "With seasons" do
      it "should return the most recent season" do
        create(:season, year: 1000, progress: :finished)
        season2 = create(:season, year: 2000, progress: :started)
        create(:season, year: 3000, progress: :unstarted)
        expect(Season.current).to eq season2
      end
    end
  end
end
