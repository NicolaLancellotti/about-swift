//: [Previous](@previous)
//: # Concurrency
/*:
 ## Async/Await
 
 An asynchronous function is a special kind of function that can be suspended while it's partway through execution.
 
 You write `await` in front of the call to mark the possible suspension point.
 */
func asyncFunc(_ x: Int) async throws -> Int {
  x + 1
}

func asyncFunc2() async throws -> Int {
  let  _ = try await asyncFunc(1)
  
  // An await operand may contain more than one potential suspension point
  let _ = try await asyncFunc(asyncFunc(1))
  
  // Async Closures
  let _ = { () async throws -> Int in
    try await asyncFunc(1)
  }
  
  // Implicitly Async Closure
  let _ = {
    try await asyncFunc(1)
  }
  
  // Calling Asynchronous Functions in Parallel
  // An async let that was declared but never awaited on explicitly, will be
  // cancelled and awaited on implicitly.
  async let first = asyncFunc(1)
  async let second = asyncFunc(2)
  return try await first + second
}
//: ## Async Sequences
struct Counter : AsyncSequence {
  let howHigh: Int
  
  typealias Element = Int
  
  func makeAsyncIterator() -> AsyncIterator {
    return AsyncIterator(howHigh: howHigh)
  }
  
  struct AsyncIterator : AsyncIteratorProtocol {
    let howHigh: Int
    var current = 1
    
    mutating func next() async -> Int? {
      guard current <= howHigh else {
        return nil
      }
      
      let result = current
      current += 1
      return result
    }
  }
}

func asyncSequence() async {
  let counter = Counter(howHigh: 3)
  let _ = await counter.max()
  
  for await _ in counter {
    
  }
}
/*:
 ## Actors
 - note:
 Actors are Reference Types
 
 Actors allow only one task to access their mutable state at a time, which makes
 it safe for code in multiple tasks to interact with the same instance of an
 actor.
 
 Swift guarantees that only code inside an actor can access the actor’s local
 state. This guarantee is known as actor isolation.
 
 All actor types implicitly conform to a the protocol `Actor`.
 */
actor AnActor {
  init() {}
  
  func actorIsolatedFunc() {}
  
  func actorIsolatedFunc1() {
    // Synchronous actor functions can be called synchronously on the actor's
    // self, but cross-actor references require an asynchronous call.
    actorIsolatedFunc()
  }
  
  var actorIsolatedVar: Int = 0
  
  let constant = 1
  
  // Non-isolated declarations
  nonisolated let nonIsolatedLet: Int = 0
  
  nonisolated func nonIsolatedFunc() { }
  
  // async functions that are not actor-isolated should formally run on a
  // generic executor associated with no actor.
  nonisolated func nonIsolatedAsyncFunc() async { }
}

func actors() async {
  let actor = AnActor()
  
  await actor.actorIsolatedFunc()
  
  // Actor-isolated properties are read-only
  let _ = await actor.actorIsolatedVar
  // await actor.actorIsolatedVar = 1 // Error
  
  let _ = actor.constant
  // Outside the module you have to use await.
  // This preserves the ability for the module that defines AnActor to evolve
  // the let into a var
  // let _ = await actor.constant
  
  // Non-isolated declarations
  let _ = actor.nonIsolatedLet
  actor.nonIsolatedFunc()
  await actor.nonIsolatedAsyncFunc()
}
/*:
 ### Actor-isolated parameters
 A function can become actor-isolated by indicating that one of its parameters
 is isolated.
 
 A given function cannot have multiple isolated parameters.
 */
func actorIsolatedFunc(actor: isolated AnActor, actor2:  AnActor) async {
  actor.actorIsolatedFunc()
  await actor2.actorIsolatedFunc()
}
/*:
 ### Global actors
 
 Any declaration can state that it is actor-isolated to that particular global
 actor by naming the global actor type as an attribute
 */
@globalActor
public struct AGlobalActor {
  public actor MyActor {}
  public static let shared = MyActor()
}

@AGlobalActor
class AnActorIsolatedClass {
  var value: Int = 0
  
