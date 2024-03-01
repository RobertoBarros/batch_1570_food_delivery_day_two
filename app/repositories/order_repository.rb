class OrderRepository
  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @csv_file = csv_file

    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository

    @orders = []
    load_csv if File.exist?(@csv_file)
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def all
    @orders
  end

  def find(id)
    @orders.select { |order| order.id == id }.first
  end

  def undelivered_orders
    # @orders.reject { |order| order.delivered? }
    @orders.reject(&:delivered?)
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      meal = @meal_repository.find(row[:meal_id].to_i)
      customer = @customer_repository.find(row[:customer_id].to_i)
      employee = @employee_repository.find(row[:employee_id].to_i)

      order = Order.new(id: row[:id].to_i, delivered: row[:delivered] == 'true', meal:, customer:, employee:)
      @orders << order
    end

  end

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row, header_converters: :symbol) do |file|
      file << %i[id delivered meal_id customer_id employee_id] # CSV HEADER

      @orders.each do |order|
        file << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id
      ]
      end
    end
  end
end
