Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B243E49B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023414; cv=pass; b=LNkhsB5nT6POHO8YgsliQAJdEVXcWEHH+L1k1W+as3mlqy005+MtVrK7dCPVF9MN/7avEX4S5tD4N4K++sPB23gPCpHPsUmNydd0gdOnosc2VB1ETz++Ver3oacUkSAZjFjWygSnCLAfRReWOPTjkQMSI9DocsdwHNkf1Yq2e+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023414; c=relaxed/simple;
	bh=ZeeXnTRW6gn8NEAsuf/mvUB03v1GIsbdVpbXeMyOpNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kysRpmd179CAHirH6aXVNN6u2FDEM2CiXp0jle8GFEycDP97Y7y6AsOiZ/0htySnVaPWPc3sVVpTQrhYJxR0njhmfBumcNBYYg+qwqJ6spllJr0x82HWA2zQXd2NXx4szwSOqpPELgtHRf4kKSFj20K8QwNZ4Czwxi0yMxOLok8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic9PaNR+; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic9PaNR+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf22d29dabso38827855ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 09:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781023412; cv=none;
        d=google.com; s=arc-20240605;
        b=iQ4axymtmBRRxyMSyRcHdXYbpNKrMEk5RGefmeuuswWJtH5vECuB+7xTGUI1Fz9p/a
         KwKJvqw/ssiDUhBKSyrfLKZqBmYeUbqoq1tpZ+DIdXEAknZrlku2oqMgavkqlNB7BAYn
         xx7gi18tEj5JitUQ0TScuWj+mea6u9IANh6CrwUo4iUK2tYfNgEy3YNvkRvRjmz5wQd6
         1ByqgRyB5oG80joj232xWTS6iJ3RCb68Dubud1vGwQS+AHIPt/2fhSiXSuV2gjKErNo/
         88Juym4SwCYeXYmrqNKRcfDwzQJTyoLs9LrpTGKmzP1t9STXSN01vpxFfhhkMVZxsa04
         TfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VAzcYQhG7oyOvuLy1RsuzIzorkNF93A1Ez0XAGpnftY=;
        fh=S3fsju4vjylT/Embz5GybE84ca52eXhpUVQVGrQUxp0=;
        b=Ifyjq7B5fP6RTb/D4rMeKRx4KHbZPJT8ic6IuGhmFniVA8naSq47ieAGMR9XDFJfik
         Vw65gI1giLZfZSZRfE3pgWMwItaJI8/qwu6p7ZmDvuK9wb/EovfQGBb6+evGfr2rCTL0
         kk7D6Ku30c9KOeIWU+clgXa07E7zCSUkvi2Y5G9UCgj0mLspXYfTuosM4UnWqwLcL/MV
         vN2JUPW/VsXppgUeFUORnKzvg3vK/wptL+IWuy6i+0Mzzig0WlJo3xF4oH5nMWSUEZXL
         EEohf2BTXqwvCJ7295GvbAn2JOjVkBNZ3tDYCqxvrg0GLU/d7gISFqUwF6Bk9YrCKvzL
         xxMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023412; x=1781628212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAzcYQhG7oyOvuLy1RsuzIzorkNF93A1Ez0XAGpnftY=;
        b=Ic9PaNR+U7yqLGPOmxMDz/3afyh9PMpmwcROoMGS0M/QgH2OvARkEve7vDutinIMTj
         lHE+NZRWqp04YwTeEBtCr+Y6yDHKBCkvhD/u1HeMuaFSP7hg8mCGOQjAEa26EcKpfp3M
         /5vQKTJ12EwKR94ffKdQatBACfsvwHr0lRygEVLJ88tFhzxSo4VviT24TnMaw/ScRxyO
         820+jijX6hfIVQaFe12ULpej40bcFFcdlEjc2kXCvpx3omCVcFkIenqALMDGPDG6J8qw
         diocl+pL2fhxAgqtOmQJzfde9DgnRLAwunlPlW9xeOl/akENBClsPmaXLnkJ2/4mNOSW
         Qmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023412; x=1781628212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAzcYQhG7oyOvuLy1RsuzIzorkNF93A1Ez0XAGpnftY=;
        b=dHX3nq6nkJky/DXJjnyyF6AACh9GGY1dGHpV70K5106Ga/zTml36pWL+Il0R8rHbFX
         Phk4lCV+zxAffqbWw7fU7a3PXw1Hf+HhvJ4DHFdA71b9iY+W5n09zEX1f/sQPif4d3Ml
         /CSKB+Z+6AEkeL8lV+P9SXzYOBz65o7ujdzeInBusHPGkwlwNOv+Da7XEc+e8GSm41Co
         qMx3se/RF34z4LdvHy7tP6JwzsIWRy0KKgC4LNpfJYrEdeBXWTkvR/5Ic1b72aaU6tsV
         qhCnsP1A4fQ2blERPJeRme+splFywqh9rcheKzzSBBjCIWgG8622TG/khnONr2jzge57
         Im5A==
