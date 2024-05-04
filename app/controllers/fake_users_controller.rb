# frozen_string_literal: true

require 'faker'
require 'csv'

class FakeUsersController < ApplicationController
  def index
    @selected_location = params['location'] || 'en-US'

    @seed = params['seed'].to_i || 2_342_223
    Faker::Config.random = Random.new(@seed)

    @users = generate_fake_user(@seed, @selected_location)

    send_data generate_csv(@users), filename: 'fake_users.csv' if params['export'] == 'csv'

    @pagy, @users = pagy_array(@users, items: 20)
  end

  private

  def generate_fake_user(seed, locale)
    Faker::Config.locale = locale
    Faker::Config.random = Random.new(seed)

    users = []
    1000.times do |i|
      users << FakeUser.new(i, Faker::Name.name, Faker::Job.title, Faker::Company.name,
                            Faker::Address.full_address)
    end
    users
  end

  def generate_csv(users)
    CSV.generate do |csv|
      csv << ['No.', 'Name', 'Job', 'Company', 'Address']
      users.each do |user|
        csv << user.to_csv
      end
    end
  end
end
