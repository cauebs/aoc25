import aoc.{obtain_input}
import day02.{parse, solve_part1, solve_part2}

const example = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

pub fn part1_example_test() {
  assert example
    |> parse()
    |> solve_part1()
    == 1_227_775_554
}

pub fn part1_test() {
  assert obtain_input(2)
    |> parse()
    |> solve_part1()
    == 29_818_212_493
}

pub fn part2_example_test() {
  assert example
    |> parse()
    |> solve_part2()
    == 4_174_379_265
}

pub fn part2_test() {
  assert obtain_input(2)
    |> parse()
    |> solve_part2()
    == 37_432_260_594
}
