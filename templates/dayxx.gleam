import aoc.{obtain_input}
import gleam/io

pub type Input

pub fn parse(raw_input: String) -> Input {
  todo as "Input parsing not implemented"
}

pub fn solve_part1(input: Input) -> Int {
  todo as "Solution for part 1 not implemented"
}

pub fn solve_part2(input: Input) -> Int {
  todo as "Solution for part 2 not implemented"
}

pub fn main() {
  let input = parse(obtain_input($x))

  io.print("Part 1: ")
  echo solve_part1(input)

  io.print("Part 2: ")
  echo solve_part2(input)
}