X-Forwarded-Encrypted: i=1; AFNElJ8BhlBAikvXe/xVQk0GIVUopNtY8GgfEWxlSQbqpkDUJ6aj29LuPkYmVf07rgWqJT3V6sjkqjm6GR1Yy0uAUfYQ8hE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnf/YzJ0KQFsKf9lwe806XRahJPe55VbVjLb4Czplaxck0Qsqo
	kEfVDQAxJ06PXLISqJ5YQnGh9kTTHyxKWKUdpK14rc8xKe1O34UMqYRtDSdyHx3NwZ2ixMH9vBf
	+zHkSec4wuIG6LQ6NXvIqvy2CmV9kzrI=
X-Gm-Gg: Acq92OEKs8Pp37zpU02VMDag7+x66KLDhlv/z4hOhEga7paB0Z+WcuTBNVU1iPf+q7o
	UhbsAGg9wSEoEDzhohAlpITrVlMn/N/TDFnbFikyVQzPzoWXzngqNHjDvx3boDIx+u6n2lb33Hh
	jX0D1d8lpLzMhJdf0IbJVgcEbHNZokFqfXWgCigG/JqcCpW/rvZ2hbh6v7P/pkej8BzUGwHmYgv
	f4ydQbLXhnPexOGmNBUhu+s3GpYsp+yPjXoT8w6ViUpsksri7QudkcIGqjHmP6Jhk1GZynjrk5A
	4fMFPiHC5WMtqckwbgcqru/DuHxvSGYFIjXEbzxBhsF1zELFtD+QGFVfM6hOos4XuJ4RK7qPxYD
	q9nhJ/jbVjav4iVU=
X-Received: by 2002:a17:903:1acb:b0:2c0:ccdb:e02c with SMTP id
 d9443c01a7336-2c2a1baf93fmr49184375ad.7.1781023412021; Tue, 09 Jun 2026
 09:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205840.173790-1-jolsa@kernel.org> <20260526205840.173790-6-jolsa@kernel.org>
 <CAEf4BzZiFUeFa4fdghuSGpqiEzyvJVxs6TDgJd5U4hSj--imiQ@mail.gmail.com> <aif8jkUPst-tTskE@krava>
In-Reply-To: <aif8jkUPst-tTskE@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jun 2026 09:43:15 -0700
X-Gm-Features: AVVi8CcxU0GCPRZ75YMUdnjcLSr_MdbLTt88syLtDsUgv9esYUAaAZ68vqS0Nr0
Message-ID: <CAEf4BzbsB-PRZRqkz37YK5wYNR=ajZv2N7tEznpZM0rdyYC_xA@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 4:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Jun 08, 2026 at 01:46:39PM -0700, Andrii Nakryiko wrote:
> > On Tue, May 26, 2026 at 1:59=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Andrii reported an issue with optimized uprobes [1] that can clobber
> > > redzone area with call instruction storing return address on stack
> > > where user code may keep temporary data without adjusting rsp.
> > >
> > > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > > instruction, so we can squeeze another instruction to escape the
> > > redzone area before doing the call, like:
> > >
> > >   lea -0x80(%rsp), %rsp
> > >   call tramp
> > >
> > > Note the lea instruction is used to adjust the rsp register without
> > > changing the flags.
> > >
> > > We use nop10 and following transformation to optimized instructions
> > > above and back as suggested by Peterz [2].
> > >
> > > Optimize path (int3_update_optimize):
> > >
> > >   1) Initial state after set_swbp() installed the uprobe:
> > >       cc 2e 0f 1f 84 00 00 00 00 00
> > >
> > >      From offset 0 this is INT3 followed by the tail of the original
> > >      10-byte NOP.
> > >
> > >      After a previous unoptimization bytes 5..9 may still contain the
> > >      old call instruction, which remains valid for threads already th=
ere.
> > >
> > >   2) Rewrite the LEA tail and call displacement:
> > >       cc [8d 64 24 80 e8 d0 d1 d2 d3]
> > >
> > >      From offset 0 this traps on the uprobe INT3.  Bytes 1..9 are not
> > >      executable entry points while byte 0 is trapped.
> > >
> > >   3) Publish the first LEA byte:
> > >       [48] 8d 64 24 80 e8 d0 d1 d2 d3
> > >
> > >      From offset 0 this is:
> > >         lea -0x80(%rsp), %rsp
> > >         call <uprobe-trampoline>
> > >
> > > Unoptimize path (int3_update_unoptimize):
> > >
> > >   1) Initial optimized state:
> > >       48 8d 64 24 80 e8 d0 d1 d2 d3
> > >      Same as 3) above.
> > >
> > >   2) Trap new entries before restoring the NOP bytes:
> > >       [cc] 8d 64 24 80 e8 d0 d1 d2 d3
> > >
> > >      From offset 0 this traps. A thread that had already executed the
> > >      LEA can still reach the intact CALL at offset 5.
> > >
> > >   3) Restore bytes 1..4 of the original NOP while keeping byte 0 trap=
ped
> > >      and byte 5 as CALL.
> > >       cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > >
> > >      From offset 0 this still traps. Offset 5 is still the CALL for a=
ny
> > >      thread that was already past the first LEA byte.
> > >
> > >   4) Publish the first byte of the original NOP:
> > >       [66] 2e 0f 1f 84 e8 d0 d1 d2 d3
> > >
> > >      From offset 0 this is the restored 10-byte NOP; the CALL opcode =
and
> > >      displacement are now only NOP operands.  Offset 5 still decodes =
as
> > >      CALL for a thread that was already there.
> > >
> > >      Tthere is only a single target uprobe-trampoline for the given n=
op10
> > >      instruction address, so the CALL instruction will not be changed=
 across
