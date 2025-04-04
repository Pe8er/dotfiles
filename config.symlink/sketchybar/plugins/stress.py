# https://github.com/matin/garth

try:
  import garth
except ImportError:
  print("garth module is not installed. Please install it using 'pip install garth'.")
  exit(1)
from garth.exc import GarthException
from getpass import getpass

garminCredentials = "/Users/pe8er/.garmin-credentials"

try:
  garth.resume(garminCredentials)
  garth.client.username
except (FileNotFoundError, GarthException):
  email = input("Email: ")
  password = getpass("Password: ")
  garth.client.login(email, password)

garth.save(garminCredentials)

from datetime import date
dailyStress = garth.DailyStress.list(date.today())[0].overall_stress_level
weeklyStress = garth.WeeklyStress.list(date.today())[0].value
# test = garth.DailySteps.list(period=2)

# print(dailyStress)

if dailyStress:
  stressData = print(f"{dailyStress}/{weeklyStress}")
else:
  stressData = print("N/A")