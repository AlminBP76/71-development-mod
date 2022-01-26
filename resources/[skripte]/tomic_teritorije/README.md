# tomic_teritorije

FiveM Territories | Sistem Teritorija za FiveM | (San Andreas Multiplayer Inspired)

| __ Consumes 0.01ms __ | 

My first finished project as a FiveM Developer. I'm a massive fan of SA:MP, in particular, the SA:MP territories. 
I wanted to create something similar to SA:MP territories since I believe no one did and posted it as an open-source. 
It's a system where you and your gang can capture different territories or zones. 
Of course, by capturing you receive different rewards and receive even more by having them under your control!

Ukoliko ste igrali SA:MP, znate o cemu je rijec. Ukoliko ne, biti ce objasnjeno tu u par rijeci..
Radi se o sistemu teritorija koje posjeduju bande. Teritorije/Zone mogu biti napadnute u bilo kojem trenutku od druge bande.
Naravno, kao i u SA:MP-u, postoje nagrade za posjedovanje teritorija. Recimo, svaki minut posjedovanja teritorije dolazi mala suma novca, ili mozda cak neki item u sef bande.
Buduci da ovo nije jos objavljeno kao open-source, postavljam ovaj thread da podjelim svoj rad s drugima. Ovo je definitivno nesto sto igraci vole da vide na serveru.

About the script:
- Capturing time is configurable, currently, it's 6 seconds per percent. It takes a while to capture (10mins), but it's meant that to work that way.
- Jobs that are allowed to capture the territories are also configurable.
- A command "/teritorije" exists. If executed, it'll list all the territories in chat, including their owners.
- Availability to set the time when the zone loses the owner, basically the territory resets after the time configured. (Current time is 99999999999, which means that it doesn't reset. xD)
- There is a radius system, which means when the person that is capturing the zone goes out of the territory (current radius is 50 units), it cancels by itself. So you can't go to the other side of the map.
- Discord Logs with precise hour, minute, and second. It also includes when, who, and which job started taking which territory.
- I'm looking forward to improving this script with other developers to another level, so it can be perfectly done and functional.

Informacije:
- Mogućnost biranja poslova, tj. organizacija koje mogu zauzimati teritorije.
- Postoji cooldown nakon uspješnog zauimanja kako bi opet započeli. (1h cooldown)
- Postoje nagrade koje dolaze u sef organizacije koja je zauzela tu određenu teritoriju. (Moguće je birati između item-a, recimo x20 droge u sef, ili novac.)
- Discord Logovi s preciznim vremenom, teritorijom i organizacijom koja je započela zauzimanje.
- Komanda /teritorije s kojom provjeravate tko posjeduje koju teritoriju.
- Mogućnost da se teritorija resetira, tj. izgubi vođu nakon određenog vremena.
- SA:MP Inspired.

----------------------
Known Bugs:

**This territory system is missing some easy-repairable stuff. I did not manage to fix it, but hopefully, there is someone that can help. ;)**

Fixed Everything.

----------------------
To-Do:

**The script itself can be improved and simplified in so many different ways. I built it in a really complex way, so you may have to go through the script a few times, just to see how it works.**
- Blip color changes depending on the territory owner. For instance: If 'Grove Street Family' owns a territory, the blip color should be green. Each gang should have a different color.
I didn't manage to solve this. If you have any idea, contact me or just pull this thread.

----------------------

Keep in mind:

I am not sure if someone released something like this, but here it is anyway. If you decide to use the script, keep the credits. It means a lot to me. I will be available anytime for further development.

----------------------

Discord: Tomić#9076
