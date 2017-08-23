# Important

All data structures in Elixir are immutable.


## Create Mix Project

`mix new path` will create a new Mix project.

`iex lib/file.ex` will start iex and interpret the file while starting

`iex -S Mix` will start iex within the context of a Mix project and preload all the modules.

Loading a module within iex:
> c lib/servy.ex

Reloading a module within iex:
> r lib/servy.ex

Enabling iex shell history:
`export ERL_AFLAGS="-kernel shell_history enabled"`

## High-Level Transformations
* Building out a function's pipeline of actions functions like a to-do list.
* `map = %{ method: "GET", path: "/wildthings" }`

## Parse Request Line
`h String.<tab>` will show a list of the methods defined within the String module.

`h String.split/2` will show help text for a method. The */2* is the number of
arguments the particular version of the method takes -- also known as its arity.

Pin operator:
```
> a = 1   # 1
> 1 = a   # 1
> ^a = 3  # MatchError
```

```
%{ :method => "GET", :path => "/wildthings } == %{ method: "GET", path: "/wildthings" }
```

If keys are *not* atoms, the => form must be used:
%{ "method" => "GET", "path" => "/wildthings" }


## Route and Response

```
conv = %{ method: "GET", path: "/wildthings", resp_body: "" }
conv[:method]  # "GET"
conv.method  # "GET" -- only works with keys that are atoms
conv[:unknown]  # nil
conv.unknown  # MethodError

conv = Map.put(conv, :resp_body, "Bears, Lions, Tigers")
# the following can only modify values that exist in the map
conv = %{ conv | resp_body: "Bears, Lions, Tigers" }
```


## Function Clauses

Pattern matching often removes the need for if/else conditionals. Instead, short, declarative functions can be created.


## Request Params and Status Codes

Elixir tries to match function clauses based on the function ordering from the top to the bottom of the file. Unused variable warnings can be silenced by prefixing the clause with an `_`.

Clauses for the same definition should be grouped together.

`defp` defines private functions that cannot be called outside of their module.


## Rewrite Paths and Track 404s

We don't need to provide all the keys/values to match a Map. The keys in the pattern must exist in the Map we're trying to match against.

Example pattern matching for parts of a Map:
```
def route(%{ method: "GET", path: "/bears/" <> id } = conv) do
  %{ conv | status: 200, resp_body: "Bear #{id}" }
end
```

Regexes:
```
regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
captures = Regex.named_captures(regex, string)
```


## Serve Static Files

Tuples, an ordered collection of values:
```
{:ok, binary} = File.read(path)
```

The File and Path modules are useful in manipulating static files.

## Module Attributes

```
defmodule MyModule do
  @moduledoc "Describes the module."""

  @doc "Describes the function."""
  def my_function() do
    IO.puts "Hi"
  end
end
```

Module attributes can also be used as a constant. They can only be set at the top level of a module but can be read from inside functions. They're defined during compilation (not at runtime) so if the "[...]same attribute is set multiple times in a module the value read by a function is the value of the attribute at the time the function is defined." For instance:
```
defmodule Namer do
  @name "nicole"

  def her_name, do: @name

  @name "mike"

  def his_name, do: @name
end

iex> Namer.her_name
"nicole"

iex> Namer.his_name
"mike"
```

## Organizing Code

All modules are defined at the top level; thus, dots in a module name have no implicit meaning.

Starting iex within Mix application context: `iex -S mix`
Reloading module: `iex> r Servy.Handler`
Recompile whole application (to pick up new modules, etc): `iex> recompile()`

Functions and macros defined in [Kernel](https://hexdocs.pm/elixir/Kernel.html) are automatically imported into every module.

## Modeling with Structs

A struct needs to live in its own module.
```
defmodule Servy.Conv do
  defstruct method: "", path: "", resp_body: "", status: nil
end

conv = %Servy.Conv{}
conv = %Servy.Conv{method: "GET", path: "/bears", resp_body: "", status: nil}
```

A struct will only accept the fields specified in its definition and these values will be checked at compile time. Dynamic access to a struct's fields with square brackets is *not* allowed. They're instead accessed via struct.field.

A struct instance is a special kind of map with a fixed set of keys and default values.
```
iex> is_map(conv)  # true
```

Therefore, matching works the same way as it would with a map:
```
conv = %Servy.Conv{method: "GET", path: "/bears", resp_body: "", status: nil}
%{method: "GET"} = conv
# %Servy.Conv{method: "GET", path: "/bears", resp_body: "", status: nil}
```

However, a map is *not* a struct:
```
%Servy.Conv{method: "GET"} = %{method: "GET"}  # MatchError
```


## Handling POST Requests

The cons operator (|) can be used to split a list into its head and tail.

```
[head | tail] = [1, 2, 3, 4, 5]
head = 1
tail = [2, 3, 4, 5]

[head | tail] = [5]
head = 5
tail = []
```

Cons can also be used to create a list.
nums = [1 | [2, 3]]  # [1, 2, 3]
[0 | nums]  # [0, 1, 2, 3]

Lists are recursive data structures because they're implemented as a series of linked lists.

`hd` and `tl` can be used to access the head and tail of a list, respectively.

Atoms are not garbage collected inside of elixir so be careful with allowing the outside environment to create them (for instance, by reading POST body parameters into them instead of strings) because it can lead to EOM.
