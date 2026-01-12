Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C561376BF2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238413; cv=none; b=nN9s6Vttg4iO6JuWLQdvl7xD5etZ50lUvbep3TS1V77tecA3dQiZmjiCIpe8khF8BwNCu7ziqrm06eWNL5S86c6aeNygeKBm7FdKNUqA9O6qwKfQTcud0aYUe4lH8mzpBpyaQDvoGuYlW0J4W51QlaFGdw+jLcc4FdOzWd28k8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238413; c=relaxed/simple;
	bh=WjqCWoD1rTd0tAoOL5oGFUBibEdR95jENn5cj2vf8ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRPqqnSstdMhgAHW2cGg9v3KqETLZ6fZQFhbOJN/PX8A2tVTysBixExnniuQsojLuW18tVE/AGMEuezARYtr4soLVoAboCY8+4Wnz+U7eAA5B0hpgP5Ae7FaFOVbRwWr0h2MueX8Aog7ze/L4Fva/iGkz7EgWLwm6hu39/y6lRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfu146Oy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfu146Oy"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb5810d39so3482817f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 09:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768238410; x=1768843210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wfo1H3rAgV/t1VxtARBz5MkJzax/TOyF8ts8rowgvw=;
        b=Xfu146Oydv7DoYt8Fz41DwqYx9JGsGUxSv2ZevD/LH4/MpZ4Vssq7RsMHBBay9yfSJ
         WFw98oyBsfB16pQfdrCDMyVSzwTqUINWPSzG7S7GczKHB5hvDnDIibstFlbo+bDTxM/j
         vWxPcKE0mmIgw4/H18IzjBm6AasthSJ3plDULMkFLGUSFwjXMPd9f5vUngS4u/HgvPkd
         FmkRojLFxNaKqijzWgWBZOXL/XNzm/xmYEMK06E0GNZWBWK+hNuLovuJ0/UVq3UQjTYd
         ++gRHeNxvK0XRUnwVxBT/SRxU2Jp6ImoIUb8t2ppZiHtTKc9mae6JZP/XEFnF77jsk6U
         wpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768238410; x=1768843210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wfo1H3rAgV/t1VxtARBz5MkJzax/TOyF8ts8rowgvw=;
        b=KxJPYnem+UXedup4pof9Adwtl5A9PKfAXf3dZfpfBkrSwY6/8q3ZephLODF+XlwnTS
         yJBEZolcrFV8WGDvzewMJRp7vwP9wtvZWf2O1aTT0Ujd6POHOBTUTjiZ71IrbrCHJea5
         3h1bUviJULNUowWJv1IktxOp3xiXFJo1h+kAuvSKBFXgRf9Xn2lQ9UMowiY6xbgHtbh3
         X893IN3jtceLkWtMjn4dl38RWmPoSkWqbcjNr8X9NwqVRQ2z/62DpgAlhha4fNXdt+22
         rB4aFCRYnthkLLguXSDogCIAqwyR8QZvFZSruwuXfKZtVZYeC5qBax6hvsD/PX4yPZB5
         Kp/w==
X-Forwarded-Encrypted: i=1; AJvYcCXJnHCDl4OjWy1hnPrhCrcSAMsQvY4iJtWIrz+4mX4+1z5ITpkXr5yJwgxrA5xuwVJj5jSMto/g616abjUm1wnrDiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsI5GrtBs1pW08HvJvA6rbILwWt9jLFFmseT5Wph7lQtuOgIjM
	CTbqOxXWGNwPx0/e7EoMhRccKiHPYHfd+dCa95P74ocdurnyxmivE3Iw5rvxpX5Ar4U4wEl0FmJ
	R5Vct9EMtut+XCj29EetmLey37eDWsB4=
X-Gm-Gg: AY/fxX4HWWhe4T/HA6BZWkpf4YLuONG/jzV+sPfOcqa7qi1CK+3x8oTaiXeqLs0IU1C
	RRhrCr/ax3bGUfxXKRsW7J/h7GxQfekd2RtT5ymriYYM+zreLp+PmQ6eGDWqtOuycQFcovcK66B
	8+BF381haby5/SFswcdjwBL1FZJlJZfi7hIJLkN9EgnSJTqEfw53S8yKWEfN79+dHUcpKVV6hW4
	PJ2NdlIAy31BaPbFRF0lnbENDX6WanhnsCYgQqdeF325ySJoT6FaveRZt/YEUW/uoTDUM91T2Er
	HG94xd+YxXg=
