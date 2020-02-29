//
// In ACPI Patch:
// SMRD to XMRD:
// Find:    534D5244 04
// Replace: 584D5244 04
//
// SMWR to XMWR:
// Find:    534D5752 04
// Replace: 584D5752 04
//
// GBIF to XBIF:
// Find:    47424946 01
// Replace: 58424946 01
//
// GBCO to XBCO:
// Find:    4742434F 08
// Replace: 5842434F 08
//
// ADJT to XDJT:
// Find:    41444A54 08A043
// Replace: 58444A54 08A043
//
// CLRI to XLRI:
// Find:    434C5249 08
// Replace: 584C5249 08
//
// UPBI to XPBI:
// Find:    55504249 00
// Replace: 58504249 00
//
// UPBS to XPBS:
// Find:    55504253 00
// Replace: 58504253 00
//
DefinitionBlock ("", "SSDT", 2, "OCLT", "BAT0", 0)
{
    External (_SB.BAT0, DeviceObj)
    External (_SB.WMID, DeviceObj)
    External (_SB.BAT0._STA, MethodObj)
    External (_SB.LID0._LID, MethodObj)
    External (_SB.BAT0.FABL, IntObj)
    External (_SB.BAT0.PBIF, PkgObj)
    External (_SB.BAT0.PBST, PkgObj)
    External (_SB.BAT0.UPUM, MethodObj)
    External (_SB.BAT0.XPBI, MethodObj)
    External (_SB.BAT0.XPBS, MethodObj)
    External (_SB.GBFE, MethodObj)
    External (_SB.ITOS, MethodObj)
    External (_SB.PBFE, MethodObj)
    External (_SB.PCI0.ACEL, DeviceObj)
    External (_SB.PCI0.ACEL.XLRI, MethodObj)
    External (_SB_.PCI0.ACEL._STA, MethodObj)
    External (_SB.PCI0.LPCB.EC0, DeviceObj)
    External (_SB.PCI0.LPCB.EC0.ACCC, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.BACR, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.BCNT, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.BDVO, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.BTVD, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.BVHB, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.BVLB, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.ECOK, IntObj)
    External (_SB_.PCI0.ACEL.CNST, IntObj)
    External (_SB.PCI0.LPCB.EC0.MBDC, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.MBST, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.MBTS, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.MUT0, MutexObj)
    External (_SB.PCI0.LPCB.EC0.MUT1, MutexObj)
    External (_SB.PCI0.LPCB.EC0.SHPM, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.SMAD, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.SMB0, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.SMCM, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.SMPR, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.SMST, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.STRM, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.STSP, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.SW2S, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.PLGS, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0.XMRD, MethodObj)
    External (_SB.PCI0.LPCB.EC0.XMWR, MethodObj)
    External (_SB.PCI0.ACEL.XDJT, MethodObj)
    External (_SB.WMID.XBCO, MethodObj)
    External (_SB.WMID.XBIF, MethodObj)
    External (BRTM, FieldUnitObj)
    External (SMA4, FieldUnitObj)
    External (PWRS, FieldUnitObj)

    Method (B1B2, 2, NotSerialized)
	{
		Return ((Arg0 | (Arg1 << 0x08)))
	}

	Method (RE1B, 1, NotSerialized)
	{
		OperationRegion (ERM2, EmbeddedControl, Arg0, One)
		Field (ERM2, ByteAcc, NoLock, Preserve)
		{
			BYTE,   8
		}

		Return (BYTE)
	}

	Method (RECB, 2, Serialized)
	{
		Arg1 = ((Arg1 + 0x07) >> 0x03)
		Name (TEMP, Buffer (Arg1){})
		Arg1 += Arg0
		Local0 = Zero
		While ((Arg0 < Arg1))
		{
			TEMP [Local0] = RE1B (Arg0)
			Arg0++
			Local0++
		}

		Return (TEMP)
	}

	Method (WE1B, 2, NotSerialized)
	{
		OperationRegion (ERM2, EmbeddedControl, Arg0, One)
		Field (ERM2, ByteAcc, NoLock, Preserve)
		{
			BYTE,   8
		}

		BYTE = Arg1
	}

	Method (WECB, 3, Serialized)
	{
		Arg1 = ((Arg1 + 0x07) >> 0x03)
		Name (TEMP, Buffer (Arg1){})
		TEMP = Arg2
		Arg1 += Arg0
		Local0 = Zero
		While ((Arg0 < Arg1))
		{
			WE1B (Arg0, DerefOf (TEMP [Local0]))
			Arg0++
			Local0++
		}
	}

    Scope (_SB.PCI0.LPCB.EC0)
    {
        OperationRegion (ERM2, EmbeddedControl, Zero, 0xFF)
        Field (ERM2, ByteAcc, Lock, Preserve)
        {
            //SMD0,   256, WECB (0x04, 256)
            Offset (0x70), 
            ADC0,8,ADC1,8, //BADC,   16, 
            FCC0,8,FCC1,8, //BFCC,   16, 
            Offset (0x82), 
            ,   8, 
            CUR0,8,CUR1,8, //MCUR,   16, 
            BRM0,8,BRM1,8, //MBRM,   16, 
            BCV0,8,BCV1,8  //MBCV,   16, 
        }

        Field (ERM2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            MW00,8,MW01,8  //SMW0,   16
        }
        
        Field (ERM2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            //FLD1,   128  RECB (0x04, 128)
        }
        
        Field (ERM2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            //FLD2,   192  RECB (0x04, 192)
        }

        Field (ERM2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            //FLD3,   256  RECB (0x04, 256)
        }

        Method (SMRD, 4, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (!ECOK)
                {
                    Return (0xFF)
                }

                If ((Arg0 != 0x07))
                {
                    If ((Arg0 != 0x09))
                    {
                        If ((Arg0 != 0x0B))
                        {
                            If ((Arg0 != 0x47))
                            {
                                If ((Arg0 != 0xC7))
                                {
                                    Return (0x19)
                                }
                            }
                        }
                    }
                }

                Acquire (MUT0, 0xFFFF)
                Local0 = 0x04
                While ((Local0 > One))
                {
                    SMST &= 0x40
                    SMCM = Arg2
                    SMAD = Arg1
                    SMPR = Arg0
                    Local3 = Zero
                    While (!Local1 = (SMST & 0xBF))
                    {
                        Sleep (0x02)
                        Local3++
                        If ((Local3 == 0x32))
                        {
                            SMST &= 0x40
                            SMCM = Arg2
                            SMAD = Arg1
                            SMPR = Arg0
                            Local3 = Zero
                        }
                    }

                    If ((Local1 == 0x80))
                    {
                        Local0 = Zero
                    }
                    Else
                    {
                        Local0--
                    }
                }

                If (Local0)
                {
                    Local0 = (Local1 & 0x1F)
                }
                Else
                {
                    If ((Arg0 == 0x07))
                    {
                        Arg3 = SMB0
                    }

                    If ((Arg0 == 0x47))
                    {
                        Arg3 = SMB0
                    }

                    If ((Arg0 == 0xC7))
                    {
                        Arg3 = SMB0
                    }

                    If ((Arg0 == 0x09))
                    {
                        Arg3 = B1B2 (MW00, MW01)
                    }

                    If ((Arg0 == 0x0B))
                    {
                        Local3 = BCNT
                        Local2 = 0x20
                        If ((Local3 > Local2))
                        {
                            Local3 = Local2
                        }

                        If ((Local3 < 0x11))
                        {
                            Local2 = RECB (0x04, 128)
                        }
                        ElseIf ((Local3 < 0x19))
                        {
                            Local2 = RECB (0x04, 192)
                        }
                        Else
                        {
                            Local2 = RECB (0x04, 256)
                        }

                        Local3++
                        Local4 = Buffer (Local3){}
                        Local3--
                        Local5 = Zero
                        Name (OEMS, Buffer (0x46){})
                        ToBuffer (Local2, OEMS)
                        While ((Local3 > Local5))
                        {
                            GBFE (OEMS, Local5, RefOf (Local6))
                            PBFE (Local4, Local5, Local6)
                            Local5++
                        }

                        PBFE (Local4, Local5, Zero)
                        Arg3 = Local4
                    }
                }

                Release (MUT0)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XMRD (Arg0, Arg1, Arg2, Arg3))
            }
        }

        Method (SMWR, 4, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (!ECOK)
                {
                    Return (0xFF)
                }

                If ((Arg0 != 0x06))
                {
                    If ((Arg0 != 0x08))
                    {
                        If ((Arg0 != 0x0A))
                        {
                            If ((Arg0 != 0x46))
                            {
                                If ((Arg0 != 0xC6))
                                {
                                    Return (0x19)
                                }
                            }
                        }
                    }
                }

                Acquire (MUT0, 0xFFFF)
                Local0 = 0x04
                While ((Local0 > One))
                {
                    If ((Arg0 == 0x06))
                    {
                        SMB0 = Arg3
                    }

                    If ((Arg0 == 0x46))
                    {
                        SMB0 = Arg3
                    }

                    If ((Arg0 == 0xC6))
                    {
                        SMB0 = Arg3
                    }

                    If ((Arg0 == 0x08))
                    {
                        B1B2 (MW00, MW01) = Arg3
                    }

                    If ((Arg0 == 0x0A))
                    {
                        WECB (0x04, 256, Arg3)
                    }

                    SMST &= 0x40
                    SMCM = Arg2
                    SMAD = Arg1
                    SMPR = Arg0
                    Local3 = Zero
                    While (!Local1 = (SMST & 0xBF))
                    {
                        Sleep (0x02)
                        Local3++
                        If ((Local3 == 0x32))
                        {
                            SMST &= 0x40
                            SMCM = Arg2
                            SMAD = Arg1
                            SMPR = Arg0
                            Local3 = Zero
                        }
                    }

                    If ((Local1 == 0x80))
                    {
                        Local0 = Zero
                    }
                    Else
                    {
                        Local0--
                    }
                }

                If (Local0)
                {
                    Local0 = (Local1 & 0x1F)
                }

                Release (MUT0)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XMWR (Arg0, Arg1, Arg2, Arg3))
            }
        }
    }

    Scope (_SB.WMID)
    {
        Method (GBIF, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Debug = "HP WMI Command 0x7 (BIOS Read)"
                Acquire (^^PCI0.LPCB.EC0.MUT1, 0xFFFF)
                If (!^^PCI0.LPCB.EC0.ECOK)
                {
                    Local0 = Package (0x02)
                        {
                            0x0D, 
                            Zero
                        }
                    Sleep (0x96)
                    Release (^^PCI0.LPCB.EC0.MUT1)
                    Return (Local0)
                }

                If (Arg0)
                {
                    Local0 = Package (0x02)
                        {
                            0x06, 
                            Zero
                        }
                    Sleep (0x96)
                    Release (^^PCI0.LPCB.EC0.MUT1)
                    Return (Local0)
                }

                If (!^^PCI0.LPCB.EC0.MBTS)
                {
                    Local0 = Package (0x02)
                        {
                            0x34, 
                            Zero
                        }
                    Sleep (0x96)
                    Release (^^PCI0.LPCB.EC0.MUT1)
                    Return (Local0)
                }

                If ((^^PCI0.LPCB.EC0.BTVD != One))
                {
                    Local0 = Package (0x02)
                        {
                            0x37, 
                            Zero
                        }
                    Sleep (0x96)
                    Release (^^PCI0.LPCB.EC0.MUT1)
                    Return (Local0)
                }
                ElseIf (((^^PCI0.LPCB.EC0.MBDC & 0x10) == 0x10))
                {
                    Local0 = Package (0x02)
                        {
                            0x36, 
                            Zero
                        }
                    Sleep (0x96)
                    Release (^^PCI0.LPCB.EC0.MUT1)
                    Return (Local0)
                }

                Local0 = Package (0x03)
                    {
                        Zero, 
                        0x80, 
                        Buffer (0x80){}
                    }
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x18, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [One])
                DerefOf (Local0 [0x02]) [Zero] = Local2
                Local1 = B1B2 (^^PCI0.LPCB.EC0.FCC0, ^^PCI0.LPCB.EC0.FCC1)
                Local1 >>= 0x05
                Local1 <<= 0x05
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x03])
                DerefOf (Local0 [0x02]) [0x02] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x0F, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x05])
                DerefOf (Local0 [0x02]) [0x04] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x0C, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x07])
                DerefOf (Local0 [0x02]) [0x06] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x17, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x09])
                DerefOf (Local0 [0x02]) [0x08] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x08, RefOf (Local1))
                Local1 -= 0x0AAA
                Divide (Local1, 0x0A, Local2, Local1)
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x0B])
                DerefOf (Local0 [0x02]) [0x0A] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x09, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x0D])
                DerefOf (Local0 [0x02]) [0x0C] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x0A, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x0F])
                DerefOf (Local0 [0x02]) [0x0E] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x19, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x11])
                DerefOf (Local0 [0x02]) [0x10] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x16, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x13])
                DerefOf (Local0 [0x02]) [0x12] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x3F, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x15])
                DerefOf (Local0 [0x02]) [0x14] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x3E, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x17])
                DerefOf (Local0 [0x02]) [0x16] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x3D, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x19])
                DerefOf (Local0 [0x02]) [0x18] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x3C, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x1B])
                DerefOf (Local0 [0x02]) [0x1A] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x1C, RefOf (Local1))
                Local3 = ITOS (ToBCD (Local1))
                Local2 = 0x1C
                Local4 = Zero
                Local1 = SizeOf (Local3)
                While (Local1)
                {
                    GBFE (Local3, Local4, RefOf (Local5))
                    PBFE (DerefOf (Local0 [0x02]), Local2, Local5)
                    Local1--
                    Local2++
                    Local4++
                }

                DerefOf (Local0 [0x02]) [Local2] = 0x20
                Local2++
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x1B, RefOf (Local1))
                Local7 = (Local1 & 0x1F)
                Local6 = ITOS (ToBCD (Local7))
                Local7 = (Local1 & 0x01E0)
                Local7 >>= 0x05
                Local5 = ITOS (ToBCD (Local7))
                Local7 = (Local1 >> 0x09)
                Local7 += 0x07BC
                Local4 = ITOS (ToBCD (Local7))
                Local1 = 0x02
                Local7 = 0x03
                While (Local1)
                {
                    GBFE (Local5, Local7, RefOf (Local3))
                    PBFE (DerefOf (Local0 [0x02]), Local2, Local3)
                    Local1--
                    Local2++
                    Local7++
                }

                DerefOf (Local0 [0x02]) [Local2] = "/"
                Local2++
                Local1 = 0x02
                Local7 = 0x03
                While (Local1)
                {
                    GBFE (Local6, Local7, RefOf (Local3))
                    PBFE (DerefOf (Local0 [0x02]), Local2, Local3)
                    Local1--
                    Local2++
                    Local7++
                }

                DerefOf (Local0 [0x02]) [Local2] = "/"
                Local2++
                Local1 = 0x04
                Local7 = One
                While (Local1)
                {
                    GBFE (Local4, Local7, RefOf (Local3))
                    PBFE (DerefOf (Local0 [0x02]), Local2, Local3)
                    Local1--
                    Local2++
                    Local7++
                }

                DerefOf (Local0 [0x02]) [Local2] = Zero
                ^^PCI0.LPCB.EC0.SMRD (0x0B, 0x16, 0x20, RefOf (Local1))
                Local3 = SizeOf (Local1)
                Local2 = 0x2C
                Local4 = Zero
                While (Local3)
                {
                    GBFE (Local1, Local4, RefOf (Local5))
                    PBFE (DerefOf (Local0 [0x02]), Local2, Local5)
                    Local3--
                    Local2++
                    Local4++
                }

                ^^PCI0.LPCB.EC0.SMRD (0x0B, 0x16, 0x70, RefOf (Local1))
                GBFE (Local1, Zero, RefOf (Local5))
                If ((Local5 == 0x36))
                {
                    Local3 = SizeOf (Local1)
                    Local2 = 0x3E
                    Local4 = Zero
                }
                Else
                {
                    Local3 = 0x03
                    Local2 = 0x3E
                    Local4 = Zero
                    Local1 = Buffer (0x04)
                        {
                            "N/A"
                        }
                }

                While (Local3)
                {
                    GBFE (Local1, Local4, RefOf (Local5))
                    PBFE (DerefOf (Local0 [0x02]), Local2, Local5)
                    Local3--
                    Local2++
                    Local4++
                }

                ^^PCI0.LPCB.EC0.SMRD (0x0B, 0x16, 0x21, RefOf (Local1))
                Local3 = SizeOf (Local1)
                Local2 = 0x4F
                Local4 = Zero
                While (Local3)
                {
                    GBFE (Local1, Local4, RefOf (Local5))
                    PBFE (DerefOf (Local0 [0x02]), Local2, Local5)
                    Local3--
                    Local2++
                    Local4++
                }

                ^^PCI0.LPCB.EC0.SMRD (0x0B, 0x16, 0x22, RefOf (Local1))
                Local3 = SizeOf (Local1)
                Local2 = 0x56
                Local4 = Zero
                While (Local3)
                {
                    GBFE (Local1, Local4, RefOf (Local5))
                    PBFE (DerefOf (Local0 [0x02]), Local2, Local5)
                    Local3--
                    Local2++
                    Local4++
                }

                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, Zero, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x5B])
                DerefOf (Local0 [0x02]) [0x5A] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x1B, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x5D])
                DerefOf (Local0 [0x02]) [0x5C] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x14, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x5F])
                DerefOf (Local0 [0x02]) [0x5E] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x15, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x61])
                DerefOf (Local0 [0x02]) [0x60] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x0B, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x63])
                DerefOf (Local0 [0x02]) [0x62] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x11, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x65])
                DerefOf (Local0 [0x02]) [0x64] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x12, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x67])
                DerefOf (Local0 [0x02]) [0x66] = Local2
                ^^PCI0.LPCB.EC0.SMRD (0x09, 0x16, 0x13, RefOf (Local1))
                Divide (Local1, 0x0100, Local2, DerefOf (Local0 [0x02]) [0x69])
                DerefOf (Local0 [0x02]) [0x68] = Local2
                DerefOf (Local0 [0x02]) [0x6A] = One
                Sleep (0x96)
                Release (^^PCI0.LPCB.EC0.MUT1)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.WMID.XBIF (Arg0))
            }
        }

        Method (GBCO, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Debug = "HP WMI Command 0x2B (BIOS Read)"
                Local0 = Package (0x03)
                    {
                        Zero, 
                        0x04, 
                        Buffer (0x04){}
                    }
                If ((^^PCI0.LPCB.EC0.ECOK == One))
                {
                    If (^^PCI0.LPCB.EC0.MBTS)
                    {
                        If (^^PCI0.LPCB.EC0.BTVD)
                        {
                            If (^^PCI0.LPCB.EC0.ACCC)
                            {
                                Local2 = ^^PCI0.LPCB.EC0.MBST
                                Local2 &= 0x03
                                Switch (Local2)
                                {
                                    Case (Zero)
                                    {
                                        Local1 = ^^PCI0.LPCB.EC0.BDVO
                                        If ((Local1 == 0xC5))
                                        {
                                            Local1 = 0x04
                                        }
                                        Else
                                        {
                                            Local1 = Zero
                                        }
                                    }
                                    Case (One)
                                    {
                                        Local1 = 0x02
                                    }
                                    Case (0x02)
                                    {
                                        Local2 = B1B2 (^^PCI0.LPCB.EC0.CUR0, ^^PCI0.LPCB.EC0.CUR1)
                                        Local3 = 0xC3
                                        If (((Local2 <= 0x0200) & (^^PCI0.LPCB.EC0.BDVO == Local3)))
                                        {
                                            Local1 = 0x03
                                        }
                                        Else
                                        {
                                            Local1 = One
                                        }
                                    }
                                    Default
                                    {
                                        DerefOf (Local0 [Zero]) [Zero] = 0x37
                                    }

                                }
                            }
                            Else
                            {
                                Local1 = 0x02
                            }
                        }
                        Else
                        {
                            DerefOf (Local0 [Zero]) [Zero] = 0x37
                        }
                    }
                    Else
                    {
                        Local1 = 0xFF
                    }

                    If ((^^PCI0.LPCB.EC0.STRM == One))
                    {
                        Local1 = 0x06
                    }
                    ElseIf ((^^PCI0.LPCB.EC0.SHPM == One))
                    {
                        Local1 = 0x05
                    }

                    DerefOf (Local0 [0x02]) [Zero] = Local1
                    DerefOf (Local0 [0x02]) [One] = 0xFF
                    DerefOf (Local0 [0x02]) [0x02] = ^^PCI0.LPCB.EC0.STSP
                }
                Else
                {
                    DerefOf (Local0 [Zero]) [Zero] = 0x35
                }

                Return (Local0)
            }
            Else
            {
                Return (\_SB.WMID.XBCO ())
            }
        }
    }

    Scope (_SB.PCI0.ACEL)
    {
        Method (CLRI, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Local0 = Zero
                If ((^^LPCB.EC0.ECOK == One))
                {
                    If ((^^LPCB.EC0.SW2S == Zero))
                    {
                        If ((^^^BAT0._STA () == 0x1F))
                        {
                            If ((B1B2 (^^LPCB.EC0.BRM0, ^^LPCB.EC0.BRM1) <= 0x96))
                            {
                                Local0 = One
                            }
                        }
                    }
                }

                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.ACEL.XLRI ())
            }
        }
        
        Method (ADJT, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (_STA ())
                {
                    If ((^^LPCB.EC0.ECOK == One))
                    {
                        Local0 = ^^LPCB.EC0.SW2S
                    }
                    Else
                    {
                        Local0 = PWRS
                    }

                    If (((^^^LID0._LID () == Zero) && (Local0 == Zero)))
                    {
                        If ((CNST != One))
                        {
                            CNST = One
                            Sleep (0x0BB8)
                            ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x36, 0x14)
                            ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x37, 0x10)
                            ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x34, 0x2A)
                            ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x24, Zero)
                            ^^LPCB.EC0.PLGS = Zero
                            ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x22, 0x20)
                        }
                    }
                    ElseIf ((CNST != Zero))
                    {
                        CNST = Zero
                        ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x36, One)
                        ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x37, 0x50)
                        ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x34, 0x7F)
                        ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x24, 0x02)
                        ^^LPCB.EC0.PLGS = One
                        ^^LPCB.EC0.SMWR (0xC6, 0x50, 0x22, 0x40)
                    }
                }
            }
            Else
            {
                \_SB.PCI0.ACEL.XDJT ()
            }
        }
    }

    Scope (_SB.BAT0)
    {
        Method (UPBI, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Local5 = B1B2 (^^PCI0.LPCB.EC0.FCC0, ^^PCI0.LPCB.EC0.FCC1)
                If ((Local5 && !(Local5 & 0x8000)))
                {
                    Local5 >>= 0x05
                    Local5 <<= 0x05
                    PBIF [One] = Local5
                    PBIF [0x02] = Local5
                    Local2 = (Local5 / 0x64)
                    Local2 += One
                    If ((B1B2 (^^PCI0.LPCB.EC0.ADC0, ^^PCI0.LPCB.EC0.ADC1) < 0x0C80))
                    {
                        Local4 = (Local2 * 0x0E)
                        PBIF [0x05] = (Local4 + 0x02)
                        Local4 = (Local2 * 0x09)
                        PBIF [0x06] = (Local4 + 0x02)
                        Local4 = (Local2 * 0x0B)
                    }
                    ElseIf ((SMA4 == One))
                    {
                        Local4 = (Local2 * 0x0C)
                        PBIF [0x05] = (Local4 + 0x02)
                        Local4 = (Local2 * 0x07)
                        PBIF [0x06] = (Local4 + 0x02)
                        Local4 = (Local2 * 0x0A)
                    }
                    Else
                    {
                        Local4 = (Local2 * 0x0C)
                        PBIF [0x05] = (Local4 + 0x02)
                        Local4 = (Local2 * 0x07)
                        PBIF [0x06] = (Local4 + 0x02)
                        Local4 = (Local2 * 0x0A)
                    }

                    FABL = (Local4 + 0x02)
                }

                Local0 = ^^PCI0.LPCB.EC0.BVLB
                Local1 = ^^PCI0.LPCB.EC0.BVHB
                Local1 <<= 0x08
                Local0 |= Local1
                PBIF [0x04] = Local0
                Sleep (0x32)
                PBIF [0x0B] = "LION"
                PBIF [0x09] = "Primary"
                UPUM ()
                PBIF [Zero] = One
            }
            Else
            {
                \_SB.BAT0.XPBI ()
            }
        }

        Method (UPBS, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If ((BRTM == One))
                {
                    Local0 = B1B2 (^^PCI0.LPCB.EC0.CUR0, ^^PCI0.LPCB.EC0.CUR1)
                    If ((Local0 & 0x8000))
                    {
                        If ((Local0 == 0xFFFF))
                        {
                            PBST [One] = 0xFFFFFFFF
                        }
                        Else
                        {
                            Local1 = ~Local0
                            Local1++
                            Local3 = (Local1 & 0xFFFF)
                            PBST [One] = Local3
                        }
                    }
                    Else
                    {
                        PBST [One] = Local0
                    }
                }
                Else
                {
                    PBST [One] = 0xFFFFFFFF
                }

                Local5 = B1B2 (^^PCI0.LPCB.EC0.BRM0, ^^PCI0.LPCB.EC0.BRM1)
                If (!(Local5 & 0x8000))
                {
                    Local5 >>= 0x05
                    Local5 <<= 0x05
                    If ((Local5 != DerefOf (PBST [0x02])))
                    {
                        PBST [0x02] = Local5
                    }
                }

                If ((!^^PCI0.LPCB.EC0.SW2S && (^^PCI0.LPCB.EC0.BACR == One)))
                {
                    PBST [0x02] = FABL
                }

                PBST [0x03] = B1B2 (^^PCI0.LPCB.EC0.BCV0, ^^PCI0.LPCB.EC0.BCV1)
                PBST [Zero] = ^^PCI0.LPCB.EC0.MBST
            }
            Else
            {
                \_SB.BAT0.XPBS ()
            }
        }
    }
}

