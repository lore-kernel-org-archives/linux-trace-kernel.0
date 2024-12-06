Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92901212FA1
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526865; cv=none; b=fwcA59Tmn00QXN8rohoUMQibXhz1ByBKhYCMwfqcenNehJo/88QyGZ+cfknyNYJb6uKe5lqYbmdSR8BUiVure5mc5qX9Hl/Yjm1qsz2I0kekJ9xxvtzW5y/SXzxMtHQHPjBoVrh2D8JLvrkjvb1CWXZUhgwxZbMrw4RcQIcR9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526865; c=relaxed/simple;
	bh=nr5ePPbtBK2X8uG6dSt4bEjpaGmviojpuJaDVxzFKlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMmjyiZI9DcUUaCfGi3ngPQwHl5lqwj1/H0cr+/Hgx/hfZfTOBx3nKtC8Z+hWw6YDAJCgx6sRx/ql3zfAn0NCAogKMGXqfliZMN2ynBJvgy71SGAgg1ET0Ot6IDcdVYGPI4o8RIxCWSNy9sYc34gBqc/erDcNAFdiEv/NPu0LWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXSPzv9B; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXSPzv9B"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d1228d66a0so635a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Dec 2024 15:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733526862; x=1734131662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT70/4haykowxKJLSO2D1Td5mevQmnkZI/GztOJ/4fM=;
        b=qXSPzv9B5zrGpBSTqmtmnGte35c6q9CyuaibTtCEYOaFYa/GR87w8ATYtLV99CfnFB
         3Vmf+v4yavNa6KSJUHA80T6GQjBVP7Uj/XvkywsjRm8SccMqNJJetZEa/dvXD4t9nV9j
         NMqBWDinBFBMUpwtEgptrCLrXATCmCMtN0iTWcIdx6/vGmJlWjQxLT3T9QoVoAOYsx/D
         GC8XOyLxl2645YXr1bqgwPtaZM/oJdAm982TSN23CM4wj75PgsytIukiY8PUc2vnpgBD
         35goHEcXImdUtzVULOqZRFIi4AJHxQ1ZxnU9e97mqR9FiDE/qSaNV2ZVZw8+mvsk4ExJ
         E+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733526862; x=1734131662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT70/4haykowxKJLSO2D1Td5mevQmnkZI/GztOJ/4fM=;
        b=OgNP+0bfI/svjSQfphNJH5UEM7+DpfJrlspaE+BpaZ6wVCiTbZQ/KDLRKGXTF5HPBc
         l5UrBtGtG4yaOduoB2v4qNa/d4UlKPA1gooDxR7B/He40LgfEyjaJ0G4iYW0gMxEIoql
         Sg8QIL8E5xI/jWF0ZuIsDw+JCppWvvYgvN55hCbIeRih5k07VnOUOfIgiXMtaucCi6ef
         oG9oEz4tlMumQfkvwUkesCXQdzjEuJ/UOSxh5qow1ZXofAaVYZWqxVSi58IfacfJx1Gg
         VfzeYU3jUDzjUmQYFo3YuZWbudmV7fdrOHvlidY5pLyDIdyD3lwNvIWgUYzPd/u/3y+E
         JAvA==
X-Forwarded-Encrypted: i=1; AJvYcCUHIljSXyZkJZ3gL7HNk53u1upkAdhyNb9/e57Gcrt74WNwZo5Ag+v0lAr337arubDGgKY8PsRygRIQhtRAuuoVplk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOPNCPRrY+vJIX/ZKrXIel9giBRBK+CXtAhBi/ZdNZpxlx3ck
	/jXwQatuehbQr8imx3d1Fl/1Po0gV0Osvwn4Gty1JV89HX3ewxUz/kxPbcMQdd7vQY640+c5TNa
	JjmptJKXnjAtcHOaVFd/YRyGWO75e6GmzRjVP
X-Gm-Gg: ASbGnctl98HqsIl43MOBrcFnRrD8ih/tGhAcKqvsgzGu/TeuVoKQMmOIpxT6JbBpH7v
	JnTfcc2QzpWnz7MFkGXT9TyVi8h/zf3KRPquVwDjLQXNFPkP4mBo0Putkx34stEE=
