# == Schema Information
#
# Table name: diary_videos
#
#  id            :bigint           not null, primary key
#  thumbnail_url :string(255)      not null
#  video_uid     :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  diary_id      :bigint
#
# Indexes
#
#  index_diary_videos_on_diary_id  (diary_id)
#
# Foreign Keys
#
#  fk_rails_...  (diary_id => diaries.id)
#
require 'rails_helper'

RSpec.describe DiaryVideo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
