class AddNameToUser < ActiveRecord::Migration
  def up
    add_column :users, :name, :string

    %w[
      Faethon
      James
      Catalin
    ].each do |name|
      email = "#{name.downcase}@foggy.io"
      unless user = User.find_by(email: email)
        user = User.create!(
          email: email,
          password: "password",
          name: name
        )
      end
    end
  end

  def down
    remove_column :users, :name
  end
end
