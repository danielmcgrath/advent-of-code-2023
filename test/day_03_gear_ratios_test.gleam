import day_03_gear_ratios
import gleeunit/should

pub fn parse_grid_test() {
  day_03_gear_ratios.parse_grid(["123..45.", "..*...89"])
  |> should.equal([
    ["123", "123", "123", ".", ".", "45", "45", "."],
    [".", ".", "*", ".", ".", ".", "89", "89"],
  ])
}

pub fn get_part_numbers_test() {
  let grid = [
    ["123", "123", "123", ".", ".", "45", "45", "."],
    [".", ".", "*", ".", ".", ".", "89", "89"],
  ]

  day_03_gear_ratios.get_part_numbers(1, 2, grid)
  |> should.equal([123])

  day_03_gear_ratios.get_part_numbers(0, 0, grid)
  |> should.equal([])

  day_03_gear_ratios.get_part_numbers(0, 1, grid)
  |> should.equal([])
}

pub fn get_check_coordinates_test() {
  day_03_gear_ratios.get_check_coordinates(1, 2)
  |> should.equal([
    [0, 1],
    [0, 2],
    [0, 3],
    [1, 1],
    [1, 3],
    [2, 1],
    [2, 2],
    [2, 3],
  ])
}

pub fn get_gear_numbers_test() {
  let grid = [
    ["123", "123", "123", ".", ".", "45", "45", "."],
    [".", ".", "*", ".", ".", ".", "89", "89"],
    [".", ".", "32", "32", "*", ".", ".", "."],
  ]

  day_03_gear_ratios.get_gear_numbers(1, 2, grid)
  |> should.equal([123, 32])

  day_03_gear_ratios.get_gear_numbers(0, 0, grid)
  |> should.equal([])

  day_03_gear_ratios.get_gear_numbers(0, 1, grid)
  |> should.equal([])

  day_03_gear_ratios.get_gear_numbers(2, 4, grid)
  |> should.equal([])
}
