import aoc.{obtain_input}
import day03.{parse, solve_part1, solve_part2}

const example = "987654321111111
811111111111119
234234234234278
818181911112111"

pub fn part1_example_test() {
  assert example
    |> parse()
    |> solve_part1()
    == 357
}

pub fn part1_test() {
  assert obtain_input(3)
    |> parse()
    |> solve_part1()
    == 17_316
}

pub fn part2_example_test() {
  assert example
    |> parse()
    |> solve_part2()
    == 3_121_910_778_619
}

pub fn part2_test() {
  assert obtain_input(3)
    |> parse()
    |> solve_part2()
    == 171_741_365_473_332
}
