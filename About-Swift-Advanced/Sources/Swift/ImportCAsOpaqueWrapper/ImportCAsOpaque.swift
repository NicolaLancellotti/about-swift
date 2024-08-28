import ImportCAsOpaque

public class ImportCAsOpaque {
  private let ref: ImportCAsOpaqueRef
  
  public init(value: Int32) {
    ref = ImportCAsOpaqueCreate(value)
  }
  
  public var value: Int32 {
    get {
      ImportCAsOpaqueGetValue(ref)
    }
    set {
      ImportCAsOpaqueSetValue(ref, newValue)
    }
  }
  
  deinit {
    ImportCAsOpaqueRelease(ref)
  }
}
