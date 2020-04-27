import 'package:lyricsflutterapp/utils/direct_select/direct_select_container.dart';
import 'package:lyricsflutterapp/utils/direct_select/direct_select_item.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lyricsflutterapp/ui/search_select_menu.dart';
import 'package:lyricsflutterapp/utils/slider/batch_slider.dart';
import 'package:lyricsflutterapp/ui/direct_select_menu.dart';

bool notSeen = true;

class StyleTab extends StatefulWidget {

  final String title;
  PageController pageController;
  StreamController<Map> condsStreamCtrl;

  StyleTab({Key key,
    @required this.pageController,
    @required this.condsStreamCtrl,
    this.title}) : super(key: key);

  @override
  _StyleTabState createState() => _StyleTabState();
}

class _StyleTabState extends State<StyleTab> with AutomaticKeepAliveClientMixin<StyleTab> {
  String genreStr = "None";
  String artistStr = "None";
  String yearStr = "None";
  String albumStr = "None";
  String songTitleStr = "None";
  String batchSizeStr = "None";
  String initialTextStr = "None";

  @override
  bool get wantKeepAlive => true;

  @override
  void initState(){
    if (notSeen) {
      Timer(Duration(milliseconds: 500), () {
        showAlertDialog(context);
        notSeen = false;
      });
    }
    super.initState();
  }

