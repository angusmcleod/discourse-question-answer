# frozen_string_literal: true

module Jobs
  class QaUpdateTopicsPostOrder < ::Jobs::Onceoff
    def execute_onceoff(_args)
      Topic.find_each do |topic|
        if topic.qa_enabled
          Topic.qa_update_vote_order(topic.id)
        else
          topic.posts.each do |post|
            post.update_columns(sort_order: post.post_number)
          end
        end
      end
    end
  end
end
