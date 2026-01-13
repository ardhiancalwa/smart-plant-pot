"use client";

import MobileLayout from "@/components/MobileLayout";
import {
  AreaChart,
  Area,
  LineChart,
  Line,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
} from "recharts";
import { Download, TrendingUp } from "lucide-react";
import { motion } from "framer-motion";

const MOISTURE_DATA = [
  { time: "06:00", value: 60 },
  { time: "09:00", value: 55 },
  { time: "12:00", value: 48 },
  { time: "15:00", value: 40 },
  { time: "18:00", value: 35 },
  { time: "21:00", value: 30 },
  { time: "24:00", value: 50 }, // Watered?
];

const TEMP_DATA = [
  { time: "Mon", value: 24 },
  { time: "Tue", value: 25 },
  { time: "Wed", value: 28 },
  { time: "Thu", value: 22 },
  { time: "Fri", value: 24 },
  { time: "Sat", value: 26 },
  { time: "Sun", value: 25 },
];

const HUMIDITY_DATA = [
  { time: "W1", value: 60 },
  { time: "W2", value: 65 },
  { time: "W3", value: 55 },
  { time: "W4", value: 70 },
];

// Custom Tooltip
const CustomTooltip = ({ active, payload, label }: any) => {
  if (active && payload && payload.length) {
    return (
      <div className="bg-black/90 border border-glass-border p-2 rounded-lg text-xs">
        <p className="text-gray-400">{label}</p>
        <p className="text-primary font-bold">{payload[0].value}</p>
      </div>
    );
  }
  return null;
};

export default function StatsPage() {
  return (
    <MobileLayout>
      <div className="flex flex-col gap-8 pt-4">
        {/* Header */}
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-2xl font-bold text-white">Analytics</h1>
            <p className="text-gray-400 text-sm">Weekly Health Report</p>
          </div>
          <button className="p-2 rounded-full bg-white/5 hover:bg-white/10 transition">
            <Download size={20} className="text-primary" />
          </button>
        </div>

        {/* Moisture Chart */}
        <section className="space-y-4">
          <div className="flex items-center gap-2 mb-2">
            <h2 className="text-lg font-bold text-white uppercase tracking-wider">
              Moisture
            </h2>
            <div className="bg-green-500/20 text-green-400 px-2 py-1 rounded text-xs flex items-center gap-1">
              <TrendingUp size={12} /> -5%
            </div>
          </div>
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="h-48 bg-glass-bg border border-glass-border rounded-2xl overflow-hidden p-2"
          >
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={MOISTURE_DATA}>
                <defs>
                  <linearGradient
                    id="colorMoisture"
                    x1="0"
                    y1="0"
                    x2="0"
                    y2="1"
                  >
                    <stop offset="5%" stopColor="#00ff9d" stopOpacity={0.3} />
                    <stop offset="95%" stopColor="#00ff9d" stopOpacity={0} />
                  </linearGradient>
                </defs>
                <Tooltip content={<CustomTooltip />} />
                <Area
                  type="monotone"
                  dataKey="value"
                  stroke="#00ff9d"
                  strokeWidth={2}
                  fillOpacity={1}
                  fill="url(#colorMoisture)"
                />
              </AreaChart>
            </ResponsiveContainer>
          </motion.div>
        </section>

        {/* Temperature Chart */}
        <section className="space-y-4">
          <h2 className="text-lg font-bold text-white uppercase tracking-wider">
            Temperature
          </h2>
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="h-48 bg-glass-bg border border-glass-border rounded-2xl overflow-hidden p-2"
          >
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={TEMP_DATA}>
                <CartesianGrid
                  strokeDasharray="3 3"
                  stroke="#333"
                  vertical={false}
                />
                <XAxis
                  dataKey="time"
                  stroke="#666"
                  fontSize={10}
                  tickLine={false}
                  axisLine={false}
                />
                <Tooltip content={<CustomTooltip />} />
                <Line
                  type="monotone"
                  dataKey="value"
                  stroke="#f97316"
                  strokeWidth={2}
                  dot={{ fill: "#f97316", r: 4 }}
                  activeDot={{ r: 6 }}
                />
              </LineChart>
            </ResponsiveContainer>
          </motion.div>
        </section>

        {/* Humidity Chart */}
        <section className="space-y-4">
          <h2 className="text-lg font-bold text-white uppercase tracking-wider">
            Humidity
          </h2>
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            className="h-48 bg-glass-bg border border-glass-border rounded-2xl overflow-hidden p-2"
          >
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={HUMIDITY_DATA}>
                <XAxis
                  dataKey="time"
                  stroke="#666"
                  fontSize={10}
                  tickLine={false}
                  axisLine={false}
                />
                <Tooltip content={<CustomTooltip />} />
                <Bar dataKey="value" fill="#3b82f6" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </motion.div>
        </section>
      </div>
    </MobileLayout>
  );
}
