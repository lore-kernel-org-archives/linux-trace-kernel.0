Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E23033D1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247290; cv=none; b=U1/PHaaKtz1uFFeXa3TOCqh3XaLWOUr+Nkml/Y5x2yNFsk0mMEIiYR2P0FFEUZvo/FcVhl73rI9a0H7pCDLx+oxoBl22s5l1NZ+hGoJctQsxOdOxllKckDnRWQ4qBWJYEGABJVxgj4p0QiqTYkHxUvDyVwuoBQZuMrtLuq8WJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247290; c=relaxed/simple;
	bh=RVjiN4DP9fSW/O10it19QP2bn8wGkaJ6vL7xbjZI3Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1ZR5az7//1+eusUM2wLwAyyrmHcgVjFfzbCmNROcmeBYH06pi96rYW25fIvW/BTZHP69Cl09LNCmaHRPmBV7ikqlcFgqDDlogQJeP9J6K3nTz2PHSBJIDAInzueBYHvRRE2vHN4Z1eHv3HaxWzfcYtQU80v4jCz864PKxCDeXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TbhnRHZh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TbhnRHZh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so5768008f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 11:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768247287; x=1768852087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGyo51WmDqtagxgoVSIwRWG3W5A40tN9gD1xGhmOgu0=;
        b=TbhnRHZhvuPPC/Nc46X8GJ1IBvwjdJJMOIUtkfbafW2y4yr9G+wyGKjbEv+V13gVCA
         VkeLkrvAw+pyqs6M2bJ6TszAQQq+82tAIYZBw566J/8sgLDtg74LDtY2jEFJkjE7pIdI
         tBQ1rOCZwfyzCJnTU/0eW+XkIdgDg0grcvwGvxM+mQL4felbN1NfdydYdfjO0pbMsBfW
         vbEDpYs7rW4LWyPhQ4MFAsYGGX5Qu+1ahP89h46+dE/ZvwN8rO1rH+uUHztBcL1/OlUH
         F8p7MeYDSP1VdDZ2GNp4S76LUg8q3Jj5Lu4pv7G1WaLfFHUwnIF8qshDHhJJ5nkqu4Lg
         xF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768247287; x=1768852087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGyo51WmDqtagxgoVSIwRWG3W5A40tN9gD1xGhmOgu0=;
        b=MyrU/3O+PTlrpgLFQiFmnBCI2AuZpr5hEcCzz7aftB5Pi+OvizKow6USzQrKrhl7Ae
         Qpg6b0u93zCDCIMwLOvwme8Y/zYEVnNBH+d8Y9pUzYxWTaaunYXVqY2AYlc2Wg4Ov294
         K0XPfWHSRWubiaupzVx9pLoPyaTXGombOY/80yvj/ZeENJkwHFEXD2wQ6/GkiNAhO/Nj
         68QYCCSgF9JVC4sv7jPRmlcY2lq+PSgeC2eh4uy/DV6gbgc9tewgp6IPpeP42icRg7gj
         VdWhiMUF5QUnj3RKw5HSKyhmBfR+4Jpoym1mtyMFcSTm0tscFtau0p5aM1WA7jVn8+Ko
         zsZg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9omQ75AX5yOwRgB3/wyPJoRUXcAXR/Uo5bzNg77mNU0ErhD1bjDLLmnAE+1cAJC1NpacO1wi74BJW+Yhxptd3yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu232t0SwwHjpGvoIsJc26K6NZBGXyoDgoKF8ZKorWoVl34RNb
	TnkUiCbh8uWL1WCCfvYSJAp2ZjuzYx0bxKr7WY5DpILM0Is8ZTn5SKBAgv1dh4ntjcI=
X-Gm-Gg: AY/fxX5q+F4sZu4WY+vGCOpsxOrh5IDo65gyZt8jRhhzJNg1TZ/kADKCRAEsBZ3b3rx
	nP6NxGWtANyOrFX86PnF+EQJK6qcrqPnaGwRs0+xNYCBZxAVeJWqRrIp3c4ZqfSxUgAAFIXxTXf
	sO47AUW37KZ3VShjiIU3s2S/LBTCLIqaKM/L6vW/vCoFKuJcsew0QvtrRKtqy1VX2ljhkQ4EUku
	Eop8HNzKoSU8PqMOjdSR4lxk3mxAkd6TMpHrs0NEAC7aCF7pA4XXrApW2ZBUvLWYbZQ/bNMKBhj
	TOF1YLyQiP5H3X+kkhpS7tWpsTjnf7RZADWP+raOd0A2eR8neAA60qZPomCQdK1D0BeK2GCyxrb
	P90acM9aT6AhU1l/d4p0/7c1/IUmVAExAJbRRiU2wF0cK7odFPu3AvlMJzKmlYzB68ipbDGm4Db
	l+ppyOoIC/f/Rq0FV7nae3D4Kc
