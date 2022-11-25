//
//  CompositionalLayout.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/25.
//

import UIKit
public final class MyViewLayout {
    class func compositionalLayoutWithContain(gWidth: NSCollectionLayoutDimension, gHeight: NSCollectionLayoutDimension, count: Int) -> NSCollectionLayoutSection{
        let spacing : NSCollectionLayoutSpacing = .fixed(18)
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(128), heightDimension: .absolute(148)))
        let hgroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: gWidth, heightDimension: gHeight), subitem: item , count: count)
        hgroup1.interItemSpacing = spacing
        let hgroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: gWidth, heightDimension: gHeight), subitem: item ,count: count)
        hgroup2.interItemSpacing = spacing
        let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .estimated(600), heightDimension: .absolute(316)), subitems: [hgroup1,hgroup2])
        containerGroup.interItemSpacing = spacing
        return section(containerGroup, edge: .init(top: 18, leading: 20, bottom: 0, trailing: 20))
    }
    class func compositional_horizontal(gWidth: NSCollectionLayoutDimension, gHeight: NSCollectionLayoutDimension, count: Int) -> NSCollectionLayoutSection{
        let spacing : NSCollectionLayoutSpacing = .fixed(18)
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(128), heightDimension: .absolute(148)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: gWidth, heightDimension: gHeight), subitem: item , count: count )
        group.interItemSpacing = spacing
        return section(group, edge: .init(top: 25, leading: 20, bottom: 46, trailing: 20))
    }
    class func compositional_vertical(gWidth: NSCollectionLayoutDimension , gHeight: NSCollectionLayoutDimension , count: Int) -> NSCollectionLayoutSection{
        let spacing : NSCollectionLayoutSpacing = .fixed(18)
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(128), heightDimension: .absolute(148)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: gWidth, heightDimension: gHeight), subitem: item , count: count )
        group.interItemSpacing = spacing
        return section(group, edge: .init(top: 25, leading: 20, bottom: 46, trailing: 20))
    }
    class func section(_ group : NSCollectionLayoutGroup, edge : NSDirectionalEdgeInsets) -> NSCollectionLayoutSection{
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(.init(edge))
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        section.decorationItems = [backgroundItem]
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
   
}
