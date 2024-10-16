//: [Previous](@previous)
//: # Concurrency
/*:
 ## Utils
 */
class NonSendableClass: Hashable, Equatable {
  var value: Int = 0
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
  static func ==(lhs: NonSendableClass, rhs: NonSendableClass) -> Bool {
    lhs.value == rhs.value
  }
}

final class SendableClass: Sendable {
  let value: Int = 0
  func method() {}
}
/*:
 ## Async/await
 
 An asynchronous function is a special kind of function that can be suspended
 while it's partway through execution.
 
 You write `await` in front of the call to mark the possible suspension point.
 */
func asyncFunction1(_ x: Int) async throws -> Int {
  x + 1
}

func asyncFunction2() async throws -> Int {
  let  _ = try await asyncFunction1(1)
  
  // An await operand may contain more than one potential suspension point
  let _ = try await asyncFunction1(asyncFunction1(1))
  
  // Async Closures
  let _ = { () async throws -> Int in
    try await asyncFunction1(1)
  }
  
  // Implicitly Async Closure
  let _ = {
    try await asyncFunction1(1)
  }
  
  // Calling Asynchronous Functions in Parallel
  // An async let that was declared but never awaited on explicitly, will be
  // cancelled and awaited on implicitly.
  async let x = asyncFunction1(1)
  async let y = asyncFunction1(2)
  return try await x + y
}
//: ## Async sequences
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
      guard current <= howHigh else { return nil }
      defer { current += 1 }
      return current
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
actor MyActor {
  init(value: Int) {
    self.actorIsolatedProperty = value
  }
  
  // Delegating Initializer
  init() {
    self.init(value: 0)
  }
  
  func actorIsolatedMethod1() {}
  
  func actorIsolatedMethod2() {
    // Synchronous actor functions can be called synchronously on the actor's
    // self, but cross-actor references require an asynchronous call.
    actorIsolatedMethod1()
  }
  
  var actorIsolatedProperty: Int
  
  let constant = 1
  
  // Non-isolated declarations
  nonisolated let nonIsolatedLetProperty: Int = 0
  
  nonisolated func nonIsolatedMethod() { }
  
  // async functions that are not actor-isolated should formally run on a
  // generic executor associated with no actor.
  nonisolated func nonIsolatedAsyncMethod() async { }
}

func actors() async {
  let actor = MyActor()
  
  await actor.actorIsolatedMethod1()
  
  // Actor-isolated properties are read-only
  let _ = await actor.actorIsolatedProperty
  // await actor.actorIsolatedVar = 1 // Error
  
  let _ = actor.constant
  // Outside the module you have to use await.
  // This preserves the ability for the module that defines AnActor to evolve
  // the let into a var
  // let _ = await actor.constant
  
  // Non-isolated declarations
  let _ = actor.nonIsolatedLetProperty
  actor.nonIsolatedMethod()
  await actor.nonIsolatedAsyncMethod()
}
/*:
 ### Actor-isolated parameters
 A function can become actor-isolated by indicating that one of its parameters
 is isolated.
 
 A given function cannot have multiple isolated parameters.
 */
func actorIsolatedFunction(actor: isolated MyActor, actor2:  MyActor) async {
  actor.actorIsolatedMethod1()
  await actor2.actorIsolatedMethod1()
}
/*:
 ### Inheritance of actor isolation for async functions
 */
func inheritedActorIsolation(
  isolation actor: isolated (any Actor)? =  #isolation,
  instance: NonSendableClass) async {
    instance.value += 1
  }

extension MyActor {
  func foo() async {
    let nonSendable = NonSendableClass()
    await inheritedActorIsolation(instance: nonSendable)
    // same as:
    await inheritedActorIsolation(isolation: self,
                                  instance: nonSendable)
    
    // Error
    // await inheritedActorIsolation(isolation: nil  /* nonisolated */,
    //                               instance: nonSendable)
    
  }
}
/*:
 ### Global actors
 
 - Any declaration can state that it is actor-isolated to that particular global
 actor by naming the global actor type as an attribute.
 - Stored properties of `Sendable` type in a global-actor-isolated value type
 are treated as `nonisolated` when used within the module that defines the
 property.
 - A global-actor-isolated subclass of a non-isolated, non-Sendable class is
 allowed, but it must be non-Sendable.
 */
