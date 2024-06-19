Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE794224D2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768425; cv=none; b=VJvxjY3NMqN1QN7DkMCv4NX6Ty4mV46bXtarRsCfsR5Un/iFguLIoJmTyQYCUx/4wIF+FL+X+1MLutv8Yico8dQQ8WEnvwHmCnqXbiIuVWWDpsI4KEMANHk3K8uli8zmKOQnXGyjCa0K0hIkb/TjDO2XWWzKZXvmjQk1wx504Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768425; c=relaxed/simple;
	bh=W0qX1firUtWHRYX/P6AUsb1Bq/tAev6Bu6nihu+dEGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPoMGs7A+LVJ7gcC9xqK2hS7ghEm9X+BHtdX6NsrCVJ+Shozid8Jc10pm+jgW2tbi5HJYfw6fI4SsA57XwNj/vPxYAdNfSjR4y7C0mFsWpLbPWZAsQMohSZtwQAcVBrpncDaLeFuxBpm43jwTta+o++i8i9cgMMG/mm++4b2SPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ewDvbqVE; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ewDvbqVE"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e02c4168e09so181191276.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718768421; x=1719373221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU/xf2tVFP1Wv/KAvg/7L1SzSc5/sikagJsqouU0aT4=;
        b=ewDvbqVEogC9KGfOEb7HCzzirFrRQh39xYSz8/HXRb8azy/IP+9elo+9VzgK6KHi3u
         6Z5WWH1m9bEgsDmTx6ledFCQcyZxcNLGnTZUGG848C4JoLphu7q5X6Gtjge1K+jPocd8
         QYrPABAsK+iEIiUj9atI0sARCZM4R2AQbcRtGLN4WYPaQ68YKRyCruuOMdoYx7VwP7Qq
         tBmDo67eGznugcmONJ5UHg+dc7gAC1XDVipMHvHsw1dsFrfLVGzIbWnf3qWWTzzUSThF
         2o5V5tQqpbyMVlx5EuB29IrI0Elsd/Th2SynyFYARRQQkcS3Yy4IDftzCsKk2Y2s3Sqz
         l79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718768421; x=1719373221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU/xf2tVFP1Wv/KAvg/7L1SzSc5/sikagJsqouU0aT4=;
        b=Bi/beUqXWP5BqN25KHIoUnRP7x7MtV+4hyBUhcpLEWe9T8UDdc5gNP5S78sSljsX3Z
         YKXmWhkPxl8kqGm+iyjsR/vbe5xg2dW1e9pWiLUwi0ilPjZYiAfNvAuN4yF5GdDR6gLK
         lsRIdqR+LpXRDQaH0XQ/V+Cx+7yzrHoXx4q7f6fyFU0/C2KNp4in67PGFpfPusQh3MiR
         NmiAhtRn4UWC4nW1r0m6tERM0Zhnh9vUvRL18EmkKK7nYBkn4QcTQdASlO9DGwCmi9Xy
         3N7vitS14XncKPEsod4/rMjoahHqI6jevGD9qu84j+U/lsjFjSclDdt3YbrnCtOth0B5
         jXUw==
X-Forwarded-Encrypted: i=1; AJvYcCWOVZUf4efjdV46ARqkS4E2xXIlRnX3Vy8mTZPsZzT1lzS07/PmumwCT/RAeBzWgkeKrLo4uIez9gwL4/c3D/8m9BogxPm9QAyU7iKCk6ZtOpWT
X-Gm-Message-State: AOJu0YzG+xTWzP+frzRiddAvCP3ir4FWWEzJjsbVj3JyQNkWEzm/kEFC
	FqBFvEQal5Wd21oXQRWW0+OXql2oHv0q74f+7zKoEotnXllqqlE0bsj1Wx+R98qR97oZJXiDqDm
	XRU8JR36REjXfsK6oP0uE0cKxpj1hkNnbheS/RdOxmpi4rjxoZu4=
