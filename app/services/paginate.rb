class Paginate

  def initialize(page, per, sort_attr, order)
    @page = page
    @per = per
    @sort_attr = sort_attr
    @order = order
  end

  def perform
    paginate_projects
  end

  private

  def paginate_projects
    query = "SELECT * FROM projects ORDER BY #{@sort_attr} #{@order} LIMIT #{@per} OFFSET #{offset(@page, @per)}"
    sanitized_query = ActiveRecord::Base.sanitize_sql(query)
    ActiveRecord::Base.connection.execute(sanitized_query)
  end

  def offset(page, per_page)
    (page - 1) * per_page
  end

end