import aoc.{obtain_input}
import day08.{parse, solve_part1, solve_part2}

const example = "162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689"

pub fn part1_example_test() {
  assert example
    |> parse()
    |> solve_part1()
    == 40
}

pub fn part1_test() {
  assert obtain_input(8)
    |> parse()
    |> solve_part1()
    == -42
}

pub fn part2_example_test() {
  assert example
    |> parse()
    |> solve_part2()
    == -42
}

pub fn part2_test() {
  assert obtain_input(8)
    |> parse()
    |> solve_part2()
    == -42
}
