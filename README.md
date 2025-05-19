# ☆Star-Star☆ for EDOPro

Welcome to the "☆Star-Star☆" archetype custom cards repository for EDOPro. These cards, created by [Omegaplayer00](https://www.deviantart.com/omegaplayer00), can be integrated into your EDOPro game.

## Installation

### Repository-based Installation

To install via repository, follow these steps:

1. Open the `user-configs.json` file located in:
   ```
   path-to-edopro/config/user-configs.json
   ```
   If this file does not exist, create one. The file should be structured as shown below:
   ```json
   {
       "repos": [
           {
               "url": "github_link_here",
               "repo_name": "name_that_will_be_used_in_edopro's_repository_list",
               "repo_path": "path_where_the_contents_will_be_saved",
               "should_update": true,
               "should_read": true
           }
       ]
   }
   ```

2. Append the following lines to the `repos` list:
   ```json
   {
       "url": "https://github.com/tiendatbinhan/star-star-edopro-cc.git",
       "repo_name": "☆Star-Star☆ for EDOPro",
       "repo_path": "./repositories/star-star-edopro-cc",
       "should_update": true,
       "should_read": true
   }
   ```

For additional instruction, refer to Naim's instructions [here](https://github.com/ProjectIgnis/CardScripts/wiki/2-%E2%80%90-Required-programs-and-enviroment-setup).

### Local Installation

To install locally:

1. Clone the repository.
2. Archive the `pics`, `script`, `strings.conf`, and `cc-starstar-from-omegaplayer.cdb` files into a `.zip` file.
3. Move the `.zip` file to the following directory:
   ```
   path-to-edopro/expansions
   ```

## Bug Reporting

If you encounter any bugs with the cards, please open an issue on this repository. We appreciate your feedback and contributions to improve the experience.
