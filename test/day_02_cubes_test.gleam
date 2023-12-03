import gleeunit/should
import day_02_cubes

pub fn is_possible_test() {
  day_02_cubes.is_possible(
    "Game 1: 4 blue, 7 red, 5 green; 3 blue, 4 red, 16 green; 3 red, 11 green",
    100,
    100,
    100,
  )
  |> should.equal(True)

  day_02_cubes.is_possible(
    "Game 1: 4 blue, 7 red, 5 green; 3 blue, 4 red, 16 green; 3 red, 11 green",
    7,
    16,
    4,
  )
  |> should.equal(True)

  day_02_cubes.is_possible(
    "Game 1: 4 blue, 7 red, 5 green; 3 blue, 4 red, 16 green; 3 red, 11 green",
    7,
    15,
    4,
  )
  |> should.equal(False)

  day_02_cubes.is_possible(
    "Game 1: 4 blue, 7 red, 5 green; 3 blue, 4 red, 16 green; 3 red, 11 green",
    1,
    1,
    1,
  )
  |> should.equal(False)
}

pub fn get_game_id_test() {
  day_02_cubes.get_game_id(
    "Game 14: 4 blue, 7 red, 5 green; 3 blue, 4 red, 16 green; 3 red, 11 green",
  )
  |> should.equal(14)
}

pub fn min_product_test() {
  day_02_cubes.min_product(
    "Game 1: 4 blue, 7 red, 5 green; 3 blue, 4 red, 16 green; 3 red, 11 green",
  )
  |> should.equal(7 * 16 * 4)
}
