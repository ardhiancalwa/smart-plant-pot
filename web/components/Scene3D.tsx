"use client";

import React, { useRef } from "react";
import { Canvas, useFrame } from "@react-three/fiber";
import { OrbitControls, PerspectiveCamera } from "@react-three/drei";
import * as THREE from "three";
import { Emotion } from "@/hooks/usePlantSensor";

interface Scene3DProps {
  emotion: Emotion;
  waterLevel: number; // 0-100
}

function Plant({ emotion }: { emotion: Emotion }) {
  const group = useRef<THREE.Group>(null);

  // Animation: "Breathing"
  useFrame((state) => {
    if (group.current) {
      const time = state.clock.getElapsedTime();
      // Slow down breathing if thirsty/hot
      const speed = emotion === "thirsty" || emotion === "hot" ? 0.5 : 2;
      group.current.position.y = Math.sin(time * speed) * 0.1;

      // Gentle rotation
      group.current.rotation.y = Math.sin(time * 0.5) * 0.1;
    }
  });

  // Dynamic Colors
  const leafColor = emotion === "thirsty" ? "#eab308" : "#00ff9d"; // Yellow vs Neon Green
  const potColor = "#8B4513"; // SaddleBrown

  return (
    <group ref={group} position={[0, -1, 0]}>
      {/* The Pot */}
      <mesh position={[0, 0.5, 0]}>
        <cylinderGeometry args={[0.8, 0.6, 1.5, 32]} />
        <meshStandardMaterial color={potColor} />
      </mesh>

      {/* The Plant Stem */}
      <mesh position={[0, 1.5, 0]}>
        <cylinderGeometry args={[0.1, 0.1, 1, 16]} />
        <meshStandardMaterial color="#2d6a4f" />
      </mesh>

      {/* Leaves (Procedural Spheres/Capsules) */}
      <group position={[0, 2, 0]}>
        <mesh position={[0.5, 0, 0]} rotation={[0, 0, -Math.PI / 4]}>
          <capsuleGeometry args={[0.2, 1, 4, 8]} />
          <meshStandardMaterial color={leafColor} />
        </mesh>
        <mesh position={[-0.5, 0, 0]} rotation={[0, 0, Math.PI / 4]}>
          <capsuleGeometry args={[0.2, 1, 4, 8]} />
          <meshStandardMaterial color={leafColor} />
        </mesh>
        <mesh position={[0, 0.5, 0.5]} rotation={[Math.PI / 4, 0, 0]}>
          <capsuleGeometry args={[0.2, 1, 4, 8]} />
          <meshStandardMaterial color={leafColor} />
        </mesh>
        <mesh position={[0, 0.5, -0.5]} rotation={[-Math.PI / 4, 0, 0]}>
          <capsuleGeometry args={[0.2, 1, 4, 8]} />
          <meshStandardMaterial color={leafColor} />
        </mesh>
      </group>
    </group>
  );
}

function WaterTank({ waterLevel }: { waterLevel: number }) {
  // Map 0-100 to 0-2 (height of cylinder)
  const actualHeight = (waterLevel / 100) * 2;

  return (
    <group position={[2, -1, 0]}>
      {/* Glass Shell */}
      <mesh position={[0, 1, 0]}>
        <cylinderGeometry args={[0.5, 0.5, 2.2, 32]} />
        <meshPhysicalMaterial
          color="#ffffff"
          transmission={0.9}
          opacity={0.3}
          transparent
          roughness={0}
          thickness={0.1}
        />
      </mesh>

      {/* Water Liquid */}
      {waterLevel > 0 && (
        <mesh position={[0, actualHeight / 2, 0]}>
          <cylinderGeometry args={[0.45, 0.45, actualHeight, 32]} />
          <meshStandardMaterial color="#3b82f6" transparent opacity={0.8} />
        </mesh>
      )}
    </group>
  );
}

export default function Scene3D({ emotion, waterLevel }: Scene3DProps) {
  return (
    <div className="h-[300px] w-full">
      <Canvas>
        <PerspectiveCamera makeDefault position={[0, 2, 6]} />
        <OrbitControls enableZoom={false} enablePan={false} />

        {/* Environment */}
        <ambientLight intensity={0.5} />
        <directionalLight
          position={[5, 10, 5]}
          intensity={1.5}
          color="#ffffff"
        />
        <pointLight position={[-5, 5, -5]} intensity={0.5} color="#00ff9d" />

        <Plant emotion={emotion} />
        <WaterTank waterLevel={waterLevel} />
      </Canvas>
    </div>
  );
}
