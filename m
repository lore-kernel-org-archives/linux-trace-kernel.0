Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115E1E1DE7;
	Fri, 11 Jul 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222325; cv=none; b=QNIxLzPyFl+g+9YHFeSo/fmPTU3xzq/NPqsshQaauO83ST9/PBG7vFibD2u5uWK6XQpKE+/BOOPTrBfvVvKsKzqHsMXmiC+Vr9rjEkmYk+GldHQ2phw1fdB60v25dj8UnK+vmVE1DBwgW99VBAp4z0PLaJcN4uQMN265+CBDNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222325; c=relaxed/simple;
	bh=6+5Ha7SJxmyoopp1jzkm2XJfU5Q1cuDgFc7BE6MVAj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOlnTr42HVPYl1ZGWFtvbDE9ZNoIV46gyEpkDfTFqUEFTXtxDb0UKfkEFf+Mkp7kDs88aOiVVqfuN8Y/B5j/hIZmpMwGAVu7jiz9fvt2HufjgIegRmlYrXmEhud18aoFqmVgMOxZdcbFF/HXrb5gTJnKMoKv230gnsbcIBETvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdLvZTZ4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdLvZTZ4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae361e8ec32so325129066b.3;
        Fri, 11 Jul 2025 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752222321; x=1752827121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRoXmte5KjgmHxw5xtEa7W/UEelUJHeebr5yRCTQ5tc=;
        b=QdLvZTZ4ubrg5UYOx9nknmLe3uaKcDNqqPAMTDDa8M8/huVssvoNa6rk4Ag3dfhfD5
         ZK+xkkvExLcWe8CNHf5ruop6OiQDBGnq6zuWTgBMKNPsDV/jj/QdXjk7Ld03Ncosg+SN
         mazqBd8KcHEHnV5jV84Jrf8plUqWm9BdKAwv/QbPM5/jJaEhYNPtd7KA8uSfVa6aNtfO
         G+aNQowbJFrF+FPzpXecz57loNSAoSEd/lcOuM1J0W6WdfRJ3nVul2xlVQc5QE7mIKcT
         XwbjYxi5BNxn7Xus93UWCB8Wk2WTmlVpC01MIexoI+vqcp8W0UQZN9fImd/oe54Z8svN
         86EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752222321; x=1752827121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRoXmte5KjgmHxw5xtEa7W/UEelUJHeebr5yRCTQ5tc=;
        b=szQLG1ZVQBS0sKEzq4Y0cwQx+z72ti6tGpbzYO90stifIzXYQAv/2V2yxFLi5A4U3m
         Ivs/+pYOaBGnzT/WbPlgt3er60Ze6187KLQrxn5X2TUu/PWRUt3AJE4Tmdsc+FF0aSav
         S6StRO+tyzQCNLGkyggDKzCXsHEJ/L2KJI7axE0qm/y/XZxIptojDqHA5xiYCkDa3ORk
         1TqRQHvWcw9xc3ydFvdlnYUO6K9AIVv1VXh/Y4Uc+XFoRUsotWpgFfuuNE/GicDpeHRh
         n8njQG+c5B2dq7OMnZzUkGFr613Au2zwFl+m4UtAUTl+oMbztp5eOCzHLhXIGPgqLOxf
         PZKA==
X-Forwarded-Encrypted: i=1; AJvYcCUShNJ7H46PS3h9Q+S0y02AisO8/BiAqinHUsnjI/Hcx0ZYlI0tkDDAvlKMmst2rCqy71Ca9lTnDD2pezfN+pRh5p67@vger.kernel.org, AJvYcCVT8KiMGH+3PGXkGzLdGBKCwepe5fGjRlXb57C+fbCJDi9dae7byLh3zcilsKn3ZP9Vrk61Fs8R4mxhZ+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcPGiYK1S+yhb9J0C9dazXpFapOyPberePNJmYxUfkd0EnHmyF
	7njhQEm1vmMWywGgT1P37z4htTMasD89Tx5BLOxSlYCRWzGWzBPKx3O2GfVHZcxFWNFAwLmoPw2
	JinrtsdEUDfCMjp+iobVAa30Fvzo/2ME=
X-Gm-Gg: ASbGncud/OpO5Jsvr/vgM2EOa3gbNbUmeOjbyxqdhs9P/d993ByNZ0uEZy8sgFwfhp0
	PQpcLHkxqLjPA5Zijb+78eDJfu1EgNstpucUSmCbev9JZrP/Yr1A9obxI85g2DiO9MCgGMsKkRr
	Yf5JVC6+iGPM+fk6eSMaESV+6ba0Cz/Sau9HydFy7I8zeWug1Ni/hnSm59Ui1XLikBj4DaegUMT
	G2ylMM=
