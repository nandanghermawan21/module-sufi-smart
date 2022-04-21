    package com.example.sufismart

    import android.app.IntentService
    import android.app.NotificationManager
    import android.content.BroadcastReceiver
    import android.content.Context
    import android.content.Intent
    import android.os.Bundle
    import android.util.Log
    import androidx.core.app.NotificationCompat


    const val NOTIFICATION_ID = 1

    private const val TAG = "MyIntentService"

    class MyIntentService : BroadcastReceiver() {

        override fun onReceive(context: Context, intent: Intent) {
            Log.d(TAG, "onReceive: masuk sini cuy")
        }
    }
    