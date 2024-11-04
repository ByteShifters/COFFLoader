const std = @import("std");

pub const SectionHeader = packed struct {
    Name: [8]u8,
    VirtualSize: u32,
    VirtualAddress: u32,
    SizeOfRawData: u32,
    PointerToRawData: u32,
    PointerToRelocations: u32,
    PointerToLinenumbers: u32,
    NumberOfRelocations: u16,
    NumberOfLinenumbers: u16,
    Characteristics: u32,
};

pub fn loadSectionData(file: *std.fs.File, baseAddr: *u8, section: SectionHeader) !void {
    try file.seek(section.PointerToRawData, .Start);
    try file.readBytes(section.SizeOfRawData, baseAddr + section.VirtualAddress);
}
