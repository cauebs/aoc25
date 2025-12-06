import aoc.{obtain_input}
import day05.{parse, solve_part1, solve_part2}

const example = "3-5
10-14
16-20
12-18

1
5
8
11
17
32"

pub fn part1_example_test() {
  assert example
    |> parse()
    |> solve_part1()
    == 3
}

pub fn part1_test() {
  assert obtain_input(5)
    |> parse()
    |> solve_part1()
    == 735
}

pub fn part2_example_test() {
  assert example
    |> parse()
    |> solve_part2()
    == 14
}

pub fn part2_test() {
  assert obtain_input(5)
    |> parse()
    |> solve_part2()
    == 344_306_344_403_172
}
