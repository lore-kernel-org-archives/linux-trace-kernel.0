Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD71DA53;
	Fri,  4 Apr 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785512; cv=none; b=cqeuJKOsgcQmf7zMhBAEQjiFpODr9lnue5A69J9V6ax0MZG3e5+EVHKhmxCyAKjkInnGPchzP2TuIK6FTF9eDxucTqmco0o267htj8t/uJln2jLjDyhDDWrMASkgpdDPc6P8i4+xYCTKDt95loLqYu+Zg5hZfIydJJDdR88AI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785512; c=relaxed/simple;
	bh=k/1i68EDhtfGaWp4Zjr/ho+pU2UjPOi9WaiMdKbnryI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9dLy1ulWQoSBj9zcZl1ynZUmuR/ns41+qb87jY1AUlj5xcdsuYB8Gx0B9x/nUeiLDSL+4chFmUFyil+jEH0EirU2/hROtjdb5dRh8Kfkb9mlcd9g3pGK8mApaLp72LKMnA7jaYb5ByVTnKRrkW4BeSckjETFi7GzSfBy0OWKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFIKEcV/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFIKEcV/"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54b166fa41bso2383508e87.0;
        Fri, 04 Apr 2025 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743785509; x=1744390309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCJOxCsq4sP6eihazz9u78w+Z/VcmA1ipTY8uGgwWqQ=;
        b=DFIKEcV/OOdulk04GAl1peHltsDAkEdoSYSR5wdx3P0NJpRFiTHzIydB0i/z/q6pT6
         erzUK8Gw307/D5njZSlJdHdAMIcLV80XODWAAR9YDyB6h2QCJoWeEl8SA3lV2S3BZygW
         1JxeUxIHk6LNxtMt9/HRVqQOu7IQiPP+lpVwldbW3iR0iwWBhMOI7KD5KtpYgmzyHQ+L
         Bng+R61Sp0vykGsFo8oArBmCLAKzp7NYjGA3UgKe6cDK8siroOCSsNtzPzVNn8t0uk3Z
         RRH9RLTEEC+0h33C9rISMLP5fodMtzBteT4LRY/jOWowSUVUtj18f2db2PPC08posjP5
         X2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785509; x=1744390309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCJOxCsq4sP6eihazz9u78w+Z/VcmA1ipTY8uGgwWqQ=;
        b=VXtB2QrNw5zmqKd50KHyJ/36QntZbbQtzyn3iJSzMos1AWtC/ows0Y3FYYXsGAe67c
         BPoPQV+z5l2gc0nWX3F/jzmoUlASqXpk2UFe5HBezFN/xzT5TIvJRX+92O+glc7L1+M6
         jTu1W9NP6HksRKGUxhgSRn8H8K0Ew9UgrFf0i92nF1uZfqcooquCLfOAjDEzjQct1ovM
         QklDJK68975plHRasNzyGlL0dZQJQO+SmE+OP4mncYJpb4z7PvJxy2csvT9vSKxmzBPW
         LurZqgFMxIVxpWrOW4Dhivh80fEqFjJDbU9ZN+dyPoKayxUgtL0ixAkejBJMEsdSLkis
         eMkw==
X-Forwarded-Encrypted: i=1; AJvYcCUkJLp0EwCDYNnl/kRy5O1hOMxP/wn2LgX+4WKrR7eo2XOWAR9cKQ2cJ154ij0q5ovMsUFwvtvo/oGUf/zpCvvfLl+S@vger.kernel.org, AJvYcCXZJr4zP5rDGmnZ55t2zgEEoIXabuIgp3ziAPrcdvMj+e01oBugJX+qyrxNQ3YGUXpdTbxW2GgK90dUFko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/lHACUsAUjHEbi4MVC1HC2mXSqi5+IhpBW0+fT6ESQUwvR29L
	1KwY3+J2CyZwGgmRhha4Qkhu9GJd5+LrIbry+YlliHRNzNdeJrEm4Snp7PgRbTfXDQUn9vrR6c8
	h4Tc01VFoBiWSjGySvblZV1emKSQ=
X-Gm-Gg: ASbGncuVN2TRZDn7ml1ZBZbIKUjNV1Ramz7LBoEmK3OoCzNmPfDxOoAbkf9Wnh/u/Ow
	fk3RniMSDVB3QHOBPILxpFOOZ6Kt8FKe14wc4h2s+Of8Rwdo1lOonn8xMdXoR+e+EJdzgmkReOV
	qtM79umVQw7TdzVXqNeyH/lyxkIg==
