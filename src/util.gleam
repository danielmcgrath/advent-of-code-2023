import gleam/int
import gleam/string
import simplifile

pub fn read_input(filename: String) -> String {
  let assert Ok(contents) = simplifile.read(from: "inputs/" <> filename)
  contents
}

pub fn read_input_lines(filename: String) -> List(String) {
  read_input(filename)
  |> string.split(on: "\n")
}

pub fn easy_int(input: String) -> Int {
  let assert Ok(parsed) = int.parse(input)
  parsed
}
