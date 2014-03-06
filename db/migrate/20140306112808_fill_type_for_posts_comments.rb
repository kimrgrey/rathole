class FillTypeForPostsComments < ActiveRecord::Migration
  def change
    Comments::Comment.update_all type: 'Comments::PostComment'
  end
end
