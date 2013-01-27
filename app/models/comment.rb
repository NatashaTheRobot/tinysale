class Comment < ActiveRecord::Base
  include Rakismet::Model

  belongs_to :commentable, :polymorphic => true

  # NOTE: Comments belong to a user
  belongs_to :user
  belongs_to :lead

  accepts_nested_attributes_for :lead

  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  attr_accessible :rating, :subtype

  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true
  validates :subtype, presence: true, inclusion: %w(review comment)

  #validates_presence_of :rating, if: :review?
  validates :rating, presence: true, inclusion: (1..5), if: :review?

  validates :lead, presence: true, unless: lambda { user.present? }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  rakismet_attrs author: proc { user.username if user.present? },
                 author_email: proc { email_address },
                 content: :body,
                 permalink: proc { commentable.permalink }

  def review?
    self.subtype == 'review'
  end

  def self.build_from(params, user_id = nil)
    comment = params[:comment]
    c = self.new
    c.commentable_id = comment[:commentable_id]
    c.commentable_type = comment[:commentable_type]
    c.body = comment[:body]
    c.title = comment[:title]
    c.user_id = user_id
    if user_id.nil?
      email = comment[:lead][:email]
      c.lead = Lead.find_by_email(email) || Lead.build_from(email)
    end
    c.subtype = comment[:subtype]
    c.rating = self.rating_score(params[:score])
    c
  end

  def self.rating_score(score)
    score.present? ? score.to_i : nil
  end

  def email_address
    user.present? ? user.email : self.lead.email
  end

  #helper method to check if a comment has children
  def has_children?
    self.children.size > 0
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end
end
