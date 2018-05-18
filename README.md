Timer
===============



## How timer is managed in background mode.


- You are able to manage timer in background mode to using follwing code in applicationDidEnterBackground function of AppDelegate.swift file.
- Below code will make sure that our application works in bakground mode.

    var taskId = UIBackgroundTaskIdentifier()
    taskId = application.beginBackgroundTask(expirationHandler: {() -> Void in
        taskId = UIBackgroundTaskInvalid
    })
