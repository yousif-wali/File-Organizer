const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 2) {
        std.debug.print("Usage: {s} <folder_path>\n", .{args[0]});
        return;
    }

    const folder_path = args[1];
    const cwd = std.fs.cwd();

    // Open the directory
    var dir = try cwd.openDir(folder_path, .{});
    defer dir.close();

    // Iterate over directory entries
    var iterator = dir.iterate();
    while (try iterator.next()) |entry| {
        if (entry.kind != .file) continue;

        const ext = try getFileExtension(entry.name);

        const target_dir_path = try std.fmt.allocPrint(allocator, "{s}/{s}", .{ folder_path, ext });
        defer allocator.free(target_dir_path);

        // Create the directory for the extension if it doesn't exist
        _ = cwd.makeDir(target_dir_path) catch |err| {
            if (err != error.PathAlreadyExists) return err;
        };

        const old_path = try std.fmt.allocPrint(allocator, "{s}/{s}", .{ folder_path, entry.name });
        const new_path = try std.fmt.allocPrint(allocator, "{s}/{s}/{s}", .{ folder_path, ext, entry.name });
        defer allocator.free(old_path);
        defer allocator.free(new_path);

        // Move the file
        try cwd.rename(old_path, new_path);
    }

    std.debug.print("Files organized successfully!\n", .{});
}

// Extract the file extension from a file name
fn getFileExtension(file_name: []const u8) ![]const u8 {
    const dot_index = std.mem.indexOf(u8, file_name, ".");
    if (dot_index == null) {
        return error.InvalidFileName;
    }
    return file_name[dot_index.? + 1 ..];
}
