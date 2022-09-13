class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search(page)
    relation = User.distinct
    relation.name_contain(name)
            .page(page)
            .without_count
  end
end
