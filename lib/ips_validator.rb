require "ips_validator/version"
require 'ips_validator/loader'
require 'ips_validator/validator'

module IpsValidator
  class Runner
    class << self  
      def run(args)
        num_valid = 0
        num_invalid = 0
        num_error = 0
        total = 0
        puts "\n"
        statuses = []
        types = []
        categories = []
        layers = []
        xip = args[0].to_sym
        file_names = args[1..-1]
        
        file_names.map do |file_name|
          attributes = Loader.load(file_name)
          total+=1
          begin 
            validator = ValidatorFactory.make(xip)
            v = validator.new(attributes)
            if v.valid?
              num_valid+=1      
            else
              num_invalid+=1
              puts "#{file_name} is NOT valid:\t #{v.errors.messages}"
            end
            statuses.push v.status
          rescue => e
            puts "Warning: #{file_name} \t #{e}"
            num_error+=1
          end
        end
              
        puts "\n\ntotal:#{total}, valid:#{num_valid}, invalid:#{num_invalid}, errors:#{num_error}"
        puts "\tstatuses: #{aggregate(statuses)}"
        raise "#{num_invalid} invalid entities" unless num_invalid == 0
      end

      private

      def aggregate(array)
        array.group_by{|k,v| k}.map{|k,v| [k,v.length]}
      end  
    end
  end
end
