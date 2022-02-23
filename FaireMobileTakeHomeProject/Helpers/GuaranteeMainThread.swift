//
//  GuaranteeMainThread.swift
//  FaireMobileTakeHomeProject
//
//  Created by Carlos Antunes on 22/02/22.
//

import Foundation

func guaranteeMainThread(_ work: @escaping () -> Void) {
    if Thread.isMainThread {
        work()
    } else {
        DispatchQueue.main.async(execute: work)
    }
}
