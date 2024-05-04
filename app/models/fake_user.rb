# frozen_string_literal: true

class FakeUser
  include ActiveModel::API

  attr_accessor :index, :name, :job, :company, :location

  # LOCATIONS = %w[[France 'fr'] []Georgia].freeze
  LOCATIONS = [%w[France fr], %w[USA en-US], %w[Bulgaria bg]].freeze

  def initialize(index, name, job, company, location)
    @index = index + 1
    @name = name
    @job = job
    @company = company
    @location = location
  end

  def to_csv
    [@index, @name, @job, @company, @location]
  end
end
