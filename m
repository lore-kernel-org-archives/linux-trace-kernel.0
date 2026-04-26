Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526712FFF99
	for <linux-trace-kernel@vger.kernel.org>; Sun, 26 Apr 2026 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777246998; cv=none; b=YcAgJxeHi49sj4/22cFWCcZg1CcZENryUU72incGD9+ZW2VsfuFlKQvpJgQrMJXcij6gY0YFKWUGowYmUoC7qB0Zh8lGnH8AlRwxyHNRnuOnP0CCJ9YAKJB4lpGga+AMLjBYiHUtZUlq0+V02zqJPA7FuqCpjV1iDh7aayslJcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777246998; c=relaxed/simple;
	bh=QTqu1wmocWcq6zBzB9KmwmGLME2u4qreqaKpysA/Isk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fQTb0nTQZRgxzdC8oDZoNjz1YWfhNA75T7GmBvkyYAr/RpTqoandRCB8rLU6Bh6KT+oulcVFxp8jKfLuUeKTagDn7+Z6Z77S3nlI908siD0YYPE9xgRmh/7Vl0rarZDKmly05jE+ARz5cv4nlv4y8pKIi2Y0QwGeBujcV1z2kUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeZ2QG3r; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeZ2QG3r"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so6453902a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 26 Apr 2026 16:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777246997; x=1777851797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMcuATLy/ginolpQIDJCxy12h57szRVGfrxwU4MqXGI=;
        b=IeZ2QG3rILzi3aByOUCwZ8Ka2a2cJ+lMDvL56yYWGRDRBNDqDRPFa13Hcz0AvytQoz
         tJkcBdXGEvuFTydfQ9VBz2G4peixyg6F9A7jHhi0p7R+VnfbmwJq2ihu+YR86hfVKbXB
         j7aaLDRR0+qZYIE8Y1HUIXN61qQ6s1EZZ2UhW+1PhNt92VILNESxUPYRHLSLI1KnipBH
         JUoBNSdjrD3hyhBFLWCIlqG3redlpZ9k3Z3DLmE7Ca9p2JqoayfETuzywPVHQBIpp1aY
         Zq5bLLFIilWjfoDaZWGwCBlawfcTvhbXYXkXeqla+GqcNwhSuRSiA9c/izCve+WV/j+u
         aNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777246997; x=1777851797;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GMcuATLy/ginolpQIDJCxy12h57szRVGfrxwU4MqXGI=;
        b=E+MlyJR5vloiXoYj4rEgIvjVyRrEfuovhvrC+D33mp7GMG3uTJi/yvhD5NTAikiR+Z
         bI4j4qkMW6nu4BWgJ2vY2tS0gJbX9kZDrKQqGtpNvtcUlL1fFpmq0e4ULRvomaSPZM6E
         zENDWkGwZp+J8pDJo3o3GR6mCUphzU6QelPJ5jm29algNGenK8TVSh8TvGNJvKJOqSF/
         k/DmwGd4EXbXA9ihjbfpwk/JGMKLjnoj6FpI/MwxjzVUDwEI8PgXpop7oXJpdUmpQ/zb
         w1HKJXdSzpa6ECcZbuMSrmGGjeWkzT8jIvpbZRhipm0yN4qhq9/ELQi0FUF1K4wO+OTE
         ZP8A==
X-Forwarded-Encrypted: i=1; AFNElJ/IAZflLCfyKYW2V0KYZBUnKJKdv7zAWrdhotMu/olwc5oU1PLqx8bFgy+m30aF5gDqMfVBlt6/63orMfKFXzBPpPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytO0DbCZUnJEByfbl61aiKE4Q7K2ZxlLlazfcWztehMzFhfkrg
	69tfhsI0gXwgOTZNcdB0SiG9bjO/QBAf2BUkCbFMkBT012yWJ9UM6czM
