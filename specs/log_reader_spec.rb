# frozen_string_literal: true

require "./require_all.rb"

RSpec.describe LogReader do
  let(:file_path) { "specs/data/webserver_test.log" }
  let(:log_reader) { LogReader.new(file_path: file_path) }

  let(:file_path2) { "specs/data/webserver_test_2.log" }
  let(:log_reader2) { LogReader.new(file_path: file_path2) }

  describe "#new" do
    it "LogReader object has correct attributes" do
      expect(log_reader.file_path).to eq("specs/data/webserver_test.log")
    end
  end

  describe "#build_entries" do
    context "using 'webserver_test' file" do
      let(:entries) { log_reader.build_entries }

      it "builds 500 entry objects" do
        expect(entries.count).to eq(500)
      end

      it "builds Entry objects" do
        expect(entries.all? { |e| e.class == Entry }).to be(true)
      end

      it "object data matches data in log file" do
        expect(entries.last.path).to eq("/about")
        expect(entries.last.ip_address).to eq("543.910.244.929")
      end
    end

    context "using 'webserver_test_2' file" do
      let(:entries) { log_reader2.build_entries }

      it "builds 1000 entry objects" do
        expect(entries.count).to eq(1000)
      end

      it "builds Entry objects" do
        expect(entries.all? { |e| e.class == Entry }).to be(true)
      end

      it "object data matches data in log file" do
        expect(entries.last.path).to eq("/about")
        expect(entries.last.ip_address).to eq("543.910.244.912")
      end
    end
  end
end
