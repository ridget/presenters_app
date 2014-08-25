require 'spec_helper'

describe User do

  common_lets

  # define the user, user_other,... instances in
  # spec/support/common_lets.rb
  it { expect(user).to be_valid }
#  it { expect(user_other).to be_valid }

end
