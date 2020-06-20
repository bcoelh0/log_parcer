# Log Parser

**Author:** Bruno Coelho

### Getting started
1. `bundle install`
2. `rspec specs/`
3. `ruby parser.rb <log_file>` Default file: `data/webserver.log`

### Structure
#### Models
- Entry -- represents an entry on the log file (row)
  - path: path visited
  - ip_address: ip address of visitor

#### Services
These classes perform operations on the data passed to them.

- LogReader -- reads the log file and creates an Entry object per each row in the file
- LogAnalyser -- treats the data stored in Entry objects to return visits count

#### Other files
- app.rb -- Main file that uses the services to perform the script desired action


### Possible improvements / to do
- improve code on LogAnalyser, could be cleaner
