import gleam/int
import gleam/io
import gleam/list
import gleam/regex
import gleam/string
import util

pub fn phase_one(filename: String) -> Int {
  let grid =
    util.read_input_lines(filename)
    |> parse_grid

  grid
  |> list.index_fold(
    0,
    fn(total, row, row_idx) {
      total + list.index_fold(
        row,
        0,
        fn(row_total, _, col_idx) {
          row_total + int.sum(get_part_numbers(row_idx, col_idx, grid))
        },
      )
    },
  )
}

pub fn phase_two(filename: String) -> Int {
  let grid =
    util.read_input_lines(filename)
    |> parse_grid

  grid
  |> list.index_fold(
    0,
    fn(total, row, row_idx) {
      total + list.index_fold(
        row,
        0,
        fn(row_total, _, col_idx) {
          let n = get_gear_numbers(row_idx, col_idx, grid)
          case n {
            [] -> row_total
            _ -> row_total + int.product(n)
          }
        },
      )
    },
  )
}

pub fn get_check_coordinates(row: Int, col: Int) -> List(List(Int)) {
  [
    [row - 1, col - 1],
    [row - 1, col],
    [row - 1, col + 1],
    [row, col - 1],
    [row, col + 1],
    [row + 1, col - 1],
    [row + 1, col],
    [row + 1, col + 1],
  ]
}

pub fn get_gear_numbers(
  row: Int,
  col: Int,
  grid: List(List(String)),
) -> List(Int) {
  let assert Ok(r) = list.at(grid, row)
  let assert Ok(item) = list.at(r, col)
  let res = case item {
    "*" -> {
      get_check_coordinates(row, col)
      |> list.map(fn(coords) {
        let [y, x] = coords
        deep_num(grid, y, x)
      })
      |> list.unique
      |> list.filter(fn(n) { n > 0 })
    }
    _ -> []
  }

  case list.length(res) {
    0 | 1 -> []
    _ -> {
      res
    }
  }
}

fn deep_num(l: List(List(String)), y: Int, x: Int) -> Int {
  case list.at(l, y) {
    Ok(r) -> {
      case list.at(r, x) {
        Ok(item) -> {
          case int.parse(item) {
            Ok(n) -> n
            _ -> 0
          }
        }
        _ -> 0
      }
    }
    _ -> 0
  }
}

pub fn get_part_numbers(
  row: Int,
  col: Int,
  grid: List(List(String)),
) -> List(Int) {
  let assert Ok(r) = list.at(grid, row)
  let assert Ok(item) = list.at(r, col)
  case item {
    "#" | "^" | "$" | "*" | "+" | "/" | "@" | "%" | "&" | "=" | "-" -> {
      get_check_coordinates(row, col)
      |> list.map(fn(coords) {
        let [y, x] = coords
        deep_num(grid, y, x)
      })
      |> list.unique
      |> list.filter(fn(n) { n > 0 })
    }
    _ -> []
  }
}

pub fn parse_grid(input: List(String)) -> List(List(String)) {
  let assert Ok(re) = regex.from_string("(\\d+|.)")
  input
  |> list.map(fn(line) {
    regex.scan(with: re, content: line)
    |> list.fold(
      [],
      fn(l, m) {
        list.append(l, list.repeat(m.content, string.length(m.content)))
      },
    )
  })
}

pub fn main() {
  io.println("Phase 1 (test): " <> int.to_string(phase_one("03.test.txt")))
  io.println("Phase 1 " <> int.to_string(phase_one("03.txt")))
  io.println("Phase 2 (test): " <> int.to_string(phase_two("03.test.txt")))
  io.println("Phase 2: " <> int.to_string(phase_two("03.txt")))
}
