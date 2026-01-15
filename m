Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F43C1FD7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503032; cv=pass; b=TCzTAH1qeG/+MaNqAcaXFlvLtzgfuFL+vAWhpk21TLBJ0Xtaj0S+WlZOD5xOEi4q/Xpfu+qIpw16NhnEekbqKL/f5J6h9uNIW5cQrHPLV28qo7BxDjxoXAbS53dyGlz8eWBGjm8WHPegmaYKK61FCw2iRjB5HJKXR8r9hdxQzyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503032; c=relaxed/simple;
	bh=gQtRYgLCeRAq8QsfKbXbRJ5PemQLVXh1Ew/167lVpVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWew/u0xa2PgcpI5hjM99PDKmVJxdQCrz8l1BTCYW7fiSKFZomJY5INCkZlBSpdhCKniDK1GXJYNTvXN3KqHHCY/IxTYNlhRlB2I0ZdI6NnoK/+0FqsT/RpmuCVe2mBcN2i8xGMrlUu1cqochRyKFkXsj7FE7sJenaU77G8OE88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPS1+2LO; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPS1+2LO"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so747570a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 10:50:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768503026; cv=none;
        d=google.com; s=arc-20240605;
        b=Nb7J0x5NynQm3pRmqviFQw0uBkCNpGizJdqiqPDG99fYGG86GZWe0b18DBNuIug6a8
         TsZmZ6IDO2U8I6tcvmf7MCGIZYEP1kl8YxHp4HtnhVByu+DE9KujUQ0V11Wi6FvMqz4J
         DZDOBI8yBWa+h5pGBDBUZ/pIDvw44ocvtwW1tfYKLutAhRQ3PuYGjOhL3uBIGN8Lh1vq
         ndAo7GabY6O3HKnBURS+oAdGPLrYVXxC+pb0MQqJ6ly1FME7Aj3giCGpqHe7V59SeJc/
         xpAHSpA/2EjzfEvsfLoO1KYshF9RyshZssJqRgPVnR36hNGhqxbUIJFb9CXel9Z40kmm
         Kh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OnpCoYg3n4ioXiv+ldJpW4ktoyK6Gvbrlk/GRDVTf7w=;
        fh=rG0z0u5sc/95pZB0/WGvgyjYRq6MzSSc4NBekb4PiH0=;
        b=iQkxnzhyY3TQuhfMVpUt9v3msKlumXeokcdZtJs/gHNztU6CA4zh5/lJiNByafAcsq
         PBEpVigozwD40p9pJpPq/4l70640mUCpSEOCpqCGLGPBB6lX9pGKlOhBiMTFrWim2tBf
         racQclwD4ShaZsxkmEh/MaCYPuBpUUYesbioQX2UkGGPo3m71dnvDYlIkLiN6/L5aw+8
         LCELrBc2Kgtdsx9ezFyZaR8rNZ7AGOTBBX+/JziMyfNZ9QgQcrFlfwpWPEIspf7qO09s
         Xp0RshjVZAjookM3zU46F5Mks+hj2DMNlq++2JiZzGPIpGVuyf7mBzkfq9c3q/O/OGRJ
         B19g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503026; x=1769107826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnpCoYg3n4ioXiv+ldJpW4ktoyK6Gvbrlk/GRDVTf7w=;
        b=FPS1+2LOHcbVW2YkPKvcwnd+DdJOCShb+u1PNYlJgIvOCObhUQUSKbb2kUMZ6jyBB9
         voN1gI5DHGPgDv+58qusfPq0Sq9p2hyYmg4Wn9uQ3niVkPCh6tLdKX7b/xcUJx4g7FrV
         73iANe6VU/oCD+FraOZdggQc4WRd3zg0742TCC8H6ihIz7/ORAdpwG2VCgYrXz2g+Yxj
         uE+bl2m4pSlk0uiW0GecJ5QYWZOCc0PVR/9YDEzvmaLszpeSeZ5t2mUhXsaBChlimloe
         RoKJounO70kUK6Tzgno5XWfBuciuk0q9I6B30xYSNH/RimZJUUUYRwXvmm6ytyvZV4PY
         1TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503026; x=1769107826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OnpCoYg3n4ioXiv+ldJpW4ktoyK6Gvbrlk/GRDVTf7w=;
        b=tsBRB5MKs5v1yl6R0lN8Vh9mvzR6eoxatjxBWkLTYdqVnaZYkT5ZStY/DVJJsJrPWA
         grmoWKX3WknmcTc17lwLnEepqdUVRZOk1Ipc1zrNsdrMDv9wGPhA2PvsaLI1yahthObn
         1oGKJT+yYO4ZKeJAF5NgldGZs5ZCujdypwGS34h3WT+/9LwdnFFCetZYq8A9Wv1hvCKj
         QJl9d74bb9n8yP0FBgjXfZTCDJFjqwM3ZDsdFy6RQIXhRyfNFYNfT6Plt8mwImbCw4yf
         ZgzMCeq4ktAF+Qzzahkl+k0xgswnDEhqCbIQo8KTYiQ/mr0tw5EtP/1tbneYjsIhAWKX
         gHMA==
