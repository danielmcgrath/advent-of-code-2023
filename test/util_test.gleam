import gleeunit/should
import util

pub fn easy_int_test() {
  util.easy_int("12")
  |> should.equal(12)
}
