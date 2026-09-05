// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
/// Formats [dt] as a 24-hour time string with leading zeros.
///
/// Returns time in `HH:mm` format (e.g., `"14:30"` or `"09:05"`).
String formatTime(DateTime dt) =>
    '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';