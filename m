Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3C3A1A34
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483966; cv=none; b=U4VcTwh2FNiR2eSrYGKxTS9PYzdx6EPb3JnzLvPlEalS0DLPLKPXwzz4gzEsVPsP8dO21aHmx6eMvF6rselcSsd/5hIGT9DQbP92TUGxxFE3JBUHcW1O+Hm5kvtBg4EphiyVF8wrk0IJEh4iyReGSpV+WhtHApk8BAaVTapEMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483966; c=relaxed/simple;
	bh=GmrxhFqDWHlIuIsD4keNusucBO/J8p/xhbOz4P8gMk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYchf4vge3rcjoRD/U/jjNr9Q8fmENSpb2LakGZkXNMg1WhgUW8M3zq43eP7IFcMONlFTDzlba28iTVv4/iTQJeFOP6pVd85jjCKDJLNwMwp26ORVuwUQV6kAYo9z/grjJSFFywrBr89j2+Pr0jU6wG81k/CMN+gbOZuDi9F9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OckG1yMa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OckG1yMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768483963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12UR8iJ56CLzHZqPrDUAJq6DBQ1DPKTo5h0bZR9Juz0=;
	b=OckG1yMaAtnsgVvbgfcJVIbPPy6MxlP0WLshi6hmlci+FuHCEhVAhShOF6Qfa99+z1l1gP
	/VHzVNBxK9HV1xZM9lRL3OldMGogt0DTOSKQ942f2TMRGk67DhqPLfT7Yo6w6hHr3vRud0
	gvSEjT0qM3e/W7rkHVatPX0qhW0BS7k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-_-jkgjtBOfGSCigNqx2n2A-1; Thu, 15 Jan 2026 08:32:40 -0500
X-MC-Unique: _-jkgjtBOfGSCigNqx2n2A-1
X-Mimecast-MFC-AGG-ID: _-jkgjtBOfGSCigNqx2n2A_1768483959
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b877f048350so104942366b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 05:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768483959; x=1769088759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=12UR8iJ56CLzHZqPrDUAJq6DBQ1DPKTo5h0bZR9Juz0=;
        b=cmci6iAX7woniRM1Ysen7+T47dpt/eFrQhXNG0y5JEgPnF9A/2baC9ha6M9WbvOOXD
         qvIsDWG4DQ4Oy3AGXheuKYMvtrkupjTtuk3mrr84WtS5hJW9kQhNKkZP6q/0CXSU4bHX
         AwrXHTiO5iSsk7GeKFDhGiyNU7Mnj0HtQTV8RAkWEuqWUm9PI99E51iHhLLgVuxbB/Xc
         zCVvk34xGd/hE2KF+FbuKg2ZT0r6/W6jvyDnTTfzsT4jTWVj+lbI9fTgiZA/GDNaD7rB
         TEfwgxu0wc5P8FxK14bCPqXhezLzUq+iMjLVyj2XYqZnuZJaYqo48/5u9cqhLMX8lmnw
         c9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVONwDCoH1RDraM+eHx8x9KFwYSWwWmax2NGD8vVBPih1EPPPlPoBvFhtFj6i9LweaW9kXRad9eTQLNXAcQ4rP0Sik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDW2Rc2OzjPF5PAP9fbNw3KTmMeDw7MNhVsY/jCu99fcoZDO/Q
	TC7vtL7lXynLoR6mLiSVhNoXunBjI0e04abo/SNThgpW1Gj1T2KW2F13FBUvYL1h8IffexyN48/
	h4/jJCVTKhNbTvJRFS0eBQxV+DrLuZrzpETdYUru/C8FT0im8O61/rJ/VMoqHTlp/7OZ3V/WLeE
	18EKcj9PJzl4gnLvpOfCSR8NAM/XwgIciSv5xdWWTzg/yriG/m
X-Gm-Gg: AY/fxX7bq7RvdTwNLYzhkYyXZw72lbWHTYCj/rqwADd534MeQ/Rr2StVd7XjjsuMI3M
	/dQBCaHb8M4M52vkLpkeDysu7pGyk0+rcKRo/2h4TtI15G2HppeMJ+FghetJCn7ovfIY8NYyYko
	g9q2Z9bE6/1oRgRitxPmVVSKfJbY71T5RSgp1VQO60+I+zMSStqG6MVfnOa1Jh8ksj+g==
X-Received: by 2002:a17:907:c24:b0:b87:1d30:7ec with SMTP id a640c23a62f3a-b87677a7f7fmr480982866b.37.1768483959358;
        Thu, 15 Jan 2026 05:32:39 -0800 (PST)
