# "☆Star-Star☆" Archetype in EDOPro
This repository is for "☆Star-Star☆" custom cards in EDOPro. The original cards are from [Omegaplayer00](https://www.deviantart.com/omegaplayer00)

## Installation

### Repository-based installation

Open the following files:

```
path-to-edopro/config/configs.json
```

You will see a list of repository there, like so:

```json
{
	"repos": [
		{
			"url": "https://github.com/ProjectIgnis/DeltaPuppetOfStrings",
			"repo_name": "Project Ignis updates",
			"repo_path": "./repositories/delta-puppet",
			"has_core": true,
			"core_path": "bin",
			"data_path": "",
			"script_path": "script",
			"should_update": true,
			"should_read": true
		},
		{
			"url": "https://github.com/ProjectIgnis/LFLists",
			"repo_name": "Forbidden & Limited Card Lists",
			"repo_path": "./repositories/lflists",
			"lflist_path": ".",
			"should_update": true,
			"should_read": true
		},
		{
			"url": "https://github.com/ProjectIgnis/Puzzles",
			"repo_name": "Project Ignis puzzles",
			"repo_path": "./puzzles/Canon collection",
			"should_update": true,
			"should_read": true
		}
	],
    ...
}
```