@globalActor
public struct MyGlobalActor {
  public actor ActorImpl {}
  public static let shared = ActorImpl()
}

@MyGlobalActor
class MyGlobalActorIsolatedClass {
  var value: Int = 0
  
  func method() {
    value = 1
  }
}
/*:
 ### @isolated(any) function types
 A function value with this type dynamically carries the isolation of the
 function that was used to initialize it.
 */
func functionWithIsolatedAny(_ operation: @isolated(any) () -> ()) async {
  let _: (any Actor)? = operation.isolation
  await operation()
}
await functionWithIsolatedAny {  }
/*:
 ### Non-delegating initializers
 - **An initializer**
    - has a nonisolated self reference if it is:
        - non-async
        - or global-actor isolated
        - or nonisolated
    - has an isolated self reference if it is:
        - an asynchronous actor initializer
 - **Actors**
    - *Initializers with isolated self*
        - An implicitly hop to the actor's executor will be performed
 immediately after self becomes fully-initialized.
    - *Initializers with nonisolated self*
        - Accesses to the stored properties of self is required to bootstrap an
 instance of an actor.
        - Such accesses are considered to be a weaker form of isolation that
 relies on having exclusive access to the reference self.
        - The isolation of self decays to nonisolated during any use of self
 that is not a direct stored-property access.
- **Global-actor isolated types**
  - *Isolated initializers*
     - No data races because they gain actor-isolation prior to calling the
 initializer itself.
  - *Non-isolated initializers*
      - The isolation of self decays to nonisolated during any use of self that
 is not a direct stored-property access.
 ### Deinitializers
  - The isolation of self decays to nonisolated during any use of self that is
 not a direct stored-property access.
  - deinit can only access the stored properties of self that are Sendable.
 */
/*:
 ## Sendable
 
 You can safely pass values of a sendable type from one concurrency domain to
 another.
 
 To declare conformance to `Sendable` without any compiler enforcement, write
 `@unchecked Sendable`.
 
 ### Sendable structures and enumerations
 To satisfy the requirements of the `Sendable` protocol, an enumeration or
 structure must have only sendable members and associated values.
 
 Implicitly conform to `Sendable`:
 - Frozen structures and enumerations
 - Structures and enumerations that aren’t `public` and aren’t marked
 `@usableFromInline`
 
 ### Sendable actors
 Actors implicitly conform to `Sendable`.
 
 ### Sendable classes
 To satisfy the requirements of the `Sendable` protocol, a class must:
 - be marked final,
 - contain only stored properties that are immutable and sendable,
 - have no superclass or have NSObject as the superclass.
 
 Classes marked with `@MainActor` are implicitly sendable.
 
 ### Tuples
 Tuples, whose elements are sendable, implicitly conform to the `Sendable`
 protocol.
 
 ### Metatypes
 Metatypes such as `Int.Type` implicitly conform to the `Sendable` protocol.
 
 ### Sendable functions and closures
 Any values that the function or closure captures must be sendable.
 
 Sendable closures must use only by-value captures, and the
 captured values must be of a sendable type.
 Captures of immutable values introduced by let are implicitly by-value; any
 other capture must be specified via a capture list.
 
 You mark sendable functions and closures with the `@Sendable` attribute.
 
 In a context that expects a sendable closure, a closure that satisfies the
 requirements implicitly conforms to `Sendable`.
 
 A closure formed within an actor-isolated context is
 - actor-isolated if it is non-sendable (it cannot escape the concurrency
 domain),
 - non-isolated if it is @Sendable.
 
 *Global functions* and *global-actor-isolated functions and closures*
 implicitly conform to the `Sendable` protocol.

 *Global-actor-isolated closures* are allowed to capture non-Sendable values
 despite being `@Sendable`.
 
 ### Sendable methods
 Implicitly conform to `Sendable`:
 - unapplied references to methods of a Sendable type,
 - partially-applied methods of a Sendable type.
 */
