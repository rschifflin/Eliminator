require 'spec_helper'

describe Week do
  it { should validate_presence_of :season }
  it { should belong_to :season }
  it { should have_many :games }

  it "has a week number" do
    season = create(:season, year: 2014)
    week = create(:week, week_no: 5, season: season)
    expect(week.week_no).to eq 5
  end

  it "use the correct week number based on the season" do
    old_season = create(:season, year: 2013) 
    new_season = create(:season, year: 2014) 
    weeks = create_list(:week, 16, season: old_season)
    weeks = create_list(:week, 5, season: new_season)
    expect(weeks.map{ |w| w.week_no }).to eq((1..5).to_a)
  end

  it "has a factory" do
    expect(create(:week)).to be_valid
  end

  describe "##current" do
    context "With no weeks" do
      it "returns nil" do
        expect(Week.current).to be_nil
      end
    end

    context "With weeks in the same season" do
      it "returns the most recent week" do
        season = create(:season)
        week1 = create(:week, season: season, week_no: 1)
        week2 = create(:week, season: season, week_no: 2)
        week3 = create(:week, season: season, week_no: 3)
        expect(Week.current).to eq week3
      end
    end
  end
end
