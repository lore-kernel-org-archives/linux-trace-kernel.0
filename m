Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057853A6403
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409287; cv=none; b=Or62J5NSu/UzvQwMtMsX4QZ9UoJmkrGL8B+Ke4zpfifIM7wCPHkcs1z4WuvKPBhO3NPpEuwkd2khzNoA2C9QVq/sfCxlzWX52m7Y7Cczs1l/GWLaVuuDbSaaqWD1tRpHP2I7X5ZEJXa4ChG6Wk5x8TzYvVM4jobXfbmORTW/M5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409287; c=relaxed/simple;
	bh=j1zkDAHezLQkOdLJI+qtI0KRUXAmjFjMGFuiufQH8GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/3XEHgFgu6fi44uigJl6gPAhuS8iJQFtf1JMvm2UYnsHEsCPgYT8/TlaU8PbyaKLnAapuoLNamZxTnI3VrVfW8jpsZPwoznfGhw5PRoNL22iLInAdjX+GYdq83FMB83H6RppIq5Mq+rLZs1QfBFAN+l1/tPXp70Y7n0wYlvz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VIsIDqIo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VIsIDqIo"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so139505e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 08:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768409282; x=1769014082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWihw0KAMXVM/F7Z84yiMzol9tq02jR8sEQFJ5oi4pA=;
        b=VIsIDqIo/WCfOu6DAbJjmwZ0Cp7CqjXen3CO6klqC9n9ZfQvGH6SaqiSnAACKJWYV8
         gzqxDlrZhlbDU16yclUSv/8Zu2J+0otKgCdjphBKwAGpx5AzRbzypCpYjIk0TIngg7Yr
         BPtWkCB+2Bx7yPCy6edV9HboDVaC+8C8OpZHZIImZPrKlHIifm+8N0jzw5+PDvYAInzn
         trhYFSHyZw2jzZhk9zepkcSP+C7HJ4jU4REkH4HVCfdHxP7fseVLpoMpw6JNzMBbX8ns
         65l1WeNBbFd3+HdioocssQL3uVjQn9qiDTexT8c0nJ+im6Du84oZtCNhjywg5wvGhWIY
         sHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409282; x=1769014082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWihw0KAMXVM/F7Z84yiMzol9tq02jR8sEQFJ5oi4pA=;
        b=TPHUsPCwczcjku6eEX7OE795Lx6/zoy3j6EFSZaNsOTAxiaEO8FJhLkiaX/mtmafo7
         GrSi5YUeHCrgYJhzAcFoceqkWs43frTOWhsEBnVeMRsv/XyvDL1AcEC+uZ/TF+AcMxAx
         om2POBdCHGnY/XeMXqsyX0yArqBliVQWgBryY3HSPqKlZOIjpraP7zP2vVwt/MChOxfB
         dF/nT2QpF5b7ojn6xdfEOsCHyZHM6+KcPL6AEduvpwVgIPF7dXlNykyilHLo2QzJzF4t
         32W5XMf2a6/LNhuKDnZJMR6bS0HcMQk51lFZWEf22/VBgZRdYG4wBDL25edYL6mjTXCO
         CNlg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Tgz+M7NOrOtxq0qMJ6NwK4zfp3mhT78K1uvBO6CyaY0jEPJFdXfJ16k/TiwQErG1gp5tJuZNcb0hKp4FVHeN0g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZs5L6SC9hVWgiryY57wzFnhzu2V2f0kH4IiJBht1wJ/qRYkC7
	114OtWlmcZNJdj82gUm+PWZ2rfI/6AYzaLCa/5cvl35NxWeXwBedNHgawNgFv5aMJ3E=
X-Gm-Gg: AY/fxX5KoNW+c9/xt+SCMdpGJCezrHOZkXD3UkBELSlu2NfhqQERofO6+NCfkqDwcDd
	w8EqxzbqfJWDn2XLIK77IBH9+CMFdEI8bxc5jma1IZLF2VqT69QYRwdcq1OiqAaZ+Ayiyo+LrnJ
	MvByTzP+RHOjCy+hknP3VLMWaXIBIuqnGU8zrfaqCZkH82UbIjDKdHCJXqg5lT9/mMfwYPbGa4a
	Zbs6pDJFTolPbJCl47ClQwbmStqS0tynTp3xMuST60mLW6TFwaFAE5ihXx9DzgMYf4wAZFCUHhQ
	8hUO2MpUIe1N5BybQxai6k9aC0HFyXqdJZW2xc7CVg0HA58ZBD91UjzclSQV+TDaME0E12JSRQM
	l6qq23lXGcO1KSL9wOGIo6qwaO2OcgTqPDarfU3sLxcdFsXUL5WknxalX1FVk+Qk99x9qUTlAWr
	Ff81jJcLy4Dj+Od8H+St0DJfhp
