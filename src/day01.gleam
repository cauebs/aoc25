import aoc.{obtain_input}
import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub type Rotation {
  Left(distance: Int)
  Right(distance: Int)
}

pub type Input =
  List(Rotation)

fn parse_rotation(line: String) -> Rotation {
  let #(constructor, digits) = case line {
    "L" <> digits -> #(Left, digits)
    "R" <> digits -> #(Right, digits)
    _ -> panic as { "Unexpected: " <> line }
  }

  let assert Ok(distance) = int.parse(digits)
  constructor(distance)
}

pub fn parse(raw_input: String) -> Input {
  raw_input
  |> string.trim_end()
  |> string.split("\n")
  |> list.map(parse_rotation)
}

const numbers_in_dial = 100

type DialState {
  DialState(pointed: Int, stops_at_zero: Int, passes_by_zero: Int)
}

const dial_start = DialState(pointed: 50, stops_at_zero: 0, passes_by_zero: 0)

fn modular_additive_inverse(n: Int, mod m: Int) -> Int {
  // Assuming non-negative n and m.
  use <- bool.guard(when: n == 0, return: 0)
  let assert Ok(n_mod_m) = int.modulo(n, m)
  m - n_mod_m
}

fn apply_rotation(state: DialState, rotation: Rotation) -> DialState {
  let assert Ok(new_pointed) =
    case rotation {
      Left(distance:) -> state.pointed - distance
      Right(distance:) -> state.pointed + distance
    }
    |> int.modulo(numbers_in_dial)

  let new_stops_at_zero = case new_pointed == 0 {
    True -> 1
    False -> 0
  }

  let new_passes_by_zero = {
    // If we reflect the dial before rotating to the left,
    // everything else can be the same as when rotating to the right.
    let normalized_pointed = case rotation {
      Left(..) -> modular_additive_inverse(state.pointed, mod: numbers_in_dial)
      Right(..) -> state.pointed
    }

    { normalized_pointed + rotation.distance } / numbers_in_dial
  }

  DialState(
    pointed: new_pointed,
    stops_at_zero: state.stops_at_zero + new_stops_at_zero,
    passes_by_zero: state.passes_by_zero + new_passes_by_zero,
  )
}

pub fn solve_part1(input: Input) -> Int {
  let final_state =
    list.fold(from: dial_start, over: input, with: apply_rotation)

  final_state.stops_at_zero
}

pub fn solve_part2(input: Input) -> Int {
  let final_state =
    list.fold(from: dial_start, over: input, with: apply_rotation)

  final_state.passes_by_zero
}

pub fn main() {
  let input = parse(obtain_input(1))

  io.print("Part 1: ")
  echo solve_part1(input)

  io.print("Part 2: ")
  echo solve_part2(input)
}
