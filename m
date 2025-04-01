Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BB13AA2F;
	Tue,  1 Apr 2025 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743478038; cv=none; b=IqQNawhWJZLwFj52RKNvo8O49GGt873dZAvnSHqnr2kp1mvMdK8Gb8ZPtIat253GGaKXRaCMzxwLgFnEp1LAPQXx5GOdQfNIiqWS5iWkL95MJLbNtgvJwSHfJuafcn9jPHbD+JVLM//sPZqpzpNeN06gaTRxtQOQuLk53cBEuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743478038; c=relaxed/simple;
	bh=JpRMSG4y+HpoC78IzJ6RPNdQpNyIUd6Y6hkV0WMQsds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZUXrwH5WwPmNj+1t29L1/Hqa4VfmdXhkGnJLL7PnH5K9mQaw1/WJwkZfZ4FKAujAu/ZDE7ghA4HL3AiFq68B5jGNbOk6ty1OncNmKSF4SnC0HnkIcyZ/EAsXJ+f3V8eQvX6cwItf7sO4A2sJx4JQD0vBUjG13GA1bUIbMz9DAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeKvJk9K; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeKvJk9K"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5499d2134e8so5733271e87.0;
        Mon, 31 Mar 2025 20:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743478035; x=1744082835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PMpO2/suGC0ARSAeEmRf7TeWHcQ6pkbpeUtrBkFfIM=;
        b=JeKvJk9KYicu6EV06VK4inE7ym+3hIeSnY5zYfmz7f6mBTYYajNXS03xO0Y1fyHv0D
         /DU9ri/dqnhxG+QV/vBLi8DdumQppi9bF+eQYgslLRO2BcClEZlTxd8TaOibrwfqXL6Y
         TOIyjYApq5z0+eXcHkVR9qBcKo62Tw7DezP4P4TqqAHZ4XvYnbPhIOESqY+V2G3tY3Ey
         qV+M1qAQhLRlh9I67TPu8vZtgETrxbWEmgWQL0Z4Wfc4+yjS374oeHTYZ8wGa2olAQkP
         /gsDkbIW4thaoS7AlLaCQcJlbOvFhwdULI2SNUXcFnSZFtgPQcLiegL9Qkq10sjxWGEH
         BRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743478035; x=1744082835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PMpO2/suGC0ARSAeEmRf7TeWHcQ6pkbpeUtrBkFfIM=;
        b=STCIJl54ik4Rq2K2q+HGqPDQYNdhTt1zDPCN47Ycu5a1VVkIBACHFlE89goOJ0MVFk
         r5xnlSy6jBQJNBWTTu7B0w8w0IUiyRaCoUVwdvqiX3y406FoU3oa7ZPGlNaXjJiCjmGJ
         So528TQVveqkEZ3Kq+6EQxSF7u9LYIqTyuE47PtWFKQXDA/CD48VDK3Y2QKImj4tAxdJ
         ZFR7lCLtMkGiAUh6JLKHdN2FHOoCDBzcaHGiYJbMy1uBUyit4Vtcm/5E71rb5GNM2ETl
         v6XycHTO7VfJO30f3+rMaq6G/BI7jOt94E8CNc9lbY/ZeoHfk9ayR1oo2I5kM8kipZ4a
         O0BA==
X-Forwarded-Encrypted: i=1; AJvYcCXVHo4Nr+rr4m4kVMKPqaAg5dqg43t0QFuOGgdq0oIwOQ1hDa+YiENh0ujBZRwMCdYlS5MNU61Jmm/4mfqegQGN3nPO@vger.kernel.org, AJvYcCXpj7vjriktQqbOMkjl/+L+GU6QDkGZMneNQRysBdkJ33hu85q/5rATlKmyfobAO4TgdqTHhCZs3d/eYd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywdmmYPioNZUKF5N6T+3oAMZ2AXmA/1uaHhQ23fnJ8HRnS1Tic
	WZeSgZBCR/K42NMpJhEerHP8LFCVfHzS4tswx9PEIv3QgwXki4wCJ9IvV9MC00OSskEmPHCer2d
	vxj5Osoznp4IcjxjhIJNfqt68YnY=
X-Gm-Gg: ASbGncsHTpCUgoxROL0z+dLqjerLRHfzvJWQoVMZZQlvVJaaR+ZS6gxdDUl7Wgg0ljF
	z58/PXPmriehokKv2ZtMLydaeXqgoze4+8xWXGOWe/6xofwEtG8Mn6gGwQlI4lm2FZ73c8bbHUt
	+QKFccfIIMF8/z+iYXK2QqcYbYun45JgnCh/EQ