X-Google-Smtp-Source: AGHT+IFvqea0ygicIaaMKdKwMVrDYelzBAhoiklcQz+KZTVCeOG7wm/s4JtUPWbUATXoft/BlVZ3YIswZ48TXkXHTeU=
X-Received: by 2002:a05:6402:1346:b0:5d0:b20c:205c with SMTP id
 4fb4d7f45d1cf-5d3dd9dd1a9mr11075a12.5.1733526861427; Fri, 06 Dec 2024
 15:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
 <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com>
 <CAG48ez3i5haHCc8EQMVNjKnd9xYwMcp4sbW_Y8DRpJCidJotjw@mail.gmail.com>
 <CAEf4BzYkGQ0sw9JEeAMLAfcQbzxwg46c487kBD_LcbZSaTKD5Q@mail.gmail.com> <CAG48ez1LRsuew4y_KQxPHNipA68hhm+iJohHbk6=1cwv5QPCxQ@mail.gmail.com>
In-Reply-To: <CAG48ez1LRsuew4y_KQxPHNipA68hhm+iJohHbk6=1cwv5QPCxQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Sat, 7 Dec 2024 00:13:45 +0100
Message-ID: <CAG48ez2+3TTbWNNO4aqxFAX8Cd4COaayRxoy1V2xvM9oS2_ygQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Delyan Kratunov <delyank@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:43=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Fri, Dec 6, 2024 at 11:30=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> > >
> > > On Fri, Dec 6, 2024 at 11:15=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@google.com=
> wrote:
> > > > >
> > > > > Currently, the pointer stored in call->prog_array is loaded in
> > > > > __uprobe_perf_func(), with no RCU annotation and no RCU protectio=
n, so the
> > > > > loaded pointer can immediately be dangling. Later,
> > > > > bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical=
 section,
