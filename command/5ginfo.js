import triginfo from '../lib/5ginfo.js'
export const cmds = ["5ginfo"];
export const exec = async (bot, msg, chatId, messageId) => {
    var data = await triginfo()
    bot.reply(data)
};