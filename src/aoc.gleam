import advent
import day01
import day02
import day03
import gleam/http/request
import gleam/httpc
import gleam/int
import gleam/option.{Some}
import gleam/result
import gleam/string
import question.{question}
import simplifile

const year: Int = 2025

const session_path: String = ".session"

const inputs_dir: String = "inputs"

fn ask_session() -> Nil {
  use session <- question(
    "Enter the value of your adventofcode.com session cookie: ",
  )
  let assert Ok(Nil) = simplifile.write(to: session_path, contents: session)
}

fn obtain_session() -> String {
  case simplifile.read(from: session_path) {
    Ok(session) -> session
    Error(_) -> {
      ask_session()
      obtain_session()
    }
  }
}

pub fn zero_padded_day(day: Int) -> String {
  int.to_string(day)
  |> string.pad_start(to: 2, with: "0")
}

fn input_path(day: Int) -> String {
  inputs_dir <> "/day" <> zero_padded_day(day) <> ".txt"
}

fn input_url(day: Int) -> String {
  "https://adventofcode.com/"
  <> int.to_string(year)
  <> "/day/"
  <> int.to_string(day)
  <> "/input"
}

fn download_input(day: Int) -> String {
  let url = input_url(day)
  let assert Ok(req) = request.to(url)

  let assert Ok(resp) =
    req
    |> request.set_cookie("session", obtain_session())
    |> httpc.send()

  let input = resp.body
  let _ = simplifile.create_directory(inputs_dir)
  let assert Ok(_) = simplifile.write(input, to: input_path(day))
  input
}

pub fn obtain_input(day: Int) -> String {
  input_path(day)
  |> simplifile.read()
  |> result.unwrap(or: download_input(day))
}

pub fn main() {
  advent.year(2025)
  |> advent.timed()
  |> advent.add_day(
    advent.Day(
      1,
      day01.parse,
      day01.solve_part1,
      Some(1118),
      [],
      day01.solve_part2,
      Some(6289),
      [],
    ),
  )
  |> advent.add_day(
    advent.Day(
      2,
      day02.parse,
      day02.solve_part1,
      Some(29_818_212_493),
      [],
      day02.solve_part2,
      Some(37_432_260_594),
      [],
    ),
  )
  |> advent.add_day(
    advent.Day(
      3,
      day03.parse,
      day03.solve_part1,
      Some(17_316),
      [],
      day03.solve_part2,
      Some(171_741_365_473_332),
      [],
    ),
  )
  |> advent.add_padding_days(up_to: 12)
  |> advent.run()
}
