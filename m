Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF32505B2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386022; cv=none; b=INCV+6fO4T0tJXldB459h0ZhOXJO+RYk3gWqtp1+v0XHy/5dVkRWFd41xh3RlIRQe0IXzqGhOpreu5RaW0+44zvKMSBbTIrlk7D5XZVUBCfc/EEqo7c9Kt29mguiXSkDeLlyzu0iJz5YYW/eU7QgBxOVwjiCZ2z3j1z/SczA1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386022; c=relaxed/simple;
	bh=Os55gpHmtBaFoy4EizyVtukjFDIwLYhxxp9IlZe9pBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUAtU31Pmx77nknU3NO75olT5MeIlxo9quTMBB5RmwGoRh0HDgD33a/yZVbuFsAr77wollP9pM19gUPyOz+sOBw7pnfy6aImi82JMxpC1UGhWtdEQdQlj6Yvz50maZG01mkWSFHST7xSl9VcD4CYaadIdXtbX78NKrPCfxenySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Mpl/L6AE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Mpl/L6AE"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so1062438466b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742386019; x=1742990819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78siVUcrqX50+D3XL3UtIOYlvRh1M9mNDzyv1u3Bamk=;
        b=Mpl/L6AE/fWxBzDbsr5G/MRNmGPjxYnzcXdj0AQafQg1/pKQo1bKsPAp9YsjjTom5D
         rW19/7Mnc4uAk14ezi4MeAER+Rf3ojL3Aiui/xSSeMmgUlc2BvygEvfxkSDrINbBMcbD
         LUHcL+H5G68yP2tgIRml4XfaqdC05q3u54zO3bHUFxqhlO9iYs5LjyqXjBhvKBh1M/rI
         FYARSSpP27Xk2kw5w8Ozr5lKZorUThMV8vaUvur8qrJBslWsKgkkzM+36wZAaREJqUta
         XtyldBYaE8EksgGZDQ4vGVAZmG2j2WtQ8PaD/Tk7bNaHROkObBgEgthBnj/0fO+wJbij
         qsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742386019; x=1742990819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78siVUcrqX50+D3XL3UtIOYlvRh1M9mNDzyv1u3Bamk=;
        b=OBh4dEEYEhBLt0+qoniiynwfEtOyyW7IJRhdNL1H43UcV7IqlEJNsu7YBq+WIiQ98L
         oravTz/7aQ1IkqkpLw1N/cXci0gCi2p9n6E5OpxszotXL9bzWQRzH1hUSCidIiRsAgot
         AahuQirRpe2YsemWUkXDTeiCybgYXywI2Few6SJD4ktftvHJOscYlGYFmjthetNcSa6V
         ReFfIjag3ghyyH7SNJGn/AL+OIGNZ9+1CVjvRH95moAnY67CwIoRbrtcUBgBfuuC9Wtl
         BWjK7Sm1Cu5Xbv4zgZTzGLSlk9NhFXTPm47n+GqTNVFvKx0EcUe2d16a2LZXXBRznuK1
         tafA==
X-Forwarded-Encrypted: i=1; AJvYcCUOLr+FL1aIc9yKSj8v2noy+CmNpGCQY1zc1rBgmOA7J99vZP6IcjQ1i4njEOulK7qSRXfJmszg+FfxQMr57Zp7g5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk7Me83SrhD+dTsDJxrBk2H6luhJjx6Ali/Hj6iyw5PKZfmwsc
	ZfTdlBoXfH+n1UUO5AzRnsKPHZsHu2+UlkIzkcyFEIr6/XSVCMwqhyioZZ6fa5WgX+lRt7FS1W5
	Ux6oq8suIUV/iseyqTHETH6WBrUGTKR276ikglA==
X-Gm-Gg: ASbGnct5qttrnF3PvjywoQh+YAlJZNHFInn4wGjzTJjP3X/OljcmVEeMBE+UHdPqbj+
	Wqo+xAgcBuWf3Z2y6IBGFAycLAh6cb4X+sUoEpdmk0cuG6WkYIujuT14P0C313uW95VuSgPpktD
	j8IP+Kmd5tVJnU7Qdu7BkH35eRsNtRMkyWNFOp3X2L17fZ7gv9A10P6ikEQjw=
