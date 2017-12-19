require "grundl"
require "krypto"
require "analyse"

--chin. RS:
--a = 1 (mod 2)
--a = 5 (mod 13)
print("--CRS mod 26-----")
print(crs({[2]=1,[13]=5}))

--Primzahlen bis:
print("--Primz. bis 23--")
for p in primbis(23) do
    print(p)
end
print("\n")

--Primfaktoren:
print("--Primfaktorzerl-")
print(2^2*7^2*19,"=")
for p,i in primfakt(2^2*7^2*19) do
    print(p,"^",i,"*")
end
print("1\n")


--RkRinge
local a = RRElement(12,3)
local b = RRElement(12,5)
print("--Operat. in Zn--")
print(b^(-1)+a)


--Matrizen
m = Matrix({0,1,0,0},2,RkRing(2))
m2 = Matrix({1,2,3,4,5,6,7,10,9},3,RkRing(11))
m3 = Matrix({1,2,3,4,5,6,7,10,9},3,RkRing(48))
print("--Matrixop.------")
print(m)
print(m*m)

print(m2)
print(m2:t())
print(m2:inv())
print(m2:inv()*m2==Matrix.eins(m2.nrow,m2.ring))
print(m3:det())
local hillvl = Matrix(stringToAlphaArray("LNIVYRDZSMXRGPCP"),4)
print("--Det+Inv. aus VL-")
print(hillvl:det())
print(hillvl:inv())

--Chiffren:
print("Chiffren:")
print("--affin----------")
print(affin_ver("DF","AFFIN"))
print(affin_ent("DF","FUUDS"))
print("--Hill-----------")
print(hill_ver("LNIVYRDZSMXRGPCP","HILL"))
print(hill_ent("LNIVYRDZSMXRGPCP","NERX"))
print("--Vigenère-------")
print(vigenere_ver("WIE","VIGENERE"))
print(vigenere_ent("WIE","RQKAVINM"))
print("--Beaufort-------")
print(beaufort("WIE","BEAUFORT"))
print(beaufort("WIE","VEECDQFP"))
print("--Autokey klar---")
print(autokeyklar_ver("WIE","VIGENERE"))
print(autokeyklar_ent("WIE","RQKZVKVR"))
print("--Autokey krypto-")
print(autokeykrypto_ver("WIE","VIGENERE"))
print(autokeykrypto_ent("WIE","RQKVDOMH"))
print("--Blocktransp.---")
--Schlüssel ist Spalten in Buchstabennot: B=1 C=2 usw.
print(blocktrans_ver("CBFDE","BLOCKTRANS"))
print(blocktrans_ent("CBFDE","LBKOCRTSAN"))

print(ngramm_anteil("ergebnisderbigrammanalyse",2))
print(lang.de.bi)
print(lang.en.bi)
local yadd = affin_ver("BD",
    "NICHTSOLANGERTEXTABERTEXTDERHOFFENTLICHLANGGENUGIST")
local kand1 = additivngramm(yadd,lang.de,1,1)
local kand2 = additivngramm(yadd,lang.de,2,7)
local kand3 = additivngramm(yadd,lang.de,3,7)
local kand4,x4 = additivpassend(yadd,lang.de)
print(dump(kand1,2))
print(dump(kand2,2))
print(dump(kand3,2))
print(kand4,x4)

local beispVigAna = "HUDSKUAEZGXRAVTFPGWSWGWSZHTPPBILLRTZPZHWLOIJ" ..
    "VFICVBTHLUGILGPRKHWMYHTIUAXRBHTWUCGXOSPWAOCHIMCSYHWQHWCFYOCG" ..
    "OGTZLBILSWBFLOHXZWSIZVDSATGSTHWISSUXLMTSMHWIKSPXOGWIHRPFLSAM" ..
    "USUVVAILLHGILHWVVIVLAVTWOCIJPTICMSTXVII"
    print(vigenereICmax(beispVigAna,lang.en,20))--Spalten individ. 
    print(vigenereICmax(beispVigAna,lang.en,20,true))--gemeins. IC
    print(vigenereICerw(beispVigAna,lang.en,20))--Spalten individ.
    print(vigenereICerw(beispVigAna,lang.en,20,true))--gemeins. IC
    --kombiniere beide Ansätze, erst erw. IC, dann im Bereich 
    --d+/-1 den max. IC
    print(vigenereICerw(beispVigAna,lang.en,20,false,1))--Spalten ind.
    print(vigenereICerw(beispVigAna,lang.en,20,true,1))--gemeins. IC

--Transposition und S-Box aus dem SPN aus der VL
local transvl = 
    {1, 5, 9, 13, 2, 6, 10, 14, 3, 7, 11, 15, 4, 8, 12 , 16}
local sboxvl = sboxHex("E4D12FB83A6C5907")
local spnvl = spn(16,kgenShift,sboxvl,4,transvl,4)
local kspnvl = hexStringToBitArray("3A94D63F")
local xspnvl = hexStringToBitArray("26B7")

print(spnvl(kspnvl,xspnvl))


