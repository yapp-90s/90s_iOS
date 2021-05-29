//
//  AlbumSectionModel.swift
//  90s
//
//  Created by 김진우 on 2021/04/09.
//

import RxDataSources

enum AlbumSectionModel {
    case sectionCreate(item: AlbumSectionItem)
    case sectionBanner
    case sectionHeader(items: [AlbumSectionItem])
    case sectionCover(items: [AlbumSectionItem])
    case sectionPreview(items: [AlbumSectionItem])
}

enum AlbumSectionItem {
    case statusCreate(viewModel: AlbumCreateCellViewModel)
    case statusBanner
    case statusHeader(title: String)
    case statusCover(albums: AlbumViewModel)
    case statusPreview(albums: AlbumViewModel)
}

extension AlbumSectionModel: SectionModelType {
    typealias Item = AlbumSectionItem
    
    var items: [AlbumSectionItem] {
        switch self {
        case .sectionCreate(let item):
            return [item]
        case .sectionBanner:
            return [.statusBanner]
        case .sectionHeader(let title):
            return title
        case .sectionCover(let items):
            return items
        case .sectionPreview(let items):
            return items
        }
    }
    
    init(original: AlbumSectionModel, items: [AlbumSectionItem]) {
        switch original {
        case .sectionCreate(let item):
            self = .sectionCreate(item: item)
        case .sectionBanner:
            self = .sectionBanner
        case .sectionHeader(items: _):
            self = .sectionHeader(items: items)
        case .sectionCover(let items):
            self = .sectionCover(items: items)
        case .sectionPreview(let items):
            self = .sectionPreview(items: items)
        }
    }
}
