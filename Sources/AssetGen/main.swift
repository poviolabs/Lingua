import Foundation

let processorFactory = ProcessorFactory()
let processors: [CommandLineProcessable] = [
  processorFactory.makeLocalizationProcessor()
]

Task {
  for processor in processors {
    try? await processor.process(arguments: CommandLine.arguments)
  }
  exit(0)
}

RunLoop.main.run(until: Date.distantFuture)