X-Google-Smtp-Source: AGHT+IHvbbHU5KMjzoEWzZpYrZ+40iRqLkc+O4ilyBXQOzUUk85eh2NEk9DM2NyRTSf3VS+sRcfChVOK+g6Cz/MM4FY=
X-Received: by 2002:a05:6000:2c02:b0:425:769e:515a with SMTP id
 ffacd0b85a97d-432c37610e6mr24456763f8f.42.1768238410323; Mon, 12 Jan 2026
 09:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108220550.2f6638f3@fedora> <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home> <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
 <20260109170028.0068a14d@fedora> <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
 <20260109173326.616e873c@fedora> <20260109173915.1e8a784e@fedora>
 <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
 <20260110111454.7d1a7b66@fedora> <CAADnVQJ_L_TvFogq0+-qOH=vxe5bzU9iz3c-6-N7VFYE6cBnjQ@mail.gmail.com>
 <20260111170953.49127c00@fedora> <CAADnVQJiEhDrfYVEyV8eGUECE_XFt7PGG=PFJRKU4jRBn-TsvA@mail.gmail.com>
 <20260112085257.26bb7b5b@fedora>
In-Reply-To: <20260112085257.26bb7b5b@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Jan 2026 09:19:58 -0800
X-Gm-Features: AZwV_QhtAWSH2DkU1WaheKjYNsqxXpmrkcmEEtxcChGC1gzMi1oK1QaiN4zEk0M
Message-ID: <CAADnVQKvY026HSFGOsavJppm3-Ajm-VsLzY-OeFUe+BaKMRnDg@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 5:53=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 11 Jan 2026 15:38:38 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > > Oh, so you are OK replacing the preempt_disable in the tracepoint
> > > callbacks with fast SRCU?
> >
> > yes, but..
> >
> > > Then I guess we can simply do that. Would it be fine to do that for
> > > both RT and non-RT? That will simplify the code quite a bit.
> >
> > Agree. perf needs preempt_disable in their callbacks (as this patch doe=
s)
> > and bpf side needs to add migrate_disable in __bpf_trace_run for now.
> > Though syscall tracepoints are sleepable we don't take advantage of
> > that on the bpf side. Eventually we will, and then rcu_lock
> > inside __bpf_trace_run will become srcu_fast_lock.
> >
> > The way to think about generic infrastructure like tracepoints is
> > to minimize their overhead no matter what out-of-tree and in-tree
> > users' assumptions are today, so why do we need preempt_disable
> > or srcu_fast there?
>
> Either preempt disable or srcu_fast is still needed.
>
> > I think today it's there because all callbacks (perf, ftrace, bpf)
> > expect preemption to be disabled, but can we just remove it from tp sid=
e?
> > and move preempt_disable to callbacks that actually need it?
>
> Yes if we are talking about switching from preempt_disable to src_fast.
> No if you mean to remove both as it still needs RCU protection. It's
> used for synchronizing changes in the tracepoint infrastructure itself.
> That __DO_TRACE_CALL() macro is the guts of the tracepoint callback
> code. It needs to handle races with additions and removals of callbacks
> there, as the callbacks also get data passed to them. If it gets out of
> sync, a callback could be called with another callback's data.
>
> That's why it has:
>
>                 it_func_ptr =3D                                          =
 \
>                         rcu_dereference_raw((&__tracepoint_##name)->funcs=
);
>
> >
> > I'm looking at release_probes(). It's fine as-is, no?
>
> That's just freeing, and as you see, there's RCU synchronization
> required.
>
> Updates to tracepoints require RCU protection. It started out with
> preempt_disable() for all tracepoints (which was synchronized with
> synchronized_sched() which later became just synchronize_rcu()).

I see.

> The issue that came about was that both ftrace and perf had an
> assumption that its tracepoint callbacks always have preempt disabled
> when being called. To move to srcu_fast() that is no longer the case.
> And we need to do that for PREEMPT_RT if BPF is running very long
> callbacks to the tracepoints.
>
> Ftrace has been fixed to not require it, but still needs to take into
> account if tracepoints disable preemption or not so that it can display
> the preempt_count() of when the tracepoint was called correctly.
>
> Perf is trivial to fix as it can simply add a preempt_disable() in its
> handler.
>
> But we were originally told that BPF had an issue because it had the
> assumption that tracepoint callbacks wouldn't migrate. That's where
> this patch came about.
>
> Now if you are saying that BPF will handle migrate_disable() on its own
> and not require the tracepoint infrastructure to do it for it, then
> this is perfect. And I can then simplify this code, and just use
> srcu_fast for both RT and !RT.

Agree. Just add migrate_disable to __bpf_trace_run,
or, better yet, use rcu_read_lock_dont_migrate() in there.

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fe28d86f7c35..abbf0177ad20 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2062,7 +2062,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link
*link, u64 *args)
        struct bpf_run_ctx *old_run_ctx;
        struct bpf_trace_run_ctx run_ctx;

-       cant_sleep();
+       rcu_read_lock_dont_migrate();
        if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
                bpf_prog_inc_misses_counter(prog);
                goto out;
@@ -2071,13 +2071,12 @@ void __bpf_trace_run(struct bpf_raw_tp_link
*link, u64 *args)
        run_ctx.bpf_cookie =3D link->cookie;
        old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);

-       rcu_read_lock();
        (void) bpf_prog_run(prog, args);
-       rcu_read_unlock();

        bpf_reset_run_ctx(old_run_ctx);
 out:
        this_cpu_dec(*(prog->active));
+       rcu_read_unlock_migrate();
 }