X-Received: by 2002:a17:907:c24:b0:b87:1d30:7ec with SMTP id
 a640c23a62f3a-b87677a7f7fmr480980766b.37.1768483958825; Thu, 15 Jan 2026
 05:32:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114123547.583859-1-tglozar@redhat.com> <bbb834f13cb1480b2517497481a1b3e0137d089a.camel@redhat.com>
In-Reply-To: <bbb834f13cb1480b2517497481a1b3e0137d089a.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 15 Jan 2026 14:32:27 +0100
X-Gm-Features: AZwV_QjaAXC6_PzvUH9xOzBbWehyeh4oL0qbhhFXL785-EOHz9JP2qOLr-HicK4
Message-ID: <CAP4=nvQeBnAtbQFjAdKhQUP1_Xi2uEH0i+kZC6TZwu7GZJYu3w@mail.gmail.com>
Subject: Re: [PATCH] tracing/osnoise: Fix OSN_WORKLOAD-related crash
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m_t6GqnxC5GhJ1NGyaEL9gwI3vNkuGMV_cZEsVWiChQ_1768483959
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 14. 1. 2026 v 20:49 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> nap=
sal:
> >
> > The kernel first displays several WARN traces with the following patter=
n:
> >
> >    WARNING: CPU: 1 PID: 1822 at kernel/trace/trace_osnoise.c:1959 stop_=
kthread+0xb7/0xc0
>
> The line number doesn't match up for me; is this the first or second
> WARN_ON in that function?

The first one [1], sorry for the confusion, I used a log from an old
CentOS Stream 10 kernel for the commit description.

[1] https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/b=
lob/7482e1508860dc8009827f87970b2f48fca251d4/kernel/trace/trace_osnoise.c#L=
1959

> > and finally a null pointer reference BUG:
> >
> >    BUG: kernel NULL pointer dereference, address: 0000000000000030
> >    ...
> >    CPU: 1 UID: 0 PID: 2155 Comm: timerlatu/1
> >    ...
> >    Call Trace:
> >      ...
> >      ? timerlat_fd_read+0xf2/0x370
> >      ? timerlat_fd_read+0xee/0x370
> >      vfs_read+0xe8/0x370
> >      ksys_read+0x6d/0xf0
> >      do_syscall_64+0x7d/0x160
> >      ...
> >      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> What's the actual fault location?  And those ? lines in the call trace
> are "considered to be additional clues" rather than actual unwound
> frames; what was in the ... above them?

Ah I dropped one line more than I wanted, the fault is in timerlat_fd_read:

