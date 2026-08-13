Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023EB248F72
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 04:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594607; cv=pass; b=Y21fFcNgLYPAlcvzmVkRB6f6l13fSI4479CHZapC+QicQJMlIWlwOiWTXEm8Dy51WRpP7ZzfZBVEdeB9KXugFImV5t/ack/Z8yYiiEhRIASfRunNuaQtD9mUZBatfD9C4KhbKNmgFo/B4GbgHTU4NMl+pkDCMyJQpgJtSnJvWu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594607; c=relaxed/simple;
	bh=kyvju2B3kVRFWxtt3UBGqzSAAkahmS3D2grt7G1bekA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmLVugnOrL85jwcPFjE17q05fkB5dX2rpydumPNCr5wWnyu8ZH6wsuwjgs74TYyVFqpDYyOgqzGF4doVQCepwEDA/+77pZKYBE8+KTOyQOCQ+hOQH8Mp9xqbmVtey8e4iGIKOLsQKwrXA5d+h1JjIZ732GcJC2jeqoBV5CstNO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=req0uku2; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="req0uku2"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6626b5ace23so912940d50.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 21:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786594604; cv=none;
        d=google.com; s=arc-20260327;
        b=LtoNgyib9Bk8ZQFpgsQIaZMArpCK4I3eE/H7BmEW95SbgPMW3M+MrWJSYxoJNymlir
         Q/jhqLulWpQMXXr1cfRDKaEeQuVFbJN1Scf3b1cHiY4WYKjTmYKGuVWjw2Nv46tXHi+k
         chs965Jc9TfvnzFAcCz1oteSi2VM4K+yMfvLlLOOC5cHCCjez1RZ6nQVY06RxdqFE2d9
         K9MhD/g7/uCaWLlG5tkW2iV3sYaT8P8h/4oWwGsBX3fGM2X8TxGibeaweijYPXkzLoOR
         FM00e1Y5BDOfCg/wjOYn+cg7vIHEFyresmYgIgicYNvakPTnHONTQBhP9O2QxzD+OWmD
         uB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hj+aZ+4yYhvsPaAhIqtP1+VT7SwFhpMGkiPhnjwuFe4=;
        fh=pSANr0tXDoaLZyqrtwLvhUx9ZJUsY7KzfHMo0RQZcD8=;
        b=eRxUWrhLFa9LG7J3XohF7LLCvhvv8ycOYwLtboviUJUtkIKQRZ/DOJ7FOWzrW9CSD1
         kYgB3OQhDlwUSfDTVQksqqEGeblXkIh/ZcPanfqwV2Itv3mCWWOWT7dQh+uHjfsms2vk
         Y1fr8O0djh7W3fsYqG5G3DZs329BmAYCby/xUVjzgyEGvP5RebTSSiQgxMs6Aq5QRn/v
         QVCZi7ythr0BsweOhDamGwru/w3NJHBqKINupts7rX6zTpC0nw0KbaXY97KxmU3qlp5U
         3keiqjTTHb1XpAudDCgV9IwrBRq5+f5LppBJPOG+K37W2NS+6R3tFCwMx2J4c99c6qpo
         6iwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786594604; x=1787199404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hj+aZ+4yYhvsPaAhIqtP1+VT7SwFhpMGkiPhnjwuFe4=;
        b=req0uku2ETWcB1cJ2WbF+yaXE5uKne+ndkbW/DLtlXfjIvKjv/4VyEKJxoTADWlfnj
         d46ebDXkahmv8Bh16F/Bfu2r0fbOmILJyi7ykzRysVZRDFppPSGB+jTk4bo/Ir7Q+KM/
         RELAr6vOHdQK61h5/CcQRRXzOVl+ZYKFdLkUhM6gQqFHjHO/O+j6PTFKHruVHV/R+J06
         v4zG77kcrZL2A7aZrnLTrgPRa8F7buTYUF9gR5MR3BfiUhyROYK2uUGv2zV+OF9LudtF
         kVWP5ly+9HZBgcCjCvsxjo/YIUEttSzDsSS7H2N8xK67I6l88rw9IXQT46vo9Gh1VJx+
         841g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786594604; x=1787199404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hj+aZ+4yYhvsPaAhIqtP1+VT7SwFhpMGkiPhnjwuFe4=;
        b=g1Od+V6frfxBjhwrVwseNU5S7WEz75H5yC1VO/8iwJ0BV+f0TwBAeAeEGTYiCoAbif
         WD73uKT0YbeGaygpl3GmhoxmgXVNs8JU1L70qXoEPz4x1fM08y4l8gAM0i2Zzy463dFJ
         sKyHVX6nswWOQSWkjHknn0geXSuDBqQlEZYavjEIaYOdTNmwuakRlLtPZKGwLjI3QfRl
         Mb4vtcmmxMz3CRI0N5HQs6ekpofzkT+yX7By2dRPa+I6n5rFTkfoR6BmajvF5Kv5tLSC
         mDacsf/yAF70j9+gI1nqeBNad+ECr/vsGHQbgZwrjDhuJ76Q7O8EhzKOW4GNfHzQVLqO
         JgnQ==
