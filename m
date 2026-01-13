Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00952FFF89
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296291; cv=none; b=Cf2mFj+htfsDMxnxrD4N97kmkPNCw1YBl9AnQluP2pHLA4OtflsSKdSuxpmpduEUKEU34sQOy4+xRX+eb/ufc9tLiDD42Lk+fO/ntox9H3aO3bxo7ePqLnAzIdCy16KZH9v+vJSjFTxks8NOAXrPAc3DlllAZTxYEmmsJ/wp6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296291; c=relaxed/simple;
	bh=0jn24JEKWb0/9Saq/hawmriPzmuV9BAKK4nMxc5tsuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulwCr4R5ho4O/5wcQDIqGKVBfvCn3M6nHEQte75kDfGqT9RLzoHj/3rAkcays5Me5pmBZpHiYrPEnfGcLidnxaHUEWXfQ207cF8jMdrnff02pa2A4mHUpdAotSufkfzqNrGuYdY3HMBYLwB54NVcGKkCT73DAuVF+hhOtJaalYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QXeaHx2i; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QXeaHx2i"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so3783009f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 01:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768296282; x=1768901082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZyF9oSCiMio2wmOHsADV3M+vA6ApPBpXUawJoezOv4=;
        b=QXeaHx2iQddPnvlJUTny7x9XCHlJt32YcUK3wvyddOSl5Z2lKA4VWlkUJGYXP1z8ZC
         SmQDiggrVPjm/ThsU27KydqrF5lvKQwGqbw0K6Dg9mDkGWg5UVz878qmczRHSAYoV0qb
         cFEZ4W0HpDos5sHxwAKoV198zmF/JtUzrbK/DiDwA/ajk/zPwMQgTYkK6BkrcBhWM30s
         i642TSzb+Qy/rNx4VfIVWtRSn4pOAMyzk+41Xf5D1VoUA4NexH4uZxDBtYZJKJHv5UHk
         x/V/Fxrx7xxDOVUg/jOohpBznRm7izEKIndAxhDJTo63e8uY5DbYpsrsjTlI2pE7p742
         J4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296282; x=1768901082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZyF9oSCiMio2wmOHsADV3M+vA6ApPBpXUawJoezOv4=;
        b=TfTP9/xWJaFd1MBE1ppx4mCCHMrcl3hSkid0o5zl7jQy8GwS0R0p0gUlRk6f+NbAL9
         4L0l+BOHMJ2e2LZb037Db6ipk2Tkm7t01VBbRtDm+Pm6uPLkkT2BUwxqhRKXTYIGgAfX
         dAeV4zqJ69dTgt1uQLuH3vU3zi7i3ThAuaNiYzNGGW8UAA9zukT5N37vWtL/6ERPvA7x
         /m7HXFmrxmNztSMBniOp8kTcjTIAnFlVwQ2y/DjZdHpphWcBxB4DyQ/+GxOM9/aTGimO
         Szy93v7hq/51xIYi6k7ZlIj6GCWq6Ovru6rQv4PPJmDvNdIHB8FEBOruRw+zI40w/uBO
         e61w==
X-Forwarded-Encrypted: i=1; AJvYcCX53vdTGNSF1siZeob5c3kQGPQNQ2WViN2wZtWB+fBJ5OXX7qeyR+6/SMfboBX/Z0J00+MLLLAeZWwUJa4zGpLva18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBBphV7nw56n9TvBZlzYo5Qgl7vaSOT1sg9gXpqXtKJZdB78X
	ZrgoGFEZXxeqpn4oj24KgF50mzXRoSltPucXqg8qgfUPEtJx+FsDJ41he2UUdITHQe0=
X-Gm-Gg: AY/fxX6nGt+zEVA6KzpeEtsVGwJnyZJZmscbA0bvTciWwWCUDhek1y/JjZ0PagYKA5i
	p68zcPv1nPoIVWukxNt1MYWP00IuME3razoVKOstt4F1hgW8wgQPm/dPEYSUapzA4uslF4xEg5H
	JI8tg9awnTHtTlYBAsRru47pRU47tHAaGyKuVbia2PQKSwGeVA5tQf0pOk4aNBThsqg0wf5Pxh2
	9yCd6DctsrWnOC5LSJqAY4vIlhtj1sVu8Mt7Hk4sTX1EtQPAUVV1UsV7BerycaDoe2sUu5bl967
	3qN5y7gdXHtfJUyXzq7rZhWVtDc/MZw/j3Pcw9F3ZZlYy0h+t9qFrzoAC7qwGTv8u5v0WNgw3R7
	+kl4hxLHk/a7dipPxo+kT1qd1B1cX/YBOSswYPBoHO2Hzkp8urC/xt/mNu3D/VaXriMGgFGzHEh
	uaZTsdOPi8uON9NA2WCP0WbyFR
X-Google-Smtp-Source: AGHT+IHxVARX0CcBthdCu6T5JJaZCa1h1WP2ZhQZH2siQrl0JD5UEBh8+2HwINiFB9HE7IPyLrLj0w==
X-Received: by 2002:a05:600c:a314:b0:479:3876:22a8 with SMTP id 5b1f17b1804b1-47d84b2d285mr218894715e9.16.1768296282317;
        Tue, 13 Jan 2026 01:24:42 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f4ddsm405518135e9.2.2026.01.13.01.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:24:41 -0800 (PST)