X-Google-Smtp-Source: AGHT+IGK3F33Df+10aQdjoJr70xSP9c2GKPQCcPTBlwhZQiFKKM+t8XpJK57xDkPZniPwNMnHJ8Gbw9j/AMdwqX65v4=
X-Received: by 2002:a25:b11d:0:b0:e02:6944:ecec with SMTP id
 3f1490d57ef6-e02be1004b3mr1768077276.10.1718768421520; Tue, 18 Jun 2024
 20:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523115134.70380-1-alexghiti@rivosinc.com>
 <20240613-lubricant-breath-061192a9489a@wendy> <a396c024-f1a8-4636-85ee-e36950a2dca0@ghiti.fr>
 <b603c8b5-3100-4ccf-b014-9274f980358d@ghiti.fr> <CABgGipU1tjFAJ+KD7fFabVmLoqNtmQagn2sREHVzZCZ3OxozzQ@mail.gmail.com>
 <CAHVXubiubf9oCHnFco19SReZRPELYJSRtZmwEnGQLR++N+aH-g@mail.gmail.com>
In-Reply-To: <CAHVXubiubf9oCHnFco19SReZRPELYJSRtZmwEnGQLR++N+aH-g@mail.gmail.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Wed, 19 Jun 2024 11:40:10 +0800
Message-ID: <CABgGipWu2sL0EiKGUgksCZta5Ru3N5fqiNZVQ-5mrDt00puyyQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix early ftrace nop patching
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor.dooley@microchip.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrea Parri <parri.andrea@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 9:40=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Andy,
>
> On Tue, Jun 18, 2024 at 2:48=E2=80=AFPM Andy Chiu <andy.chiu@sifive.com> =
wrote:
> >
> > On Tue, Jun 18, 2024 at 8:02=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> > >
> > > Hi Conor,
> > >
> > > On 17/06/2024 15:23, Alexandre Ghiti wrote:
> > > > Hi Conor,
> > > >
> > > > Sorry for the delay here.
> > > >
> > > > On 13/06/2024 09:48, Conor Dooley wrote:
> > > >> On Thu, May 23, 2024 at 01:51:34PM +0200, Alexandre Ghiti wrote:
> > > >>> Commit c97bf629963e ("riscv: Fix text patching when IPI are used"=
)
> > > >>> converted ftrace_make_nop() to use patch_insn_write() which does =
not
> > > >>> emit any icache flush relying entirely on __ftrace_modify_code() =
to do
> > > >>> that.
> > > >>>
> > > >>> But we missed that ftrace_make_nop() was called very early direct=
ly
> > > >>> when
> > > >>> converting mcount calls into nops (actually on riscv it converts =
2B
> > > >>> nops
> > > >>> emitted by the compiler into 4B nops).
> > > >>>
> > > >>> This caused crashes on multiple HW as reported by Conor and Bj=C3=
=B6rn since
> > > >>> the booting core could have half-patched instructions in its icac=
he
> > > >>> which would trigger an illegal instruction trap: fix this by emit=
ting a
> > > >>> local flush icache when early patching nops.
> > > >>>
> > > >>> Fixes: c97bf629963e ("riscv: Fix text patching when IPI are used"=
)
> > > >>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > >>> ---
> > > >>>   arch/riscv/include/asm/cacheflush.h | 6 ++++++
> > > >>>   arch/riscv/kernel/ftrace.c          | 3 +++
> > > >>>   2 files changed, 9 insertions(+)
> > > >>>
> > > >>> diff --git a/arch/riscv/include/asm/cacheflush.h
> > > >>> b/arch/riscv/include/asm/cacheflush.h
> > > >>> index dd8d07146116..ce79c558a4c8 100644
> > > >>> --- a/arch/riscv/include/asm/cacheflush.h
> > > >>> +++ b/arch/riscv/include/asm/cacheflush.h
> > > >>> @@ -13,6 +13,12 @@ static inline void local_flush_icache_all(void=
)
> > > >>>       asm volatile ("fence.i" ::: "memory");
> > > >>>   }
> > > >>>   +static inline void local_flush_icache_range(unsigned long star=
t,
> > > >>> +                        unsigned long end)
> > > >>> +{
> > > >>> +    local_flush_icache_all();
> > > >>> +}
> > > >>> +
> > > >>>   #define PG_dcache_clean PG_arch_1
> > > >>>     static inline void flush_dcache_folio(struct folio *folio)
> > > >>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrac=
e.c
> > > >>> index 4f4987a6d83d..32e7c401dfb4 100644
> > > >>> --- a/arch/riscv/kernel/ftrace.c
> > > >>> +++ b/arch/riscv/kernel/ftrace.c
> > > >>> @@ -120,6 +120,9 @@ int ftrace_init_nop(struct module *mod, struc=
t
> > > >>> dyn_ftrace *rec)
> > > >>>       out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> > > >>>       mutex_unlock(&text_mutex);
> > > >> So, turns out that this patch is not sufficient. I've seen some mo=
re
> > > >> crashes, seemingly due to initialising nops on this mutex_unlock()=
.
> > > >> Palmer suggested moving the if (!mod) ... into the lock, which fix=
ed
> > > >> the problem for me.
> > > >
> > > >
> > > > Ok, it makes sense, I completely missed that. I'll send a fix for t=
hat
> > > > shortly so that it can be merged in rc5.
> > > >
> > > > Thanks,
> > > >
> > > > Alex
> > >
> > >
> > > So I digged a bit more and I'm afraid that the only way to make sure
> > > this issue does not happen elsewhere is to flush the icache right aft=
er
> > > the patching. We actually can't wait to batch the icache flush since
> > > along the way, we may call a function that has just been patched (the
> > > issue that you encountered here).
> >
> > Trying to provide my thoughts, please let me know if I missed
> > anything. I think what Conor suggested is safe for init_nop, as it
> > would be called only when there is only one core (booting) and at the
> > loading stage of kernel modules. In the first case we just have to
> > make sure there is no patchable entry before the core executes
> > fence.i. The second case is unconditionally safe because there is no
> > read-side of the race.
> >
> > It is a bit tricky for the generic (runtime) case of ftrace code
> > patching, but that is not because of the batch fence.i maintenance. As
> > long as there exists a patchable entry for the stopping thread, it is
> > possible for them to execute on a partially patched instruction. A
> > solution for this is again to prevent any patchable entry in the
> > stop_machine's stopping thread. Another solution is to apply the
> > atomic ftrace patching series which aims to get rid of the race.
>
> Yeah but my worry is that we can't make sure that functions called
> between the patching and the fence.i are not the ones that just get
> patched. At least today, patch_insn_write() etc should be marked as

