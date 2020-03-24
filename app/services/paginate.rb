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
    connect = ActiveRecord::Base.connection();
    sanitized_query = ActiveRecord::Base.send(:sanitize_sql_array, query)
    connect.execute(sanitized_query)
  end

  def offset(page, per_page)
    (page - 1) * per_page
  end

end