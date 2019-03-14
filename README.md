
```
$$$$$$\  $$\     $$\  $$$$$$\   $$$$$$\
$$  __$$\ \$$\   $$  |$$  __$$\ $$  __$$\
$$ /  \__| \$$\ $$  / $$ /  $$ |$$ /  $$ |
$$ |        \$$$$  /  $$ |  $$ |$$$$$$$$ |
$$ |         \$$  /   $$ |  $$ |$$  __$$ |
$$ |  $$\     $$ |    $$ |  $$ |$$ |  $$ |
\$$$$$$  |    $$ |     $$$$$$  |$$ |  $$ |
 \______/     \__|     \______/ \__|  \__|
```


# CYOA (Choose Your Own Adventure)

A Simple 'Choose Your Own Adventure' (aka paragraph) game engine inspired by the Black Mirror's 'Bandersnatch' episode. 


## About the project

The engine lets you play a paragraph adventure game written in a simple format (documented below). 

If you wrote your own, you can play it by providing a text file  URL (online). Otherwise you'll play a default one. 

I'm not the author of the default adventure, credit goes to u/gargle-greg (used without permission):
[Default Adventure on Reddit](https://www.reddit.com/r/chooseyouradventure/comments/8wxysn/interactive_fiction_for_the_next_generation_text/)


## Getting Started 

CYOA is made to be run in the Mac OS terminal, but it should be easy to compile it under Linux. It could be possible to run it on web with online Swift REPL tools (like [Repl.it](https://repl.it)), but this has also not been tested. 


### Prerequisites

Currently no dependency manager is being used, nothing to install before compiling. 


### Running Tests

There are a few unit tests, make sure to run them when you make changes in code. 


### Authors

Programming: Thomas Wyszomirski, [Twitter](https://twitter.com/Wyszo), [blog](https://www.wyszo.wordpress.com)

Writing (default adventure): Reddit user [u/gargle-greg](https://www.reddit.com/user/gargle-greg/) 


### License

This project is licensed under the MIT License - see the [LICENSE.md] file for details


### Versioning

Semantic versioning is being used ([SemVer](http://semver.org))


### Adding your own adventure

It is possible to play a different adventure than the one that's provided. The file containing the adventure has to follow a simple format like so: 

```
id: 0

You are reading instrauctions on how the custom adventure file format should look like. You are pretty clueless about all this, but very curious!


To continue, go to Entry 1.

choices: 1

--- next ---

id: 1

After reading a bit more, you feel you haven't got it yet. 

To continue reading, go to Entry 2.

To give it a rest and move on, go to Entry 3.

choices: 2, 3

--- next ---

id: 2

You continue reading, yet you learn nothing new!

To finish reading, go to Entry 3.

choices: 3

--- next ---

id: 3

You now have a better idea on how the custom adventure format looks like!

THE END.


To restart go to entry 0.

choices: 0

```

So in general a file consists of multiple sections (paragraphs) of the same structure separated by a delimiter:

```
<paragraph>
--- next ---
<paragraph>
--- next ---
<paragraph>
```

A single paragraph has following format: 

```
id: $id

$text

choices: $choice_1, $choice_2, ...
```

Where: 

```$id``` - an obligatory number. They don't have to be in order or continuous (but it helps with readability). 

$text - any text you want to display for a given paragraph. Can be multiline and with empty lines in between. Anything between 'id' and 'choices' section will be displayed as paragraph content in the game.

$choice_1, $choice_2, ... - ids of paragraphs that you allow user to jump to from current paragraph. At least one choice is mandatory! If you end the game, just loop to the first paragraph here.  

If the paragraph is not following the format above, it will not parse and will not be reachable in the game, thus breaking it. 

When running from XCode on loading the adventure, you'll get a message saying which paragraph didn't parse correctly (if any). 


