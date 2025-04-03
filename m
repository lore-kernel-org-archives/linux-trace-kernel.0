Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808A73477;
	Thu,  3 Apr 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690703; cv=none; b=EQlV4oYailcRHHngMCasICqSqdJKXRGC+HDtk8MpNRUoounuHf0SAfr1twbe/UrbXb2f7vLJdnOhEKT2e+DTUFMfY+lGZl9qoWBFC7Wn1i4+zszMDrx9PGBRcJURiUXHk/vszypF03UPrIQQ6PiM1d11l1eleC69D3YrF/WaLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690703; c=relaxed/simple;
	bh=Jm2l2+PkwAQ9E0WIwt6XgDiYx8IDoOrADkeg/qtEnZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlbwnu2HUQ2+0VBpyewsvpNqXtokSi3CaipRW6tkUd2+Gw4PsK3UGE4TFIZesWNUv3THfL9dtQHfxlKcyIRsnMmPQpp2kaqUWGusVbN+mLjHwIiORTSOnZkWJlwqkL8Ig7lSySNFp9tB4CbP35xgBL6bsf7ExIOSSs78pSJAJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2jx8dFe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2jx8dFe"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so1370227a12.1;
        Thu, 03 Apr 2025 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743690700; x=1744295500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK9/wkbg8zvAiAyI3GpEsZTlV7drMA2QZPU1sf6wwxU=;
        b=d2jx8dFex1RHLQAfzDtvCgqFBR6AC5WF0hQKre4k01W04pi63Cntd50RMOixgGyGOl
         bph4wogRiZrG9aGDjhYhicQLWgmNEcFUuiX5WZ0VQx38M32fbJlDpHSwPCTNRFA7baWk
         GvTAzuClj7pkVgBKZiMes9CPf4TPgpsRrFNdk1Qrd4hSu467s5cT6ei/yH1EmWzWwOfQ
         Cd3Xf9aEosulm7Y+QAMZnPOljrLKD6adT8ynV1LFupJe32m35K8AWSRiRxR3BuTGurlU
         HwFyD4Mt2k0P04g0TSY6PSVFQVieAB9SKQX6sQx7yTl09fJzNNH0ZAM94xX6PXE4+sSv
         mw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690700; x=1744295500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK9/wkbg8zvAiAyI3GpEsZTlV7drMA2QZPU1sf6wwxU=;
        b=fkqHcgojdhffhheUaaXL8dWMWO8Q5iWlSeqCwSca05KYIrjSunGihSu+cWcEvfM71Q
         oibvu4MDd1dIbQ/VhObYDhE9wwtbQsBrwZ4L6tXCaWblO9KGAbIUcabAblF0TL0v2W8m
         yNoQIog5QkT5ttgP01KJ1BgdzQojVGsZDS8FHlbsPNdkAEcmQE7o/0fl6HrYZIbQGukF
         VuihDmqvTlKnqYUFK7kstiwIfHFIgaRqvAPxMVyxzhTv2TuW9e1OWdRAJiuWiP0OhHky
         Jr5lP1IObB2w7K4sijncvMtBZQydtNRfr/+hMJWF61bLSlOwprM6gPyp9Q3fbIFKgAx1
         UYIw==
X-Forwarded-Encrypted: i=1; AJvYcCX57m1IS6Ky8+M/3+1jGdZEZMH2cFfuiBAjMjdtFIcxoxxI+ZItwjD+OH9FgG1/nXh1IPTyS5ff42lMLRSjfzaU2kZd@vger.kernel.org, AJvYcCXjka81Mtwm+s8Ms1m4yn34LQge0Zq1Qv1T6n9/67GI1j5Joj1znTZ7AbIJqi7tAbYLEJ1BFt0lSNadWJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DeI2h5UcQR6tvs+Bkp5V5B8oP4KW+Cu3cFJHJct33p06GgB8
	Yml4Hi+wxK04NcPRvekRcZgW7MDjg4NFUfIAW5vnvnbT3a1IHvr724ay/LGn82fmXt5ruZDKKAu
	NPv9sckBa2VasugK0DAwpmSnKqZI=
X-Gm-Gg: ASbGncsL9HAM4u1TskSf0H+I92CpY84kKtIFsSWAMnnG8HR8sk2o71kEL037dX3ArF+
	WLhmGK1YqcFRnFCjYjXFqlepvGP3onlPE8DPCT1EAJVqDCLskznz+paX+nNT5rmKYFBNGBXUNIj
	1S7RzHF9QTDPHAoDJUgYO9/cu8
X-Google-Smtp-Source: AGHT+IHkJ4KaUGObBE6FKmfGZm5gTXO6nvY2/gUckZhrPo4HJ/GKOeBtA77J6m8VGj9ClwYiYfsjNg2+RSWj2GRIfVk=
X-Received: by 2002:a05:6402:350b:b0:5e0:892f:89ae with SMTP id
 4fb4d7f45d1cf-5edfcc27575mr17848743a12.4.1743690699939; Thu, 03 Apr 2025
 07:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331223516.7810-2-sweettea-kernel@dorminy.me> <CAMgjq7AroDCKTfJzJRr++8H2b3eTd=MeUqwkPUX4ixRVqZw6-A@mail.gmail.com>
In-Reply-To: <CAMgjq7AroDCKTfJzJRr++8H2b3eTd=MeUqwkPUX4ixRVqZw6-A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 3 Apr 2025 16:31:28 +0200
X-Gm-Features: ATxdqUFbcuKJ9YYwfeWxR-IddzPF5kxU7naBcMCGt4TtUjwLbygy2hilEX9A1F4
Message-ID: <CAGudoHH7OUHG2HHrjzqkiqgYXzLEtovCptHpxkyVNPwSMHWfrw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: use per-numa-node atomics instead of percpu_counters
To: Kairui Song <ryncsn@gmail.com>
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

