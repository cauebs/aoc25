import aoc.{obtain_input}
import gleam/bool
import gleam/dict.{type Dict}
import gleam/float
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/order
import gleam/string

pub type Position {
  Position(x: Int, y: Int, z: Int)
}

fn parse_position(line: String) -> Position {
  let assert [x, y, z] =
    line
    |> string.split(",")
    |> list.filter_map(int.parse)

  Position(x:, y:, z:)
}

type Breaker =
  Position

pub type Input =
  List(Breaker)

pub fn parse(raw_input: String) -> Input {
  raw_input
  |> string.trim_end()
  |> string.split("\n")
  |> list.map(parse_position)
}

fn distance(first: Position, second: Position) -> Float {
  let assert Ok(dist) =
    [
      first.x - second.x,
      first.y - second.y,
      first.z - second.z,
    ]
    |> list.filter_map(int.power(_, 2.0))
    |> float.sum()
    |> float.square_root()

  dist
}

type BreakerPair {
  BreakerPair(first: Breaker, second: Breaker, distance: Float)
}

fn compute_distances(breakers: List(Breaker)) -> List(BreakerPair) {
  let pairs = list.combination_pairs(breakers)
  use #(first, second) <- list.map(pairs)
  BreakerPair(first, second, distance(first, second))
}

fn connect_breakers(
  breaker_pairs: List(BreakerPair),
  remaining_connections: Int,
) -> Dict(Breaker, List(Breaker)) {
  let sorted_breaker_pairs =
    breaker_pairs
    |> list.sort(fn(first, second) {
      float.compare(first.distance, second.distance)
    })
  connect_breakers_aux(sorted_breaker_pairs, dict.new(), remaining_connections)
}

fn connect_breakers_aux(
  sorted_breaker_pairs: List(BreakerPair),
  connections: Dict(Breaker, List(Breaker)),
  remaining_connections: Int,
) -> Dict(Breaker, List(Breaker)) {
  case sorted_breaker_pairs, remaining_connections {
    _, 0 | [], _ -> connections

    [new_connection, ..next_breaker_pairs], _ -> {
      let connections =
        dict.upsert(
          in: connections,
          update: new_connection.first,
          with: fn(breaker_connections) {
            case breaker_connections {
              Some(other_breakers) -> [new_connection.second, ..other_breakers]
              None -> [new_connection.second]
            }
          },
        )

      connect_breakers_aux(
        next_breaker_pairs,
        connections,
        remaining_connections - 1,
      )
    }
  }
}

fn map_circuits(
  connections: Dict(Breaker, List(Breaker)),
) -> List(List(Breaker)) {
  dict.
}

pub fn solve_part1(input: Input) -> Int {
  let breaker_pairs = compute_distances(input)
  connect_breakers(breaker_pairs, 1000)
  |> map_circuits()
  |> list.map(list.length)
  |> list.sort(order.reverse(int.compare))
  |> list.take(3)
  |> int.product()
}

pub fn solve_part2(input: Input) -> Int {
  todo as "Solution for part 2 not implemented"
}

pub fn main() {
  // let input = parse(obtain_input(8))
  let input =
    parse(
      "162,817,812
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
425,690,689",
    )

  io.print("Part 1: ")
  echo solve_part1(input)

  io.print("Part 2: ")
  echo solve_part2(input)
}
