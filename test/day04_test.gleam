import aoc.{obtain_input}
import day04.{parse, solve_part1, solve_part2}

const example = "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@."

pub fn part1_example_test() {
  assert example
    |> parse()
    |> solve_part1()
    == 13
}

pub fn part1_test() {
  assert obtain_input(4)
    |> parse()
    |> solve_part1()
    == 1491
}

pub fn part2_example_test() {
  assert example
    |> parse()
    |> solve_part2()
    == 43
}

pub fn part2_test() {
  assert obtain_input(4)
    |> parse()
    |> solve_part2()
    == 8722
}