X-Google-Smtp-Source: AGHT+IFJCn2k9ZiPrMNpvm5zigeAos7swIfr+WYbZoJwErVPkTB72leaL2OosKOL08Q75yIJnf2WcPn3dtUCnG+A50Q=
X-Received: by 2002:a17:906:fd86:b0:acb:abff:a5b6 with SMTP id
 a640c23a62f3a-ae7010feb8dmr132425966b.13.1752222320689; Fri, 11 Jul 2025
 01:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aG3A8Jirg+TxNza/@rli9-mobl> <f5b1fc77-d180-4df7-b8f6-0cb0ca4a187a@ghiti.fr>
 <CAKxVwge4=cagaVDesKWe0BE88U0YmNn5LLDJvJG=F7EEP2=-LQ@mail.gmail.com>
 <7204f633-5b35-41ce-b847-7dfbaedbac47@ghiti.fr> <CAKxVwgdoK6wSt-1LNZ8Tn3MPaETR58RThbcdydijrKPbfpE68g@mail.gmail.com>
 <b6dbdcbc-08b5-4de0-9955-cf2b048dbb38@ghiti.fr>
In-Reply-To: <b6dbdcbc-08b5-4de0-9955-cf2b048dbb38@ghiti.fr>
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Fri, 11 Jul 2025 16:24:42 +0800
X-Gm-Features: Ac12FXyvD0R9AsvspaLoVsNWvo-QzhbHa2gjFm3KnJTmZUxfAcQszpX4dP7braM
Message-ID: <CAKxVwgdMBfzfU04WMOALsi7sqPdj1vsv_kt+ZK=32aWASF1XXw@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAMIC_FTRACE selection
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: kernel test robot <lkp@intel.com>, Linux RISCV <linux-riscv@lists.infradead.org>, 
	oe-kbuild-all@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Pu Lehui <pulehui@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I rechecked the .config file. I configured it using

make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu-
CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__ -fmax-errors=3Dunlimited
-fmax-warnings=3Dunlimited' O=3Dbuild_dir olddefconfig,

and obtained the following configuration. If NONPORTABLE is disabled,
the MMU will be enabled. I did not find any other settings that would
affect the enabling of NONPORTABLE=E2=80=94it is set to 'y' by default.


--------- CONFIG ---------------------

config NONPORTABLE
bool "Allow configurations that result in non-portable kernels"

Symbol: HAVE_DYNAMIC_FTRACE [=3Dn]
Type  : bool
Defined at kernel/trace/Kconfig:42
Selected by [n]:
    - RISCV [=3Dy] && !XIP_KERNEL [=3Dn] && MMU [=3Dn] &&
(CLANG_SUPPORTS_DYNAMIC_FTRACE [=3Dn] || GCC_SUPPORTS_DYNAMIC_FTRACE
[=3Dy])

Symbol: MMU [=3Dn]
Type  : bool
Defined at arch/riscv/Kconfig:298
Prompt: MMU-based Paged Memory Management Support
Location:
  (1) -> MMU-based Paged Memory Management Support (MMU [=3Dn])
  Selected by [n]:
      - PORTABLE [=3Dn]

Symbol: PORTABLE [=3Dn]
    Type  : bool
    Defined at arch/riscv/Kconfig:1344
    Selects: EFI [=3Dn] && MMU [=3Dn] && OF [=3Dy]

Symbol: NONPORTABLE [=3Dy]
  =E2=94=82 Type  : bool
  =E2=94=82 Defined at arch/riscv/Kconfig:389
  =E2=94=82   Prompt: Allow configurations that result in non-portable kern=
els
  =E2=94=82   Location:
  =E2=94=82     -> Platform type
  =E2=94=82 (1)   -> Allow configurations that result in non-portable kerne=
ls
(NONPORTABLE [=3Dy])

Thanks,

Chen Miao