func sendable() {
  let letString: String = ""
  var varString: String = ""
  
  let sendableInstance = SendableClass()
  let nonSendableInstance = NonSendableClass()
  
  let unappliedMethod = SendableClass.method
  let partiallyAppliedMethod = sendableInstance.method
  
  let sendableKeyPath = \SendableClass.value // KeyPath<SendableClass, Int> & Sendable
  let nonsendableKeyPath1: KeyPath<SendableClass, Int> = \SendableClass.value
  let nonsendableKeyPath2 = \Dictionary<NonSendableClass, Int>[nonSendableInstance]
  
  let pointer = UnsafeMutablePointer<Int>.allocate(capacity: 1);
  pointer.pointee = 10;
  
  let sendableClosure =  { @Sendable [varString] in
    let _ = letString
    let _ = varString
    let _ = sendableInstance
    let _ = unappliedMethod
    let _ = partiallyAppliedMethod
    let _ = sendableKeyPath
    
    // Errors
    //    let _ = nonsendableKeyPath1
    //    let _ = nonsendableKeyPath2
    //    let _ = pointer
  }
}
/*:
 ### Region based Isolation
 Through the usage of isolation regions, the compiler can now prove that
 sending a value that does not conform to the Sendable protocol over an
 isolation boundary cannot result in races because the value (and any other
 value that might reference it) is not used in the caller after the point of
 sending.
 */
extension MyActor {
  func takeNonSendable(_ x: NonSendableClass) {  }
}

func regionBasedIsolation() async {
  let x = NonSendableClass()
  await MyActor().takeNonSendable(x)
}
/*:
 - A `sending` function parameter requires that the argument value be in a
 disconnected region.
 At the point of the call, the disconnected region is no longer in the caller's
 isolation domain, allowing the callee to send the parameter value to a region
 that is opaque to the caller.
 - A `sending` result requires that the function implementation returns a value
 in a disconnected region.
 */
func sending(x: sending NonSendableClass,
             y: sending NonSendableClass) async -> sending NonSendableClass {
  await MyActor().takeNonSendable(x)
  return y
}
/*:
 ## Global and static variables
 Global and Static Variables must either be
 - isolated to a global actor, or
 - immutable and of `Sendable` type.
 
 Top-level global variables are implicitly assigned a `@MainActor`.
 */
/*:
 ## nonisolated(unsafe)
 - The `nonisolated(unsafe)` modifier can be used to annotate  any form of
 storage to suppress data isolation violations when manual synchronization is
 provided.
 - It can be used as a more granular opt out for `Sendable` checking,
 eliminating the need for `@unchecked Sendable`.
 */
nonisolated(unsafe) var nonisolatedUnsafeGlobal: Int = 0
/*:
 ## Isolated default value expressions
 Default value expressions have the same isolation as the enclosing function or
 the corresponding stored property.
 */
@MainActor func requiresMainActor() -> Int { 0 }

@MainActor func useDefault(value: Int = requiresMainActor()) { }

@MainActor func mainActorCaller() {
  useDefault() // okay
}

func nonisolatedCaller() async {
  await useDefault() // call is implicitly async
}
/*:
 ## Structured concurrency
 A task is a unit of work that can be run asynchronously as part of your
 program.
 
 All asynchronous code runs as part of some task.
 
 Tasks are arranged in a hierarchy. Each task in a task group has the same
 parent task, and each task can have child tasks.
 
 By the time the scope exits, the child task must either have completed, or it
 will be implicitly awaited. When the scope exits via a thrown error, the child
 task will be implicitly cancelled before it is awaited.
 
 The async-let syntax creates a child task.
 */
let array = [1, 2, 3]

