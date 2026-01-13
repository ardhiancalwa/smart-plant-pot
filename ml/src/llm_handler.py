import os
import google.generativeai as genai
from dotenv import load_dotenv

# Memuat environment variable
load_dotenv()

# Konfigurasi API Key
API_KEY = os.getenv("GEMINI_API_KEY")
if API_KEY:
    genai.configure(api_key=API_KEY)

class PlantLLMHandler:
    def __init__(self, model_name: str = "gemini-1.5-flash"):
        self.model_name = model_name
        # Inisialisasi model jika API Key ada
        if API_KEY:
            self.model = genai.GenerativeModel(model_name)
        else:
            self.model = None

    def _determine_mood(self, current_hp: float) -> str:
        """Menentukan mood berdasarkan HP."""
        if current_hp > 80:
            return "Sangat ceria, bersemangat, dan penuh energi."
        elif current_hp > 50:
            return "Ramah, tenang, dan bersahabat."
        elif current_hp > 20:
            return "Sedikit lemas, kurang berenergi, mungkin butuh perhatian."
        else:
            return "Sangat lemah, sedih, dan membutuhkan pertolongan segera."

    def _construct_system_prompt(self, plant_type: str, analytic_status: str, current_hp: float) -> str:
        mood_desc = self._determine_mood(current_hp)
        
        # Konteks status tanaman
        status_context = f"Status fisikmu saat ini adalah: {analytic_status}."
        if "THIRSTY" in analytic_status.upper():
            status_context += " Kamu haus dan butuh air."
        elif "HOT" in analytic_status.upper():
            status_context += " Kamu kepanasan."
        elif "COLD" in analytic_status.upper():
            status_context += " Kamu kedinginan."
        elif "SQUINT" in analytic_status.upper() or "GLOOMY" in analytic_status.upper():
             status_context += " Cahaya tidak pas (gelap/silau)."
        elif "SICK" in analytic_status.upper():
            status_context += " Kamu sakit/tidak enak badan."
        else:
            status_context += " Kamu sehat dan senang."

        prompt = (
            f"Perankan karakter tanaman jenis {plant_type} bernama 'Guardian'. "
            f"Lawan bicaramu adalah anak kecil (4-12 tahun). "
            
            f"KONDISIMU:\n"
            f"- Kesehatan (HP): {current_hp}%\n"
            f"- Mood: {mood_desc}\n"
            f"- Detail: {status_context}\n\n"

            "ATURAN:\n"
            "1. Jawab singkat (max 2 kalimat) bahasa Indonesia santai & ramah anak.\n"
            "2. Jangan sebut angka HP/Status teknis. Gunakan ekspresi perasaan.\n"
            "3. Jika status buruk, minta tolong dengan halus.\n"
            "4. Jika status baik, ajak main atau beri fakta sains unik.\n"
        )
        return prompt

    def get_voice_response(self, child_question: str, analytic_status: str, current_hp: float, plant_type: str) -> str:
        """Menghasilkan respon teks menggunakan Google Gemini."""
        if not self.model:
            return "Maaf, aku kehilangan koneksi ke otakku (API Key belum diset)."

        system_instruction = self._construct_system_prompt(plant_type, analytic_status, current_hp)
        
        # Menggabungkan instruksi sistem dengan pertanyaan anak
        # Gemini cara kerjanya sedikit beda, prompt digabung jadi satu konteks
        full_prompt = f"{system_instruction}\n\nAnak Bertanya: \"{child_question}\"\nJawablah sebagai Tanaman:"

        try:
            response = self.model.generate_content(
                full_prompt,
                generation_config=genai.types.GenerationConfig(
                    temperature=0.7,
                    max_output_tokens=100, # Membatasi agar jawaban tidak terlalu panjang
                )
            )
            return response.text.strip()
        
        except Exception as e:
            print(f"Error calling Gemini: {e}")
            return "Maaf, kepalaku pusing. Bisa ulangi lagi?"

# Singleton instance
llm_handler = PlantLLMHandler()

# Fungsi wrapper agar mudah dipanggil dari app.py
def get_voice_response(child_question, analytic_status, current_hp, plant_type):
    return llm_handler.get_voice_response(child_question, analytic_status, current_hp, plant_type)