Alexandre Ghiti <alex@ghiti.fr> =E4=BA=8E2025=E5=B9=B47=E6=9C=8811=E6=97=A5=
=E5=91=A8=E4=BA=94 15:55=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 7/10/25 17:56, Miao Chen wrote:
> > Hello Alex,
> >
> > I found where the error is, but there's a problem here:
> >
> > config PORTABLE
> >    bool
> >    default !NONPORTABLE
> >    select EFI
> >    select MMU
> >    select OF
> >
> > select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU &&
> > (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
> >
> > Because HAVE_DYNAMIC_FTRACE depends on the MMU=E2=80=94of course, it's
> > reasonable for DYNAMIC_FTRACE to depend on the MMU=E2=80=94*but since
> > NONPORTABLE is enabled by default, this causes PORTABLE to default to
> > n, thereby preventing the MMU from being enabled*. So, should I change
> > NONPORTABLE to default to n?
>
>
> NONPORTABLE is not enabled by default and PORTABLE=3Dn does not prevent
> MMU from being enabled.
>
> IIUC, it seems like you don't have HAVE_DYNAMIC_FTRACE enabled but
> that's probably because of your toolchain, not !MMU, can you check that
> in your .config?
>
> Thanks,
>
> Alex
>
>
> >
> > Thanks,
> >
> > Alex
> >
> > Alexandre Ghiti <alex@ghiti.fr> =E4=BA=8E2025=E5=B9=B47=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=9B=9B 22:33=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 7/10/25 14:34, Miao Chen wrote:
> >>> Hello Alex,
> >>>
> >>> Sure, I'll checkout it. Btw, this is my first commit, so can u tell
> >>> how to reproduce failed case? Using the reproduce and .config.gz give=
d
> >>> by build-bot?
> >>
> >> Yes exactly!
> >>
> >>
> >>> Thanks,
> >>>
> >>> Chen Miao
> >>>
> >>> Alexandre Ghiti <alex@ghiti.fr> =E4=BA=8E2025=E5=B9=B47=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=9B=9B 19:53=E5=86=99=E9=81=93=EF=BC=9A
> >>>> Hi ChenMiao,
> >>>>
> >>>> On 7/9/25 03:08, kernel test robot wrote:
> >>>>> Hi ChenMiao,
> >>>>>
> >>>>> kernel test robot noticed the following build errors:
> >>>>>
> >>>>> [auto build test ERROR on fda589c286040d9ba2d72a0eaf0a13945fc48026]
> >>>>>
> >>>>> url:    https://github.com/intel-lab-lkp/linux/commits/ChenMiao/ris=
cv-ftrace-Fix-the-logic-issue-in-DYNAMIC_FTRACE-selection/20250706-231907
> >>>>> base:   fda589c286040d9ba2d72a0eaf0a13945fc48026
> >>>>> patch link:    https://lore.kernel.org/r/20250706151830.25091-1-che=
nmiao.ku%40gmail.com
> >>>>> patch subject: [PATCH V2] riscv: ftrace: Fix the logic issue in DYN=
AMIC_FTRACE selection
> >>>>> :::::: branch date: 2 days ago
> >>>>> :::::: commit date: 2 days ago
> >>>>> config: riscv-randconfig-r112-20250708 (attached as .config)
> >>>>> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-projec=
t cd708029e0b2869e80abe31ddb175f7c35361f90)
> >>>>> reproduce: (attached as reproduce)
> >>>>>
> >>>>> If you fix the issue in a separate patch/commit (i.e. not just a ne=
w version of
> >>>>> the same patch/commit), kindly add following tags
> >>>>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202507090650.YGY56S=
IA-lkp@intel.com/
> >>>>>
> >>>>> All errors (new ones prefixed by >>):
> >>>>>
> >>>>>>> <instantiation>:1:14: error: operand must be a symbol with %lo/%p=
crel_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
> >>>>>       addi sp, sp, -FREGS_SIZE_ON_STACK
> >>>>>                    ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>>> <instantiation>:2:18: error: unexpected token
> >>>>>        sw t0, FREGS_EPC(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:3:17: error: unexpected token
> >>>>>        sw x1, FREGS_RA(sp)
> >>>>>                       ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:7:17: error: unexpected token
> >>>>>        sw x6, FREGS_T1(sp)
> >>>>>                       ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:9:17: error: unexpected token
> >>>>>        sw x7, FREGS_T2(sp)
> >>>>>                       ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:10:18: error: unexpected token
> >>>>>        sw x28, FREGS_T3(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:11:18: error: unexpected token
> >>>>>        sw x29, FREGS_T4(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:12:18: error: unexpected token
> >>>>>        sw x30, FREGS_T5(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:13:18: error: unexpected token
> >>>>>        sw x31, FREGS_T6(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:16:18: error: unexpected token
> >>>>>        sw x10, FREGS_A0(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:17:18: error: unexpected token
> >>>>>        sw x11, FREGS_A1(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:18:18: error: unexpected token
> >>>>>        sw x12, FREGS_A2(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:19:18: error: unexpected token
> >>>>>        sw x13, FREGS_A3(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:20:18: error: unexpected token
> >>>>>        sw x14, FREGS_A4(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:21:18: error: unexpected token
> >>>>>        sw x15, FREGS_A5(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:22:18: error: unexpected token
> >>>>>        sw x16, FREGS_A6(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:23:18: error: unexpected token
> >>>>>        sw x17, FREGS_A7(sp)
> >>>>>                        ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>        ^
> >>>>>       <instantiation>:25:15: error: operand must be a symbol with %=
lo/%pcrel_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
> >>>>>        addi a0, a0, FREGS_SIZE_ON_STACK
> >>>>>                     ^
> >>>>>       arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro in=
stantiation
> >>>>>        SAVE_ABI_REGS
> >>>>>
> >>>>> Kconfig warnings: (for reference only)
> >>>>>       WARNING: unmet direct dependencies detected for DYNAMIC_FTRAC=
E
> >>>>>       Depends on [n]: FTRACE [=3Dy] && FUNCTION_TRACER [=3Dy] && HA=
VE_DYNAMIC_FTRACE [=3Dn]
> >>>>>       Selected by [y]:
> >>>>>       - RISCV [=3Dy] && FUNCTION_TRACER [=3Dy]
> >>>> To avoid that, we should check HAVE_DYNAMIC_FTRACE too:
> >>>>
> >>>> select DYNAMIC_FTRACE if FUNCTION_TRACER && HAVE_DYNAMIC_FTRACE
> >>>>
> >>>> That fixes the build error for me. Can you send a v3 with this chang=
e?
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Alex
> >>>>
> >>>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
