Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FED1DE4F9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183334; cv=none; b=DuRrnwmULraI10FqC5zlT3og3ygFpIKPwpfTfNCGygjdTw8BWLTDLx2GxKtYIWchetud+Jdxzo5jnEJayUOjBtMLLVlikxRlHUJSqH4LR/AsHQDszWLcK1xRHuEzxh55U5bDs6fozRgVoqjkXtYTIIYSxNHF1AGwWpShxRrDSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183334; c=relaxed/simple;
	bh=Z9Fe2+FVxTOtr+1ZWGqM2uQD2DnWR5j0vKz1i55zxnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0FXENEI3NFUXRCqTW8kvRYblXU2+rbLks+ehisbJT6r5sjyO62gCj9T4rAqcQ/1kWH7txMNxxEXaieAhf7f97difNruce7alr2634x+rT5SvjX4/6nk33dTgC+5Vu+KayJqh4UD4C/W689WSjk1mOk6Z0xtvZDtTNB0oa+d0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BYDJTLmY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BYDJTLmY"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so3971384a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743183329; x=1743788129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCOY/OM3xv2Rdy8rOxicNNUSqGLSD2Kt3rZzPoVTCgs=;
        b=BYDJTLmYCMmVQqQcuycIH7fOriXxM32BTbphMTA07yJgy9/o1e8WY7l91+Zr9p7VfF
         uqzIkPN9PvddM9w3+arkaV3xUnZZTEbxavSKAGtlmZ+8zmlOeWTUbeycVWP3A1aoF1Bb
         vH1kEwgL3XH8K5zuSB1rJ8bThyJR4UPWh2D4NzC7FxakyPOwa+L6NEEDQfPpTk8wnGxT
         edafZCtEqwxK8teNzbvTe6mu/46q3MfGwPxoY72Z/nZHuU43cpxE6Bo8BU7eGvO/VbwL
         HTGG/ji9V8Z/hPUc2FqM39TUXI258DdymcT1LyPnCW342d+x/YcLAo3kaAtpdTTq4zF7
         BaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743183329; x=1743788129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCOY/OM3xv2Rdy8rOxicNNUSqGLSD2Kt3rZzPoVTCgs=;
        b=ddfCeZyh0B/X7qCybr7YXQioqUI5EBfmUFFQ8cAYXOWCqZSZJGDDyTxr2sb/SQR9qA
         yxU2+j3GgGqe4H1uAjSyELjgspYzzsEuhjTCv2IDhdp8CnOCr6rZcRMy3VxozHkbr1sy
         68T6lacWXHq0HmbGTIwO/Fsamkg6/mFp314YaFW+41ByMGeBXtGiHV/SXbfg3s01ev9m
         S2KDmjjgiHLEQJi1ONhhRQvo/5wySS3YikrB7fSt9fshJtEh05pcQXrRvaGRgazJ5PDU
         HoyRO0L+jwsHF/AbK+cmkI1o+pL3sa4jqyoNaJPCSF9lRGd92JSTFnP9VdI7e/fAa7+b
         whaw==
X-Forwarded-Encrypted: i=1; AJvYcCVjxe0pGFzCh3mrmJfnpR8RDOElTghM3k8ixq0XivQ74GdEfDsFzrVPy94ADwNjnXdy5LIs5Z7sMIx732XgnN8Wh+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrkbb74ITJz3jh+wWdLmTL7XUqUAFaoqwe3G/5ITjjt/Lr25Iq
	YxYbf0qj+jJ1ZV29fB4YE+TkH96IL+vrdyd2BAUqq3lGcHmEqE3o3Oerl31LU2S+0Q3HYoutnOX
	gw3qvvgk+VVvx7Wx/1OFj3x9GPSLRBVAnkBpLdQ==
X-Gm-Gg: ASbGnct6JXDMAJDxZu4VwSZxjdF18I6vRp0XEs+RVsJTbOo4ompqicbnkM+ECE/J4YW
	dwrBSl+kf3h4hpfNMmXt7ZB3DDsGOHjvPhrpoaeiFvD3r5p7x7lBYQGCjr7652TSckKfwisAO1o
	w7wr7isNSTaxgVTbqXm8RDddZ1mfPILZoQfyrUKSMyljmXJOGvMTNxUFG+IxY=
