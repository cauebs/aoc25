import aoc.{obtain_input}
import gleam/int
import gleam/io
import gleam/list
import gleam/regexp
import gleam/string

pub type Interval {
  Interval(first: Int, last: Int)
}

pub type Input =
  List(Interval)

pub fn parse(raw_input: String) -> Input {
  let raw_intervals =
    raw_input
    |> string.trim_end()
    |> string.split(",")

  use interval <- list.map(raw_intervals)
  let assert Ok(#(a, b)) = string.split_once(interval, "-")
  let assert Ok(first) = int.parse(a)
  let assert Ok(last) = int.parse(b)
  Interval(first:, last:)
}

fn numbers_in_interval(interval: Interval) -> List(Int) {
  list.range(interval.first, interval.last)
}

const part1_regex = "^(\\d+)\\1$"

fn solve(input: Input, regex: String) -> Int {
  let assert Ok(re) = regexp.from_string(regex)

  input
  |> list.flat_map(numbers_in_interval)
  |> list.filter(fn(n) { regexp.check(re, int.to_string(n)) })
  |> int.sum()
}

pub fn solve_part1(input: Input) -> Int {
  solve(input, part1_regex)
}

const part2_regex = "^(\\d+)\\1+$"

pub fn solve_part2(input: Input) -> Int {
  solve(input, part2_regex)
}

pub fn main() {
  let input = parse(obtain_input(2))

  io.print("Part 1: ")
  echo solve_part1(input)

  io.print("Part 2: ")
  echo solve_part2(input)
}
