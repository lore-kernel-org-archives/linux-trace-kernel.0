Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56962505B2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386068; cv=none; b=RGgr+6J+Mq9XZCVx6oHFM7a7qlQ8FN8Sujvw9gD49dFXLv5VXz4xi7nC+ksmbQX2XYPh+Q7OLgPbYHvmLDx8sD7Go9MviL9e2m0zTBhfmmg/Qx8XVyfXn6XwAzfSyjffM3ZIy6i3R5QlGgAw58VQGA64/JMihlS6e41tBAQyHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386068; c=relaxed/simple;
	bh=DsntNwWr/71h8JWy1GGwsGCldoFfUPdAAwK/yceJvFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeZ5lEHXQhMYbsR3D7EHOKn+RD/HFmMaCsBDK0SN3rXqorAdC5MYeCK/MasUCjIYQSCTqpRIMbxdtLE/JK+YHKsiLgBkhkkad/vpgyW+L2Vsg4D44N72vQUOBhnKkGmY/JT5LRsw/kfAK6gcmt8TMZXDNz7wNFie2ym14rNY6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zqxWt32r; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zqxWt32r"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbb12bea54so1379739866b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742386065; x=1742990865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj1wv3hie3xf/U2fIJSRtMbb8Km5isZegvQ7ROR/UgE=;
        b=zqxWt32rLuOnapqNGDAREBEreMenW7VOJYvfRSQdKL7BN3V9cX6oFPVayU8VpSHoat
         44I3glW5D+I29Eh4mvJ4o2vQjQK2lMjn4r1rCChYjuUoICdsFqas2uQVkr1uOpQxKXZS
         nUglxMoPqr9IBNqSUvXOY8taz3W6F+cuaeRkUrOwnTIzKEvBrzCUlolRaw8kLj4fhqX0
         V7/x/pSwTL/Fd0xTNIV45rWfKrUJ/y935lr4djU5IHTK4gL10CdH/IJe99uibIM6J8IL
         yPYVLlur9mmTxssLGEYYnVvTtzNclpfGuG8VNIEix+6RZwGBEn6ypul9J+z/wnT3MQIO
         2YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742386065; x=1742990865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dj1wv3hie3xf/U2fIJSRtMbb8Km5isZegvQ7ROR/UgE=;
        b=nLbNqEYxzm6jOU3/NXXR1JJeB1adatpSxd0L9zMU9erch2Bib3n9o8e5LSiY+FWVRH
         YcR1MgOOI2j/ChTawVHzV1NjklWTbtFMe++qfHtyslUivcs2ITIagFLmdvf2V/pHy3j5
         6ldUWKSILXq+C0Rey8eCgqPGb/J8DWR7ABO83fMZDQOBAU3DZ3SYoowpl0GqgQq97z7r
         nDHTCLz2BsZDPxr1c2vdT+wKRfUQYGIwFcp9OAGYoJpFRKAzp3a4P/HdqmMXm4PxwzMQ
         oxVPiUW7l6YezlgZpYnclw5PvII7nuuYaPn1SEIJBp1rhZ3zs3dZpa5GMba2tEt3ZHET
         eAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5c53eOIVZHAJbFMwm8BX1r3GPJhvV4iChmqRV4pDXjmogS5B7HhpVXWTznSssG8r98Fxu877q8P74zrqsjXJOTCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywepv8c6eTqownUg5nxz8804GBPoDPwxdJlukzr4hdBVbKIwXKU
	6RwJChOLHowbziQspVeXVYPAUVBDxCSdWzsymRLuzjbXGWgEACuyvxFQG4b7NhfhnkbAhp7hLTT
	KlU2NnlrprQl44oV0dRQDocOmV1+8ZL+nk2j9EQ==
X-Gm-Gg: ASbGncthxmEe31t3PqM3GnIFvXzJ5O37hiOozOBoNZQ320DtEX4SrmXcz3jZ0RCDp3T
	V306/HfWn58opw6D0+5Rs6gOUozd+bnLYYqjo9OFtdgNQ3JbzpLJcN4z8sp/iBYzYNWjnVKblt3
	osdfMj6m0hr2JQ67x/h64csfZ5h4MUuFsUDWE78aKtiDEmuNDXzckEekF0CDU=
