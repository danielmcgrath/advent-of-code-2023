import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/regex
import util

pub fn is_possible(line: String, red: Int, green: Int, blue: Int) -> Bool {
  let assert Ok(line_parser) = regex.from_string("(\\d+) (\\w+)")
  regex.scan(with: line_parser, content: line)
  |> list.all(fn(x) {
    case x.submatches {
      [option.Some(v), option.Some("red")] -> red >= util.easy_int(v)
      [option.Some(v), option.Some("green")] -> green >= util.easy_int(v)
      [option.Some(v), option.Some("blue")] -> blue >= util.easy_int(v)
      _ -> False
    }
  })
}

pub fn get_game_id(line: String) -> Int {
  let assert Ok(line_parser) = regex.from_string("Game (\\d+):")
  let assert Ok(match) =
    regex.scan(with: line_parser, content: line)
    |> list.first
  let assert Ok(option.Some(id)) =
    match.submatches
    |> list.first
  util.easy_int(id)
}

pub fn check(
  file: String,
  red red: Int,
  green green: Int,
  blue blue: Int,
) -> Int {
  util.read_input_lines(file)
  |> list.fold(
    0,
    fn(acc, line) {
      case is_possible(line, red, green, blue) {
        True -> acc + get_game_id(line)
        False -> acc
      }
    },
  )
}

type Colors {
  Colors(red: Int, green: Int, blue: Int)
}

pub fn min_product(line: String) -> Int {
  let assert Ok(line_parser) = regex.from_string("(\\d+) (\\w+)")
  let mins =
    regex.scan(with: line_parser, content: line)
    |> list.fold(
      Colors(red: 0, green: 0, blue: 0),
      fn(acc, x) {
        case x.submatches {
          [option.Some(v), option.Some("red")] ->
            Colors(..acc, red: int.max(acc.red, util.easy_int(v)))
          [option.Some(v), option.Some("green")] ->
            Colors(..acc, green: int.max(acc.green, util.easy_int(v)))
          [option.Some(v), option.Some("blue")] ->
            Colors(..acc, blue: int.max(acc.blue, util.easy_int(v)))
          _ -> acc
        }
      },
    )
  mins.red * mins.green * mins.blue
}

pub fn check_phase_two(file: String) -> Int {
  util.read_input_lines(file)
  |> list.fold(0, fn(acc, line) { acc + min_product(line) })
}

pub fn main() {
  io.println(
    "Phase 1 (test): " <> int.to_string(check(
      "02.test.txt",
      red: 12,
      green: 13,
      blue: 14,
    )),
  )

  io.println(
    "Phase 1: " <> int.to_string(check("02.txt", red: 12, green: 13, blue: 14)),
  )

  io.println(
    "Phase 2 (test): " <> int.to_string(check_phase_two("02.test.txt")),
  )

  io.println("Phase 2: " <> int.to_string(check_phase_two("02.txt")))
}
