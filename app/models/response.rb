module Response
  extend self

  def list_found_text(run_query)
    ''.tap do |response|
      response << "Here are the items on #{run_query.first.try(:name)}: "
      response << "#{run_query.first.list_items.map(&:name).join(', ')}. "
      if run_query.first.list_items.items_in_basket.any?
        response << "You still need to buy "
        response << run_query.first.list_items.items_in_basket.map(&:name).join(', ')
      end
    end
  end

  def recommended_text(query, recommend_for_query)
    ''.tap do |response|
      response << "You don't have a list for #{query}, "
      response << "but I found one from #{recommend_for_query.first.user.try(&:name).try(&:capitalize)}. "
      response << 'Do you want to view theirs?'
    end
  end

  def none_text(query)
    "I couldn\'t find a #{query} list. Do you want to create one?"
  end

  def show_text(list)
    ''.tap do |response|
      response << "The #{list.name} list for #{list.user.try(:name).try(:capitalize)} contains: "
      response << list.list_items.map(&:name).join(", ")
      response << '. Would you like a copy of this list?'
    end
  end

  def static_text
    'Hello James!'
  end

  def list_create_text(list)
    ''.tap do |response|
      response << "I've created the #{list.name} list. To add an item say: add item to #{list.name} list. "
      response << "For example: Add shoes to #{list.name}."
    end
  end

  def list_item_create_text(list_item)
    "I've added #{list_item.name} to #{list_item.list.name}."
  end

  def add_to_basket_text(list_item)
    "I've added #{list_item.name} from your list for #{list_item.list.name} to the basket!"
  end
end
