defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_orbital_period 31_557_600
  @planet_to_period %{
    earth: 1,
    mercury: 0.2408467,
    venus: 0.61519726,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  }

  def age_on(:earth, seconds) do
    calculate_age_on_planet(seconds, @planet_to_period.earth)
  end

  def age_on(:mercury, seconds) do
    calculate_age_on_planet(seconds, @planet_to_period.mercury)
  end

  def age_on(:venus, seconds) do
    calculate_age_on_planet(seconds, @planet_to_period.venus)
  end

  def age_on(:mars, seconds) do
    calculate_age_on_planet(seconds, @planet_to_period.mars)
  end

  def age_on(:jupiter, seconds) do
    calculate_age_on_planet(seconds, @planet_to_period.jupiter)
  end

  def age_on(:saturn, seconds) do
    calculate_age_on_planet(seconds, @planet_to_period.saturn)
  end

  def age_on(:uranus, seconds) do
    calculate_age_on_planet(seconds, @planet_to_period.uranus)
  end

  def age_on(:neptune, seconds) do
    calculate_age_on_planet(seconds, @planet_to_period.neptune)
  end

  defp calculate_age_on_planet(seconds, relative_period) do
    seconds / (relative_period * @earth_orbital_period)
  end
end
