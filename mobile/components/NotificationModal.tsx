"use client";

import { useEffect, useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { X, Send } from "lucide-react";
import { sendAlert } from "@/lib/notificationService";
import { usePlantSensor } from "@/hooks/usePlantSensor";

export default function NotificationModal() {
  const { showNotificationAlert, dismissNotification, moisture } =
    usePlantSensor();
  const [waNumber, setWaNumber] = useState("");
  const [telegramBot, setTelegramBot] = useState("");

  useEffect(() => {
    // Load settings for contact info
    const storedWa = localStorage.getItem("waNumber");
    const storedTg = localStorage.getItem("telegramBot");
    if (storedWa) setWaNumber(storedWa);
    if (storedTg) setTelegramBot(storedTg);
  }, []);

  const handleSend = (channel: "whatsapp" | "telegram") => {
    const message = `🚨 CRITICAL ALERT: Plant moisture is at ${moisture.toFixed(
      0
    )}%! Please water immediately.`;
    const contact = channel === "whatsapp" ? waNumber : telegramBot;

    if (contact) {
      sendAlert(channel, message, contact);
      dismissNotification(); // Close after sending
    } else {
      alert(`Please configure your ${channel} details in Settings first!`);
    }
  };

  return (
    <AnimatePresence>
      {showNotificationAlert && (
        <div className="fixed inset-0 z-50 flex items-center justify-center px-4 bg-black/80 backdrop-blur-sm">
          <motion.div
            initial={{ scale: 0.9, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0.9, opacity: 0 }}
            className="w-full max-w-sm bg-[#1a1a1a] border border-red-500/50 rounded-2xl p-6 shadow-[0_0_50px_rgba(239,68,68,0.3)]"
          >
            <div className="flex justify-between items-start mb-4">
              <h2 className="text-xl font-bold text-red-500 flex items-center gap-2">
                <span className="animate-pulse">🚨</span> PLANT CRISIS!
              </h2>
              <button
                onClick={dismissNotification}
                className="text-gray-400 hover:text-white"
              >
                <X size={24} />
              </button>
            </div>

            <p className="text-gray-300 mb-6">
              Moisture has dropped to{" "}
              <strong className="text-red-400">{moisture.toFixed(0)}%</strong>.
              Your plant needs help immediately.
            </p>

            <div className="flex flex-col gap-3">
              <button
                onClick={() => handleSend("whatsapp")}
                className="w-full py-3 rounded-xl bg-green-600 hover:bg-green-500 text-white font-bold flex items-center justify-center gap-2 transition-colors"
              >
                <Send size={18} /> Alert via WhatsApp
              </button>

              <button
                onClick={() => handleSend("telegram")}
                className="w-full py-3 rounded-xl bg-blue-500 hover:bg-blue-400 text-white font-bold flex items-center justify-center gap-2 transition-colors"
              >
                <Send size={18} /> Alert via Telegram
              </button>

              <button
                onClick={dismissNotification}
                className="w-full py-3 rounded-xl bg-white/5 hover:bg-white/10 text-gray-400 text-sm mt-2 transition-colors"
              >
                I'm handling it locally
              </button>
            </div>
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  );
}
