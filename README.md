
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



## Adding your own adventure

It is possible to play a different adventure than the one that's provided. 

### File format

The adventure file has to be formatted like this:

```
id: 0

You are reading instructions on how the custom adventure file format should look like. You are pretty clueless about all this, but very curious!


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

As in the above example, a file consists of multiple sections (paragraphs) separated by a delimiter: 

```
<paragraph>
--- next ---
<paragraph>
--- next ---
<paragraph>
```

A single paragraph is formatted like this: 

```
id: $id

$text

choices: $choice_1, $choice_2, ...
```

Where: 

`$id` - mandatory id number. They don't have to be in order or even continuous (but it helps with readability). 

`$text` - any text you want to display for a given paragraph. Can be multiline and have empty lines. Anything between 'id' and 'choices' section will be displayed as paragraph content in the game.

`$choice_1, $choice_2, ...` - ids of paragraphs to jump to from the current paragraph. At least one choice is mandatory! In the final paragraph it is recommended to loop to the first one, so the user can easily restart the game. 

If the paragraph is not in the correct format, it won't parse and will not be reachable in the game.

When loading the corrupt adventure file you should see a warning message stating which paragraph was malformed and didn't parse correctly. The game will be broken from that paragraph on. 


### Loading custom adventure files

#### 1) Local file 

If you're compiling the game and running from XCode, you could simply modify `adventure.txt` file. 

Or add a new one: 
1) Add a new resource text file to the XCode project 
2) Tell CYOA to load it by default: change `Constants.fileName` in `LocalFileAdventureReader.swift` to the name of your file. 

There's no way of loading a local file without running XCode at the moment. 


#### 2) Online file

If you have a URL of an adventure file on server, you could run the engine, select to run a remote adventure, type in a URL and press enter. If the file is in correct format, everything should work. 

#### 3) Local webserver

You could run a webserver on your machine and serve a text file through it. It will be accessible through http protocol and you could pass it's new address as a remote URL. 

In terminal navigate to a directory with your textfile (let's assume it's named `my_adventure.txt`). 

Run `python -m SimpleHTTPServer 1337` or `python3 -m http.server 1337`. From now on, you can use `http://localhost:1337/my_adventure.txt` as a remote resource URL (as long as a python server is running).  

### Debugging your adventure

Adventure file is loaded to memory on game start and never reloaded afterwards. If you made changes to your adventure and would like to see them in the game, you have to close and reopen the program. 


## General Information


### Authors

Programming: Thomas Wyszomirski, [Twitter](https://twitter.com/Wyszo), [blog](https://www.wyszo.wordpress.com)

Writing (default adventure): Reddit user [u/gargle-greg](https://www.reddit.com/user/gargle-greg/) 


### Versioning

Semantic versioning is being used ([SemVer](http://semver.org))


### License

This project is licensed under the MIT License - see the [LICENSE.md] file for details

