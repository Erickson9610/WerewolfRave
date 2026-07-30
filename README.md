## This Add-on is not created by, affiliated with or sponsored by ZeniMax Media Inc. or its affiliates. The Elder Scrolls® and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the United States and/or other countries. All rights reserved.

# Features

Werewolf Rave (WWR) is an addon for The Elder Scrolls Online which allows you automatically change your character's Werewolf form fur color.

This addon will automatically search for new Werewolf Form Skill Styles that may be added to the game in future updates, then reference those styles in a list.
Once you unlock a style, you will be able to add it to your Style Sequence list.

## Activation Methods

- While Transformed (/wwr auto): Continuously changes your fur color while you are transformed.
- When Reverting Form (/wwr tf): Changes your fur color when you revert form, so you can look different when you transform again.

## Settings

- Selection Method (/wwr random)
    - Randomized (true): Treats the Style Sequence as a list of weighted probabilities.
    - Sequential (false): Treats the Style Sequence as the order to iterate through.
- Allow Changes In Combat (/wwr combat): If true, styles may be equipped while you are in combat.
- Allow Disable Styles (/wwr duplicates): If true, styles may re-equip while already equipped, toggling them off and showing the fur color for your morph of Werewolf Transformation.
- Frequency (/wwr frequency): The interval in seconds between style changes in the continuous activation mode. Range [2, 60].
- In-Combat Frequency (/wwr cfrequency): The interval in seconds between style changes while in combat in the continuous activation mode. Range [2, 60].

## Editing the Style Sequence

If you also have the LibAddonMenu-2.0 addon installed, you can use the /wwrui slash command to edit these settings with a visual GUI.
Alternatively, you may use the following /wwr slash commands to create, read, update, and delete entries in the Style Sequence.

- /wwr idtable
    - Prints out the list of every Werewolf Form Skill Style currently in the game, in this order:
    - <collectibleName>, <collectibleId>, <isCollected>
- /wwr getlist
    - Prints out your current Style Sequence list, in this order:
    - <index>, <name>, <collectibleId>
- /wwr setlist <index> <collectibleId>
    - Used for manipulating the Style Sequence. Handles adding, changing, and removing elements.
    - /wwr setlist new <collectibleId>
        - Inserts a new element at the end of the list.
    - /wwr setlist <index> <collectibleId>
        - Replaces the value at position <index> in the Style Sequence with <collectibleId>
    - /wwr setlist new nil
        - Removes the last element of the list.

# Installation

To install this addon to the Live server, put the folder containing the .lua files in the "\Elder Scrolls Online\live\AddOns\" directory.