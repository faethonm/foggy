class List
  class ResponseMaker
    attr_reader :query

    STATUSES = {
      found: 'FOUND',
      recommended: 'RECOMMENDED',
      found_friend: 'FOUND_FRIEND',
      created: 'CREATED',
      not_found: 'NOT_FOUND',
      show_found: 'SHOW_FOUND'
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
      'james'
    end

    def found_response
      {
        text: Response.list_found_text(run_query),
        status: STATUSES[:found],
        id: run_query.first.id
      }
    end

    def recommended_response
      {
        text: Response.recommended_text(query, recommend_for_query),
        status: STATUSES[:recommended],
        id: recommend_for_query.first.id
      }
    end

    def none_response
      {
        text: Response.none_text,
        status: STATUSES[:not_found]
      }
    end

    def show_response(list)
      {
        text: Response.show_text(list),
        status: STATUSES[:show_found],
        id: list.id
      }
    end
  end
end
