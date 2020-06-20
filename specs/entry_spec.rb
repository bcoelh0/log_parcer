# frozen_string_literal: true

require "./require_all.rb"

RSpec.describe Entry do
  let(:entry) { Entry.new(path: "/about", ip_address: "86.10.190.143") }

  describe "#new" do
    it "Entry object has correct attributes" do
      expect(entry.path).to eq("/about")
      expect(entry.ip_address).to eq("86.10.190.143")
    end
  end
end
