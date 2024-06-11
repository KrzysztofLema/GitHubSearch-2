//
//  SettingsView.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 11/06/2024.
//

import UIKit

final class SettingsView: BasicView {
    
    private let settingsTableView = UITableView(frame: .zero, style: .grouped)
    private let viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        
        super.init()
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    override func addSubviews() {
        addSubview(settingsTableView)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
        
        settingsTableView.estimatedRowHeight = 44.0
        settingsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func setupConstraints() {
        settingsTableView.edgesToSuperview()
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.models[indexPath.section].settingsOption[indexPath.row].didSelect?()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight
    }
}

extension SettingsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.models[section].settingsOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        let section = viewModel.models[indexPath.section]
        let settingsOption = section.settingsOption[indexPath.row]
        
        cell.configure(with: settingsOption)
        
        return cell
    }
}
