# Ruby Practice: CSV Reader CLI Tool
This is a little practice project I made to learn Ruby.  It's a CLI tool that reads CSVs, filtering and processing their fields (string, int, float) based on the "CSV type" given.  Two sample CSV types (`user` & `business`) as well as `generic` (for processing all fields as string types) are given via the `CSV_TYPES` variable, but others could be added or modified here.

## Instructions
1. Install Ruby
2. Run `ruby csv_reader.rb CSV_TYPE CSV_FILEPATH`

## Samples & Example Command
In the `samples/` directory you can find sample CSVs matching the `user` and `business` types, as well as a miscellaneous CSV to see how `user` and `business` types filter its fields, and how the `generic` type does not.  For example:
```bash
bash-3.2$ ruby csv_reader-reader.rb user samples/users.csv
{"name"=>"David", "age"=>32, "height"=>173, "weight"=>152.3}
{"name"=>"Susan", "age"=>44, "height"=>161, "weight"=>210.9}
{"name"=>"Katie", "age"=>31, "height"=>170, "weight"=>144.5}
{"name"=>"Bob", "age"=>54, "height"=>177, "weight"=>232.6}
```
