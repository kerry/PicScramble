//
// Created by Prateek Grover on 18/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import UIKit

class HomeConfigurator {
    func getRouter() -> HomeRouter {
        let presenter = DependencyManager.getInstance().assembler.resolver.resolve(HomeModule.self) as! HomePresenter
        let router = presenter.router as! HomeRouter
        _ = UINavigationController(rootViewController: router.viewController)
        return router
    }
}
