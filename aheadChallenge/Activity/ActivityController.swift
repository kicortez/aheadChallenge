//
//  ActivityController.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import Foundation

class ActivityController: ObservableObject {
    @Published var viewModel: ActivityViewModel?
    
    // Replace with call from source as needed
    func getActivity() {
        let decoder = JSONDecoder()
        guard let resource = Bundle.main.url(forResource: "activity-response", withExtension: "json"),
              let data = try? Data(contentsOf: resource),
              let response = try? decoder.decode(ActivityResponse.self, from: data) else { return }
        
        viewModel = ActivityViewModel(activityResponse: response)
    }
    
    func getScreensViewModel() -> ActivityScreensViewModel {
        return ActivityScreensViewModel(screens: viewModel?.screens ?? [])
    }
}

class ActivityViewModel: ObservableObject {
    let activityResponse: ActivityResponse
    
    var title: String { activityResponse.title }
    var description: String { activityResponse.description }
    var screens: [ActivityScreen] { activityResponse.activity.screens }
    
    init(activityResponse: ActivityResponse) {
        self.activityResponse = activityResponse
    }
}

class ActivityScreensViewModel: ObservableObject, ScreenNavigatable {
    let screens: [ActivityScreen]
    @Published var currentPage = 0
    
    init(screens: [ActivityScreen]) {
        self.screens = screens
    }
    
    var currentScreen: ActivityScreen? {
        guard currentPage < screens.count, currentPage >= 0 else { return nil }
        return screens[currentPage]
    }
    
    func nextScreen() {
        currentPage += 1
    }
    
    func previousScreen() {
        currentPage -= 1
    }
    
    var canGoBack: Bool { currentPage > 0 }
    
    func endActivity() {}
}
