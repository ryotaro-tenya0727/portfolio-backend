# == Schema Information
#
# Table name: diary_images
#
#  id              :bigint           not null, primary key
#  diary_image_url :string(255)
#  uuid            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  diary_id        :bigint           not null
#
# Indexes
#
#  index_diary_images_on_diary_id  (diary_id)
#  index_diary_images_on_uuid      (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (diary_id => diaries.id)
#
FactoryBot.define do
  factory :diary_image do
  end
end
