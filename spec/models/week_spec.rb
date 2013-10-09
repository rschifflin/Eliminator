require 'spec_helper'

describe Week do

  it { should validate_presence_of :season }
  it { should belong_to :season }
  it { should have_many :games }
  it { should ensure_inclusion_of(:progress).in_array(%w|unstarted started finished|) }

  it "has a factory" do
    expect(create(:week)).to be_valid
  end

  it "has a week number" do
    season = create(:season, year: 2014)
    week = create(:week, week_no: 5, season: season)
    expect(week.week_no).to eq 5
  end

  it "starts the week whenever it receives a start_game message" do
    week = create(:week)
    expect { week.start_game }.to change { week.reload.unstarted? }.to false
  end

  it "finishes whenever all of its games finish" do
    week = create(:week)
    games = [].tap { |ary| 3.times { ary << double(Game, state: "started", unstarted?: false) } }
    week.stub(:games) { games }
    expect { week.start_game }.to change{ week.finished? }.to true
  end

  it "doesn't finish when only some of its games finish" do
    week = create(:week)
    games = [].tap do |ary| 
      2.times { ary << double(Game, state: "started", unstarted?: false) } 
      ary << double(Game, state: "unstarted", unstarted?: true)
    end
    week.stub(:games) { games }
    expect { week.start_game }.to_not change { week.reload.finished? }.to true
  end

  it "notifies the season when it's started" do
    week = Week.new
    season = double(Season, 
                    marked_for_destruction?: false, 
                    assign_next_week_no: 1,
                    finish_week: true)
    week.stub(:season) { season }
    season.should_receive(:start_week)
    week.start_game
  end

  it "notifies the season when it's finished" do
    week = Week.new
    season = double(Season, 
                    start_week: true,
                    marked_for_destruction?: false, 
                    assign_next_week_no: 1)
    week.stub(:season) { season }
    season.should_receive(:finish_week)
    week.start_game
  end

  it "uses the correct week number based on the season" do
    old_season = create(:season, year: 2013) 
    new_season = create(:season, year: 2014) 
    weeks = create_list(:week, 16, season: old_season)
    weeks = create_list(:week, 5, season: new_season)
    expect(weeks.map{ |w| w.week_no }).to eq((1..5).to_a)
  end


  describe ".current" do
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
