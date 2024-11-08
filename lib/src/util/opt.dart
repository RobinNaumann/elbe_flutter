/// Opt is a function that returns a nullable value. This is used to
/// work with optional values in the context of copyWith methods.
/// use the optEval function to evaluate the value.
typedef Opt<T> = T? Function()?;

/// optEval evaluates the function if it is not null, otherwise returns the self value.
/// This is used to work with optional values in the context of copyWith methods.
T? optEval<T>(Opt<T> f, T? self) => f == null ? self : f();
