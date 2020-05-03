/// Base class for type converters which can be applied to:
///
/// 1. databases
/// 1. DAOs
/// 1. entities/views
/// 1. entity/view fields
/// 1. DAO methods
/// 1. DAO method parameters
///
/// The type converter is added to the scope of the element so if you put it
/// on a class, all methods/fields in that class will be able to use the
/// converters.
///
/// A type converter that converts between [DateTime] and the database
/// compatible [int] type can be seen in the following example.
///
/// ```dart
/// // definition
/// class DateTimeConverter extends TypeConverter<DateTime, int> {
///   @override
///   DateTime decode(int databaseValue) {
///     return DateTime.fromMillisecondsSinceEpoch(databaseValue);
///   }
///
///   @override
///   int encode(DateTime value) {
///     return value.millisecondsSinceEpoch;
///   }
/// }
///
/// // usage
/// @TypeConverters([DateTimeConverter])
/// @Database(version: 1, entities: [Order])
/// abstract class OrderDatabase extends FloorDatabase {
///   OrderDao get orderDao;
/// }
///
/// @entity
/// class Order {
///   @primaryKey
///   final int id;
///
///   final DateTime date;
///
///   Order(this.id, this.date);
/// }
/// ```
abstract class TypeConverter<T, S> {
  /// Converts the [databaseValue] of type [S] into [T]
  T decode(S databaseValue);

  /// Converts the [value] of type [T] into the database-compatible type [S]
  S encode(T value);
}
