# PD (PagerDuty scheduler)

PD is a tool to generate a PagerDuty schedule shared between teams.  It's
created to solve very specific problem that I have at Babbel. That means the
tool might not be useful for anyone else. However it still might work as an
inspiration.

Teams build their monthly PageDuty schedules, and I use pd to generate a special schedule for services shared between these teams.

## Usage

### How to generate a shared monthly schedule

1. Save teams schedules in separate plain text files.
2. To generate a shared schedule and copy it into the clipboard run:
   ```shell
   bin/csviser data/<YYYY>-<MM>/*.txt \
   | bin/schedule YYYY-MM \
   | xsel --clipboard`
   ```

### How to create team schedule files

Team schedules come from teams and usually simply shared on Slack as messages. To make use of them they need to be stored in the `data` directory.

Example (a schedule for May 2022 for the ALPHA team):

```
# data/2022-05/alpha.txt
1 Alice
2 Bob
```

**TIP:** Copy a team schedule from Slack into the clipboard, then run the following command to store the schedule into a file:

```shell
xclip -o > data/<YYYY>-<MM>/<TEAM>.txt
```

### How to generate a monthly calendar

```
cat data/holidays/<YEAR>.csv \
| bin/calendar <YEAR>-<MONTH>
```

**TIP:** because December 31 and January 1 are holidays, it's better to provide data for the current and next years. Otherwise the type of day might not be detected correctly for these two days.

Example:

```
cat data/holidays/2024.csv data/holidays/2025.csv \
| bin/calendar 2024-12
```

Holiday data is stored in CSV files in the following format:

```
DATE,TYPE,"COMMENT"
```

`TYPE` is a one character identified for a day type. The following values are supported:

- `F`: a full-day holiday
- `H`: a half-day holiday

Example:

```csv
2024-01-01,F,"Neujahr"
2024-03-08,F,"Internationaler Frauentag"
2024-03-29,F,"Karfreitag"
```

## License

See [LICENSE](LICENSE).
