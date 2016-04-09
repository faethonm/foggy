class List
  class ResponseMaker
    attr_reader :query

    def initialize(query)
      @query = query
    end

    def run
      if run_query.any?
        "I found a list for you. Here are the items: #{run_query.first.list_items.map(&:name).join(', ')}"
      elsif recommend_for_query.any?
        "You don't have a list for #{query}, but I found some from #{recommend_for_query.map(&:user).map(&:name).join(' and ')}. Do you want to see what they have?"
      else
        "I couldn't find a list for you or recommend you something. Do you want to create one?"
      end
    end

    private
    def run_query
      ::List.for_user(current_user).search(query)
    end

    def recommend_for_query
      ::List.not_for_user(current_user).search(query)
    end

    def current_user
      "james@foggy.io"
    end
  end
end