X-Google-Smtp-Source: AGHT+IEdtZ+nRiNksT1ZK+nI3EizfIqfBPMNuSPKc2pMJ6eYrNml/gOglrN0NRjLhGamyyaNY+9z2umM8g59uSBHDZc=
X-Received: by 2002:a17:907:9693:b0:ac3:45c0:6d08 with SMTP id
 a640c23a62f3a-ac7385b6095mr6897266b.0.1743183329025; Fri, 28 Mar 2025
 10:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-runtime_const_riscv-v10-0-745b31a11d65@rivosinc.com>
 <20250319-runtime_const_riscv-v10-2-745b31a11d65@rivosinc.com> <cc8f3525-20b7-445b-877b-2add28a160a2@gmail.com>
In-Reply-To: <cc8f3525-20b7-445b-877b-2add28a160a2@gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 28 Mar 2025 18:35:17 +0100
X-Gm-Features: AQ5f1JoTd6oWVQeMRN3V-hTS5jlcvyyynZ90Kl6ULD3non1sxEaNj1v0M7jl2uY
Message-ID: <CAHVXubjq901KYw+aRmYoNYUpCks87TB2QAu2U_fcx7Wmh_+9gg@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] riscv: Add runtime constant support
To: Klara Modin <klarasmodin@gmail.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ben Dooks <ben.dooks@codethink.co.uk>, Pasha Bouzarjomehri <pasha@rivosinc.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Klara,

On Fri, Mar 28, 2025 at 4:42=E2=80=AFPM Klara Modin <klarasmodin@gmail.com>=
 wrote:
