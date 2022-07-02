# == Schema Information
#
# Table name: user_relationships
#
#  id          :bigint           not null, primary key
#  uuid        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_user_relationships_on_followed_id                  (followed_id)
#  index_user_relationships_on_follower_id                  (follower_id)
#  index_user_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#  index_user_relationships_on_uuid                         (uuid) UNIQUE
#
require 'rails_helper'

RSpec.describe UserRelationship, type: :model do
end
