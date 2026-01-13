export type AlertChannel = "whatsapp" | "telegram";

export const sendAlert = (
  channel: AlertChannel,
  message: string,
  contactInfo: string
) => {
  if (!contactInfo) {
    console.error("Missing contact info for alert");
    return;
  }

  let url = "";

  if (channel === "whatsapp") {
    // WhatsApp: https://wa.me/[NUMBER]?text=[MESSAGE]
    url = `https://wa.me/${contactInfo}?text=${encodeURIComponent(message)}`;
  } else if (channel === "telegram") {
    // Telegram Bot: https://t.me/[USERNAME]?start=[MESSAGE]
    // Note: 'start' parameter usually for deep linking param, 
    // but for simple user simulation we might just open the chat.
    // For this mock, we append the message to the URL just to show intent, 
    // although standard Telegram deep links work differently.
    // A better pattern for bots is ?start=alert_code, but we'll stick to the prompt.
    url = `https://t.me/${contactInfo}?start=${encodeURIComponent(message)}`;
  }

  if (url) {
    window.open(url, "_blank");
  }
};
