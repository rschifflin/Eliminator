require 'spec_helper'

describe Timekeeper do
  describe "#current_week" do
    context "with no season with no weeks" do
      it "returns nil" do
        expect(Timekeeper.current_week_for nil ).to be_nil
      end
    end

    context "with a season" do 
      let(:season) { Season.new }

      context "with no weeks" do
        it "returns nil" do
          expect(Timekeeper.current_week_for season ).to be_nil
        end
      end

      context "with all unstarted weeks" do
        let(:first_week) { double(Week, unstarted?: true, started?: false) }
        before do 
          weeks = [first_week] + ([double(Week, unstarted?: true, started?: false)] * 5)
          weeks.each_with_index { |week, i| week.stub(:week_no){ i } }
          season.stub(:weeks) { weeks.shuffle }
        end

        it "returns the earliest week number" do
          expect(Timekeeper.current_week_for season).to eq first_week
        end
      end

      context "with one week that has started" do
        let(:started_week) { double(Week, started?: true) }
        before do
          weeks = ([double(Week, started?: false)] * 5) << started_week
          weeks.each_with_index { |week, i| week.stub(:week_no){ i } }
          season.stub(:weeks) { weeks.shuffle } 
        end

        it "returns the first started week" do
          expect(Timekeeper.current_week_for season).to eq started_week
        end
      end

      context "with multiple weeks, some started, some not" do
        let(:first_started_week) { double(Week, started?: true) }
        before do
          unstarted_weeks = [double(Week, unstarted?: true, started?: false)] * 5
          started_weeks = [first_started_week] + ([double(Week, unstarted?: false, started?: true)] * 5)
          (unstarted_weeks + started_weeks).each_with_index { |week, i| week.stub(:week_no){ i } }
          season.stub(:weeks) { (unstarted_weeks + started_weeks).shuffle } 
        end

        it "returns the first started week" do
          expect(Timekeeper.current_week_for season).to eq first_started_week
        end
      end

      context "with some finished weeks and some unstarted weeks" do
        let(:first_unstarted_week) { double(Week, unstarted?: true, started?: false) }
        before do
          unstarted_weeks = [first_unstarted_week] + ([double(Week, unstarted?: true, started?: false)] * 5)
          finished_weeks = [double(Week, unstarted?: false, started?: false, finished?: true)] * 5
          (finished_weeks + unstarted_weeks).each_with_index { |week, i| week.stub(:week_no){ i } }
          season.stub(:weeks) { (finished_weeks + unstarted_weeks).shuffle } 
        end

        it "returns the first unstarted week" do
          expect(Timekeeper.current_week_for season).to eq first_unstarted_week
        end
      end

      context "With all finished weeks" do
        let(:last_finished_week) { double(Week, unstarted?: false, started?: false, finished?: true) }
        before do
          weeks = ([double(Week, unstarted?: false, started?: false, finished?: true)] * 5) << last_finished_week
          weeks.each_with_index { |week, i| week.stub(:week_no) { i } }
          season.stub(:weeks) { weeks.shuffle }
        end

        it "returns the last finished week" do
          expect(Timekeeper.current_week_for season).to eq last_finished_week
        end
      end
    end
  end


  describe "#current_season" do
    let(:seasons) { [] }

    context "with no season" do
      it "returns nil" do
        expect(Timekeeper.current_season_from nil ).to be_nil
      end
    end
    context "with all unstarted seasons" do
      let(:first_season) { double(Season, unstarted?: true, started?: false) }
      before do 
        seasons.concat [first_season] + ([double(Season, unstarted?: true, started?: false)] * 8)
        seasons.each_with_index { |season, i| season.stub(:year){ 2013 + i } }
        seasons.shuffle!
      end

      it "returns the earliest season year" do
        expect(Timekeeper.current_season_from(seasons)).to eq first_season
      end
    end

    context "with one season that has started" do
      let(:started_season) { double(Season, started?: true) }
      before do
        seasons.concat ([double(Season, started?: false)] * 5) << started_season
        seasons.each_with_index { |season, i| season.stub(:year){ 2013 + i } }
        seasons.shuffle!
      end

      it "returns the first started week" do
        expect(Timekeeper.current_season_from seasons).to eq started_season
      end
    end

    context "with multiple seasons, some started, some not" do
      let(:first_started_season) { double(Season, started?: true) }
      before do
        unstarted_seasons = [double(Season, unstarted?: true, started?: false)] * 5
        started_seasons = [first_started_season] + ([double(Season, unstarted?: false, started?: true)] * 5)
        seasons.concat(unstarted_seasons).concat(started_seasons)
        seasons.each_with_index { |season, i| season.stub(:year){ 2013 + i } }
        seasons.shuffle!
      end

      it "returns the first started season" do
        expect(Timekeeper.current_season_from seasons).to eq first_started_season
      end
    end

    context "with some finished seasons and some unstarted seasons" do
      let(:first_unstarted_season) { double(Season, unstarted?: true, started?: false) }
      before do
        unstarted_seasons = [first_unstarted_season] + ([double(Season, unstarted?: true, started?: false)] * 3)
        finished_seasons = [double(Season, unstarted?: false, started?: false, finished?: true)] * 6
        seasons.concat(finished_seasons).concat(unstarted_seasons).each_with_index { |season, i| season.stub(:year){ 2013 + i } }
        seasons.shuffle!
      end

      it "returns the first unstarted season" do
        expect(Timekeeper.current_season_from seasons).to eq first_unstarted_season
      end
    end

    context "With all finished seasons" do
      let(:last_finished_season) { double(Season, unstarted?: false, started?: false, finished?: true) }
      before do
        seasons.concat([double(Week, unstarted?: false, started?: false, finished?: true)] * 5) << last_finished_season
        seasons.each_with_index { |season, i| season.stub(:year) { 2013 + i } }
        seasons.shuffle!
      end

      it "returns the last finished season" do
        expect(Timekeeper.current_season_from seasons).to eq last_finished_season
      end
    end
  end
end


