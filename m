Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2B342C9E
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Feb 2026 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770584083; cv=none; b=Z9VeM51WiGcL83oEpscEag6pi6cYqFbqMy0Ds/fpf0OEcpOgmdEE9me38cwSQURs1ZkvsJ8TzLKxBUb857v1+OU+C4PF83fRRp+B8XWFc3mORs29s0XLDT9AyQdgkoQhMJejAUskCrUy39BOyLRLcu0WGlS4Zuiq95GbUUiHzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770584083; c=relaxed/simple;
	bh=eK05MBlMzImiefkpgxbWyOhV3iimcUuSiDy9MKaaclo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaBG87Au8E2DLpGcvotK3zYEea9hXrWlcEDR4eIEHY3UWLth57FWl3EWE6s63pijYmiTvgqCycS+8H56KiYDt0ezISL7ICpUEw01tNISAxviDh9QpwDoqoWn76SS7+OTAzbEcjbqGDKk6WWufFs3EEKDq6vYUmbvwa6i7pV9dwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlNNroyx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlNNroyx"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so28201955e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 08 Feb 2026 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770584081; x=1771188881; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7EEz2ZzYiyLdsMM9R6IByMZnU2nWj69epSM+E7T1+is=;
        b=BlNNroyxn/uXbLwXsxEsV2WCJ9mosbbv24+LgpDT5WINiiNgj1RlSWHDCZtYw4FySQ
         lhgJy7k0Lm67GTUGjKcZ5eRBQcQW6MjgKYQ92Z+80kWe1eSi1ldOFCIrxfdbKzdILnka
         i9LVKZuKFoguKOWrd5ueeSjiI4R9diFek1gWHv+znWhJbVjlAhnbUt1nPdo7W9Kebo1a
         +6gx8mS+A47Un4TcwtJ/lm6yCbxKiXfspgEKDuG3W5+AjV229XcwaqTgc8qEvikOIEH2
         r+MHlPHDLuv8uftFFZ/MrFyW1N43+1TS+2APV4++BmOPLl8DCPVXXSFr8Hry0uBobk4N
         zLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770584081; x=1771188881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EEz2ZzYiyLdsMM9R6IByMZnU2nWj69epSM+E7T1+is=;
        b=Aeah1Ipis5xBasYIKhuTD2YQDagSj4naAQjDpUxRB0Mt32vY2AU73ywttjcdU0aLq/
         zsZh1Kx1LpB64vAWvvtKVfcD9L3c/+UVPbzXNyygMnyq1JGKPKpR+HYmm05aaSzqyPVq
         L2UEddJAT3sI1bQp/O4xC/iv4Zx7STp9V1gKJwPb3Q9iX3xmh+3pS8qoPmTwrQJVhm/D
         0o/TwhB7q05KaW2D70hx0a4+ZnlQWAGthOJvynGw9DKQtXkKH6kTyoNE8V36tGQqoSO9
         uSmq5IqdZayF4XkVNujthmTxWBf5m9Qb5t9ah5edM1FpLubYlBJRsAL3Y7HuZV+LyC81
         Y/zw==
X-Forwarded-Encrypted: i=1; AJvYcCU4DKXEgzpOcZjYjMbQTMDR+tr+tz5Oo5oTx27WUkasjjYB0Pfu6U/qrgSD9Wh0zZ8GEaSfGYHSMVy0Lw9yPtvcsis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqfPJie14nDRlpNx8SlONBuQ5qqV028pIzkrvLKGY78kvCrqg
	n2usyPvTOyzE3QQ1O9j5DZLSBP7u2NWGrRLskFgXIzBon+iwEiAu4J3r
X-Gm-Gg: AZuq6aKYj70Y3r/yq5Q4fwNyzwKvItV8LcL1Yq6czRAuW32/5hZbz6wL4MC8+wvwUb1
	frtHwiOsENmfxput0ILJryNLT/qfw0hnmmGDBeAUySVK9dWe1MwgvviYXI/eipQBS7Z3Vps3U+M
	7S/RLv4IszTJnXgFgCf110V03eR2bhBDaSSqhkKR89adZ2md9cOywbhssIOrMet3ElsaMFs+L4r
	dcJLWZuG9UpXGyJIB8iSnLJq6RzFl7LteyNQKM3MrecDk9uS0VwdtRRNEMvP7JifLwjQIQQ0H6k
	U3uVUFKSbzTHyaPwJ7YP4QxfznyVU02HgWPJyD3xJPcFWP6KblpOafB6tThVkj2BVkTUGh83Dwg
	CbTwInLRNPXxBitFJasJF/a1oimQB5JRFbBKBsqsEqwD710DfYvJ4HBdQEASFc9lUsMrOQeZ08k
	I=
X-Received: by 2002:a05:600c:1e0d:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-483201da2f1mr132554955e9.2.1770584081273;
        Sun, 08 Feb 2026 12:54:41 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd211sm22939470f8f.13.2026.02.08.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 12:54:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 8 Feb 2026 21:54:38 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
Message-ID: <aYj4DnCDlUHUSPgU@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
 <aYM9YUl6xf9I2x4c@krava>
 <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>
 <aYRa_CDL1RqIR_8S@krava>
 <CAADnVQLJJn=bSDvQrjNyyeNdLOZABKDjjR_3j6DG3pgbsJ+JXA@mail.gmail.com>
 <aYWjxMeXABGcYqEI@krava>
 <CAEf4BzbUX8xEp1x66ugtj1C6sxWPJ+_9EpyVmy3TVOMiKrFcWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbUX8xEp1x66ugtj1C6sxWPJ+_9EpyVmy3TVOMiKrFcWA@mail.gmail.com>

