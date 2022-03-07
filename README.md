# Jap Vocabs

[![release](https://github.com/Darklod/jap-vocabs/workflows/release/badge.svg?branch=master)](https://github.com/Darklod/jap-vocabs/actions?query=workflow%3Arelease)
[![dev](https://github.com/Darklod/jap-vocabs/workflows/dev/badge.svg?branch=develop)](https://github.com/Darklod/jap-vocabs/actions?query=workflow%3Adev)
[![codecov](https://codecov.io/gh/Darklod/jap-vocabs/branch/develop/graph/badge.svg?token=C4RT80DY1S)](https://codecov.io/gh/Darklod/jap-vocabs)
[![Flutter version](https://img.shields.io/badge/flutter-v1.22.2-blue?logo=flutter)](https://flutter.dev/docs/development/tools/sdk/releases)
[![style: pedantic](https://img.shields.io/badge/style-pedantic-00b4ab.svg)](https://pub.dev/packages/pedantic)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FDarklod%2Fjap-vocabs.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2FDarklod%2Fjap-vocabs?ref=badge_shield)

## Screenshots

Vocabulary List   |  Sorting |  Filtering 
:----:|:---:|:--------:
![](screenshots/Screenshot_2022-03-07-14-26-10-981_com.darklod.jap_vocab.jpg) | ![](screenshots/Screenshot_2022-03-07-14-26-27-894_com.darklod.jap_vocab.jpg) | ![](screenshots/Screenshot_2022-03-07-14-26-33-879_com.darklod.jap_vocab.jpg)

 Review Page | Review Item | Legend | Summary
:----:|:---:|:--------:|:--------:
![](screenshots/Screenshot_2022-03-07-14-30-04-172_com.darklod.jap_vocab.jpg) | ![](screenshots/Screenshot_2022-03-07-14-26-49-236_com.darklod.jap_vocab.jpg) | ![](screenshots/Screenshot_2022-03-07-14-26-54-494_com.darklod.jap_vocab.jpg) | ![](screenshots/Screenshot_2022-03-07-14-29-46-418_com.darklod.jap_vocab.jpg) |

## To Do

- [ ] Notifications
- [x] Sorting
- [x] Filter
- [ ] Statistics Page
- [ ] Remove, Update examples
- [ ] Automatic Backups
- [ ] Language localization
- [ ] Redesign Add/Edit Page

## Folder Structure

```
lib
├── components                # Common widgets shared between pages
├── database                  # Database configuration and Dao classes
├── models                    # Models
├── pages                     # Page widgets
│   ├─ home                   
│   │  ├── components         # Local widgets used only in the home page
│   │  └── home.dart          
│   ├─ details
│   └─ ...
├── redux                     # Redux folders
│   ├─ actions                
│   ├─ reducers               
│   ├─ state                  
│   ├─ thunk                  
│   └─ store.dart
├── utils                     # Common functions
├── main.dart
└── routes.dart               # Contains the routes and imports all pages.
```

