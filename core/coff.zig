const std = @import("std");
const Section = @import("core/section").SectionHeader;
const Memory = @import("utils/memory");

pub const CoffHeader = packed struct {
    Machine: u16,
    NumberOfSections: u16,
    TimeDateStamp: u32,
    PointerToSymbolTable: u32,
    NumberOfSymbols: u32,
    SizeOfOptionalHeader: u16,
    Characteristics: u16,
};

pub fn readCoffHeader(file: *std.fs.File) !CoffHeader {
    var header: CoffHeader = undefined;
    try file.read(&header);
    return header;
}

pub fn loadSections(file: *std.fs.File, header: CoffHeader) ![]Section {
    const allocator = std.heap.page_allocator;
    const num_sections = header.NumberOfSections;
    const sections = try allocator.alloc(Section, num_sections);
    const size_of_section = @sizeOf(Section);
    const total_size_to_read = size_of_section * num_sections;
    const bytes_read = try file.read(sections);
    if (bytes_read != total_size_to_read) {
        return error.InvalidRead;
    }
    return sections;
}

pub fn executeEntryPoint(baseAddr: *u8, sections: []Section) void {
    const entryAddress = baseAddr + sections[0].VirtualAddress;
    std.debug.print("Base Address: {}\n", .{baseAddr});
    std.debug.print("Entry Address: {}\n", .{entryAddress});
    const entry = @ptrCast(fn () void, entryAddress);
    entry();
}
