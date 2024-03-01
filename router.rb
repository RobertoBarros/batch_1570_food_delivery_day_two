class Router

  def initialize(meals_controller, customer_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customer_controller = customer_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
  end

  def run
    @employee = @sessions_controller.login

    loop do
      if @employee.manager?
        display_options_manager
        option = gets.chomp.to_i
        puts `clear`
        dispatch_manager(option)
      else
        display_options_rider
        option = gets.chomp.to_i
        puts `clear`
        dispatch_rider(option)
      end
    end
  end

  private

  def display_options_manager
    puts '-' * 40
    puts "1. Create Meal"
    puts "2. List Meals"
    puts '-' * 40
    puts "3. Create Customer"
    puts "4. List Customers"
    puts '-' * 40
    puts "5. Create Order"
    puts "6. List Undelivered Orders"
    puts '-' * 40

    puts "Choose an option:"
  end

  def dispatch_manager(option)
    case option
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customer_controller.add
    when 4 then @customer_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    end
  end

  def display_options_rider
    puts '-' * 40
    puts "1. List My Orders"
    puts "2. Mark Order as Delivered"
    puts '-' * 40

    puts "Choose an option:"
  end

  def dispatch_rider(option)
    case option
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    end
  end

end
