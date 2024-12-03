import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // Cria o `mapView` e `bottomView`
    let mapView = MKMapView()
    let bottomView = UIView()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupMapView()
        setupBottomView()
        setupLocationManager()
        centerMapOnLocation()
    }
    
    private func setupMapView() {
        // Configura o `mapView`
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)

        mapView.showsUserLocation = true
        mapView.mapType = .standard
        
        // Define as restrições do `mapView` para estar no topo com altura fixa
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupBottomView() {
        // Configura a `bottomView`
        bottomView.backgroundColor = .systemBlue
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        
        // Define as restrições da `bottomView` para preencher o espaço abaixo do `mapView`
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Adiciona bordas nas pontas superiores
        addTopBorders(to: bottomView)
    }
    
    private func addTopBorders(to view: UIView) {
        let borderWidth: CGFloat = 2.0 // Largura da borda
        let borderColor = UIColor.red.cgColor // Cor da borda

        // Borda esquerda
        let leftBorder = CALayer()
        leftBorder.backgroundColor = borderColor
        leftBorder.frame = CGRect(x: 0, y: 0, width: borderWidth, height: 100) // 20 é a altura da borda
        view.layer.addSublayer(leftBorder)

        // Borda direita
        let rightBorder = CALayer()
        rightBorder.backgroundColor = borderColor
        rightBorder.frame = CGRect(x: view.frame.width - borderWidth, y: 0, width: borderWidth, height: 20) // 20 é a altura da borda
        view.layer.addSublayer(rightBorder)
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func centerMapOnLocation() {
        let location = CLLocation(latitude: 37.7749, longitude: -122.4194) // Exemplo: São Francisco
        let regionRadius: CLLocationDistance = 10000

        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Atualiza as bordas após o layout
        updateTopBorders(for: bottomView)
    }

    private func updateTopBorders(for view: UIView) {
        let borderWidth: CGFloat = 2.0
        let leftBorder = view.layer.sublayers?[0] as? CALayer
        let rightBorder = view.layer.sublayers?[1] as? CALayer
        
        leftBorder?.frame = CGRect(x: 0, y: 0, width: borderWidth, height: 20)
        rightBorder?.frame = CGRect(x: view.frame.width - borderWidth, y: 0, width: borderWidth, height: 20)
    }
}
