class Comment < ActiveRecord::Base
  include Rakismet::Model

  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  attr_accessible :rating, :email, :subtype

  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true
  validates :subtype, presence: true, inclusion: %w(review comment)

  validates_presence_of :rating, if: :review?
  validates :rating, inclusion: (1..5)

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates_presence_of :email, unless: lambda { user.present? }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  belongs_to :commentable, :polymorphic => true

  # NOTE: Comments belong to a user
  belongs_to :user

  rakismet_attrs author: proc { user.username if user.present? },
                 author_email: proc { email_address },
                 content: :body,
                 permalink: proc { commentable.permalink }

  def review?
    self.subtype == 'review'
  end

  def self.build_from(options)
    c = self.new
    c.commentable_id = options[:commentable_id]
    c.commentable_type = options[:commentable_type]
    c.body = options[:body]
    c.title = options[:title]
    c.user_id = options[:user_id] if options[:user_id]
    c.email = options[:email]
    c.subtype = options[:subtype]
    c.rating = options[:rating] if options[:rating]
    c
  end

  def email_address
    user.present? ? user.email : self.email
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
