"use client";

import { ReactNode } from "react";
import { motion } from "framer-motion";

interface MetricCardProps {
  label: string;
  value: string;
  unit: string;
  icon: ReactNode;
  trend?: "up" | "down" | "stable";
  status?: "good" | "warning" | "critical";
}

export default function MetricCard({
  label,
  value,
  unit,
  icon,
  trend,
  status = "good",
}: MetricCardProps) {
  // Determine border color based on status
  const borderColor =
    status === "critical"
      ? "border-red-500/50"
      : status === "warning"
      ? "border-yellow-500/50"
      : "border-primary/30";

  const glowColor =
    status === "critical"
      ? "shadow-[0_0_20px_rgba(239,68,68,0.2)]"
      : status === "warning"
      ? "shadow-[0_0_20px_rgba(234,179,8,0.2)]"
      : "shadow-[0_0_20px_rgba(0,255,157,0.1)]";

  return (
    <motion.div
      whileHover={{ scale: 1.02 }}
      className={`
        relative overflow-hidden rounded-2xl
        bg-glass-bg backdrop-blur-xl
        border ${borderColor}
        p-4 flex flex-col justify-between
        ${glowColor} transition-all duration-300
      `}
    >
      <div className="flex justify-between items-start">
        <div className="p-2 rounded-full bg-white/5 text-primary">{icon}</div>
        {trend && (
          <span
            className={`text-xs px-2 py-1 rounded-full ${
              trend === "up"
                ? "bg-green-500/20 text-green-400"
                : trend === "down"
                ? "bg-red-500/20 text-red-400"
                : "bg-white/10 text-gray-400"
            }`}
          >
            {trend === "up" ? "↑" : trend === "down" ? "↓" : "→"}
          </span>
        )}
      </div>

      <div className="mt-4">
        <h3 className="text-sm text-gray-400 font-medium uppercase tracking-wider">
          {label}
        </h3>
        <div className="flex items-end gap-1 mt-1">
          <span className="text-2xl font-bold text-white tracking-tight">
            {value}
          </span>
          <span className="text-sm text-primary mb-1">{unit}</span>
        </div>
      </div>

      {/* Background decoration */}
      <div className="absolute -right-4 -bottom-4 w-20 h-20 bg-gradient-to-br from-primary/10 to-transparent rounded-full blur-2xl" />
    </motion.div>
  );
}
