import Foundation

struct Strings {
    static let gameIntro = """
        \n
        \
            $$$$$$\\  $$\\     $$\\  $$$$$$\\   $$$$$$\\
            $$  __$$\\ \\$$\\   $$  |$$  __$$\\ $$  __$$\\
            $$ /  \\__| \\$$\\ $$  / $$ /  $$ |$$ /  $$ |
            $$ |        \\$$$$  /  $$ |  $$ |$$$$$$$$ |
            $$ |         \\$$  /   $$ |  $$ |$$  __$$ |
            $$ |  $$\\     $$ |    $$ |  $$ |$$ |  $$ |
            \\$$$$$$  |    $$ |     $$$$$$  |$$ |  $$ |
             \\______/     \\__|     \\______/ \\__|  \\__|
        \n
        \
        CYOA game v\(Settings.version) (Choose Your Own Adventure)
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
    
    static let localOrRemoteChoice = """
        Press [Enter] again to play a default adventure.
        Type 5 and confirm with [Enter] to load a remote adventure
        """
    static let remoteAdventureShortcut = "5"
    
    static let askRemoteAdventureUrl = """
        What's the remote adventure URL?
        Leaving this blank will take you back to the main menu.
        """
    static let incorrectUrl = "Incorrect URL. Try again."
}
