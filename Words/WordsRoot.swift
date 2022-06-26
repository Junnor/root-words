//
//  WordsRoot.swift
//  Words
//
//  Created by ys on 2022/6/23.
//

import Foundation
import RealmSwift

// https://www.mongodb.com/docs/realm/sdk/swift/quick-start/

class LastWord: Object {
    
    @Persisted var name = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

class WordIndex: Object {
    
    @Persisted var index: Int
    
    convenience init(index: Int) {
        self.init()
        self.index = index
    }
}

let sourceRootWords = ["003\"dur\"", "004\"holic\"", "005\"alt\"", "006\"pany\"", "007\"dol\"", "008\"migr\"", "009\"tangle\"", "010\"fla\"", "011\"und\"", "012\"err\"", "013\"labor\"", "014\"am\"", "015\"jelly\"", "016\"ee\"", "017\"conq\"", "018\"bhor\"", "019\"vita\"", "020\"haus\"", "021\"mon\"", "022\"vigor\"", "023\"awe\"", "024\"-er\"", "025\"viro\"", "026\"dim\"", "027\"un-\"", "028\"fac\"", "029\"sassin\"", "030\"hate\"", "031\"son\"", "032\"mort\"", "033\"co con com\"", "034\"deb\"", "035\"fev\"", "036\"tomb\"", "037\"plunge\"", "038\"-cian\"", "039\"vac\"", "040\"tami\"", "041\"seven\"", "042\"fee\"", "043\"deny\"", "044\"mini\"", "045\"loq\"", "046\"disa\"", "047\"bi-\"", "048\"hol\"", "049\"chan\"", "050\"hotel\"", "051\"massa\"", "052\"cens\"", "053\"movie\"", "054\"paw\"", "055\"langui\"", "056\"dread\"", "057\"dodge\"", "058\"maid\"", "059\"teen\"", "060\"hal\"", "061\"pain\"", "062\"eu\"", "063\"isol\"", "064\"rar\"", "065\"heir\"", "066\"ploy\"", "067\"cease\"", "068\"numb\"", "069\"gang\"", "070\"tan\"", "071\"rumor\"", "072\"lend\"", "073\"loyal\"", "074\"shit\"", "075\"yer\"", "076\"hook\"", "077\"merge\"", "078\"equ\"", "079\"marshal\"", "080\"nym\"", "081\"canteen\"", "082\"hance\"", "083\"chat\"", "084\"lun\"", "085\"bullet\"", "086\"sandwich\"", "087\"typhoon\"", "088\"want\"", "089\"guess\"", "090\"feeb\"", "091\"taboo\"", "092\"wee\"", "093\"ebb\"", "094\"ardu\"", "095\"dum\"", "096\"hein\"", "097\"mum\"", "098\"mall\"", "099\"for\"", "100\"doc\"", "101\"umb\"", "102\"staff  fran\"", "103\"ole\"", "104\"dye\"", "105\"little\"", "106\"soar\"", "107\"genius\"", "108\"might\"", "109\"horr\"", "110\"swamp\"", "111\"blind\"", "112\"iso\"", "113\"jacket\"", "114\"diesel\"", "115\"tangi\"", "116\"ruin\"", "117\"leisure\"", "118\"bald\"", "119\"nec\"", "120\"tread\"", "121\"bind\"", "122\"ballet\"", "123\"yogurt\"", "124\"jam\"", "125\"jack\"", "126\"cheat\"", "127\"mir\"", "128\"dilige\"", "129\"pat\"", "130\"whistle\"", "131\"tom\"", "132\"howl\"", "133\"pest\"", "134\"-eer\"", "135\"assidu\"", "136\"schedule\"", "137\"haul\"", "138\"vanq\"", "139\"dream\"", "140\"tard\"", "141\"gem\"", "142\"jun\"", "143\"jewel\"", "144\"poly\"", "145\"demp\"", "146\"hoop\"", "147\"shun\"", "148\"whirl\"", "149\"latry\"", "150\"plead\"", "151\"bru\"", "152\"tattoo\"", "153\"text\"", "154\"be-\"", "155\"chao\"", "156\"modern\"", "157\"murmur\"", "158\"-dom\"", "159\"idol\"", "160\"phoen\"", "161\"laser\"", "162\"trophy\"", "163\"mirror\"", "164\"pie\"", "165\"jeal\"", "166\"woo\"", "167\"mel\"", "168\"flee\"", "169\"myst\"", "170\"tour\"", "171\"title\"", "172\"jar\"", "173\"saint\"", "174\"nown\"", "175\"eon\"", "176\"can\"", "177\"sto\"", "178\"hormone\"", "179\"few\"", "180\"ail\"", "181\"seat\"", "182\"myth\"", "183\"cook\"", "184\"sault\"", "185\"ease\"", "186\"cute\"", "187\"youth\"", "188\"leave\"", "189\"give\"", "190\"ear\"", "191\"car\"", "192\"soon\"", "193\"porn\"", "194\"fort ford force\"", "195\"gadge\"", "196\"tel\"", "197\"lumin\"", "198\"vince\"", "199\"franc slave\"", "200\"patr matr\"", "201\"ess\"", "202\"max mag maj\"", "203\"bili\"", "204\"bob bub bulb\"", "205\"neg\"", "206\"bat\"", "207\"golf\"", "208\"vey\"", "209\"dyn\"", "210\"pract\"", "211\"ace\"", "212\"tal\"", "213\"prim\"", "214\"tedi\"", "215\"vor\"", "216\"sol\"", "217\"plat\"", "218\"tach\"", "219\"trem\"", "220\"bra\"", "221\"sooth\"", "222\"pop\"", "223\"fab\"", "224\"lat\"", "225\"serv\"", "226\"gon\"", "227\"bar\"", "228\"tow\"", "229\"ling\"", "230\"glu\"", "231\"hobby\"", "232\"ben\"", "233\"caut caust\"", "234\"psyche\"", "235\"mobi\"", "236\"pal\"", "237\"vein\"", "238\"colon\"", "239\"elas\"", "240\"kill mill\"", "241\"dop\"", "242\"voc vok\"", "243\"turb\"", "244\"rain\"", "245\"lim limin\"", "246\"sist\"", "247\"crust\"", "248\"jill\"", "249\"summ\"", "250\"fibr\"", "251\"noc\"", "252\"neighbor\"", "253\"calo\"", "254\"van\"", "255\"nihil\"", "256\"nounce\"", "257\"val vail\"", "258\"aer\"", "259\"sour\"", "260\"drama\"", "261\"goat\"", "262\"zom\"", "263\"dulge\"", "264\"bas\"", "265\"stroll\"", "266\"vibr\"", "267\"norm\"", "268\"disc\"", "269\"-sh\"", "270\"sym\"", "271\"quasi\"", "272\"pur\"", "273\"lax\"", "274\"prehend\"", "275\"punc\"", "276\"phony\"", "277\"cola\"", "278\"trib\"", "279\"truan\"", "280\"lone\"", "281\"rio\"", "282\"elegan\"", "283\"chamb\"", "284\"hom\"", "285\"公式:万能t\"", "286\"sover\"", "287\"nylon\"", "288\"bowling\"", "289\"coy\"", "290\"plur\"", "291\"vent\"", "292\"phil\"", "293\"jeep\"", "294\"hum\"", "295\"dive\"", "296\"quaff\"", "297\"dual\"", "298\"fal faul\"", "299\"bath\"", "300\"only\"", "301\"puls\"", "302\"bible\"", "303\"minister\"", "304\"liqu aqu\"", "305\"scen\"", "306\"stable\"", "307\"lotto\"", "308\"lit litter\"", "309\"photo\"", "310\"nucle\"", "311\"agro\"", "312\"veget\"", "313\"tick tack\"", "314\"hilar\"", "315\"schol\"", "316\"imit\"", "317\"stereo\"", "318\"febr\"", "319\"sage\"", "320\"diet\"", "321\"tab\"", "322\"pug\"", "323\"admire\"", "324\"fero\"", "325\"bon\"", "326\"turr\"", "327\"fulge\"", "328\"soph\"", "329\"bi\"", "330\"proto\"", "331\"fur\"", "332\"ed\"", "333\"pred\"", "334\"mord\"", "335\"vener\"", "336\"arist\"", "337\"volt\"", "338\"hyd\"", "339\"bit\"", "340\"oo ov\"", "341\"green\"", "342\"pov\"", "343\"line\"", "344\"agogo\"", "345\"orb\"", "346\"mega\"", "347\"lic relic\"", "348\"dang\"", "349\"fan phan\"", "350\"bale\"", "351\"nov\"", "352\"pod\"", "353\"not\"", "354\"phon\"", "355\"imag\"", "356\"pseudo\"", "357\"finan\"", "358\"measure\"", "359\"phyllo\"", "360\"capit\"", "361\"foli\"", "362\"case\"", "363\"leas\"", "364\"boss\"", "365\"lesion\"", "366\"far\"", "367\"ton tun toun\"", "368\"toler\"", "369\"noun\"", "370\"plank\"", "371\"fasci\"", "372\"clim\"", "373\"woe\"", "374\"hyster\"", "375\"coat\"", "376\"clone\"", "377\"lous\"", "378\"jud\"", "379\"bomb\"", "380\"meter\"", "381\"bond\"", "382\"digit\"", "383\"junct\"", "384\"govern\"", "385\"nut\"", "386\"wow\"", "387\"gest\"", "388\"pol\"", "389\"techn\"", "390\"war\"", "391\"choc\"", "392\"ant\"", "393\"phase\"", "394\"arm\"", "395\"sec\"", "396\"ident\"", "397\"glace\"", "398\"flag\"", "399\"conch\"", "400\"caut\"", "401\"di\"", "402\"grat\"", "403\"morph\"", "404\"ze\"", "405\"mand\"", "406\"lyr\"", "407\"tumu\"", "408\"soc\"", "409\"port\"", "410\"mal\"", "411\"pati hepati\"", "412\"pen\"", "413\"pan\"", "414\"ali\"", "415\"pex\"", "416\"clar\"", "417\"corp\"", "418\"vid vis\"", "419\"mine\"", "420\"river\"", "421\"intel inter\"", "422\"copy\"", "423\"xen\"", "424\"av\"", "425\"marsh\"", "426\"neo\"", "427\"molly\"", "428\"domin\"", "429\"ruby\"", "430\"vow\"", "431\"sur\"", "432\"cer\"", "433\"rol\"", "434\"fine\"", "435\"flor\"", "436\"link linq\"", "437\"pike\"", "438\"fiss\"", "439\"gen\"", "440\"pro\"", "441\"lounge\"", "442\"chron\"", "443\"miss\"", "444\"gn\"", "445\"andr\"", "446\"core cord card\"", "447\"goth ghost\"", "448\"coct\"", "449\"hor\"", "450\"guis\"", "451\"ind end\"", "452\"er缩略成r的公式\"", "453\"hoarse\"", "454\"hoot\"", "455\"emcee\"", "456\"gorge\"", "457\"mango\"", "458\"coolie\"", "459\"marathon\"", "460\"ballyhoo\"", "461\"eery\"", "462\"samba\"", "463\"khan\"", "464\"widget\"", "465\"khaki\"", "466\"lama\"", "467\"mog\"", "468\"ox\"", "469\"cum\"", "470\"jac ros\"", "471\"belle\"", "472\"salon\"", "473\"-ule\"", "474\"flit\"", "475\"cark\"", "476\"eleg\"", "477\"lynch\"", "478\"hew\"", "479\"wirl\"", "480\"naught\"", "481\"sen\"", "482\"sough\"", "483\"dink\"", "484\"ken\"", "485\"boff\"", "486\"Jew\"", "487\"volv\"", "488\"volu\"", "489\"kangaroo\"", "490\"hurl\"", "491\"gouge\"", "492\"ann enn\"", "493\"humil\"", "494\"lobs\"", "495\"doz\"", "496\"kerne\"", "497\"atom\"", "498\"uni\"", "499\"heli\"", "500\"cool\"", "501\"monet\"", "502\"down\"", "503\"cube\"", "504\"call\"", "505\"bus\"", "506\"song\"", "507\"beam\"", "508\"公式：er的缩略\"", "509\"shed\"", "510\"beak\"", "511\"lion\"", "512\"felon\"", "513\"widow\"", "514\"strong\"", "515\"yoyo\"", "516\"-some\"", "517\"whorl\"", "518\"heter\"", "519\"lut\"", "520\"stair\"", "521\"mundan\"", "522\"sky\"", "523\"sponge\"", "524\"ya\"", "525\"pel\"", "526\"pig\"", "527\"wander\"", "528\"thaw\"", "529\"person\"", "530\"show\"", "531\"straw\"", "532\"peak\"", "533\"ivy\"", "534\"shop\"", "535\"dear\"", "536\"sand\"", "537\"jaw\"", "538\"thane\"", "539\"happy\"", "540\"buffet\"", "541\"confu\"", "542\"mosaic\"", "543\"neut\"", "544\"ridge\"", "545\"dam\"", "546\"sham\"", "547\"skull\"", "548\"sudden\"", "549\"snooker\"", "550\"islam\"", "551\"jeer\"", "552\"muslim\"", "553\"alone\"", "554\"qwerty\"", "555\"isl\"", "556\"pud\"", "557\"bungee\"", "558\"age\"", "559\"beau\"", "560\"coffee\"", "561\"scan\"", "562\"scal\"", "563\"enter\"", "564\"motel\"", "565\"haunt\"", "566\"enchant\"", "567\"wish\""]

