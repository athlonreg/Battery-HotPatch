//// battery
// In config ACPI, _BIX to XBIX
// Find:     5F42495800
// Replace:  5842495800
//
DefinitionBlock ("", "SSDT", 2, "OCLT", "BAT0", 0)
{
    External (_SB.PCI0.BAT0, DeviceObj)
    External (_SB.PCI0.LPCB.EC0, DeviceObj)
    //
    External (_SB.PCI0.LPCB.EC0.BATP, MethodObj)
    External (_SB.PCI0.LPCB.EC0.GBTT, MethodObj)
    //
    External (_SB.PCI0.BAT0.PBIF, PkgObj)
    External (_SB.PCI0.BAT0.BIXT, PkgObj)
    External (_SB.PCI0.BAT0.NBIX, PkgObj)
    //
    External (_SB.PCI0.BAT0._BIF, MethodObj)
    //
    External (_SB.PCI0.BAT0.XBIX, MethodObj)

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        OperationRegion (ERM2, EmbeddedControl, Zero, 0xFF)
        Field (ERM2, ByteAcc, Lock, Preserve)
        {
            Offset (0xC4), 
            C300,8,C301,8, //B0C3,   16, 
        }
    }
    
    Scope (_SB.PCI0.BAT0)
    {
        Method (_BIX, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (!^^LPCB.EC0.BATP (Zero))
                {
                    Return (NBIX) /* \_SB_.PCI0.BAT0.NBIX */
                }

                If ((^^LPCB.EC0.GBTT (Zero) == 0xFF))
                {
                    Return (NBIX) /* \_SB_.PCI0.BAT0.NBIX */
                }

                _BIF ()
                BIXT [One] = DerefOf (PBIF [Zero])
                BIXT [0x02] = DerefOf (PBIF [One])
                BIXT [0x03] = DerefOf (PBIF [0x02])
                BIXT [0x04] = DerefOf (PBIF [0x03])
                BIXT [0x05] = DerefOf (PBIF [0x04])
                BIXT [0x06] = DerefOf (PBIF [0x05])
                BIXT [0x07] = DerefOf (PBIF [0x06])
                BIXT [0x0E] = DerefOf (PBIF [0x07])
                BIXT [0x0F] = DerefOf (PBIF [0x08])
                BIXT [0x10] = DerefOf (PBIF [0x09])
                BIXT [0x11] = DerefOf (PBIF [0x0A])
                BIXT [0x12] = DerefOf (PBIF [0x0B])
                BIXT [0x13] = DerefOf (PBIF [0x0C])
                If ((DerefOf (BIXT [One]) == One))
                {
                    BIXT [One] = Zero
                    Local0 = DerefOf (BIXT [0x05])
                    BIXT [0x02] = (DerefOf (BIXT [0x02]) * Local0)
                    BIXT [0x03] = (DerefOf (BIXT [0x03]) * Local0)
                    BIXT [0x06] = (DerefOf (BIXT [0x06]) * Local0)
                    BIXT [0x07] = (DerefOf (BIXT [0x07]) * Local0)
                    BIXT [0x0E] = (DerefOf (BIXT [0x0E]) * Local0)
                    BIXT [0x0F] = (DerefOf (BIXT [0x0F]) * Local0)
                    Divide (DerefOf (BIXT [0x02]), 0x03E8, Local0, BIXT [0x02])
                    Divide (DerefOf (BIXT [0x03]), 0x03E8, Local0, BIXT [0x03])
                    Divide (DerefOf (BIXT [0x06]), 0x03E8, Local0, BIXT [0x06])
                    Divide (DerefOf (BIXT [0x07]), 0x03E8, Local0, BIXT [0x07])
                    Divide (DerefOf (BIXT [0x0E]), 0x03E8, Local0, BIXT [0x0E])
                    Divide (DerefOf (BIXT [0x0F]), 0x03E8, Local0, BIXT [0x0F])
                }

                BIXT [0x08] = B1B2 (^^LPCB.EC0.C300, ^^LPCB.EC0.C301) /* \_SB_.PCI0.LPCB.EC0_.B0C3 */
                BIXT [0x09] = 0x0001869F
                Return (BIXT) /* \_SB_.PCI0.BAT0.BIXT */
            }
            Else
            {
                Return (\_SB.PCI0.BAT0.XBIX())
            }
        }
    }
}

