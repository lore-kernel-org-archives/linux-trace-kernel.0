Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2C209F43
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114544; cv=pass; b=gMTVS6ffdv5rXbOf+IF9b719i+BGJWBX6UiW7kpSXMcwaq3JKkuzyaPTNfHiE1gbe4t2nEFVF0wq7f9QDhrrPBDXlkujYrU1YX9WTYjslpxRcw+2bCZu+6sWNXs+gexakMoJAuroK9TwNl82vgWdQKFsp5j3fm2WZJUYvmPER8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114544; c=relaxed/simple;
	bh=7sPyy8cC8UyRtjCg/DQlQqazKm29Om0ms69W0GvgSpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZRCjfPcVr66J41rN4fEu3XHUEPsgq2LI4L0A1FIhQWsLPxDul8oOGqo7iPbCiSl1Zvxz7bvqx75/8DYHgIANSq0mVzTFmRwk9F5ch+ZxkUhnsYGxA4PB82Tj0rRDFLGibiSqFLGmaSWKqAP55ZYT09H9/n5ITrMMo+lLDZ0JFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhomfRnR; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhomfRnR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf55c39e16so734285ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 11:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781114543; cv=none;
        d=google.com; s=arc-20240605;
        b=Dw7O6XLxTG8dCPCE8+NH2kht5EZg0GB1Q5Ti7V/UfRKi7mTFFFRpDRVRnAKZpoe4ub
         0uHatk4SqPKNYN7R9zUOlznHGJz4bPCPa57DZr6xw7rhS3gvjLkmDHt+V4813oteL5Cp
         PVbhUHngwKo5LJFwN65DKyqraiTEUiIdTe1Vl/BUxMBmiPpE3vIOJnlUHQM2K0D1I9WP
         U5j39i2SaFdKdD2wMpOcvWudHxWpkVIWg/t8ghoHHEiITpn342iddDiGrJD1hidYNwHJ
         ADsESSqUl1Ze7UfE5Q4/pnHMqtcXJ+t2Gc8UOcu6fuGKk9YCYytvDF1okTGEBe9XNDsJ
         TtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pJnlJlQ30WFBCS0cKwVCZOuVVwwvVHiS/1leOhv1Elc=;
        fh=+wDxK2RVTqwy+PE5anuoqXN8RDkPPPI0i//s1G+mLZQ=;
        b=ARxLoLyac/EtpaodjEjQqg0nXDgk80IlKTTpd78X6OHNSo8Donye0ostZ8FcswaVlB
         twi+MfKZqltWCJWi4fzgf2EpUHNCF2JamDIyDvwLdld8p8T9YNOuePpEFco6QGvLBPXT
         ZfC0ctkUFPX+1RS3A4+8qMZjwksdgl/QVBZu0Q/NIzBNXoE05TYmp/hyTh/EdmJD22zN
         DjxHTdHl4cYmkK9FtSeOgY3cpbOLTL/EXoptiUiCApeI5lzF+cwMHSUVdYuqIVwOeocG
         GJH9R2y4nyCSEKJz29N+wNojJWS9pJtiG+sARVpGd3FCm4fBPXLInsPu8JEaKcFtho4v
         1gWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114543; x=1781719343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJnlJlQ30WFBCS0cKwVCZOuVVwwvVHiS/1leOhv1Elc=;
        b=OhomfRnRKWUnwQcfWfYOWPV5A1Ar+WA0qRrzKd1XhXyxyPsI/AARf4h0/JUF1Tg2L7
         kGcz/TgjsmCDUveYQxXnuIWhgjNqo5QutPKHF6/wXgTo6EJwM4Mug6FYPe0PzOrjZkXk
         1SegtEsZqevXTzqmdCrK+DwwNhVqwhaiYz9TX3DJW1RzFgXb3YlCg7HLZ9GBIcuSLE34
         VgOil3Cwoo/jr+yrJLpXn4P1xt2aMLa6AMgqO7ydmKDo2T3/6EHCRpj28ssQ0My4C6Q+
         3GF0eSrVWL9VajCSp3QN5k1/pmM5fn1Hcms1pDKALiGr4SqkGX3k+M75y4D1d6sqpeTc
         BHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114543; x=1781719343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJnlJlQ30WFBCS0cKwVCZOuVVwwvVHiS/1leOhv1Elc=;
        b=H74A2mD0W4gEI84FdlGxdWPdFgxwvlrXNwwROpNFjsCqA3sVQUbSDdK/eRayuwvAf+
         KzU0LtasLeHstzYuS44CzID0h86yHVy+amcO/IL5jh7GBhIYGAN+Ee3yu4UD8XLQlHR3
         f1Pfl34qRdnpZSarJpUCM4B/wgR1bVEn5QmzbXc7Fig8wItVxXPF1g6DFp7bsr5j0c+P
         UOVmvcdCaUGZEJORp+tWSyiRxkzfxQfRgk3Z7ESJRvaSDRomW6SfWgi/9nibDI0A0pl/
         4WL+Am5pO/NVe4YUNIf/K45x+aYIN8RuJbwJ4gbAPwsYlXIQViFCY7T0AJpSzTJPgc8q
         //Fw==
