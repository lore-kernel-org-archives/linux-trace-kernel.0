Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10D19FA8D;
	Thu,  6 Feb 2025 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866015; cv=none; b=A9olNL2x1/eooj6JV614ifgXVMlSsNhTEEhkVcwCirywpe+BANsQWHge+Wtidcn5zdQch3sUiV864XoHJQfoDrKZtk4xgr6VQ8KRFLU93N/YDK3vIwSMoDyDtVMF50BF+SrlNsOeANvc9YzwA3PRl0iVoQQ6ScjvQdgZEigYaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866015; c=relaxed/simple;
	bh=7xGc49hCcHJZCMN59E//NooAH7ZW/6S1zhGVCmh/4iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFc5wynA32WaVoJ6aLzrSHG9uunwQTpGR5Nzi3IkOBEvsztc+VDwv+BDpkaxYBqXmWs08Pq5/vDT1FtFJnuTRsydMHJ1Irz3fyuSbsZ3lLIjJG86kOkhnF3U/KZLwmnaByXL97J/VUPWGNWvKG2ZX8XLHlsw2tkoURUaGWk/DaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKDHSTS+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKDHSTS+"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7157cf352so454575766b.0;
        Thu, 06 Feb 2025 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738866011; x=1739470811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNEi0kknlIjpUum1uoPVYlcdsr42AMJVcKjCrYsKSL0=;
        b=YKDHSTS+Tp0Id/BDvaxQiNqc4ar/8NvOPtkHqox+IIkRacmc9uRdgd9fWl76S5w/Vf
         jCbaLXooR1fXPYwOjGtiRdOx9Ho6vpQFAPN4Tmc3o7CPkoMivh3ddf889ndFED667ajZ
         1HwSehhWy+yIthwFnTCxzm3cCk+KodCitpqWGwS51O2Oxf2e/2X4z/29eAfPE23pB7Y+
         GXhGsmUlZ2sZxfgmWhIjG6ffolN15r0z1FCIX2djT52LtzKZBJDUfyyugUuBFowCFUbE
         D5wuVCw+/EY2lpL6Id3v0O/0XfNSQHB4q0XtQWwMCd6Il9f51CvXAOSoNIpvmymg1zlh
         sj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738866011; x=1739470811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNEi0kknlIjpUum1uoPVYlcdsr42AMJVcKjCrYsKSL0=;
        b=c8hczAmdiQDm4YhlUj2QrSjx1fb0HTz3W2CK6nPuU7ae2JFvOIksy2ucXyEhh6jGk/
         F7sA0iruA5GTxDhjo+Mh4hJPzu3cVbJklvzfsrJCSP0qmM12cNsDOwTLpKZde5Cl1tUH
         OOO3NT10HYif3lYu4GRjX24pDpjp4JyVYKq8+Cx8V/NIpPchpUtd3OoSSGQC4BQfCmjS
         dz1Lwd6rWpk34PcVtyBpUffMIOeqB69SfXRL2MmwSw3pGhHkXtsYtR3m6miY9tvVghhN
         /Dr4/hauhVdqV9rdFdxw+36u5fQbxyWZlHfrF9LIt4g0G5ZrTwHxWMrbYt4yiG8dN4Ni
         kyKg==
X-Forwarded-Encrypted: i=1; AJvYcCVAJyYaXXDAv3v/jcamDaQ5+w9eOHJJDljtpjcp4vAWTUkijne7/3PH2lAD4Qo4910BuSlHyEKWFlE1rl66iaiJj4hA@vger.kernel.org, AJvYcCXT/eHdH0jXKFWfvZ3grEwDCvUXcKsMsNDrnoHHB1uHi5oI01CdXnk3OYAM9bRRr5ZwNuc801r4hZtkK3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8goztwvYptIzTUygq6PYupXSky+o/rauWwibi5nBVho4w8hS
	xvI10w71CjCY/T84QZ/mXM5DDSTyBjniGsf/eBbt73PznECjKvZ4oKTZ4TQYvoDbzNhPaaVsHyZ
	hrBjTPj1i5osLghmVw8/x6GY/Cc4=
X-Gm-Gg: ASbGncuoaBQT/HASaeoI6flaYVsa2vy4RjG9usNkBFqiJlqp6p07R1UmzndqtMWmGjF
	r7o/7NW0vs6qWeWODKYO+un2gBE4eh33r9OnsS96q+ZwqUhApeGd2lYsWX52h/L2T6tZxP8jBG4
	nzQFHmaiUHZ6INZiHfuRoPeYquLw8=
X-Google-Smtp-Source: AGHT+IH0zOqsMJfbAGW7RIBKq/bHcuItMk/Hpd9Z0DEoPzQJLzkikiCPZ9hu9xh24sTJVpiZzgqLDfxTZ2hcolOJz4o=
X-Received: by 2002:a17:907:3f22:b0:ab7:5983:13b5 with SMTP id
 a640c23a62f3a-ab76e8e9017mr483401566b.20.1738866011273; Thu, 06 Feb 2025
 10:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
