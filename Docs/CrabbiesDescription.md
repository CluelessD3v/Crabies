## Zombie Horde mini-project
Example mini project to test the capabilities of "Cracker". 
The game will be called Crabies (Cracker and Zombie put together... I know, so imaginative :P)

## Project Description
Here is a smoll eye catchy description ;)

```
They are everywhere!!! Survive the endless onslaught of the undead... How long will you last?
```

### Game Loop
The game loop is simple:

1. *When the player spawns the game inmediately prompts him with a shop to buy upgrades* (and maybe a tutorial every time it joins the game before the first round). *The player might decide to buy weapons or upgrades and then start a new round*

2. *When the player closes the shop gui, a new round starts and zombies will start spawning.*

3. *Finally the player has to kill all the zombies to end the round.* 

Rinse and repeat
<br>

## Game Elements

Zombie behavior
- Spawns
- Makes its way to a target
- once it's near a target it will attempt to attack it
- if for some reason there is no target they'll just sit idle waiting for a target to appear

Zombie only chases valid targets, probably within a certain radius as well.