> > >      unoptimization/optimization cycles.
> > >      Therefore, any task that is preempted at the CALL instruction is=
 guaranteed
> > >      to observe that CALL and not anything else.
> > >
> > > Note as explained in [2] we need to use following nop10:
> > >        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> > > NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- =
cs nopw 0x00000000(%rax,%rax,1)
> > >
> > > which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> > > attribute in is_prefix_bad function.
> > >
> > > Also changing the uprobe syscall error when called out of uprobe
> > > trampoline to -EPROTO, so we are able to detect the fixed kernel.
> > >
> > > The optimized uprobe performance stays the same:
> > >
> > >         uprobe-nop     :    3.129 =C2=B1 0.013M/s
> > >         uprobe-push    :    3.045 =C2=B1 0.006M/s
> > >         uprobe-ret     :    1.095 =C2=B1 0.004M/s
> > >   -->   uprobe-nop10   :    7.170 =C2=B1 0.020M/s
> > >         uretprobe-nop  :    2.143 =C2=B1 0.021M/s
> > >         uretprobe-push :    2.090 =C2=B1 0.000M/s
> > >         uretprobe-ret  :    0.942 =C2=B1 0.000M/s
> > >   -->   uretprobe-nop10:    3.381 =C2=B1 0.003M/s
> > >         usdt-nop       :    3.245 =C2=B1 0.004M/s
> > >   -->   usdt-nop10     :    7.256 =C2=B1 0.023M/s
> > >
> > > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel=
.org/
> > > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.progra=
mming.kicks-ass.net/#t
> > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@ke=
rnel.org/
> > > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > > Assisted-by: Codex:GPT-5.5
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  arch/x86/kernel/uprobes.c | 255 ++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 190 insertions(+), 65 deletions(-)
> > >
> >
> > [...]
> >
> > > @@ -943,13 +1026,31 @@ static int int3_update(struct arch_uprobe *aup=
robe, struct vm_area_struct *vma,
> > >         smp_text_poke_sync_each_cpu();
> > >
> > >         /*
> > > -        * Write first byte.
> > > +        * 3) Restore bytes 1..4 of the original NOP while keeping by=
te 0 trapped
> > > +        *    and byte 5 as CALL:
> > > +        *    cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > > +        */
> > > +       ctx.expect =3D EXPECT_SWBP_OPTIMIZED;
> > > +       err =3D uprobe_write(auprobe, vma, vaddr + 1, insn + 1,
> > > +                          LEA_INSN_SIZE - 1, verify_insn,
> > > +                          true /* is_register */, false /* do_update=
_ref_ctr */,
> >
> > tbh, it's quite subtle and non-obvious why is_register should be set
> > to true first two times (and especially that is_register and
> > do_update_ref_ctr are implicitly connected), not sure how to make it
> > cleaner, but maybe leave a short comment explaining this twice
> > register, once unregister sequence?
>
> ok, I came up with comment below
>
> thanks,
> jirka
>
>
> ---
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index de544516ea70..92449f34c005 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1011,6 +1011,12 @@ static int int3_update_unoptimize(struct arch_upro=
be *auprobe, struct vm_area_st
>         int err;
>
>         /*
> +        * Note the first two uprobe_write calls use is_register=3Dtrue, =
because they
> +        * are intermediate patching states while the probe is still acti=
ve.

this doesn't really explain why is_register=3Dtrue is the right one. It
actually doesn't matter as long as do_update_ref_ctr=3Dtrue, isn't that
right? So maybe just to avoid a bit of confusion let's pass
is_register=3Dfalse and do_update_ref_ctr=3Dfalse, and in the comment
explain as you said that it's intermediate update and we don't want to
update refctr just yet until the very last step?

> +        *
> +        * The last uprobe_write to nop10 instruction is called with is_r=
egister=3Dfalse
> +        * and do_update_ref_ctr=3Dtrue to trigger the refctr update.
> +        *
>          * 1) Initial optimized state:
>          *    48 8d 64 24 80 e8 d0 d1 d2 d3
>          *
