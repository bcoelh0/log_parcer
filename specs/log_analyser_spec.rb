# frozen_string_literal: true

require "./require_all.rb"

RSpec.describe LogAnalyser do
  let(:file_path) { "specs/data/webserver_test.log" }
  let(:log_entries) { LogReader.new(file_path: file_path).build_entries }
  let(:log_analyser) { LogAnalyser.new(log_entries: log_entries) }

  let(:file_path2) { "specs/data/webserver_test_2.log" }
  let(:log_entries2) { LogReader.new(file_path: file_path2).build_entries }
  let(:log_analyser2) { LogAnalyser.new(log_entries: log_entries2) }

  describe "#new" do
    it "LogAnalyser object has correct attributes" do
      expect(log_analyser.log_entries).to eq(log_entries)
    end
  end

  describe "#visit_count" do
    context "using 'webserver_test' file" do
      let(:visit_count) { log_analyser.visit_count }

      it "returns hash with paths and total visit count" do
        expect(visit_count).to eq(
          [
            { path: "/about/2", visits: 90 },
            { path: "/contact", visits: 89 },
            { path: "/index", visits: 82 },
            { path: "/about", visits: 81 },
            { path: "/help_page/1", visits: 80 },
            { path: "/home", visits: 78 }
          ]
        )
      end

      it "is sorted in decrescent order" do
        expect(visit_count.map { |e| e[:visits] }).to eq(visit_count.map { |e| e[:visits] }.sort.reverse)
      end
    end

    context "using 'webserver_test_2' file" do
      let(:visit_count2) { log_analyser2.visit_count }

      it "returns hash with paths and total visit count" do
        expect(visit_count2).to eq(
          [
            { path: "/about/2", visits: 180 },
            { path: "/contact", visits: 178 },
            { path: "/index", visits: 164 },
            { path: "/about", visits: 162 },
            { path: "/help_page/1", visits: 160 },
            { path: "/home", visits: 156 }
          ]
        )
      end

      it "is sorted in decrescent order" do
        expect(visit_count2.map { |e| e[:visits] }).to eq(visit_count2.map { |e| e[:visits] }.sort.reverse)
      end
    end
  end

  describe "#unique_visit_count" do
    context "using 'webserver_test' file" do
      let(:unique_visit_count) { log_analyser.unique_visit_count }

      it "returns hash with paths and unique visit count in decrescent order" do
        expect(unique_visit_count).to eq(
          [
            { path: "/index", visits: 23 },
            { path: "/home", visits: 23 },
            { path: "/contact", visits: 23 },
            { path: "/help_page/1", visits: 23 },
            { path: "/about/2", visits: 22 },
            { path: "/about", visits: 21 }
          ]
        )
      end

      it "is sorted in decrescent order" do
        expect(unique_visit_count.map { |e| e[:visits] }).to eq(unique_visit_count.map { |e| e[:visits] }.sort.reverse)
      end
    end

    context "using 'webserver_test_2' file" do
      let(:unique_visit_count2) { log_analyser2.unique_visit_count }

      it "returns hash with paths and unique visit count in decrescent order" do
        expect(unique_visit_count2).to eq(
          [
            { path: "/home", visits: 25 },
            { path: "/about/2", visits: 24 },
            { path: "/index", visits: 23 },
            { path: "/contact", visits: 23 },
            { path: "/help_page/1", visits: 23 },
            { path: "/about", visits: 22 }
          ]
        )
      end

      it "is sorted in decrescent order" do
        expect(unique_visit_count2.map { |e| e[:visits] }).to eq(unique_visit_count2.map { |e| e[:visits] }.sort.reverse)
      end
    end
  end
end