>
> Hi,
>
> On 3/19/25 19:35, Charlie Jenkins wrote:
> > Implement the runtime constant infrastructure for riscv. Use this
> > infrastructure to generate constants to be used by the d_hash()
> > function.
> >
> > This is the riscv variant of commit 94a2bc0f611c ("arm64: add 'runtime
> > constant' support") and commit e3c92e81711d ("runtime constants: add
> > x86 architecture support").
>
> This patch causes the following build failure for me:
>
> fs/dcache.c: Assembler messages:
> fs/dcache.c:157: Error: attempt to move .org backwards
> fs/dcache.c:157: Error: attempt to move .org backwards
> fs/dcache.c:157: Error: attempt to move .org backwards
> fs/dcache.c:157: Error: attempt to move .org backwards
> fs/dcache.c:157: Error: attempt to move .org backwards
> make[3]: *** [scripts/Makefile.build:203: fs/dcache.o] Error 1
>
> The value of CONFIG_RISCV_ISA_ZBKB doesn't seem to have an impact.
> Reverting the patch on top of next-20250328 resolved the issue for me. I
> attached the generated fs/dcache.s.

Thanks for your report!

Kernel test robot reported the following issue, do you have the same errors=
?

   fs/dcache.c: Assembler messages:
>> fs/dcache.c:143: Warning: Unrecognized .option directive: arch,+zba
--
>> fs/dcache.c:145: Error: unrecognized opcode `add.uw s1,s1,a5'
>> fs/dcache.c:143: Warning: Unrecognized .option directive: arch,+zba
--
>> fs/dcache.c:145: Error: unrecognized opcode `add.uw a4,a4,a5'
>> fs/dcache.c:143: Warning: Unrecognized .option directive: arch,+zba
--
>> fs/dcache.c:145: Error: unrecognized opcode `add.uw s4,s4,a5'
>> fs/dcache.c:143: Warning: Unrecognized .option directive: arch,+zba
--
>> fs/dcache.c:145: Error: unrecognized opcode `add.uw s1,s1,a5'
>> fs/dcache.c:152: Error: attempt to move .org backwards
>> fs/dcache.c:152: Error: attempt to move .org backwards
>> fs/dcache.c:152: Error: attempt to move .org backwards
>> fs/dcache.c:152: Error: attempt to move .org backwards

 If so, I sent a fix, don't hesitate to add your Tested-by:
https://lore.kernel.org/linux-riscv/c0f425ec-6c76-45b2-b1bc-8d9be028a878@ri=
vosinc.com/T/#me1469bfb2e6f69e1422a136014b753a6acaa3bc6

Thanks,

Alex


>
> Please let me know if there's anything else you need.
>
> Regards,
> Klara Modin
>
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >   arch/riscv/Kconfig                     |  22 +++
> >   arch/riscv/include/asm/asm.h           |   1 +
> >   arch/riscv/include/asm/runtime-const.h | 265 ++++++++++++++++++++++++=
+++++++++
> >   arch/riscv/kernel/vmlinux.lds.S        |   3 +
> >   4 files changed, 291 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 7612c52e9b1e35607f1dd4603a596416d3357a71..c123f7c0579c1aca839e3c0=
4bdb662d6856ae765 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -783,6 +783,28 @@ config RISCV_ISA_ZBC
> >
> >          If you don't know what to do here, say Y.
> >
> > +config TOOLCHAIN_HAS_ZBKB
> > +     bool
> > +     default y
> > +     depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zb=
kb)
> > +     depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_z=
bkb)
> > +     depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23900
> > +     depends on AS_HAS_OPTION_ARCH
> > +
> > +config RISCV_ISA_ZBKB
> > +     bool "Zbkb extension support for bit manipulation instructions"
> > +     depends on TOOLCHAIN_HAS_ZBKB
> > +     depends on RISCV_ALTERNATIVE
> > +     default y
> > +     help
> > +        Adds support to dynamically detect the presence of the ZBKB
> > +        extension (bit manipulation for cryptography) and enable its u=
sage.
> > +
> > +        The Zbkb extension provides instructions to accelerate a numbe=
r
> > +        of common cryptography operations (pack, zip, etc).
> > +
> > +        If you don't know what to do here, say Y.
> > +
> >   config RISCV_ISA_ZICBOM
> >       bool "Zicbom extension support for non-coherent DMA operation"
> >       depends on MMU
> > diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.=
h
> > index 776354895b81e7dc332e58265548aaf7365a6037..a8a2af6dfe9d2406625ca8f=
c94014fe5180e4fec 100644
> > --- a/arch/riscv/include/asm/asm.h
> > +++ b/arch/riscv/include/asm/asm.h
> > @@ -27,6 +27,7 @@
> >   #define REG_ASM             __REG_SEL(.dword, .word)
> >   #define SZREG               __REG_SEL(8, 4)
> >   #define LGREG               __REG_SEL(3, 2)
> > +#define SRLI         __REG_SEL(srliw, srli)
> >
> >   #if __SIZEOF_POINTER__ =3D=3D 8
> >   #ifdef __ASSEMBLY__
> > diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/includ=
e/asm/runtime-const.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..a23a9bd47903b2765608c75=
cd83f01ae578dffaa
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/runtime-const.h
> > @@ -0,0 +1,265 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_RISCV_RUNTIME_CONST_H
> > +#define _ASM_RISCV_RUNTIME_CONST_H
> > +
> > +#include <asm/asm.h>
> > +#include <asm/alternative.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/insn-def.h>
> > +#include <linux/memory.h>
> > +#include <asm/text-patching.h>
> > +
> > +#include <linux/uaccess.h>
> > +
> > +#ifdef CONFIG_32BIT
> > +#define runtime_const_ptr(sym)                                       \
> > +({                                                           \
> > +     typeof(sym) __ret;                                      \
> > +     asm_inline(".option push\n\t"                           \
> > +             ".option norvc\n\t"                             \
> > +             "1:\t"                                          \
> > +             "lui    %[__ret],0x89abd\n\t"                   \
> > +             "addi   %[__ret],%[__ret],-0x211\n\t"           \
> > +             ".option pop\n\t"                               \
> > +             ".pushsection runtime_ptr_" #sym ",\"a\"\n\t"   \
> > +             ".long 1b - .\n\t"                              \
> > +             ".popsection"                                   \
> > +             : [__ret] "=3Dr" (__ret));                        \
> > +     __ret;                                                  \
> > +})
> > +#else
> > +/*
> > + * Loading 64-bit constants into a register from immediates is a non-t=
rivial
> > + * task on riscv64. To get it somewhat performant, load 32 bits into t=
wo
> > + * different registers and then combine the results.
> > + *
> > + * If the processor supports the Zbkb extension, we can combine the fi=
nal
> > + * "slli,slli,srli,add" into the single "pack" instruction. If the pro=
cessor
> > + * doesn't support Zbkb but does support the Zbb extension, we can
> > + * combine the final "slli,srli,add" into one instruction "add.uw".
> > + */
> > +#define RISCV_RUNTIME_CONST_64_PREAMBLE                              \
> > +     ".option push\n\t"                                      \
> > +     ".option norvc\n\t"                                     \
> > +     "1:\t"                                                  \
> > +     "lui    %[__ret],0x89abd\n\t"                           \
> > +     "lui    %[__tmp],0x1234\n\t"                            \
> > +     "addiw  %[__ret],%[__ret],-0x211\n\t"                   \
> > +     "addiw  %[__tmp],%[__tmp],0x567\n\t"                    \
> > +
> > +#define RISCV_RUNTIME_CONST_64_BASE                          \
> > +     "slli   %[__tmp],%[__tmp],32\n\t"                       \
> > +     "slli   %[__ret],%[__ret],32\n\t"                       \
> > +     "srli   %[__ret],%[__ret],32\n\t"                       \
> > +     "add    %[__ret],%[__ret],%[__tmp]\n\t"                 \
> > +
> > +#define RISCV_RUNTIME_CONST_64_ZBA                           \
> > +     ".option push\n\t"                                      \
> > +     ".option arch,+zba\n\t"                                 \
> > +     "slli   %[__tmp],%[__tmp],32\n\t"                       \
> > +     "add.uw %[__ret],%[__ret],%[__tmp]\n\t"                 \
> > +     "nop\n\t"                                               \
> > +     "nop\n\t"                                               \
> > +     ".option pop\n\t"                                       \
> > +
> > +#define RISCV_RUNTIME_CONST_64_ZBKB                          \
> > +     ".option push\n\t"                                      \
> > +     ".option arch,+zbkb\n\t"                                \
> > +     "pack   %[__ret],%[__ret],%[__tmp]\n\t"                 \
> > +     "nop\n\t"                                               \
> > +     "nop\n\t"                                               \
> > +     "nop\n\t"                                               \
> > +     ".option pop\n\t"                                       \
> > +
> > +#define RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                        \
> > +     ".option pop\n\t"                                       \
> > +     ".pushsection runtime_ptr_" #sym ",\"a\"\n\t"           \
> > +     ".long 1b - .\n\t"                                      \
> > +     ".popsection"                                           \
> > +
> > +#if defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_RISCV_ISA_ZBKB)
> > +#define runtime_const_ptr(sym)                                        =
       \
