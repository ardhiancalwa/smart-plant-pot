"use client";

import { useEffect, useState } from "react";
import MobileLayout from "@/components/MobileLayout";
import { ArrowLeft, Save } from "lucide-react";
import Link from "next/link";
import { motion } from "framer-motion";

export default function Settings() {
  const [waNumber, setWaNumber] = useState("");
  const [telegramBot, setTelegramBot] = useState("");
  const [saved, setSaved] = useState(false);

  useEffect(() => {
    // Load from localStorage
    const storedWa = localStorage.getItem("waNumber");
    const storedTg = localStorage.getItem("telegramBot");
    if (storedWa) setWaNumber(storedWa);
    if (storedTg) setTelegramBot(storedTg);
  }, []);

  const handleSave = () => {
    localStorage.setItem("waNumber", waNumber);
    localStorage.setItem("telegramBot", telegramBot);
    setSaved(true);
    setTimeout(() => setSaved(false), 2000);
  };

  return (
    <MobileLayout>
      <div className="flex flex-col gap-6 pt-4">
        {/* Header */}
        <div className="flex items-center gap-4">
          <Link
            href="/"
            className="p-2 rounded-full bg-glass-bg hover:bg-white/10 transition"
          >
            <ArrowLeft size={20} className="text-gray-400" />
          </Link>
          <h1 className="text-2xl font-bold text-white">Settings</h1>
        </div>

        {/* Form */}
        <div className="flex flex-col gap-6 mt-4">
          <div className="space-y-2">
            <label className="text-sm text-gray-400 uppercase tracking-wide">
              WhatsApp Number
            </label>
            <input
              type="text"
              placeholder="e.g. 628123456789"
              value={waNumber}
              onChange={(e) => setWaNumber(e.target.value)}
              className="w-full bg-glass-bg border border-glass-border rounded-xl p-4 text-white focus:outline-none focus:border-primary/50 placeholder:text-gray-600"
            />
            <p className="text-xs text-gray-500">
              Include country code without '+' (e.g. 62...)
            </p>
          </div>

          <div className="space-y-2">
            <label className="text-sm text-gray-400 uppercase tracking-wide">
              Telegram Bot Username
            </label>
            <input
              type="text"
              placeholder="e.g. MyPlantBot"
              value={telegramBot}
              onChange={(e) => setTelegramBot(e.target.value)}
              className="w-full bg-glass-bg border border-glass-border rounded-xl p-4 text-white focus:outline-none focus:border-primary/50 placeholder:text-gray-600"
            />
          </div>

          <motion.button
            whileTap={{ scale: 0.95 }}
            onClick={handleSave}
            className={`
              mt-8 w-full py-4 rounded-xl font-bold text-lg tracking-wide shadow-lg
              flex items-center justify-center gap-2
              transition-all duration-300
              ${
                saved
                  ? "bg-green-500 text-black"
                  : "bg-primary text-black hover:bg-primary/90"
              }
            `}
          >
            <Save size={20} />
            {saved ? "SAVED!" : "SAVE SETTINGS"}
          </motion.button>
        </div>
      </div>
    </MobileLayout>
  );
}
