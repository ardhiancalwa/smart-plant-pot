"use client";

import React, {
  createContext,
  useContext,
  useEffect,
  useState,
  ReactNode,
} from "react";

// Types
export type Emotion = "happy" | "thirsty" | "hot" | "cold";

interface SensorData {
  moisture: number; // 0-100%
  temp: number; // Celsius
  humidity: number; // 0-100%
  emotion: Emotion;
  waterLevel: number; // 0-100%
}

interface PlantContextType extends SensorData {
  waterPlant: () => void;
  refillTank: () => void;
  isWatering: boolean;
  showNotificationAlert: boolean;
  dismissNotification: () => void;
}

// Initial Mock Data
const INITIAL_DATA: SensorData = {
  moisture: 45,
  temp: 24,
  humidity: 60,
  emotion: "happy",
  waterLevel: 80,
};

// Create Context
const PlantContext = createContext<PlantContextType | undefined>(undefined);

// Helper to fluctuate numbers naturally
const fluctuate = (val: number, min: number, max: number) => {
  const change = (Math.random() - 0.5) * 2; // -1 to +1
  let newVal = val + change;
  // Keep within bounds
  if (newVal < min) newVal = min;
  if (newVal > max) newVal = max;
  return Number(newVal.toFixed(1));
};

export function PlantSensorProvider({ children }: { children: ReactNode }) {
  const [data, setData] = useState<SensorData>(INITIAL_DATA);
  const [isWatering, setIsWatering] = useState(false);

  // Notification State
  const [showNotificationAlert, setShowNotificationAlert] = useState(false);
  const [lastAlertTime, setLastAlertTime] = useState(0);

  // Dismiss notification handler
  const dismissNotification = () => setShowNotificationAlert(false);

  // Simulation Effect
  useEffect(() => {
    const interval = setInterval(() => {
      setData((prev) => {
        // Fluctuate values
        const newMoisture = fluctuate(prev.moisture, 0, 100);
        const newTemp = fluctuate(prev.temp, 15, 40);
        const newHumidity = fluctuate(prev.humidity, 30, 90);

        // Determine Logic
        let newEmotion: Emotion = "happy";

        // Priority Logic:
        // 1. Critical Thirst
        if (newMoisture < 30) {
          newEmotion = "thirsty";
        }
        // 2. Too Hot
        else if (newTemp > 32) {
          newEmotion = "hot";
        }
        // 3. Too Cold (Optional extra)
        else if (newTemp < 18) {
          newEmotion = "cold";
        }

        // Return the new state
        return {
          moisture: newMoisture,
          temp: newTemp,
          humidity: newHumidity,
          emotion: newEmotion,
          waterLevel: prev.waterLevel, // Preserve water level
        };
      });

      // Notification Trigger Logic
      // We need to re-calculate or get the latest moisture value here for the notification logic.
      // Since setData is asynchronous, we can't directly use the `newMoisture` from the callback.
      // A better approach is to calculate the values once and then use them for both state update and side effects.
      // For simplicity and to match the user's intent of using `newMoisture` here, we'll use the current `data.moisture`
      // which will be the value from the *previous* interval, or we can refactor to calculate outside setData.
      // Let's refactor to calculate outside setData for correctness.

      // Calculate new values for the current interval tick
      const currentMoisture = fluctuate(data.moisture, 0, 100);
      const currentTemp = fluctuate(data.temp, 15, 40);
      const currentHumidity = fluctuate(data.humidity, 30, 90);

      let currentEmotion: Emotion = "happy";
      if (currentMoisture < 30) {
        currentEmotion = "thirsty";
      } else if (currentTemp > 32) {
        currentEmotion = "hot";
      } else if (currentTemp < 18) {
        currentEmotion = "cold";
      }

      // Update state with the newly calculated values
      setData({
        moisture: currentMoisture,
        temp: currentTemp,
        humidity: currentHumidity,
        emotion: currentEmotion,
        waterLevel: data.waterLevel, // Preserve water level during background ticks
      });

      // Now use currentMoisture for notification logic
      const CRITICAL_MOISTURE = 10;
      const LOW_WATER = 15;
      const COOLDOWN = 60 * 60 * 1000; // 1 hour
      const now = Date.now();

      // Check Moisture OR Low Water
      const isCriticalMoisture = currentMoisture < CRITICAL_MOISTURE;
      const isLowWater = data.waterLevel < LOW_WATER;

      if (
        (isCriticalMoisture || isLowWater) &&
        now - lastAlertTime > COOLDOWN
      ) {
        // Trigger the alert UI
        setShowNotificationAlert(true);
        setLastAlertTime(now);

        let body = "";
        if (isCriticalMoisture)
          body = `Plant moisture is at ${currentMoisture.toFixed(
            0
          )}%! Water immediately!`;
        if (isLowWater)
          body = `Water Tank is low (${data.waterLevel}%)! Refill required.`;

        // Browser Notification
        if (Notification.permission === "granted") {
          new Notification("SMART POT ALERT!", {
            body: body,
            icon: "/web-app-manifest-192x192.png",
          });
        } else if (Notification.permission !== "denied") {
          Notification.requestPermission();
        }
      }
    }, 3000); // Update every 3 seconds

    return () => clearInterval(interval);
  }, [data, lastAlertTime]); // Add 'data' to dependency array because we're reading it directly now.

  const waterPlant = () => {
    if (data.waterLevel <= 0) {
      alert("TANK EMPTY! Please refill.");
      return;
    }

    setIsWatering(true);
    // Simulate watering delay
    setTimeout(() => {
      setData((prev) => ({
        ...prev,
        moisture: 100, // Fully watered
        emotion: "happy", // Instant gratification
        waterLevel: Math.max(0, prev.waterLevel - 5), // Consume water
      }));
      setIsWatering(false);
    }, 2000);
  };

  const refillTank = () => {
    setData((prev) => ({ ...prev, waterLevel: 100 }));
  };

  return (
    <PlantContext.Provider
      value={{
        ...data,
        waterPlant,
        refillTank,
        isWatering,
        showNotificationAlert,
        dismissNotification,
      }}
    >
      {children}
    </PlantContext.Provider>
  );
}

export function usePlantSensor() {
  const context = useContext(PlantContext);
  if (context === undefined) {
    throw new Error("usePlantSensor must be used within a PlantSensorProvider");
  }
  return context;
}