X-Gm-Gg: AeBDiettOnkF4SHDcKTrjiMwwcNm32pSn83ZbXQHPD81T1jJwZN/hft4oZA6pIHK2t2
	OrOBFZ7KZYXO2qIOSPuN8LQ5VJe+HaX3mItH0b6kxCbebPd4ulhMad0SCFw6o5AQfBg2AMMNSWo
	iiv5D1rpeb6Ve+G6CPyw3q0lSxO0A2xxQKPmKthqRTn19NzUw9t4OJU9yqRxTnXWWFs/s2v7GPx
	aWaxanFuks1WbFM11GkszEdBA1Dvi9aqQR4a4zLtWfsHrLc2Y3f09CmUZQagDN6tRd20iHBnb7W
	pRJGQfQMg2DvjhudDKA4KHwJrjzw1Ix87WFsQstkfDTqHS1bC3i5YOqUnBWamD3tiIhsAs6veXi
	ehLRLrnD/AVZxU4HsED6A6xkPdfgpUmKYIs5fD+OP60BVQHIiRzen/sUZzJA3L/JHZPkLOjfsfF
	+OQ1y0qb/v4yBj9nvX86iLLfe/ZK/nX/ZT
X-Received: by 2002:a17:90b:5845:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-36140473f70mr42914414a91.14.1777246996503;
        Sun, 26 Apr 2026 16:43:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-362b9a79176sm17396721a91.5.2026.04.26.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 16:43:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3 2/4] mm: kick writeback flusher for IOCB_DONTCACHE with targeted dirty tracking
In-Reply-To: <20260426-dontcache-v3-2-79eb37da9547@kernel.org>
Date: Mon, 27 Apr 2026 04:01:15 +0530
Message-ID: <qzo1s6a4.ritesh.list@gmail.com>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org> <20260426-dontcache-v3-2-79eb37da9547@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff Layton <jlayton@kernel.org> writes:

> The IOCB_DONTCACHE writeback path in generic_write_sync() calls
> filemap_flush_range() on every write, submitting writeback inline in
> the writer's context.  Perf lock contention profiling shows the
> performance problem is not lock contention but the writeback submission
> work itself =E2=80=94 walking the page tree and submitting I/O blocks the=
 writer
> for milliseconds, inflating p99.9 latency from 23ms (buffered) to 93ms
> (dontcache).
>
> Replace the inline filemap_flush_range() call with a flusher kick that
> drains dirty pages in the background.  This moves writeback submission
> completely off the writer's hot path.
>
> To avoid flushing unrelated buffered dirty data, add a dedicated
> WB_start_dontcache bit and wb_check_start_dontcache() handler that uses
> the new NR_DONTCACHE_DIRTY counter to determine how many pages to write
> back.  The flusher writes back that many pages from the oldest dirty
> inodes (not restricted to dontcache-specific inodes). This helps
> preserve I/O batching while limiting the scope of expedited writeback.
>

Yup, so, we wakeup the writeback flusher, which will write those many
"number" of dirty pages. Those dirty pages written by writeback, can be
of any type though, can be DONTCACHE or normal (non-dontcache) dirty
pages. IIUC, writeback doesn't distinguish between them while writing.


IMO, what we could also include in the commit msg is why is this above
approach taken? IIUC, that is because, by writing NR_DONTCACHE_DIRTY
pages, it still reduces the page cache pressure and still reduces the
amount of work that the reclaim has to do, even though some of those
pages maybe non-dontcache pages, in case if there was a parallel
buffered write in the system.


Also should the following change be documented somewhere? Like in Man
page maybe? i.e.
Earlier RWF_DONTCACHE writes made sure that those dirty pages are
immediately submitted for writeback and completion would release those
pages. But now, in certain cases when there is a mixed buffered write in
the system, those dontcache dirty pages might be written back after a
delay (whenever the next time writeback kicks in).
However for RWF_DONTCACHE reads, it should not affect anything.

