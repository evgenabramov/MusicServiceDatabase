CREATE SCHEMA music_service;

CREATE TABLE music_service.artist
(
    name       VARCHAR(50) PRIMARY KEY,
    hometown   VARCHAR(50),
    birth_date DATE CHECK (birth_date < now()::date),
    genre      VARCHAR(50),
    about      VARCHAR(1000)
);

CREATE TABLE music_service.album
(
    name        VARCHAR(50),

    artist      VARCHAR(50) REFERENCES music_service.artist (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    main_artist VARCHAR(50) REFERENCES music_service.artist (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    album_id    SERIAL      NOT NULL,
    year        SMALLINT    NOT NULL CHECK (year > 0),
    genre       VARCHAR(50) NOT NULL,
    duration    INTEGER     NOT NULL CHECK (duration > 0),
    num_songs   SMALLINT    NOT NULL CHECK (num_songs > 0),
    label       VARCHAR(50),
    description VARCHAR(1000),

    UNIQUE (artist, name, main_artist),
    PRIMARY KEY (artist, name)
);

CREATE TABLE music_service.song
(
    name        VARCHAR(50),

    artist      VARCHAR(50) REFERENCES music_service.artist (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    main_artist VARCHAR(50) REFERENCES music_service.artist (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    song_id     SERIAL  NOT NULL,
    duration    INTEGER NOT NULL CHECK (duration > 0),
    lyrics      VARCHAR(3500),

    UNIQUE (artist, name, main_artist),
    PRIMARY KEY (artist, name)
);

CREATE TABLE music_service.album_music
(
    artist      VARCHAR(50) REFERENCES music_service.artist (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    main_artist VARCHAR(50) REFERENCES music_service.artist (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    album       VARCHAR(50),
    song        VARCHAR(50),

    PRIMARY KEY (artist, album, song),
    FOREIGN KEY (artist, song, main_artist) REFERENCES music_service.song (artist, name, main_artist)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (artist, album, main_artist) REFERENCES music_service.album (artist, name, main_artist)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE music_service.playlist
(
    name        VARCHAR(50) PRIMARY KEY,
    update_date DATE CHECK (update_date <= now()::date) DEFAULT now()::date,
    duration    INTEGER NOT NULL CHECK (duration > 0),
    num_songs   INTEGER NOT NULL CHECK (duration > 0),
    description VARCHAR(1000)
);

CREATE TABLE music_service.playlist_music
(
    artist   VARCHAR(50) REFERENCES music_service.artist (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    playlist VARCHAR(50) REFERENCES music_service.playlist (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    song     VARCHAR(50),
    song_id  SERIAL NOT NULL,

    PRIMARY KEY (artist, playlist, song),
    FOREIGN KEY (song, artist) REFERENCES music_service.song (name, artist)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- INSERT INTO ARTIST TABLE
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Mac Demarco', 'Duncan, British Columbia, Canada', '1990-04-30', 'Alternative',
        'McBriare Samuel Lanyon "Mac" DeMarco is a Canadian singer-songwriter, multi-instrumentalist and producer. DeMarco has released three full-length studio albums, 2 (2012), Salad Days (2014), and This Old Dog (2017), as well as two mini-LPs: his debut Rock and Roll Night Club (2012) and Another One (2015). His style of music has been described as "blue wave" and "slacker rock", or, by DeMarco himself, "jizz jazz".');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Tame Impala', 'Perth, Australia', '1986-01-20', 'Alternative',
        'Tame Impala is an Australian psychedelic music project led by multi-instrumentalist Kevin Parker, who writes, records, performs, and produces the music. As a touring act, Parker (guitar, vocals) plays alongside Dominic Simper (guitar, synthesiser) and some members of Australian psychedelic rock band Pond – Jay Watson (synthesiser, vocals, guitar), Cam Avery (bass guitar, vocals), and Julien Barbagallo (drums, vocals). Previously signed to Modular Recordings, Tame Impala is now signed to Interscope Records in the US, and Fiction Records in the UK.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Cage the Elephant', 'Bowling Green, KY', '1983-10-23', 'Alternative',
        'Cage the Elephant is an American rock band from Bowling Green, Kentucky, that formed in 2006 and relocated to London, England, in 2008 before their first album was released. The band currently consists of lead vocalist Matt Shultz, rhythm guitarist Brad Shultz, lead guitarist Nick Bockrath, guitarist and keyboardist Matthan Minster, bassist Daniel Tichenor, and drummer Jared Champion. Lincoln Parish served as the band''s lead guitarist from their formation in 2006 until December 2013, when he left on good terms to pursue a career in producing. The band''s first album, Cage the Elephant, was released in 2008 to much success, spawning several successful radio singles and gained the band a large following in both the United States and the United Kingdom.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Kanye West', 'Atlanta, GA', '1977-06-08', 'Hip-hop/Rap',
        'Kanye Omari West is an American rapper, singer, songwriter, record producer, entrepreneur, and fashion designer. His musical career has been marked by dramatic changes in styles, incorporating an eclectic range of influences including soul, baroque pop, electro, indie rock, synth-pop, industrial, and gospel. Over the course of his career, West has been responsible for cultural movements and progressions within mainstream hip hop and popular music at large.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('JAY-Z', 'New-York, NY [Brooklyn]', '1969-12-04', 'Hip-hop/Rap',
        'Shawn Corey Carter, known professionally as Jay-Z (stylized as JAY-Z), is an American rapper, songwriter, record producer, entrepreneur, and record executive. Considered one of the best rappers of all time, he is regarded as one of the world''s most significant cultural icons and has been a global figure in popular culture for over two decades.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Beyoncé', 'Houston, Texas', '1981-07-04', 'Pop',
        'Beyoncé Giselle Knowles-Carter is an American singer, songwriter, actress, record producer and dancer. Born and raised in Houston, Texas, Beyoncé performed in various singing and dancing competitions as a child. She rose to fame in the late 1990s as lead singer of the R&B girl-group Destiny''s Child. Managed by her father, Mathew Knowles, the group became one of the best-selling girl groups in history. Their hiatus saw Beyoncé''s theatrical film debut in Austin Powers in Goldmember (2002) and the release of her first solo album, Dangerously in Love (2003). The album established her as a solo artist worldwide, debuting at number one on the US Billboard 200 chart and earning five Grammy Awards, and featured the Billboard Hot 100 number-one singles "Crazy in Love" and "Baby Boy".');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('ASAP Rocky', 'New York, U.S.', '1988-10-03', 'Hip-hop/Rap',
        'Rakim Mayers, known by his stage name ASAP Rocky (stylized as A$AP Rocky), is an American rapper, actor and music video director. He is a member of the hip hop group A$AP Mob, from which he adopted his moniker.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Tyler, The Creator', 'Ladera Heights, CA', '1991-03-06', 'Hip-hop/Rap',
        'Tyler Gregory Okonma, known professionally as Tyler, the Creator, is an American rapper, songwriter, record producer, music video director and designer. He rose to prominence as the co-founder and de facto leader of the alternative hip hop collective Odd Future, and has performed on and produced songs for nearly every Odd Future release. Okonma has created all the artwork for the group''s releases and has also designed the group''s clothing and other merchandise. As a solo artist, Okonma has released one mixtape and four studio albums, often handling most or all production himself.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Adele', 'Tottenham, London, England', '1988-05-05', 'Pop',
        'Adele Laurie Blue Adkins is an English singer-songwriter. After graduating from the BRIT School in 2006, Adele signed a recording contract with XL Recordings. In 2007, she received the Brit Awards Critics'' Choice award and won the BBC Sound of 2008 poll. Her debut album, 19, was released in 2008 to commercial and critical success. It is certified eight times platinum in the UK, and three times platinum in the US. The album contains her first song, "Hometown Glory", written when she was 16, which is based on her home suburb of West Norwood in London. An appearance she made on Saturday Night Live in late 2008 boosted her career in the US. At the 51st Grammy Awards in 2009, Adele received the awards for Best New Artist and Best Female Pop Vocal Performance.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Calvin Harris', 'Dumfries, Scotland', '1984-01-17', 'Dance',
        'Adam Richard Wiles, known professionally as Calvin Harris, is a Scottish DJ, record producer, singer, and songwriter from Dumfries. He is best known for his singles "We Found Love", "This Is What You Came For", "Summer", Feel So Close", and "Feels". His collaboration single with Rihanna, "We Found Love", became an international success, giving Harris his first number one single on the US Billboard Hot 100 chart. He has released five studio albums and runs his own record label, Fly Eye Records, which he founded in 2010.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Desiigner', 'New York, U.S.', '1997-05-03', 'Hip-hop/Rap',
        'Sidney Royel Selby III, better known by his stage name Desiigner, is an American rapper, hip hop musician recording artist and singer-songwriter. He rose to prominence in 2016 after the release of his debut single "Panda", which reached number one on the U.S. Billboard Hot 100.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Rihanna', 'Saint Michael, Barbados', '1988-02-20', 'Pop',
        'Robyn Rihanna Fenty is a Barbadian singer, businesswoman and actress. Born in Saint Michael and raised in Bridgetown, Rihanna was discovered by American record producer Evan Rogers in her home country in 2003. Throughout 2004, she recorded demo tapes under the direction of Rogers; this led to her securing a recording contract with Def Jam Recordings after she auditioned for its then-president, Jay-Z.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Swizz Beatz', 'New York, U.S.', '1978-09-13', 'Rap',
        'Kasseem Dean, known professionally as Swizz Beatz, is an American record producer, rapper, DJ, art collector, and entrepreneur from New York City. Born and raised in The Bronx, Dean began his musical career as a disc jockey (DJ). At the age of 16, he gained recognition in the hip hop industry through his friendship and work with East Coast rapper DMX and the Ruff Ryders Entertainment record label.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('French Montana', 'Casablanca, Morocco', '1984-11-09', 'Rap',
        'Karim Kharbouch, better known by his stage name French Montana, is a Moroccan-American rapper, singer and songwriter. Born and raised in Morocco, he immigrated to the United States with his family when he was 13.[1][2] He is the founder of Coke Boys Records, and its predecessor Cocaine City Records. In 2012, he signed a joint-venture recording deal with Bad Boy Records and Maybach Music Group.');
INSERT INTO music_service.artist(name, hometown, birth_date, genre, about)
VALUES ('Pasosh', 'Moscow, Russia', '1994-07-13', 'Punk',
        'The founder and frontman of the group is Petar martich, an ethnic Serb who moved to Russia at the age of nine, received higher education in England, and then returned to Russia. In the framework of the project "Jump pussy" Petar recorded tracks that in 2014 were widely popular among young people and often laid out in public groups in the social network "Vkontakte".');


-- INSERT INTO ALBUM TABLE
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('The Life Of Pablo', 'Kanye West', 'Kanye West', 2016, 'Hip-hop/Rap', 66, 20, 'Getting Out Our Dreams',
        'The Life of Pablo is the seventh studio album by American rapper and recording artist Kanye West, released on February 14, 2016 by GOOD Music and Def Jam Recordings. Recording sessions took place from 2013 to 2016 in Italy, Mexico, Canada, and the United States. Production on the album was handled by West and a variety of producers, including co-executive producers Rick Rubin and Noah Goldstein, Mike Dean, Metro Boomin, Hudson Mohawke, Plain Pat, and Madlib.');
INSERT INTO music_service.album(album_id, name, artist, main_artist, year, genre, duration, num_songs, label,
                                description)
VALUES (CURRVAL('music_service.album_album_id_seq'), 'The Life Of Pablo', 'Desiigner', 'Kanye West', 2016,
        'Hip-hop/Rap', 66, 20, 'Getting Out Our Dreams',
        'The Life of Pablo is the seventh studio album by American rapper and recording artist Kanye West, released on February 14, 2016 by GOOD Music and Def Jam Recordings. Recording sessions took place from 2013 to 2016 in Italy, Mexico, Canada, and the United States. Production on the album was handled by West and a variety of producers, including co-executive producers Rick Rubin and Noah Goldstein, Mike Dean, Metro Boomin, Hudson Mohawke, Plain Pat, and Madlib.');
INSERT INTO music_service.album(album_id, name, artist, main_artist, year, genre, duration, num_songs, label,
                                description)
VALUES (CURRVAL('music_service.album_album_id_seq'), 'The Life Of Pablo', 'Rihanna', 'Kanye West', 2016, 'Hip-hop/Rap',
        66, 20, 'Getting Out Our Dreams',
        'The Life of Pablo is the seventh studio album by American rapper and recording artist Kanye West, released on February 14, 2016 by GOOD Music and Def Jam Recordings. Recording sessions took place from 2013 to 2016 in Italy, Mexico, Canada, and the United States. Production on the album was handled by West and a variety of producers, including co-executive producers Rick Rubin and Noah Goldstein, Mike Dean, Metro Boomin, Hudson Mohawke, Plain Pat, and Madlib.');
INSERT INTO music_service.album(album_id, name, artist, main_artist, year, genre, duration, num_songs, label,
                                description)
VALUES (CURRVAL('music_service.album_album_id_seq'), 'The Life Of Pablo', 'Swizz Beatz', 'Kanye West', 2016,
        'Hip-hop/Rap', 66, 20, 'Getting Out Our Dreams',
        'The Life of Pablo is the seventh studio album by American rapper and recording artist Kanye West, released on February 14, 2016 by GOOD Music and Def Jam Recordings. Recording sessions took place from 2013 to 2016 in Italy, Mexico, Canada, and the United States. Production on the album was handled by West and a variety of producers, including co-executive producers Rick Rubin and Noah Goldstein, Mike Dean, Metro Boomin, Hudson Mohawke, Plain Pat, and Madlib.');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('ye', 'Kanye West', 'Kanye West', 2018, 'Hip-hop/Rap', 24, 7, 'Getting Out Our Dreams',
        'Ye is the eponymous eighth studio album by American rapper Kanye West. It was released on June 1, 2018, by GOOD Music and Def Jam Recordings. Following controversy surrounding his sociopolitical views, West re-wrote and recorded all the work on the album, completing it over the course of just two weeks at a ranch in Jackson Hole, Wyoming. It is his first studio album in two years since the release of The Life of Pablo in 2016.');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('At. Long. Last. ASAP', 'ASAP Rocky', 'ASAP Rocky', 2015, 'Hip-hop/Rap', 66, 18, 'ASAP Worldwide',
        'At. Long. Last. ASAP is the second studio album by American rapper ASAP Rocky. It was released on May 26, 2015, by ASAP Worldwide, Polo Grounds Music and RCA Records. The record serves as a sequel from Rocky''s previous studio effort Long. Live. ASAP (2013).');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('21', 'Adele', 'Adele', 2011, 'Pop', 52, 12, 'XL Recordings',
        '21 is the second studio album by English singer-songwriter Adele. It was released on 24 January 2011 in Europe and on 22 February 2011 in North America by XL Recordings and Columbia Records. The album was named after the age of the singer during its production. 21 shares the folk and Motown soul influences of her 2008 debut album 19, but was further inspired by the American country and Southern blues music to which she had been exposed during her 2008–09 North American tour An Evening with Adele.');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('Another One', 'Mac Demarco', 'Mac Demarco', 2015, 'Alternative', 24, 8, 'Captured Tracks',
        'Another One is a mini-LP by Canadian singer-songwriter Mac DeMarco released on August 7, 2015 by Captured Tracks. The mini-LP was preceded by the release of four streaming singles on Spotify, "The Way You''d Love Her", "Another One", "I''ve Been Waiting for Her", and "No Other Heart". The title track was accompanied by a music video directed by DeMarco himself.');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('Salad Days', 'Mac Demarco', 'Mac Demarco', 2014, 'Alternative', 35, 11, 'Captured Tracks',
        'Salad Days is the second full-length studio album by Canadian musician Mac DeMarco released on April 1, 2014 through Captured Tracks. Following the debut releases of Rock and Roll Night Club and 2 in 2012 and the extensive touring for both releases in 2013, DeMarco worked on material for his next album at his Bedford-Stuyvesant apartment in Brooklyn. Salad Days garnered acclaim from critics, and debuted at number 30 on the Billboard 200.');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('Flower Boy', 'Tyler, The Creator', 'Tyler, The Creator', 2017, 'Hip-hop/Rap', 47, 14, 'Columbia Records',
        'Flower Boy is the fourth studio album by American rapper Tyler, the Creator. The album was released on July 21, 2017, by Columbia Records. Produced entirely by Tyler, the album features guest vocals from a range of artists; including Frank Ocean, ASAP Rocky, Anna of the North, Lil Wayne, Kali Uchis, Steve Lacy, Estelle, Jaden Smith and Rex Orange County.');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('Currents', 'Tame Impala', 'Tame Impala', 2015, 'Alternative', 51, 13, 'Modular Recordings',
        'Currents is the third studio album by Australian artist Tame Impala. It was released on 17 July 2015 by Modular Recordings and Universal Music Australia, Interscope Records in the United States, and Fiction Records and Caroline International in other international regions. Like the group''s previous two albums, Currents was written, recorded, performed, and produced by primary member Kevin Parker. For the first time, Parker mixed the music and recorded all instruments by himself; the album featured no other collaborators.');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('Funk Wav Bounces Vol. 1', 'Calvin Harris', 'Calvin Harris', 2017, 'Funk', 38, 10, 'Sony Music Entertainment',
        'Funk Wav Bounces Vol. 1 is the fifth studio album by Scottish DJ and record producer Calvin Harris. It was released on 30 June 2017 by Columbia Records. The album features guest vocals by Frank Ocean, Migos, Schoolboy Q, PartyNextDoor, DRAM, Young Thug, Pharrell Williams, Ariana Grande, Future, Khalid, Travis Scott, Snoop Dogg, John Legend, Nicki Minaj, Katy Perry, Big Sean, Kehlani, Lil Yachty and Jessie Reyez, as well as prominent writing contributions from Starrah.');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('Tell me I''m pretty', 'Cage the Elephant', 'Cage the Elephant', 2015, 'Alternative', 38, 10, 'RCA Records',
        'Cage the Elephant released their fourth album, Tell Me I''m Pretty, on December 18, 2015, with Dan Auerbach, a member of The Black Keys, as the producer.[23] The band said they "just wanted to experiment with sounds. While you start experimenting with sound and you get out there a little bit, away from the norm, I think people will see that as psychedelic." This project reached farther then their usual work.');
INSERT INTO music_service.album(name, artist, main_artist, year, genre, duration, num_songs, label, description)
VALUES ('21', 'Pasosh', 'Pasosh', 2016, 'Punk', 31, 8, 'RDS Records',
        'An album recorded by group and released March 21, 2016 in Moscow');
-- INSERT INTO SONG TABLE
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('Salad Days', 'Mac Demarco', 'Mac Demarco', 146, '[Verse 1]
As I’m getting older, chip up on my shoulder
Rolling through life, to roll over and die

[Scat Singing]

[Verse 2]
Missing Hippie Jon, salad days are gone
Remembering things just to tell ‘em so long

[Scat Singing]

[Chorus]
Oh mama, actin’ like my life’s already over
Oh dear, act your age and try another year

[Verse 3]
Always feeling tired, smiling when required
Write another year off and kindly resign

[Scat Singing]

[Verse 4]
Salad days are gone, missing Hippie Jon
Remember the days just to tell ‘em so long''

[Scat Singing]

[Chorus]
Oh mama, actin’ like my life’s already over
Oh dear, act your age and try another year
Oh mama, actin’ like my life’s already over
Oh dear, act your age and try another year');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('Brother', 'Mac Demarco', 'Mac Demarco', 213, '[Intro]
Shit

[Verse 1]
You’re no better off
Living your life
Than dreaming at night
This much is true
But it’s still up to you
To take my advice

[Pre-Chorus]
To take it slowly, brother
Let it go now, brother
Take it slowly, brother
Let it go

[Chorus]
Go home, go home
Go home, go home

[Verse 2]
You’re better off dead
When your mind’s been set
From nine until five
How could it be true
Well it’s happened to you
So take my advice

[Pre-Chorus]
To take it slowly, brother
Let it go now, brother
Take it slowly, brother
Let it go

[Chorus]
Go home, go home
Go home, go home
Go home, go home
Go home, go home');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('The Way You''d Love Her', 'Mac Demarco', 'Mac Demarco', 156, '[Verse 1: Mac Demarco]
How''s your heart been beating?
How''s your skin been keeping?
How''s the dream been going since you''ve came back home this time?
You left her out there somewhere
Told her how you feel but
Never really got the chance to show her what it really means to love her

[Chorus]
The way you''d love her
The way you''d love to love her
The way you''d love her

[Verse 2: Mac Demarco]
Closer to the ending
She''s still out pretending
Prying eyes won''t recognize the way she feels about him
She''ll just go on living
The river keeps on rolling
Knowing all the time she''ll never understand just what it means to love her

[Chorus]
The way you''d love her
The way you''d love to love her
The way you''d love her


[Chorus]
Love her
The way you''d love her
The way you''d love to love her
The way you''d love her');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('Pt. 2', 'Kanye West', 'Kanye West', 130, '[Intro]
Faaaaaaaa—
Perfect
Faaaaaaaa—
Faaaaaaaa—
Faaaaaaaa—

[Verse 1: Kanye West]
I told, I told, ayy-ayy, I told you
Up in the mornin'', miss you bad
Sorry I ain''t call you back, same problem my father had
All this time, all he had, all he had
And what he dreamed, all his cash
Market crashed, hurt him bad
People get divorced for that
Dropped some stacks, pops is good
Mama passed in Hollywood
If you ask, lost my soul
Drivin'' fast, lost control
Off the road, jaw was broke
''Member we all was broke
''Member I''m comin'' back
I''ll be takin'' all the stacks, oh

[Verse 2: Desiigner & Kanye West]
I got broads in Atlanta
Twistin'' dope, lean, and the Fanta
Stacks, oh
Credit cards and the scammers
Hittin'' off licks in the bando
Takin'' all the stacks, oh
Black X6, Phantom
White X6 looks like a panda
Stacks, oh
Going out like I''m Montana
Hundred killers, hundred hammers
Black X6, Phantom
White X6, panda
Pockets swole, Danny
Sellin'' bar, candy
Man I''m the macho like Randy
The choppa go Oscar for Grammy
Bitch nigga, pull up ya panty
Hope you killas understand me


[Chorus: Kanye West & Desiigner]
I just wanna feel liberated, I, I, I (hey)
I just wanna feel liberated, I, I, I (Panda)
Panda, panda, panda, panda
Takin'' all the stacks, oh
Panda, panda, panda
Stacks, oh
Takin'' all the stacks, oh

[Verse 3: Desiigner & Kanye West]
I got broads in Atlanta
Twist the dope, lean and shit, sippin'' Fanta
Stacks, oh
Credit cards and the scammers
Wake up Versace, shit life Desiigner
Takin'' all the stacks, oh
Whole bunch of lavish shit
They be askin'' ''round town who be clappin'' shit
I be pullin'' up stuff in the Phantom ship
I got plenty of stuff of Bugatti, whip look how I try this shit
Black X6, Phantom
White X6, killin'' on camera

[Bridge: Caroline Shaw]
How can I find you?
Who do you turn to?
How do I bind you?');
INSERT INTO music_service.song(song_id, name, artist, main_artist, duration, lyrics)
VALUES (CURRVAL('music_service.song_song_id_seq'), 'Pt. 2', 'Desiigner', 'Kanye West', 130, '[Intro]
Faaaaaaaa—
Perfect
Faaaaaaaa—
Faaaaaaaa—
Faaaaaaaa—

[Verse 1: Kanye West]
I told, I told, ayy-ayy, I told you
Up in the mornin'', miss you bad
Sorry I ain''t call you back, same problem my father had
All this time, all he had, all he had
And what he dreamed, all his cash
Market crashed, hurt him bad
People get divorced for that
Dropped some stacks, pops is good
Mama passed in Hollywood
If you ask, lost my soul
Drivin'' fast, lost control
Off the road, jaw was broke
''Member we all was broke
''Member I''m comin'' back
I''ll be takin'' all the stacks, oh

[Verse 2: Desiigner & Kanye West]
I got broads in Atlanta
Twistin'' dope, lean, and the Fanta
Stacks, oh
Credit cards and the scammers
Hittin'' off licks in the bando
Takin'' all the stacks, oh
Black X6, Phantom
White X6 looks like a panda
Stacks, oh
Going out like I''m Montana
Hundred killers, hundred hammers
Black X6, Phantom
White X6, panda
Pockets swole, Danny
Sellin'' bar, candy
Man I''m the macho like Randy
The choppa go Oscar for Grammy
Bitch nigga, pull up ya panty
Hope you killas understand me


[Chorus: Kanye West & Desiigner]
I just wanna feel liberated, I, I, I (hey)
I just wanna feel liberated, I, I, I (Panda)
Panda, panda, panda, panda
Takin'' all the stacks, oh
Panda, panda, panda
Stacks, oh
Takin'' all the stacks, oh

[Verse 3: Desiigner & Kanye West]
I got broads in Atlanta
Twist the dope, lean and shit, sippin'' Fanta
Stacks, oh
Credit cards and the scammers
Wake up Versace, shit life Desiigner
Takin'' all the stacks, oh
Whole bunch of lavish shit
They be askin'' ''round town who be clappin'' shit
I be pullin'' up stuff in the Phantom ship
I got plenty of stuff of Bugatti, whip look how I try this shit
Black X6, Phantom
White X6, killin'' on camera

[Bridge: Caroline Shaw]
How can I find you?
Who do you turn to?
How do I bind you?');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('Famous', 'Kanye West', 'Kanye West', 196, '[Intro: Rihanna & Kanye West]
Man, I can understand how it might be
Kinda hard to love a girl like me
I don''t blame you much for wanting to be free
I just wanted you to know
Swizz told me let the beat rock

[Verse 1: Kanye West & Swizz Beatz]
For all my Southside niggas that know me best
I feel like me and Taylor might still have sex
Why? I made that bitch famous (Goddamn)
I made that bitch famous
For all the girls that got dick from Kanye West
If you see ''em in the streets give ''em Kanye''s best
Why? They mad they ain''t famous (Goddamn)
They mad they still nameless (Talk that talk, man)
Her man in the store tryna try his best
But he just can''t seem to get Kanye fresh
But we still hood famous (Goddamn)
Yeah, we still hood famous

[Chorus: Rihanna & Swizz Beatz]
I just wanted you to know
I''ve loved you better than your own kin did
From the very start
I don''t blame you much for wanting to be free
Wake up, Mr. West! Oh, he''s up!
I just wanted you to know


[Verse 2: Kanye West & Swizz Beatz]
I be Puerto Rican day parade floatin''
That Benz Marina Del Rey coastin''
She in school to be a real estate agent
Last month I helped her with the car payment
Young and we alive, whoo!
We never gonna die, whoo!
I just copped a jet to fly over personal debt
Put one up in the sky
The sun is in my eyes, whoo!
Woke up and felt the vibe, whoo!
No matter how hard they try, whoo!
We never gonna die

[Chorus: Rihanna & Swizz Beatz]
I just wanted you to know
Get ''em!

[Bridge: Sister Nancy & Swizz Beatz]
Bam, ''ey ''ey ''ey
Bam bam, bam, bam bam dilla
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
How you feeling right now? Let me see your lighters in the air
Bam bam ''ey ''ey ''ey ''ey ''ey
Bam bam ''ey ''ey ''ey
What a bam
Let me see your middle finger in the air
Bam ''ey ''ey ''ey
Bam bam, bam, bam bam dilla
Let me see you act up in this motherfucker
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
How you feelin'', how you feelin, how you feelin'' in this mother fucker, god damn
Bam bam ''ey ''ey ''ey ''ey ''ey
Bam bam ''ey ''ey ''ey
What a bam
One thing you can''t do is stop us now
Bam ''ey ''ey ''ey
Bam bam bam, bam bam dilla
Ayy, you can''t stop the thing now
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
Man, it''s way too late, it''s way too late, it''s way too late, you can''t fuck with us
Bam bam, ''ey ''ey ''ey ''ey ''ey
Bam bam, ''ey ''ey ''ey
What a bam
To the left, to the right
Bam ''ey ''ey ''ey
Bam bam bam, bam bam dilla
I wanna see everybody hands in the air like this
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
Bam bam ''ey ''ey ''ey ''ey ''ey
Bam bam ''ey ''ey ''ey
What a bam, bam


[Outro: Nina Simone]
I just wanted you to know
I loved you better than your own kin did
From the very start
I don''t blame you much for wanting to be free
I just wanted you to know
');
INSERT INTO music_service.song(song_id, name, artist, main_artist, duration, lyrics)
VALUES (CURRVAL('music_service.song_song_id_seq'), 'Famous', 'Rihanna', 'Kanye West', 196, '[Intro: Rihanna & Kanye West]
Man, I can understand how it might be
Kinda hard to love a girl like me
I don''t blame you much for wanting to be free
I just wanted you to know
Swizz told me let the beat rock

[Verse 1: Kanye West & Swizz Beatz]
For all my Southside niggas that know me best
I feel like me and Taylor might still have sex
Why? I made that bitch famous (Goddamn)
I made that bitch famous
For all the girls that got dick from Kanye West
If you see ''em in the streets give ''em Kanye''s best
Why? They mad they ain''t famous (Goddamn)
They mad they still nameless (Talk that talk, man)
Her man in the store tryna try his best
But he just can''t seem to get Kanye fresh
But we still hood famous (Goddamn)
Yeah, we still hood famous

[Chorus: Rihanna & Swizz Beatz]
I just wanted you to know
I''ve loved you better than your own kin did
From the very start
I don''t blame you much for wanting to be free
Wake up, Mr. West! Oh, he''s up!
I just wanted you to know


[Verse 2: Kanye West & Swizz Beatz]
I be Puerto Rican day parade floatin''
That Benz Marina Del Rey coastin''
She in school to be a real estate agent
Last month I helped her with the car payment
Young and we alive, whoo!
We never gonna die, whoo!
I just copped a jet to fly over personal debt
Put one up in the sky
The sun is in my eyes, whoo!
Woke up and felt the vibe, whoo!
No matter how hard they try, whoo!
We never gonna die

[Chorus: Rihanna & Swizz Beatz]
I just wanted you to know
Get ''em!

[Bridge: Sister Nancy & Swizz Beatz]
Bam, ''ey ''ey ''ey
Bam bam, bam, bam bam dilla
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
How you feeling right now? Let me see your lighters in the air
Bam bam ''ey ''ey ''ey ''ey ''ey
Bam bam ''ey ''ey ''ey
What a bam
Let me see your middle finger in the air
Bam ''ey ''ey ''ey
Bam bam, bam, bam bam dilla
Let me see you act up in this motherfucker
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
How you feelin'', how you feelin, how you feelin'' in this mother fucker, god damn
Bam bam ''ey ''ey ''ey ''ey ''ey
Bam bam ''ey ''ey ''ey
What a bam
One thing you can''t do is stop us now
Bam ''ey ''ey ''ey
Bam bam bam, bam bam dilla
Ayy, you can''t stop the thing now
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
Man, it''s way too late, it''s way too late, it''s way too late, you can''t fuck with us
Bam bam, ''ey ''ey ''ey ''ey ''ey
Bam bam, ''ey ''ey ''ey
What a bam
To the left, to the right
Bam ''ey ''ey ''ey
Bam bam bam, bam bam dilla
I wanna see everybody hands in the air like this
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
Bam bam ''ey ''ey ''ey ''ey ''ey
Bam bam ''ey ''ey ''ey
What a bam, bam


[Outro: Nina Simone]
I just wanted you to know
I loved you better than your own kin did
From the very start
I don''t blame you much for wanting to be free
I just wanted you to know
');
INSERT INTO music_service.song(song_id, name, artist, main_artist, duration, lyrics)
VALUES (CURRVAL('music_service.song_song_id_seq'), 'Famous', 'Swizz Beatz', 'Kanye West', 196, '[Intro: Rihanna & Kanye West]
Man, I can understand how it might be
Kinda hard to love a girl like me
I don''t blame you much for wanting to be free
I just wanted you to know
Swizz told me let the beat rock

[Verse 1: Kanye West & Swizz Beatz]
For all my Southside niggas that know me best
I feel like me and Taylor might still have sex
Why? I made that bitch famous (Goddamn)
I made that bitch famous
For all the girls that got dick from Kanye West
If you see ''em in the streets give ''em Kanye''s best
Why? They mad they ain''t famous (Goddamn)
They mad they still nameless (Talk that talk, man)
Her man in the store tryna try his best
But he just can''t seem to get Kanye fresh
But we still hood famous (Goddamn)
Yeah, we still hood famous

[Chorus: Rihanna & Swizz Beatz]
I just wanted you to know
I''ve loved you better than your own kin did
From the very start
I don''t blame you much for wanting to be free
Wake up, Mr. West! Oh, he''s up!
I just wanted you to know


[Verse 2: Kanye West & Swizz Beatz]
I be Puerto Rican day parade floatin''
That Benz Marina Del Rey coastin''
She in school to be a real estate agent
Last month I helped her with the car payment
Young and we alive, whoo!
We never gonna die, whoo!
I just copped a jet to fly over personal debt
Put one up in the sky
The sun is in my eyes, whoo!
Woke up and felt the vibe, whoo!
No matter how hard they try, whoo!
We never gonna die

[Chorus: Rihanna & Swizz Beatz]
I just wanted you to know
Get ''em!

[Bridge: Sister Nancy & Swizz Beatz]
Bam, ''ey ''ey ''ey
Bam bam, bam, bam bam dilla
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
How you feeling right now? Let me see your lighters in the air
Bam bam ''ey ''ey ''ey ''ey ''ey
Bam bam ''ey ''ey ''ey
What a bam
Let me see your middle finger in the air
Bam ''ey ''ey ''ey
Bam bam, bam, bam bam dilla
Let me see you act up in this motherfucker
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
How you feelin'', how you feelin, how you feelin'' in this mother fucker, god damn
Bam bam ''ey ''ey ''ey ''ey ''ey
Bam bam ''ey ''ey ''ey
What a bam
One thing you can''t do is stop us now
Bam ''ey ''ey ''ey
Bam bam bam, bam bam dilla
Ayy, you can''t stop the thing now
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
Man, it''s way too late, it''s way too late, it''s way too late, you can''t fuck with us
Bam bam, ''ey ''ey ''ey ''ey ''ey
Bam bam, ''ey ''ey ''ey
What a bam
To the left, to the right
Bam ''ey ''ey ''ey
Bam bam bam, bam bam dilla
I wanna see everybody hands in the air like this
Bam bam ''ey ''ey ''ey
What a bam, bam, bam bam dilla
Bam bam ''ey ''ey ''ey ''ey ''ey
Bam bam ''ey ''ey ''ey
What a bam, bam


[Outro: Nina Simone]
I just wanted you to know
I loved you better than your own kin did
From the very start
I don''t blame you much for wanting to be free
I just wanted you to know
');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('Wolves', 'Kanye West', 'Kanye West', 302, '[Chorus: Kanye West]
Lost out, beat up
Dancin'', down there
I found you, somewhere out
''Round ''round there, right right there
Lost and beat up
Down there, dancin''
I found you, somewhere out
Right down there, right ''round there

[Verse 1: Kanye West]
Lost and, found out
Turned out, how you thought
Daddy, found out
That you turned out, how you turned out
If mama knew now
How you turned out, you too wild
You too wild, you too wild
You too wild, I need you now
Love you, got to
Love you, love you
Found you, found you
Right now, right now
Right now, right now
If your mama knew how
You turned out, you too wild
You too wild, you too wild
You too wild, and I need you now
Lost in... my doubt

[Bridge: Vic Mensa]
Cry, I''m not sorry
Cry, who needs sorry when there''s Hennessy?
Don''t fool yourself
Your eyes don''t lie, you''re much too good to be true
Don''t fire fight
Yeah I feel you burning, everything''s burning
Don''t fly so high
Your wings might melt, you''re much too good to be true
I''m just bad for you
I''m just bad, bad, bad for you

[Verse 2: Sia]
I was lost and beat up
Turned out, burned up
You found me, through a heartache
Didn''t know me, you were drawn in
I was lost and beat up
I was warm flesh, unseasoned
You found me, in your gaze
Well, I found me, oh, Jesus
I was too wild, I was too wild
I was too wild, I was too wild
I was too wild, I was too wild

[Chorus: Kanye West]
And I need you now
Lost and found out


[Verse 3: Kanye West]
You gotta let me know if I could be your Joseph
Only tell you real shit, that''s the tea, no sip
Don''t trip, don''t trip, that pussy slippery, no whip
We ain''t trippin'' on shit, we just sippin'' on this
Just forget the whole shit, we could laugh about nothin''
I impregnate your mind, let''s have a baby without fuckin'', yo
I know it''s corny bitches you wish you could unfollow
I know it''s corny niggas you wish you could unswallow
I know it''s corny bitches you wish you could unfollow
I know it''s corny niggas you wish you could unswallow
I know it''s corny bitches you wish you could unfollow
I know it''s corny niggas you wish you could unswallow
You tried to play nice, everybody just took advantage
You left your fridge open, somebody just took a sandwich
I said baby what if you was clubbin''
Thuggin'', hustlin'' before you met your husband?
Then I said, "What if Mary was in the club
''Fore she met Joseph around hella thugs?
Cover Nori in lambs'' wool
We surrounded by the fuckin'' wolves"
(What if Mary) "What if Mary
(Was in the club) was in the club
''Fore she met Joseph with no love?
Cover Saint in lambs'' wool
(And she was) We surrounded by
(Surrounded by) the fuckin'' wolves"');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('I Ain''t Got Time!', 'Tyler, The Creator', 'Tyler, The Creator', 206, '[Intro: Shane Powers]
Right now we got some new music only here on Golf Radio!
(God I love this sample)
We''re going to dance
And exercise
And have some fun

[Chorus]
I ain''t got time for these niggas
Better throw a watch at the boy
Had my boys in this bitch, looking like a seminar
Who the fuck you talking to motherfucker?
Boy, I ain''t got time for these bitches
Better throw a clock at these hoes
Have these hoes in this bitch looking for a waterhose
Who the fuck you talking to, motherfucker?
Boy, I ain''t got time

[Verse 1]
Boy, I need a Kleenex
How I got this far? Boy, I can''t believe it
That I got this car, so I take the scenic
Passenger a white boy, look like River Phoenix
First... happy birthday!
You bitch ass nigga, yup I''m thirsty
Them little shots that you threw, they ain''t hurt me
I ain''t fuck with you bitch ass in the first place


[Chorus]
I ain''t got time for these niggas
Better throw a watch at the boy
Had my boys in this bitch, looking like a seminar
Who the fuck you talking to motherfucker?
Boy, I ain''t got time for these bitches
Better throw a clock at these hoes
Have these hoes in this bitch looking for a waterhose
Who the fuck you talking to, motherfucker?
Boy, I ain''t got time

[Verse 2]
Nat Turner would be so proud of me
''Cause all these motherfuckers got they style from me
I bet they all looking from the crowd at me
And if I ask them, they would bow at me
But you''re a house nigga, so you don''t know
How that shit go, with my big lips and my big nose
And my big dick and my short hair
''Cause you already know how slow my shit grow

[Bridge]
(Hey)
Tick tock
Tick tock
Tick tock
Tick tock');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('Sometimes...', 'Tyler, The Creator', 'Tyler, The Creator', 36, '[Tyler]
Sometimes, I sit in my room

[Shane Powers]
"It''s Golf Radio, you''re on the air with Shane Powers
Taking requests... What''s uh... What''s your name? Hello? Um, okay, well, since, you want to be Mr. Fucking Secret Agent, what song you wanna hear?"

[Unknown Boy]
The one about me');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('L$D', 'ASAP Rocky', 'ASAP Rocky', 238, '[Verse]
I know I dream about her all day
I think about her with her clothes off
I''m ridin'' ''round with my system bumpin'' LSD
I look for ways to say "I love you"
But I ain''t into makin'' love songs
Baby, I''m just rappin'' to this LSD
She ain''t a stranger to the city life
I introduced her to this hippy life
We make love under pretty lights, LSD (Acid)
I get a feelin'' it''s a trippy night
Them other drugs just don''t fit me right
Girl, I really fuckin'' want love, sex, dream
Another quarter to the face system
Make no mistakes, it''s all, a leap of faith for love
It takes a place in, feelin'' that you crave doin'' love, sex, dreams

[Chorus]
It started in Hollywood
Dreamin'' of sharin'' love
My tongue at a loss for words
Cause my feelings just said it all
Party just started up
Dreamin'' of sharin'' worlds
Held this feeling for way too long
Said, "I really wanna let it go"


[Bridge 1]
I''ve been gettin'' fly because the gimmick''s so dope
I''ve been getting high cause I figured Lord told me
I''ve been drinking, driving, now we''ll never go home
I gon'' stay in doubt because the weather''s so cold, oh

[Bridge 2]
Feeling low sometimes when the light shines down
Makes me high
Can you feel it?
Can you feel it?
Feeling low sometimes when the light shines down
Makes me high
Can you feel it?
Can you feel it?

[Chorus]
It started in Hollywood
Duh, duh-duh
Dreamin'' of sharin'' love
Duh, duh-duh
My tongue at a loss for words
Cause my feelings just said it all

[Outro]
I look for ways to say, "I love you"
But I ain''t into makin'' love songs
Baby, I''m just rappin'' to this LSD');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('Everyday', 'ASAP Rocky', 'ASAP Rocky', 261, '[Chorus: Rod Stewart & Miguel]
Everyday I spend my time
Drinkin'' wine, feelin'' fine
Waitin'' here to find the sign
That I can understand, yes I am
So everyday I spend my time
Drinkin'' wine, feelin'' fine
Waiting here to find the sign
That I should take it slow
Here I go, here I go, here I go...

[Verse 1: A$AP Rocky]
Off again, there he go, to another dimension, my mind
Body, soul imprisoned, my eye, prolly goin'' ballistic, but listen
I''m missin'' a couple of screws, they ain''t never do drillin'' true
You been sippin'' away at the truth, a double shot of wisdom''ll do
Do, do, rollin'' through, hittin'' switches
Rolling ditches, blowin'' kisses, to the bitches, holdin'' biscuits
What''s the business? Beat the system
Co-defendants, blow the sentence, go to prison
Go to church and pray the father, Lord forgive us (Amen)
And only God can judge me (yeah) and he don''t like no ugly
I look so fuckin'' good, most dykes''ll fuck me, buddy
Yeah I''m a piece of shit, I know I plead the fifth
I tell her, "Holla if ya need some dick"
The devotion is gettin'' hopeless, but hold it, I''m gettin'' close
As my soul is, I''m seein'' ghosts, a solo is now a poet
Hypnosis overdose on potions, adjustin'' to the motions
And gettin'' out all my emotions

[Chorus: Rod Stewart & Miguel]
Everyday I spend my time
Drinkin'' wine, feelin'' fine
Waitin'' here to find the sign
That I can understand, yes I am
So everyday I spend my time
Drinkin'' wine, feelin'' fine
Waiting here to find the sign
That I should take it slow
Here I go, here I go, here I go

[Verse 2: A$AP Rocky]
Uh, this type of shit
Make a nigga wanna flip September through August
This type of shit got ''em bustin'' out the clip
In the middle of the office
And a message to the bosses
The Misfits'' new outfit is on the bloglist
Gorgeous hoes keep on the sayin'' that they ''caused it
Cause the Porsches get ''em nauseous
Plus I ain''t even mad yet, niggas caught me in a good mood
Paparazzi wanna nag a nigga chillin'' at the bag check
Hope they show me in my good shoes
When papa got the brand new bag
Flacko got the brand new Raf, that''s good news
"Hood dudes usually don''t look like you"
How it feel to get a deal and come back
And the whole hood look like you?
Screamin'', "Pimp Squad, hold it down!"
Can''t drive, bitch, I''m legally blind, bitch
If I live or die, it''s up to me to decide
Shit, niggas coppin'' guns like they legal to buy
The only key to survive and get a piece of the pie
Is to agree with a lot or just believe a façade, bitch
And I''ll be fine just-a drinkin'' my wine, bitch

[Bridge: Miguel]
I got the love birds chirpin'' at the window
But I don''t need love no more
I''ll be fine, sippin'' wine
Takin'' time slow
I got the love birds chirpin'' at the window
But I don''t need love no more
I''ll be fine, sippin'' wine

[Chorus: Miguel & Rod Stewart]
So everyday I spend my time
Drinkin'' wine, feelin'' fine
Waiting here to find the sign
That I can understand, yes I am
Everyday I spend my time
Drinkin'' wine, feelin'' fine
Waitin'' here to find the sign
I don''t care if I ever know
Here I go, here I go, here I go!

[Outro: A$AP Rocky]
I got the love birds chirpin'' at the window
But I don''t need love no more, oh, no
I''ll be fine, sippin'' wine
Takin'' time slow
I got the love birds chirpin'' at the window
But I don''t need love no more, oh, no
I''ll be fine, sippin'' wine
Takin'' time slow');
INSERT INTO music_service.song(name, artist, main_artist, duration, lyrics)
VALUES ('Famous', 'French Montana', 'French Montana', 245, '[Verse 1]
I hope no one discovers you
Hope no one sees her
I hope no one falls in love with you
I''ve got my reasons
''Cause if they knew what I know then I know
I wouldn''t stand a chance
There''s no way you would go for a man like me
If you had options

[Chorus]
Even though the world was meant for you
I hope you don''t get famous
''Cause everyone will love you but won''t love you like I do, oh nah
Hope you don''t get famous
Stay home with me
Stay home with me
I''ll always love ya, I''ll always
Hope you don''t get
Hope you don''t get famous
Hope you don''t get famous
Hope you don''t get famous
Hope you don''t get famous
Yeah

[Verse 2]
Baby live your life, just how you are
Shining star
Hope you never get famous
Flying low with the angels
They said "fake it ''till you make it"
I guess you fake when you make it
I told you "stick to the basics"
Built an empire started from the basement
If you tryna fix a glass that''s broken
You know it might cut ya hand
Never want to see you with another man
Truth might eat you if you''re mumbling
When it get too cold for a blanket
Need you hugging me
Because nobody gonna love you like I do


[Chorus]
Even though the world was meant for you
I hope you don''t get famous
''Cause everyone will love you but won''t love you like the way I do, oh nah
Hope you don''t get famous
Stay home with me
Stay home with me
I''ll always love ya, I''ll always
Hope you don''t get
Hope you don''t get famous
Hope you don''t get famous
Hope you don''t get famous
Hope you don''t get famous
Yeah

[Bridge]
All day long I stand by you
Right or wrong I stand by you
Keep me strong, oh girl it''s true
Keep me strong, oh girl it''s true

[Chorus]
Even though the world was meant for you
I hope you don''t get famous
''Cause everyone will love you but won''t love you like I do, oh nah
Hope you don''t get famous
Stay home with me
Stay home with me
I''ll always love ya, I''ll always
Hope you don''t get
Hope you don''t get famous
Hope you don''t get famous
Hope you don''t get famous
Hope you don''t get famous
Yeah');

-- INSERT INTO ALBUM_MUSIC TABLE
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Mac Demarco', 'Mac Demarco', 'Salad Days', 'Salad Days');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Mac Demarco', 'Mac Demarco', 'Salad Days', 'Brother');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Mac Demarco', 'Mac Demarco', 'Another One', 'The Way You''d Love Her');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Kanye West', 'Kanye West', 'The Life Of Pablo', 'Pt. 2');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Desiigner', 'Kanye West', 'The Life Of Pablo', 'Pt. 2');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Kanye West', 'Kanye West', 'The Life Of Pablo', 'Famous');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Rihanna', 'Kanye West', 'The Life Of Pablo', 'Famous');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Swizz Beatz', 'Kanye West', 'The Life Of Pablo', 'Famous');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Kanye West', 'Kanye West', 'The Life Of Pablo', 'Wolves');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Tyler, The Creator', 'Tyler, The Creator', 'Flower Boy', 'I Ain''t Got Time!');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('Tyler, The Creator', 'Tyler, The Creator', 'Flower Boy', 'Sometimes...');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('ASAP Rocky', 'ASAP Rocky', 'At. Long. Last. ASAP', 'L$D');
INSERT INTO music_service.album_music(artist, main_artist, album, song)
VALUES ('ASAP Rocky', 'ASAP Rocky', 'At. Long. Last. ASAP', 'Everyday');

-- INSERT INTO PLAYLIST TABLE
INSERT INTO music_service.playlist(name, duration, num_songs, description)
VALUES ('For Rest', 4184, 15, 'Playlist for relaxation');
INSERT INTO music_service.playlist(name, duration, num_songs, description)
VALUES ('Chill Mix', 6960, 25, 'Handpicked songs to help you relax and unwind');
INSERT INTO music_service.playlist(name, duration, num_songs, description)
VALUES ('Dance Nation', 10080, 50, 'It''s going of. The biggest anthems and club bangers');
INSERT INTO music_service.playlist(name, duration, num_songs, description)
VALUES ('Headspace', 20280, 63, 'Best music to concentrate');
INSERT INTO music_service.playlist(name, duration, num_songs, description)
VALUES ('Rage Workout', 8580, 35, 'Ruthless hard rock and metal ragers take you from dead weight to power lifter');

-- INSERT INTO PLAYLIST_MUSIC TABLE
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Mac Demarco', 'Chill Mix', 'Salad Days');
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Mac Demarco', 'For Rest', 'Salad Days');
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Mac Demarco', 'Chill Mix', 'Brother');
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Mac Demarco', 'For Rest', 'Brother');
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Mac Demarco', 'Chill Mix', 'The Way You''d Love Her');
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Kanye West', 'Dance Nation', 'Pt. 2');
INSERT INTO music_service.playlist_music(artist, playlist, song, song_id)
VALUES ('Desiigner', 'Dance Nation', 'Pt. 2', CURRVAL('music_service.playlist_music_song_id_seq'));
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Kanye West', 'Rage Workout', 'Pt. 2');
INSERT INTO music_service.playlist_music(artist, playlist, song, song_id)
VALUES ('Desiigner', 'Rage Workout', 'Pt. 2', CURRVAL('music_service.playlist_music_song_id_seq'));
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Kanye West', 'Dance Nation', 'Famous');
INSERT INTO music_service.playlist_music(artist, playlist, song, song_id)
VALUES ('Rihanna', 'Dance Nation', 'Famous', CURRVAL('music_service.playlist_music_song_id_seq'));
INSERT INTO music_service.playlist_music(artist, playlist, song, song_id)
VALUES ('Swizz Beatz', 'Dance Nation', 'Famous', CURRVAL('music_service.playlist_music_song_id_seq'));
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Kanye West', 'Rage Workout', 'Famous');
INSERT INTO music_service.playlist_music(artist, playlist, song, song_id)
VALUES ('Rihanna', 'Rage Workout', 'Famous', CURRVAL('music_service.playlist_music_song_id_seq'));
INSERT INTO music_service.playlist_music(artist, playlist, song, song_id)
VALUES ('Swizz Beatz', 'Rage Workout', 'Famous', CURRVAL('music_service.playlist_music_song_id_seq'));
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Kanye West', 'Chill Mix', 'Wolves');
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Tyler, The Creator', 'Rage Workout', 'I Ain''t Got Time!');
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('Tyler, The Creator', 'Headspace', 'Sometimes...');
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('ASAP Rocky', 'Headspace', 'L$D');

/*-- CRUD QUERIES (TASK 6)
INSERT INTO music_service.playlist_music(artist, playlist, song)
VALUES ('ASAP Rocky', 'Headspace', 'Everyday');

SELECT *
FROM music_service.song
WHERE duration < 200;

UPDATE music_service.playlist
SET num_songs = 51
WHERE name = 'Dance Nation';

DELETE FROM music_service.playlist
WHERE name = 'Rage Workout';

SELECT *
FROM music_service.song
WHERE artist = 'Mac Demarco';

SELECT *
FROM music_service.song
WHERE main_artist = 'Kanye West' AND NOT artist = 'Kanye West';

UPDATE music_service.playlist
SET update_date = now()::date - 3
WHERE name = 'Headspace';

INSERT INTO music_service.playlist(name, duration, num_songs, description)
VALUES ('Study', 13455, 17, 'Best music to learn something');

DELETE FROM music_service.playlist
WHERE num_songs < 16;

SELECT COUNT(*)
FROM music_service.album
WHERE artist=main_artist;

-- SELECT QUERIES
-- Для каждого альбома выведем число исполнителей, которые участвовали в записи альбома с таким названием
SELECT name, COUNT(*)
FROM music_service.album
GROUP BY name;

-- Выведем исполнителей, у которых больше 1 песни
SELECT artist, COUNT(name)
FROM music_service.song
GROUP BY artist
HAVING COUNT(name) > 1;

-- Отсортируем исполнителей по убыванию их даты рождения
SELECT name, birth_date
FROM music_service.artist
ORDER BY birth_date DESC;

-- Для каждой песни выведем число исполнителей, участвовавших в ее создании
SELECT DISTINCT name, main_artist,
       COUNT(artist) OVER (PARTITION BY song_id) AS num_artists
FROM music_service.song;

-- Для каждого исполнителя по алфавиту вывести число исполнителей, рожденных до него
SELECT name, birth_date,
       COUNT(name) OVER (ORDER BY birth_date) AS num_artists_born_before
FROM music_service.artist
ORDER BY name;

-- Для каждого исполнителя узнать число песен в его альбомах на каждый год
SELECT main_artist, year,
       SUM(num_songs) OVER (PARTITION BY main_artist ORDER BY year ASC) AS num_songs_by_year
FROM music_service.album
WHERE artist = main_artist
ORDER BY main_artist, year;

-- Отсортируем все песни по длительности и выведем разницу по сравнению с предыдущим
SELECT name, duration, duration - LAG(duration, 1, 0) OVER (ORDER BY duration) AS diversity
FROM music_service.song
WHERE main_artist = artist;

-- Отранжируем исполнителей по альбому, в записи которого они участвовали
SELECT name, artist, duration,
       RANK() OVER (ORDER BY album_id)
FROM music_service.album;
*/

-- Хранимая процедура для корректного отображения продолжительности альбома у пользователя
CREATE OR REPLACE FUNCTION music_service.GetDuration(duration INTEGER)
    RETURNS TEXT AS
$$
DECLARE
    hours_str   TEXT := '';
    minutes_str TEXT := '';
BEGIN
    IF (duration / 60 = 1) THEN
        hours_str := ' hour';
    ELSE
        hours_str := ' hours';
    END IF;
    IF (duration % 60 = 1) THEN
        minutes_str := ' minute';
    ELSE
        minutes_str := ' minutes';
    END IF;
    IF (duration > 60) AND (duration % 60 = 0) THEN
        return duration / 60 || hours_str;
    ELSIF (duration < 60) THEN
        RETURN duration || minutes_str;
    ELSE
        RETURN duration / 60 || hours_str || ' ' || duration % 60 || minutes_str;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Вью с данными об альбоме, которые предоставлены пользователю
CREATE OR REPLACE VIEW music_service.album_public_information AS (
    SELECT name,
           main_artist,
           year,
           genre,
           music_service.GetDuration(duration) AS duration,
           num_songs,
           description
    FROM music_service.album
    WHERE artist = main_artist
    ORDER BY year
);

SELECT *
FROM music_service.album_public_information;

-- Хранимая процедура для получения красивого отображения исполнителей
CREATE OR REPLACE FUNCTION music_service.GetOtherArtistsInfo(search_song_id INTEGER)
    RETURNS TEXT
    LANGUAGE SQL
AS
$$
SELECT concat('(feat. ', string_agg(artist, ', '), ')')
FROM music_service.song
WHERE artist <> main_artist
  AND song_id = search_song_id
GROUP BY main_artist;
$$;

-- Вью с информацией о песнях с красивым отображением исполнителей
CREATE OR REPLACE VIEW music_service.songs_information AS (
    SELECT DISTINCT name,
                    concat(main_artist, music_service.GetOtherArtistsInfo(song_id)) AS artist
    FROM music_service.song
);

SELECT *
FROM music_service.songs_information;



-- Список альбомов, отсортированный по возрасту исполнителей, в котором они его записали
CREATE OR REPLACE VIEW music_service.albums_by_artist_age AS (
    SELECT DISTINCT album.name                                    AS album_name,
                    main_artist                                   AS artist,
                    year,
                    year - EXTRACT(YEAR from birth_date)::INTEGER AS artist_age
    FROM music_service.artist
             INNER JOIN music_service.album
                        ON album.main_artist = artist.name
    ORDER BY artist_age
);

SELECT *
FROM music_service.albums_by_artist_age;


-- Хранимая процедура для триггеров, позволяющих удобно вставлять данные
CREATE OR REPLACE FUNCTION music_service.insert_with_default_artist() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.main_artist IS NULL THEN
        NEW.main_artist := NEW.artist;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 3 триггера, которые позволяют не инициализировать отдельно main_artist и artist, если они совпадают
CREATE TRIGGER trigger_insert_with_default_artist
    BEFORE INSERT
    ON music_service.album
    FOR EACH ROW
EXECUTE PROCEDURE music_service.insert_with_default_artist();

CREATE TRIGGER trigger_insert_with_default_artist
    BEFORE INSERT
    ON music_service.song
    FOR EACH ROW
EXECUTE PROCEDURE music_service.insert_with_default_artist();

CREATE TRIGGER trigger_insert_with_default_artist
    BEFORE INSERT
    ON music_service.album_music
    FOR EACH ROW
EXECUTE PROCEDURE music_service.insert_with_default_artist();

-- Пример использования триггеров
INSERT INTO music_service.album(name, artist, year, genre, duration, num_songs, label, description)
VALUES ('Social Cues', 'Cage the Elephant', 2019, 'Alternative', 44, 13, '110 Entertainment LCC',
        'On Social Cues, Matt Shultz tries to make sense of a tumultuous time in his life. The Cage the Elephant frontman not only went through a divorce but also lost two of his best friends to suicide during the recording of the band''s fifth full-length album. But rather than dwell on his tragic circumstances, Shultz focused on the positives that tend to get dismissed during periods of personal turmoil.');

INSERT INTO music_service.song(name, artist, duration, lyrics)
VALUES ('Social Cues', 'Cage the Elephant', 219, '[Verse 1]
I think it''s strange when people say
You''re the next big thing, you''ll never fade
The slightest touch, forced to fold
Sleight of the hand, modern gold

[Pre-Chorus]
Starry-eyed child left behind
Choose your favorite vice
I don''t have the strength to play nice

[Chorus]
Hide me in the back room, tell me when it''s over
Don''t know if I can play this part much longer
I''ll be in the back room, tell me when it''s over
Don''t know if I can play this part much longer
I don''t know if it is right to live this way, yeah
I''ll be in the back room, tell me when it''s over
People always say, "Man, at least you''re on the radio"

[Post-Chorus]
At least you''re on the radio, oh
At least you''re on the radio, huh
At least you''re on the radio, oh

[Verse 2]
Close your eyes, don''t be afraid
Take some of these, they''ll ease the pain
Live fast, die young, pay the price
The best die young, immortalized


[Pre-Chorus]
Starry-eyed children left behind
To choose their favorite vice
I don''t have the strength to think twice

[Chorus]
Hide me in the back room, tell me when it''s over
Don''t know if I can play this part much longer
I''ll be in the back room, tell me when it''s over
Don''t know if I can play this part much longer
I don''t know if it is right to live this way, yeah
I''ll be in the back room, tell me when it''s over
People always say, "Man, at least you''re on the radio"

[Post-Chorus]
At least you''re on the radio, oh
At least you''re on the radio, huh

[Chorus]
Hide me in the back room, tell me when it''s over
Don''t know if I can play this part much longer
I''ll be in the back room, tell me when it''s over
Don''t know if I can play this part much longer
I don''t know if it is right to live this way, yeah
I''ll be in the back room, tell me when it''s over
People always say, "Man, at least you''re on the radio"


[Outro]
At least you''re on the radio, oh');

-- Функция и триггер для обновления id у альбомов после удаления одного из них
CREATE OR REPLACE FUNCTION music_service.delete_with_id_reduce() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE music_service.album
    SET album_id = album_id - 1
    WHERE album_id > OLD.album_id;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_delete_with_id_reduce
    BEFORE DELETE
    ON music_service.album
    FOR EACH ROW
EXECUTE PROCEDURE music_service.delete_with_id_reduce();

-- Пример использования триггера
DELETE FROM music_service.album
WHERE name = 'Flower Boy';