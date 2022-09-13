# == Schema Information
#
# Table name: diaries
#
#  id                       :bigint           not null, primary key
#  event_date               :date
#  event_name               :string(255)
#  event_polaroid_count     :integer
#  event_venue              :string(255)
#  impressive_memory        :string(255)
#  impressive_memory_detail :text(65535)
#  status                   :integer          default("published"), not null
#  uuid                     :string(255)      not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  recommended_member_id    :bigint           not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_diaries_on_created_at                            (created_at)
#  index_diaries_on_recommended_member_id                 (recommended_member_id)
#  index_diaries_on_recommended_member_id_and_created_at  (recommended_member_id,created_at)
#  index_diaries_on_user_id                               (user_id)
#  index_diaries_on_uuid                                  (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (recommended_member_id => recommended_members.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Diary, type: :model do
end
