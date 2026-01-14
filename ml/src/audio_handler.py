import os
import asyncio
import speech_recognition as sr
import edge_tts
from pydub import AudioSegment

class AudioHandler:
    def __init__(self):
        self.recognizer = sr.Recognizer()
        # Voice options: 'id-ID-GadisNeural' (Female) or 'id-ID-ArdiNeural' (Male)
        self.tts_voice = "id-ID-GadisNeural" 

    def transcribe_audio(self, file_path: str) -> str:
        """
        Mengubah file audio (WAV/MP3) menjadi teks menggunakan Google Web Speech API.
        
        Args:
            file_path (str): Path ke file audio input.
            
        Returns:
            str: Teks hasil transkripsi. Mengembalikan string kosong jika gagal.
        """
        # Konversi ke WAV jika format bukan WAV (SpeechRecognition butuh WAV PCM)
        temp_wav_path = None
        target_path = file_path

        try:
            if not file_path.lower().endswith('.wav'):
                audio = AudioSegment.from_file(file_path)
                temp_wav_path = file_path + "_temp.wav"
                audio.export(temp_wav_path, format="wav")
                target_path = temp_wav_path

            with sr.AudioFile(target_path) as source:
                # Rekam data audio dari file
                audio_data = self.recognizer.record(source)
                
                # Transkripsi menggunakan Google Web Speech API (Gratis)
                # Note: Membutuhkan koneksi internet
                text = self.recognizer.recognize_google(audio_data, language="id-ID")
                return text

        except sr.UnknownValueError:
            print("AudioHandler: Suara tidak jelas atau tidak terdeteksi.")
            return ""
        except sr.RequestError as e:
            print(f"AudioHandler: Gagal menghubungi layanan Google Speech API ({e}).")
            return ""
        except Exception as e:
            print(f"AudioHandler: Error umum saat transkripsi ({e}).")
            return ""
        finally:
            # Bersihkan file temp jika ada
            if temp_wav_path and os.path.exists(temp_wav_path):
                os.remove(temp_wav_path)

    async def _generate_tts_async(self, text: str, output_file: str) -> bool:
        """Fungsi internal async untuk edge-tts."""
        try:
            communicate = edge_tts.Communicate(text, self.tts_voice)
            await communicate.save(output_file)
            return True
        except Exception as e:
            print(f"AudioHandler: Error generating TTS ({e})")
            return False

    def text_to_speech(self, text: str, output_file: str) -> bool:
        """
        Mengubah teks menjadi file audio MP3 menggunakan Edge TTS (Neural Voice).
        Fungsi ini bersifat synchronous (blocking) agar mudah dipanggil dari Flask.
        
        Args:
            text (str): Teks yang akan diucapkan.
            output_file (str): Path tujuan penyimpanan file audio (e.g., 'response.mp3').
            
        Returns:
            bool: True jika berhasil, False jika gagal.
        """
        try:
            # Menjalankan fungsi async dalam wrapper sync
            return asyncio.run(self._generate_tts_async(text, output_file))
        except Exception as e:
            print(f"AudioHandler: Gagal menjalankan text_to_speech ({e})")
            return False

# Singleton instance
audio_engine = AudioHandler()

# Wrapper functions for easy import
def transcribe_audio(file_path: str) -> str:
    return audio_engine.transcribe_audio(file_path)

def text_to_speech(text: str, output_file: str) -> bool:
    return audio_engine.text_to_speech(text, output_file)