> > > > > but this is too late. It then uses rcu_dereference_check(), but t=
his use of
> > > > > rcu_dereference_check() does not actually dereference anything.
> > > > >
> > > > > It looks like the intention was to pass a pointer to the member
> > > > > call->prog_array into bpf_prog_run_array_uprobe() and actually de=
reference
> > > > > the pointer in there. Fix the issue by actually doing that.
> > > > >
> > > > > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chainin=
g gps")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > ---
> > > > > To reproduce, in include/linux/bpf.h, patch in a mdelay(10000) di=
rectly
> > > > > before the might_fault() in bpf_prog_run_array_uprobe() and add a=
n
> > > > > include of linux/delay.h.
> > > > >
> > > > > Build this userspace program:
> > > > >
> > > > > ```
> > > > > $ cat dummy.c
> > > > > #include <stdio.h>
> > > > > int main(void) {
> > > > >   printf("hello world\n");
> > > > > }
> > > > > $ gcc -o dummy dummy.c
> > > > > ```
> > > > >
> > > > > Then build this BPF program and load it (change the path to point=
 to
> > > > > the "dummy" binary you built):
> > > > >
> > > > > ```
> > > > > $ cat bpf-uprobe-kern.c
> > > > > #include <linux/bpf.h>
> > > > > #include <bpf/bpf_helpers.h>
> > > > > #include <bpf/bpf_tracing.h>
> > > > > char _license[] SEC("license") =3D "GPL";
> > > > >
> > > > > SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> > > > > int BPF_UPROBE(main_uprobe) {
> > > > >   bpf_printk("main uprobe triggered\n");
> > > > >   return 0;
> > > > > }
> > > > > $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe-ker=
n.c
> > > > > $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test autoatt=
ach
> > > > > ```
> > > > >
> > > > > Then run ./dummy in one terminal, and after launching it, run
> > > > > `sudo umount uprobe-test` in another terminal. Once the 10-second
> > > > > mdelay() is over, a use-after-free should occur, which may or may
> > > > > not crash your kernel at the `prog->sleepable` check in
> > > > > bpf_prog_run_array_uprobe() depending on your luck.
> > > > > ---
> > > > > Changes in v2:
> > > > > - remove diff chunk in patch notes that confuses git
> > > > > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-u=
af-v1-1-6869c8a17258@google.com
> > > > > ---
> > > > >  include/linux/bpf.h         | 4 ++--
> > > > >  kernel/trace/trace_uprobe.c | 2 +-
> > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > >
> > > > Looking at how similar in spirit bpf_prog_run_array() is meant to b=
e
> > > > used, it seems like it is the caller's responsibility to
> > > > RCU-dereference array and keep RCU critical section before calling
> > > > into bpf_prog_run_array(). So I wonder if it's best to do this inst=
ead
> > > > (Gmail will butcher the diff, but it's about the idea):
> > >
> > > Yeah, that's the other option I was considering. That would be more
> > > consistent with the existing bpf_prog_run_array(), but has the
> > > downside of unnecessarily pushing responsibility up to the caller...
> > > I'm fine with either.
> >
> > there is really just one caller ("legacy" singular uprobe handler), so
> > I think this should be fine. Unless someone objects I'd keep it
> > consistent with other "prog_array_run" helpers
>
> Ack, I will make it consistent.
>
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index eaee2a819f4c..4b8a9edd3727 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_prog_ar=
ray *array,
> > > >   * rcu-protected dynamically sized maps.
> > > >   */
> > > >  static __always_inline u32
> > > > -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array=
_rcu,
> > > > +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> > > >                           const void *ctx, bpf_prog_run_fn run_prog=
)
> > > >  {
> > > >         const struct bpf_prog_array_item *item;
> > > >         const struct bpf_prog *prog;
> > > > -       const struct bpf_prog_array *array;
> > > >         struct bpf_run_ctx *old_run_ctx;
> > > >         struct bpf_trace_run_ctx run_ctx;
> > > >         u32 ret =3D 1;
> > > >
> > > >         might_fault();
> > > > +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock =
held");
> > > > +
> > > > +       if (unlikely(!array))
> > > > +               goto out;
> > > >
> > > > -       rcu_read_lock_trace();
> > > >         migrate_disable();
> > > >
> > > >         run_ctx.is_uprobe =3D true;
> > > >
> > > > -       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_tr=
ace_held());
> > > > -       if (unlikely(!array))
> > > > -               goto out;
> > > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > > >         item =3D &array->items[0];
> > > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > > @@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struct
> > > > bpf_prog_array __rcu *array_rcu,
> > > >         bpf_reset_run_ctx(old_run_ctx);
> > > >  out:
> > > >         migrate_enable();
> > > > -       rcu_read_unlock_trace();
> > > >         return ret;
> > > >  }
> > > >
> > > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprob=
e.c
> > > > index fed382b7881b..87a2b8fefa90 100644
> > > > --- a/kernel/trace/trace_uprobe.c
> > > > +++ b/kernel/trace/trace_uprobe.c
> > > > @@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct trace_u=
probe *tu,
> > > >         if (bpf_prog_array_valid(call)) {
> > > >                 u32 ret;
> > > >
> > > > +               rcu_read_lock_trace();
> > > >                 ret =3D bpf_prog_run_array_uprobe(call->prog_array,
> > > > regs, bpf_prog_run);
> > >
> > > But then this should be something like this (possibly split across
> > > multiple lines with a helper variable or such):
> > >
> > > ret =3D bpf_prog_run_array_uprobe(rcu_dereference_check(call->prog_ar=
ray,
> > > rcu_read_lock_trace_held()), regs, bpf_prog_run);
> >
> > Yeah, absolutely, forgot to move the RCU dereference part, good catch!
> > But I wouldn't do the _check() variant here, literally the previous
> > line does rcu_read_trace_lock(), so this check part seems like just
> > unnecessary verboseness, I'd go with a simple rcu_dereference().
>
> rcu_dereference() is not legal there - that asserts that we are in a
> normal RCU read-side critical section, which we are not.
> rcu_dereference_raw() would be, but I think it is nice to document the
> semantics to make it explicit under which lock we're operating.
>
> I'll send a v3 in a bit after testing it.

Actually, now I'm still hitting a page fault with my WIP v3 fix
applied... I'll probably poke at this some more next week.