On Tue, Apr 1, 2025 at 5:27=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Tue, Apr 1, 2025 at 6:36=E2=80=AFAM Sweet Tea Dorminy
> <sweettea-kernel@dorminy.me> wrote:
> >
> > [Resend as requested as RFC and minus prereq-patch-id junk]
> >
> > Recently, several internal services had an RSS usage regression as part=
 of a
> > kernel upgrade. Previously, they were on a pre-6.2 kernel and were able=
 to
> > read RSS statistics in a backup watchdog process to monitor and decide =
if
> > they'd overrun their memory budget. Now, however, a representative serv=
ice
> > with five threads, expected to use about a hundred MB of memory, on a 2=
50-cpu
> > machine had memory usage tens of megabytes different from the expected =
amount
> > -- this constituted a significant percentage of inaccuracy, causing the
> > watchdog to act.
> >
> > This was a result of f1a7941243c1 ("mm: convert mm's rss stats into
> > percpu_counter") [1].  Previously, the memory error was bounded by
> > 64*nr_threads pages, a very livable megabyte. Now, however, as a result=
 of
> > scheduler decisions moving the threads around the CPUs, the memory erro=
r could
> > be as large as a gigabyte.
> >
> > This is a really tremendous inaccuracy for any few-threaded program on =
a
> > large machine and impedes monitoring significantly. These stat counters=
 are
> > also used to make OOM killing decisions, so this additional inaccuracy =
could
> > make a big difference in OOM situations -- either resulting in the wron=
g
> > process being killed, or in less memory being returned from an OOM-kill=
 than
> > expected.
> >
> > Finally, while the change to percpu_counter does significantly improve =
the
> > accuracy over the previous per-thread error for many-threaded services,=
 it does
> > also have performance implications - up to 12% slower for short-lived p=
rocesses
> > and 9% increased system time in make test workloads [2].
> >
> > A previous attempt to address this regression by Peng Zhang [3] used a =
hybrid
> > approach with delayed allocation of percpu memory for rss_stats, showin=
g
> > promising improvements of 2-4% for process operations and 6.7% for page
> > faults.
> >
> > This RFC takes a different direction by replacing percpu_counters with =
a
> > more efficient set of per-NUMA-node atomics. The approach:
> >
> > - Uses one atomic per node up to a bound to reduce cross-node updates.
> > - Keeps a similar batching mechanism, with a smaller batch size.
> > - Eliminates the use of a spin lock during batch updates, bounding stat
> >   update latency.
> > - Reduces percpu memory usage and thus thread startup time.
> >
> > Most importantly, this bounds the total error to 32 times the number of=
 NUMA
> > nodes, significantly smaller than previous error bounds.
> >
> > On a 112-core machine, lmbench showed comparable results before and aft=
er this
> > patch.  However, on a 224 core machine, performance improvements were
> > significant over percpu_counter:
> > - Pagefault latency improved by 8.91%
> > - Process fork latency improved by 6.27%
> > - Process fork/execve latency improved by 6.06%
> > - Process fork/exit latency improved by 6.58%
> >
> > will-it-scale also showed significant improvements on these machines.
> >
> > [1] https://lore.kernel.org/all/20221024052841.3291983-1-shakeelb@googl=
e.com/
> > [2] https://lore.kernel.org/all/20230608111408.s2minsenlcjow7q3@quack3/
> > [3] https://lore.kernel.org/all/20240418142008.2775308-1-zhangpeng362@h=
uawei.com/
>
> Hi, thanks for the idea.
>
> I'd like to mention my previous work on this:
> https://lwn.net/ml/linux-kernel/20220728204511.56348-1-ryncsn@gmail.com/
>
> Basically using one global percpu counter instead of a per-task one, and
> flush each CPU's sub-counter on context_switch (if next->active_mm !=3D
> current->active_mm, no switch for IRQ or kthread).
> More like a percpu stash.
>
> Benchmark looks great and the fast path is super fast (just a
> this_cpu_add). context_switch is also fine because the scheduler would
> try to keep one task on the same CPU  to make better use of cache. And
> it can leverage the cpu bitmap like tlb shootdown to optimize the
> whole thing.
>
> The error and total memory consumption are both lower than current design=
 too.

Note there are 2 unrelated components in that patchset:
- one per-cpu instance of rss counters which is rolled up on context
switches, avoiding the costly counter alloc/free on mm
creation/teardown
- cpu iteration in get_mm_counter

The allocation problem is fixable without abandoning the counters, see
my other e -mail (tl;dr let mm's hanging out in slab caches *keep* the
counters). This aspect has to be solved anyway due to mm_alloc_cid().
Providing a way to sort it out covers *both* the rss counters and the
cid thing.

In your patchset the accuracy increase comes at the expense of walking
all CPUs every time, while a big part of the point of using percpu
counters is to have a good enough approximation somewhere that this is
not necessary.

Indeed the stock kernel fails to achieve that at the moment and as you
can see there is discussion how to tackle it. It is a general percpu
counter problem.

I verified get_mm_counter is issued in particular on mmap and munmap.
On high core count boxes (hundreds of cores) the mandatory all CPU
walk has to be a problem, especially if a given process is also highly
multi-threaded and mmap/munmap heavy.

Thus I think your patchset would also benefit from some form of
distribution of the counter other than just per-cpu and the one
centralized value. At the same time if RSS accuracy is your only
concern and you don't care about walking the CPUs, then you could
modify the current code to also do it.

Or to put it differently, while it may be changing the scheme to have
a local copy makes sense, the patchset is definitely not committable
in the proposed form -- it really wants to have better quality caching
of the state.
--
Mateusz Guzik <mjguzik gmail.com>