  func function() {
    value = 1
  }
}
//: Top-level global variables are implicitly assigned a `@MainActor`
var globalVariable: Int = 0
/*:
 ## Sendable
 
 You can safely pass values of a sendable type from one concurrency domain to
 another.
 
 To declare conformance to Sendable without any compiler enforcement, write
 `@unchecked Sendable`.
 
 ### Sendable Structures and Enumerations
 To satisfy the requirements of the Sendable protocol, an enumeration or
 structure must have only sendable members and associated values.
 
 Implicitly conform to Sendable:
 - Frozen structures and enumerations
 - Structures and enumerations that aren’t `public` and aren’t marked
 `@usableFromInline`
 
 ### Sendable Actors
 Actors implicitly conform to Sendable.
 
 ### Sendable Classes
 To satisfy the requirements of the Sendable protocol, a class must:
 - Be marked final
 - Contain only stored properties that are immutable and sendable
 - Have no superclass or have NSObject as the superclass
 
 Classes marked with `@MainActor` are implicitly sendable.
 
 ### Tuples
 Tuples, whose elements are sendable, implicitly conform to the Sendable protocol.
 
 ### Metatypes
 Metatypes such as `Int.Type` implicitly conform to the Sendable protocol.
 
 ### Key path literals
 Key paths themselves conform to the Sendable protocol. However, to ensure that
 it is safe to share key paths, key path literals can only capture values of
 types that conform to the Sendable protocol. This affects uses of subscripts in
 key paths.
 
 ### Sendable Functions and Closures
 Any values that the function or closure captures must be sendable.
 
 Sendable closures must use only by-value captures, and the
 captured values must be of a sendable type.
 Captures of immutable values introduced by let are implicitly by-value; any
 other capture must be specified via a capture list.
 
 You mark sendable functions and closures with the `@Sendable` attribute.
 
 In a context that expects a sendable closure, a closure that satisfies the
 requirements implicitly conforms to `Sendable`.
 
 A closure formed within an actor-isolated context is
 - actor-isolated if it is non-@Sendable (it cannot escape the concurrency domain)
 - non-isolated if it is @Sendable
 */
let letString: String = ""
var varString: String = ""

let pointer = UnsafeMutablePointer<Int>.allocate(capacity: 1);
pointer.pointee = 10;

class AClass: Hashable, Equatable {
  var value: Int = 0
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
  static func ==(lhs: AClass, rhs: AClass) -> Bool {
    lhs.value == rhs.value
  }
}
let aClass = AClass()

let sendableClosure =  { @Sendable [varString] in
  let _ = letString
  let _ = varString
  
  // Errors
  // let _ = pointer
  // let _ = \Dictionary<AClass, Int>[aClass]
}
/*:
 ## Structured concurrency
 A task is a unit of work that can be run asynchronously as part of your program.
 
 All asynchronous code runs as part of some task.
 
 Tasks are arranged in a hierarchy. Each task in a task group has the same
 parent task, and each task can have child tasks.
 
 By the time the scope exits, the child task must either have completed, or it
 will be implicitly awaited. When the scope exits via a thrown error, the child
 task will be implicitly cancelled before it is awaited.
 
 The async-let syntax creates a child task.
 */
let list = [1, 2, 3]

let result = try await withThrowingTaskGroup(of: Int.self) { group in
  for value in list {
    group.addTask { value * 10 }
  }
  
  var sum = 0;
  for try await value in group {
    sum += value
  }
  return sum
}
/*:
 ### DiscardingTaskGroup
 - `[Throwing]DiscardingTaskGroup` automatically cleans up its child `Task`s when those `Task`s complete.
 - `[Throwing]DiscardingTaskGroup` do not have a `next()` method, nor do they conform to `AsyncSequence`.
 
 A failure of a single child task, immediately causes cancellation of the group and its siblings.
 */
await withDiscardingTaskGroup { group in
  
}
/*:
 ## Unstructured Concurrency
 
 An unstructured task doesn’t have a parent task.
 
 Tasks run to completion even if there are no remaining uses of their task handle.
 */
/*:
 ### Unstructured tasks
 
 It inherits priority, task-local values, and the actor context.
 */
do {
  let handle = Task {
    10
  }
  let result = await handle.value
}
/*:
 ### Detached tasks
 
 It does not inherit priority, task-local values, or the actor context.
 */
do {
  let handle = Task.detached {
    10
  }
  let result = await handle.value
}

/*:
 ## Task Cancellation
 
 Cancellation propagates recursively through the task hierarchy from parent to
 child tasks.
 */
do {
  let handle = Task {
    // throws a CancellationError if the task was canceled
    try Task.checkCancellation()
    
    if Task.isCancelled {
      throw CancellationError()
    }
  }
  
  // Propagate cancellation
  handle.cancel()
}
/*:
 ### Cancellation handlers
 
 The cancellation handler is always and immediately invoked when the task is
 canceled
 */
func cancellationHandler() async {
  await withTaskCancellationHandler {
    
  } onCancel: {
    
  }
}
//: ## Suspending Execution
func SuspendingFunc() async throws {
  await Task.yield()
  
  // It will throw CancellationError if the task is cancelled while it sleeps,
  // without waiting for the full sleep duration.
  try await Task.sleep(for: .seconds(3))
  try await Task.sleep(until: .now + .seconds(3), clock: .continuous)
}

/*:
 ## withUnsafeCurrentTask
 
 Calls a closure with an unsafe reference to the current task.
 */