> > +({                                                                   \
> > +     typeof(sym) __ret, __tmp;                                       \
> > +     asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE                      \
> > +             ALTERNATIVE_2(                                          \
> > +                     RISCV_RUNTIME_CONST_64_BASE,                    \
> > +                     RISCV_RUNTIME_CONST_64_ZBA,                     \
> > +                     0, RISCV_ISA_EXT_ZBA, 1,                        \
> > +                     RISCV_RUNTIME_CONST_64_ZBKB,                    \
> > +                     0, RISCV_ISA_EXT_ZBKB, 1                        \
> > +             )                                                       \
> > +             RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                   \
> > +             : [__ret] "=3Dr" (__ret), [__tmp] "=3Dr" (__tmp));       =
   \
> > +     __ret;                                                          \
> > +})
> > +#elif defined(CONFIG_RISCV_ISA_ZBA)
> > +#define runtime_const_ptr(sym)                                        =
       \
> > +({                                                                   \
> > +     typeof(sym) __ret, __tmp;                                       \
> > +     asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE                      \
> > +             ALTERNATIVE(                                            \
> > +                     RISCV_RUNTIME_CONST_64_BASE,                    \
> > +                     RISCV_RUNTIME_CONST_64_ZBA,                     \
> > +                     0, RISCV_ISA_EXT_ZBA, 1                         \
> > +             )                                                       \
> > +             RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                   \
> > +             : [__ret] "=3Dr" (__ret), [__tmp] "=3Dr" (__tmp));       =
   \
> > +     __ret;                                                          \
> > +})
> > +#elif defined(CONFIG_RISCV_ISA_ZBKB)
> > +#define runtime_const_ptr(sym)                                        =
       \
