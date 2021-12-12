# Update Dec 12, 2021: This solution has passed all automated tests.
I changed my approach to the problem. Rather than construct a 'naive' and 'greedy' tree that lists all possible coin combinations, I use dynamic programming approach, which will significantly reduce possible coin combinations. This new approach makes use of the fact that the least number of coins among all the possible combinations for any target value, can be produced from the combinations of additional coins + the least number of coin combinations from lesser amount than the target. Therefore, there's no need to generate all the possible combinations.

~~# !Note
This solution has not passed all the automated test, especially for 'large target values' and 'change with Lower Elbonia Coins'.
My approach to the problem is to contruct a tree of all possible coin combinations, then choose the least number of coins in the tree.~~


# Change

Welcome to Change on Exercism's Elixir Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Instructions

Correctly determine the fewest number of coins to be given to a customer such
that the sum of the coins' value would equal the correct amount of change.

## For example

- An input of 15 with [1, 5, 10, 25, 100] should return one nickel (5)
  and one dime (10) or [5, 10]
- An input of 40 with [1, 5, 10, 25, 100] should return one nickel (5)
  and one dime (10) and one quarter (25) or [5, 10, 25]

## Edge cases

- Does your algorithm work for any given set of coins?
- Can you ask for negative change?
- Can you ask for a change value smaller than the smallest coin value?

## Source

### Created by

- @bernardoamc

### Contributed to by

- @angelikatyborska
- @Cohen-Carlisle
- @devonestes
- @lpil
- @neenjaw
- @parkerl
- @sotojuan
- @veelenga
- @waiting-for-dev
- @weapp

### Based on

Software Craftsmanship - Coin Change Kata - https://web.archive.org/web/20130115115225/http://craftsmanship.sv.cmu.edu:80/exercises/coin-change-kata
