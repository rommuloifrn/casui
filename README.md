# casui

![](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)

FOSS workout app focused on calisthenics enthusiasts.

## Models

```mermaid
classDiagram
direction LR
    class Workout {
        id: int
        title: String
        description: String
        circuits: int
        useSets: bool
    }

    Workout "1" -- "*" Execution

    class Execution {
        start: DateTime
        end: DateTime
    }
```
