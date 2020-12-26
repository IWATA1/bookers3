class Book < ApplicationRecord
    belongs_to :user
     validates :title, presence: true
     validates :body, presence: true, uniqueness: true,
                      length: { maximum: 200 }
end