X-Forwarded-Encrypted: i=1; AHgh+RongtD01ZjuEHKb1ZszK7ro5RnT3KUt+9Sy/4UeiyN+KgAzrlLZIh833qF5nOX7zSXnFaBUqARmFfGQoXEd7X8CD50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpFPBEhBBybGkqqYgiO5QSgoekayFNLlgwy36isvwY96CA3fY
	0mqMdFlcEvCAFjSifY4qiDr3skJ9SRuwJKzW3GI36XDAdv3PSxkHpr9Z96Ix4zCcMRsqbDroMl6
	5CX5ZQ7aqZPvW7ExkB2DfQt/Dhcl64bI=
X-Gm-Gg: AR+sD11qsFJU4nhMItOweMkHZR/3rvuEYq5MXT5D4fmuENl9IEDfQGeoBc4Ct+xzJwO
	bHsBIf5V7a5Obyqgz2Pxlp0DRLHW1Xm6kjlM1uXEOgprz+o7UPsbNH1O6EY7/HQwwXx33T3lEVR
	564biD5wku+fdBEcJfgDTjn/HaVBP1Dj1dPSzDCbAz0sRIOEleH698WCGUFNt/SKltE2HprFvxe
	PVUF0XWi7bJTmxsOhba9pE/gM2OcXzO9J1TXyhWui/3PW0aAORe1/3qxQBw6ez4mLf7L1JUchGI
	9yXYdf86P0yrplGDTfBxdt9l35ZLTudLkeOMQf8focSs8ABsrdhOHwpxAxRBj+Gsoqp4AAO4ITf
	QcPPkg+S2TRpO15x7kNLzKaiffvtWGOCPUN+TGv8B/XjN
X-Received: by 2002:a05:690e:2584:b0:668:a17:daed with SMTP id
 956f58d0204a3-66c54c49056mr818130d50.21.1786594604022; Wed, 12 Aug 2026
 21:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811235331.10044-1-kartikey406@gmail.com> <20260812000859.654FC1F00A3A@smtp.kernel.org>
 <anxMXBwCX0HCYgxr@krava>
In-Reply-To: <anxMXBwCX0HCYgxr@krava>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 13 Aug 2026 09:46:31 +0530
X-Gm-Features: AUfX_mwfqzym4wGlqOQexfSsnhGUEHmMvw1zBvwX7sKbdWrWjMFru5WvJUuewL8
Message-ID: <CADhLXY5QdvPjyK+X0q4S4wF71CTt-RQ76fHt_W=x-BmVka9LAQ@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Fix data race in __perf_event_overflow
To: Jiri Olsa <olsajiri@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 4:05=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Aug 12, 2026 at 12:08:58AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> >
> > Pre-existing issues:
> > - [High] Lockless TOCTOU race in perf_event_alloc() causes NULL pointer=
 dereference or Use-After-Free during BPF program inheritance.
> > - [Medium] Incomplete fix for data races and missing memory barriers in=
 BPF attach/detach paths.
> > - [Medium] Time-of-Check to Time-of-Use (TOCTOU) race drops valid perf =
events during concurrent BPF detach.
> > --
> >
> > --- Patch [1]: [PATCH] perf/bpf: Fix data race in __perf_event_overflow=
 ---
> > commit f63a2be5ceb79a2a8bb0263ba6723f7bf4ae763d
> > Author: Deepanshu Kartikey <kartikey406@gmail.com>
> >
> > perf/bpf: Fix data race in __perf_event_overflow
> >
> > This patch addresses a data race where __perf_event_overflow() concurre=
ntly
> > reads event->prog without lock protection while perf_event_detach_bpf_p=
rog()
> > writes it to NULL. It fixes the race by introducing READ_ONCE() and
> > WRITE_ONCE() in the respective read and write paths.
> >
> > Reported-by: syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D651d2774bd1d8395595f
> > Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through =
overflow machinery")
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> >
> > [ ... ]
> >
> > > @@ -10766,7 +10767,8 @@ static int __perf_event_overflow(struct perf_=
event *event,
> > >     if (event->attr.aux_pause)
> > >             perf_event_aux_pause(event->aux_event, true);
> > >
> > > -   if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EV=
ENT &&
> > > +   prog =3D READ_ONCE(event->prog);
> > > +   if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> > >         !bpf_overflow_handler(event, data, regs))
> > >             goto out;
> >
> > [Severity: Medium]
> > This isn't a bug introduced by this patch, but does the independent sec=
ond
> > read in bpf_overflow_handler() create a time-of-check to time-of-use ra=
ce?
> >
> > If a concurrent detach sets event->prog to NULL between the READ_ONCE()=
 here
