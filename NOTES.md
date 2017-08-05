# Notes

These are my notes from various resources.

## Try Elixir (1)

### Modules & Functions

Elixir functions are pure functions:
1. Return value relies entirely on arguments (and no external factors).
2. Must not cause any side effects.

All named functions in Elixir must be part of an enclosing module

```
defmodule Account do

    def balance(initial, spending) do
        initial - spending
    end

end
```

They're invoked by using the dot notation and preceded by their module name.

```
current_balance = Account.balance(1000, 500)
IO.puts "Current balance: US $#{current_balance}"
```


### Pipe Operator ( |> )

Nested function calls can be refactored into an easier syntax by using the
pipe operator ( |> ). It takes the output from the expression on the left and passes
it as the first argument to the function call on the right. It thus works very
similarly to the unix pipe operator.

```
defmodule Account do
    def balance(initial, spending) do
        discount(initial, 10)
        |> interest(0.1)
        |> format("$")
    end

    def discount(total, amount) do
    end

    def interest(total, rate) do
    end

    def print_sum do
        1..10
        |> Enum.sum
        |> IO.puts
    end
end
```


### Pattern Matching

The `=` symbol in Elixir is the match operator. It matches values on one side
against corresponding structures on the other side.

```
"John " <> last_name = "John Smith"
IO.puts last_name

"John " <> last_name = "Unknown"  # will raise a MatchError
IO.puts last_name
```

Square brackets specify a list and allow us to use pattern matching to read elements.

```
data = ["Elixir", "Valim"]
IO.puts data  # ElixirValim

[lang, author] = data
IO.puts "#{lang} #{author}"  # Elixir Valim
```

If statements are used less commonly than in other languages.
Pattern matching is supported in function arguments so functions with if statements
can be split into multiple clauses.

```
defmodule Account do
    # first clause
    def run_transaction(balance, amount, :deposit) do
        balance + amount
    end
    
    # second clause
    def run_transaction(balance, amount, :withdrawal) do
        balance - amount
    end
end

1000
|> Account.run_transaction(50, :deposit)  # 1050
|> Account.run_transaction(100, :withdrawal)  # 950
```


## References
1. [Codeschool's Try Elixir](https://www.codeschool.com/courses/try-elixir)