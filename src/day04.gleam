import aoc.{obtain_input}
import gleam/io
import gleam/list
import gleam/option
import gleam/set.{type Set}
import gleam/string

pub type Position {
  Position(x: Int, y: Int)
}

pub type Input =
  Set(Position)

pub fn parse(raw_input: String) -> Input {
  raw_input
  |> string.trim_end()
  |> string.split("\n")
  |> list.index_map(fn(line, i) {
    line
    |> string.to_graphemes()
    |> list.index_map(fn(char, j) {
      case char {
        "." -> option.None
        "@" -> option.Some(Position(i, j))
        _ -> panic
      }
    })
  })
  |> list.flatten()
  |> list.filter_map(option.to_result(_, Nil))
  |> set.from_list()
}

fn adjacent_positions(pos: Position) -> List(Position) {
  let deltas = list.range(-1, 1)
  use dx <- list.flat_map(deltas)
  use dy <- list.filter_map(deltas)

  case dx, dy {
    0, 0 -> Error(Nil)
    _, _ -> Ok(Position(pos.x + dx, pos.y + dy))
  }
}

fn adjacent_paper_rolls(pos: Position, grid: Set(Position)) -> Set(Position) {
  pos
  |> adjacent_positions()
  |> set.from_list()
  |> set.intersection(grid)
}

fn can_be_accessed(pos: Position, grid: Set(Position)) -> Bool {
  pos
  |> adjacent_paper_rolls(grid)
  |> set.size()
  < 4
}

pub fn solve_part1(input: Input) -> Int {
  let paper_rolls = input

  paper_rolls
  |> set.to_list()
  |> list.count(can_be_accessed(_, paper_rolls))
}

fn count_removable(grid: Set(Position)) -> Int {
  let #(can_be_accessed, cannot_be_accessed) =
    grid
    |> set.to_list()
    |> list.partition(can_be_accessed(_, grid))

  case can_be_accessed {
    [] -> 0
    _ -> {
      list.length(can_be_accessed)
      + count_removable(set.from_list(cannot_be_accessed))
    }
  }
}

pub fn solve_part2(input: Input) -> Int {
  count_removable(input)
}

pub fn main() {
  let input = parse(obtain_input(4))

  io.print("Part 1: ")
  echo solve_part1(input)

  io.print("Part 2: ")
  echo solve_part2(input)
}
