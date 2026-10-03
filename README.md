# Tow Money System

Earn money while towing vehicles in FiveM with ESX.

## Features

- Track towing distance and calculate earnings
- Configurable base price and distance multiplier
- Database logging of towing jobs

## Requirements

- FiveM server with ESX framework
- MySQL database

## Installation

1. Download the script files
2. Place them in your FiveM server's resources folder
3. Add `start towMoneySystem` to your server.cfg
4. Run the database.sql file to create the necessary table

## Usage

- Players can start towing by entering a vehicle and pressing E
- The script will track the distance traveled and display earnings
- Earnings are deposited into the player's bank account

## Configuration

The script can be configured in the `config.lua` file:

```lua
Config = {}

-- Towing settings
Config.TowPrice = 500 -- Base price for towing a vehicle
Config.TowMultiplier = 1.5 -- Multiplier for towing distance

-- Database settings
Config.DatabaseName = 'tow_money_system'

-- Vehicle settings
Config.TowableVehicles = {
    'adder',
    'banshee',
    'bullet',
    'cheetah',
    'entityxf',
    'fmj',
    'infernus',
    'reaper',
    't20',
    'turismor',
    'vacca',
    'voltic'
}
```

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=tow-money-system&utm_content=bottom) — describe it in one sentence and get the full source code.
