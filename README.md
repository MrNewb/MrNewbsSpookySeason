# MrNewb's Spooky Season

Halloween event: ghost hunts, pumpkin searches, grave digging, trick-or-treat, decorations, and an event-token shop.

[Documentation](https://mrnewb.github.io/docs/mrnewbspookyseason) · [Install guide](https://mrnewb.github.io/docs/mrnewbspookyseason/install) · [Tebex](https://mrnewbscripts.tebex.io/) · [Discord](https://discord.gg/mrnewbscripts) · [Preview](https://www.youtube.com/watch?v=hi4yJjPZ7RE)

[![MrNewbSpookySeason preview](https://img.youtube.com/vi/hi4yJjPZ7RE/hqdefault.jpg)](https://www.youtube.com/watch?v=hi4yJjPZ7RE)

<img width="1920" alt="Spooky Season" src="https://github.com/user-attachments/assets/f26c2bbd-2d8f-40a7-8cec-2c5360a57c15" />
<img width="1920" alt="Spooky Season shop" src="https://github.com/user-attachments/assets/f224813f-d213-40d7-9c9c-6ea3bf0e7e3f" />
<img width="1920" alt="Spooky Season hunt" src="https://github.com/user-attachments/assets/711a0e5f-6a48-4f37-97db-dd044919132a" />

## Features

- Pumpkin searches, grave digging, and trick-or-treat door knocks
- Ghost hunts (needs [pengu_digiscanner](https://github.com/PenguScript/pengu_digiscanner))
- Event-token shop (`pumpkin_basket` / `rotten_casket`, optional digiscanner)
- Usable crates that roll their own loot tables
- Optional Halloween weather around shops
- Seasonal decorations as spawned props
- Loot tables and scavenger coords stay in the **server-only** `sv_config`

## Install

Needs [ox_lib](https://github.com/overextended/ox_lib) and [Newb_Bridge](https://github.com/MrNewb/Newb_Bridge). Keep the folder named `MrNewbsSpookySeason`. Items, images, and start order: [install guide](https://mrnewb.github.io/docs/mrnewbspookyseason/install).

```cfg
ensure ox_lib
ensure Newb_Bridge
ensure pengu_digiscanner
ensure MrNewbsSpookySeason
```

`pengu_digiscanner` is only required for ghost hunts. Pumpkins, graves, trick-or-treat, shops, and crates still run without it.

Copy `[INSTALL]/images/` into your inventory images folder. Register `event_token`, `candy_corn`, `chocolate_bar`, `pumpkin_basket`, and `rotten_casket`. Do not add `server.export`.

## Config

| File | Contents |
| --- | --- |
| `configs/config.lua` | Weather toggle, trick-or-treat blips, shops, decorations |
| `configs/sv_config.lua` | Server-only loot pools and scavenger locations |

Field tables: [documentation](https://mrnewb.github.io/docs/mrnewbspookyseason).
