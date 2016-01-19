property WeekdayText : {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}
property YoubiText : {"月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"}

on WeekdayToYoubi(day, flag)
  if flag is 0 then
    repeat with i from 1 to 7
      if item i of WeekdayText = day as text then return item i of YoubiText
    end repeat
  else if flag is 1 then
    repeat with i from 1 to 7
      if item i of WeekdayText = day as text then
        if i ≥ 7 then
          return item 1 of YoubiText
        else
          return item (i + 1) of YoubiText
        end if
      end if
    end repeat
  end if
end WeekdayToYoubi

-- TODO: 月末, 年末問題

set Y to year of (current date)
set M to (month of (current date)) * 1
set D to day of (current date)
set WD to WeekdayToYoubi(weekday of (current date), 0)
set today to my date ((Y as string) & "年" & (M as string) & "月" & (D as string) & "日" & WD & " 00:00:00")
set tomorrow to my date ((Y as string) & "年" & (M as string) & "月" & (D + 1 as string) & "日" & WD & " 00:00:00")
set TWD to WeekdayToYoubi(weekday of (current date), 1)

tell application "Calendar"
  set taskList to every event of calendar "ru6r1ckcu6e@gmail.com" whose (start date is today) and (end date is tomorrow)
  if taskList is not {} then
    set dayaftertomorrow to my date ((Y as string) & "年" & (M as string) & "月" & (D + 2 as string) & "日" & TWD & " 00:00:00")
    repeat with i from 1 to length of taskList
      set start date of item i of taskList to tomorrow
      set end date of item i of taskList to dayaftertomorrow
    end repeat
  end if
end tell