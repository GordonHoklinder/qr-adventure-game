About QR Adventure Game
=======================

This mobile app is intended to be used by children playing an adventure game (or a puzzle hunt). They run around in nature and scan qr codes prepared by organizers and the app displays appropriate texts and manages access.

The app enables additional complexity to an adventure game which woudln't be possible on a blank paper. Becomes especially handy when there are not enough organizers to operate the whole game.

The app was developed for an adaptation course of Gymnázium, Plzeň in year 2021. However as the story is fully handled by the QR codes and the app only serves as an QR code translator, it can be reused by anyone for any such game.

How to write text in QR codes
=============================
The code in QR codes is quite simple and consists of two units.

* Text
  * This is written inside a single quotes.
	* Single quotes and backslashes are escaped by backslashes (i.e. '\'' prints a single quote and '\\' a backslash).
	* The text is printed to the page
* Functions
  * Functions start with a dollar sign, then goes the function name followed by round braces in which the function arguements are written separated by commas. If the function takes code as the last arguement, it should be written inside curly braces which follow the closing round brace.
	* There are a lot of functions enabling more complex behaviour the simple text printing. They are described below.

A sample code:
--------------

```
$title(Locked_drawer, drawer5)
'You\'ve come across a locked drawer. What will you do?'
$if(key|crowbar) {
  $option(Unlock_it) {
	  'You found a diary!'
		$add(diary)
  }
}
```

The title function displays a title *Locked drawer* and saves that the user has visited the stop with id **drawer5**.

Below is displayed text *You've come across a locked drawer. What will you do?*.

If the user has item *key* or item *crowbar*, the button with text *unlock* is displayed. When clicked, text *You found a diary!* is displayed and an item diary is added to inventory.

Functions
---------

This is the list of functions which are currently supported.

### If
`$if(expression) { code }`

Conditionally executes code.

* The *expression* consists of items / page ids and logical operators |, & and !. It can also contain braces. The items evaluate to true if they are in itinerary and to false otherwise (analogously for page ids).
* The *code* is executed if the *expression* evaluates to true.

### Add
`$add(item)`

Adds the item *item* to itinerary

### Remove
`$remove(item)`

Removes the item *item* from itinerary

### Title
`$title(text, id)`

Adds a title with text *text* and ads a visited page with id *id* to the itinerary.

### Option
`$option(text) { code }`

Displays a clickable button.

* *Text* is displayed on the button.
* When clicked the button navigates to a new page described by *code*.

How to use the app
==================

The app was developed by @composerPigeon and @GordonHoklinder. Many thanks to @Keiky and @Yokto13 for their advice and help.

It can be used freely. If one finds it sufficient as it is, the app can be downloaded from Play Store as QRAdventureGame by publisher Whizzmot (the exact link will be added) and the only thing left to do is prepare the QR codes. If there are some features missing, feel free to raise an issue or create a pull request. Additionally one can fork the repositary and publish it themselves.
