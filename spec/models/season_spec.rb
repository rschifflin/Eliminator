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

  it "starts the season when it receives a message to start a week" do
    season = Season.new
    expect{ season.start_week }.to change { season.unstarted? }.to false
  end

  it "finishes the season when all its weeks are finished" do
    season = Season.new
    weeks = [].tap do |ary| 
      5.times { ary << double(Week, finished?: true) }
    end
    season.stub(:weeks) { weeks }
    season.start_week
    expect { season.finish_week }.to change { season.finished? }.to true
  end

  it "doesn't finish the season when only some of its weeks are finished" do
    season = Season.new
    weeks = [].tap do |ary| 
      2.times { ary << double(Week, finished?: true) }
      3.times { ary << double(Week, finished?: false) }
    end
    season.stub(:weeks) { weeks }
    season.start_week
    expect { season.finish_week }.to_not change { season.finished? }.to true
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
        season1 = create(:season, year: 1000)
        season2 = create(:season, year: 2000)
        season3 = create(:season, year: 3000)
        expect(Season.current).to eq season3
      end
    end
  end
end
