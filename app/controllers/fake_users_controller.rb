# frozen_string_literal: true

require 'faker'

class FakeUser
  include ActiveModel::API

  attr_accessor :name, :job, :company, :location

  def initialize(name, job, company, location)
    @name = name
    @job = job
    @company = company
    @location = location
  end
end

class FakeUsersController < ApplicationController
  def index
    @users = []
    100.times do
      @users << FakeUser.new(Faker::Name.name, Faker::Job.title, Faker::Company.name,
                             Faker::Address.full_address)
    end
    @pagy, @users = pagy_array(@users, items: 10)
  end
end