X-Google-Smtp-Source: AGHT+IE959JkF4JbGxNjtCLhhUw13PhDVcbNmTMyMrjsGBeV1Ndq8mfPbHvsBiY6Rms3kB62EULxIa7YQaMjWdGnYjU=
X-Received: by 2002:a17:907:f508:b0:abe:fa18:1fc6 with SMTP id
 a640c23a62f3a-ac3b7c49e73mr299524666b.10.1742386064912; Wed, 19 Mar 2025
 05:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-runtime_const_riscv-v9-0-ddd3534d3e8e@rivosinc.com> <20250318-runtime_const_riscv-v9-2-ddd3534d3e8e@rivosinc.com>
In-Reply-To: <20250318-runtime_const_riscv-v9-2-ddd3534d3e8e@rivosinc.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 19 Mar 2025 13:07:33 +0100
X-Gm-Features: AQ5f1JrY_AAZHgcwIN9G8noVjnJfDMKwTRyJo_zRGvJG4Jva2bHGDDLMCcF787M
Message-ID: <CAHVXubj3TMpb0XzA2c1HuN9oUj97uvRGiyGNx9YrTWaHutEjjA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] riscv: Add runtime constant support
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Pasha Bouzarjomehri <pasha@rivosinc.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Charlie,

On Wed, Mar 19, 2025 at 1:39=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Implement the runtime constant infrastructure for riscv. Use this
> infrastructure to generate constants to be used by the d_hash()
> function.
>
> This is the riscv variant of commit 94a2bc0f611c ("arm64: add 'runtime
> constant' support") and commit e3c92e81711d ("runtime constants: add
> x86 architecture support").
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig                     |  22 +++
>  arch/riscv/include/asm/asm.h           |   1 +
>  arch/riscv/include/asm/runtime-const.h | 265 +++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/vmlinux.lds.S        |   3 +
>  4 files changed, 291 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7612c52e9b1e35607f1dd4603a596416d3357a71..c123f7c0579c1aca839e3c04b=
db662d6856ae765 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -783,6 +783,28 @@ config RISCV_ISA_ZBC
>
>            If you don't know what to do here, say Y.
>
> +config TOOLCHAIN_HAS_ZBKB
> +       bool
> +       default y
> +       depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zb=
kb)
> +       depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_z=
bkb)
> +       depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23900
> +       depends on AS_HAS_OPTION_ARCH
> +
> +config RISCV_ISA_ZBKB
> +       bool "Zbkb extension support for bit manipulation instructions"
> +       depends on TOOLCHAIN_HAS_ZBKB
> +       depends on RISCV_ALTERNATIVE
> +       default y
> +       help
> +          Adds support to dynamically detect the presence of the ZBKB
> +          extension (bit manipulation for cryptography) and enable its u=
sage.
> +
> +          The Zbkb extension provides instructions to accelerate a numbe=
r
> +          of common cryptography operations (pack, zip, etc).
> +
> +          If you don't know what to do here, say Y.
> +
>  config RISCV_ISA_ZICBOM
>         bool "Zicbom extension support for non-coherent DMA operation"
>         depends on MMU
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index 776354895b81e7dc332e58265548aaf7365a6037..a8a2af6dfe9d2406625ca8fc9=
4014fe5180e4fec 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -27,6 +27,7 @@
>  #define REG_ASM                __REG_SEL(.dword, .word)
>  #define SZREG          __REG_SEL(8, 4)
>  #define LGREG          __REG_SEL(3, 2)
> +#define SRLI           __REG_SEL(srliw, srli)
>
>  #if __SIZEOF_POINTER__ =3D=3D 8
>  #ifdef __ASSEMBLY__
> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/=
asm/runtime-const.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..a23a9bd47903b2765608c75cd=
83f01ae578dffaa
> --- /dev/null
> +++ b/arch/riscv/include/asm/runtime-const.h
> @@ -0,0 +1,265 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_RUNTIME_CONST_H
> +#define _ASM_RISCV_RUNTIME_CONST_H
> +
> +#include <asm/asm.h>
> +#include <asm/alternative.h>
> +#include <asm/cacheflush.h>
> +#include <asm/insn-def.h>
> +#include <linux/memory.h>
> +#include <asm/text-patching.h>
> +
> +#include <linux/uaccess.h>
> +
> +#ifdef CONFIG_32BIT
> +#define runtime_const_ptr(sym)                                 \
> +({                                                             \
> +       typeof(sym) __ret;                                      \
> +       asm_inline(".option push\n\t"                           \
> +               ".option norvc\n\t"                             \
> +               "1:\t"                                          \
> +               "lui    %[__ret],0x89abd\n\t"                   \
> +               "addi   %[__ret],%[__ret],-0x211\n\t"           \
> +               ".option pop\n\t"                               \
> +               ".pushsection runtime_ptr_" #sym ",\"a\"\n\t"   \
> +               ".long 1b - .\n\t"                              \
> +               ".popsection"                                   \
> +               : [__ret] "=3Dr" (__ret));                        \
> +       __ret;                                                  \
> +})
> +#else
> +/*
> + * Loading 64-bit constants into a register from immediates is a non-tri=
vial
> + * task on riscv64. To get it somewhat performant, load 32 bits into two
> + * different registers and then combine the results.
> + *
> + * If the processor supports the Zbkb extension, we can combine the fina=
l
> + * "slli,slli,srli,add" into the single "pack" instruction. If the proce=
ssor
> + * doesn't support Zbkb but does support the Zbb extension, we can
> + * combine the final "slli,srli,add" into one instruction "add.uw".
> + */
> +#define RISCV_RUNTIME_CONST_64_PREAMBLE                                \
> +       ".option push\n\t"                                      \
> +       ".option norvc\n\t"                                     \
> +       "1:\t"                                                  \
> +       "lui    %[__ret],0x89abd\n\t"                           \
> +       "lui    %[__tmp],0x1234\n\t"                            \
> +       "addiw  %[__ret],%[__ret],-0x211\n\t"                   \
> +       "addiw  %[__tmp],%[__tmp],0x567\n\t"                    \
> +
> +#define RISCV_RUNTIME_CONST_64_BASE                            \
> +       "slli   %[__tmp],%[__tmp],32\n\t"                       \
> +       "slli   %[__ret],%[__ret],32\n\t"                       \
> +       "srli   %[__ret],%[__ret],32\n\t"                       \
> +       "add    %[__ret],%[__ret],%[__tmp]\n\t"                 \
> +
> +#define RISCV_RUNTIME_CONST_64_ZBA                             \
> +       ".option push\n\t"                                      \
> +       ".option arch,+zba\n\t"                                 \
> +       "slli   %[__tmp],%[__tmp],32\n\t"                       \
> +       "add.uw %[__ret],%[__ret],%[__tmp]\n\t"                 \
> +       "nop\n\t"                                               \
> +       "nop\n\t"                                               \
> +       ".option pop\n\t"                                       \
> +
> +#define RISCV_RUNTIME_CONST_64_ZBKB                            \
> +       ".option push\n\t"                                      \
> +       ".option arch,+zbkb\n\t"                                \
> +       "pack   %[__ret],%[__ret],%[__tmp]\n\t"                 \
> +       "nop\n\t"                                               \
> +       "nop\n\t"                                               \
> +       "nop\n\t"                                               \
> +       ".option pop\n\t"                                       \
> +
> +#define RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                  \
> +       ".option pop\n\t"                                       \
> +       ".pushsection runtime_ptr_" #sym ",\"a\"\n\t"           \
> +       ".long 1b - .\n\t"                                      \
> +       ".popsection"                                           \
> +
> +#if defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_RISCV_ISA_ZBKB)
> +#define runtime_const_ptr(sym)                                         \
> +({                                                                     \
> +       typeof(sym) __ret, __tmp;                                       \
> +       asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE                      \
> +               ALTERNATIVE_2(                                          \
> +                       RISCV_RUNTIME_CONST_64_BASE,                    \
> +                       RISCV_RUNTIME_CONST_64_ZBA,                     \
> +                       0, RISCV_ISA_EXT_ZBA, 1,                        \
> +                       RISCV_RUNTIME_CONST_64_ZBKB,                    \
> +                       0, RISCV_ISA_EXT_ZBKB, 1                        \
> +               )                                                       \
> +               RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                   \
> +               : [__ret] "=3Dr" (__ret), [__tmp] "=3Dr" (__tmp));       =
   \
> +       __ret;                                                          \
> +})
> +#elif defined(CONFIG_RISCV_ISA_ZBA)
> +#define runtime_const_ptr(sym)                                         \
> +({                                                                     \
> +       typeof(sym) __ret, __tmp;                                       \
> +       asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE                      \
> +               ALTERNATIVE(                                            \
> +                       RISCV_RUNTIME_CONST_64_BASE,                    \
> +                       RISCV_RUNTIME_CONST_64_ZBA,                     \
> +                       0, RISCV_ISA_EXT_ZBA, 1                         \
> +               )                                                       \
> +               RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                   \
> +               : [__ret] "=3Dr" (__ret), [__tmp] "=3Dr" (__tmp));       =
   \
> +       __ret;                                                          \
> +})
> +#elif defined(CONFIG_RISCV_ISA_ZBKB)
> +#define runtime_const_ptr(sym)                                         \
> +({                                                                     \
> +       typeof(sym) __ret, __tmp;                                       \
> +       asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE                      \
> +               ALTERNATIVE(                                            \
> +                       RISCV_RUNTIME_CONST_64_BASE,                    \
> +                       RISCV_RUNTIME_CONST_64_ZBKB,                    \
> +                       0, RISCV_ISA_EXT_ZBKB, 1                        \
> +               )                                                       \
> +               RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                   \
> +               : [__ret] "=3Dr" (__ret), [__tmp] "=3Dr" (__tmp));       =
   \
> +       __ret;                                                          \
> +})
> +#else
> +#define runtime_const_ptr(sym)                                         \
> +({                                                                     \
> +       typeof(sym) __ret, __tmp;                                       \
> +       asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE                      \
> +               RISCV_RUNTIME_CONST_64_BASE                             \
> +               RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)                   \
> +               : [__ret] "=3Dr" (__ret), [__tmp] "=3Dr" (__tmp));       =
   \
