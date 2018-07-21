class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(term, page)
    if term
      where('name LIKE ?', "%#{term}%").paginate(page: page, per_page: 30).order('id DESC')
    else
      paginate(page: page, per_page: 30).order('id DESC')
    end
  end
end
