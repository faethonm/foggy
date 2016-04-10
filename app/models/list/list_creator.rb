class List
  class ListCreator
    attr_reader :list

    def initialize(list)
      @list = list
    end

    def run
      user = User.find_by(email: default_email)

      new_list = user.lists.create!(name: list.name)
      create_list_items(new_list)

      creator_response(new_list)
    end

    private
    def default_email
      "james@foggy.io"
    end

    def create_list_items(new_list)
      list.list_items.each do |old_list_item|
        new_list.list_items.create!(name: old_list_item.name)
      end
    end

    def creator_response(new_list)
      {
        text: text_response(new_list),
        status: "CREATED",
        id: new_list.id
      }
    end

    def text_response(new_list)
      "".tap do |response|
        response << "I've created a list for #{new_list.name}. "
        response << "The list contains #{new_list.list_items.map(&:name)}"
      end
    end
  end
end
