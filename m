Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54028936E;
	Wed,  7 May 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627535; cv=none; b=iXCmiMEBiakdd6C+IQpVQdMjMj3eEAR7p8VKBV37ufOOPcmct0d1JpANdSR+954JlUUqA1JGNAz+cDsID60S6r33D/r8ceg4IqJR9WpAgxMxWqtEKY6HcDy9W/03idpMXU9JpryFm4mX1TYoptZB5RdE0nEYtXaOj2TgGHkwJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627535; c=relaxed/simple;
	bh=FD4O6QobhgY2V6HoziwBobxZEANNwyqRczGfovFLe98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBJ6dGyhoaulRYEZ/OYt9wxvOUE+2pJtZwhAAsz8PgnJUiZ3OQgjNS3OXr7KCNm9Z2Cb/pGFv0dR/dB0+Uj5Cp+siBfTGL1vC2pOLQ1KTG641Y8/soZCVTD0Oizkgkyl+/IRsIQ6K1lxNZJcqxBu92DJL/rbBv0h6YuRjTvewR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USsJHICe; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USsJHICe"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30ab344a1d8so760068a91.3;
        Wed, 07 May 2025 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746627533; x=1747232333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgc60RT3i5cN3qIa3LzlK7CpHd0lVW+cAZTi4RAyCBg=;
        b=USsJHICeuE1phaeR1+dsjht/+Ql3pKCS5SY5Iq1sqbWKOMoai06XWMPHbLlRJGFtgG
         spvZIB/VUK+0L2eYvaAD23njgIiNj6JzSm1TBMbZJtHpy09QuzTPmpEQNWKwgAl4iX5x
         PyK7wAmkg7izfayHxCNV49IijgHrvQPBrfJYa0rJhaGlGsmQ6SHaBgXW9w1h0GbKXEbt
         qNIcKHR6kqJbAOLVeVEWEil/Gi0b92MaXLcGNmmexPeuHG4V1OMqJntqggkpnfgNzytj
         CPtdnoXBKq+a/4Dca1hc8Tq6e4QLapM6qoPfVw0Rg/ll7aDirfNTXwu8d5vJSaLxEVi1
         b+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627533; x=1747232333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgc60RT3i5cN3qIa3LzlK7CpHd0lVW+cAZTi4RAyCBg=;
        b=jfDZntHQD7DhbzfJODAZNVPDqVXS/REU9Rh+C+LI3+wQku0M+F6yA3wH3T2gQ4GZ6r
         l9GeWAQQfIY9qeCcwhLqFQdf7ooo3fG1swvfl6v7SGEOacmVKS6X5U7AjgE3l2iNGgtT
         LQ4LvnwpQNr35pDSyAg+K/ukqOuXSdJvx5/w9Xpi4H6AG6R55yikdtFLR9XGqiVYf5U+
         uW5nUoOUCRmHUGBnrYje5wRQesuQfdycyDijRLMeMbO0x2ZBu2xiKd4w7IK9ICDKWIq7
         wwVxtQnfqzsfWrYOQa8KWV+0qnJgxMCKCQdr9ohAkvPq9nlpxI077G6StU6XXLrC1eq8
         5C2A==
X-Forwarded-Encrypted: i=1; AJvYcCU67oovAxuohexv0ZD/XPEg5uykVYuMLIqH6gtQ5K9jlJnz++WVLdWuEa4eMJstAJ4K+nkI8Q2Z8nyFgYQ=@vger.kernel.org, AJvYcCV0MEnniHW/D9mq6vWKl/TLz7uTVbn2spgKngZhTJOIrofibdPp1Vwj8pvI/ndiEUcdHIbgdYgrmcd+0TOdjNuPmUUp@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAj8nyghqLYVQ2jIiee3VUIs/95wlEc1tPecJf5495k6QsMQ/
	66hJvh+A0D85x5xuQww8XqvDPlqYgz2J+1SHt3WjHHMS0CmZf8AmTHluAp5+PxJicSMDqbqzbse
	NurymtIa1HMd/uK7t640X13Nlc7U=
X-Gm-Gg: ASbGncvB8tTEqGkBvHSQdNJRWQTHer1u6rxO4/ur7a/KYvlPqJjgEo8F4iDM+efaQvO
	Maix1Po/T9aRN630M559fPawdLLGuuiJOoXM7SOcMIAzZFlWcVwvw4dwBhpGSZOzI9phNfjSYg8
	kddCLxYV/gXZz6rzT1xuPf