> +       __ret;                                                          \
> +})
> +#endif
> +#endif
> +
> +#define runtime_const_shift_right_32(val, sym)                 \
> +({                                                             \
> +       u32 __ret;                                              \
> +       asm_inline(".option push\n\t"                           \
> +               ".option norvc\n\t"                             \
> +               "1:\t"                                          \
> +               SRLI " %[__ret],%[__val],12\n\t"                \
> +               ".option pop\n\t"                               \
> +               ".pushsection runtime_shift_" #sym ",\"a\"\n\t" \
> +               ".long 1b - .\n\t"                              \
> +               ".popsection"                                   \
> +               : [__ret] "=3Dr" (__ret)                          \
> +               : [__val] "r" (val));                           \
> +       __ret;                                                  \
> +})
> +
> +#define runtime_const_init(type, sym) do {                     \
> +       extern s32 __start_runtime_##type##_##sym[];            \
> +       extern s32 __stop_runtime_##type##_##sym[];             \
> +                                                               \
> +       runtime_const_fixup(__runtime_fixup_##type,             \
> +                           (unsigned long)(sym),               \
> +                           __start_runtime_##type##_##sym,     \
> +                           __stop_runtime_##type##_##sym);     \
> +} while (0)
> +
> +static inline void __runtime_fixup_caches(void *where, unsigned int insn=
s)
> +{
> +       /* On riscv there are currently only cache-wide flushes so va is =
ignored. */
> +       __always_unused uintptr_t va =3D (uintptr_t)where;
> +
> +       flush_icache_range(va, va + 4 * insns);
> +}
> +
> +/*
> + * The 32-bit immediate is stored in a lui+addi pairing.
> + * lui holds the upper 20 bits of the immediate in the first 20 bits of =
the instruction.
> + * addi holds the lower 12 bits of the immediate in the first 12 bits of=
 the instruction.
> + */
> +static inline void __runtime_fixup_32(__le16 *lui_parcel, __le16 *addi_p=
arcel, unsigned int val)
> +{
> +       unsigned int lower_immediate, upper_immediate;
> +       u32 lui_insn, addi_insn, addi_insn_mask;
> +       __le32 lui_res, addi_res;
> +
> +       /* Mask out upper 12 bit of addi */
> +       addi_insn_mask =3D 0x000fffff;
> +
> +       lui_insn =3D (u32)le16_to_cpu(lui_parcel[0]) | (u32)le16_to_cpu(l=
ui_parcel[1]) << 16;
> +       addi_insn =3D (u32)le16_to_cpu(addi_parcel[0]) | (u32)le16_to_cpu=
(addi_parcel[1]) << 16;
> +
> +       lower_immediate =3D sign_extend32(val, 11);
> +       upper_immediate =3D (val - lower_immediate);
> +
> +       if (upper_immediate & 0xfffff000) {
> +               /* replace upper 20 bits of lui with upper immediate */
> +               lui_insn &=3D 0x00000fff;
> +               lui_insn |=3D upper_immediate & 0xfffff000;
> +       } else {
> +               /* replace lui with nop if immediate is small enough to f=
it in addi */
> +               lui_insn =3D RISCV_INSN_NOP4;
> +               /*
> +                * lui is being skipped, so do a load instead of an add. =
A load
> +                * is performed by adding with the x0 register. Setting r=
s to
> +                * zero with the following mask will accomplish this goal=
.
> +                */
> +               addi_insn_mask &=3D 0x07fff;
> +       }
> +
> +       if (lower_immediate & 0x00000fff) {
> +               /* replace upper 12 bits of addi with lower 12 bits of va=
l */
> +               addi_insn &=3D addi_insn_mask;
> +               addi_insn |=3D (lower_immediate & 0x00000fff) << 20;
> +       } else {
> +               /* replace addi with nop if lower_immediate is empty */
> +               addi_insn =3D RISCV_INSN_NOP4;
> +       }
> +
> +       addi_res =3D cpu_to_le32(addi_insn);
> +       lui_res =3D cpu_to_le32(lui_insn);
> +       mutex_lock(&text_mutex);
> +       patch_insn_write(addi_parcel, &addi_res, sizeof(addi_res));
> +       patch_insn_write(lui_parcel, &lui_res, sizeof(lui_res));
> +       mutex_unlock(&text_mutex);
> +}
> +
> +static inline void __runtime_fixup_ptr(void *where, unsigned long val)
> +{
> +#ifdef CONFIG_32BIT
> +               __runtime_fixup_32(where, where + 4, val);
> +               __runtime_fixup_caches(where, 2);
> +#else
> +               __runtime_fixup_32(where, where + 8, val);
> +               __runtime_fixup_32(where + 4, where + 12, val >> 32);
> +               __runtime_fixup_caches(where, 4);
> +#endif
> +}
> +
> +/*
> + * Replace the least significant 5 bits of the srli/srliw immediate that=
 is
> + * located at bits 20-24
> + */
> +static inline void __runtime_fixup_shift(void *where, unsigned long val)
> +{
> +       __le16 *parcel =3D where;
> +       __le32 res;
> +       u32 insn;
> +
> +       insn =3D (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]=
) << 16;
> +
> +       insn &=3D 0xfe0fffff;
> +       insn |=3D (val & 0b11111) << 20;
> +
> +       res =3D cpu_to_le32(insn);
> +       mutex_lock(&text_mutex);
> +       patch_text_nosync(where, &res, sizeof(insn));
> +       mutex_unlock(&text_mutex);
> +}
> +
> +static inline void runtime_const_fixup(void (*fn)(void *, unsigned long)=
,
> +                                      unsigned long val, s32 *start, s32=
 *end)
> +{
> +       while (start < end) {
> +               fn(*start + (void *)start, val);
> +               start++;
> +       }
> +}
> +
> +#endif /* _ASM_RISCV_RUNTIME_CONST_H */
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.=
lds.S
> index 002ca58dd998cb78b662837b5ebac988fb6c77bb..61bd5ba6680a786bf1db7dc37=
bf1acda0639b5c7 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -97,6 +97,9 @@ SECTIONS
>         {
>                 EXIT_DATA
>         }
> +
> +       RUNTIME_CONST_VARIABLES
> +
>         PERCPU_SECTION(L1_CACHE_BYTES)
>
>         .rel.dyn : {
>
> --
> 2.43.0
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
