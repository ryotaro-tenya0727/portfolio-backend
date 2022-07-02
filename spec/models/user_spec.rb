# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  me_introduction :text(65535)
#  name            :string(255)      not null
#  role            :integer          default("general"), not null
#  sub             :string(255)      not null
#  user_image      :text(65535)
#  uuid            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_sub   (sub) UNIQUE
#  index_users_on_uuid  (uuid) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
end