IIUC, the compiler does not generate a patchable entry for
patch_insn_write, and so do all functions in patch.c. The entire file
is not compiled with patchable entry because the flag is removed in
riscv's Makefile. Please let me know if I misunderstand it.

> noinstr. But even then, we call core functions that could be patchable
> (I went through all and it *seems* we are safe *for now*, but this is
> very fragile).

Yes, functions in the "else" clause, atomic_read() etc, are safe for
now. However, it is impossible to fix as long as there exists a
patchable entry along the way. This is the problem that we cannot
patch 2 instructions with a concurrent read-side. On the other hand,
the path of ftrace_modify_all_code may experience the batch fence.i
maintenance issue, and can be fixed via a local fence.i. This is
because the path is executed by only one core. There does not exist a
concurrent write-side. As a result, we just need to make sure it
leaves each patch-site with a local fence.i to make sure code is
up-to-date.

>
> Then what do you think we should do to fix Conor's issue right now:
> should we mark the riscv specific functions as noinstr, cross fingers
> that the core functions are not (and don't become) patchable and wait
> for your atomic patching? Or should we flush as soon as possible as I
> proposed above (which to me fixes the issue but hurts performance)?

Either way works for me. IMHO, the fix should include:

1. move fence.i before mutex_unlock in init_nop
2. do local fence.i in __ftrace_modify_call
3. make sure the else clause does not happen to have a patchable entry

Thanks,
Andy

>
> Thanks,
>
> Alex
>
> >
> > >
> > > I don't know how much it will impact the performance but I guess it w=
ill.
> > >
> > > Unless someone has a better idea (I added Andy and Puranjay in cc), h=
ere
> > > is the patch that implements this, can you give it a try? Thanks
> > >
> > > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > > index 87cbd86576b2..4b95c574fd04 100644
> > > --- a/arch/riscv/kernel/ftrace.c
> > > +++ b/arch/riscv/kernel/ftrace.c
> > > @@ -120,9 +120,6 @@ int ftrace_init_nop(struct module *mod, struct
> > > dyn_ftrace *rec)
> > >          out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> > >          mutex_unlock(&text_mutex);
> > >
> > > -       if (!mod)
> > > -               local_flush_icache_range(rec->ip, rec->ip +
> > > MCOUNT_INSN_SIZE);
> > > -
> > >          return out;
> > >   }
> > >
> > > @@ -156,9 +153,9 @@ static int __ftrace_modify_code(void *data)
> > >          } else {
> > >                  while (atomic_read(&param->cpu_count) <=3D num_onlin=
e_cpus())
> > >                          cpu_relax();
> > > -       }
> > >
> > > -       local_flush_icache_all();
> > > +               local_flush_icache_all();
> > > +       }
> > >
> > >          return 0;
> > >   }
> > > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > > index 4007563fb607..ab03732d06c4 100644
> > > --- a/arch/riscv/kernel/patch.c
> > > +++ b/arch/riscv/kernel/patch.c
> > > @@ -89,6 +89,14 @@ static int __patch_insn_set(void *addr, u8 c, size=
_t len)
> > >
> > >          memset(waddr, c, len);
> > >
> > > +       /*
> > > +        * We could have just patched a function that is about to be
> > > +        * called so make sure we don't execute partially patched
> > > +        * instructions by flushing the icache as soon as possible.
> > > +        */
> > > +       local_flush_icache_range((unsigned long)waddr,
> > > +                                (unsigned long)waddr + len);
> > > +
> > >          patch_unmap(FIX_TEXT_POKE0);
> > >
> > >          if (across_pages)
> > > @@ -135,6 +143,14 @@ static int __patch_insn_write(void *addr, const
> > > void *insn, size_t len)
> > >
> > >          ret =3D copy_to_kernel_nofault(waddr, insn, len);
> > >
> > > +       /*
> > > +        * We could have just patched a function that is about to be
> > > +        * called so make sure we don't execute partially patched
> > > +        * instructions by flushing the icache as soon as possible.
> > > +        */
> > > +       local_flush_icache_range((unsigned long)waddr,
> > > +                                (unsigned long)waddr + len);
> > > +
> > >          patch_unmap(FIX_TEXT_POKE0);
> > >
> > >          if (across_pages)
> > > @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_=
t len)
> > >
> > >          ret =3D patch_insn_set(tp, c, len);
> > >
> > > -       if (!ret)
> > > -               flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len=
);
> > > -
> > >          return ret;
> > >   }
> > >   NOKPROBE_SYMBOL(patch_text_set_nosync);
> > > @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *ins=
ns,
> > > size_t len)
> > >
> > >          ret =3D patch_insn_write(tp, insns, len);
> > >
> > > -       if (!ret)
> > > -               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + l=
en);
> > > -
> > >          return ret;
> > >   }
> > >   NOKPROBE_SYMBOL(patch_text_nosync);
> > > @@ -253,9 +263,9 @@ static int patch_text_cb(void *data)
> > >          } else {
> > >                  while (atomic_read(&patch->cpu_count) <=3D num_onlin=
e_cpus())
> > >                          cpu_relax();
> > > -       }
> > >
> > > -       local_flush_icache_all();
> > > +               local_flush_icache_all();
> > > +       }
> > >
> > >          return ret;
> > >   }
> > >
> > >
> > > >
> > > >
> > > >>
> > > >>>   +    if (!mod)
> > > >>> +        local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_=
SIZE);
> > > >>> +
> > > >>>       return out;
> > > >>>   }
> > > >>>   --
> > > >>> 2.39.2
> > > >>>
> > > >>>
> > > >>> _______________________________________________
> > > >>> linux-riscv mailing list
> > > >>> linux-riscv@lists.infradead.org
> > > >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > Cheers,
> > Andy
