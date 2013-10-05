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

  describe "Adding weeks" do
    it "should set the week number of the week to the most recent" do 
      create_list(:week, 10, season: season)
      expect(week.week_no).to eq 11
    end
  end
end
