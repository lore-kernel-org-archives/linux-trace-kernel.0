Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD861C84D3;
	Wed, 26 Mar 2025 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032184; cv=none; b=CIX9CXEKrvc8fWOj1mgUo3+eNiWkzIm3lCqLkt0vftfhYq6pdx7u0eYaItUNMhpYNVcHQWxpJ+sdahwLi9Y9WElsmLtyUJxXd5VdBOC+bfL1GOxzeM1WLskncbhyKp1t0Eov6YYBE0f4PlXxTcPakivoC5qeYXZfGp+XnuX/CPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032184; c=relaxed/simple;
	bh=I+1BD2iYpQhpy2hk/q4oXZ4zeqFgT+Bzn8cSp5yDDcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNBPhmbLDjZM14P9WzKJ/e1RVuNPVambK26kUO6JV90F4BzklVSj+L/JJYaxFWFVbQj5tCOIOKISlNOMehnQthW4quchf9rMTUZ4MOSXe6+zWrM+RX5Gjxn1jaklxZBpHuU2igSKiJflRZsUbw33Ls1T8IAwqD1EJkYrrjZi1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGlA5Eph; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGlA5Eph"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43690d4605dso2733415e9.0;
        Wed, 26 Mar 2025 16:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743032181; x=1743636981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+gpxRnuJVIVSr8pBWj81ZRvp6VQfzrOyG3qUhDElcCg=;
        b=XGlA5Eph4n+jRvpy6VsFtSbbxW6gIOkhxwqCAcNte1IrGTTZ6fQAO81s/QJcOcmyjV
         ayLNQUyG6ZZL88LaYGX1mKwWZThn6YQxCPU9iDhhVDiLTKuZWoXkRhguDU9Q3OVPFejq
         LdeV7Lux8pKxaBM5+MHWYSRWtreAROTmiCiwILmfBDOXUzbLLQgzdaw3G6LFn2D61vlC
         qcTB+mRla7j0Ppu6yOcbHgcZHuqCEKJxt7gwlSJ99DRQVBqLkaWMr1CjcQN5efHL6f55
         InQAFSeKbZ1nb5LI7cBcfwol7BRimH9rTKaaqP4fFNqqFOBWFTvew+PlC+Nvnf+uUsJN
         JqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743032181; x=1743636981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gpxRnuJVIVSr8pBWj81ZRvp6VQfzrOyG3qUhDElcCg=;
        b=sYeY9qojZaMN75NJ2jIh52vKkvvUim9xHmyMuQJvX9UXGtvWd/gFpcdsBwzCJ7YSC2
         IYhmklzba68Q0Svv/HLrxlOUCqbuEPwLXnAUtYUYOFZnYrGz+1Y9rOxyS/JWDM9tqr3I
         56BFXhsa14/xc7zjBU+Rq5J225wM1phSWE/7KJttKyx5UT6dDNKiAL5OAL2RaaBpxLlb
         PNxzzQQtzqiEq469RUz8EiGlrTajXL1k+k5x9K1Hxta4RrzCpxdrQovMhc376yTWmjoC
         9KMjr6/UxieP3bT1cbfl/sFSEnQoBS27n6S7bcPM8dXqdBSP1SuJMoVz2CvFkWvA8/xv
         IoMA==
X-Forwarded-Encrypted: i=1; AJvYcCV+X6P0hTXliIYKUitm1c8LuLfqYZSNX8SNIbJtGyI4r5OAjNIqQ1ZR7Ll3g37VehdzyNQeA/8uA9OL9VY=@vger.kernel.org, AJvYcCXc5cZ5B/QDYyx9Vq4n9WagTw9qsQcgVYE2qVXhOiydSQsyiHkAfJ0SPvPRz1RQN1kjeL/3aL7eOqS3x9V4kbmxXOuf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9lEenTj9hHv/egqmvMG2zpJ7Gu51Y4rFXglVztBiPqwQiw23
	elELXMaACN4cD+oPW3Kb5s3O83vMlIvR9MWLbBdQun7TUyFaiZAL
X-Gm-Gg: ASbGnctP5KJsLDNHxRAl4Lnv2ThRKyNWI4WnpzhVudtNg9Vgg1aLNdMvUocfqBfcRCg
	4dGL5STcFHMzl2knDNGFiAx9wb8usWQrYAjOKrEyofBWjrMnMznXIcu70sp3YdeEOqhhAn4yogb
	yYNSHWLtXqYb0si1AO+tRJzHerGXo1NsSG1oaM6uNZMTf8eFd3d06K3FmH+6f8ODYeY4UfsL5o4
	6rMNoJvgyAN6WmxGnePhgk4sGd/0YK35tmctTtax1sos4Wq/UALzJbv3aG0/nIrXDIzUrXhV7ln
	0ScFntOOd7zVyB3k48s8O/4HHiOOMJZN9zDDvwRWDVU1XT97o8LCIjhSBB64