X-Google-Smtp-Source: AGHT+IHE1lXvEz53VmoWzLLJVZRvVBwxgOdGb5mMIjcwZPpGkPDDOGRk+/iknTtt3x3D/wmw7rPQqQ==
X-Received: by 2002:a05:6000:1886:b0:432:a9f0:48c with SMTP id ffacd0b85a97d-432c38d26f6mr24261001f8f.63.1768247287544;
        Mon, 12 Jan 2026 11:48:07 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee893sm39721819f8f.37.2026.01.12.11.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:48:07 -0800 (PST)
Date: Mon, 12 Jan 2026 20:48:06 +0100
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
Message-ID: <aWVP9sPqG8VC8Oq_@tiehlicka>
References: <20260111194958.1231477-1-mathieu.desnoyers@efficios.com>
 <20260111194958.1231477-3-mathieu.desnoyers@efficios.com>
 <aWSz5OHBwtfYrruu@tiehlicka>
 <f2c04264-17ca-418f-bc43-e8aa6fa6cd0d@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2c04264-17ca-418f-bc43-e8aa6fa6cd0d@efficios.com>

On Mon 12-01-26 14:37:49, Mathieu Desnoyers wrote:
> On 2026-01-12 03:42, Michal Hocko wrote:
> > Hi,
> > sorry to jump in this late but the timing of previous versions didn't
> > really work well for me.
> > 
> > On Sun 11-01-26 14:49:57, Mathieu Desnoyers wrote:
> > [...]
> > > Here is a (possibly incomplete) list of the prior approaches that were
> > > used or proposed, along with their downside:
> > > 
> > > 1) Per-thread rss tracking: large error on many-thread processes.
> > > 
> > > 2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
> > >     increased system time in make test workloads [1]. Moreover, the
> > >     inaccuracy increases with O(n^2) with the number of CPUs.
> > > 
> > > 3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
> > >     error is high with systems that have lots of NUMA nodes (32 times
> > >     the number of NUMA nodes).
> > > 
> > > The approach proposed here is to replace this by the hierarchical
> > > per-cpu counters, which bounds the inaccuracy based on the system
> > > topology with O(N*logN).
> > 
> > The concept of hierarchical pcp counter is interesting and I am
> > definitely not opposed if there are more users that would benefit.
> > 
> >  From the OOM POV, IIUC the primary problem is that get_mm_counter
> > (percpu_counter_read_positive) is too imprecise on systems when the task
> > is moving around a large number of cpus. In the list of alternative
> > solutions I do not see percpu_counter_sum_positive to be mentioned.
> > oom_badness() is a really slow path and taking the slow path to
> > calculate a much more precise value seems acceptable. Have you
> > considered that option?
> I must admit I assumed that since there was already a mechanism in place
> to ensure it's not necessary to sum per-cpu counters when the oom killer
> is trying to select tasks, it must be because this
> 
>   O(nr_possible_cpus * nr_processes)
> 
> operation must be too slow for the oom killer requirements.
> 
> AFAIU, the oom killer is executed when the memory allocator fails to
> allocate memory, which can be within code paths which need to progress
> eventually. So even though it's a slow path compared to the allocator
> fast path, there must be at least _some_ expectations about it
> completing within a decent amount of time. What would that ballpark be ?

I do not think we have ever promissed more than the oom killer will try
to unlock the system blocked on memory shortage.

> To give an order of magnitude, I've tried modifying the upstream
> oom killer to use percpu_counter_sum_positive and compared it to
> the hierarchical approach:
> 
> AMD EPYC 9654 96-Core (2 sockets)
> Within a KVM, configured with 256 logical cpus.
> 
>                    nr_processes=40    nr_processes=10000
> Counter sum:            0.4 ms             81.0 ms
> HPCC with 2-pass:       0.3 ms              9.3 ms

These are peanuts for the global oom situations. We have had situations
when soft lockup detector triggered because of the process tree
traversal so adding 100ms is not really critical.

> So as we scale up the number of processes on large SMP systems,
> the latency caused by the oom killer task selection greatly
> increases with the counter sums compared with the hierarchical
> approach.

Yes, I am not really questioning the hierarchical approach will perform
much better but I am thinking of a good enough solution and calculating
the number might be just that stop gap solution (that would be also
suitable for stable tree backports). I am not ruling out improving on
top of that by a more clever solution like your hierarchical counters
approach. Especially if there are more benefits from that elsewhere.

-- 
Michal Hocko
SUSE Labs