X-Google-Smtp-Source: AGHT+IGzzdDf2+O+E4/8+jxtfp2u1ZLEf3GLMetOJ2O4e5uP72yC+bvImYtxfvw5tvT6UgNEgQsHq4u2w0+aFxWqr1w=
X-Received: by 2002:a05:6512:4013:b0:549:66d8:a1d2 with SMTP id
 2adb3069b0e04-54c232e2686mr1144449e87.19.1743785508633; Fri, 04 Apr 2025
 09:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
 <CAMgjq7AroDCKTfJzJRr++8H2b3eTd=MeUqwkPUX4ixRVqZw6-A@mail.gmail.com> <CAGudoHH7OUHG2HHrjzqkiqgYXzLEtovCptHpxkyVNPwSMHWfrw@mail.gmail.com>
In-Reply-To: <CAGudoHH7OUHG2HHrjzqkiqgYXzLEtovCptHpxkyVNPwSMHWfrw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 5 Apr 2025 00:51:32 +0800
X-Gm-Features: ATxdqUHJHnHN5IVy15yQ4251S2SiHtKLSV0rTOnKNbdjM_u66PODTpuuzvggkbw
Message-ID: <CAMgjq7C_W3dfYQ6DJT4QCza1DCtCE7yUdiManQSxCKOENxTm_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: use per-numa-node atomics instead of percpu_counters
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Sweet Tea Dorminy <sweettea@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:31=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Tue, Apr 1, 2025 at 5:27=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > On Tue, Apr 1, 2025 at 6:36=E2=80=AFAM Sweet Tea Dorminy
> > <sweettea-kernel@dorminy.me> wrote:
> > >
> > > [Resend as requested as RFC and minus prereq-patch-id junk]
> > >
> > > Recently, several internal services had an RSS usage regression as pa=
rt of a
> > > kernel upgrade. Previously, they were on a pre-6.2 kernel and were ab=
le to
> > > read RSS statistics in a backup watchdog process to monitor and decid=
e if
> > > they'd overrun their memory budget. Now, however, a representative se=
rvice
> > > with five threads, expected to use about a hundred MB of memory, on a=
 250-cpu
> > > machine had memory usage tens of megabytes different from the expecte=
d amount
> > > -- this constituted a significant percentage of inaccuracy, causing t=
he
> > > watchdog to act.
> > >
> > > This was a result of f1a7941243c1 ("mm: convert mm's rss stats into
> > > percpu_counter") [1].  Previously, the memory error was bounded by
> > > 64*nr_threads pages, a very livable megabyte. Now, however, as a resu=
lt of
> > > scheduler decisions moving the threads around the CPUs, the memory er=
ror could
> > > be as large as a gigabyte.
> > >
> > > This is a really tremendous inaccuracy for any few-threaded program o=
n a
> > > large machine and impedes monitoring significantly. These stat counte=
rs are
> > > also used to make OOM killing decisions, so this additional inaccurac=
y could
> > > make a big difference in OOM situations -- either resulting in the wr=
ong
> > > process being killed, or in less memory being returned from an OOM-ki=
ll than
> > > expected.
> > >
> > > Finally, while the change to percpu_counter does significantly improv=
e the
> > > accuracy over the previous per-thread error for many-threaded service=
s, it does
> > > also have performance implications - up to 12% slower for short-lived=
 processes
> > > and 9% increased system time in make test workloads [2].
> > >
> > > A previous attempt to address this regression by Peng Zhang [3] used =
a hybrid
> > > approach with delayed allocation of percpu memory for rss_stats, show=
ing
> > > promising improvements of 2-4% for process operations and 6.7% for pa=
ge
> > > faults.
> > >
> > > This RFC takes a different direction by replacing percpu_counters wit=
h a
> > > more efficient set of per-NUMA-node atomics. The approach:
> > >
> > > - Uses one atomic per node up to a bound to reduce cross-node updates=
.
> > > - Keeps a similar batching mechanism, with a smaller batch size.
> > > - Eliminates the use of a spin lock during batch updates, bounding st=
at
> > >   update latency.
> > > - Reduces percpu memory usage and thus thread startup time.
> > >
> > > Most importantly, this bounds the total error to 32 times the number =
of NUMA
> > > nodes, significantly smaller than previous error bounds.
> > >
> > > On a 112-core machine, lmbench showed comparable results before and a=
fter this
> > > patch.  However, on a 224 core machine, performance improvements were
> > > significant over percpu_counter:
> > > - Pagefault latency improved by 8.91%
> > > - Process fork latency improved by 6.27%
> > > - Process fork/execve latency improved by 6.06%
> > > - Process fork/exit latency improved by 6.58%
> > >
> > > will-it-scale also showed significant improvements on these machines.
> > >
> > > [1] https://lore.kernel.org/all/20221024052841.3291983-1-shakeelb@goo=
gle.com/
> > > [2] https://lore.kernel.org/all/20230608111408.s2minsenlcjow7q3@quack=
3/
> > > [3] https://lore.kernel.org/all/20240418142008.2775308-1-zhangpeng362=
@huawei.com/
> >
> > Hi, thanks for the idea.
> >
> > I'd like to mention my previous work on this:
> > https://lwn.net/ml/linux-kernel/20220728204511.56348-1-ryncsn@gmail.com=
/
> >
> > Basically using one global percpu counter instead of a per-task one, an=
d
> > flush each CPU's sub-counter on context_switch (if next->active_mm !=3D
> > current->active_mm, no switch for IRQ or kthread).
> > More like a percpu stash.
> >
> > Benchmark looks great and the fast path is super fast (just a
> > this_cpu_add). context_switch is also fine because the scheduler would
> > try to keep one task on the same CPU  to make better use of cache. And
> > it can leverage the cpu bitmap like tlb shootdown to optimize the
> > whole thing.
> >
> > The error and total memory consumption are both lower than current desi=
gn too.
>

