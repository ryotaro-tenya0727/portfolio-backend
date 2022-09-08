class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search
    relation = User.distinct
    relation.name_contain(name)
  end
end
