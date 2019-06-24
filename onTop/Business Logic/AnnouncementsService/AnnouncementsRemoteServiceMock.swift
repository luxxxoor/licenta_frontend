//
//  Announcements
//  AnnouncementsMockService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class AnnouncementsRemoteServiceMock: AnnouncementsRemoteService {

    private let announcements: [Announcement] = [Announcement(id: 0, organisationName: "Google", title: "Google socheaza !", imageUrl: URL(string: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"), description: nil, date: "13.06.2019"),
                                                 Announcement(id: 1, organisationName: "Stiri", title: "Câte locuri sunt în liceele și școlile profesionale din județ, unde se ține învățământ la seral, dual sau cu frecvență redusă", imageUrl: URL(string: "https://www.timponline.ro/wp-content/uploads/2018/06/Educatie-examen-390x280.jpg" ), description: "Cu întârziere de aproape o lună față de data prevăzută de legislație și după ce au terminat cursurile, elevii care au absolvit clasa a VIII-a află câte clase scot liceele pe care le vizează și care au fost anul trecut ultimele medii cu care s-a intrat la clasele pe care își doresc să dea admitere. Inspectoratul Școlar Județean Bistrița-Năsăud se numără printre cele care au publicat au publicat mai întâi online Ghidul candidatului la admiterea în liceu.\n\nDin broșură aflăm că, în anul școlar viitor, se va organiza o clasă de seral la Liceul Tehnologic Forestier Bistrița cu 28 de locuri în specializarea ”tehnician în prelucrarea lemnului \n\n În învățământul participar vor fi două clase, una la Liceul Creștin ”Logos” cu 30 de locuri – științe ale naturii și una la Liceul Teoretic ”Henri Coandă” Feldru cu 30 de locuri, fililogie – frecvență redusă.", date: "13.06.2019"),
                                                 Announcement(id: 2, organisationName: "Nemaivazut", title: "Nemaivazut !", imageUrl: nil, description: "Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !", date: "13.06.2019"),
                                                 Announcement(id: 3, organisationName: "Ziar de Cluj", title: "Cimitirul-junglă din Cluj-Napoca", imageUrl: URL(string: "https://www.ziardecluj.ro/sites/default/files/styles/large/public/media/image/2019/06/whatsapp_image_2019-06-20_at_23.19.43_0.jpeg?itok=iDBsakOc"), description: "Cimitirul Municipal din Cluj-Napoca a devenit o junglă. Crucile mormintelor abia se mai văd de buruienile care au crescut înalte de aproape doi metri. Cărările spre morminte sunt imposibil de accesat de cei care vin să lase o lumânare, tocmai de aceea nu mai vezi nici țipenie de om.", date: "20.06.2019"),
                                                 Announcement(id: 4, organisationName: "Ziar de Cluj", title: "ACCIDENT cu VICTIME în Vâlcele", imageUrl: URL(string: "https://www.ziardecluj.ro/sites/default/files/styles/large/public/media/image/2019/06/64592216_821891901523645_5973955748143562752_n_0.jpg?itok=5IycJy5W"), description: "Accident în localitatea clujeană Vâlcele, în jurul orei 12:30. Un tânăr de 20 de ani a părăsit partea carosabilă și a intrat într-un pom. Potrivit polițiștilor, în urma accidentului, șoferul și alți 2 pasageri au fost răniți. Șoferul nu a consumat alcool.", date: "20.06.2019"),
                                                Announcement(id: 5, organisationName: "waka waka waka waka waka waka waka", title: "waka waka ?", imageUrl: nil, description: "waka waka waka waka waka waka waka waka waka waka waka waka waka waka waka waka waka waka waka waka waka ", date: "23.06.2019")]
    
    func getAnnouncements(completion: @escaping GetAnnouncementsCompletion) {
        completion(Result.success(announcements))
    }
    
    func getAnnouncements(for organisation: String, completion: @escaping GetAnnouncementsForOrganisationCompletion) {
        let matchedAnnouncements = announcements.filter { $0.organisationName ==  organisation}
        completion(Result.success((matchedAnnouncements)))
    }
}
