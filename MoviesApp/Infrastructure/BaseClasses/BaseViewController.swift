//
//  BaseViewController.swift
//  MoviesApp
//
//  Created by Mahmoud Aziz on 22/07/2023.
//  Copyright © 2023 Telda. All rights reserved.
//

import UIKit

// MARK: - BaseViewController

open class BaseViewController: UIViewController {
    // MARK: - Computed Properties

    override open var preferredStatusBarStyle: UIStatusBarStyle { return .default }

    private var viewModel: StatableViewModel?

    // MARK: - Lifecycle Methods

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    func bindViewModelState(_ viewModel: StatableViewModel) {
        self.viewModel = viewModel
        self.viewModel?.state = self
    }

    // MARK: - Handle State Changes

    open func handleViewModelRequestFailedState(_: String) {}
    open func handleViewModelCompletedState() {}
    open func handleViewModelReloadState() {}
    func handleViewModelLoadingState(_ state: State) {
        showLoader(state == .loading)
    }
}

// MARK: - Stateful

extension BaseViewController: Stateful {
    public func mutate(newState: State) {
        handleViewModelLoadingState(newState)
        switch newState {
        case .completed:
            handleViewModelCompletedState()
        case let .failed(error):
            handleViewModelRequestFailedState(error)
        case .reload:
            handleViewModelReloadState()
        case let .navigate(destination):
            navigate(to: destination)
        default:
            break
        }
    }
}