X-Google-Smtp-Source: AGHT+IGiAtZ6MEUzl0vHpywyUjhVa6wLjc70DoixDCEpsVWavF8Jtx8EFXS/HyAo6VIz+Kt+JJ/9K+rKpTmj5VxB2jg=
X-Received: by 2002:a17:907:d786:b0:ac2:c26:5608 with SMTP id
 a640c23a62f3a-ac3b7abbc17mr276281066b.8.1742386018860; Wed, 19 Mar 2025
 05:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-runtime_const_riscv-v9-0-ddd3534d3e8e@rivosinc.com> <20250318-runtime_const_riscv-v9-1-ddd3534d3e8e@rivosinc.com>
In-Reply-To: <20250318-runtime_const_riscv-v9-1-ddd3534d3e8e@rivosinc.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 19 Mar 2025 13:06:48 +0100
X-Gm-Features: AQ5f1JqRGfd7xwZfyu2cdRM57q3At-EAnqsxfbHWxk-qnkLR0BlmB6Gp6NGNBVY
Message-ID: <CAHVXubjbfVmU4PFD8s-uRF03KjtVKyyUsCHxhKQ6vXJfFhsVzA@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] riscv: Move nop definition to insn-def.h
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
> We have duplicated the definition of the nop instruction in ftrace.h and
> in jump_label.c. Move this definition into the generic file insn-def.h
> so that they can share the definition with each other and with future
> files.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/ftrace.h   | 1 -
>  arch/riscv/include/asm/insn-def.h | 2 ++
>  arch/riscv/kernel/ftrace.c        | 6 +++---
>  arch/riscv/kernel/jump_label.c    | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..b7f361a50f6445d02a0d88eef=
5547ee27c1fb52e 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -79,7 +79,6 @@ struct dyn_arch_ftrace {
>  #define AUIPC_RA               (0x00000097)
>  #define JALR_T0                        (0x000282e7)
>  #define AUIPC_T0               (0x00000297)
> -#define NOP4                   (0x00000013)
>
>  #define to_jalr_t0(offset)                                             \
>         (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/i=
nsn-def.h
> index 9a913010cdd93cdfdd93f467e7880e20cce0dd2b..0a1fc5134f29da190554c59f8=
cee3b5374c9aa2d 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -200,4 +200,6 @@
>  #define ZAWRS_WRS_NTO  ".4byte 0x00d00073"
>  #define ZAWRS_WRS_STO  ".4byte 0x01d00073"
>
> +#define RISCV_INSN_NOP4        0x00000013U
> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 3524db5e4fa014a4594465f849d898a030bfb7b8..674dcdfae7a149c339f1e791a=
db450535f22991b 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -36,7 +36,7 @@ static int ftrace_check_current_call(unsigned long hook=
_pos,
>                                      unsigned int *expected)
>  {
>         unsigned int replaced[2];
> -       unsigned int nops[2] =3D {NOP4, NOP4};
> +       unsigned int nops[2] =3D {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
>
>         /* we expect nops at the hook position */
>         if (!expected)
> @@ -68,7 +68,7 @@ static int __ftrace_modify_call(unsigned long hook_pos,=
 unsigned long target,
>                                 bool enable, bool ra)
>  {
>         unsigned int call[2];
> -       unsigned int nops[2] =3D {NOP4, NOP4};
> +       unsigned int nops[2] =3D {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
>
>         if (ra)
>                 make_call_ra(hook_pos, target, call);
> @@ -97,7 +97,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned l=
ong addr)
>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>                     unsigned long addr)
>  {
> -       unsigned int nops[2] =3D {NOP4, NOP4};
> +       unsigned int nops[2] =3D {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
>
>         if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
>                 return -EPERM;
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_labe=
l.c
> index 654ed159c830b3d5e34ac58bf367107066eb73a1..b4c1a6a3fbd28533552036194=
f27ed206bea305d 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -11,8 +11,8 @@
>  #include <asm/bug.h>
>  #include <asm/cacheflush.h>
>  #include <asm/text-patching.h>
> +#include <asm/insn-def.h>
>
> -#define RISCV_INSN_NOP 0x00000013U
>  #define RISCV_INSN_JAL 0x0000006fU
>
>  bool arch_jump_label_transform_queue(struct jump_entry *entry,
> @@ -33,7 +33,7 @@ bool arch_jump_label_transform_queue(struct jump_entry =
*entry,
>                         (((u32)offset & GENMASK(10,  1)) << (21 -  1)) |
>                         (((u32)offset & GENMASK(20, 20)) << (31 - 20));
>         } else {
> -               insn =3D RISCV_INSN_NOP;
> +               insn =3D RISCV_INSN_NOP4;
>         }
>
>         if (early_boot_irqs_disabled) {
>
> --
> 2.43.0
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
