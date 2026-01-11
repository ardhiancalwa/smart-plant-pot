"use client";

import { motion } from "framer-motion";

interface PlantAvatarProps {
  emotion: "happy" | "thirsty" | "hot" | "cold";
}

const emotions = {
  happy: "😸",
  thirsty: "💧",
  hot: "🥵",
  cold: "🥶",
};

export default function PlantAvatar({ emotion }: PlantAvatarProps) {
  const isCrisis = emotion === "thirsty"; // Example crisis state

  return (
    <div className="flex flex-col items-center justify-center p-8">
      <div className="relative">
        {/* Glow Effect */}
        <div className="absolute inset-0 bg-primary/20 blur-[60px] rounded-full transform scale-150" />

        <motion.div
          animate={
            isCrisis
              ? {
                  x: [-2, 2, -2, 2, 0],
                  scale: [1, 1.05, 1],
                }
              : {
                  scale: [1, 1.05, 1],
                }
          }
          transition={{
            duration: isCrisis ? 0.5 : 3,
            repeat: Infinity,
            ease: "easeInOut",
          }}
          className="relative text-[120px] filter drop-shadow-[0_0_30px_rgba(0,255,157,0.4)]"
        >
          {emotions[emotion] || "😐"}
        </motion.div>
      </div>

      <motion.p
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        className="mt-4 text-xl font-medium tracking-wide text-primary/80 uppercase"
      >
        Status: {emotion}
      </motion.p>
    </div>
  );
}
