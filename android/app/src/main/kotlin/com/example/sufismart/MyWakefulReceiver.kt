  package com.example.sufismart

  import android.content.Context
  import android.content.Intent
  import android.util.Log
  import androidx.legacy.content.WakefulBroadcastReceiver


  @Suppress("DEPRECATION")
  class MyWakefulReceiver : WakefulBroadcastReceiver() {

        override fun onReceive(context: Context, intent: Intent) {
            Log.d("masuk sini juga", "onReceive: ")
            // Start the service, keeping the device awake while the service is
            // launching. This is the Intent to deliver to the service.
//            Intent(context, MyIntentService::class.java).also { service ->
//                WakefulBroadcastReceiver.startWakefulService(context, service)
//            }
        }


    }