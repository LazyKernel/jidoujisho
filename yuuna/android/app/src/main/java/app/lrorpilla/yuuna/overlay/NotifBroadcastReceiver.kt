package app.lrorpilla.yuuna.overlay

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.preference.PreferenceManager

class NotifBroadcastReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == "app.lrorpilla.yuuna.overlay.STOP_BG_SERVICE") {
            val preferences = PreferenceManager.getDefaultSharedPreferences(context)
            if (preferences.getBoolean("accessibilityServiceRunning", false)) {
                preferences.edit().putBoolean("accessibilityServiceRunning", false).apply()
            }
        }
    }
}