X-Forwarded-Encrypted: i=1; AFNElJ+TQb/kxQsM3EIiXLMSo2rsaW0XirhL15gCDHTbgVGlpEss1YdGubCKUzf6gbA+wmTCmhHaWCVWy7Ye+yqrJjEpuPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqncVxWirABd2M+XxvbzhiNhyi19lMaxq7pyzWaRrdanXgyiHV
	1RRNQ/BmXXPu4kt2LXYWxzBrTgFD9dABqO54I6tDMcYZpf4/7Kj3oMUbkgSqKBPC4aifzvXY2+M
	1txOenBZc5KGkVfFt1AozMZXFS/zFFRk=
X-Gm-Gg: Acq92OGi/DHoKXzNYcy/5oEP8nIZKXT8UJHUWeUcfUlkiKCsHVJxL61UjafiaTxiA9a
	U5C8T7r0TkY8xap0XfrN+cemqF7dVBlUMkQBSW+mPDYR+SIh+bKLm4SYwCwvlVOBIZDb/b4Ae0k
	tZbnOwn2Pcrkcoc+pSpU1Ua1/yf0qZYDZDR4vJAxZ+sI2ciV/IjUj6k6zjePoVcNt7l5Wqknrzv
	YnZPjgchET1fnEX+jl9habYM7yJh4isz74FgisVlxAC5f+MB6S5ZlLw07ChcCW17afbY6ANVKAU
	HHWCK2dSH3z2Ga4/1ogEE655N8bU/pjzZHg3N7bJ3MSDIOhLvsftxJ8zcRP8eqsF5ykzgAtWz3k
	7u310BE1MHIV/6sM=
X-Received: by 2002:a17:902:d2c7:b0:2bf:13af:b077 with SMTP id
 d9443c01a7336-2c1ec9290abmr225113575ad.14.1781114542545; Wed, 10 Jun 2026
 11:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205840.173790-1-jolsa@kernel.org> <20260526205840.173790-6-jolsa@kernel.org>
 <CAEf4BzZiFUeFa4fdghuSGpqiEzyvJVxs6TDgJd5U4hSj--imiQ@mail.gmail.com>
 <aif8jkUPst-tTskE@krava> <CAEf4BzbsB-PRZRqkz37YK5wYNR=ajZv2N7tEznpZM0rdyYC_xA@mail.gmail.com>
 <aikd6-5HYhCnc0Ze@krava>
In-Reply-To: <aikd6-5HYhCnc0Ze@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jun 2026 11:02:08 -0700
X-Gm-Features: AVVi8CdywaZzLDzIOPnc2LK8GWSXgj_KSvmGO8TWO4azabbUqslamAUKZwWVs_g
Message-ID: <CAEf4BzaJhjQiqbs6bh9zdjRzjySLJ0qccpiRk7yhdxUC-BvfUQ@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 1:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Jun 09, 2026 at 09:43:15AM -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 9, 2026 at 4:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Mon, Jun 08, 2026 at 01:46:39PM -0700, Andrii Nakryiko wrote:
> > > > On Tue, May 26, 2026 at 1:59=E2=80=AFPM Jiri Olsa <jolsa@kernel.org=
> wrote:
> > > > >
> > > > > Andrii reported an issue with optimized uprobes [1] that can clob=
ber
> > > > > redzone area with call instruction storing return address on stac=
k
> > > > > where user code may keep temporary data without adjusting rsp.
> > > > >
> > > > > Fixing this by moving the optimized uprobes on top of 10-bytes no=
p
> > > > > instruction, so we can squeeze another instruction to escape the
> > > > > redzone area before doing the call, like:
> > > > >
> > > > >   lea -0x80(%rsp), %rsp
> > > > >   call tramp
> > > > >
> > > > > Note the lea instruction is used to adjust the rsp register witho=
ut
> > > > > changing the flags.
> > > > >
> > > > > We use nop10 and following transformation to optimized instructio=
ns
> > > > > above and back as suggested by Peterz [2].
> > > > >
> > > > > Optimize path (int3_update_optimize):
> > > > >
> > > > >   1) Initial state after set_swbp() installed the uprobe:
> > > > >       cc 2e 0f 1f 84 00 00 00 00 00
> > > > >
> > > > >      From offset 0 this is INT3 followed by the tail of the origi=
nal
> > > > >      10-byte NOP.
> > > > >
> > > > >      After a previous unoptimization bytes 5..9 may still contain=
 the
