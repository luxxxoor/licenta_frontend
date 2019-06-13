//
//  Announcements
//  AnnouncementsMockService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 10/06/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class AnnouncementsMockService: AnnouncementsRemoteService {

    func getAnnouncements(completion: @escaping GetAnnouncementsCompletion) {
        completion(Result.success([Announcement(organisationName: "Google", title: "Google socheaza !", imageUrl: URL(string: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"), description: nil, date: "13.06.2019"),
                                   Announcement(organisationName: "Nemaivazut", title: "Nemaivazut !", imageUrl: nil, description: "Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !Nemaivazut !", date: "13.06.2019"),
                                   Announcement(organisationName: "Stiri", title: "Câte locuri sunt în liceele și școlile profesionale din județ, unde se ține învățământ la seral, dual sau cu frecvență redusă", imageUrl: URL(string: "https://www.timponline.ro/wp-content/uploads/2018/06/Educatie-examen-390x280.jpg" ), description: "Cu întârziere de aproape o lună față de data prevăzută de legislație și după ce au terminat cursurile, elevii care au absolvit clasa a VIII-a află câte clase scot liceele pe care le vizează și care au fost anul trecut ultimele medii cu care s-a intrat la clasele pe care își doresc să dea admitere. Inspectoratul Școlar Județean Bistrița-Năsăud se numără printre cele care au publicat au publicat mai întâi online Ghidul candidatului la admiterea în liceu.\n\nDin broșură aflăm că, în anul școlar viitor, se va organiza o clasă de seral la Liceul Tehnologic Forestier Bistrița cu 28 de locuri în specializarea ”tehnician în prelucrarea lemnului \n\n În învățământul participar vor fi două clase, una la Liceul Creștin ”Logos” cu 30 de locuri – științe ale naturii și una la Liceul Teoretic ”Henri Coandă” Feldru cu 30 de locuri, fililogie – frecvență redusă.", date: "13.06.2019")]))
    }
}
