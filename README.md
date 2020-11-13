## Notes:

- Be sure to look at my closed pull requests, as I made notes in the descriptions about the changes.
- Please disregard the git history until commit 73c2116a "Parallax view and sticky header working"
- I normally make branches for each major feature and merge them into master one by one, but I was working in a detached head state in the beginning of the project. I'd doctor the history to clean it up, but for the sake of time I left it as-is and moved forward with better practices.


## Improvements:
Here are some things I would improve with more time:

- disable editing state and save the text upon user tapping outside of the description text box **or** tapping the `return` key
- make the `ShotlistNavbar` dissappear _before_ the `StickyHeaderView()` appears, so the buttons of the navbar never overlap the safeArea
- Find a better way than using an infinite time loop for computing `self.showStickyHeader` from within the `ParallaxImageView`. There must be a solution to this that utilizes the `GeometryReader` instead. However, you must be careful because Modifying state during view update, this will undefined behavior.


## Testing:
For the sake of time, I did not add a testing suite to the exisitng project. However, in a normal dev workflow I would have been sure to include testing from the beginning and test every feature that I modified or added.

### I would have tested things like:
- `shoot.description` was saved upon exiting the editing state on the background info textbox [[ assuming persistence was already implemented]]
- editing state is deactiviated in all respects (icon color, text interaciton, etc) when the icon is toggled off, or the user taps outside the text box, or the user taps enter.
- `StickyHeaderView` appears (and dissappears) when the user has scrolled to the appropriate screen height
- `ParallaxView` increases in size as the user scrolls past the maximum height [for the visual effect]
- `ShotlistPreview` renders all of the required views
and more...