> > > > >      old call instruction, which remains valid for threads alread=
y there.
> > > > >
> > > > >   2) Rewrite the LEA tail and call displacement:
> > > > >       cc [8d 64 24 80 e8 d0 d1 d2 d3]
> > > > >
> > > > >      From offset 0 this traps on the uprobe INT3.  Bytes 1..9 are=
 not
> > > > >      executable entry points while byte 0 is trapped.
> > > > >
> > > > >   3) Publish the first LEA byte:
> > > > >       [48] 8d 64 24 80 e8 d0 d1 d2 d3
> > > > >
> > > > >      From offset 0 this is:
> > > > >         lea -0x80(%rsp), %rsp
> > > > >         call <uprobe-trampoline>
> > > > >
> > > > > Unoptimize path (int3_update_unoptimize):
> > > > >
> > > > >   1) Initial optimized state:
> > > > >       48 8d 64 24 80 e8 d0 d1 d2 d3
> > > > >      Same as 3) above.
> > > > >
> > > > >   2) Trap new entries before restoring the NOP bytes:
> > > > >       [cc] 8d 64 24 80 e8 d0 d1 d2 d3
> > > > >
> > > > >      From offset 0 this traps. A thread that had already executed=
 the
> > > > >      LEA can still reach the intact CALL at offset 5.
> > > > >
> > > > >   3) Restore bytes 1..4 of the original NOP while keeping byte 0 =
trapped
> > > > >      and byte 5 as CALL.
> > > > >       cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > > > >
> > > > >      From offset 0 this still traps. Offset 5 is still the CALL f=
or any
> > > > >      thread that was already past the first LEA byte.
> > > > >
> > > > >   4) Publish the first byte of the original NOP:
> > > > >       [66] 2e 0f 1f 84 e8 d0 d1 d2 d3
> > > > >
> > > > >      From offset 0 this is the restored 10-byte NOP; the CALL opc=
ode and
> > > > >      displacement are now only NOP operands.  Offset 5 still deco=
des as
> > > > >      CALL for a thread that was already there.
> > > > >
> > > > >      Tthere is only a single target uprobe-trampoline for the giv=
en nop10
> > > > >      instruction address, so the CALL instruction will not be cha=
nged across
> > > > >      unoptimization/optimization cycles.
> > > > >      Therefore, any task that is preempted at the CALL instructio=
n is guaranteed
> > > > >      to observe that CALL and not anything else.
> > > > >
> > > > > Note as explained in [2] we need to use following nop10:
> > > > >        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> > > > > NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00=
 -- cs nopw 0x00000000(%rax,%rax,1)
