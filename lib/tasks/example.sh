#!/usr/bin/env bash
#
# Example functions

fn_1 () {
  echo "Function #1" >&3
  my_sleep "${@}"
}

fn_2 () {
  echo "Function #2"
  my_sleep "${@}"
}