  List<String> _genre = ["None", "Pop", "Rap", "Country", "Rock", "Reggae"];
  List<String> _artist = ["None",'Gregory Isaacs (Reggae)', 'Maxi Priest (Reggae)', 'Genesis (Rock)', 'DMX (Rap)', 'Chris Lane (Country)', 'Michael Jackson (Pop)', 'Alabama (Country)', 'Deep Purple (Rock)', 'André 3000 (Rap)', 'Janis Joplin (Rock)', 'Alison Krauss (Country)', 'Marty Stuart (Country)', 'Green Day (Rock)', 'Kiss (Rock)', 'Juice WRLD (Rap)', 'LANco (Country)', 'Whitney Houston (Pop)', 'Logic (Rap)', 'The Kinks (Rock)', 'Donald Glover & Danny Pudi (Rap)', '5 Seconds of Summer (Pop)', 'Bill Monroe (Country)', 'Pearl Jam (Rock)', 'David Bowie (Rock)', 'Iron Maiden (Rock)', 'Johnny Cash (Country)', 'Elton John (Pop)', 'Foo Fighters (Rock)', 'Gentleman (Reggae)', 'Jessi Colter (Country)', 'Natasha Bedingfield (Pop)', 'Missy Elliott (Rap)', 'Black Sabbath (Rock)', 'Roy Acuff (Country)', 'Justin Bieber (Pop)', 'Crystal Gayle (Country)', 'Greta Van Fleet (Rock)', 'Brett Young (Country)', 'The Weeknd (Pop)', 'Toby Keith (Country)', 'Slick Rick (Rap)', 'The Velvet Underground (Rock)', 'Queen (Rock)', 'Santana (Rock)', 'Dwight Yoakam (Country)', 'NF (Rap)', 'Buck Owens (Country)', 'Elvis Presley (Rock)', 'Big Shaq (Rap)', 'Childish Gambino (Rap)', 'Chuck Berry (Rock)', 'Scarface (Rap)', 'Eric Church (Country)', 'Daniel Powter (Pop)', 'Dr.\xa0Dre (Rap)', 'Buju Banton (Reggae)', 'James Blunt (Pop)', 'Steps (Pop)', 'Alton Ellis (Reggae)', 'Hank Williams (Country)', 'Michael Ray (Country)', 'Seal (Pop)', 'T-Pain (Pop)', 'Tom T. Hall (Country)', 'Ricky Martin (Pop)', 'Busta Rhymes (Rap)', 'Kesha (Pop)', 'Led Zeppelin (Rock)', 'The Moody Blues (Rock)', 'Monica (Pop)', 'Imagine Dragons (Pop)', 'Maroon 5 (Pop)', 'J. Cole (Rap)', 'Lauryn Hill (Rap)', 'Obie Trice (Rap)', 'Tim McGraw (Country)', 'Pusha T (Rap)', 'Rakim (Rap)', 'John Lennon (Rock)', 'Kris Kristofferson (Country)', 'Ace of Base (Pop)', 'Shakira (Pop)', 'Tammy Wynette (Country)', 'Kanye West (Rap)', 'Linda Ronstadt (Country)', 'Bill Anderson (Country)', 'Jennifer Lopez (Pop)', 'Jerry Jeff Walker (Country)', 'Lefty Frizzell (Country)', 'Scorpions (Rock)', 'George Strait (Country)', 'Travis Scott (Rap)', 'Xzibit (Rap)', 'Janet Jackson (Pop)', 'Mariah Carey (Pop)', 'Jamie Foxx (Pop)', 'Harry Styles (Pop)', 'Ziggy Marley (Reggae)', 'Snoop Dogg (Rap)', 'Lynyrd Skynyrd (Rock)', 'Adele (Pop)', 'Stevie Wonder (Pop)', 'Dolly Parton (Country)', 'Cole Swindell (Country)', 'The Police (Rock)', 'Supertramp (Rock)', 'Steel Pulse (Reggae)', 'Luke Combs (Country)', 'Carrie Underwood (Country)', 'Boston (Rock)', 'Tarrus Riley (Reggae)', 'Shawn Mendes (Pop)', 'The Black Eyed Peas (Pop)', 'Brandy (Pop)', 'The Cure (Rock)', 'Old Dominion (Country)', 'Ramones (Rock)', 'Lil Dicky (Rap)', 'Sex Pistols (Rock)', 'Steely Dan (Rock)', 'Rihanna (Pop)', 'Red Hot Chili Peppers (Rock)', '21 Savage (Rap)', 'JAY-Z (Rap)', 'KRS-One (Rap)', 'Billy Joel (Rock)', 'Ariana Grande (Pop)', 'R.E.M. (Rock)', 'MF DOOM (Rap)', 'Bounty Killer (Reggae)', 'Madonna (Pop)', 'Taylor Swift (Pop)', 'Bad Company (Rock)', 'Calvin Harris (Pop)', 'Sean Paul (Pop)', 'ZZ Top (Rock)', 'Van Halen (Rock)', r"A$AP Rocky (Rap)", 'Earl Sweatshirt (Rap)', 'The Statler Brothers (Country)', 'Kane Brown (Country)', 'Lupe Fiasco (Rap)', 'AC/DC (Rock)', 'The Louvin Brothers (Country)', 'R. Kelly (Pop)', 'Eminem (Rap)', 'Sugar Ray (Pop)', 'Rod Stewart (Pop)', 'One Direction (Pop)', 'Ghostface Killah (Rap)', 'Kid Cudi (Rap)', 'Warren G (Rap)', 'DaBaby (Rap)', 'Eddy Arnold (Country)', 'Chuck D (Rap)', 'Chris Stapleton (Country)', 'Shania Twain (Country)', 'Waylon Jennings (Country)', 'Selena Gomez (Pop)', 'Young Thug (Rap)', 'Dixie Chicks (Country)', 'Future (Rap)', 'Twista (Rap)', 'Lee Ann Womack (Country)', 'The Cars (Rock)', 'Cheap Trick (Rock)', 'Big Pun (Rap)', 'Bunny Wailer (Reggae)', 'Townes Van Zandt (Country)', 'Rita Marley (Reggae)', 'Lil Wayne (Rap)', 'Paul McCartney (Rock)', 'Katy Perry (Pop)', 'George Michael (Pop)', 'Snow Patrol (Pop)', 'Raekwon (Rap)', 'XXXTENTACION (Rap)', 'Journey (Rock)', 'Alan Jackson (Country)', 'Rick Ross (Rap)', 'Steve Miller Band (Rock)', 'G-Eazy (Rap)', 'Cardi B (Rap)', 'Randy Travis (Country)', 'Capleton (Reggae)', 'Brothers Osborne (Country)', 'Brantley Gilbert (Country)', 'Lana Del Rey (Pop)', 'Wiz Khalifa (Rap)', 'Guns N’ Roses (Rock)', 'Big Daddy Kane (Rap)', 'John Legend (Pop)', 'Redman (Rap)', 'Patsy Cline (Country)', 'Rage Against the Machine (Rock)', 'Eagles (Rock)', 'The Game (Rap)', 'GZA (Rap)', 'Pink Floyd (Rock)', 'Mumford & Sons (Rock)', 'B.o.B (Rap)', 'Ski Mask the Slump God (Rap)', 'Ernest Tubb (Country)', 'Shaggy (Reggae)', 'Lucinda Williams (Country)', 'Britney Spears (Pop)', 'Willie Nelson (Country)', 'Meek Mill (Rap)', 'The Rolling Stones (Rock)', 'Fall Out Boy (Rock)', 'Fleetwood Mac (Rock)', 'Protoje (Reggae)', 'Asleep at the Wheel (Country)', 'The Jimi Hendrix Experience (Rock)', 'UB40 (Reggae)', 'Ed Sheeran (Pop)', 'Jimmie Rodgers (Country)', 'Prince (Pop)', 'Migos (Rap)', 'Yelawolf (Rap)', 'Roger Miller (Country)', 'The Band (Rock)', 'Alice in Chains (Rock)', 'Prodigy of Mobb Deep (Rap)', 'Meghan Trainor (Pop)', 'Marshmello (Pop)', 'Israel Vibration (Reggae)', 'Guy Clark (Country)', '\u200btwenty one pilots (Rock)', 'YG (Rap)', 'LL Cool J (Rap)', 'OutKast (Rap)', 'Joyner Lucas (Rap)', 'Rascal Flatts (Pop)', 'Patty Loveless (Country)', 'Reba McEntire (Country)', 'Denzel Curry (Rap)', 'Hopsin (Rap)', 'T.I. (Rap)', 'Damian Marley (Reggae)', 'Nicki Minaj (Pop)', 'Sam Smith (Pop)', 'M2M (Pop)', 'Oasis (Rock)', 'Gucci Mane (Rap)', 'Lil Uzi Vert (Rap)', 'Max Romeo (Reggae)', 'Céline Dion (Pop)', 'Kenny Rogers (Country)', 'Jamey Johnson (Country)', 'Nate Dogg (Rap)', 'Freddie McGregor (Reggae)', 'Fetty Wap (Rap)', 'Flatt & Scruggs (Country)', 'Miranda Lambert (Country)', 'Chris Janson (Country)', 'Coldplay (Pop)', 'Brad Paisley (Country)', 'Jah Cure (Reggae)', 'Desmond Dekker (Reggae)', 'Rosanne Cash (Country)', 'Bob Dylan (Rock)', 'Foreigner (Rock)', 'The Doors (Rock)', 'John Prine (Country)', 'Linkin Park (Rock)', 'Talib Kweli (Rap)', 'Sizzla (Reggae)', 'Stephen Marley (Reggae)', 'George Harrison (Rock)', 'Conway Twitty (Country)', 'Panic! at the Disco (Rock)', 'Big Boi (Rap)', 'Eric Clapton (Rock)', 'Camila Cabello (Pop)', 'Bruno Mars (Pop)', 'Spice Girls (Pop)', 'N.W.A (Rap)', 'The Clash (Rock)', 'Nickelback (Pop)', 'Miley Cyrus (Pop)', 'Heart (Rock)', 'The Who (Rock)', 'Aerosmith (Rock)', 'The Notorious B.I.G. (Rap)', 'Beres Hammond (Reggae)', 'Jon Pardi (Country)', 'Blondie (Rock)', 'Neil Young (Rock)', 'Fergie (Pop)', 'Merle Haggard (Country)', 'PVRIS (Rock)', 'Wu-Tang Clan (Rap)', 'Dylan Scott (Country)', 'Nirvana (Rock)', 'Dire Straits (Rock)', 'Normani (Pop)', 'The Yardbirds (Rock)', 'Luciano (Reggae)', 'Buddy Holly (Rock)', 'The Carter Family (Country)', 'Post Malone (Rap)', 'The Smashing Pumpkins (Rock)', 'Def Leppard (Rock)', 'Charlie Puth (Pop)', 'Talking Heads (Rock)', 'Demi Lovato (Pop)', 'John Denver (Country)', 'The Fray (Pop)', 'ScHoolboy Q (Rap)', 'Keith Urban (Country)', 'Beenie Man (Reggae)', 'Proof (Rap)', 'Bob Marley & The Wailers (Reggae)', 'Styx (Rock)', 'Loretta Lynn (Country)', 'Blake Shelton (Country)', 'The Beatles (Rock)', 'Drake (Pop)', 'Jeezy (Rap)', 'Brooks & Dunn (Country)', 'Bruce Springsteen (Rock)', 'Rush (Rock)', 'Vince Gill (Country)', 'Backstreet Boys (Pop)', '2 Chainz (Rap)', 'Toni Braxton (Pop)', 'Chicago (Rock)', 'Aaron Watson (Country)', 'Rachel Platten (Pop)', 'Ice Cube (Rap)', 'Dustin Lynch (Country)', '2Pac (Rap)', 'Ne-Yo (Pop)', '50 Cent (Rap)', 'Vern Gosdin (Country)', 'Midland (Country)', 'Jimmy Cliff (Reggae)', 'Christina Aguilera (Pop)', 'Natalia Oreiro (Pop)', 'Nelly (Pop)', 'Tanya Tucker (Country)', 'Nas (Rap)', 'Chance the Rapper (Rap)', 'Faith Hill (Country)', 'Amy Grant (Pop)', 'Glen Campbell (Country)', 'P!nk (Pop)', 'The Pussycat Dolls (Pop)', 'Robin Thicke (Pop)', 'Kendrick Lamar (Rap)', 'Sia (Pop)', 'George Jones (Country)', 'Metallica (Rock)', 'Chronixx (Reggae)', 'Ludacris (Rap)', 'Ozzy Osbourne (Rock)', 'Big Sean (Rap)', 'Garth Brooks (Country)', 'Charley Pride (Country)', 'Ellie Goulding (Pop)', 'Cody Johnson (Country)', 'Chris Brown (Rap)', 'U2 (Rock)', 'Emmylou Harris (Country)', 'The Beach Boys (Rock)', 'Alice Cooper (Rock)', 'Beyoncé (Pop)', 'Grateful Dead (Rock)', 'Steve Earle (Country)', 'Alessia Cara (Pop)', 'RZA (Rap)', 'Soundgarden (Rock)', 'Kelly Clarkson (Pop)', 'Bon Jovi (Rock)', 'Radiohead (Rock)', 'Q-Tip (Rap)', 'Lady Gaga (Pop)', 'Chris LeDoux (Country)', 'The Judds (Country)', 'Jethro Tull (Rock)', 'Ray Price (Country)', 'Jefferson Airplane (Rock)', 'Yes (Rock)', 'Justin Timberlake (Pop)'];
  List<String> _year = ["None",'2019', '2018', '2017', '2016', '2015', '2014', '2013', '2012', '2011', '2010', '2009', '2008', '2007', '2006', '2005', '2004', '2003', '2002', '2001', '2000', '1999', '1998', '1997', '1996', '1995', '1994', '1993', '1992', '1991', '1990', '1989', '1988', '1987', '1986', '1985', '1984', '1983', '1982', '1981', '1980', '1979', '1978', '1977', '1976', '1975', '1974', '1973', '1972', '1971', '1970', '1969', '1968', '1967', '1966', '1965', '1964', '1963', '1962', '1961', '1960', '1959', '1958', '1957', '1956', '1955', '1954', '1953', '1952', '1951', '1950', '1949', '1948', '1947', '1946', '1941', '1933', '1932', '1931', '1930', '1929', '1928', '1877'];
  List<String> _album = ["None",'Mob Rules (Black Sabbath)', 'Ten (Pearl Jam)', 'Nah No Mercy: The Warlord Scrolls (Bounty Killer)', 'Unapologetic (Rihanna)', 'Love After War (Robin Thicke)', 'Bruce Wayne (Fetty Wap)', 'Whut? Thee Album (Redman)', 'Lake Effect Kid - EP (Fall Out Boy)', 'I Look to You (Whitney Houston)', 'Unreleased (Kesha)', 'JJ12* (Janet Jackson)', 'Freebase (2 Chainz)', 'I’m Up (Young Thug)', 'Mr. Davis (Gucci Mane)', 'SLAPS FOR MY DROP-TOP MINI-VAN (Ski Mask the Slump God)', 'Greatest Hits (Queen)', 'Spotify Singles (Midland)', 'Storms of Life (Randy Travis)', 'Spice Up Your Life (Spice Girls)', 'Brave New World (Steve Miller Band)', 'RP5* (Rachel Platten)', 'My Homies Part 2 (Scarface)', 'The Pac & Biggie You Never Heard (Bootleg) (The Notorious B.I.G.)', 'Symphonica (George Michael)', 'Kiss Land (Deluxe) (The Weeknd)', 'Walkin’ in the Sunshine (Roger Miller)', 'Fables of the Reconstruction (R.E.M.)', 'Joshua (Dolly Parton)', 'Greatest Hits (Styx)', 'Transformers: Revenge of the Fallen – The Album (Linkin Park)', 'Cheap Trick (Cheap Trick)', 'Brothers in Arms (Dire Straits)', 'The Miseducation of Lauryn Hill (Lauryn Hill)', 'From The Inside (Alice Cooper)', '2001 (Dr.\xa0Dre)', 'Radio (LL Cool J)', 'Pride In What I Am (Merle Haggard)', 'Elvis: That’s the Way It Is (Elvis Presley)', 'Floored (Sugar Ray)', 'Natty Dread (Bob Marley & The Wailers)', 'Freshman Freestyles (Class of 2019) (DaBaby)', 'Always & Forever (Randy Travis)', 'Saginaw, Michigan (Lefty Frizzell)', 'Blackout (Scorpions)', 'Too Low for Zero (Elton John)', 'Appetite for Destruction (Guns N’ Roses)', 'Incognegro (Ludacris)', 'The House of Blue Light (Deep Purple)', 'Communiqué (Dire Straits)', 'Autoamerican (Blondie)', 'Evolution (Journey)', 'Pawn Shop (Brothers Osborne)', 'Now That’s What I Call Music! 98 [UK] (Marshmello)', 'Therapy Session (NF)', 'Millennium (Backstreet Boys)', 'Born to Die (Lana Del Rey)', 'Everyday Is Christmas (Sia)', 'Whitney (Whitney Houston)', 'Selassie I Way (Chronixx)', 'Dread & Terrible (Chronixx)', 'The Hits/The B-Sides (Prince)', 'Diver Down (Van Halen)', 'I Wanna Thank Me (Snoop Dogg)', 'The Beatles (The White Album) (The Beatles)', 'Piece by Piece (Kelly Clarkson)', 'Revolution Radio (Green Day)', 'Glitter (Mariah Carey)', 'The Head on the Door (The Cure)', 'Gangsta Bitch Music, Vol. 2 (Cardi B)', 'The Ruler’s Back (Slick Rick)', 'Amigos (Santana)', 'Grand Champ (DMX)', 'Reflected: Greatest Hits Vol 2 (Tim McGraw)', 'Gimme Back My Bullets (Lynyrd Skynyrd)', 'H.N.I.C. Pt. 2 (Prodigy of Mobb Deep)', 'Love in the Future (John Legend)', 'The Very Best of Eagles (Eagles)', 'My Favorite Picture of You (Guy Clark)', 'Hannah Montana (Miley Cyrus)', 'Lotusflow3r (Prince)', 'Libra (Toni Braxton)', 'Indelibly Stamped (Supertramp)', 'Ghost in the Machine (The Police)', 'Country Bus Riddim (Tarrus Riley)', 'Smiley Smile (The Beach Boys)', 'Unbreakable (Scorpions)', 'Shark Tale (Original Motion Picture Soundtrack) (Christina Aguilera)', 'Red River Blue (Blake Shelton)', 'Christmas Present (Merle Haggard)', 'An Old Time Christmas (Randy Travis)', 'Many Moods of Moses (Beenie Man)', 'Windsong (John Denver)', 'Selling England by the Pound (Genesis)', 'DROGAS WAVE (Lupe Fiasco)', 'Greatest Hits Volume Two (Reba McEntire)', 'The Blueprint (JAY-Z)', 'Number One Hits (Tim McGraw)', 'Rockford (Cheap Trick)', 'SMTSG2* (Ski Mask the Slump God)', 'A Momentary Lapse of Reason (Pink Floyd)', 'Damita Jo (Janet Jackson)', 'Blurryface (\u200btwenty one pilots)', 'NOW That’s What I Call Music! 92 [UK] (Sam Smith)', 'Kamikaze (Eminem)', 'The Cookbook (Missy Elliott)', 'O Brother, Where Art Thou? (Music from the Motion Picture) (Emmylou Harris)', 'Pretty. Odd. (Panic! at the Disco)', 'Swinging Doors and The Bottle Let Me Down (Merle Haggard)', 'High Voltage [Australian Edition] (AC/DC)', '7 Year Itch (Protoje)', r'LONG.LIVE.A$AP (Deluxe Version) (A$AP Rocky)', 'Love Story (Tim McGraw)', 'Heavy Horses (Jethro Tull)', 'Minstrel in the Gallery (Jethro Tull)', 'Combat Rock (The Clash)', 'Be Here (Keith Urban)', 'The Otto Tunes (Charlie Puth)', 'Something Special (George Strait)', 'Worried Man Blues: Their Complete Victor Recordings (1930) (The Carter Family)', 'This is Not a Test! (Missy Elliott)', 'Spotify Singles (Meghan Trainor)', '25 All Time Greatest Recordings (Patsy Cline)', 'Ocean Front Property (George Strait)', 'Some Rap Songs (Earl Sweatshirt)', 'Something Else by the Kinks (The Kinks)', 'Young Sinatra (Logic)', 'The Next Day (David Bowie)', 'The Prophet: The Best of the Works (2Pac)', 'Mud on the Tires (Brad Paisley)', 'Writing On The Wall (Gucci Mane)', 'beerbongs & bentleys (Post Malone)', 'The Hegelian Dialectic (The Book of Revelation) (Prodigy of Mobb Deep)', 'Home  (Dixie Chicks)', 'Low  (David Bowie)', 'Reggae Gold 2006 (Capleton)', 'The Trinity (Sean Paul)', 'Rebirth (Lil Wayne)', 'reputation (Taylor Swift)', 'We Love Disney  (Ne-Yo)', 'Friday (Original Motion Picture Soundtrack) (Ice Cube)', '÷ (Divide) (Ed Sheeran)', 'Cole Swindell (Cole Swindell)', 'Escape (Journey)', '1999 (Prince)', 'Fly Rasta (Ziggy Marley)', 'Mr. Mention (Buju Banton)', 'Django Unchained (Original Motion Picture Soundtrack) (Rick Ross)', 'Songs in Rule of the Bone (Jimmy Cliff)', 'All Eyez on Me (2Pac)', 'Da’ Nic (T.I.)', 'Black Dog (Original Motion Picture Soundtrack (Randy Travis)', 'You Can’t Run From Yourself (Tanya Tucker)', 'Who Are You (The Who)', 'Port Saint Joe (Brothers Osborne)', 'They Call Me Country (Jamey Johnson)', 'Panic! at the Disco Video Catalog (Panic! at the Disco)', 'You Will Regret (Reloaded) (Ski Mask the Slump God)', 'RevolveR (T-Pain)', 'Everythang’s Corrupt (Ice Cube)', 'Walking the Floor Over You (Ernest Tubb)', 'Deeper Than Rap (Rick Ross)', 'Halfway To Heaven (Brantley Gilbert)', 'Trunk Muzik Returns (Yelawolf)', 'SHADYXV (Eminem)', 'Better Dayz (2Pac)', 'thank u, next (Ariana Grande)', 'The Harder They Come (Jimmy Cliff)', 'Evolve (Imagine Dragons)', 'Owl Pharaoh (Travis Scott)', 'Slime Season 2 (Young Thug)', 'Kilroy Was Here  (Styx)', 'Category F5 (Twista)', 'Three Imaginary Boys (The Cure)', 'More Fish (Ghostface Killah)', ' Country Strong (Original Motion Picture Soundtrack) (Faith Hill)', 'Seal (1994) (Seal)', 'Royalty (Chris Brown)', 'Tegan and Sara Present The Con X: Covers (PVRIS)', 'Young Rich Niggas (Migos)', 'Simple Dreams (Linda Ronstadt)', 'R U Still Down? (Remember Me) (2Pac)', 'All For You (Janet Jackson)', 'Reload (Metallica)', 'Dreamchasers 2 (Meek Mill)', 'Tha Blue Carpet Treatment (Snoop Dogg)', 'Celebration (Madonna)', 'OU812 (Van Halen)', 'STOKELEY (Ski Mask the Slump God)', 'Stand Up (Jethro Tull)', 'Views (Drake)', 'Wrath of Caine (Pusha T)', 'Raised On Radio (Journey)', 'Ancient Future (Protoje)', 'Young Money: Rise Of An Empire (Nicki Minaj)', 'Heartbreak Express (Dolly Parton)', 'Paranoid (Black Sabbath)', 'Fly (Dixie Chicks)', ' Walk a Mile in My Shoes: The Essential ’70s Masters (Elvis Presley)', 'Born Like This (MF DOOM)', 'Christmas Pop (Sam Smith)', 'Dead Set (Grateful Dead)', 'Sound + Vision (David Bowie)', 'Port of Miami (Rick Ross)', 'Country & Western (A Ride Through History • 1924-1960): CD 24 - History Of 1956 Part 4 (Ray Price)', 'Greatest Hits II (Alabama)', 'If You See Her (Brooks & Dunn)', 'Third Stage (Boston)', 'Half Nelson (Willie Nelson)', 'Found All the Parts (Cheap Trick)', 'Troubadour (George Strait)', 'End of the Century (Ramones)', 'Document (R.E.M.)', 'Community: Music from the Original Television Series (Donald Glover & Danny Pudi)', '19 & Boomin  (Young Thug)', 'Rocky Mountain High (John Denver)', 'Red Headed Stranger (Willie Nelson)', 'G N’ R Lies (Guns N’ Roses)', 'Breakfast in America (Supertramp)', 'Changed (Rascal Flatts)', 'BINGEDRINKINGMUSIC  (Juice WRLD)', 'Crystal Ball (Styx)', 'Passion, Pain & Demon Slayin’ (Kid Cudi)', 'Taking Chances (Céline Dion)', 'Honkytonk University (Toby Keith)', 'Fly International Luxurious Art (Raekwon)', 'G.O.A.T. (Greatest of All Time) (LL Cool J)', 'Absolutely Live (The Doors)', 'Storyteller (Carrie Underwood)', 'Who Made Who (AC/DC)', 'Word of Mouth (The Kinks)', 'Every Picture Tells a Story (Rod Stewart)', 'Heroes (Willie Nelson)', 'Based on a T.R.U. Story (2 Chainz)', 'Midnight in the Garden of Good and Evil (Alison Krauss)', 'L.A. Woman (The Doors)', 'Heart in Motion (Amy Grant)', 'London Calling: Live in Hyde Park (Bruce Springsteen)', 'Ram (Paul McCartney)', 'Girls, Vol. 3 (Music from the HBO Original Series) (Ellie Goulding)', 'Dark Matter (GZA)', 'Roots and Wings (artist: Miranda Lambert) (Miranda Lambert)', 'Zenyattà Mondatta (The Police)', 'Restless (Xzibit)', 'Tomahawk Technique (Sean Paul)', 'Down Home Sessions III - EP (Cole Swindell)', 'Witness (Katy Perry)', 'Waist Deep Soundtrack (Nate Dogg)', 'A Medio Vivir (Ricky Martin)', 'Now That’s What I Call Music! 97 [UK] (Lady Gaga)', 'Roger and Out (Roger Miller)', 'Standing on a Beach (The Cure)', 'Kanye West Presents Good Music Cruel Summer (Kid Cudi)', 'Can’t Buy a Thrill (Steely Dan)', 'Made (Scarface)', 'G.I. Blues (Elvis Presley)', 'Walk On (Boston)', 'Bottoms Up (Obie Trice)', 'She Remembers Everything (Rosanne Cash)', 'The Blueprint 2: The Gift & The Curse (JAY-Z)', 'Nothing Safe - The Best of the Box (Alice in Chains)', 'Lupe Fiasco’s The Cool (Lupe Fiasco)', 'Who Feels It Knows It (Rita Marley)', 'Country & Western (A Ride Through History • 1924-1960): CD 05 - History Of 1950 Part 2 (Flatt & Scruggs)', 'The Mini Album (Sex Pistols)', 'Lover (Taylor Swift)', 'Journey (Journey)', 'MDNA (Madonna)', 'Night Visions (Deluxe) (Imagine Dragons)', 'Music Box (Mariah Carey)', 'The Lonesome Sound of Hank Williams (Hank Williams)', 'The Pains of Growing (Alessia Cara)', 'Dig Out Your Soul (Oasis)', 'Number Ones (Janet Jackson)', 'Precious Memories Volume II (Alan Jackson)', 'The Bargain Store (Dolly Parton)', 'Hell Freezes Over (Eagles)', 'JuiceWRLD 9 9 9 (Juice WRLD)', 'B.o.B Presents: The Adventures of Bobby Ray (B.o.B)', 'Back on My B.S. (Busta Rhymes)'];
  List<String> _songName = ["None",'Heartbeat (Steps)', 'Us (Ice Cube)', 'The Real Me (The Who)', 'Down To Earth (Cole Swindell)', 'Ven a Bailar (Jennifer Lopez)', 'Crazy, Crazy Nights (Kiss)', 'Your Time Is Gonna Come (Led Zeppelin)', 'Wow (Snow Patrol)', 'What’s Good (Toni Braxton)', 'Where Do Broken Hearts Go (One Direction)', 'My World (Nate Dogg)', 'Bulls on Parade - triple j Like A Version (Denzel Curry)', 'Me and My Girlfriend (2Pac)', 'Before He Walked (Talib Kweli)', 'It Better End Soon: I. 1st Movement (Chicago)', 'Ribbon in the Sky (Stevie Wonder)', 'No Favors (Big Sean)', 'X (Xzibit)', 'Million Dollar Bill (Whitney Houston)', 'Wonderful Woman (Chuck Berry)', '(Da Le) Yaleo (Santana)', '1,2 1,2 (Raekwon)', 'Higher Ground (Stevie Wonder)', 'Have You Seen That Girl (Lee Ann Womack)', 'Human (Brandy)', 'Beep Me 911 (Missy Elliott)', 'King Of The Dead (XXXTENTACION)', 'Burnin (Twista)', 'M.P.A. (Pusha T)', 'One Day (B.o.B)', 'At Least We Thought It Was (Brantley Gilbert)', 'Desolation Row (Bob Dylan)', 'Ticket to L.A. (Brett Young)', 'Pearl Harbor (Wu-Tang Clan)', 'House on Fire (Sia)', 'We Weren’t Born To Follow (Bon Jovi)', 'Stay (Alison Krauss)', 'Third Stone from the Sun (The Jimi Hendrix Experience)', 'Murder Ink (Dr.\xa0Dre)', 'Picture Book (The Kinks)', 'Fitter Happier (Radiohead)', 'Ego (Beyoncé)', 'WingRiddenAngel (XXXTENTACION)', 'Beat Goes On (Madonna)', 'G’d Up (Wu-Tang Clan)', 'Hop Is Back (Hopsin)', 'Violet Hill (Coldplay)', 'Move to the City (Guns N’ Roses)', 'We Are Never Ever Getting Back Together (Taylor Swift)', 'Over My Head (Cable Car) (The Fray)', 'Coming Clean (Green Day)', 'Bond (Slick Rick)', 'Mr. Tambourine Man (Bob Dylan)', 'Third World Man (Steely Dan)', 'Power Rap (freestyle interlude) (Prodigy of Mobb Deep)', 'Black And Proud (Steel Pulse)', 'I’m Sprung (T-Pain)', 'Lotta Boot Left To Fill (Eric Church)', 'Enough for Now (The Fray)', 'BBO (Bad Bitches Only) (Migos)', 'Of All Things (G-Eazy)', 'The Kids Are Alright (The Who)', 'The Good, the Bad and the Dirty (Panic! at the Disco)', 'Loco-Motive (Nas)', 'Takeover (JAY-Z)', 'Real (NF)', 'Chaser (Carrie Underwood)', 'Hollywood’s Bleeding (Post Malone)', '13 (There Is a Light) (U2)', 'Bump n’ Grind (R. Kelly)', 'Cool Me Down (Tarrus Riley)', 'The Grain (Ghostface Killah)', 'Bridge Burning (Foo Fighters)', 'Territorial Pissings (Nirvana)', 'Like Me (Denzel Curry)', 'Boy (I Need You) (Mariah Carey)', 'Addicted (Gucci Mane)', 'Talkin’ World War III Blues (Bob Dylan)', 'Don’t Judge Me (Chris Brown)', 'A Couple Wrongs Makin’ It Alright (Brothers Osborne)', 'Lullaby (Nickelback)', 'La Villa Strangiato (An Exercise in Self-Indulgence) (Rush)', 'Life on Earth (Snow Patrol)', 'Hey God (Bon Jovi)', 'Born to Touch Your Feelings (Scorpions)', 'Trust Issues (Cardi B)', 'Ghetto Bird (Ice Cube)', '8teen (Garth Brooks)', 'Don’t Go Away (Oasis)', 'Run Tha Streetz (2Pac)', 'Nobody (Rick Ross)', 'Yes (Demi Lovato)', 'The Fighter (Keith Urban)', 'Red Solo Cup (Toby Keith)', 'There, There (Radiohead)', 'Man of the Year (Logic)', 'Be Alright (Justin Bieber)', 'I’m a Ramblin’ Man (Waylon Jennings)', 'When I Look at You (Miley Cyrus)', 'Express Yourself (Edited) (N.W.A)', 'Stars (Cole Swindell)', 'Poor, Poor Pitiful Me (Linda Ronstadt)', 'Cowboys And Angels (Dustin Lynch)', 'The Oppressed Song (Bunny Wailer)', 'Sing for the Moment (Eminem)', 'Alone in Vegas (Pusha T)', 'About Me (Raekwon)', 'Soon We’ll Be Found (Sia)', 'Nothing (Raekwon)', '(When You Gonna) Give It Up To Me (Sean Paul)', 'This Plane (Wiz Khalifa)', 'It’s Just a Matter of Time (Randy Travis)', 'The Rain & The Sun (Interlude) (Big Pun)', 'Love At First Sight (Styx)', 'Get Me Outta Here (Deep Purple)', 'Supastars (Migos)', 'Burn Out (Midland)', 'Where Do You Think You’re Going? (Dire Straits)', 'Rocket Man (I Think It’s Going to Be a Long, Long Time) (Elton John)', 'Back to Caroline (Jamey Johnson)', 'No Worries (Lil Wayne)', 'Wack Niggaz (Talib Kweli)', 'Still Writing Songs About You (Old Dominion)', 'Scared (Paul McCartney)', 'South Of Cincinnati (Dwight Yoakam)', 'One More (Ne-Yo)', 'Say Goodbye (Green Day)', 'I. Pink Toes (Childish Gambino)', 'No Leaf Clover (Metallica)', 'Machine Gun Funk (The Notorious B.I.G.)', 'The Train, Pt. 2 (Sir Lucious Left Foot Saves the Day) (Big Boi)', 'Working Man Blues (Merle Haggard)', 'Starlight (Jon Pardi)', 'Look After You (The Fray)', 'Honest (Future)', 'I’m Holdin’ on to Love (To Save My Life) (Shania Twain)', 'Come on Down (Big Daddy Kane)', 'Journey Through the Past (Neil Young)', 'Zeltron 6 Billion (Denzel Curry)', 'Forever A G (Xzibit)', 'By the Seat of Your Pants (Jamey Johnson)', 'I Wish U Heaven (Prince)', 'Ballin (Logic)', 'Do Ya Thang (Ice Cube)', 'Prostitute (Guns N’ Roses)', 'Higher Ground (UB40)', 'Lolo (Intro) (Dr.\xa0Dre)', 'You’re My Love (Kenny Rogers)', 'Left Side Of Leavin’ (Brett Young)', 'Cryin’ (Aerosmith)', 'Nervous (Shawn Mendes)', 'Time (Pink Floyd)', 'When It Hurts so Bad (Lauryn Hill)', 'Years Ago (Jimmie Rodgers)', 'At My Most Beautiful (R.E.M.)', 'Wut We Doin? (2 Chainz)', 'Irreplaceable (Beyoncé)', 'School Days (Chuck Berry)', 'Are You Experienced? (The Jimi Hendrix Experience)', '\u200ball my friends (21 Savage)', 'Nobody (Dylan Scott)', 'Monster (Meek Mill)', 'Girls Got Rhythm (AC/DC)', 'It Ain’t My Fault (Brothers Osborne)', 'One (Ghostface Killah)', 'Dead End Street (The Kinks)', 'The City (The Game)', 'The Finest (MF DOOM)', 'Waving Goodbye (Sia)', 'Waiting (Dustin Lynch)', 'Heroin (The Velvet Underground)', 'Don’t Wanna Write This Song (The Acoustic Sessions) (Brett Young)', 'Use Me (Future)', 'Luv Me, Luv Me (Shaggy)', 'Time Don’t Wait (Marty Stuart)', 'Drunk Texting (Chris Brown)', 'Get Her Back (Robin Thicke)', 'Buy That Man a Beer (Jon Pardi)', 'Hero (Chris Lane)', 'Saturday in the Park (Chicago)', 'Blame (Calvin Harris)', 'How Long Will I Love You (Ellie Goulding)', 'Hearts (Yes)', 'I’m Living (Sizzla)', 'House of Love (Amy Grant)', 'Mamacita (Travis Scott)', 'Gang Related (Logic)', 'Africa Bamba (Santana)', 'President Carter (Lil Wayne)', 'Olivia Mae (Brett Young)', 'Pussy Print (Gucci Mane)', 'Her (Cole Swindell)', r'Fukk Sleep (A$AP Rocky)', 'Saturday Night (Chris Lane)', 'Si Te Vas (Shakira)', 'London Bridge (Fergie)', 'Suddenly (Toni Braxton)', 'Far East Man (George Harrison)', 'Green Light (John Legend)', 'Feelin’ Way Too Damn Good (Nickelback)', 'Sorry (T.I.)', 'Eskimo Blue Day (Jefferson Airplane)', 'Loving You (Michael Jackson)', 'I Hate You, Don’t Leave Me (Demi Lovato)', 'Where the Blacktop Ends (Keith Urban)', 'Love Street (The Doors)', 'Orion (Metallica)', 'Play Something Country (Brooks & Dunn)', 'Countdown (Snoop Dogg)', 'In The End (Snow Patrol)', 'Oh Love (Green Day)', 'Car Wash (Christina Aguilera)', 'Eyes Like Yours (Ojos Así) (Shakira)', 'Gangster (Yelawolf)', 'Airstream Song (Miranda Lambert)', 'Gimme Some Truth (John Lennon)', 'E.T. (Katy Perry)', 'Want You Back (Tim McGraw)', 'Demon Limbs (PVRIS)', 'My Style (The Black Eyed Peas)', 'Ooh Baby (You Know That I Love You) (George Harrison)', 'The Good Fight (Prodigy of Mobb Deep)', 'Yesterday (Paul McCartney)', 'Sail On Sailor (The Beach Boys)', 'Lie to Me (Future)', 'Ain’t No Time to Go (Loretta Lynn)', 'Gonna Raise Hell (Cheap Trick)', 'I Miss You (Adele)', 'I Know Places (Taylor Swift)', 'Cruisin’ (T.I.)', 'Bittersweet (Ellie Goulding)', 'My Woman (Beenie Man)', 'Don’t Play This Song (Kid Cudi)', 'Heartbeat (The Fray)', 'G.I.N.A.S.F.S. (Fall Out Boy)', 'Bicken Back Being Bool (YG)', 'Gas Drawls (MF DOOM)', 'It Never Rains (Dire Straits)', 'Hero (Nas)', 'You Know How We Do It (Ice Cube)', 'Holding on for Life (Ellie Goulding)', 'The Message (Dr.\xa0Dre)', 'Let Me Fly (DMX)', 'You Need Hands (Sex Pistols)', 'World’s An Addiction (Nas)', 'I Want to Know What Love Is (Mariah Carey)', 'How Great Thou Art (Alan Jackson)', 'ALONE, PART 3 (XXXTENTACION)', 'Goat Talk (T-Pain)', 'Blow Away (George Harrison)', 'Monty Got A Raw Deal (R.E.M.)', 'What You Do to Me (John Legend)', 'No More Songs to Sing (Ray Price)', 'Say When (The Fray)', 'My Love (Céline Dion)', 'Mark My Words (Justin Bieber)', 'U Not Like Me (50 Cent)', 'Sax and Violins (Talking Heads)', 'Calypso (John Denver)', 'Back Where You Belong (Foreigner)', 'Gas and Mud (Gucci Mane)', 'Little Deuce Coupe (The Beach Boys)', 'Overture (The Who)', 'Cuban Links (Luciano)', 'Caravan of Fools (John Prine)', 'One Time (Justin Bieber)', 'Old 8x10 (Randy Travis)', 'Why Can’t I Be You? (The Cure)', 'New York State of Mind (Billy Joel)', 'But It’s Better If You Do (Panic! at the Disco)', 'American Bad Dream (Kane Brown)', 'Who Says You Can’t Go Home (Duet Version) (Bon Jovi)', 'Outshined (Soundgarden)', 'Breathe on Me (Britney Spears)', 'Devil in a New Dress (Kanye West)', 'By Design (Kid Cudi)', 'Feelin’ on Yo Booty (R. Kelly)', 'Only You (Ellie Goulding)', 'Proud (Marshmello)', 'Better Than Words (One Direction)', 'Hollywood Divorce (OutKast)', 'Do You Remember (Ellie Goulding)', 'Dancing Forever (Michael Ray)', 'ROADS UNTRAVELED (Linkin Park)', 'Too Funky (George Michael)', 'THROWAWAY (Ski Mask the Slump God)', 'Think About Me (Fleetwood Mac)', 'Harambe (Young Thug)', 'You and I (PVRIS)', 'I Don’t Think About You (Kelly Clarkson)', 'Riot (Sean Paul)', 'Feeling (Juice WRLD)', 'Roots (Imagine Dragons)', 'Wake Up (Fergie)', 'Tell Me If You Still Care (Monica)', 'Spaceship Coupe (Justin Timberlake)', 'Science Genius 12.12.12 Speech (GZA)', 'Babylon (OutKast)', 'Masters of Our Fate (Raekwon)', 'Mud On The Tires (Brad Paisley)'];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final longTextFieldController = TextEditingController();
  ListSelector selectedGenre;
  SearchSelectMenu selectedArtist;
  SearchSelectMenu selectedYear;
  SearchSelectMenu selectedAlbum;
  SearchSelectMenu selectedSongTitle;
  BatchSlider batchSlider;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final appBar = PreferredSize(
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(246, 247, 249, 1),
              border: BorderDirectional(
                  bottom: BorderSide(width: 1, color: Colors.black12))),
          child: Padding(
              padding: EdgeInsets.only(top: 22, left:26),
              child: Row(
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
//                            alignment: AlignmentDirectional.centerStart,
                            child: Text("Lyrics Genius",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold)
                            )
                        ),
                        Container(
//                            alignment: AlignmentDirectional.centerStart,
                            child: Text("Select Conditions",
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                        ),
                      ]
                    ),
                    Padding(
                        padding: EdgeInsets.only(top:0, left:70, bottom:22),
                      child: Container(
                          width: 60,
                          height: 60,
                          child: RaisedButton(
//                            color: Color(0xFFe78200),
                            child: const Text('Set',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              setConditions(selectedGenre, selectedArtist, selectedYear, selectedAlbum, selectedSongTitle, longTextFieldController, batchSlider);
                              widget.pageController.animateToPage(1,
                                  duration: Duration(milliseconds: 500), curve: Curves.decelerate);
                            },
                          )
                      )
                      ),
                  ],
              )
          ),
        ),
        preferredSize: Size.fromHeight(90));

    return Scaffold(
      appBar: appBar,
      key: scaffoldKey,
      body: DirectSelectContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      selectedGenre = ListSelector(data: _genre, label: "Genre", scaffoldKey: scaffoldKey, iconCode: 58373),
                      SizedBox(height: 10.0),
                      selectedArtist = SearchSelectMenu(itemsList: _artist, selectionLabel: "Artist | Band", iconCode: 59603),
                      SizedBox(height: 10.0),
                      batchSlider = BatchSlider(),
                      SizedBox(height: 10.0),
                      selectedYear = SearchSelectMenu(itemsList: _year, selectionLabel: "Year", iconCode: 59670),
                      SizedBox(height: 10.0),
                      selectedAlbum = SearchSelectMenu(itemsList: _album, selectionLabel: "Album", iconCode: 57369),
                      SizedBox(height: 10.0),
                      selectedSongTitle = SearchSelectMenu(itemsList: _songName, selectionLabel: "Song Title", iconCode: 57956),
                      SizedBox(height: 10.0),
                      longTextField(),
                      SizedBox(height: 15.0),
                      Row(children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                              child: const Text('Set Conditions',
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () {
                                  setConditions(selectedGenre, selectedArtist, selectedYear, selectedAlbum, selectedSongTitle, longTextFieldController, batchSlider);
                                  widget.pageController.animateToPage(1,
                                      duration: Duration(milliseconds: 500), curve: Curves.decelerate);
                                },
                            ))
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget longTextField(){
    return Column(
      children: [
        Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.only(left: 4),
            child: Text("Own Lyrics")),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Container(
            height: 160,
            width: 340,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: TextField(
                    controller: longTextFieldController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: Color(0xFF1eb2a6),
      //              expands: true,
                    maxLength: 1000,
            //      maxLengthEnforced: true,
                    decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF1eb2a6))
                        ),
                        focusedBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF1eb2a6))
                        ),
                        labelText: "Write your bars",
                        helperText: "Let Lyrics Genius continue off your lines",
                        labelStyle: TextStyle(color: Color(0xFF1eb2a6)),
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
      //                  suffixStyle: TextStyle(color: Color(0xFF1eb2a6))
                    ),

                ),
              ),
            ),
          ),
        ),
      ],
    );
  }



  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(
            color: Color(0xFF1eb2a6)
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Lyrics Genius"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Use features to generate song lyrics of mixed styles.\n'),
            Text('For example, blend the style of your favourite pop artist with the country genre.\n'),
            Text('Remember, the more styles you mix, the more likely results being less impressive.'),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }


  void setConditions(
        ListSelector selectedGenre,
        SearchSelectMenu selectedArtist,
        SearchSelectMenu selectedYear,
        SearchSelectMenu selectedAlbum,
        SearchSelectMenu selectedSongTitle,
        TextEditingController textEditingController,
        BatchSlider batchSlider,
      ){
    //     The keys are in correct format expected by the API
    widget.condsStreamCtrl.sink.add({
      "genre": selectedGenre.getSelectedItem(),
      "artist": selectedArtist.getSelectedItem(),
      "year": selectedYear.getSelectedItem(),
      "album": selectedAlbum.getSelectedItem(),
      "song_name": selectedSongTitle.getSelectedItem(),
      "batch_size": batchSlider.batchSize.toString(),
      "init_lyrics": textEditingController.text,
    });
  }

}



