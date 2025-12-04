import os
import asyncio
import logging
from datetime import datetime

from aiogram import Bot, Dispatcher, types, F
from aiogram.filters import Command
from aiogram.enums import ParseMode
from aiogram.client.default import DefaultBotProperties
from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton

# === НАСТРОЙКИ ===
BOT_TOKEN = os.getenv("BOT_TOKEN", "ТВОЙ_ТОКЕН")
ADMIN_ID = 8366052369
CHANNEL = "@GrokOfficialka"

bot = Bot(token=BOT_TOKEN, default=DefaultBotProperties(parse_mode=ParseMode.HTML))
dp = Dispatcher()

# === /start ===
@dp.message(Command("start"))
async def start_cmd(message: types.Message):
    user = message.from_user
    link = f"https://admitad.com/g/xxx/?utm_user={user.id}"
    
    keyboard = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text="🛒 Перейти к товару", url=link)],
        [InlineKeyboardButton(text="📊 Статистика", callback_data="stats")]
    ])
    
    await message.answer(
        f"👋 <b>Добро пожаловать, {user.first_name}!</b>\n\n"
        f"🔗 <b>Ваша ссылка для покупки:</b>\n"
        f"<code>{link}</code>\n\n"
        f"✅ По этой ссылке отслеживаются все ваши заказы.",
        reply_markup=keyboard,
        disable_web_page_preview=True
    )
    
    print(f"[{datetime.now()}] User {user.id} started bot")

# === Запуск ===
async def main():
    print("🤖 Бот запускается...")
    print(f"👤 Админ: {ADMIN_ID}")
    print(f"📢 Канал: {CHANNEL}")
    await dp.start_polling(bot)

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.run(main())
