Name: Aditi Anmol, Red ID: 825900498
Name: Jainam Sheth, Red ID: 825867036
# WakeMeUp

An Alarm mobile application made using SwiftUI.
You can add new alarms, edit existing alarm, toggle the active state of the alarm, delete alarms which are the basic things which you could do with an alarm app.
On top of that, this app has a unique way to stop the alarm - by making user do some mission. The mission which we choose for this application is that the user will have to do some activity for a specified duration (selected while adding the alarm). At time of the alarm, a notification will popup with the selected Sound playing in the background. User needs to click on the notification and the Activity view will show up to either snooze or stop the alarm. If the user chooses to stop the alarm then he will have to complete the activity for a specified duration and then will be redirected to the home page of the application.

# Installation Steps
Once the code is in local, open in xcode and click on to run on either a simulator or an actual device.

If the build fails, it may be because the current team/developer is not trusted or identified. To fix this:
Double Click on Project Folder in xcode -> go to Signing and Capabilities tab -> update the team name and then build again

Once the application is installed on the device, you need to Trust the application or the developer for the appkication to run. To do this:
Go to settings -> VPN -> Trust the 'WakeMeUp' application

Another important thing to note is that, user will have to click on Allow notifications which is asked for first time users. If notifications are not allowed then the application won't work correctly.

We need to select the current day for the alarm to trigger on that day itself. If none of the day is selected then that alarm won't ring anytime. (also included this in issues)

# Issues
1. When the phone is not locked, the notification pops at the specified alarm time and the Music is played in the background. However, the music stops as soon as the pop up goes away (probably music only plays for 3-5 seconds)
2. When the phone is locked, the notification pops at the specified alarm time and the Music is played in the background. However, the music stops after sometime of playing or when we try to unlock the phone.
3. The application doesn't make it compulsory for the user to always complete the activity to stop the alarm. If the user clears the notification then the activity screen is not shown.
4. Snooze alarm is not implemented. The function is left blank.
5. We need to select the current day for the alarm to trigger on that day itself. If none of the day is selected then that alarm won't ring anytime.
6. If the user selected activity Duration as '0 min', then the activity page goes in a loop and we are not able to stop the alarm.
