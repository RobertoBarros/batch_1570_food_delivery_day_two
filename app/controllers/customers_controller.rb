require_relative '../views/customers_view'

class CustomersController

  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def add
    # Perguntar qual o nome do customer
    name = @view.ask_name

    # Perguntar o endereço do customer
    address = @view.ask_address

    # Instanciar um novo customer
    customer = Customer.new(name: name, address: address)

    # Adicionar o customer ao repository
    @customer_repository.create(customer)
  end

  def list
    # Recuperar todos os customers do repository
    customers = @customer_repository.all

    # Mandar a view exibir os customers
    @view.display(customers)
  end
end
