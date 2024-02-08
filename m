Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA30763E8
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398597; cv=none; b=L9VAjK5Z20uPc7M6cl96Eyz8KUkmKaWr8z1wrMwA5mBd6wKKQtAYBBaWwYP7J3w+0DjnNswswT0tJwvGQai4AOX5oV55xfVF9bMsJt2gozxJx2lWOpxWPxWB9BlpmQIWBKfwt57O5eMfJWSBO4xzimbpktkqlFJZC5uGw0jwUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398597; c=relaxed/simple;
	bh=OuNCUz52dZoeKZCssECX7LECAYjAN81wWrFdpWXkTcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJsmw+YPrh7fH7Ounq3G+e2J6xdikNVlNoLko3CKGOXTHMScWAZ9ap3PYXnPbCXr1GchIaUkUM3wRUs1dKI/YDqa4hBijqYK+Yovi9gjHEUiTWZDU9mOyeeN4lGwRge6R/ALHCPAX2CAuKmlrzTYF4cXzPO68N4jkFwl1D3yMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MpcQQGFt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MpcQQGFt"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3bbb8a0cf6so49098466b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707398593; x=1708003393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2zpgdujj1gYFQCxpzgk3AGLL3hOuoYEj3pj3VOmX9g=;
        b=MpcQQGFt5nZ56LXM/FpKp1OO1eC6PdSXWMUwlPP+k1acYTaB7N94uaMhp0kb65uQnp
         HJA6r4Mfp9nWqivNhipv6BkUq1OFyuFjX+UIjLFG0CipXIocf3wt87ox8UhJid+LbX37
         ecL3uVhw9xTo9fvoEU4YgGBgafzxe1o5x+y8ZHHvl+HEoqSezBesUqB8taU4ig88EcZz
         AZdvkFoYKF5efgild4maX8RqWjE7+iMIY9IUvoBrq3aibh+7lbiYTTabE+2v1QO2a7P1
         qvm19N8KH9df7ozxN9YzyGR/Ui+gaGQ1NpWfh3KQ/76cfLRxxdtPdwpaYe5vua/Qpqsx
         ssnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707398593; x=1708003393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2zpgdujj1gYFQCxpzgk3AGLL3hOuoYEj3pj3VOmX9g=;
        b=XpeiWPEs9rQ+Q/XHYmwoKmFOBsPN/Y1sviNwnE4vRQ7LQEhNV3xXa+M3vl1eFWfLAO
         ZLqnEk+MDA7MJsaxelVDVmeE4WV7AMqcFXzyEcXwt3QCdZZc00myfNqCmzDhcMSg/D+7
         8d6X1uf2Y43jupy7mT62o1msW1autqNJMZuMJhNGTaL+mWO9scy+TvoLrgohq92tH9sx
         C9GfgXmZS20BpUadJjy1UEFOmQDzIcgkTO5CphrkH6k8VVYuPMEZwpUbsWEiyGzGnJ2N
         fpHeNzU44x/Dtq9axyV2BLXYEeXrh2z2a811z7lyiwJz95hjtz0dERohUcwu9hV+M/ty
         DvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmeBhVvLMA3a6L07njUQv5pWlRevdfkIQOHF3RCCPoElQ1K4LbwoegEG2rTqO4Y2b714h7+cm9hXGsmQ8HraYn8NI6/LywCKWmlwYVSMDQFMoh
X-Gm-Message-State: AOJu0YyQNocXo+j1HdLF5IF2fFYqeJNX2Y1dEhct28CW6qgCOdC4EC9Z
	jSHiqfGVmfs2iR7B7ylVnFWaUC9cW8GY8+TqKiukcPcWPiI3B4JiZ20/medpCmApV7+H/sBsOaQ
	CY8/oFyjmXYqE6cZ98JPXVkNL/BCJw5iNkTgyY6MjEHNSCZIblos=
X-Google-Smtp-Source: AGHT+IEc4w81N06k/dJCCWI/8ie/Uaz6Jb1ky5A9KAQW2kGf8+rE4iLeOHNbonyyyUv3nuMoSXMDNxqjJlJT0K+Lu+s=
X-Received: by 2002:a17:906:dce:b0:a3b:a4e6:f83e with SMTP id
 p14-20020a1709060dce00b00a3ba4e6f83emr1277933eji.20.1707398593065; Thu, 08
 Feb 2024 05:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206204607.527195-1-alexghiti@rivosinc.com> <ZcS+GAaM25LXsBOl@andrea>