> Like WB_start_all, the WB_start_dontcache bit coalesces multiple
> DONTCACHE writes into a single flusher wakeup without per-write
> allocations.
>
> Also add WB_REASON_DONTCACHE as a new writeback reason for tracing
> visibility, and target the correct cgroup writeback domain via
> unlocked_inode_to_wb_begin().
>
> dontcache-bench results on dual-socket Xeon Gold 6138 (80 CPUs, 256 GB
> RAM, Samsung MZ1LB1T9HALS 1.7 TB NVMe, local XFS, io_uring, file size
> ~503 GB, compared to a v6.19-ish baseline):
>

Can we please also test parallel buffered writes and dontcache writes?=20
Since this patch series definitely affects that.

BTW - adding these numbers in the commit msg itself is much helpful.

>   Single-client sequential write (MB/s):
>                        baseline    patched     change
>   buffered              1449.8     1440.1      -0.7%
>   dontcache             1347.9     1461.5      +8.4%
>   direct                1450.0     1440.1      -0.7%
>
>   Single-client sequential write latency (us):
>                        baseline    patched     change
>   dontcache p50         3031.0    10551.3    +248.1%
>   dontcache p99        74973.2    21626.9     -71.2%
>   dontcache p99.9      85459.0    23199.7     -72.9%
>
>   Single-client random write (MB/s):
>                        baseline    patched     change
>   dontcache              284.2      295.4      +3.9%
>
>   Single-client random write p99.9 latency (us):
>                        baseline    patched     change
>   dontcache             2277.4      872.4     -61.7%
>
>   Multi-writer aggregate throughput (MB/s):

Can you please help describe this test scenario if possible.. In above
you mentioned we are writing file_size as 2x RAM_SIZE. But your
multi-client tests says something else..

local num_clients=3D4
+	mem_kb=3D$(awk '/MemTotal/ {print $2}' /proc/meminfo)
+	client_size=3D"$(( mem_kb / 1024 / num_clients ))M"

Also the multi-writer case is spawning parallel fio jobs, and then
parsing and aggregating the bandwidth results instead of using fio to
spawn multiple parallel threads... which is ok, but a bit wierd.
Why not let fio do the aggregate bandwidth, and latency calculation
instead?

>                        baseline    patched     change
>   buffered              1619.5     1611.2      -0.5%
>   dontcache             1281.1     1629.4     +27.2%
>   direct                1545.4     1609.4      +4.1%
>
>   Mixed-mode noisy neighbor (dontcache writer + buffered readers):
>                        baseline    patched     change
>   writer (MB/s)         1297.6     1471.1     +13.4%
>   readers avg (MB/s)     855.0      462.4     -45.9%
>
> nfsd-io-bench results on same hardware (XFS on NVMe, NFSv3 via fio
> NFS engine with libnfs, 1024 NFSD threads, pool_mode=3Dpernode,
> file size ~502 GB, compared to v6.19-ish baseline):
>
>   Single-client sequential write (MB/s):
>                        baseline    patched     change
>   buffered              4844.2     4653.4      -3.9%
>   dontcache             3028.3     3723.1     +22.9%
>   direct                 957.6      987.8      +3.2%
>
>   Single-client sequential write p99.9 latency (us):
>                        baseline    patched     change
>   dontcache            759169.0   175112.2     -76.9%
>
>   Single-client random write (MB/s):
>                        baseline    patched     change
>   dontcache              590.0     1561.0    +164.6%
>
>   Multi-writer aggregate throughput (MB/s):
>                        baseline    patched     change
>   buffered              9636.3     9422.9      -2.2%
>   dontcache             1894.9     9442.6    +398.3%
>   direct                 809.6      975.1     +20.4%
>
>   Noisy neighbor (dontcache writer + random readers):
>                        baseline    patched     change
>   writer (MB/s)         1854.5     4063.6    +119.1%
>   readers avg (MB/s)     131.2      101.6     -22.5%
>
> The NFS results show even larger improvements than the local benchmarks.
> Multi-writer dontcache throughput improves nearly 5x, matching buffered
> I/O. Dirty page footprint drops 85-95% in sequential workloads vs.
> buffered.
>

Nice :)
Some explaination here of why 5x improvement with NFS compared to local
filesystems please?
(I am not much aware of NFS side, but a possible reasoning would help)

-ritesh