On Fri, Feb 06, 2026 at 09:03:29AM -0800, Andrii Nakryiko wrote:
> On Fri, Feb 6, 2026 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Feb 05, 2026 at 07:55:19AM -0800, Alexei Starovoitov wrote:
> > > On Thu, Feb 5, 2026 at 12:55 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 04, 2026 at 08:06:50AM -0800, Alexei Starovoitov wrote:
> > > > > On Wed, Feb 4, 2026 at 4:36 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> > > > > > > On Tue, Feb 3, 2026 at 1:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > > > >
> > > > > > > > hi,
> > > > > > > > as an option to Meglong's change [1] I'm sending proposal for tracing_multi
> > > > > > > > link that does not add static trampoline but attaches program to all needed
> > > > > > > > trampolines.
> > > > > > > >
> > > > > > > > This approach keeps the same performance but has some drawbacks:
> > > > > > > >
> > > > > > > >  - when attaching 20k functions we allocate and attach 20k trampolines
> > > > > > > >  - during attachment we hold each trampoline mutex, so for above
> > > > > > > >    20k functions we will hold 20k mutexes during the attachment,
> > > > > > > >    should be very prone to deadlock, but haven't hit it yet
> > > > > > >
> > > > > > > If you check that it's sorted and always take them in the same order
> > > > > > > then there will be no deadlock.
> > > > > > > Or just grab one global mutex first and then grab trampolines mutexes
> > > > > > > next in any order. The global one will serialize this attach operation.
> > > > > > >
> > > > > > > > It looks the trampoline allocations/generation might not be big a problem
> > > > > > > > and I'll try to find a solution for holding that many mutexes. If there's
> > > > > > > > no better solution I think having one read/write mutex for tracing multi
> > > > > > > > link attach/detach should work.
> > > > > > >
> > > > > > > If you mean to have one global mutex as I proposed above then I don't see
> > > > > > > a downside. It only serializes multiple libbpf calls.
> > > > > >
> > > > > > we also need to serialize it with standard single trampoline attach,
> > > > > > because the direct ftrace update is now done under trampoline->mutex:
> > > > > >
> > > > > >   bpf_trampoline_link_prog(tr)
> > > > > >   {
> > > > > >     mutex_lock(&tr->mutex);
> > > > > >     ...
> > > > > >     update_ftrace_direct_*
> > > > > >     ...
> > > > > >     mutex_unlock(&tr->mutex);
> > > > > >   }
> > > > > >
> > > > > > for tracing_multi we would link the program first (with tr->mutex)
> > > > > > and do the bulk ftrace update later (without tr->mutex)
> > > > > >
> > > > > >   {
> > > > > >     for each involved trampoline:
> > > > > >       bpf_trampoline_link_prog
> > > > > >
> > > > > >     --> and here we could race with some other thread doing single
> > > > > >         trampoline attach
> > > > > >
> > > > > >     update_ftrace_direct_*
> > > > > >   }
> > > > > >
> > > > > > note the current version locks all tr->mutex instances all the way
> > > > > > through the update_ftrace_direct_* update
> > > > > >
> > > > > > I think we could use global rwsem and take read lock on single
> > > > > > trampoline attach path and write lock on tracing_multi attach,
> > > > > >
> > > > > > I thought we could take direct_mutex early, but that would mean
> > > > > > different order with trampoline mutex than we already have in
> > > > > > single attach path
> > > > >
> > > > > I feel we're talking past each other.
> > > > > I meant:
> > > > >
> > > > > For multi:
> > > > > 1. take some global mutex
> > > > > 2. take N tramp mutexes in any order
> > > > >
> > > > > For single:
> > > > > 1. take that 1 specific tramp mutex.
> > > >
> > > > ah ok, I understand, it's to prevent the lockup but keep holding all
> > > > the trampolines locks.. the rwsem I mentioned was for the 'fix', where
> > > > we do not take all the trampolines locks
> > >
> > > I don't understand how rwsem would help.
> > > All the operations on trampoline are protected by mutex.
> > > Switching to rw makes sense only if we can designate certain
> > > operations as "read" and others as "write" and number of "reads"
> > > dominate. This won't be the case with multi-fentry.
> > > And we still need to take all of them as "write" to update trampoline.
> >
> > this applies to scenario where we do not hold all the trampoline locks,
> > in such case we could have race between single and multi attachment,
> > while single/single attachment race stays safe
> >
> > as a fix the single attach would take read lock and multi attach would
> > take write lock, so single/single race is allowed and single/multi is
> > not ... showed in the patch below
> >
> > but it might be too much.. in a sense that there's already many locks
> > involved in trampoline attach/detach, and simple global lock in multi
> > or just sorting the ids would be enough
> >
> 
> I'll just throw this idea here, but we don't have to do it right away.
> What if instead of having a per-trampoline lock, we just have a common
> relatively small pool of locks that all trampolines share based on
> some hash (i.e., we deterministically map trampoline to one of the
> locks). Then multi-attach can just go and grab all of them in
> predefined order, while singular trampoline attaches will just get
> their own one. We won't need to sort anything, we reduce the amount of
> different locks. I don't think lock contention (due to lock sharing
> for some trampolines) is a real issue to be worried about either.

nice idea, I'll check on that

thanks,
jirka
