# FindShortTwitterId

This app is to find short Twitter id which no one is using.
It's difficult to explain in English (even Japanese...)

At Twitter, we can use 37 chars ('a'..'z', '0'..'9', '_')
This app generates names and tell you that names is used or not used.

# Usage

```
$ ruby main.rb :from_digit :count
```

This app generates names from these inputs :from_digit and :count.
Each digit corresponds to each name.


e.g.
* 0 : 'a'
* 1 : 'b'
* ...
* 35 : '9'
* 36 : '_'
* 37 : 'aa'
* 38 : 'ab'
* ...
* 73 : 'a_'
* ...
* 1406 : 'aaa'

sample

```
$ ruby main.rb 0 10
USED : a
USED : b
USED : c
USED : d
USED : e
USED : f
USED : g
USED : h
NOT USED : i
USED : j
```
```
$ ruby main.rb 37 37
USED : aa
USED : ab
USED : ac
USED : ad
USED : ae
USED : af
USED : ag
USED : ah
USED : ai
USED : aj
USED : ak
USED : al
USED : am
USED : an
USED : ao
USED : ap
USED : aq
USED : ar
USED : as
USED : at
USED : au
USED : av
USED : aw
USED : ax
USED : ay
USED : az
USED : a0
USED : a1
USED : a2
USED : a3
USED : a4
USED : a5
USED : a6
USED : a7
USED : a8
USED : a9
USED : a_
```
