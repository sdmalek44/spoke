class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(page)
    paginate(page: page, per_page: 30).order('id DESC')
  end
end