> > > > >
> > > > > which means we need to allow 0x2e prefix which maps to INAT_PFX_C=
S
> > > > > attribute in is_prefix_bad function.
> > > > >
> > > > > Also changing the uprobe syscall error when called out of uprobe
> > > > > trampoline to -EPROTO, so we are able to detect the fixed kernel.
> > > > >
> > > > > The optimized uprobe performance stays the same:
> > > > >
> > > > >         uprobe-nop     :    3.129 =C2=B1 0.013M/s
> > > > >         uprobe-push    :    3.045 =C2=B1 0.006M/s
> > > > >         uprobe-ret     :    1.095 =C2=B1 0.004M/s
> > > > >   -->   uprobe-nop10   :    7.170 =C2=B1 0.020M/s
> > > > >         uretprobe-nop  :    2.143 =C2=B1 0.021M/s
> > > > >         uretprobe-push :    2.090 =C2=B1 0.000M/s
> > > > >         uretprobe-ret  :    0.942 =C2=B1 0.000M/s
> > > > >   -->   uretprobe-nop10:    3.381 =C2=B1 0.003M/s
> > > > >         usdt-nop       :    3.245 =C2=B1 0.004M/s
> > > > >   -->   usdt-nop10     :    7.256 =C2=B1 0.023M/s
> > > > >
> > > > > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@ke=
rnel.org/
> > > > > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.pr=
ogramming.kicks-ass.net/#t
> > > > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andri=
i@kernel.org/
> > > > > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobe=
s")
> > > > > Assisted-by: Codex:GPT-5.5
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  arch/x86/kernel/uprobes.c | 255 ++++++++++++++++++++++++++++----=
------
> > > > >  1 file changed, 190 insertions(+), 65 deletions(-)
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > @@ -943,13 +1026,31 @@ static int int3_update(struct arch_uprobe =
*auprobe, struct vm_area_struct *vma,
> > > > >         smp_text_poke_sync_each_cpu();
> > > > >
> > > > >         /*
> > > > > -        * Write first byte.
> > > > > +        * 3) Restore bytes 1..4 of the original NOP while keepin=
g byte 0 trapped
> > > > > +        *    and byte 5 as CALL:
> > > > > +        *    cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > > > > +        */
> > > > > +       ctx.expect =3D EXPECT_SWBP_OPTIMIZED;
> > > > > +       err =3D uprobe_write(auprobe, vma, vaddr + 1, insn + 1,
> > > > > +                          LEA_INSN_SIZE - 1, verify_insn,
> > > > > +                          true /* is_register */, false /* do_up=
date_ref_ctr */,
> > > >
> > > > tbh, it's quite subtle and non-obvious why is_register should be se=
t
> > > > to true first two times (and especially that is_register and
> > > > do_update_ref_ctr are implicitly connected), not sure how to make i=
t
> > > > cleaner, but maybe leave a short comment explaining this twice
> > > > register, once unregister sequence?
> > >
> > > ok, I came up with comment below
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > index de544516ea70..92449f34c005 100644
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -1011,6 +1011,12 @@ static int int3_update_unoptimize(struct arch_=
uprobe *auprobe, struct vm_area_st
> > >         int err;
> > >
> > >         /*
> > > +        * Note the first two uprobe_write calls use is_register=3Dtr=
ue, because they
> > > +        * are intermediate patching states while the probe is still =
active.
> >
> > this doesn't really explain why is_register=3Dtrue is the right one. It
> > actually doesn't matter as long as do_update_ref_ctr=3Dtrue, isn't that
> > right? So maybe just to avoid a bit of confusion let's pass
> > is_register=3Dfalse and do_update_ref_ctr=3Dfalse, and in the comment
> > explain as you said that it's intermediate update and we don't want to
> > update refctr just yet until the very last step?
>
> apart from refctr update there's also different way the concerned
> page is managed, IIUC:
>
> with is_register=3Dtrue we force to get exclusive anonymous page for
> the update (or pin the existing one)
>
> with is_register=3Dfalse we try to zap the private anonymous page and
> return the mapping to the original page
>
> there are several comments on this in uprobe_write/__uprobe_write
>
> how about the update below
>
> jirka
>
>
> ---
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index de544516ea70..09f5ff71227c 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1011,6 +1011,16 @@ static int int3_update_unoptimize(struct arch_upro=
be *auprobe, struct vm_area_st
>         int err;
>
>         /*
> +        * Note the first two uprobe_write calls use is_register=3Dtrue, =
because they
> +        * are intermediate patching states while the probe is still acti=
ve, so
> +        * we force the exclusive anonymous page for the update.
> +        * Also we use do_update_ref_ctr=3Dfalse because refctr was alrea=
dy updated by
> +        * the initial int3 install.
> +        *
> +        * The last uprobe_write to nop10 instruction is called with is_r=
egister=3Dfalse
> +        * and do_update_ref_ctr=3Dtrue to trigger the refctr update and =
to instruct
> +        * uprobe_write to zap the anonymous page if it now matches the f=
ile page.
> +        *

lgtm!

>          * 1) Initial optimized state:
>          *    48 8d 64 24 80 e8 d0 d1 d2 d3
>          *
