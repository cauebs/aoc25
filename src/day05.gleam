import aoc.{obtain_input}
import gleam/int
import gleam/io
import gleam/list
import gleam/order
import gleam/string

pub type IngredientID =
  Int

pub type Range {
  Range(begin: IngredientID, end: IngredientID)
}

pub type Input {
  Input(fresh_ranges: List(Range), available_ingredients: List(IngredientID))
}

fn parse_ingredient_id(raw_id: String) -> IngredientID {
  let assert Ok(id) = int.parse(raw_id)
  id
}

fn parse_ranges(raw_ranges: String) -> List(Range) {
  let pairs =
    raw_ranges
    |> string.split("\n")
    |> list.filter_map(string.split_once(_, on: "-"))

  use #(raw_first, raw_last) <- list.map(pairs)

  Range(
    begin: parse_ingredient_id(raw_first),
    end: parse_ingredient_id(raw_last),
  )
}

fn parse_ingredients(raw_ingredients: String) -> List(IngredientID) {
  raw_ingredients
  |> string.split("\n")
  |> list.map(parse_ingredient_id)
}

pub fn parse(raw_input: String) -> Input {
  let assert Ok(#(ranges, ingredients)) =
    raw_input
    |> string.trim_end()
    |> string.split_once("\n\n")

  Input(parse_ranges(ranges), parse_ingredients(ingredients))
}

fn range_contains(range: Range, id: IngredientID) -> Bool {
  id >= range.begin && id <= range.end
}

pub fn solve_part1(input: Input) -> Int {
  input.available_ingredients
  |> list.count(fn(id) {
    input.fresh_ranges
    |> list.any(range_contains(_, id))
  })
}

fn remove_overlaps(ranges: List(Range)) -> List(Range) {
  let sorted_ranges =
    list.sort(ranges, fn(range1, range2) {
      int.compare(range1.begin, range2.begin)
      |> order.break_tie(int.compare(range1.end, range2.end))
    })
  remove_overlaps_aux(sorted_ranges)
}

fn remove_overlaps_aux(sorted_ranges: List(Range)) -> List(Range) {
  case sorted_ranges {
    [] -> []
    [first, second, ..rest] if first.end + 1 >= second.begin -> {
      let merged = Range(first.begin, int.max(first.end, second.end))
      remove_overlaps_aux([merged, ..rest])
    }
    [first, ..rest] -> [first, ..remove_overlaps_aux(rest)]
  }
}

fn range_length(range: Range) -> Int {
  range.end - range.begin + 1
}

pub fn solve_part2(input: Input) -> Int {
  input.fresh_ranges
  |> remove_overlaps()
  |> list.map(range_length)
  |> int.sum()
}

pub fn main() {
  let input = parse(obtain_input(5))

  io.print("Part 1: ")
  echo solve_part1(input)

  io.print("Part 2: ")
  echo solve_part2(input)
}
