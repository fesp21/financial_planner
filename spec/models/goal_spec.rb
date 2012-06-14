# == Schema Information
#
# Table name: goals
#
#  id         :integer         not null, primary key
#  name       :string(50)      not null
#  cost       :integer         not null
#  rank       :integer         not null
#  purchased  :boolean         not null
#  user_id    :integer         not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Goal do
  pending "add some examples to (or delete) #{__FILE__}"
end
