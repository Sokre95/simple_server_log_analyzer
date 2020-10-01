module ServerLogAnalyzer
  class LineParser

    # capture group name must be between < and > or ' and ' signs
    NAMED_GROUP_REGEX = /(?:<|')(?<group_name>\w+)(?:>|')/

    def initialize(line_matcher)
      @line_matcher = line_matcher
      @capture_groups_names = line_matcher.to_s
        .split('?') # named capture group starts with ? sign
        .map{ |part| NAMED_GROUP_REGEX.match(part) } 
        .compact
        .map{ |group_name| group_name[:group_name].to_sym }
    end

    def parse(line)
      match_data = @line_matcher.match(line)
      {}.tap do |hash|
        @capture_groups_names.each{ |name| hash[name] = match_data[name]}
      end
    end
  end
end