#  Colombian fruits app

## Short gifs showing app functionalities

Beggining carousel:

![](GifsDemo/Carousel.gif)

Dashboard home - fruit list:

![](GifsDemo/FruitList.gif)

Tooltip that shows each fruit description:

![](GifsDemo/Tooltip.gif)

## Code structure:

Uses a modular architecture

        .
        ├── Assets.xcassets
        ├── Common
        │   ├── Constants.swift
        │   └── Extensions.swift
        ├── Features
        │   ├── Home
        │   │   ├── HomeView.swift
        │   │   └── HomeViewModel.swift
        │   │   └── HomeCoordinator.swift
        │   └── Carousel
        │       ├── CarouselView.swift
        │       └── CarouselViewModel.swift
        │       └── CarouselCoordinator.swift
        ├── Models
        │   └── User.swift
        └── Utils
            └── Networking.swift
            └── Storage.swift
            