X-Google-Smtp-Source: AGHT+IEmQxH33871YZY3s1s6MqDyX/nGOIPdONOoV22HVlB9DOFJNyuch2FqDTS8A9EGoIff0ZbTjm1qackYxcEp1ro=
X-Received: by 2002:a17:90a:e7d1:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-30aac2a3514mr4717256a91.34.1746627532879; Wed, 07 May 2025
 07:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407180838.42877-1-andybnac@gmail.com> <20250407180838.42877-5-andybnac@gmail.com>
 <aea9f0cd-087a-43f2-8631-a6926ff9ced3@ghiti.fr> <735ba24d-e1f9-4d56-934b-18d0d2b91428@ghiti.fr>
In-Reply-To: <735ba24d-e1f9-4d56-934b-18d0d2b91428@ghiti.fr>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 7 May 2025 22:18:41 +0800
X-Gm-Features: ATxdqUEwQTmsp8Ckx0abK8dwvmdeO68vyi3kOdzCbrf7SNskU6bBtehrZAmmfvk
Message-ID: <CAFTtA3NqC+r9HBS2cJvwzZMyTECJe3VbWrsZgWo6e-LTgpPOaA@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] riscv: ftrace: prepare ftrace for atomic code patching
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com, 
	palmer@dabbelt.com, Andy Chiu <andy.chiu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, puranjay12@gmail.com, paul.walmsley@sifive.com, 
	greentime.hu@sifive.com, nick.hu@sifive.com, nylon.chen@sifive.com, 
	eric.lin@sifive.com, vicent.chen@sifive.com, zong.li@sifive.com, 
	yongxuan.wang@sifive.com, samuel.holland@sifive.com, olivia.chu@sifive.com, 
	c2232430@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:06=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> On 23/04/2025 10:22, Alexandre Ghiti wrote:
> > Hi Andy,
> >
> > On 07/04/2025 20:08, Andy Chiu wrote:
> >> From: Andy Chiu <andy.chiu@sifive.com>
> >>
> >> We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
> >> instruction fetch can break down to 4 byte at a time, it is impossible
> >> to update two instructions without a race. In order to mitigate it, we
> >> initialize the patchable entry to AUIPC + NOP4. Then, the run-time cod=
e
> >> patching can change NOP4 to JALR to eable/disable ftrcae from a
> >> function. This limits the reach of each ftrace entry to +-2KB displaci=
ng
> >> from ftrace_caller.
> >>
> >> Starting from the trampoline, we add a level of indirection for it to
> >> reach ftrace caller target. Now, it loads the target address from a
> >> memory location, then perform the jump. This enable the kernel to upda=
te
> >> the target atomically.
> >>
> >> The new don't-stop-the-world text patching on change only one RISC-V
> >> instruction:
> >>
> >>    |  -8: &ftrace_ops of the associated tracer function.
> >>    | <ftrace enable>:
> >>    |   0: auipc  t0, hi(ftrace_caller)
> >>    |   4: jalr   t0, lo(ftrace_caller)
> >>    |
> >>    |  -8: &ftrace_nop_ops
> >>    | <ftrace disable>:
> >>    |   0: auipc  t0, hi(ftrace_caller)
> >>    |   4: nop
> >>
> >> This means that f+0x0 is fixed, and should not be claimed by ftrace,
> >> e.g. kprobe should be able to put a probe in f+0x0. Thus, we adjust th=
e
> >> offset and MCOUNT_INSN_SIZE accordingly.
> >>
> >> Co-developed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> >> ---
> >> Changelog v4:
> >>   - Include Bj=C3=B6rn's fix for kprobe
> >>   - Refactor code for better reading (Robbin, Bj=C3=B6rn)
> >>   - Remove make_call_ra and friedns (Bj=C3=B6rn)
> >>   - Update comments to match reality (Bj=C3=B6rn)
> >>   - Drop code defined by !WITH_ARG
> >>   - Add a synchronization point when updating ftrace_call_dest (Bj=C3=
=B6rn)
> >> ---
> >>   arch/riscv/include/asm/ftrace.h |  49 ++++++------
> >>   arch/riscv/kernel/ftrace.c      | 130 ++++++++++++++++--------------=
--
> >>   arch/riscv/kernel/mcount-dyn.S  |   9 +--
> >>   3 files changed, 92 insertions(+), 96 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/ftrace.h
> >> b/arch/riscv/include/asm/ftrace.h
> >> index d8b2138bd9c6..6a5c0a7fb826 100644
> >> --- a/arch/riscv/include/asm/ftrace.h
> >> +++ b/arch/riscv/include/asm/ftrace.h
> >> @@ -20,10 +20,9 @@ extern void *return_address(unsigned int level);
> >>   #define ftrace_return_address(n) return_address(n)
> >>     void _mcount(void);
> >> -static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >> -{
> >> -    return addr;
> >> -}
> >> +unsigned long ftrace_call_adjust(unsigned long addr);
> >> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip);
> >> +#define ftrace_get_symaddr(fentry_ip)
> >> arch_ftrace_get_symaddr(fentry_ip)
> >>     /*
> >>    * Let's do like x86/arm64 and ignore the compat syscalls.
> >> @@ -57,12 +56,21 @@ struct dyn_arch_ftrace {
> >>    * 2) jalr: setting low-12 offset to ra, jump to ra, and set ra to
> >>    *          return address (original pc + 4)
> >>    *
> >> + * The first 2 instructions for each tracable function is compiled
> >> to 2 nop
> >> + * instructions. Then, the kernel initializes the first instruction
> >> to auipc at
> >> + * boot time (<ftrace disable>). The second instruction is patched
> >> to jalr to
> >> + * start the trace.
> >> + *
> >> + *<Image>:
> >> + * 0: nop
> >> + * 4: nop
> >> + *
> >>    *<ftrace enable>:
> >> - * 0: auipc  t0/ra, 0x?
> >> - * 4: jalr   t0/ra, ?(t0/ra)
> >> + * 0: auipc  t0, 0x?
> >> + * 4: jalr   t0, ?(t0)
> >>    *
> >>    *<ftrace disable>:
> >> - * 0: nop
> >> + * 0: auipc  t0, 0x?
> >>    * 4: nop
> >>    *
> >>    * Dynamic ftrace generates probes to call sites, so we must deal wi=
th
> >> @@ -75,10 +83,9 @@ struct dyn_arch_ftrace {
> >>   #define AUIPC_OFFSET_MASK    (0xfffff000)
> >>   #define AUIPC_PAD        (0x00001000)
> >>   #define JALR_SHIFT        20
> >> -#define JALR_RA            (0x000080e7)
> >> -#define AUIPC_RA        (0x00000097)
> >>   #define JALR_T0            (0x000282e7)
> >>   #define AUIPC_T0        (0x00000297)
> >> +#define JALR_RANGE        (JALR_SIGN_MASK - 1)
> >>     #define to_jalr_t0(offset)                        \
> >>       (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
> >> @@ -96,26 +103,14 @@ do {                                    \
> >>       call[1] =3D to_jalr_t0(offset);                    \
> >>   } while (0)
> >>   -#define to_jalr_ra(offset)                        \
> >> -    (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_RA)
> >> -
> >> -#define to_auipc_ra(offset)                        \
> >> -    ((offset & JALR_SIGN_MASK) ?                    \
> >> -    (((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_RA) :    \
> >> -    ((offset & AUIPC_OFFSET_MASK) | AUIPC_RA))
> >> -
> >> -#define make_call_ra(caller, callee, call)                \
> >> -do {                                    \
> >> -    unsigned int offset =3D                        \
> >> -        (unsigned long) (callee) - (unsigned long) (caller); \
> >> -    call[0] =3D to_auipc_ra(offset);                    \
> >> -    call[1] =3D to_jalr_ra(offset);                    \
> >> -} while (0)
> >> -
> >>   /*
> >> - * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes
> >> here.
> >> + * Only the jalr insn in the auipc+jalr is patched, so we make it 4
> >> + * bytes here.
> >>    */
> >> -#define MCOUNT_INSN_SIZE 8
> >> +#define MCOUNT_INSN_SIZE    4
> >> +#define MCOUNT_AUIPC_SIZE    4
> >> +#define MCOUNT_JALR_SIZE    4
> >> +#define MCOUNT_NOP4_SIZE    4
> >>     #ifndef __ASSEMBLY__
> >>   struct dyn_ftrace;
> >> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> >> index 1fd10555c580..cf78eef073a0 100644
> >> --- a/arch/riscv/kernel/ftrace.c
> >> +++ b/arch/riscv/kernel/ftrace.c
> >> @@ -8,10 +8,21 @@
> >>   #include <linux/ftrace.h>
> >>   #include <linux/uaccess.h>
> >>   #include <linux/memory.h>
> >> +#include <linux/irqflags.h>
> >>   #include <linux/stop_machine.h>
> >>   #include <asm/cacheflush.h>
> >>   #include <asm/text-patching.h>
> >>   +unsigned long ftrace_call_adjust(unsigned long addr)
> >> +{
> >> +    return addr + MCOUNT_AUIPC_SIZE;
> >> +}
> >> +
> >> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> >> +{
> >> +    return fentry_ip - MCOUNT_AUIPC_SIZE;
> >> +}
> >> +
> >
> >
> > Those functions cause the following errors when building with
> > !CONFIG_DYNAMIC_FTRACE, but I'm not sure how to fix this:
> >
> > ../arch/riscv/kernel/ftrace.c: In function 'ftrace_call_adjust':
> > ../arch/riscv/kernel/ftrace.c:19:35: error: 'MCOUNT_AUIPC_SIZE'
> > undeclared (first use in this function)
> >    19 |                 return addr + 8 + MCOUNT_AUIPC_SIZE;
> >       |                                   ^~~~~~~~~~~~~~~~~
> > ../arch/riscv/kernel/ftrace.c:19:35: note: each undeclared identifier
> > is reported only once for each function it appears in
> >   CC      fs/9p/vfs_dir.o
> > ../arch/riscv/kernel/ftrace.c: In function 'arch_ftrace_get_symaddr':
> > ../arch/riscv/kernel/ftrace.c:26:28: error: 'MCOUNT_AUIPC_SIZE'
> > undeclared (first use in this function)
> >    26 |         return fentry_ip - MCOUNT_AUIPC_SIZE;
> >       |                            ^~~~~~~~~~~~~~~~~
> >   CC      drivers/pci/pcie/pme.o
> > ../arch/riscv/kernel/ftrace.c: In function 'ftrace_call_adjust':
> > ../arch/riscv/kernel/ftrace.c:22:1: error: control reaches end of
> > non-void function [-Werror=3Dreturn-type]
> >    22 | }
> >       | ^
> > ../arch/riscv/kernel/ftrace.c: In function 'arch_ftrace_get_symaddr':
> > ../arch/riscv/kernel/ftrace.c:27:1: error: control reaches end of
> > non-void function [-Werror=3Dreturn-type]
> >    27 | }
> >       | ^
> > cc1: some warnings being treated as errors
> > make[5]: *** [../scripts/Makefile.build:203:
> > arch/riscv/kernel/ftrace.o] Error 1
> >
>
> So I fixed those errors with the following, let me know if that's not
> correct:
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index d65f06bfb4573..4c6c24380cfd9 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -13,6 +13,7 @@
>   #include <asm/cacheflush.h>
>   #include <asm/text-patching.h>
>
> +#ifdef CONFIG_DYNAMIC_FTRACE
>   unsigned long ftrace_call_adjust(unsigned long addr)
>   {
>          if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> @@ -26,7 +27,6 @@ unsigned long arch_ftrace_get_symaddr(unsigned long
> fentry_ip)
>          return fentry_ip - MCOUNT_AUIPC_SIZE;
>   }
>
> -#ifdef CONFIG_DYNAMIC_FTRACE
>   void arch_ftrace_update_code(int command)
>   {
>          mutex_lock(&text_mutex);
> @@ -191,7 +191,12 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>          return 0;
>   }
>
> -#endif
> +#else /* CONFIG_DYNAMIC_FTRACE */
> +unsigned long ftrace_call_adjust(unsigned long addr)
> +{
> +       return addr;
> +}
> +#endif /* CONFIG_DYNAMIC_FTRACE */
>
>   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>   int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>

Hi Alex,

Yes, this is valid, thanks for noticing and fixing the error. I would
personally prefer leaving the #else /* CONFIG_DYNAMIC_FTRACE */ part
in ftrace.h, but it can also come later as a refactor. Or, I can
respin the series, with fixes on this and the previous patch, along
with some typos and variable declarations that Robin mentioned.

Thanks,
Andy
