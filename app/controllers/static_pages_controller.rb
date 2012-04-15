class StaticPagesController < ApplicationController
  def help
  end

  def about
  end

  def contact
  end
  
  def home
    @latest_postings = Position.find(:all, limit: 6, order: :created_at)
    @featured_users = User.find(:all, limit: 5, order: :updated_at)
  end
end
