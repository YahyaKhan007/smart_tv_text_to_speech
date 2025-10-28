package com.example.tv_project

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log

class BootLaunchService : Service() {
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("BootLaunchService", "Starting MainActivity...")

        val launchIntent = Intent(this, MainActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
            addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT)
        }

        startActivity(launchIntent)
        stopSelf() // stop service after launching app
        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
