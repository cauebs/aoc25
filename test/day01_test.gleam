import aoc.{obtain_input}
import day01.{parse, solve_part1, solve_part2}

const example = "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"

pub fn part1_example_test() {
  assert example
    |> parse()
    |> solve_part1()
    == 3
}

pub fn part1_test() {
  assert obtain_input(1)
    |> parse()
    |> solve_part1()
    == 1118
}

pub fn part2_example_test() {
  assert example
    |> parse()
    |> solve_part2()
    == 6
}

pub fn part2_test() {
  assert obtain_input(1)
    |> parse()
    |> solve_part2()
    == 6289
}