X-Received: by 2002:a05:600c:8b88:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-47ee32e0281mr38831005e9.5.1768409282338;
        Wed, 14 Jan 2026 08:48:02 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b267661sm439365e9.13.2026.01.14.08.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:48:01 -0800 (PST)
Date: Wed, 14 Jan 2026 17:48:00 +0100
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
Subject: Re: [PATCH v16 2/3] mm: Improve RSS counter approximation accuracy
 for proc interfaces
Message-ID: <aWfIwKzzIihhByJ9@tiehlicka>
References: <20260114145915.49926-1-mathieu.desnoyers@efficios.com>
 <20260114145915.49926-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114145915.49926-3-mathieu.desnoyers@efficios.com>

On Wed 14-01-26 09:59:14, Mathieu Desnoyers wrote:
> Use hierarchical per-cpu counters for RSS tracking to improve the
> accuracy of per-mm RSS sum approximation on large many-core systems [1].
> This improves the accuracy of the RSS values returned by proc
> interfaces.
> 
> This is also a preparation step to introduce a 2-pass OOM killer task
> selection which leverages the approximation and accuracy ranges to
> quickly eliminate tasks which are outside of the range of the current
> selection, and thus reduce the latency introduced by execution of the
> OOM killer.
> 
> Here is a (possibly incomplete) list of the prior approaches that were
> used or proposed, along with their downside:
> 
> 1) Per-thread rss tracking: large error on many-thread processes.
> 
> 2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
>    increased system time in make test workloads [1]. Moreover, the
>    inaccuracy increases with O(n^2) with the number of CPUs.
> 
> 3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
>    error is high with systems that have lots of NUMA nodes (32 times
>    the number of NUMA nodes).
> 
> 4) Use a percise per-cpu counter sum for each counter value query:
>    Requires iteration on each possible CPUs for each sum, which
>    adds overhead (and thus increases OOM killer latency) on large
>    many-core systems running many processes.
> 
> The approach proposed here is to replace the per-cpu counters by the
> hierarchical per-cpu counters, which bounds the inaccuracy based on the
> system topology with O(N*logN).
> 
> * Testing results:
> 
> Test hardware: 2 sockets AMD EPYC 9654 96-Core Processor (384 logical CPUs total)
> 
> Methodology:
> 
> Comparing the current upstream implementation with the hierarchical
> counters is done by keeping both implementations wired up in parallel,
> and running a single-process, single-threaded program which hops
> randomly across CPUs in the system, calling mmap(2) and munmap(2) on
> random CPUs, keeping track of an array of allocated mappings, randomly
> choosing entries to either map or unmap.
> 
> get_mm_counter() is instrumented to compare the upstream counter
> approximation to the precise value, and print the delta when going over
> a given threshold. The delta of the hierarchical counter approximation
> to the precise value is also printed for comparison.
> 
> After a few minutes running this test, the upstream implementation
> counter approximation reaches a 1GB delta from the
> precise value, compared to 80MB delta with the hierarchical counter.
> The hierarchical counter provides a guaranteed maximum approximation
> inaccuracy of 192MB on that hardware topology.
> 
> * Fast path implementation comparison
> 
> The new inline percpu_counter_tree_add() uses a this_cpu_add_return()
> for the fast path (under a certain allocation size threshold).  Above
> that, it calls a slow path which "trickles up" the carry to upper level
> counters with atomic_add_return.
> 
> In comparison, the upstream counters implementation calls
> percpu_counter_add_batch which uses this_cpu_try_cmpxchg() on the fast
> path, and does a raw_spin_lock_irqsave above a certain threshold.
> 
> The hierarchical implementation is therefore expected to have less
> contention on mid-sized allocations than the upstream counters because
> the atomic counters tracking those bits are only shared across nearby
> CPUs. In comparison, the upstream counters immediately use a global
> spinlock when reaching the threshold.
> 
> * Benchmarks
> 
> Using will-it-scale page_fault1 benchmarks to compare the upstream
> counters to the hierarchical counters. This is done with hyperthreading
> disabled. The speedup is within the standard deviation of the upstream
> runs, so the overhead is not significant.
> 
>                                           upstream   hierarchical    speedup
> page_fault1_processes -s 100 -t 1           614783         615558      +0.1%
> page_fault1_threads -s 100 -t 1             612788         612447      -0.1%
> page_fault1_processes -s 100 -t 96        37994977       37932035      -0.2%
> page_fault1_threads -s 100 -t 96           2484130        2504860      +0.8%
> page_fault1_processes -s 100 -t 192       71262917       71118830      -0.2%
> page_fault1_threads -s 100 -t 192          2446437        2469296      +0.1%
> 
> This change depends on the following patch:
> "mm: Fix OOM killer inaccuracy on large many-core systems" [2]

As mentioned in the previous patch, it would be great to explicitly
mention what is the memory price for the new tracking data structure.

Other than that this seems like a generally useful improvement for
larger systems and it is my understanding that it doesn't add almost any
overhead on small end systems, correct?

-- 
Michal Hocko
SUSE Labs
