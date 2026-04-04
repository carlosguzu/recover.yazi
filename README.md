# recover.yazi

Restore deleted files from your system Trash directly within Yazi (like a Recycle Bin on Mac or Windows).
This plugin reads standard FreeDesktop `.trashinfo` metadata to intelligently move files back to their exact original locations.

## Features

  - Native visual confirmation dialog before restoring files.
  - Automatically parses `.trashinfo` files to find the exact original path.
  - Handles URL-encoded paths seamlessly (preserves spaces and special characters).
  - Built-in safety checks: warns you if you try to run it outside of the Trash directory.
  - Cleans up orphaned `.trashinfo` metadata files automatically after a successful restore.
  - Uses Yazi's native asynchronous API to keep the interface fast and responsive.

## Requirements

  - Yazi installed on your system.
  - A Linux environment utilizing the standard FreeDesktop Trash specification (typically located at `~/.local/share/Trash`).

## Installation

### Using Git

Clone the repository directly into your Yazi plugins directory (or create the folder and add your `main.lua`):

```sh
git clone https://github.com/carlosguzu/recover.yazi.git ~/.config/yazi/plugins/recover.yazi
```


## Usage

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[[manager.prepend_keymap]]
on   = [ "R" ]
run  = "plugin recover"
desc = "Recover deleted file to original location"
```

Make sure the \<kbd\>R\</kbd\> key combination (or whichever key you choose, like \<kbd\>ctrl\</kbd\> + \<kbd\>r\</kbd\>) is not used elsewhere.

## How to Use

1.  Open Yazi and navigate to your Trash directory (`~/.local/share/Trash/files` or your `~/Trash/files` symlink).
2.  Hover over the deleted file you wish to restore.
3.  Press \<kbd\>R\</kbd\> (or your configured hotkey) to activate the plugin.
4.  A confirmation dialog will appear showing you the exact original path where the file will be restored.
5.  Press \<kbd\>Enter\</kbd\> to confirm. The file will be moved, the trash info will be cleaned up, and you'll receive a success notification. (in case you are not in the files folder Trash, you will receive a warning).

## License

This plugin is MIT-licensed.
