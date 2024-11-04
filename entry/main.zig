const std = @import("std");
const Coff = @import("core/coff");
const Section = @import("core/section");
const Relocation = @import("core/relocation");
const Logger = @import("utils/logger");
const Memory = @import("utils/memory");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        Logger.log(.ERR, "Usage: COFFLoader <coff_file>");
        return;
    }

    const filename = args[1];
    const file = try std.fs.cwd().openFile(filename, .{ .read = true });
    defer file.close();

    const header = try Coff.readCoffHeader(&file);
    Logger.log(.INF, "COFF header read");

    const baseAddr = try Memory.allocateMemory(0x10000);
    defer Memory.deallocateMemory(baseAddr, 0x10000);

    const sections = try Coff.loadSections(&file, baseAddr, header);
    defer allocator.free(sections);

    for (sections) |section| {
        try Section.loadSectionData(&file, baseAddr, section);
        if (section.NumberOfRelocations > 0) {
            try file.seek(section.PointerToRelocations, .Start);
            const relocations = try allocator.alloc(Relocation.RelocationEntry, section.NumberOfRelocations);
            defer allocator.free(relocations);

            try file.read(relocations);
            try Relocation.applyRelocations(baseAddr, relocations, section.VirtualAddress);
        }
    }

    Logger.log(.SYS, "Executing entry point");
    Coff.executeEntryPoint(baseAddr, sections);
}
