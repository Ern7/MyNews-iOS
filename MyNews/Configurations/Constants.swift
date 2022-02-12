//
//  Constants.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

struct Constants {
    
    struct AppConfig {
        static let BackendUrl = "https://newsapi.org/";
        static let DEBUG_MODE = true;
    }

    struct ApiKeys {
        static let NewsApiKey = "";
    }
    
    struct Font {
        static let bold = "Montserrat-Bold";
        static let regular = "Montserrat-Regular";
        static let medium = "Montserrat-Medium";
        static let semiBold = "Montserrat-SemiBold";
        static let thin = "Montserrat-Thin";
    }
    
    struct AppPalette {
        static let primaryColor = "#A9A8FA";
        static let invisibleGrey = "#C1D2D8"
        static let pageBackgroundGrey = "#F8F8F8"
    }
    
    struct UserDefaultsKeys {
        static let Country = "Country";
    }
    
    struct CellIdentifiers {
        static let headlinesTableViewCell = "HeadlinesTableViewCell";
    }
}