In-Reply-To: <173881156244.211648.1242168038709680511.stgit@devnote2>
From: Gabriel de Perthuis <g2p.code@gmail.com>
Date: Thu, 6 Feb 2025 19:19:33 +0100
X-Gm-Features: AWEUYZlWm6WvivHpQ9sKTR6x9MaTGCkLmLGJFxAPYpqPxRCl1X4z3C_99JN6be4
Message-ID: <CAFEugPfsYVfHroc7W7PHjnRbs+KRj53AaCgeQHZediSoYm6E8g@mail.gmail.com>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about get_kernel_nofault()
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Haiyue Wang <haiyuewa@163.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
I can confirm this solves the build issue alongside gendwarfksyms;
much appreciated.

Le jeu. 6 f=C3=A9vr. 2025 =C3=A0 04:12, Masami Hiramatsu (Google)
<mhiramat@kernel.org> a =C3=A9crit :
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Fix a compile error about get_kernel_nofault() which is defined in the
> linux/uaccess.h. Since asm/ftrace.h is widely used, including
> linux/uaccess.h in asm/ftrace.h caused another error. Thus this
> moves arch_ftrace_get_symaddr() into arch/x86/kernel/ftrace.c.
>
> The original errors look like:
>
> In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
>                  from <stdin>:3:
> ./arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_get_symaddr':
> ./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of fun=
ction 'get_kernel_nofault' [-Werror=3Dimplicit-function-declaration]
>    46 |                 if (get_kernel_nofault(instr, (u32 *)(fentry_ip -=
 ENDBR_INSN_SIZE)))
>       |                     ^~~~~~~~~~~~~~~~~~
>
> This also makes ftrace_get_symaddr() available only when
> CONFIG_HAVE_FENTRY=3Dy on x86.
>
> Reported-by: Gabriel de Perthuis <g2p.code@gmail.com>
> Closes: https://lore.kernel.org/all/a87f98bf-45b1-4ef5-aa77-02f7e61203f4@=
gmail.com/
> Reported-by: Haiyue Wang <haiyuewa@163.com>
> Closes: https://lore.kernel.org/all/20250205180116.88644-1-haiyuewa@163.c=
om/
> Fixes: 2bc56fdae1ba ("ftrace: Add ftrace_get_symaddr to convert fentry_ip=
 to symaddr")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/x86/include/asm/ftrace.h |   23 ++++-------------------
>  arch/x86/kernel/ftrace.c      |   26 +++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.=
h
> index f9cb4d07df58..1ed08f2de366 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -34,26 +34,11 @@ static inline unsigned long ftrace_call_adjust(unsign=
ed long addr)
>         return addr;
>  }
>
> -static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry=
_ip)
> -{
> -#ifdef CONFIG_X86_KERNEL_IBT
> -       u32 instr;
> -
> -       /* We want to be extra safe in case entry ip is on the page edge,
> -        * but otherwise we need to avoid get_kernel_nofault()'s overhead=
.
> -        */
> -       if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> -               if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_I=
NSN_SIZE)))
> -                       return fentry_ip;
> -       } else {
> -               instr =3D *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> -       }
> -       if (is_endbr(instr))
> -               fentry_ip -=3D ENDBR_INSN_SIZE;
> -#endif
> -       return fentry_ip;
> -}
> +/* This does not support mcount. */
> +#ifdef CONFIG_HAVE_FENTRY
> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip);
>  #define ftrace_get_symaddr(fentry_ip)  arch_ftrace_get_symaddr(fentry_ip=
)
> +#endif
>
>  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 166bc0ea3bdf..7250118005fc 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -29,11 +29,35 @@
>
>  #include <trace/syscall.h>
>
> -#include <asm/kprobes.h>
>  #include <asm/ftrace.h>
> +#include <asm/ibt.h>
> +#include <asm/kprobes.h>
>  #include <asm/nops.h>
>  #include <asm/text-patching.h>
>
> +#ifdef CONFIG_HAVE_FENTRY
> +/* Convert fentry address to the symbol address. */
> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> +{
> +#ifdef CONFIG_X86_KERNEL_IBT
> +       u32 instr;
> +
> +       /* We want to be extra safe in case entry ip is on the page edge,
> +        * but otherwise we need to avoid get_kernel_nofault()'s overhead=
.
> +        */
> +       if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> +               if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_I=
NSN_SIZE)))
> +                       return fentry_ip;
> +       } else {
> +               instr =3D *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> +       }
> +       if (is_endbr(instr))
> +               fentry_ip -=3D ENDBR_INSN_SIZE;
> +#endif
> +       return fentry_ip;
> +}
> +#endif
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>
>  static int ftrace_poke_late =3D 0;
>
