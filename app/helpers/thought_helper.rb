# frozen_string_literal: true

module ThoughtHelper
  def thought_html(thought)
    thought.text.gsub("\n", '<br />')
  end
end
