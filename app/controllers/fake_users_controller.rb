# frozen_string_literal: true

require 'faker'
require 'csv'

class FakeUsersController < ApplicationController
  def index
    @selected_location = params['location'] || 'en-US'

    @seed = params['seed'].to_i || 2_342_223

    @error_value = params['error'].to_f || 0

    @users = generate_fake_users(@seed, @selected_location, @error_value)

    send_data generate_csv(@users), filename: 'fake_users.csv' if params['export'] == 'csv'

    @pagy, @users = pagy_array(@users, items: 20)
  end

  private

  def generate_fake_users(seed, locale, error)
    Faker::Config.locale = locale
    Faker::Config.random = Random.new(seed)

    users = []
    1000.times do |i|
      user = [Faker::Name.name_with_middle, Faker::PhoneNumber.phone_number, Faker::Address.full_address]
      user = emulate_error(user, error)
      users << FakeUser.new(i, Faker::IdNumber.valid, user[0], user[1], user[2])
    end
    users
  end

  def generate_csv(users)
    CSV.generate do |csv|
      csv << ['No.', 'id', 'Name', 'Phone', 'Address']
      users.each do |user|
        csv << user.to_csv
      end
    end
  end

  def emulate_error(array, error)
    error += 1 if rand < error % 1
    error.to_i.times do
      i = rand(array.length)
      array[i] = error_method.call(array[i]) if array[i].empty?
    end
    array
  end

  def error_method # rubocop:disable Metrics/AbcSize
    delete_char = ->(str) { str.delete(str.chars.sample) }
    insert_char = ->(str) { str.insert(rand(str.length), ('a'..'z').to_a.sample) }
    swap_char = lambda do |str|
      i = str[rand(str.length)]
      j = str[rand(str.length)]
      str[i], str[j] = str[j], str[i]
      str
    end

    [delete_char, insert_char, swap_char].sample
  end
end
