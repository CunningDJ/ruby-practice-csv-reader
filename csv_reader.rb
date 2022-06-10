require 'set'

# Field types by CSV type
CSV_FIELDS = {
    user: {
        string_fields: Set["name"],
        int_fields: Set["age","height"],
        float_fields: Set["weight"]
    },
    business: {
        string_fields: Set["name","hq"],
        int_fields: Set["year founded","fortune rank"]
    },
    generic: {}
}

_VALID_CSV_TYPENAMES = CSV_FIELDS.keys.map{|key| key.to_s}

def main(csv_filepath, csv_type)
    unless CSV_FIELDS.include? csv_type
        puts "ERROR: Invalid csv type. Must be one of: #{_VALID_CSV_TYPENAMES}"
        exit(1)
    end
    fields = CSV_FIELDS[csv_type]
    puts get_csv_entries(csv_filepath, fields)
end

# Utility methods
def get_csv_entries(csv_filepath, fields=nil)
    file_enumerator = File.foreach(csv_filepath)
    headers = file_enumerator.next.chomp().split(',')
    max_field_idx = headers.length - 1

    all_fields = nil
    valid_field_indices = []
    if fields.nil?
        fields[:int_fields] = Set.new
        fields[:float_fields] = Set.new
        fields[:string_fields] = headers
        all_fields = fields[:string_fields]
        valid_field_indices = 0..max_field_idx
    else
        unless fields.include?(:string_fields)
            fields[:string_fields] = Set.new
        end
        unless fields.include?(:int_fields)
            fields[:int_fields] = Set.new
        end
        unless fields.include?(:float_fields)
            fields[:float_fields] = Set.new
        end
        all_fields = fields[:string_fields] + fields[:int_fields] + fields[:float_fields]
        # Setting the indices with valid field names so that the other fields are skipped 
        #  during processing, improving time complexity linearly
        for i in 0..max_field_idx
            if all_fields.include? headers[i]
                valid_field_indices.append(i)
            end
        end
    end

    entries = []
    loop do
        values = file_enumerator.next.chomp().split(',')
        entry = {}
        valid_field_indices.each do |i|
            if fields[:int_fields].include?(headers[i])
                entry[headers[i]] = values[i].to_i
            elsif fields[:float_fields].include?(headers[i])
                entry[headers[i]] = values[i].to_f
            else
                entry[headers[i]] = values[i]
            end
        end
        entries.append(entry)
    end
    return entries
end

# RUNNING MAIN
if __FILE__ == $0
    if ARGV.length != 2
        puts "Usage: csv_reader.rb CSV_TYPE CSV_FILEPATH\n\tCSV_TYPE The type of CSV to process.  Valid values: #{_VALID_CSV_TYPENAMES}\n\tCSV_FILEPATH The file path of the CSV to process"
        exit(1)
    end
    csv_type = ARGV[0]
    csv_filepath = ARGV[1]
    main(csv_filepath, csv_type.to_sym)
end