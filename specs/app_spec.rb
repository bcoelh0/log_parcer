# frozen_string_literal: true

require "./app/app.rb"
require "./specs/spec_helper.rb"

RSpec.describe App do
  describe "#main" do
    context "using log file webserver_test" do
      context "inputted params are correct" do
        let(:file_path) { "./specs/data/webserver_test.log" }
        let(:main) { App.main(file_path) }

        it "executes correctly" do
          expect(main).to eq(true)
        end

        it "prints expected results to stdout" do
          results = <<~STR
            Number of all page views:
            /about/2     -- 90 visits
            /contact     -- 89 visits
            /index       -- 82 visits
            /about       -- 81 visits
            /help_page/1 -- 80 visits
            /home        -- 78 visits

            ============================

            Number of unique page views:
            /index       -- 23 unique visits
            /home        -- 23 unique visits
            /contact     -- 23 unique visits
            /help_page/1 -- 23 unique visits
            /about/2     -- 22 unique visits
            /about       -- 21 unique visits
          STR
          expect { main }.to output(results).to_stdout
        end
      end

      context "inputted params are incorrect" do
        let(:wrong_file_path) { "./specs/data/wrong_name.log" }

        it "prints 'file not found' error message to stdout" do
          results = "File not found!\n"
          expect { App.main(wrong_file_path) }.to output(results).to_stdout
        end

        it "prints 'no file path' error message to stdout" do
          results = "Please provide a path top the logs you wish to parse\n"
          expect { App.main(nil) }.to output(results).to_stdout
        end
      end
    end

    context "using log file webserver_test" do
      context "inputted params are correct" do
        let(:file_path) { "./specs/data/webserver_test_2.log" }
        let(:main) { App.main(file_path) }

        it "executes correctly" do
          expect(main).to eq(true)
        end

        it "prints expected results to stdout" do
          results = <<~STR
            Number of all page views:
            /about/2     -- 180 visits
            /contact     -- 178 visits
            /index       -- 164 visits
            /about       -- 162 visits
            /help_page/1 -- 160 visits
            /home        -- 156 visits

            ============================

            Number of unique page views:
            /home        -- 25 unique visits
            /about/2     -- 24 unique visits
            /index       -- 23 unique visits
            /contact     -- 23 unique visits
            /help_page/1 -- 23 unique visits
            /about       -- 22 unique visits
          STR
          expect { main }.to output(results).to_stdout
        end
      end
    end
  end
end