X-Forwarded-Encrypted: i=1; AJvYcCVlIaQFIya5B4ZlozOHQvOxSGwSF/anpZcaDM0U78tkkFNzFI8e9TUGd3sblAKx8aFn2ku+lvqQOT/2HAEde71foig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwnZrMkfNv+nYZ0zyvXJA9fViIqfnUSty1hJcP1S7Lk73QS85
	qt80HFYt7a58CVH46igaNjj+KN58tYTizwihzwqcC0MFrUsbjH08rJOYJL2LBffb/BRiwrYXRF1
	XuOw9nnIxxcypLW7/ruLdQHyJ2Cgylkg=
X-Gm-Gg: AY/fxX5beFGiteFF4NgoqtTFV8z4lUDvH7wsT1i6fhfqhGgrXJFPFgc6f7m8Ds2Djl9
	/mCmpPHGNyEZy/RYWzxV2Q8Pw1Q6Jw22Inw3lPsY0ZLpdDM/HBUQ3IaVJCaTivGRkdrWaXFceeP
	g5Exc0s3O0g/+qVynBQrTzpPBnO/jMi+tT2KXiHlBzMcAhfWqCXf8PVfT4x6bmmjQgbuOtwWRdY
	4n++EUwWVb/uBs97SmXuQFs8JUDCUKV3PBarnxx2UVbHLNq+U2vTJ0wAcMf6hQ99aEgyRRmeNYq
	ZaSqbwSV
X-Received: by 2002:a17:90b:3c85:b0:340:b86b:39c7 with SMTP id
 98e67ed59e1d1-3527317db23mr287866a91.11.1768503026313; Thu, 15 Jan 2026
 10:50:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112214940.1222115-1-jolsa@kernel.org> <20260112214940.1222115-5-jolsa@kernel.org>
 <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>
