require_relative '../views/orders_view'

class OrdersController

  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new

  end

  def add
    # Perguntar para o manager qual é o meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @view.ask_index
    meal = meals[index]

    # Perguntar para o manager qual é o customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @view.ask_index
    customer = customers[index]

    # Perguntar para o manager qual é o employee do tipo rider
    riders = @employee_repository.all_riders
    @view.display_riders(riders)
    index = @view.ask_index
    employee = riders[index]

    # Criar um order
    order = Order.new(meal:, customer:, employee:)

    # Adicionar o order no repository
    @order_repository.create(order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.display(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee == employee }
    @view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee == employee }
    @view.display(orders)
    index = @view.ask_index
    order = orders[index]
    @order_repository.mark_as_delivered(order)

  end
end
