Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EBE1CA8D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719283152; cv=none; b=uTaeZJjth+8ZmyNcHjMbflDRBDXp02Eu27QNI8cI4Y3Nek5kgEYdwTDO6PeG3BSR71Kh++Zc2vMS27QXBdVDZ7f785oDi+jzZ/Yli9q6SXsg5gUbMfXbRjhWwklDoDjHZkbj6WB9HoineFv6gzaMxHFVC2ji7n2ljfsPFZGBVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719283152; c=relaxed/simple;
	bh=S2zvzr2YT3txVPQM8oaC1bFkuwpT9uFDDUsd/JUX46w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eg59yWVm1qgc1AFiDk3TV6eEEXE6OVuLWR1UP9eAO7AOqodWQdyIP7ErhJU77vdkcjO8/zXYlsFzzSfRZoy9vGDTdwSOILq2xV6uvUTTEAJH0SjhCJt1HfiekSrgTX6FjZqEBfQ2Uxl3/zsC+u6POMu1mdbaMrmIyqoo00pzy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=caFAtzOl; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="caFAtzOl"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso5228669276.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719283150; x=1719887950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4nK+m/TEmRPZdUwZe7j9O1ig+33bNCxGNefCYINg2Q=;
        b=caFAtzOllDWQzP+aNiO4O5jbr8Z0iBjaJORadfpYfNzYgIEAaFLhJjK6kCAY2sGIbA
         DcBtsUNffDdXqNf5NKmzUlOMYq5+OkXrmGv1H5bvZDPKBZyMryK75Rn33U7dof7J7SaS
         uSei87ijHphPqVm+WXyphYbRpY0Tb4F3IcNdcS6FlI2tVDivuMMe0y6yWOqNHGVvO5hO
         5zJwiM3G3C68FNhuAkfUK2WGW+Gn46NtE42EZj8PBvr+XoyJt1zWwNEUqp5zgIx+uIwA
         oPCNvW58P9ZwBqhk8gZpA0Bfv/07Kle55ZnqlwQWz2gQooF1C5/WMvSCuxikJRzSSGjP
         AzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719283150; x=1719887950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4nK+m/TEmRPZdUwZe7j9O1ig+33bNCxGNefCYINg2Q=;
        b=QtrGLykMhho1FIdeMupodlEE3L8n6/DLoxdw0k8fXdLCBqektKq//nwfbQPB0PYKx4
         4vz0ceaGOafOzKlXlpPZi6PjEvPH+InT/GTB+fhOvbm7z1QUvsdcuWjRQI0P3YZBfJF+
         TYY8idDvu0fFerfVlX5PXCxuMQef65Pa8SXtSuhZxPZpQi6qsLSyYIYnitZyxEq/Qx0T
         du0ck0goLhCEEw7z0oiz0TpLAhOMGhVaMgycWEfl1AN5YzqsKVtSpEyE6sB/m8qv7+Nw
         0A8BrzUoRPKQQoFGqjwCJ/0GvX/i8iKtlJnGiWWQxB4JPPH3MDJoQUNlClpxC885ecFT
         GHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxTe+Cl2/3yJEGfpBNj6Us2SGE3nnvPYTGrpP+1YGk0rif4F9nKXdSV0iI3ttYUucMxJJBdr4B0V3Otwp80kVLgpUh8AeOr/m0FOq3zHgBloXH
X-Gm-Message-State: AOJu0YzUEEZkE7T8qbj46XiIqSYCWVrwdY2b02AdykUkf2Zeb+D2odvf
	goGYP83nEOlGxUjSmSzBSgdBAF2nEKQtjkyLCnMyhkfO6109pKnxgfSA3R3HrsPX4c71aiCFVhq
	jz2nSCxLhlm2bxKu3ZM/UnrJnWgkcq+Fd271zLQ==
X-Google-Smtp-Source: AGHT+IHKSN058g/QcX941p8tcRKTOzJPr409onokITSLEzi+0NUbHeNvo0EJpY+vaEpFjSnmhZzP/QtohyABMy5Rmf8=
X-Received: by 2002:a25:abcb:0:b0:e02:bab0:2b11 with SMTP id
 3f1490d57ef6-e02fc37b011mr6929278276.59.1719283149931; Mon, 24 Jun 2024
 19:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082141.153871-1-alexghiti@rivosinc.com> <CABgGipXR6ETkH0w-8GG8uBtKbG5jvD0VHz-A-VnXFPgvqrd6Lw@mail.gmail.com>
