import aoc.{obtain_input}
import gleam/float
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

/// Part 1 -----------------------------------------------------------------------------------------
pub type Solution1 =
  Int

const numbers_in_dial = 100

type DialState {
  DialState(pointed: Int, stops_at_zero: Int, passes_by_zero: Int)
}

const dial_start = DialState(pointed: 50, stops_at_zero: 0, passes_by_zero: 0)

fn apply_rotation(state: DialState, rotation: Rotation) -> DialState {
  let assert Ok(pointed) =
    case rotation {
      Left(distance:) -> state.pointed - distance
      Right(distance:) -> state.pointed + distance
    }
    |> int.modulo(numbers_in_dial)

  let stops_at_zero =
    state.stops_at_zero
    + case pointed == 0 {
      True -> 1
      False -> 0
    }

  let passes_by_zero =
    state.passes_by_zero
    + case rotation {
      Left(distance:) if state.pointed == 0 ->
        { numbers_in_dial - state.pointed + distance } / numbers_in_dial - 1

      Left(distance:) ->
        { numbers_in_dial - state.pointed + distance } / numbers_in_dial

      Right(distance:) -> { state.pointed + distance } / numbers_in_dial
    }

  DialState(pointed:, stops_at_zero:, passes_by_zero:)
}

pub fn solve_part1(input: Input) -> Solution1 {
  let final_state =
    list.fold(from: dial_start, over: input, with: apply_rotation)

  final_state.stops_at_zero
}

/// Part 2 -----------------------------------------------------------------------------------------
pub type Solution2 =
  Solution1

pub fn solve_part2(input: Input) -> Solution2 {
  let final_state =
    list.fold(from: dial_start, over: input, with: apply_rotation)

  final_state.passes_by_zero
}

/// Main -------------------------------------------------------------------------------------------
pub fn main() {
  let input = parse(obtain_input(1))

  io.print("Part 1: ")
  echo solve_part1(input)

  io.print("Part 2: ")
  echo solve_part2(input)
}
