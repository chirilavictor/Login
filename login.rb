# sectiunea 1: baza de date cu utilizatori

# $users_profil = {            # ani   oras    stare civila
# 	"chirilavictor" => ["29", "Iasi", "necasatorit"],
# 	"danielaboghian" => ["25", "Cluj", "casatorita"]
# }
utilizatori = File.open("utilizatori.txt", "r+"){ |f| f.read.split }
print "#{utilizatori}" # afisam baza de date, in mod normal nici un utilizator nu ar trebui sa vada baza de date
puts

# semnul $ e ca sa fie variabila globala. Adica ca sa o pot accesa si din interiorul unei metode
$users_profil = {}   # utiliatori.inject(Hash.new(0)) { |k,v|  } # aici am incercat sa fac ceva cu inject dar nu a mers
# in while-ul de mai jos parcurg array-ul utilizatori din 4 in 4. Stiu ca pe pozitia utilizatori[0] voi avea primul username pe pozitia utilizatori[1] voi avea varsta usenamului anterior etc. Stiu pentru ca tot eu sau mai bine zis tot acest script creeaza baza de date.
# deci utilizatori[i] va fi cheia hash-ului iar urmatoarele valori pana la i+3 le pun intr-un nou array asociat volorii cheiei de dinainte. As putea sa le pun foarte simplu intr-un string dar planuiam sa folosesc aceste valori pentru a oferi posibilitatea utilizatorului sa le modifice. Si acest lucru se face foarte usor cu array-uri.
i = 0
while utilizatori[i] != nil 
	$users_profil[utilizatori[i]] = [utilizatori[i+1], utilizatori[i+2], utilizatori[i+3]]
	i += 4
end

# puts $users_profil.class
# functia pe care o folosim pentru cazul cand utilizatorul are deja cont
def login(user)
	if $users_profil.include?(user)
		puts "Username: #{user}"
		puts "Profil: #{$users_profil[user]}" 
	else 
		puts "Numele de utilizator este gresit."
		prima # daca a scris usernamul gresit sau daca acel username nu exista atunci scriptul practic se reinitializeaza
	end
end

# functia pentru inreistrarea unui nou utilizator
def register
	i = 0
	while i <= 10
		print "Alege un username: "
		alegere_username = gets.chomp
		if $users_profil.include?(alegere_username)
			puts "Numele de utilizator deja exista."
		else
			puts "Felicitari, numele tau de utilizator este: #{alegere_username}"
			puts "Completeaza profilul: "
			print "Varsta: "
			varsta = gets.chomp
			print "In ce oras locuiesti:  "
			oras = gets.chomp
			print "Stare civila: "
			scivil = gets.chomp

			arr_util = [varsta, oras, scivil] # stocam valorile intr-un array pe care il adaugam ca valoare atasata cheiei din hash-ul $users_profil
			$users_profil.store(alegere_username, arr_util) # pur si simplu adaugam in baza de date
			puts $users_profil[alegere_username] # printam de dragul afisarii
			printout # apelam functia care stocheaza noua baza de date intr-un fisier .txt
			break
		end
	i += 1
	end


end

# sectiune 2: login utilizatori
def prima
	i_choose = 0
	while i_choose <= 10
	puts "Alege si tasteaza: 'login' sau 'register'"
	choose_login = gets.chomp

		if choose_login == 'login'
			print "Scrie numele de utilizator: "
			nume_utilizator = gets.chomp
			login(nume_utilizator)
	 		break
			elsif choose_login == 'register'
				register
				break
			else 
				puts "Tasteaza corect cu litere mici: 'login' sau 'register'"
		end

		i_choose += 1
	end
end

# aici rescriem fisierul utilizatori.txt cu noile valori adaugate de utilizatorul nou
# daca veti reincarca programul acesta va "tine minte" ce ati facut data trecuta
def printout
	output = File.new("utilizatori.txt", "w")
	$users_profil.each do |k,v|
		output.puts k + " " + v[0].to_s + " " + v[1].to_s + " " + v[2].to_s
	end
	output.close
end

prima



 