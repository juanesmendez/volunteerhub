//
//  RegistrationTopics.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 28/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct RegistrationTopics: View {
    
    @State var environment = false
    @State var vulnerablePopulations = false
    @State var disabilities = false
    @State var animals = false
    @State var poor = false
    @State var tutoring = false
    @State var elders = false
    
    var body: some View {
        
        VStack{
            
            
            Form {
                Text("What topics are you interested in?")
                .font(.title)
                .bold()
                
                Section {
                    Toggle(isOn: $environment) {
                        Text("Environment")
                    }
                    Toggle(isOn: $vulnerablePopulations) {
                        Text("Vulnerable populations")
                    }
                    Toggle(isOn: $disabilities) {
                        Text("Helping people with disabilities")
                    }
                    Toggle(isOn: $animals) {
                        Text("Animals")
                    }
                    Toggle(isOn: $poor) {
                        Text("Building homes for the poor")
                    }
                    Toggle(isOn: $tutoring) {
                        Text("Tutoring")
                    }
                    Toggle(isOn: $elders) {
                        Text("Helping the elder ones")
                    }
                }
            }
        }
        
    }
}

struct RegistrationTopics_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationTopics()
    }
}