> > +({                                                                   \
> > +     typeof(sym) __ret, __tmp;                                       \
> > +     asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE                      \
> > +             ALTERNATIVE(                                            \
> > +                     RISCV_RUNTIME_CONST_64_BASE,                    \
> > +                     RISCV_RUNTIME_CONST_64_ZBKB,                    \
> > +                     0, RISCV_ISA_EXT_ZBKB, 1                        \
> > +             )                                                       \
> > +             RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                   \
> > +             : [__ret] "=3Dr" (__ret), [__tmp] "=3Dr" (__tmp));       =
   \
> > +     __ret;                                                          \
> > +})
> > +#else
> > +#define runtime_const_ptr(sym)                                        =
       \
> > +({                                                                   \
> > +     typeof(sym) __ret, __tmp;                                       \
> > +     asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE                      \
> > +             RISCV_RUNTIME_CONST_64_BASE                             \
> > +             RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                   \
> > +             : [__ret] "=3Dr" (__ret), [__tmp] "=3Dr" (__tmp));       =
   \
> > +     __ret;                                                          \
> > +})
> > +#endif
> > +#endif
> > +
> > +#define runtime_const_shift_right_32(val, sym)                       \
> > +({                                                           \
> > +     u32 __ret;                                              \
> > +     asm_inline(".option push\n\t"                           \
> > +             ".option norvc\n\t"                             \
> > +             "1:\t"                                          \
> > +             SRLI " %[__ret],%[__val],12\n\t"                \
> > +             ".option pop\n\t"                               \
> > +             ".pushsection runtime_shift_" #sym ",\"a\"\n\t" \
> > +             ".long 1b - .\n\t"                              \
> > +             ".popsection"                                   \
> > +             : [__ret] "=3Dr" (__ret)                          \
> > +             : [__val] "r" (val));                           \
> > +     __ret;                                                  \
> > +})
> > +
> > +#define runtime_const_init(type, sym) do {                   \
> > +     extern s32 __start_runtime_##type##_##sym[];            \
> > +     extern s32 __stop_runtime_##type##_##sym[];             \
> > +                                                             \
> > +     runtime_const_fixup(__runtime_fixup_##type,             \
> > +                         (unsigned long)(sym),               \
> > +                         __start_runtime_##type##_##sym,     \
> > +                         __stop_runtime_##type##_##sym);     \
> > +} while (0)
> > +
> > +static inline void __runtime_fixup_caches(void *where, unsigned int in=
sns)
> > +{
> > +     /* On riscv there are currently only cache-wide flushes so va is =
ignored. */
> > +     __always_unused uintptr_t va =3D (uintptr_t)where;
> > +
> > +     flush_icache_range(va, va + 4 * insns);
> > +}
> > +
> > +/*
> > + * The 32-bit immediate is stored in a lui+addi pairing.
> > + * lui holds the upper 20 bits of the immediate in the first 20 bits o=
f the instruction.
> > + * addi holds the lower 12 bits of the immediate in the first 12 bits =
of the instruction.
> > + */
> > +static inline void __runtime_fixup_32(__le16 *lui_parcel, __le16 *addi=
_parcel, unsigned int val)
> > +{
> > +     unsigned int lower_immediate, upper_immediate;
> > +     u32 lui_insn, addi_insn, addi_insn_mask;
> > +     __le32 lui_res, addi_res;
> > +
> > +     /* Mask out upper 12 bit of addi */
> > +     addi_insn_mask =3D 0x000fffff;
> > +
> > +     lui_insn =3D (u32)le16_to_cpu(lui_parcel[0]) | (u32)le16_to_cpu(l=
ui_parcel[1]) << 16;
> > +     addi_insn =3D (u32)le16_to_cpu(addi_parcel[0]) | (u32)le16_to_cpu=
(addi_parcel[1]) << 16;
> > +
> > +     lower_immediate =3D sign_extend32(val, 11);
> > +     upper_immediate =3D (val - lower_immediate);
> > +
> > +     if (upper_immediate & 0xfffff000) {
> > +             /* replace upper 20 bits of lui with upper immediate */
> > +             lui_insn &=3D 0x00000fff;
> > +             lui_insn |=3D upper_immediate & 0xfffff000;
> > +     } else {
> > +             /* replace lui with nop if immediate is small enough to f=
it in addi */
> > +             lui_insn =3D RISCV_INSN_NOP4;
> > +             /*
> > +              * lui is being skipped, so do a load instead of an add. =
A load
> > +              * is performed by adding with the x0 register. Setting r=
s to
> > +              * zero with the following mask will accomplish this goal=
.
> > +              */
> > +             addi_insn_mask &=3D 0x07fff;
> > +     }
> > +
> > +     if (lower_immediate & 0x00000fff) {
> > +             /* replace upper 12 bits of addi with lower 12 bits of va=
l */
> > +             addi_insn &=3D addi_insn_mask;
> > +             addi_insn |=3D (lower_immediate & 0x00000fff) << 20;
> > +     } else {
> > +             /* replace addi with nop if lower_immediate is empty */
> > +             addi_insn =3D RISCV_INSN_NOP4;
> > +     }
> > +
> > +     addi_res =3D cpu_to_le32(addi_insn);
> > +     lui_res =3D cpu_to_le32(lui_insn);
> > +     mutex_lock(&text_mutex);
> > +     patch_insn_write(addi_parcel, &addi_res, sizeof(addi_res));
> > +     patch_insn_write(lui_parcel, &lui_res, sizeof(lui_res));
> > +     mutex_unlock(&text_mutex);
> > +}
> > +
> > +static inline void __runtime_fixup_ptr(void *where, unsigned long val)
> > +{
> > +#ifdef CONFIG_32BIT
> > +             __runtime_fixup_32(where, where + 4, val);
> > +             __runtime_fixup_caches(where, 2);
> > +#else
> > +             __runtime_fixup_32(where, where + 8, val);
> > +             __runtime_fixup_32(where + 4, where + 12, val >> 32);
> > +             __runtime_fixup_caches(where, 4);
> > +#endif
> > +}
> > +
> > +/*
> > + * Replace the least significant 5 bits of the srli/srliw immediate th=
at is
> > + * located at bits 20-24
> > + */
> > +static inline void __runtime_fixup_shift(void *where, unsigned long va=
l)
> > +{
> > +     __le16 *parcel =3D where;
> > +     __le32 res;
> > +     u32 insn;
> > +
> > +     insn =3D (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]=
) << 16;
> > +
> > +     insn &=3D 0xfe0fffff;
> > +     insn |=3D (val & 0b11111) << 20;
> > +
> > +     res =3D cpu_to_le32(insn);
> > +     mutex_lock(&text_mutex);
> > +     patch_text_nosync(where, &res, sizeof(insn));
> > +     mutex_unlock(&text_mutex);
> > +}
> > +
> > +static inline void runtime_const_fixup(void (*fn)(void *, unsigned lon=
g),
> > +                                    unsigned long val, s32 *start, s32=
 *end)
> > +{
> > +     while (start < end) {
> > +             fn(*start + (void *)start, val);
> > +             start++;
> > +     }
> > +}
> > +
> > +#endif /* _ASM_RISCV_RUNTIME_CONST_H */
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinu=
x.lds.S
> > index 002ca58dd998cb78b662837b5ebac988fb6c77bb..61bd5ba6680a786bf1db7dc=
37bf1acda0639b5c7 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -97,6 +97,9 @@ SECTIONS
> >       {
> >               EXIT_DATA
> >       }
> > +
> > +     RUNTIME_CONST_VARIABLES
> > +
> >       PERCPU_SECTION(L1_CACHE_BYTES)
> >
> >       .rel.dyn : {
> >
