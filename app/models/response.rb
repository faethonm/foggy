module Response
  extend self

  def list_found_text(run_query)
    ''.tap do |response|
      response << 'I found a list for you. '
      response << "Here are the items: #{run_query.first.list_items.map(&:name).join(', ')}"
    end
  end

  def recommended_text(query, recommend_for_query)
    ''.tap do |response|
      response << "You don't have a list for #{query}, "
      response << "but I found one from #{recommend_for_query.first.user.try(&:name).try(&:capitalize)}. "
      response << 'Do you want to see what they have?'
    end
  end

  def none_text
    'I couldn\'t find any lists for you. Do you want to create a new one?'
  end

  def show_text(list)
    ''.tap do |response|
      response << "The list for #{list.user.try(:name).try(:capitalize)} contains "
      response << list.list_items.map(&:name).join(", ")
      response << '. Would you like a copy of this list?'
    end
  end
end
