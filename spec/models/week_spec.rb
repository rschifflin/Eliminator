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

  describe "#on_game_start" do
    let(:season) { Season.create }
    subject(:week) { create(:week, season: season) }
    before { season.stub(:on_week_start) }
    
    it "starts the week" do
      expect(week.unstarted?).to be_true
      #expect { week.on_game_start }.to change { week.unstarted? }.to false
    end

    it "notifies the season that it's started" do
      season.should_receive(:on_week_start)
      week.on_game_start
    end
  end

  describe "#on_game_finish" do
    let(:season) { Season.create }
    subject(:week) { create(:week, season: season) }
    before do 
      season.stub(:on_week_finish)
      week.stub(:season) { season }
    end

    it "finishes whenever all of its games finish" do
      games = [double(Game, state: "finished", finished?: true)] * 7
      week.stub(:games) { games }
      expect { week.on_game_finish }.to change{ week.finished? }.to true
    end

    it "doesn't finish when only some of its games finish" do
      games = [double(Game, state: "finished", finished?: true)] * 2 + 
              [double(Game, state: "unstarted", finished?: false)]
      week.stub(:games) { games }
      expect { week.on_game_finish }.to_not change { week.reload.finished? }.to true
    end

    it "notifies the season when it's finished" do
      season.should_receive(:on_week_finish)
      week.on_game_finish
    end
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
        create(:week, season: season, week_no: 1, progress: :finished)
        create(:week, season: season, week_no: 2, progress: :finished)
        week3 = create(:week, season: season, week_no: 3, progress: :unstarted)
        create(:week, season: season, week_no: 4, progress: :unstarted)
        expect(Week.current).to eq week3
      end
    end
  end

  
end
