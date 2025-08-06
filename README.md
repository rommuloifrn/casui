# casui

![](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)

FOSS workout app focused on calisthenics enthusiasts.

## How to run

If on linux:

    apt install sqlite3 libsqlite3-dev

If on Windows, i presume you would install SQLite3 normally.

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
