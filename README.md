# Vehicle Dashboard Menu Control Program in x86 Assembly

## Overview

This project is an x86 Assembly program designed to manage a vehicle's dashboard menu. The menu allows the user to view and set the following information:

- Date
- Time
- Automatic door lock setting
- Back-home function
- Oil check

If accessed in supervisor mode, the menu will also allow the user to set:

- Highway mode blinkers
- Tire pressure reset

## Specifications

The program can be run in two modes:

- **User mode**: Run by executing the program from the command line.
- **Supervisor mode**: Run by executing the program followed by the code `2244` (e.g., `program.exe 2244`).

### User Mode

In user mode, the program displays the following menu, one line at a time, starting from the first line and moving to the next by pressing the down arrow key, and selecting options with the Enter key. Scrolling past the last line loops back to the first.

1. Setting automobile:
2. Date: 15/06/2014
3. Time: 15:32
4. Automatic door lock: ON
5. Back-home: ON
6. Oil check

### Supervisor Mode

In supervisor mode, the program displays the first line as:

1. Setting automobile (supervisor):

And includes the following additional menu options:

7. Highway mode blinkers
8. Tire pressure reset

### Submenu Navigation

For each displayed menu option, pressing the right arrow key followed by Enter allows access to the corresponding submenu, where the current setting is shown and can be changed.

- For example, in the "Automatic door lock: ON" menu, pressing the right arrow key followed by Enter allows the user to toggle the setting between ON and OFF using the up/down arrow keys and pressing Enter.

Only the submenus for options 4 and 5 need to be implemented, with ON/OFF settings as shown above. Submenus for options 2, 3, and 6 are not required to be implemented.

Pressing Enter within any submenu returns the user to the main menu.

### Additional Features in Supervisor Mode

- **Highway Mode Blinkers**: This submenu shows the number of blinks (default is 3) and allows the user to adjust the value between 2 and 5. Input outside this range defaults to the minimum or maximum value.
- **Tire Pressure Reset**: In this submenu, pressing the right arrow key followed by Enter resets the tire pressure and displays the message "Tire pressure reset," then returns to the main menu.


