# frozen_string_literal: true

class FakeUser
  include ActiveModel::API

  attr_accessor :index, :id, :name, :phone, :location

  LOCATIONS = [%w[France fr], %w[USA en-US], %w[Bulgaria bg]].freeze

  def initialize(index, id, name, phone, location)
    @index = index + 1
    @id = id
    @name = name
    @phone = phone
    @location = location
  end

  def to_csv
    [@index, @id, @name, @phone, @location]
  end
end
