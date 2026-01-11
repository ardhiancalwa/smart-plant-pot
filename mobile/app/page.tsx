"use client";

import MobileLayout from "@/components/MobileLayout";
import Scene3D from "@/components/Scene3D"; // Replaces PlantAvatar
import MetricCard from "@/components/MetricCard";
import { Droplets, Thermometer, Wind } from "lucide-react";
import { PlantSensorProvider, usePlantSensor } from "@/hooks/usePlantSensor";
import { motion } from "framer-motion";
import NotificationModal from "@/components/NotificationModal";

function DashboardContent() {
  const {
    moisture,
    temp,
    humidity,
    emotion,
    waterPlant,
    isWatering,
    waterLevel,
    refillTank,
  } = usePlantSensor();

  const isLowWater = waterLevel < 15; // Warning Level
  const isCriticalLevel = waterLevel < 10; // Critical Action Level (Pump Disable)

  return (
    <div className="flex flex-col gap-6">
      {/* Header */}
      <div className="pt-4 flex justify-between items-end">
        <div>
          <h1 className="text-2xl font-bold bg-gradient-to-r from-white to-gray-400 bg-clip-text text-transparent">
            My Plant
          </h1>
          <p className="text-gray-400 text-sm">Welcome back, Human.</p>
        </div>
        <div className="text-right">
          <span className="text-xs uppercase tracking-widest text-primary/60">
            Live Signal
          </span>
          <div className="flex justify-end gap-1 mt-1">
            <span className="animate-pulse w-2 h-2 rounded-full bg-primary" />
            <span className="w-2 h-2 rounded-full bg-primary/30" />
            <span className="w-2 h-2 rounded-full bg-primary/10" />
          </div>
        </div>
      </div>

      {/* 3D Scene Section */}
      <div className="-mx-8 relative">
        {" "}
        {/* Negative margin to allow canvas to bleed to edges if needed */}
        <Scene3D emotion={emotion} waterLevel={waterLevel} />{" "}
        {/* Mock waterLevel for now */}
        {/* Tank Level Indicator */}
        <div className="absolute bottom-4 right-12 bg-black/60 backdrop-blur-md p-2 rounded-lg border border-glass-border">
          <div className="text-xs text-blue-300 font-bold mb-1">TANK LEVEL</div>
          <div className="w-24 h-2 bg-gray-700 rounded-full overflow-hidden">
            <div
              className={`h-full transition-all duration-500 ${
                isLowWater ? "bg-red-500" : "bg-blue-500"
              }`}
              style={{ width: `${waterLevel}%` }}
            />
          </div>
          <div className="text-right text-xs mt-1 text-white">
            {waterLevel}%
          </div>
        </div>
      </div>

      {/* Warnings */}
      {isCriticalLevel && (
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-red-500/10 border border-red-500/50 p-3 rounded-xl flex justify-between items-center"
        >
          <div className="flex items-center gap-2 text-red-500 font-bold">
            <span className="animate-pulse">⚠️</span> REFILL TANK NEEDED
          </div>
          <button
            onClick={refillTank}
            className="text-xs bg-red-500 text-black px-3 py-1 rounded-lg font-bold hover:bg-red-400 transition"
          >
            REFILL
          </button>
        </motion.div>
      )}

      {/* Water Button */}
      {/* Water Button */}
      <motion.button
        whileTap={{ scale: 0.95 }}
        onClick={waterPlant}
        disabled={isWatering || isCriticalLevel}
        className={`
          w-full py-4 rounded-xl font-bold text-lg tracking-wide shadow-lg
          transition-all duration-300
          ${
            isWatering || isCriticalLevel
              ? "bg-gray-800 text-gray-500 cursor-not-allowed"
              : "bg-primary text-black hover:bg-primary/90 hover:shadow-[0_0_30px_rgba(0,255,157,0.4)]"
          }
        `}
      >
        {isWatering
          ? "Watering... 🚿"
          : isCriticalLevel
          ? "REFILL TANK 🚫"
          : "WATER PLANT 💧"}
      </motion.button>

      {/* Metrics Grid */}
      <div className="grid grid-cols-2 gap-4">
        <MetricCard
          label="Moisture"
          value={moisture.toFixed(0)}
          unit="%"
          icon={<Droplets size={20} />}
          status={moisture < 30 ? "critical" : "good"}
          trend="stable"
        />
        <MetricCard
          label="Temp"
          value={temp.toFixed(1)}
          unit="°C"
          icon={<Thermometer size={20} />}
          status={temp > 32 ? "warning" : "good"}
          trend={temp > 30 ? "up" : "stable"}
        />
        <MetricCard
          label="Humidity"
          value={humidity.toFixed(0)}
          unit="%"
          icon={<Wind size={20} />}
          status="good"
          trend="down"
        />
      </div>
    </div>
  );
}

export default function Home() {
  return (
    <PlantSensorProvider>
      <NotificationModal />
      <MobileLayout>
        <DashboardContent />
      </MobileLayout>
    </PlantSensorProvider>
  );
}