In-Reply-To: <ZcS+GAaM25LXsBOl@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 8 Feb 2024 14:23:02 +0100
Message-ID: <CAHVXubj7ChgpvN4F_QO0oASaT5WC2VS0Q-bEqhnmF8z8QV=yDQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix text patching when icache flushes use IPIs
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Thu, Feb 8, 2024 at 12:42=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > +static int __ftrace_modify_code(void *data)
> > +{
> > +     struct ftrace_modify_param *param =3D data;
> > +
> > +     if (atomic_inc_return(&param->cpu_count) =3D=3D num_online_cpus()=
) {
> > +             ftrace_modify_all_code(param->command);
> > +             atomic_inc(&param->cpu_count);
>
> I stared at ftrace_modify_all_code() for a bit but honestly I don't see
> what prevents the ->cpu_count increment from being reordered before the
> insn write(s) (architecturally) now that you have removed the IPI dance:
> perhaps add an smp_wmb() right before the atomic_inc() (or promote this
> latter to a (void)atomic_inc_return_release()) and/or an inline comment
> saying why such reordering is not possible?

I did not even think of that, and it actually makes sense so I'll go
with what you propose: I'll replace atomic_inc() with
atomic_inc_return_release(). And I'll add the following comment if
that's ok with you:

"Make sure the patching store is effective *before* we increment the
counter which releases all waiting cpus"

>
>
> > +     } else {
> > +             while (atomic_read(&param->cpu_count) <=3D num_online_cpu=
s())
> > +                     cpu_relax();
> > +             smp_mb();
>
> I see that you've lifted/copied the memory barrier from patch_text_cb():
> what's its point?  AFAIU, the barrier has no ordering effect on program
> order later insn fetches; perhaps the code was based on some legacy/old
> version of Zifencei?  IAC, comments, comments, ... or maybe just remove
> that memory barrier?

Honestly, I looked at it one minute, did not understand its purpose
and said to myself "ok that can't hurt anyway, I may be missing
something".

FWIW,  I see that arm64 uses isb() here. If you don't see its purpose,
I'll remove it (here and where I copied it).

>
>
> > +     }
> > +
> > +     local_flush_icache_all();
> > +
> > +     return 0;
> > +}
>
> [...]
>
>
> > @@ -232,8 +230,7 @@ static int patch_text_cb(void *data)
> >       if (atomic_inc_return(&patch->cpu_count) =3D=3D num_online_cpus()=
) {
> >               for (i =3D 0; ret =3D=3D 0 && i < patch->ninsns; i++) {
> >                       len =3D GET_INSN_LENGTH(patch->insns[i]);
> > -                     ret =3D patch_text_nosync(patch->addr + i * len,
> > -                                             &patch->insns[i], len);
> > +                     ret =3D patch_insn_write(patch->addr + i * len, &=
patch->insns[i], len);
> >               }
> >               atomic_inc(&patch->cpu_count);
> >       } else {
> > @@ -242,6 +239,8 @@ static int patch_text_cb(void *data)
> >               smp_mb();
> >       }
> >
> > +     local_flush_icache_all();
> > +
> >       return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_cb);
>
> My above remarks/questions also apply to this function.
>
>
> On a last topic, although somehow orthogonal to the scope of this patch,
> I'm not sure the patch_{map,unmap}() dance in our patch_insn_write() is
> correct: I can see why we may want (need to do) the local TLB flush be-
> fore returning from patch_{map,unmap}(), but does a local flush suffice?
> For comparison, arm64 seems to go through a complete dsb-tlbi-dsb(-isb)
> sequence in their unmapping stage (and apparently relying on "no caching
> of invalid ptes" in their mapping stage).  Of course, "broadcasting" our
> (riscv's) TLB invalidations will necessary introduce some complexity...
>
> Thoughts?

To avoid remote TLBI, could we simply disable the preemption before
the first patch_map()? arm64 disables the irqs, but that seems
overkill to me, but maybe I'm missing something again?

Thanks for your comments Andrea,

Alex

>
>   Andrea
