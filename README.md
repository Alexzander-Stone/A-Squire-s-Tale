# A Squire's Tale
ARPG with a focus on ability crafting to create unique playstyles. 
Game design pitch presentation can be found [here](https://docs.google.com/presentation/d/1ON4uhXwuz6inhaHWjd04_6zV-EJ59bGnnRDBTOinQX8/edit?usp=sharing).
This project is intended for Clemson's CPSC 4820: Game Design course.

## Gameplay


## Controls
Initial designs for control schemes can be found [here](https://docs.google.com/document/d/1TT2nNv_OAMtWZwmalvXUz9XKexSAGvmox7Vhtd5tcew/edit?usp=sharing).

## Testing Program

### Prerequisites
Download Godot 3.0.6 from either of the links.

* [Godot Download](https://godotengine.org/download/windows) - Godot official download page.
* [Godot Previous Releases](https://downloads.tuxfamily.org/godotengine/) - Godot official previous release list.
### Running
After installation, run the Godot game engine.

When the engine has loaded, click import and lead file path to the project.godot in the project files.

From there, click the play button in the top-corner of the program to play the game.

In case there is an issue with finding the primary scene, direct the project towards the World.tcsn in the res:// path.

## Relevant Design Principles
	
State Machines - 

* Player uses a simple FSM. Design can be found [here](https://drive.google.com/file/d/1qfA-In6oXvWRf-HElUcLaJJDhWyOMeaJ/view?usp=sharing)
	
Observor Pattern -
	
* Godot signal system used to alert objects (like Player's State Machine node) of state changes, through emitters.


## Acknowledgments

* [Nathan Lovato](http://gdquest.com/) - Godot content creator with great tutorials covering various game design topics.
