import gleeunit/should
import day_01_trebuchet

pub fn calibrate_test() {
  day_01_trebuchet.calibrate([1, 2, 3])
  |> should.equal(6)
}

pub fn values_test() {
  day_01_trebuchet.values(["1b4d7", "2ahjabsdjh5asdasd", "7j4"])
  |> should.equal([17, 25, 74])
}

pub fn values_v2_test() {
  day_01_trebuchet.values_v2(["oneb4dseven", "twone", "7j4"])
  |> should.equal([17, 21, 74])
}

pub fn concat_first_and_last_test() {
  day_01_trebuchet.concat_first_and_last(["1", "2", "3"])
  |> should.equal(13)
}

pub fn extract_digits_test() {
  day_01_trebuchet.extract_digits("four1b4d7", False)
  |> should.equal(["1", "4", "7"])

  day_01_trebuchet.extract_digits("four1b4d7", True)
  |> should.equal(["4", "1", "4", "7"])
}
