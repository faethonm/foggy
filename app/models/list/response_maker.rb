class List
  class ResponseMaker
    attr_reader :query

    STATUSES = {
      found: "FOUND",
      recommended: "RECOMMENDED",
      found_friend: "FOUND_FRIEND",
      created: "CREATED",
      not_found: "NOT_FOUND",
      show_found: "SHOW_FOUND"
    }.freeze

    def initialize(query)
      @query = query
    end

    def run
      if run_query.any?
        found_response
      elsif recommend_for_query.any?
        recommended_response
      else
        none_response
      end
    end

    def show(list)
      show_response(list)
    end

    private
    def run_query
      List.for_user(default_user).search(query)
    end

    def recommend_for_query
      List.not_for_user(default_user).search(query)
    end

    def default_user
      "james"
    end

    def recommended_response
      {
        text: recommended_text,
        status: STATUSES[:recommended],
        id: recommend_for_query.first.id
      }
    end

    def none_response
      {
        text: "I couldn't find any lists for you. Do you want to create a new one?",
        status: STATUSES[:not_found]
      }
    end

    def recommended_text
      "".tap do |response|
        response << "You don't have a list for #{query}, "
        response << "but I found one from #{recommend_for_query.first.user.try(&:name).try(&:capitalize)}. "
        response << "Do you want to see what they have?"
      end
    end

    def found_response
      {
        text: found_text,
        status: STATUSES[:found],
        id: run_query.first.id
      }
    end

    def found_text
      "".tap do |response|
        response << "I found a list for you. "
        response << "Here are the items: #{run_query.first.list_items.map(&:name).join(', ')}"
      end
    end

    def show_response(list)
      {
        text: show_text(list),
        status: STATUSES[:show_found]
      }
    end

    def show_text(list)
      "".tap do |response|
        response << "The list for #{list.user.try(:name).try(:capitalize)} contains "
        response << list.list_items.map(&:name).join(", ")
      end
    end
  end
end