Thanks for checking the patch.

> Note there are 2 unrelated components in that patchset:
> - one per-cpu instance of rss counters which is rolled up on context
> switches, avoiding the costly counter alloc/free on mm
> creation/teardown
> - cpu iteration in get_mm_counter
>
> The allocation problem is fixable without abandoning the counters, see
> my other e -mail (tl;dr let mm's hanging out in slab caches *keep* the
> counters). This aspect has to be solved anyway due to mm_alloc_cid().
> Providing a way to sort it out covers *both* the rss counters and the
> cid thing.

It's not just about the fork performance, on some servers there could
be ~100K processes and ~200 CPUs, that will be hundreds of MBs of
memory just for the counters.

And nowadays it's not something uncommon for a desktop to have ~64
CPUs and ~10K processes.

If we use a single shared "per-cpu" counter (as in the patch), the
total consumption will always be only about just dozens of bytes.

>
> In your patchset the accuracy increase comes at the expense of walking
> all CPUs every time, while a big part of the point of using percpu
> counters is to have a good enough approximation somewhere that this is
> not necessary.

It usually doesn't walk all CPUs, only the CPUs that actually used
that mm_struct, by checking mm_struct's cpu_bitmap. I didn't check if
all arch uses that bitmap though.

It's true that one CPU having its bit set on one mm_struct's
cpu_bitmap doesn't mean it updated the RSS counter so there will be
false positives, the false positive rate is low as schedulers don't
shuffle processes between processors randomly, and not every process
will be ran at a period.

Also per my observation the reader side is much colder compared to
updater for /proc.

>
> Indeed the stock kernel fails to achieve that at the moment and as you
> can see there is discussion how to tackle it. It is a general percpu
> counter problem.
>
> I verified get_mm_counter is issued in particular on mmap and munmap.
> On high core count boxes (hundreds of cores) the mandatory all CPU
> walk has to be a problem, especially if a given process is also highly
> multi-threaded and mmap/munmap heavy.
>
> Thus I think your patchset would also benefit from some form of
> distribution of the counter other than just per-cpu and the one
> centralized value. At the same time if RSS accuracy is your only
> concern and you don't care about walking the CPUs, then you could
> modify the current code to also do it.
>
> Or to put it differently, while it may be changing the scheme to have
> a local copy makes sense, the patchset is definitely not committable
> in the proposed form -- it really wants to have better quality caching
> of the state.
> --
> Mateusz Guzik <mjguzik gmail.com>
