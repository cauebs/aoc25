import gleam/bool
import gleam/int
import gleam/list
import gleam/order.{type Order}
import gleam/string

pub type Battery {
  Battery(joltage: Int)
}

pub type BatteryBank {
  BatteryBank(batteries: List(Battery))
}

pub type Input =
  List(BatteryBank)

fn parse_battery(raw_joltage: String) -> Battery {
  let assert Ok(joltage) = int.parse(raw_joltage)
  Battery(joltage:)
}

pub fn parse(raw_input: String) -> Input {
  let lines =
    raw_input
    |> string.trim_end()
    |> string.split("\n")

  use line <- list.map(lines)
  line
  |> string.to_graphemes()
  |> list.map(parse_battery)
  |> BatteryBank
}

fn compare_joltage(battery1: Battery, battery2: Battery) -> Order {
  int.compare(battery1.joltage, battery2.joltage)
}

fn optimal_batteries(batteries: List(Battery), remaining: Int) -> List(Battery) {
  use <- bool.guard(when: remaining == 0, return: [])

  let n_batteries = list.length(batteries)
  let assert Ok(largest) =
    batteries
    |> list.take(n_batteries - { remaining - 1 })
    |> list.max(compare_joltage)

  let batteries_to_check =
    batteries
    |> list.drop_while(fn(b) { b.joltage < largest.joltage })
    |> list.drop(1)

  [largest, ..optimal_batteries(batteries_to_check, remaining - 1)]
}

fn total_joltage(batteries: List(Battery)) -> Int {
  total_joltage_aux(batteries, 0)
}

fn total_joltage_aux(batteries: List(Battery), current_joltage: Int) -> Int {
  case batteries {
    [] -> current_joltage
    [first, ..rest] ->
      total_joltage_aux(rest, current_joltage * 10 + first.joltage)
  }
}

fn solve(input: Input, n_batteries: Int) -> Int {
  input
  |> list.map(fn(bank) { bank.batteries })
  |> list.map(optimal_batteries(_, n_batteries))
  |> list.map(total_joltage)
  |> int.sum()
}

pub fn solve_part1(input: Input) -> Int {
  solve(input, 2)
}

pub fn solve_part2(input: Input) -> Int {
  solve(input, 12)
}
