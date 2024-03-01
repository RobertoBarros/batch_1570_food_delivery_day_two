require_relative '../views/meals_view'

class MealsController

  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def add
    # Perguntar qual o nome do meal
    name = @view.ask_name

    # Perguntar o preço do meal
    price = @view.ask_price

    # Instanciar um novo meal
    meal = Meal.new(name: name, price: price)

    # Adicionar o meal ao repository
    @meal_repository.create(meal)
  end

  def list
    # Recuperar todos os meals do repository
    meals = @meal_repository.all

    # Mandar a view exibir os meals
    @view.display(meals)
  end
end
