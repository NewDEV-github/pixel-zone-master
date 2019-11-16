# Godot ADB Helper
This is a helpful plugin to streamline the process of maintaining wireless ADB connections to devices.

## Configuring Godot Android builds
Please see [this documentation](https://docs.godotengine.org/en/latest/getting_started/workflow/export/exporting_for_android.html) to learn more.

## Configuring Wireless ADB debugging
The general information regarding how this works [can be found here](http://codetuto.com/2016/06/godot-engine-remote-debug-live-edit/). Please note that I am not associated with this site in any way.
TODO: Move the information into this readme!

## How to use

### Installation
1. Install this Plugin into `~PROJECT/addons/adb_helper`
    - The AssetLib should do this by default
1. Activate the Plugin
    - `Project->Project Settings->Plugins`

### Initial Usage
If this is the first time you've set this up you'll need to follow these steps.
1. Set up your [Android Export](https://docs.godotengine.org/en/latest/getting_started/workflow/export/exporting_for_android.html) if you haven't already
1. Connect the device via USB
1. Get the device's IP address
1. Use the Plugin
    - It'll be in the top-right corner ![The Plugin's icon](./icon.png)
1. Add your device by giving it a name and the IP
1. Connect to the device!

### Reconnecting
Once your device is setup, you can now connect to it at any time. If you ever lose connection, you can simply hit the plugin again and have it reconnect.

***HOWEVER!***

If your device reboots, it will lose the wireless connection. You'll need to re-establish the connection by plugging the device back into the machine via USB and connecting. Once the wireless connection has been established, you can disconnect the device and utilize ADB wirelessly again!