X-Google-Smtp-Source: AGHT+IEm8Qm2x7jTGG6I1atPXJ5ybseu2lCiRGTMOndtoEUvMXIrXP9gxloBkptnrRjLwd9n2WDiSdi5eAm5ic+RfbY=
X-Received: by 2002:a05:6512:2244:b0:540:1f7d:8bce with SMTP id
 2adb3069b0e04-54b11128191mr2739891e87.38.1743478034910; Mon, 31 Mar 2025
 20:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
In-Reply-To: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 1 Apr 2025 11:26:58 +0800
X-Gm-Features: AQ5f1JoNr6kDqJ43H441717JQENbbrXTG_y_ViKPl6dlH7HzyhSUtpo35zjSf_Q
Message-ID: <CAMgjq7AroDCKTfJzJRr++8H2b3eTd=MeUqwkPUX4ixRVqZw6-A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: use per-numa-node atomics instead of percpu_counters
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Sweet Tea Dorminy <sweettea@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 6:36=E2=80=AFAM Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:
>
> [Resend as requested as RFC and minus prereq-patch-id junk]
>
> Recently, several internal services had an RSS usage regression as part o=
f a
> kernel upgrade. Previously, they were on a pre-6.2 kernel and were able t=
o
> read RSS statistics in a backup watchdog process to monitor and decide if
> they'd overrun their memory budget. Now, however, a representative servic=
e
> with five threads, expected to use about a hundred MB of memory, on a 250=
-cpu
> machine had memory usage tens of megabytes different from the expected am=
ount
> -- this constituted a significant percentage of inaccuracy, causing the
> watchdog to act.
>
> This was a result of f1a7941243c1 ("mm: convert mm's rss stats into
> percpu_counter") [1].  Previously, the memory error was bounded by
> 64*nr_threads pages, a very livable megabyte. Now, however, as a result o=
f
> scheduler decisions moving the threads around the CPUs, the memory error =
could
> be as large as a gigabyte.
>
> This is a really tremendous inaccuracy for any few-threaded program on a
> large machine and impedes monitoring significantly. These stat counters a=
re
> also used to make OOM killing decisions, so this additional inaccuracy co=
uld
> make a big difference in OOM situations -- either resulting in the wrong
> process being killed, or in less memory being returned from an OOM-kill t=
han
> expected.
>
> Finally, while the change to percpu_counter does significantly improve th=
e
> accuracy over the previous per-thread error for many-threaded services, i=
t does
> also have performance implications - up to 12% slower for short-lived pro=
cesses
> and 9% increased system time in make test workloads [2].
>
> A previous attempt to address this regression by Peng Zhang [3] used a hy=
brid
> approach with delayed allocation of percpu memory for rss_stats, showing
> promising improvements of 2-4% for process operations and 6.7% for page
> faults.
>
> This RFC takes a different direction by replacing percpu_counters with a
> more efficient set of per-NUMA-node atomics. The approach:
>
> - Uses one atomic per node up to a bound to reduce cross-node updates.
> - Keeps a similar batching mechanism, with a smaller batch size.
> - Eliminates the use of a spin lock during batch updates, bounding stat
>   update latency.
> - Reduces percpu memory usage and thus thread startup time.
>
> Most importantly, this bounds the total error to 32 times the number of N=
UMA
> nodes, significantly smaller than previous error bounds.
>
> On a 112-core machine, lmbench showed comparable results before and after=
 this
> patch.  However, on a 224 core machine, performance improvements were
> significant over percpu_counter:
> - Pagefault latency improved by 8.91%
> - Process fork latency improved by 6.27%
> - Process fork/execve latency improved by 6.06%
> - Process fork/exit latency improved by 6.58%
>
> will-it-scale also showed significant improvements on these machines.
>
> [1] https://lore.kernel.org/all/20221024052841.3291983-1-shakeelb@google.=
com/
> [2] https://lore.kernel.org/all/20230608111408.s2minsenlcjow7q3@quack3/
> [3] https://lore.kernel.org/all/20240418142008.2775308-1-zhangpeng362@hua=
wei.com/

Hi, thanks for the idea.

I'd like to mention my previous work on this:
https://lwn.net/ml/linux-kernel/20220728204511.56348-1-ryncsn@gmail.com/

Basically using one global percpu counter instead of a per-task one, and
flush each CPU's sub-counter on context_switch (if next->active_mm !=3D
current->active_mm, no switch for IRQ or kthread).
More like a percpu stash.

Benchmark looks great and the fast path is super fast (just a
this_cpu_add). context_switch is also fine because the scheduler would
try to keep one task on the same CPU  to make better use of cache. And
it can leverage the cpu bitmap like tlb shootdown to optimize the
whole thing.

The error and total memory consumption are both lower than current design t=
oo.
