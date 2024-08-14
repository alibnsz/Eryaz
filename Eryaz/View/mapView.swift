//
//  mapView.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 8.08.2024.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var coordinate: CLLocationCoordinate2D

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation {
                let placemark = MKPlacemark(coordinate: annotation.coordinate)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = annotation.title ?? "Eryaz Bilgi Teknolojileri"
                
                let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                mapItem.openInMaps(launchOptions: options)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeAnnotations(view.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Eryaz Bilgi Teknolojileri"
        view.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        view.setRegion(region, animated: true)
    }
}

struct MapsView: View {
    @State private var coordinate = CLLocationCoordinate2D(latitude: 40.97897768646023, longitude: 29.119317953352102)
    var body: some View {
        MapView(coordinate: $coordinate)
            .edgesIgnoringSafeArea(.all)
    }
}

