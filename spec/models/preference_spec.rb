require 'spec_helper'

describe Preference do

  common_lets

  # define the preference, preference_other,... instances in
  # spec/support/common_lets.rb
  it { expect(preference).to be_valid }
#  it { expect(preference_other).to be_valid }

end
