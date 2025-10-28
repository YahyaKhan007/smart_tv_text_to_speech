package com.example.tv_project

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.Looper
import android.util.Log

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        Log.d("BootReceiver", "Received intent: ${intent?.action}")

        if (intent?.action == Intent.ACTION_BOOT_COMPLETED ||
            intent?.action == "com.example.tv_project.TEST_BOOT") {

            Log.d("BootReceiver", "Boot completed! Scheduling app launch...")

            Handler(Looper.getMainLooper()).postDelayed({
                try {
                    val launchIntent = Intent(context, MainActivity::class.java).apply {
                        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                        addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
                        addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT)
                    }
                    context?.startActivity(launchIntent)
                    Log.d("BootReceiver", "MainActivity launched successfully ✅")
                } catch (e: Exception) {
                    Log.e("BootReceiver", "Failed to launch MainActivity: ${e.message}")
                }
            }, 5000) // wait 5 seconds after boot
        }
    }
}
