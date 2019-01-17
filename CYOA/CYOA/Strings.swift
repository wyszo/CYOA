import Foundation

struct Strings {
    static let gameIntro = """
        CYOA game v\(Settings.version)
        Open Source. Feel free to fork and modify.\n
        \
        Programming: Thomas Wyszomirski (https://github.com/wyszo/)
        Writing:     u/gargle-greg (reddit)\n
        \
        Original text 'choose your own adventure' version by u/gargle-greg (used without permission):
        https://www.reddit.com/r/chooseyouradventure/comments/8wxysn/interactive_fiction_for_the_next_generation_text/\n
        \
        Press [Enter] to continue.
        """
    
    // This is temporary, will be removed
    struct GameEntries {
        static let firstEntry = """
            \nYou’re having a dream you’re in one of those interactive fiction novels that lets you decide what happens in the story by flipping to different parts of the book. It’s great. It gives you the feeling that the choices you make really matter, unlike reality where you have no autonomy whatsoever.

            To continue, go to Entry [3].
            """
    }
}