X-Google-Smtp-Source: AGHT+IFz0F2wc1aL46ik2E1XpPNYlbJYtT9XpCftxWi2JDIsiQu5DLWnXHZ0BlYk5pj9NjT8WdVWRw==
X-Received: by 2002:a05:600c:4e56:b0:43d:bb9:ad00 with SMTP id 5b1f17b1804b1-43d850fd05amr11243815e9.15.1743032180778;
        Wed, 26 Mar 2025 16:36:20 -0700 (PDT)
Received: from f (cst-prg-80-192.cust.vodafone.cz. [46.135.80.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ad32bd464sm71193f8f.57.2025.03.26.16.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 16:36:19 -0700 (PDT)
Date: Thu, 27 Mar 2025 00:36:07 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, Jani Nikula <jani.nikula@intel.com>, 
	Sweet Tea Dorminy <sweettea@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH] mm: use per-numa-node atomics instead of percpu_counters
Message-ID: <evqxyt5dkkervut7q4ea4dnykcz75lxx2wvqyg2lq7m3ptam3c@53ao37tlhytk>
References: <20250325221550.396212-1-sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325221550.396212-1-sweettea-kernel@dorminy.me>

On Tue, Mar 25, 2025 at 06:15:49PM -0400, Sweet Tea Dorminy wrote:
> From: Sweet Tea Dorminy <sweettea@google.com>
> 
> This was a result of f1a7941243c1 ("mm: convert mm's rss stats into
> percpu_counter") [1].  Previously, the memory error was bounded by
> 64*nr_threads pages, a very livable megabyte. Now, however, as a result of
> scheduler decisions moving the threads around the CPUs, the memory error could
> be as large as a gigabyte.
> 
> This is a really tremendous inaccuracy for any few-threaded program on a
> large machine and impedes monitoring significantly. These stat counters are
> also used to make OOM killing decisions, so this additional inaccuracy could
> make a big difference in OOM situations -- either resulting in the wrong
> process being killed, or in less memory being returned from an OOM-kill than
> expected.
> 
> Finally, while the change to percpu_counter does significantly improve the
> accuracy over the previous per-thread error for many-threaded services, it does
> also have performance implications - up to 12% slower for short-lived processes
> and 9% increased system time in make test workloads [2].
> 
> A previous attempt to address this regression by Peng Zhang [3] used a hybrid
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
> Most importantly, this bounds the total error to 32 times the number of NUMA
> nodes, significantly smaller than previous error bounds.
> 
> On a 112-core machine, lmbench showed comparable results before and after this
> patch.  However, on a 224 core machine, performance improvements were
> significant over percpu_counter:
> - Pagefault latency improved by 8.91%
> - Process fork latency improved by 6.27%
> - Process fork/execve latency improved by 6.06%
> - Process fork/exit latency improved by 6.58%
> 
> will-it-scale also showed significant improvements on these machines.
> 

The problem on fork/exec/exit stems from back-to-back trips to the
per-cpu allocator every time a mm is allocated/freed (which happens for
each of these syscalls) -- they end up serializing on the same global
spinlock.

On the alloc side this is mm_alloc_cid() followed by percpu_counter_init_many().

Even if you eliminate the counters for rss, you are still paying for CID. While
this scales better than the stock kernel, it still leaves perf on the table.

Per our discussion on IRC there is WIP to eliminate both cases by
caching the state in mm. This depends on adding a dtor for SLUB to undo
the work in ctor. Harry did the work on that front, this is not
submitted to -next though.

There is a highly-inefficient sanity-check loop in check_mm(). Instead
of walking the entire list 4 times with toggling interrupts in-between,
it can do the walk once.

So that's for the fork/execve/exit triplets.

As for the page fault latency, your patch adds atomics to the fast path.
Even absent any competition for cachelines with other CPUs this will be
slower to execute than the current primitive. I suspect you are
observing a speed up with your change because you end up landing in the
slowpath a lot and that sucker is globally serialized on a spinlock --
this has to hurt.

Per my other message in the thread, and a later IRC discussion, this is
fixable with adding intermediate counters, in the same spirit you did here.

I'll note though that numa nodes can be incredibly core-y and that
granularity may be way too coarse.

That aside there are globally-locked lists mms are cycling in and out of
which also can get the "stay there while cached" treatment.

All in all I claim that:
1. fork/execve/exit tests will do better than they are doing with your
patch if going to the percpu allocator gets eliminated altogether (in
your patch it is not for mm_alloc_cid() and the freeing counterpart),
along with unscrewing the loop in check_mm().
2. fault handling will be faster than it is with your patch *if*
something like per-numa state gets added for the slowpath -- the stock
fast path is faster than yours, the stock slowpath is way slower. you
can get the best of both worlds on this one.

Hell, it may be your patch as is can be easily repurposed to
decentralize the main percpu counter? I mean perhaps there is no need
for any fancy hierarchical structure.

I can commit to providing a viable patch for sorting out the
fork/execve/exit side, but it is going to take about a week. You do have
a PoC in the meantime (too ugly to share publicly :>).

So that's my take on it. Note I'm not a maintainer of any of this, but I
did some work on the thing in the past.
