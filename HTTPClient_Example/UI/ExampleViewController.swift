//
// Copyright (c) 2021 Shakuro (https://shakuro.com/)
// Sergey Laschuk
//

import Alamofire
import HTTPClient_Framework
import UIKit

class ExampleViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    private var request: Request?
    private let client: ExampleHTTPClient = ExampleHTTPClient()

    private var contributors: [ExampleParser.Contributor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadContributorsAsync()
    }

}

extension ExampleViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCellIdentifier", for: indexPath)
        (cell as? ExampleCell)?.setup(title: contributors[indexPath.row].login)
        return cell
    }

}

// MARK: - Private

private extension ExampleViewController {

    private func loadContributors() {
        activityIndicator.startAnimating()
        let requestOptions = HTTPClientRequestOptions(
            endpoint: ExampleAPIEndPoint(path: .contributors),
            method: .get,
            parser: ExampleParser(),
            urlQueryParameters: nil,
            bodyParameters: nil)
        request = client.sendRequest(options: requestOptions, completion: { [weak self] (result) in
            Task(operation: { @MainActor [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.activityIndicator.stopAnimating()
                switch result {
                case .success(let contributors):
                    strongSelf.contributors = contributors
                    strongSelf.tableView.reloadData()
                case .cancelled:
                    break
                case .failure(let error):
                    print(error)
                }
            })
        })
    }

    @MainActor
    private func loadContributorsAsync() {
        activityIndicator.startAnimating()
        let requestOptions = HTTPClientRequestOptions(
            endpoint: ExampleAPIEndPoint(path: .contributors),
            method: .get,
            parser: ExampleParser(),
            urlQueryParameters: nil,
            bodyParameters: nil)
        let httpClient = client
        Task(operation: { @MainActor [weak self] in
            let result = await httpClient.sendRequest(options: requestOptions)
            self?.activityIndicator.stopAnimating()
            switch result {
            case .success(let contributors):
                self?.contributors = contributors
                self?.tableView.reloadData()
            case .cancelled:
                break
            case .failure(let error):
                print(error)
            }
        })
    }

}
