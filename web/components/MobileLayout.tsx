"use client";

import { ReactNode } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { Home, LineChart, Settings } from "lucide-react";
import { motion } from "framer-motion";

interface MobileLayoutProps {
  children: ReactNode;
}

export default function MobileLayout({ children }: MobileLayoutProps) {
  const pathname = usePathname();

  const navItems = [
    { icon: <Home size={24} />, label: "Home", href: "/" },
    { icon: <LineChart size={24} />, label: "Stats", href: "/stats" },
    { icon: <Settings size={24} />, label: "Settings", href: "/settings" },
  ];

  return (
    <div className="min-h-screen bg-background text-foreground flex justify-center">
      {/* Mobile Constraint Container */}
      <div className="w-full max-w-md bg-black min-h-screen relative shadow-2xl overflow-hidden flex flex-col">
        {/* Content Area */}
        <main className="flex-1 overflow-y-auto pb-24 px-6 pt-8">
          {children}
        </main>

        {/* Bottom Navigation */}
        <div className="fixed bottom-0 left-0 right-0 flex justify-center pointer-events-none z-50">
          <div className="w-full max-w-md pointer-events-auto">
            <nav className="mx-6 mb-6 rounded-2xl bg-glass-bg backdrop-blur-xl border border-glass-border p-2 flex justify-around items-center shadow-lg">
              {navItems.map((item) => {
                const isActive = pathname === item.href;
                return (
                  <Link
                    key={item.href}
                    href={item.href}
                    className={`relative p-3 rounded-xl transition-all duration-300 ${
                      isActive
                        ? "text-primary bg-primary/10"
                        : "text-gray-400 hover:text-white"
                    }`}
                  >
                    {isActive && (
                      <motion.div
                        layoutId="nav-pill"
                        className="absolute inset-0 bg-primary/10 rounded-xl"
                        transition={{
                          type: "spring",
                          stiffness: 300,
                          damping: 30,
                        }}
                      />
                    )}
                    <span className="relative z-10">{item.icon}</span>
                  </Link>
                );
              })}
            </nav>
          </div>
        </div>
      </div>
    </div>
  );
}
