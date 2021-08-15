About QR Adventure Game
=======================

This mobile app is intended to be used by children playing an adventure game (or a puzzle hunt). They run around in nature and scan qr codes prepared by organizers and the app displays appropriate text and manages access.

The app enables additional complexity to an adventure game which woudln't be possible on a blank paper. Becomes especially handy when there are not enough organizers to operate the whole game.

The app was developed for an adaptation course of Gymnázium, Plzeň in year 2021. However as the story is fully handled by the QR codes and the app only serves as an QR code translator, it can be reused by anyone for any such game.

How to write text in QR codes
=============================
The code in QR codes is quite simple and consists of two units.

+ Text
  + This is written inside a single quotes.
  + Single quotes and pipes are escaped by pipes (i.e. '|'' prints a single quote and '||' a pipe).
  + The text is printed to the page
+ Functions
  + Functions start with a ampersand sign, then goes the function name followed by round braces in which the function arguements are written separated by commas. If the function takes code as the last arguement, it should be written inside curly braces which follow the closing round brace.
  + There are a lot of functions enabling more complex behaviour the simple text printing. They are described below.

A sample code:
--------------

```
&title(Locked-drawer, drawer5)
'You|'ve come across a locked drawer. What will you do?'
&if(key|crowbar) {
  &option(Unlock-it) {
	  'You found a diary!'
		&add(diary)
  }
}
```

The title function displays a title *Locked drawer* and saves that the user has visited the stop with id **drawer5**.

Below is displayed text *You've come across a locked drawer. What will you do?*.

If the user has item *key* or item *crowbar*, the button with text *Unlock it* is displayed. When clicked, text *You found a diary!* is displayed and an item diary is added to inventory.

Functions
---------

This is the list of functions which are currently supported.

### If
`&if(expression) { code }`

Conditionally executes code.

+ The *expression* consists of items / page ids and logical operators |, & and !. It can also contain braces. The items evaluate to true if they are in itinerary and to false otherwise (analogously for page ids).
+ The *code* is executed if the *expression* evaluates to true.

### Add
`&add(item)`

Adds the item *item* to itinerary

### Remove
`&remove(item)`

Removes the item *item* from itinerary

### Title
`&title(text, id)`

Adds a title with text *text* and ads a visited page with id *id* to the itinerary.

### Option
`&option(text) { code }`

Displays a clickable button.

+ *Text* is displayed on the button.
+ When clicked the button navigates to a new page described by *code*.

Encoding
--------
The code to the QR codes should be encoded before the QR code is created. It can be done using the `encode.py` script.

This serves two reasons:

+ The final code cannot be read by humans easily. Otherwise the children could just scan the code with other qr code scanner and see even text they shouldn't have access to. Note however that this is not a secure cipher and anyone with a little knowledge in cryptography might be able to hack it.
+ Numbers occupy less space than complicated text in qr codes. Thanks to the encoding it is possible to pass longer codes to the qr code.

Despite being very effective in space, the encoding has its drawbacks.

+ It was designed to cover only characters used in czech text. Other characters may be passed as well and the parser will handle it, but the space effectiveness disappears.
+ This is the reason why some key characters may seem a bit arbitrary (such as the pipe used for escaping).

The alphabet and the key characters can be changed in the `parser.dart` file if needed.

Note
----
There are cases where code written in different way than described above might work as well. Examples are providing a non-encrypted code or passing the code in `if` as another arguement in round braces.

We did not restrict these as they might be handy in some special cases, but be aware that in some cases they will cause the parser to parse the code incorrectly and in order to distinguish these cases it might be needed to have a look at the implementation of the parser.

How to use the app
==================

The app was developed by @composerPigeon and @GordonHoklinder. Many thanks to @Keiky and @Yokto13 for their advice and help.

It can be used freely. If one finds it sufficient as it is, the app can be downloaded from Play Store as QR Adventure by publisher Whizzmot at https://play.google.com/store/apps/details?id=com.whizzmot.qr_adventure_game (available in Czech Republic only at this moment) and the only thing left to do is prepare the QR codes. If there are some features missing, feel free to raise an issue or create a pull request. Additionally one can fork the repositary and publish it themself.
