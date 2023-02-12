//
//  Errors.swift
//  Gaming Application
//
//  Created by Ali Murad on 10/02/2023.
//

import UIKit

enum NetworkRequestError: Error {
    case parsingError
    case emptyData
    case notConnected
    case serverError(error: String)

    func showErrorDialog(viewController: UIViewController?) {
        var errorMsg = "General proccess error.\n Please try again."
        switch self {
        case .parsingError:
            print("parsing Error")
            break
        case .emptyData:
            errorMsg = "No data found"
        case .notConnected:
            errorMsg = "Reconnect internet and try again."
        case .serverError(let errorMsg):
            print(errorMsg)
            break
        }

        let alert = UIAlertController(title: nil, message: errorMsg, preferredStyle: .alert)
        let btn = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(btn)
        viewController?.present(alert, animated: true)
    }
}
