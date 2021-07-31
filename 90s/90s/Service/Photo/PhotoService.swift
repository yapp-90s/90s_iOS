//
//  PhotoService.swift
//  90s
//
//  Created by 김진우 on 2021/01/23.
//

import RxSwift
import Moya

final class PhotoService {
    static let shared = PhotoService()
    
    let provider = MoyaProvider<PhotoAPI>()
    
    private init() { }
    
    func upload(photo data: PhotoAPI.photoData, completionHandler : @escaping (Result<PhotoResponse, Error>) -> Void) {
        provider.request(.upload(data)) { result in
            do {
                let response = try result.get()
                let value = try response.map(PhotoResponse.self)
                completionHandler(.success(value))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func download(photoUid data : PhotoAPI.photoUid, completionHandler : @escaping(Result<Int, Error>) -> Void) {
        provider.request(.download(data)) { result in
            do {
                let response = try result.get()
                let value = try response.map(Int.self)
                completionHandler(.success(value))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func getPhotoInfosByFilm(filmUID data : PhotoAPI.filmUID, completionHandler : @escaping(Result<[PhotoResponse], Error>) -> Void) {
        provider.request(.getPhotoInfosByFilm(data)) { result in
            do {
                let response = try result.get()
                let value = try response.map([PhotoResponse].self)
                completionHandler(.success(value))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func delete(filmUID data : PhotoAPI.filmUID, completionHandler : @escaping(Result<Bool, Error>) -> Void) {
        provider.request(.delete(data)) { result in
            do {
                let response = try result.get()
                let value = try response.map(Bool.self)
                completionHandler(.success(value))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