[  513.050331] BUG: kernel NULL pointer dereference, address: 0000000000000=
030
[  513.050345] #PF: supervisor read access in kernel mode
[  513.050350] #PF: error_code(0x0000) - not-present page
[  513.050354] PGD 0 P4D 0
[  513.050358] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  513.050364] CPU: 1 UID: 0 PID: 2155 Comm: timerlatu/1 Kdump: loaded
Tainted: G        W         -------  ---  6.12.0-35.el10.x86_64 #1
[  513.050375] Tainted: [W]=3DWARN
[  513.050378] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-3.fc41 04/01/2014
[  513.050385] RIP: 0010:timerlat_fd_read+0xf2/0x370
[  513.050392] Code: f7 53 e3 a5 9b c4 20 48 89 e8 48 c1 e8 03 48 f7
e2 48 c1 ea 04 48 39 ca 0f 83 8c 01 00 00 48 89 df e8 a2 f9 ff ff 48
8b 43 38 <48> 8b 40 30 ff d0 0f 1f 00 48 2b 43 50 48 89 c5 78 49 48 8b
43 60
[  513.050406] RSP: 0018:ffffadd181227df8 EFLAGS: 00010246
[  513.050411] RAX: 0000000000000000 RBX: ffff93739fd2e680 RCX: 00000000000=
00000
[  513.050417] RDX: ffff937365b21560 RSI: ffff93734106b180 RDI: ffff9373422=
b4280
[  513.050422] RBP: 000000000000b38b R08: 0000000000000000 R09: 00000000000=
00001
[  513.050427] R10: 0000000080170010 R11: ffff93734106b180 R12: ffff937342c=
186c0
[  513.050433] R13: 0000000000000001 R14: 00007f6e618dca90 R15: ffffadd1812=
27ed0
[  513.050547] FS:  00007f6e618dd6c0(0000) GS:ffff93739fd00000(0000)
knlGS:0000000000000000
[  513.050659] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  513.050766] CR2: 0000000000000030 CR3: 000000000354e006 CR4: 00000000007=
72ef0
[  513.050888] PKRU: 55555554
[  513.051006] Call Trace:
[  513.051134]  <TASK>
[  513.051249]  ? show_trace_log_lvl+0x1b0/0x2f0
[  513.051363]  ? show_trace_log_lvl+0x1b0/0x2f0
[  513.051476]  ? vfs_read+0xe8/0x370
[  513.051591]  ? __die_body.cold+0x8/0x12
[  513.051706]  ? page_fault_oops+0x146/0x160
[  513.051823]  ? exc_page_fault+0x73/0x160
[  513.051941]  ? asm_exc_page_fault+0x26/0x30
[  513.052060]  ? timerlat_fd_read+0xf2/0x370
[  513.052187]  ? timerlat_fd_read+0xee/0x370
[  513.052300]  vfs_read+0xe8/0x370
[  513.052410]  ksys_read+0x6d/0xf0
[  513.052519]  do_syscall_64+0x7d/0x160
[  513.052630]  ? clear_bhb_loop+0x25/0x80
[  513.052742]  ? clear_bhb_loop+0x25/0x80
[  513.052853]  ? clear_bhb_loop+0x25/0x80
[  513.052963]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  513.053081] RIP: 0033:0x7f6e619d7bbc
[  513.053217] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08
e8 b9 8f f9 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31
c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 0f 90 f9
ff 48
[  513.053470] RSP: 002b:00007f6e618dc910 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  513.053599] RAX: ffffffffffffffda RBX: 00007f6e618dca90 RCX: 00007f6e619=
d7bbc
[  513.053731] RDX: 0000000000000400 RSI: 00007f6e618dca90 RDI: 00000000000=
00003
[  513.053863] RBP: 00007f6e618dced0 R08: 0000000000000000 R09: 00007f6e5c0=
00b90
[  513.053998] R10: 00007f6e5c0008e0 R11: 0000000000000246 R12: 00000000000=
00001
[  513.054145] R13: 0000000000000003 R14: 0000000000000000 R15: 00000000000=
00001
[  513.054288]  </TASK>

I didn't look deeply into the mechanism of the crash, I just thought
that this is not a valid state to be setting OSNOISE_WORKLOAD in the
first place, so I can just disallow it and I don't have to dig deeper.

> >  static int osnoise_options_open(struct inode *inode, struct file *file=
)
> >  {
> >       return seq_open(file, &osnoise_options_seq_ops);
> > @@ -2229,6 +2254,10 @@ static ssize_t osnoise_options_write(struct file=
 *filp, const char __user *ubuf,
> >       if (option < 0)
> >               return -EINVAL;
> >
> > +     retval =3D osnoise_validate_option(option, enable);
> > +     if (retval !=3D 0)
> > +             return retval;
> > +
> >       /*
> >        * trace_types_lock is taken to avoid concurrency on start/stop.
> >        */
>
> Shouldn't this be done under interface_lock to avoid concurrent
> timerlat_fd_open()?  FWIW, your test script doesn't appear to cover the
> case of option setting racing with timerlat starting (due to the 2
> second delay).

My patch only takes into account the sequential case, which is already
rare to trigger - I don't know about any cases where this happened
during normal use. I would normally put the code behind the
interface_lock, if there weren't the stop_per_cpu_kthreads() thing in
between.

> Of course, this is complicated by stop_per_cpu_kthreads() happening
> before interface_lock is acquired.  Do we know why that happens outside
> the lock?  That might even be the actual cause of this bug.

Before commit b484a02c9c ("tracing/timerlat: Drop interface_lock in
stop_kthread()"), stop_kthread() took interface_lock, so
stop_per_cpu_kthreads() couldn't be called while holding
interface_lock. As that is no longer the case, the position of taking
interface_lock in osnoise_options_write() could be re-evaluated
(comment in 5bfbcd1ee57b says interface_lock cannot be taken at the
same time as cpu_read_lock).

I don't think it's directly related to this bug. All operations in the
reproducer are expected to be executed in sequence, so the lock should
have no effect on it.

> Though even in the non-race case, we might still want to return -EBUSY
> rather than just killing the thread (which might still have races since
> we don't wait for the user thread to die).

Yes, if we want to change the semantics to kill the user threads and
restart kernel threads on setting OSNOISE_WORKLOAD, we have to take
into account that the user threads might take an indefinite amount of
time to exit. The idea of my patch is to let the user dispose of the
user threads rather than the tracer, that will also avoid possible
deadlocks.

Tomas

