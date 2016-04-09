class List
  class ResponseMaker
    attr_reader :query, :user

    STATUSES = {
      found: "FOUND",
      recommended: "RECOMMENDED",
      found_friend: "FOUND_FRIEND",
      created: "CREATED",
      not_found: "NOT_FOUND"
    }.freeze

    def initialize(query, user)
      @query = query
      @user  = user || default_user
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

    private
    def run_query
      List.for_user(user).search(query)
    end

    def recommend_for_query
      List.not_for_user(user).search(query)
    end

    def default_user
      "james@foggy.io"
    end

    def recommended_response
      {
        text: recommended_text,
        status: STATUSES[:recommended]
      }
    end

    def none_response
      {
        text: "I couldn't find a list for you or recommend you something. Do you want to create one?",
        status: STATUSES[:not_found]
      }
    end

    def recommended_text
      "".tap do |response|
        response << "You don't have a list for #{query}, "
        response << "but I found some from #{recommend_for_query.map(&:user).first.try(&:name)}."
        response << "Do you want to see what they have?"
      end
    end

    def found_response
      {
        text: found_text,
        status: STATUSES[:found]
      }
    end

    def found_text
      "".tap do |response|
        response << "I found a list for you. "
        response << "Here are the items: #{run_query.first.list_items.map(&:name).join(', ')}"
      end
    end
  end
end