> > in __perf_event_overflow() and the second READ_ONCE() inside
> > bpf_overflow_handler():
> >
> > bpf_overflow_handler() {
> >     prog =3D READ_ONCE(event->prog);
> >     if (prog) {
> >         ...
> >     }
> >     return 0;
> > }
> >
> > Wouldn't bpf_overflow_handler() evaluate prog as NULL and return 0? The
> > caller __perf_event_overflow() evaluates !0 as true and executes goto o=
ut,
> > which unconditionally drops the perf sample.
> >
> > Should the already-validated prog pointer be passed directly to
> > bpf_overflow_handler()?
>
> seems legit
>
> >
> >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -2018,7 +2018,7 @@ void perf_event_detach_bpf_prog(struct perf_eve=
nt *event)
> > >
> > >  put:
> > >     prog =3D event->prog;
> > > -   event->prog =3D NULL;
> > > +   WRITE_ONCE(event->prog, NULL);
> > >
> > >  unlock:
> >
> > [Severity: Medium]
> > This is a pre-existing issue, but does this incomplete fix leave other =
data
> > races in the attach and detach paths?
> >
> > Other functions like perf_event_set_bpf_handler(),
> > perf_event_free_bpf_handler(), and perf_event_attach_bpf_prog() still
> > perform plain writes to event->prog without WRITE_ONCE().
>
> was wondering the same, the perf_event_detach_bpf_prog is called for
> tracing events (tracepoint/kprobe/uprobe) the perf event release goes
> through perf_event_free_bpf_handler, check perf_event_free_bpf_prog
>
> jirka
>
> >
> > Additionally, does this need release and acquire semantics? If the writ=
es to
> > event->prog and event->bpf_cookie in the attach paths are reordered by =
the
> > CPU, could the NMI handler read a valid event->prog but a stale or
> > uninitialized event->bpf_cookie?
> >
> > [Severity: High]
> > This is also a pre-existing issue, but does the lockless access in
> > perf_event_alloc() create a use-after-free or NULL pointer dereference
> > during BPF program inheritance?
> >
> > During fork, perf_event_alloc() inherits the BPF program:
> >
> > perf_event_alloc() {
> >     ...
> >     if (parent_event->prog) {
> >         struct bpf_prog *prog =3D parent_event->prog;
> >         bpf_prog_inc(prog);
> >         ...
> >     }
> > }
> >
> > Since this accesses parent_event->prog locklessly, can a concurrent
> > bpf_perf_link_release() clear the pointer? If the compiler reloads the
> > pointer after the check, bpf_prog_inc() would dereference NULL.
> >
> > Even if it is optimized to a single read, perf_event_alloc() is not ins=
ide
> > an RCU read-side critical section. Could a concurrent detach finish its=
 RCU
> > grace period and free the BPF program, causing bpf_prog_inc() to write =
to
> > freed memory?
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811235331.=
10044-1-kartikey406@gmail.com?part=3D1
> >


Thank you for the thorough review!

On the three issues raised:

[1] TOCTOU in bpf_overflow_handler():

You are correct. The second READ_ONCE() inside bpf_overflow_handler()
creates a TOCTOU race. If a concurrent detach sets event->prog to NULL
between the two reads, bpf_overflow_handler() returns 0, causing
__perf_event_overflow() to drop the perf sample via goto out.

I will fix this by passing the already-validated prog pointer directly
to bpf_overflow_handler() instead of having it re-read event->prog.

[2] Incomplete fix - other write paths:

Thanks Jirka for pointing out that perf_event_free_bpf_handler() is
used for handler-based events (tracepoint/kprobe/uprobe). You are
right that my fix is incomplete.

I will extend the fix to also add WRITE_ONCE() in:
- perf_event_free_bpf_handler()
- perf_event_set_bpf_handler()
- perf_event_attach_bpf_prog()

[3] Lockless access in perf_event_alloc() - UAF:

Agreed. The lockless access to parent_event->prog in
perf_event_alloc() during fork can lead to NULL pointer dereference or
use-after-free if a concurrent detach clears and frees the prog.

I will fix this by using READ_ONCE() to capture the pointer atomically
before the NULL check.

I will send a v2 patch addressing all three issues.

Thanks

Deepanshu
