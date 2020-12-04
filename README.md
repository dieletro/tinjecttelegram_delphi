 ![IMG_Logo_TInjectTelegram_s_Fundo](https://user-images.githubusercontent.com/11804577/79389701-fd284580-7f44-11ea-8238-bab525a19caa.png)

This Component was developed by [*Ruan Diego Lacerda Menezes*](https://github.com/dieletro/)
for use and consumption of the Official [*Telegram Bot*] API(https://core.telegram.org/bots/api) via Delphi

#  Help maintain this project, follow the Links for donations
---
**[*Donation via PAYPAL*](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=2JPLRUD9S2RBY&item_name=Projeto+TInjectTelegram+para+Delphi&currency_code=BRL&source=url)**

# Use QR CODE, if you prefer, to make your donation via PAYPAL

![QR CodeDoacoesTInjectTelegram](https://user-images.githubusercontent.com/11804577/82735377-ae19c100-9cf7-11ea-9e63-86266ecaa55f.png)

**[*Donation via Mercado Pago*](https://www.mercadopago.com.br/checkout/v1/redirect?pref_id=96811362-c8e28ed6-7ee2-4a89-a043-a18d5c1ec317)**
---

# TInjectTelegram for Delphi
To get the latest updates, go here
 * **[*dieletro/tinjecttelegram_delphi*](https://github.com/dieletro/tinjecttelegram_delphi)**

# Suport Groups for developers:
 * **[*Telegram*](https://t.me/TinjectTelegram)**
 * **[*Whatsapp*](https://chat.whatsapp.com/KyepdH5XYw9KnuLlobGFAE)**

# TInjectTelegram UPDATES for Delphi by (dieletro) LMCODE 
---
* **Component version 1.2.0**
> - [X] Updated for the latest version of the Telegram API, version 5.0 of November 24, 2020.

*Run Your Own Bot API Server*
> - [ ] Bot API source code is now available at telegram-bot-api. You can now run your own Bot API server locally, boosting your bots' performance (check this out to see if this will benefit your project).
> - [ ] Added the method logOut, which can be used to log out from the cloud Bot API server before launching your bot locally. You must log out the bot before running it locally, otherwise there is no guarantee that the bot will receive all updates. 
> - [ ] Added the method close, which can be used to close the bot instance before moving it from one local server to another.
-----------------------------------------------------------------------------------------------------------------------------------------

*Transfer Bot Ownnership*
> - [X] You can now use @BotFather to transfer your existing bots to another Telegram account.
-----------------------------------------------------------------------------------------------------------------------------------------

*Working with Groups*
> - [X] add in ItgChat and TtgChat
	function LinkedChatId:	Integer;
	function location: ItgChatLocation;
	function SlowModeDelay:	Integer;
	function Permissions: ItgChatPermissions;
	function Bio:	String;	
> - [X] Now the method getChat result this more two new property	
> - [X] New Interfaces and Objects
	ItgChatLocation e TtgChatLocation
	ItgChatPermissions e TtgChatPermissions
> - [X] add unbanChatMember
	only_if_banned	Boolean	Optional	(Do nothing if the user is not banned)
-----------------------------------------------------------------------------------------------------------------------------------------	

*Webhooks*	
> - [X] add param in method SetWebHook
	const IpAddress: String;
	const DropPendingUpdates: Boolean;	
> - [X] add param in method DeleteWebhook
    const DropPendingUpdates: Boolean;	
> - [X] add property in ItgWebhookInfo e TtgWebhookInfo
	function IpAddress: String;
-----------------------------------------------------------------------------------------------------------------------------------------

*Other updates*		
> - [X] add property in ItgFile and TtgFile
	function FileUniqueId: string;	
> - [X] add property in ItgAudio and TtgAudio
	function Thumb: ItgPhotoSize;
	function FileName: string;
> - [X] add property in ItgVideo and TtgVideo
	function FileName: string;
-----------------------------------------------------------------------------------------------------------------------------------------

*Multiple Pinned Messages*
> - [X] Added the ability to pin messages in private chats.
> - [X] Added the parameter MessageId to the method 
    function UnPinChatMessage(
      const ChatId: TtgUserLink; const MessageId: Int64): Boolean; 
to allow unpinning of the specific pinned message.
> - [X] Added the method 
	function UnPinAllChatMessages(const ChatId: TtgUserLink): Boolean;
which can be used to unpin all pinned messages in a chat.
-----------------------------------------------------------------------------------------------------------------------------------------

*File Albums*
> - [X] Added support for sending and receiving audio and document albums in the method sendMediaGroup.
-----------------------------------------------------------------------------------------------------------------------------------------

*Live Locations*
> - [X] Added the fields 
	LivePeriod, 
	HorizontalAccuracy,
	Heading,
	ProximityAlertRadius
to the Interface ItgLocation and class TtgLocation, representing a maximum period for which the live location can be updated.
> - [X] Added support for live location heading: added the field heading to the classes TtgLocation, TtgInlineQueryResultLocation, TtgInputLocationMessageContent and the parameter Heading to the methods sendLocation and editMessageLiveLocation.
> - [X] Added parameter AllowSendingWithoutReply to the sendLocation method
> - [X] Added the interface ItgProximityAlertTriggered and type TtgProximityAlertTriggered and the field ProximityAlertTriggered to the interface ItgMessage and class TtgMessage.
> - [X] Added in the ItgMessage Interface
	function SenderChat: ItgChat;
	function ForwardSenderName: String;
	function proximity_alert_triggered: ItgProximityAlertTriggered;
-----------------------------------------------------------------------------------------------------------------------------------------
	
*Anonymous Admins*
> - [X] Added the field SenderChat to the class TtgMessage, containing the sender of a message which is a chat (group or channel). For backward compatibility in non-channel chats, the field from in such messages will contain the user 777000 for messages automatically forwarded to the discussion group and the user 1087968824 (@GroupAnonymousBot) for messages from anonymous group administrators.
> - [X] Added the field IsAnonymous to the class TtgChatMember, which can be used to distinguish anonymous chat administrators.
> - [X] Added the parameter IsAnonymous to the method promoteChatMember, which allows to promote anonymous chat administrators. The bot itself should have the IsAnonymous right to do this. Despite the fact that bots can have the IsAnonymous right, they will never appear as anonymous in the chat. Bots can use the right only for passing to other administrators.
> - [X] Added the CustomTitle of an anonymous message sender to the class TtgMessage as author_signature.
-----------------------------------------------------------------------------------------------------------------------------------------

*And More*
> - [X] Added the method CopyMessage, which sends a copy of any message.
Maximum poll question length increased to 300.

> - [X] Added the fields google_place_id and google_place_type to the classes TtgVenue, TtgInlineQueryResultVenue, TtgInputVenueMessageContent and the optional parameters google_place_id and google_place_type to the method sendVenue to support Google Places as a venue API provider.

> - [X] Added the field allow_sending_without_reply to the methods sendMessage, sendPhoto, sendVideo, sendAnimation, sendAudio, sendDocument, sendSticker, sendVideoNote, sendVoice, sendLocation, sendVenue, sendContact, sendPoll, sendDice, sendInvoice, sendGame, sendMediaGroup to allow sending messages not a as reply if the replied-to message has already been deleted.

*And Last but bot Least*
> - [X] Supported the new football and slot machine animations for the random dice. Choose between different animations (etDado, etDardo, etBasketball, etFootball, etSlotMachine) by specifying the emoji parameter in the method sendDice.

---
* **Component version 1.1.0**
> - [X] Code updated for the latest version of the Telegram API, version 4.9 of June 4, 2020.
> - [X] Added the new ViaBot field to the TtgMessage object. You can now find out which bot was used to send a message.
> - [X] Video thumbnails with support for embedded GIF and MPEG4 animations.
> - [X] Support for new basketball animation for random data. Choose between different animations (etData, etDardos, etBasquete), specifying the emoji parameter in the sendDice method.
> - [X] Added Telegram Passport.
> - [X] Reading of Invoice, Dice, Poll, PassportData, in the TtgMessage object

---
* **Component version 1.0.0**
> - [X] Updated code for the latest version of the Telegram API, version 4.8 of April 24, 2020.
> - [X] Name of the Modified Objects.
> - [X] Created New Methods to be able to convert different types of array of string to JSonString
> - [X] Added new Objects in accordance with the API
> - [X] Bug fixes in several methods
> - [X] Update features from version 3.5.5 to 4.8
> - [X] Added the SendPool function (Sending Polls and Quiz).
> - [X] Added the function SendDice (Sending a Dice or an animated Dart).
> - [X] Fixed the SendLocation function.
> - [X] Fixed the SendVenue function (Sending Location with Text).
> - [X] Added the function SendAnimaion (Sending an animation).
> - [X] Added the SendMediaGroup function (Uploading Photos and Videos Grouped).
> - [X] Added the type TtgKeyboardButtonPollType.
> - [X] Correction in Send Method with Buttons.
> - [X] Added the function SendInvoice (Sending a Payment Order).

![Fundo3](https://user-images.githubusercontent.com/11804577/79387409-14196880-7f42-11ea-8e7f-cb2d3270c74c.png)

The following people contributed to this library:
---
> **Ruan Diego Lacerda Menezes (dieletro).**
1. Contacts
    * **[whatsapp](https://web.whatsapp.com/send?phone=5521997196000&text=Olá#13gostaria#13de#13saber#13mais#13sobre#13o#13Projeto#13TinjectTelegram)** 
    * **[telegram](https://t.me/diegolacerdamenezes)**  
    * **[email](https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&source=mailto&to=diegolacerdamenezes@gmail.com)**
    * **[instagram](https://www.instagram.com/lacerdamenezes/?hl=pt-br)**
---
> **Aurino (Collaborator of Unit TelegAPI.Emoji)**
---

# CrossUrl
Library to use end user network libraries.

***Installation and other information see:***
[wiki-page] **https://github.com/ms301/CrossUrl/wiki**
[github]    **https://github.com/ms301/CrossUrl**

To use it is necessary to have CrossURL installed, available at:
[github] ***https://github.com/ms301/CrossUrl***

# To use Telegram's TDLib API see my other projects with usage examples and are also available on Telegram's official website, click in exemples for see more...
* **[Usage](https://core.telegram.org/tdlib/docs/#usage)** , or access my direct link to the examples * **[See my TDLib examples for use with Object Pascal](https://github.com/tdlib/td/blob/master/example/README.md#object-pascal)**  
