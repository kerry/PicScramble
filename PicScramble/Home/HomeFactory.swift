//
// Created by Prateek Grover on 18/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import UIKit
import Swinject

typealias HomeModule = HomeInteractorOutput & HomeViewOutput

class HomeFactory: Assembly {
    func assemble(container: Container) {
        container.register(HomeModule.self) { r in
            return HomePresenter()
            }
            .initCompleted { r, p in
                let presenter = p as! HomePresenter
                presenter.view = r.resolve(HomeViewInput.self) as! HomeViewController
                presenter.router = r.resolve(HomeRouterInput.self) as! HomeRouter
                presenter.interactor = r.resolve(HomeInteractorInput.self) as! HomeInteractor
        }
        
        container.register(HomeViewInput.self) { _ in
            UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            }
            .initCompleted { r, v in
                let vc = v as! HomeViewController
                vc.output = r.resolve(HomeViewOutput.self) as! HomePresenter
        }
        
        container.register(HomeViewOutput.self) { r in
            r.resolve(HomeModule.self)!
        }
        
        container.register(HomeRouterInput.self) { r in
            HomeRouter()
            }
            .initCompleted { r, p in
                let router = p as! HomeRouter
                router.viewController = r.resolve(HomeViewInput.self) as? UIViewController
        }
        
        container.register(HomeInteractorInput.self) { _ in
            HomeInteractor()
            }
            .initCompleted { r, i in
                let interactor = i as! HomeInteractor
                interactor.output = r.resolve(HomeInteractorOutput.self) as! HomePresenter
        }
        
        container.register(HomeInteractorOutput.self) { r in
            r.resolve(HomeModule.self)!
        }
    }
}