Date: Tue, 13 Jan 2026 10:24:40 +0100
From: Michal Hocko <mhocko@suse.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v13 2/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
Message-ID: <aWYPWNIv4lR2FpUZ@tiehlicka>
References: <20260111194958.1231477-1-mathieu.desnoyers@efficios.com>
 <20260111194958.1231477-3-mathieu.desnoyers@efficios.com>
 <aWSz5OHBwtfYrruu@tiehlicka>
 <f2c04264-17ca-418f-bc43-e8aa6fa6cd0d@efficios.com>
 <aWVP9sPqG8VC8Oq_@tiehlicka>
 <b779c646-64c7-49f8-8847-8819227e3f1f@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b779c646-64c7-49f8-8847-8819227e3f1f@efficios.com>

On Mon 12-01-26 19:47:54, Mathieu Desnoyers wrote:
> On 2026-01-12 14:48, Michal Hocko wrote:
> > On Mon 12-01-26 14:37:49, Mathieu Desnoyers wrote:
> > > On 2026-01-12 03:42, Michal Hocko wrote:
> > > > Hi,
> > > > sorry to jump in this late but the timing of previous versions didn't
> > > > really work well for me.
> > > > 
> > > > On Sun 11-01-26 14:49:57, Mathieu Desnoyers wrote:
> > > > [...]
> > > > > Here is a (possibly incomplete) list of the prior approaches that were
> > > > > used or proposed, along with their downside:
> > > > > 
> > > > > 1) Per-thread rss tracking: large error on many-thread processes.
> > > > > 
> > > > > 2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
> > > > >      increased system time in make test workloads [1]. Moreover, the
> > > > >      inaccuracy increases with O(n^2) with the number of CPUs.
> > > > > 
> > > > > 3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
> > > > >      error is high with systems that have lots of NUMA nodes (32 times
> > > > >      the number of NUMA nodes).
> > > > > 
> > > > > The approach proposed here is to replace this by the hierarchical
> > > > > per-cpu counters, which bounds the inaccuracy based on the system
> > > > > topology with O(N*logN).
> > > > 
> > > > The concept of hierarchical pcp counter is interesting and I am
> > > > definitely not opposed if there are more users that would benefit.
> > > > 
> > > >   From the OOM POV, IIUC the primary problem is that get_mm_counter
> > > > (percpu_counter_read_positive) is too imprecise on systems when the task
> > > > is moving around a large number of cpus. In the list of alternative
> > > > solutions I do not see percpu_counter_sum_positive to be mentioned.
> > > > oom_badness() is a really slow path and taking the slow path to
> > > > calculate a much more precise value seems acceptable. Have you
> > > > considered that option?
> > > I must admit I assumed that since there was already a mechanism in place
> > > to ensure it's not necessary to sum per-cpu counters when the oom killer
> > > is trying to select tasks, it must be because this
> > > 
> > >    O(nr_possible_cpus * nr_processes)
> > > 
> > > operation must be too slow for the oom killer requirements.
> > > 
> > > AFAIU, the oom killer is executed when the memory allocator fails to
> > > allocate memory, which can be within code paths which need to progress
> > > eventually. So even though it's a slow path compared to the allocator
> > > fast path, there must be at least _some_ expectations about it
> > > completing within a decent amount of time. What would that ballpark be ?
> > 
> > I do not think we have ever promissed more than the oom killer will try
> > to unlock the system blocked on memory shortage.
> > 
> > > To give an order of magnitude, I've tried modifying the upstream
> > > oom killer to use percpu_counter_sum_positive and compared it to
> > > the hierarchical approach:
> > > 
> > > AMD EPYC 9654 96-Core (2 sockets)
> > > Within a KVM, configured with 256 logical cpus.
> > > 
> > >                     nr_processes=40    nr_processes=10000
> > > Counter sum:            0.4 ms             81.0 ms
> > > HPCC with 2-pass:       0.3 ms              9.3 ms
> > 
> > These are peanuts for the global oom situations. We have had situations
> > when soft lockup detector triggered because of the process tree
> > traversal so adding 100ms is not really critical.
> > 
> > > So as we scale up the number of processes on large SMP systems,
> > > the latency caused by the oom killer task selection greatly
> > > increases with the counter sums compared with the hierarchical
> > > approach.
> > 
> > Yes, I am not really questioning the hierarchical approach will perform
> > much better but I am thinking of a good enough solution and calculating
> > the number might be just that stop gap solution (that would be also
> > suitable for stable tree backports). I am not ruling out improving on
> > top of that by a more clever solution like your hierarchical counters
> > approach. Especially if there are more benefits from that elsewhere.
> > 
> 
> Would you be OK with introducing changes in the following order ?
> 
> 1) Fix the OOM killer inaccuracy by using counter sum (iteration on all
>    cpu counters) in task selection. This may slow down the oom killer,
>    but would at least fix its current inaccuracy issues. This could be
>    backported to stable kernels.
> 
> 2) Introduce the hierarchical percpu counters on top, as a oom killer
>    task selection performance optimization (reduce latency of oom kill).
> 
> This way, (2) becomes purely a performance optimization, so it's easy
> to bissect and revert if it causes issues.

Yes, this makes more sense.

> I agree that bringing a fix along with a performance optimization within
> a single commit makes it hard to backport to stable, and tricky to
> revert if it causes problems.
> 
> As for finding other users of the hpcc, I have ideas, but not so much
> time available to try them out, as I'm pretty much doing this in my
> spare time.

I do understand this constrain and motivation to have OOM situation
addressed with a priority. I am pretty sure that if you see issues in
OOM path then other consumers of get_mm_counter would be affected as
well. Namely /proc/<pid>/stat. There might be others but I can imagine
that some of them are more performance than precision sensitive.
All that being said it seems that we need slow-and-precise and
fast-approximate interfaces to have incremental path for other users as
well. Looking at patch 1 it seems there are interfaces available for
that. I think it would be great to call those out explicitly in the
highlevel doc to give some guidance what to use when with what kind of
expectations.

Thanks!
-- 
Michal Hocko
SUSE Labs
