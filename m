Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC803A4F2E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408914; cv=none; b=PORf4mXj5cLcnfid95ILd/UhZlD9VnKir5yzeBy2Wps2rFwCWXQKWq2RB77tVbGBH4eDMQ9mImW/jydtg5Z2kobE1EtPozVglhs0F5wjDdye2oXouQ149xFMX+prfMSecGn31WX+XqajnGfKChHSRSjmlP4nu/Q6yRlmNoCt7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408914; c=relaxed/simple;
	bh=Cx7kvRIX8Qrq0TT1Ah/lwLqz6bmyUkl+ja3kUOilRek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqwZXEVghddtElxYHH6HvlxbzkHHiL3ndF55lla6tEC6xbw7rt17jwpvnzcV1aqVRdku1+ZPBxw44miAgchPUCEjQG90hfC+yqy5nV4FQOcj3JQmzx/2WD2m5+6uYCKCV0TMsEqarLZQgOmGqSDP0UAZWUSaYoN+4rvh5oMBfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U9wSIwSo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U9wSIwSo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so350625e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768408911; x=1769013711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5XsqmTd3Wuf5i5kP7cIwbfY5FVmF/Do+b5WJ9+iLQY=;
        b=U9wSIwSodCs06wB7tdkolYgmsgzIFQLUpE1w4ZxkVPJkx7mJxb0rvve4y+SKNsTsrs
         pb1DhXcIRwZmGPHt5pUfhwQ6mZTs+GwzNZ4GQHXnTVCAVBDXOL6xhifiPJSQ27rA9xpr
         yG826RjZRslf9YZGiihDwHwNnKJRTE7Tav0CrK9MZhE5gEjHLADjjOU8WGSEoAusX4+n
         xnH9pWqhEWh4U8rb0tMVQzLE7kHkxFfMgXfWDkBkrAuKjPSfHBhahrH8sW5V+5QlrKaN
         WV81egIsfqrVyDoPEGsNyCHaez3fyzws95CuvxYFOFL1hwSdiQkG19CUwWs/BoGeZhbA
         Nisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768408911; x=1769013711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5XsqmTd3Wuf5i5kP7cIwbfY5FVmF/Do+b5WJ9+iLQY=;
        b=segDX3krau0CZCYA27suG4BA/CkIMq7lSQ3HDgPTlSAnLhk0Hx+aaSoWxFU3hGUiku
         Z/SG5Hu6Wf/2IMK7whVSkeiri6LmxjdOBWDTzXVe+ojfvTef0DBHwNxWf9x7X+wUCp2O
         UulFp0Nwv7hSnADmGWtWB+1VQ+Xy0/jbcWpaPrjvenMuJHKMl762wwR61vknlYO/9BM/
         Sw7YbBD/fB3UCOMlLmx7hE2kVJCJd7bQOpgJicgGixVuXBXiNozvKwZaVEID+ZWQDPYX
         LEjA6VM4KU3Vj7Dqmkz8qO2Z/aWbjQ5MhjZZ8dbVnncXpMqwzl/slQ7oGHwnHiYhxP2B
         ib+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBeJgry1Y+AOA8CIHk1k4cPjwBLoVAi/avjkWbQBvwd1cua/rx6Mfn7JhgrfEsXecUBl7xXLUTk4IrYvQ7bHAJ3tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/NxVoAPv7IfibBM31Q6/TC1Ao9newVpigV6GpJTPTOxp4fCK
	x1cZjbuVw7IF/Lpz+i6t7jEVpbkGhh/tyT/pX3qij9XzE7h00Oc1GMvh1D1AK1I/WKQ=
X-Gm-Gg: AY/fxX5jofBN/BlDlKWWCM/kmBQY5uS68kHZUZKhzwHgvTQUE4VME0sMAYFv6+E0Twn
	1Vf7568EA1WH22mZSet8VJwQBVS/Pw6dNJ6s/l9VMHLhmajQfDvrQZc9Ol8Bg8qb9MbZKJvEX6w
	pG3BSDln7G3M/cdYUtLksJZZzcRzMJC9xkUd4jkj06S5hpgEYBJ8WSbpGK6N4L+9r99/jdZK4bi
	anHmKYQhSU/YShwnM7shl0xIoH4Srwre30K5xpdsLiRCbGWPikbuIpgVTDuSiWFQzKIV+/LE1TG
	Ka6vtAlu0lhxNzuwdlQn0UX16ZOqe+s9dzzFeVzV92QfjlvMQUKhgnTupPi7rMeiUIuoFqNqnso
	8JJuQnxgoTIsZxcH2juBjW36/rNycCwN6Q8Rj3PzyyHG0jb0olXeKpziR5XLaEWKtW6LgwKhpcb
	4WP2J4WZXN9v3xrn0fD/AfcSD6ca0vQ5vDOEo=
X-Received: by 2002:a05:6000:4387:b0:432:c092:ee3b with SMTP id ffacd0b85a97d-4342d5dd58cmr4121853f8f.62.1768408910801;
        Wed, 14 Jan 2026 08:41:50 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a643sm284591f8f.1.2026.01.14.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:41:50 -0800 (PST)
Date: Wed, 14 Jan 2026 17:41:48 +0100
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
Subject: Re: [PATCH v16 1/3] lib: Introduce hierarchical per-cpu counters
Message-ID: <aWfHTLDA8-Fja_gD@tiehlicka>
References: <20260114145915.49926-1-mathieu.desnoyers@efficios.com>
 <20260114145915.49926-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114145915.49926-2-mathieu.desnoyers@efficios.com>

On Wed 14-01-26 09:59:13, Mathieu Desnoyers wrote:
> * Motivation
> 
> The purpose of this hierarchical split-counter scheme is to:
> 
> - Minimize contention when incrementing and decrementing counters,
> - Provide fast access to a sum approximation,
> - Provide a sum approximation with an acceptable accuracy level when
>   scaling to many-core systems.
> - Provide approximate and precise comparison of two counters, and
>   between a counter and a value.
> - Provide possible precise sum ranges for a given sum approximation.
> 
> Its goals are twofold:
> 
> - Improve the accuracy of the approximated RSS counter values returned
>   by proc interfaces [1],
> - Reduce the latency of the OOM killer on large many-core systems.
> 
> * Design
> 
> The hierarchical per-CPU counters propagate a sum approximation through
> a N-way tree. When reaching the batch size, the carry is propagated
> through a binary tree which consists of logN(nr_cpu_ids) levels. The
> batch size for each level is twice the batch size of the prior level.
> 
> Example propagation diagram with 8 cpus through a binary tree:
> 
> Level 0:  0    1    2    3    4    5    6    7
>           |   /     |   /     |   /     |   /
>           |  /      |  /      |  /      |  /
>           | /       | /       | /       | /
> Level 1:  0         1         2         3
>           |       /           |       /
>           |    /              |    /
>           | /                 | /
> Level 2:  0                   1
>           |               /
>           |         /
>           |   /
> Level 3:  0
> 
> For a binary tree, the maximum inaccuracy is bound by:
>    batch_size * log2(nr_cpus) * nr_cpus
> which evolves with O(n*log(n)) as the number of CPUs increases.
> 
> For a N-way tree, the maximum inaccuracy can be pre-calculated
> based on the the N-arity of each level and the batch size.

One thing you should probably mention here is the memory consumption of
the structure.

I have briefly looked at the implementation and concluded that I do not
have enough time to make a thorough review. Sorry about that. As I've
said in previous version the overall idea is sound. Especially if the
additional memory consumption is not a factor. I will let others judge
implementation details.

Thanks!
-- 
Michal Hocko
SUSE Labs
