mySOS
=====
<h2>Descrizione App Store</h2>
E' la prima applicazione, che in caso di emergenza, permette di avvisare parenti e amici con un messaggio personalizzato
che include anche le coordinate geoografiche della posizione attuale, con un semplice click del dito!

<h4>Funzionamento</h4>
All'apertura dell'applicazione la prima volta si dovranno inserire i paramentri iniziali, come il numero di telefono.
Alle successive aperture la schermata principale sarà formata da 3 bottini. 
* SOS  se premuto permette di inviare un messaggio col testo scelto precedentemente nella schermata settings ai destinatari preselezionati e immediatamente dopo partirà una chiamata al numero precedentemente scelto. 
* Call  permette di chiamare istantaneamente il numero di telefono precedentemente scelto.
* SMS  permette di inviare un messaggio con coordinate e testo ai testinatari scelti.

<h3>Versione Free</h3>
* In questa versione non sarà possibile utilizzare la localizzazione, quindi non verranno inserite le coordinate geografiche nel messaggio.
* Si potrà inserire un solo numero di telefono il quale sarà in automatico il destinatario della chiamata e del messaggio.
* Non si potrà personalizzare il messaggio di aiuto.

<h3>Versione Plus</h3>
* Sarà possibile inserire un numero di telefono e due destinatari di messaggi distinti
* Si potrà scegliere se attivare o meno la localizzazione.
* Sarà possibile personalizzare il messaggio di aiuto.

====

<h2> Impostazioni Iniziali </h2>
1) All'apertura dell'applicazione bisognerà andare nella schermata settings per inserire i parametri iniziali.<br>
2) Per fare in modo che la localizzione si attivi bisogna mettere uno stop alla riga 256, metodo (findCurretLocation), classe FirstViewController.<br>
successivamente avviare il programma in modalità debug e premere il pulsante "Send SMS". <br>
Il programma si bloccherà e verrà mostrato un avviso sulla localizzazione. <br>
Premere OK e continuare con l'esecuzione del programma. <br>

<h2> Informazioni Funzionamento </h2>
* Con il pulsante SOS si aprirà una schermata di messaggi già impostata con destinatari, messaggi e coordinate e se si preme invio il messaggio sarà inviato e partirà immediantamente la chiamata al numero desiderato
* Con il pulsante Call partirà una chiamata al destinatario impostato nella schermata settings.
* Con il pulsante Send SMS si visualizzerà una schermata con il messaggio già impostato con i vari destinatari, il testo e le coordinate.

<h3> Versione Free </h3>

* Sarà possibile inserire solo un numero da chiamare (che sarà lo stesso destinatario del messaggio).
* La localizzazione non è attivata.
* Il messaggio di aiuto non è modificabile.

<h3> Versione Plus </h3>
* Si potrà inserire il numero da chiamare.
* Si potranno inserire 2 destinatari per i messsaggi (diversi dal numero che si chiama).
* Si potrà modificare il messaggio di aiuto.
* Si potrà attiviare la localizzazione.


Applicazione di Emergenza
