# 💸 Money Laundering Script for FiveM

A flexible and configurable money laundering system for FiveM using `ox_lib`, supporting both `QBCore` and `ESX` frameworks.

## ✨ Features

- ✅ Auto-detect QBCore or ESX framework
- ✅ Auto-detect ox_target or qb-target
- ✅ Support for multiple inventories: ox_inventory, qb-inventory, qs-inventory
- ✅ Choose between ped or prop for laundering interaction
- ✅ Progress bar with animation using ox_lib
- ✅ Laundering time based on money amount (5s per 10,000)
- ✅ Full server-side validation and anti-exploit logic

## ⚙️ Configuration

Edit everything in `config.lua`:
```lua
Config.UsePed = true -- true = ped, false = prop
Config.Inventory = 'ox' -- or 'qb', 'qs'
Config.MinAmount = 10000
Config.MaxAmount = 500000
Config.BaseRate = 5000 -- 5 seconds per 10k
````

You can also change the NPC model, animation, location, and more!

## 🔧 Installation

1. Download or clone this repo into your `resources` folder.
2. Add to your `server.cfg`:

```
ensure moneylaunder
```

3. Make sure you have:

   * `ox_lib`
   * One of: `ox_inventory`, `qb-inventory`, `qs-inventory`
   * One of: `ox_target`, `qb-target`
   * Framework: QBCore or ESX
