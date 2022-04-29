# PD (PagerDuty scheduler)

PD is a tool to generate a PagerDuty schedule shared between teams.  It's
created to solve very specific problem that I have at Babbel. That means the
tool might not be useful for anyone else. However it still might work as an
inspiration.

Teams build their monthly PageDuty schedules, and I use pd to generate a
special schedule for services shared between these teams.

## Usage

1. Save teams schedules in separate plain text files.
2. To generate a shared schedule and copy it into the clipboard run:
   ```shell
   bin/csviser data/<YYYY>-<MM>/*.txt \
   | bin/schedule YYYY-MM \
   | xsel --clipboard`
   ```

### How to create team schedule files

Team schedules come from teams and usually simply shared on Slack as
messages. To make use of them they need to be stored in the `data` directory.

Example (a schedule for May 2022 for the ALPHA team):

```
# data/2022-05/alpha.txt
1 Alice
2 Bob
```

### Tip

Copy a team schedule from Slack into the clipboard, then run the following
command to store the schedule into a file:

```shell
xclip -o > data/<YYYY>-<MM>/<TEAM>.txt
```

## License

See [LICENSE](LICENSE).
