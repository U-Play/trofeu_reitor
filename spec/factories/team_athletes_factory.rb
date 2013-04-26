# require "spec_helper"
# require_relative '../spec_helper'

FactoryGirl.define do

  factory :team_athlete do
    association :team
    association :athlete

    # after_build do |t|
    #   # ta = TeamAthlete.find(t.id)
    #   TeamAthlete.stub(:send_email)
    #   # t.stub(:send_email)
    # end
  end
end