let result = try await withThrowingTaskGroup(of: Int.self) { group in
  for value in array {
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
 - `[Throwing]DiscardingTaskGroup` automatically cleans up its child `Task`s
 when those `Task`s complete.
 - `[Throwing]DiscardingTaskGroup`s do not have a `next()` method, nor do they
 conform to `AsyncSequence`.
 
 A failure of a single child task, immediately causes cancellation of the group
 and its siblings.
 */
await withDiscardingTaskGroup { group in
  
}
/*:
 ## Unstructured concurrency
 
 An unstructured task doesn’t have a parent task and does not inherit the task
 executor preference.
 
 Tasks run to completion even if there are no remaining uses of their task
 handle.
 */
/*:
 ### Unstructured tasks
 
 An unstructured task inherits priority, task-local values, and the actor
 context.
 */
do {
  let handle = Task {
    10
  }
  let result = await handle.value
}
/*:
 ### Detached tasks
 
 A detached task is an unstructured task that does not inherit priority,
 task-local values, or the actor
 context.
 */
do {
  let handle = Task.detached {
    10
  }
  let result = await handle.value
}

/*:
 ## Task cancellation
 
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
//: ## Suspending execution
func SuspendingExectution() async throws {
  await Task.yield()
  
  // It will throw CancellationError if the task is cancelled while it sleeps,
  // without waiting for the full sleep duration.
  try await Task.sleep(for: .seconds(3))
  try await Task.sleep(until: .now + .seconds(3), clock: .continuous)
}

//: ## Task local values
func taskLocalValues() async {
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
    assert(value == 1)
    assert(TaskLocals.value == 1)
    
    await TaskLocals.$value.withValue(2) {
      assert(syncFunc() == 2)
      let value = await asyncFunc()
      assert(value == 2)
      assert(TaskLocals.value == 2)
    }
  }
  
  assert(syncFunc() == 0)
  let value = await asyncFunc()
}
await taskLocalValues()
/*:
 ## withUnsafeCurrentTask
 
 Calls a closure with an unsafe reference to the current task.
 */
withUnsafeCurrentTask { unsafeCurrentTask in
  guard let unsafeCurrentTask else { return }
  unsafeCurrentTask.unownedTaskExecutor
}
/*:
 ## Asynchronous main
 
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
  func functionWithClosure(_ closure: (Result<Int, Error>) -> Void) {
    closure(.success(1))
  }
  
  let value = try await withCheckedThrowingContinuation{ continuation in
    functionWithClosure { value in
      switch value {
      case .success(let value): continuation.resume(returning: value)
      case .failure(let error): continuation.resume(throwing: error)
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
  final class EventGenerator: Sendable {
    func start() {}
    func stop() {}
    private let handler: @Sendable (Int) -> Void
    
    init(handler: @escaping @Sendable (Int) -> Void) {
      self.handler = handler
    }
  }
  
  do {
    let stream = AsyncStream(Int.self) { continuation in
      let generator = EventGenerator() { continuation.yield($0) }
      continuation.onTermination = {  _ in generator.stop() }
      generator.start()
    }
    for await _ in stream { }
  }
  
  do {
    let (stream, continuation) = AsyncStream.makeStream(of: Int.self)
    let generator = EventGenerator { continuation.yield($0) }
    continuation.onTermination = {  _ in generator.stop() }
    generator.start()
    for await _ in stream { }
  }
}
/*:
 ## Unavailable from async attribute
 For example, API that uses thread-local storage isn't safe for consumption by
 asynchronous functions in general, but is safe for functions on the MainActor
 since it will only use the main thread.
 */
/*:
 - note:
 Verifying that unavailable functions are not used from asynchronous contexts is
 done weakly; only unavailable functions called directly from asynchronous
 contexts are diagnosed.
 */
@available(*, noasync, renamed: "readIDFromMainActor()",
            message: "use readIDFromMainActor instead")
func readIDFromThreadLocal() -> Int { 0 }

@MainActor
func readIDFromMainActor() -> Int { readIDFromThreadLocal() }
/*:
 ## Distributed actors
 
 A distributed actor is used to represent an actor which may be either local or
 remote.
 
 Location transparency: property of hiding away information about the location
 of the actual instance.
 
 Distributed actors implicitly conform to the `DistributedActor` protocol.
 
 Distributed methods can be called on "remote" references of distributed
 actors, turning those invocations into remote procedure calls.
 All parameter types and return type of such methods must be or conform to
 the `SerializationRequirement` type.
 
 All distributed actors are explicitly part of some specific distributed actor
 system.
 Libraries aiming to implement distributed actor systems, and act as the runtime
 for distributed actors must implement the `DistributedActorSystem`.
 */
import Distributed

// MARK: - API

@Resolvable
protocol MyDistributedActorProtocol: DistributedActor
    where ActorSystem: DistributedActorSystem<any Codable> {
  distributed func distributedMethod() -> Int
}

// MARK: - Server

distributed actor MyDistributedActor<ActorSystem>: MyDistributedActorProtocol
    where ActorSystem: DistributedActorSystem<any Codable> {
  
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
  
  distributed func distributedMethod() -> Int { storedProperty }
  
  // Computed properties can only be distributed if they are get-only
  distributed var computedProperty: Int { 0 }
}

// MARK: - Distributed Actor System

typealias MyDistributedActorSystem = LocalTestingDistributedActorSystem
let actorSystem = MyDistributedActorSystem()

// MARK: - Local Actor

func localActor() async throws {
  let actor = MyDistributedActor(value: 1, actorSystem: actorSystem)
  _ = actor.id
  
  // Remote calls are implicitly throwing and async,
  // to account for the potential networking involved
  let _ = try await actor.distributedMethod()
  let _ = try await actor.computedProperty
  
  // Stored properties are not accessible across distributed actors
  // actor.storedProperty // Error
  
  // Executes the passed body only when the distributed actor is a local instance
  await actor.whenLocal { isolatedActor in
    let _ = isolatedActor.storedProperty
    let _ : any Actor = isolatedActor.asLocalActor
  }
}

// MARK: - Potentially Remote Actors

func resolveUsingAConcreteActor(id: MyDistributedActorSystem.ActorID) async throws {
  let actor = try MyDistributedActor.resolve(id: id, using: actorSystem)
  let _ = try await actor.distributedMethod()
}

func resolveUsingResolvable(id: MyDistributedActorSystem.ActorID) async throws {
  let actor = try $MyDistributedActorProtocol.resolve(id: id, using: actorSystem)
  let _ = try await actor.distributedMethod()
}
/*:
 ## Custom executors
 */
import Dispatch

final class MySerialExecutor: SerialExecutor, TaskExecutor {
  let queue: DispatchSerialQueue = .init(label: "MySerialExecutorQueue")
  
  func enqueue(_ job: consuming ExecutorJob) {
    let job = UnownedJob(job)
    queue.async {
      job.runSynchronously(isolatedTo: self.asUnownedSerialExecutor(),
                           taskExecutor: self.asUnownedTaskExecutor())
    }
  }
  
  public func checkIsolated() {
    dispatchPrecondition(condition: .onQueue(queue))
  }
  
  //  Default Implementation:
  //  func asUnownedSerialExecutor() -> UnownedSerialExecutor {
  //    UnownedSerialExecutor(ordinary: self)
  //  }
}
/*:
 ### Custom actor executors
 */
actor MyActorWithCustomExecutor {
  nonisolated let unownedExecutor: UnownedSerialExecutor
  
  init(unownedExecutor: UnownedSerialExecutor) {
    self.unownedExecutor = unownedExecutor
  }
}

do {
  let serialExecutor = MySerialExecutor()
  let actor = MyActorWithCustomExecutor(unownedExecutor: serialExecutor.asUnownedSerialExecutor())

  serialExecutor.queue.sync {
    actor.assertIsolated() // calls checkIsolated()
  }
}

do {
  let dispatchSerialQueue: DispatchSerialQueue = .init(label: "dispatchSerialQueue")
  let actor = MyActorWithCustomExecutor(unownedExecutor: dispatchSerialQueue.asUnownedSerialExecutor())
}

do {
  let actor = MyActorWithCustomExecutor(unownedExecutor: MainActor.sharedUnownedExecutor)
}
/*:
 ### Task executor preference
 - Task executors, unlike serial executors, are explicitly owned by tasks as long
 as they are running on the given task executor.
 - Structured tasks inherit the task executor preference.
 - Unstructured tasks do not inherit the task executor preference.
 
 `func` execution semantics:
 ```
 switch is isolated {
 case true:
  switch actor has unownedExecutor {
  case true: on specified executor
  case false:
    switch task has executor preference {
    case true: on Task's preferred executor
    case false: on default (actor) executor
    }
  }
 case false:
  switch task has executor preference {
  case true: on Task's preferred executor
  case false: on global concurrent executor
  }
 }
 ```
 */
func specifyTaskExecutorPreference(taskExecutor: any TaskExecutor) async {
  await withTaskExecutorPreference(taskExecutor) {
    
  }
  
  // Structured concurrency
  await withThrowingTaskGroup(of: Void.self) { group in
    group.addTask(executorPreference: taskExecutor) {}
  }
  
  // Unstructured concurrency
  Task(executorPreference: taskExecutor) {}
  Task.detached(executorPreference: taskExecutor) {}
}
await specifyTaskExecutorPreference(taskExecutor: MySerialExecutor())
await specifyTaskExecutorPreference(taskExecutor: globalConcurrentExecutor)
//: [Next](@next)
