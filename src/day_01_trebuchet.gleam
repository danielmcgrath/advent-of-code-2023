import gleam/io
import gleam/int
import gleam/list
import gleam/option
import gleam/regex
import gleam/string
import simplifile

fn lines(file: String) -> List(String) {
  file
  |> string.split(on: "\n")
}

pub fn extract_digits(str: String, strings: Bool) -> List(String) {
  let assert Ok(re) = case strings {
    False -> regex.from_string("\\d")
    True ->
      regex.from_string(
        "(?=(\\d|one|two|three|four|five|six|seven|eight|nine))",
      )
  }

  regex.scan(with: re, content: str)
  |> list.map(fn(m) {
    case strings {
      False -> m.content
      True ->
        case m.submatches {
          [option.Some("one")] -> "1"
          [option.Some("two")] -> "2"
          [option.Some("three")] -> "3"
          [option.Some("four")] -> "4"
          [option.Some("five")] -> "5"
          [option.Some("six")] -> "6"
          [option.Some("seven")] -> "7"
          [option.Some("eight")] -> "8"
          [option.Some("nine")] -> "9"
          [option.Some(x)] -> x
        }
    }
  })
}

pub fn concat_first_and_last(xs: List(String)) -> Int {
  let assert Ok(first) = list.first(xs)
  let assert Ok(last) = list.last(xs)
  let assert Ok(ret) = int.base_parse(first <> last, 10)
  ret
}

pub fn values(lines: List(String)) -> List(Int) {
  lines
  |> list.map(fn(l) {
    extract_digits(l, False)
    |> concat_first_and_last
  })
}

pub fn values_v2(lines: List(String)) -> List(Int) {
  lines
  |> list.map(fn(l) {
    extract_digits(l, True)
    |> concat_first_and_last
  })
}

pub fn calibrate(values: List(Int)) -> Int {
  list.fold(values, 0, fn(a, x) { a + x })
}

fn phase_one(filename: String) {
  let assert Ok(contents) = simplifile.read(from: filename)
  let result =
    contents
    |> lines
    |> values
    |> calibrate
  io.println("Phase 1 (" <> filename <> "): " <> int.to_string(result))
}

fn phase_two(filename: String) {
  let assert Ok(contents) = simplifile.read(from: filename)
  let result =
    contents
    |> lines
    |> values_v2
    |> calibrate
  io.println("Phase 2 (" <> filename <> "): " <> int.to_string(result))
}

pub fn main() {
  phase_one("inputs/01.test.txt")
  phase_one("inputs/01.txt")
  phase_two("inputs/01-2.test.txt")
  phase_two("inputs/01.txt")
}