In-Reply-To: <CABgGipXR6ETkH0w-8GG8uBtKbG5jvD0VHz-A-VnXFPgvqrd6Lw@mail.gmail.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Tue, 25 Jun 2024 10:38:59 +0800
Message-ID: <CABgGipWOKqVynXW2OvxP3cfX7dvbjVES8t4epW+f3W11AJLgeA@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: patch: Flush the icache right after
 patching to avoid illegal insns
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 7:49=E2=80=AFPM Andy Chiu <andy.chiu@sifive.com> wr=
ote:
>
> Hi Alex,
>
> On Mon, Jun 24, 2024 at 4:21=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > We cannot delay the icache flush after patching some functions as we ma=
y
> > have patched a function that will get called before the icache flush.
> >
> > The only way to completely avoid such scenario is by flushing the icach=
e
> > as soon as we patch a function. This will probably be costly as we don'=
t
> > batch the icache maintenance anymore.
> >
> > Fixes: 6ca445d8af0e ("riscv: Fix early ftrace nop patching")
> > Reported-by: Conor Dooley <conor.dooley@microchip.com>
> > Closes: https://lore.kernel.org/linux-riscv/20240613-lubricant-breath-0=
61192a9489a@wendy/
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

> > ---
> >  arch/riscv/kernel/ftrace.c |  7 ++-----
> >  arch/riscv/kernel/patch.c  | 26 ++++++++++++++++++--------
> >  2 files changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > index 87cbd86576b2..4b95c574fd04 100644
> > --- a/arch/riscv/kernel/ftrace.c
> > +++ b/arch/riscv/kernel/ftrace.c
> > @@ -120,9 +120,6 @@ int ftrace_init_nop(struct module *mod, struct dyn_=
ftrace *rec)
> >         out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> >         mutex_unlock(&text_mutex);
> >
> > -       if (!mod)
> > -               local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN=
_SIZE);
> > -
> >         return out;
> >  }
> >
> > @@ -156,9 +153,9 @@ static int __ftrace_modify_code(void *data)
> >         } else {
> >                 while (atomic_read(&param->cpu_count) <=3D num_online_c=
pus())
> >                         cpu_relax();
> > -       }
> >
> > -       local_flush_icache_all();
> > +               local_flush_icache_all();
> > +       }
>
> Sorry, maybe I should point it out directly earlier. But I don't think
> this diff chunk is required. Threads running in the else clause from
> stop_machine must not run into any patchable entry. If it runs into a
> patchable entry, running the local fence.i is not going to fix the
> problem.

Sorry, I read the code wrong. The local flush is not in the while
loop. I have no problem with this chunk after properly seeing them.

>
> >
> >         return 0;
> >  }
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 4007563fb607..ab03732d06c4 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -89,6 +89,14 @@ static int __patch_insn_set(void *addr, u8 c, size_t=
 len)
> >
> >         memset(waddr, c, len);
> >
> > +       /*
> > +        * We could have just patched a function that is about to be
> > +        * called so make sure we don't execute partially patched
> > +        * instructions by flushing the icache as soon as possible.
> > +        */
> > +       local_flush_icache_range((unsigned long)waddr,
> > +                                (unsigned long)waddr + len);
> > +
> >         patch_unmap(FIX_TEXT_POKE0);
> >
> >         if (across_pages)
> > @@ -135,6 +143,14 @@ static int __patch_insn_write(void *addr, const vo=
id *insn, size_t len)
> >
> >         ret =3D copy_to_kernel_nofault(waddr, insn, len);
> >
> > +       /*
> > +        * We could have just patched a function that is about to be
> > +        * called so make sure we don't execute partially patched
> > +        * instructions by flushing the icache as soon as possible.
> > +        */
> > +       local_flush_icache_range((unsigned long)waddr,
> > +                                (unsigned long)waddr + len);
> > +
> >         patch_unmap(FIX_TEXT_POKE0);
> >
> >         if (across_pages)
> > @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t =
len)
> >
> >         ret =3D patch_insn_set(tp, c, len);
> >
> > -       if (!ret)
> > -               flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> > -
> >         return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_set_nosync);
> > @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns=
, size_t len)
> >
> >         ret =3D patch_insn_write(tp, insns, len);
> >
> > -       if (!ret)
> > -               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len=
);
> > -
> >         return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_nosync);
> > @@ -253,9 +263,9 @@ static int patch_text_cb(void *data)
> >         } else {
> >                 while (atomic_read(&patch->cpu_count) <=3D num_online_c=
pus())
> >                         cpu_relax();
> > -       }
> >
> > -       local_flush_icache_all();
> > +               local_flush_icache_all();
> > +       }
> >
> >         return ret;
> >  }
> > --
> > 2.39.2
> >
>
> Thanks,
> Andy
