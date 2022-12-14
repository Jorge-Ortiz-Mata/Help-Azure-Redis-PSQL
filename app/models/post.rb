class Post < ApplicationRecord

  has_rich_text :description

  after_create_commit on: :create do
    broadcast_append_to(
      @posts_channel,
      partial: 'posts/post',
      locals: { post: self },
      target: 'posts'
    )
  end
end
