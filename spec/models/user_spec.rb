require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures username presence' do
      user = User.new(email: "sample@example.com", password: "sample").save
      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = User.new(username: "sample", email: "sample@example.com").save
      expect(user).to eq(false)
    end

    it 'ensures password uniqueness' do
      User.new(username: "sample", email: "sample@example.com").save
      user = User.new(username: "sample", email: "sample@example.com").save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(username: "sample", email: "sample@example.com", password: "sample").save

      expect(user).to eq(true)
    end
  end
  context 'scope tests' do
    let(:params) { {username: "sample", password: "sample"} }
    before(:each) do
      User.new(username: "one", password: "sample", status: "active").save
      User.new(username: "two", password: "sample", status: "active").save
      User.new(username: "three", password: "sample", status: "active").save
      User.new(username: "four", password: "sample", status: "inactive").save
      User.new(username: "five", password: "sample", status: "inactive").save
      User.new(username: "six", password: "sample", status: "suspended").save
    end

    it 'should return active users' do
      expect(User.active_users.size).to eq(3)
    end

    it 'should return inactive users' do
      expect(User.inactive_users.size).to eq(2)
    end

    it 'should return suspended users' do
      expect(User.suspended_users.size).to eq(1)
    end
  end

  context 'changes status' do
    before(:each) do
      @users = []
      @users << User.new(username: "active", password: "sample", status: "active")
      @users << User.new(username: "inactive", password: "sample", status: "inactive")
      @users << User.new(username: "suspended", password: "sample", status: "suspended")
    end

    it 'should activate user' do
      @users.each do |user|
        user.activate
      end

      @users.each do |user|
        expect(user.status).to eq("active")
      end
    end

    it 'should deactivate user' do
      @users.each do |user|
        user.deactivate
      end

      @users.each do |user|
        expect(user.status).to eq("inactive")
      end
    end

    it 'should suspend user' do
      @users.each do |user|
        user.suspend
      end

      @users.each do |user|
        expect(user.status).to eq("suspended")
      end
    end


  end
end
