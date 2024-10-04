//
//  LiveMobileConfigClient.swift
//  MobilePlatform
//
//  Created by Thanh Hai Khong on 4/10/24.
//

import ComposableArchitecture
import FirebaseRemoteConfig

extension MobileConfigClient: DependencyKey {
    public static var liveValue: MobileConfigClient {
        let configurator = Configurator()
        return Self(editorChoices: configurator.getEditorChoices)
    }
}

private actor Configurator {
    private let remoteConfig = RemoteConfig.remoteConfig()
    private var cachedEditorChoices: [EditorChoice]? = nil
    
    public init() {
        remoteConfig.addOnConfigUpdateListener { configUpdate, error in
            guard error == nil else { return }
            RemoteConfig.remoteConfig().activate { changed, error in
                guard error == nil else { return }
                Task {
                    await self.handleConfigUpdate()
                }
            }
        }
    }
    
    // MARK: - Public Methods
    
    public func getEditorChoices() async throws -> [EditorChoice] {
        if let cachedChoices = cachedEditorChoices {
            return cachedChoices
        }
        let fetchedChoices = try await fetchEditorChoices()
        cachedEditorChoices = fetchedChoices
        return fetchedChoices
    }
    
    // MARK: - Helper Functions
    
    private func handleConfigUpdate() async {
        do {
            let updatedChoices = try await fetchEditorChoices()
            cachedEditorChoices = updatedChoices
        } catch {
            print("Failed to update editor choices: \(error)")
        }
    }
    
    private func fetchEditorChoices() async throws -> [EditorChoice] {
        return try await withCheckedThrowingContinuation { continuation in
            remoteConfig.fetchAndActivate { status, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                
                if status == .successFetchedFromRemote {
                    if let editorChoiceJSON = self.remoteConfig.configValue(forKey: "PREF_REMOTE_CONFIG_EDITOR_CHOICES_KEY").jsonValue as? [[String: Any]] {
                        do {
                            let editorChoices = try self.decodeEditorChoices(from: editorChoiceJSON)
                            continuation.resume(returning: editorChoices)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    } else {
                        continuation.resume(returning: [])
                    }
                }
            }
        }
    }
    
    private func decodeEditorChoices(from json: [[String: Any]]) throws -> [EditorChoice] {
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        let editorChoices = try JSONDecoder().decode([EditorChoice].self, from: jsonData)
        return editorChoices
    }
}