withUnsafeCurrentTask { unsafeCurrentTask in
  
}
//: ## Task Local Values
func taskLocals() async {
  enum TaskLocals {
    @TaskLocal
    static var value: Int = 0
  }
  
  func asyncFunc() async -> Int {
    TaskLocals.value
  }
  
  func syncFunc() -> Int {
    TaskLocals.value
  }
  
  await TaskLocals.$value.withValue(1) {
    assert(syncFunc() == 1)
    let value = await asyncFunc()
    assert(TaskLocals.value == 1)
    
    await TaskLocals.$value.withValue(2) {
      assert(syncFunc() == 2)
      let value = await asyncFunc()
      assert(value == 2)
    }
  }
  
  assert(syncFunc() == 0)
  let value = await asyncFunc()
  assert(value == 0)
}
/*:
 ## Asynchronous Main
 
 Semantically, Swift will create a new task that will execute main(). Once that
 task completes, the program terminates.
 ```
 @main
 struct Main {
  static func main() async throws { }
 }
 ```
 */
/*:
 ## Continuations
 
 - `withCheckedContinuation`
 - `withCheckedThrowingContinuation`
 - `withUnsafeContinuation`
 - `withUnsafeThrowingContinuation`
 */
func continuation() async throws -> Int {
  func funcWithClosure(_ closure: (Result<Int, Error>) -> Void) {
    closure(.success(1))
  }
  
  let value = try await withCheckedThrowingContinuation{ continuation in
    funcWithClosure { value in
      switch value {
      case .success(let v):
        continuation.resume(returning: v)
      case .failure(let e):
        continuation.resume(throwing: e)
      }
    }
  }
  
  return value
}
/*:
 ## AsyncStreams
 
 - `AsyncStream`
 - `AsyncThrowingStream`
 */
func asyncStream() async {
  final class Stream: Sendable {
    func start() {}
    func stop() {}
    private let handler: @Sendable (Int) -> Void
    
    init(handler: @escaping @Sendable (Int) -> Void) {
      self.handler = handler
    }
  }
  
  let asyncStream = AsyncStream(Int.self) { continuation in
    let stream = Stream() {
      continuation.yield($0)
    }
    
    continuation.onTermination = {  _ in stream.stop() }
    
    stream.start()
  }
  
  for await _ in asyncStream {
    
  }
}
/*:
 ## Unavailable From Async Attribute
 
 Verifying that unavailable functions are not used from asynchronous contexts is
 done weakly; only unavailable functions called directly from asynchronous
 contexts are diagnosed.
 
 For example, API that uses thread-local storage isn't safe for consumption by
 asynchronous functions in general, but is safe for functions on the MainActor
 since it will only use the main thread.
 */
@available(*, noasync, renamed: "readIDFromMainActor()",
            message: "use readIDFromMainActor instead")
func readIDFromThreadLocal() -> Int { 0 }

@MainActor
func readIDFromMainActor() -> Int { readIDFromThreadLocal() }
/*:
 ## Distributed Actors
 
 A distributed actor is used to represent an actor which may be either local or
 remote.
 
 Location transparency: property of hiding away information about the location
 of the actual instance.
 
 Distributed actors implicitly conform to the `DistributedActor` protocol.
 
 `Distributed methods` can be called on "remote" references of distributed actors,
 turning those invocations into remote procedure calls.
 All parameter types and return type of such methods must be or conform to
 the `SerializationRequirement` type.
 
 All distributed actors are explicitly part of some specific distributed actor
 system.
 Libraries aiming to implement distributed actor systems, and act as the runtime
 for distributed actors must implement the `DistributedActorSystem`.
 */
import Distributed

// It is possible to declare a module default actor system type
typealias DefaultDistributedActorSystem = LocalTestingDistributedActorSystem

distributed actor ADistributedActor: Identifiable {
  typealias ActorSystem = LocalTestingDistributedActorSystem
  
  // Stored properties cannot be declared distributed nor nonisolated
  var storedProperty: Int
  
  init(value: Int, actorSystem: ActorSystem) {
    self.actorSystem = actorSystem
    
    // Injected
    // self.id = actorSystem.assignID(Self.self)
    
    self.storedProperty = value
    
    // Injected
    // system.actorReady(self)
  }
  
  deinit {
    // Injected
    // self.actorSystem.resignID(self.id)
  }
  
  distributed func distributedFunc() -> Int {
    return storedProperty
  }
  
  // Computed properties can only be distributed if they are get-only
  distributed var computedProperty: Int {
    0
  }
}

func distributedActors(actor: ADistributedActor) async throws {
  // Stored properties are not accessible across distributed actors
  // actor.value // Error
  
  // Remote calls are implicitly throwing and async,
  // to account for the potential networking involved
  let _ = try await actor.distributedFunc()
  
  // Executes the passed body only when the distributed actor is a local instance
  await actor.whenLocal { isolatedActor in
    let _ = isolatedActor.storedProperty
  }
}
//: ### Creating a local actor
let actorSystem = LocalTestingDistributedActorSystem()
let localActor = ADistributedActor(value: 1, actorSystem: actorSystem)
let id = localActor.id
//: ### Resolving a potentially remote actor
let potentiallyRemoteActor = try ADistributedActor.resolve(id: id,
                                                           using: actorSystem)
//: [Next](@next)