In-Reply-To: <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 10:50:13 -0800
X-Gm-Features: AZwV_Qgp2lQN9PVyejnfsDp_b_Uy6fqZH6QztBobLA0UKr6zwNYYWO93As_6mFY
Message-ID: <CAEf4Bzbn-Sai+pnC1Gu-E-uhJeSA8g-6xB49bswdPFpJd92Rng@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Allow to benchmark trigger
 with stacktrace
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Mahe Tardy <mahe.tardy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 10:48=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 12, 2026 at 1:50=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > Adding support to call bpf_get_stackid helper from trigger programs,
> > so far added for kprobe multi.
> >
> > Adding the --stacktrace/-g option to enable it.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bench.c            |  4 ++++
> >  tools/testing/selftests/bpf/bench.h            |  1 +
> >  .../selftests/bpf/benchs/bench_trigger.c       |  1 +
> >  .../selftests/bpf/progs/trigger_bench.c        | 18 ++++++++++++++++++
> >  4 files changed, 24 insertions(+)
> >
>
> This now actually becomes a stack trace benchmark :) But I don't mind,
> I think it would be good to be able to benchmark this. But I think we
> should then implement it for all different tracing programs (tp,
> raw_tp, fentry/fexit/fmod_ret) for consistency and so we can compare
> and contrast?...
>
> > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selfte=
sts/bpf/bench.c
> > index bd29bb2e6cb5..8dadd9c928ec 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -265,6 +265,7 @@ static const struct argp_option opts[] =3D {
> >         { "verbose", 'v', NULL, 0, "Verbose debug output"},
> >         { "affinity", 'a', NULL, 0, "Set consumer/producer thread affin=
ity"},
> >         { "quiet", 'q', NULL, 0, "Be more quiet"},
> > +       { "stacktrace", 'g', NULL, 0, "Get stack trace"},
>
> bikeshedding time: why "g"? why not -S or something like that?
>
> >         { "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
> >           "Set of CPUs for producer threads; implies --affinity"},
> >         { "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
> > @@ -350,6 +351,9 @@ static error_t parse_arg(int key, char *arg, struct=
 argp_state *state)
> >         case 'q':
> >                 env.quiet =3D true;
> >                 break;
> > +       case 'g':
> > +               env.stacktrace =3D true;
> > +               break;
> >         case ARG_PROD_AFFINITY_SET:
> >                 env.affinity =3D true;
> >                 if (parse_num_list(arg, &env.prod_cpus.cpus,
> > diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selfte=
sts/bpf/bench.h
> > index bea323820ffb..7cf21936e7ed 100644
> > --- a/tools/testing/selftests/bpf/bench.h
> > +++ b/tools/testing/selftests/bpf/bench.h
> > @@ -26,6 +26,7 @@ struct env {
> >         bool list;
> >         bool affinity;
> >         bool quiet;
> > +       bool stacktrace;
> >         int consumer_cnt;
> >         int producer_cnt;
> >         int nr_cpus;
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools=
/testing/selftests/bpf/benchs/bench_trigger.c
> > index 34018fc3927f..aeec9edd3851 100644
> > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > @@ -146,6 +146,7 @@ static void setup_ctx(void)
> >         bpf_program__set_autoload(ctx.skel->progs.trigger_driver, true)=
;
> >
> >         ctx.skel->rodata->batch_iters =3D args.batch_iters;
> > +       ctx.skel->rodata->stacktrace =3D env.stacktrace;
> >  }
> >
> >  static void load_ctx(void)
> > diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/=
testing/selftests/bpf/progs/trigger_bench.c
> > index 2898b3749d07..479400d96fa4 100644
> > --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> > +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > @@ -25,6 +25,23 @@ static __always_inline void inc_counter(void)
> >         __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> >  }
> >
> > +volatile const int stacktrace;
> > +
> > +typedef __u64 stack_trace_t[128];
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > +       __uint(max_entries, 16384);
> > +       __type(key, __u32);
> > +       __type(value, stack_trace_t);
> > +} stackmap SEC(".maps");

oh, and why bother with STACK_TRACE map, just call bpf_get_stack() API
and have maybe per-CPU scratch array for stack trace (per-CPU so that
in multi-cpu benchmarks they don't just contend on the same cache
lines)

> > +
> > +static __always_inline void do_stacktrace(void *ctx)
> > +{
> > +       if (stacktrace)
> > +               bpf_get_stackid(ctx, &stackmap, 0);
> > +}
> > +
> >  SEC("?uprobe")
> >  int bench_trigger_uprobe(void *ctx)
> >  {
> > @@ -96,6 +113,7 @@ SEC("?kprobe.multi/bpf_get_numa_node_id")
> >  int bench_trigger_kprobe_multi(void *ctx)
> >  {
> >         inc_counter();
> > +       do_stacktrace(ctx);
> >         return 0;
> >  }
> >
> > --
> > 2.52.0
> >
