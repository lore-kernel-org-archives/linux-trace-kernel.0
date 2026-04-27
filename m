Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FD3B777D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334138; cv=none; b=Mfy7CzyqWU3M1FBVskx1AgXuZOwxgeHqZsOxLke4oLX6ppzmSfgoD76XoXkO6KmqEznSj6zvPfNICXNBXGqJAXiAiX83BXPGjQp1UBKw/qudVElEy3Y3AAficC5ad56T4BmybLdQInI+xS85tlSu0Pt8MCL2do9rqJSngV2q0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334138; c=relaxed/simple;
	bh=6kXywhWGRAqfZcJnUKbUhCWuhKfcPlm4r7kE4iiYotc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Z73w/p0ZjEDRN0lAKcr7lE9Ocz6BXg8kKPpP8WzoiSynyhvBbfFZqjMkBEScH9cJW/u9bUoBGJVJvH+suHJp3R51FyqOYXvHC5O7z+a4yDSuhZSjncYvCeW9VlR0ZgxhzEgjw0aJX2ZOSwFi9PQI3Q8Vkklxji5G6jxsnDwmX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcuFY12v; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcuFY12v"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b45cb89f7eso67479075ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 16:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777334136; x=1777938936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgEWh+XI0SPB+PinHXs94gFrx3gTRtQhlrntWyMIEwk=;
        b=LcuFY12vVWO7vqr/F2eC3lhWHJSOrNATLXKt11bZknSt/jmHAxsCa2fq2Ckhzgs7NQ
         T8QpxY+aYZ3vCgmQb9W6CSCt2LA0PDBSio0kY8RaE7Sr6SW3O00EBhl3ZZ0J6pXuLEvR
         swqpCtV80o4ODeBpHUah5QPL6PmX0/KH6vUG0Pep/7K4KlJNbBcSE2QlcHthpQdiYZ4w
         0xpYVlAWQSWHB0YqA33sw6Taa2E+8uRo6+Z5cql+8zkAREGDa229fEbeIrn0V4h7d4xP
         XhmHqtO7BENBYcmIGM7OkvSZNX6Y+jW1/Ai3jO87L3H68gl7+jpqeLKDqPpVSqLvaEfA
         ZiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777334136; x=1777938936;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zgEWh+XI0SPB+PinHXs94gFrx3gTRtQhlrntWyMIEwk=;
        b=dUdlPAWC/9uiNRSHmIWDSfYXROWAFFt0PPQiWlfSiqzMa0/5lGdIJ0/rFe6sOISb6U
         0kJ4jcTShbZykk0PjaPUUXSYDdu6EwhzGsRkhjiD+dqevVXIIyIbVB1pEiSpTlh/zAnw
         XhpQ/52Blf4exS1QoHnxZMJcMyZsLcV1NkwY/wRk2b7HojIHqdgykMwhyqzgV+A651fS
         K8NLGfeRQiSTLCjunUtC4H4l77DT46zDBu8JIw73KCSRJ9zh1pg4JHdA14w7OzEQ+Wn8
         gpMFBxmChPJE/qoF3obJpEFCSFJX7npOdkDF79Xe4CMjaYTv+HWaMLbHy2zMt0G3FDq+
         Iylg==
X-Forwarded-Encrypted: i=1; AFNElJ+mIO5NyntJ5iYldobumDRAsV75BiK/7Yn3+aCc0LNUt6D8K825FhBs1B0w0Ua3Eu1MnHop+dT7giZZRpOijCwxwRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCsqiaqspB5HI2ZtqETaEpFb0gNmx2xQc06+j27QU5yk92ekyN
	RR90cY1lkB9vJmqiEAE8CxmrEHOC9gS0NUn4Ef4CNVVavA0aT88KSUfekzE2yA==
X-Gm-Gg: AeBDiesFpCU+wr2jItyWe/hCVbJCEANoW39q2YdW/EX860dsTOn1Qqd5PaEdugs0tTk
	GGwgd4o9AJDiD+PRVCm8/qYUhVQIq9+edx+MKlu1HiV0+VEdRdbQIaZgqQbOvIMamOhqFLhuTVe
	a3+gc55wnCyv+htEU0bGUThD7XFrERsYOZuJP8yaRt5kD/L8IrJlCDVzR+ohsgqpibzUcgMHGnB
	0WnVLD2mI6MTTRutmBTqT6SGqVLnuC53ljsTuDGP2jtVzMXCcIlRc4pgjg3tDuvOa6iVj4JUtV9
	jYt0oJ61PTuZFxG7ML3ULactOtnnKbggezZBcqsdDm7uf17/Twm4alpVQJr1H6L4jupL7oz9FJ3
	O3e8PztBOHVJpOb9fT0qhoMa7Ixed0be43CMa8nzKMoUUxyVTLMr3kUpc4zCpBRnw5R0Q9eSOpk
	4pIE2Tol5ObWP5ft8LPs4gFmS4/SAhDTEC
X-Received: by 2002:a17:902:76c3:b0:2ae:5eee:7a5 with SMTP id d9443c01a7336-2b97c43c746mr4936135ad.12.1777334136066;
        Mon, 27 Apr 2026 16:55:36 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97a96cc61sm6493415ad.0.2026.04.27.16.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 16:55:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm: kick writeback flusher for IOCB_DONTCACHE with targeted dirty tracking
In-Reply-To: <bb418f9a7bfcabc3070b412c745c5b6456d592b9.camel@kernel.org>
Date: Tue, 28 Apr 2026 04:56:10 +0530
Message-ID: <jytsrnn1.ritesh.list@gmail.com>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org> <20260426-dontcache-v3-2-79eb37da9547@kernel.org> <qzo1s6a4.ritesh.list@gmail.com> <bb418f9a7bfcabc3070b412c745c5b6456d592b9.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff Layton <jlayton@kernel.org> writes:

>> 
>> Also should the following change be documented somewhere? Like in Man
>> page maybe? i.e.
>> Earlier RWF_DONTCACHE writes made sure that those dirty pages are
>> immediately submitted for writeback and completion would release those
>> pages. But now, in certain cases when there is a mixed buffered write in
>> the system, those dontcache dirty pages might be written back after a
>> delay (whenever the next time writeback kicks in).
>> However for RWF_DONTCACHE reads, it should not affect anything.
>> 
>
> Looks like DONTCACHE is documented in the preadv/writev manpage. Here's
> the current blurb about writes:
>
>     Additionally, any range dirtied by a write operation with RWF_DONT‐
>     CACHE  set  will  get kicked off for writeback.  This is similar to
>     calling  sync_file_range(2)  with  SYNC_FILE_RANGE_WRITE  to  start
>     writeback on the given range.  RWF_DONTCACHE is a hint, or best ef‐
>     fort,  where  no hard guarantees are given on the state of the page
>     cache once the operation completes.
>
> I don't think this verbiage is invalid after this change. Kicking off
> writeback is still just a hint, like it was before. We could mention
> about how that I/O can compete with regular buffered I/O, but it seems
> a bit like we're adding info that will just be confusing for users.
>

Make sense.

>> > dontcache-bench results on dual-socket Xeon Gold 6138 (80 CPUs, 256 GB
>> > RAM, Samsung MZ1LB1T9HALS 1.7 TB NVMe, local XFS, io_uring, file size
>> > ~503 GB, compared to a v6.19-ish baseline):
>> > 
>> 
>> Can we please also test parallel buffered writes and dontcache writes? 
>> Since this patch series definitely affects that.
>>
>> BTW - adding these numbers in the commit msg itself is much helpful.
>> 
>
> To be clear, this only affects DONTCACHE, not normal buffered writes,
> but I guess you're referring to the fact that DONTCACHE and buffered
> writes can compete now.
>
> Can you clarify specifically what you'd like me to test here? Are you
> saying you want me to test parallel and buffered writes together at the
> same time (i.e. make them compete?).
>
> I should be able to do that for the local benchmarks, but nfsd's iomode
> settings are global and that won't be possible there.
>

The reason I am thinking of this is: dontcache marked pages, gets
evicted from page cache after they are written back. But this patch
series can now delay that from happening when there is a parallel
buffered writer dirtying page cache pages. Because of the reasons we
already discussed...

Note that, this may not be a workload which matters in the real world,
but I was thinking, it will be good to know the impact if any, of such
workload with this patch series (parallel buffered and dontcache
writers).


>> >   Single-client sequential write (MB/s):
>> >                        baseline    patched     change
>> >   buffered              1449.8     1440.1      -0.7%
>> >   dontcache             1347.9     1461.5      +8.4%
>> >   direct                1450.0     1440.1      -0.7%
>> > 
>> >   Single-client sequential write latency (us):
>> >                        baseline    patched     change
>> >   dontcache p50         3031.0    10551.3    +248.1%
>> >   dontcache p99        74973.2    21626.9     -71.2%
>> >   dontcache p99.9      85459.0    23199.7     -72.9%
>> > 
>> >   Single-client random write (MB/s):
>> >                        baseline    patched     change
>> >   dontcache              284.2      295.4      +3.9%
>> > 
>> >   Single-client random write p99.9 latency (us):
>> >                        baseline    patched     change
>> >   dontcache             2277.4      872.4     -61.7%
>> > 
>> >   Multi-writer aggregate throughput (MB/s):
>> 
>> Can you please help describe this test scenario if possible.. In above
>> you mentioned we are writing file_size as 2x RAM_SIZE. But your
>> multi-client tests says something else..
>> 
>> local num_clients=4
>> +	mem_kb=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
>> +	client_size="$(( mem_kb / 1024 / num_clients ))M"
>> 

I guess you missed answering this. The reason why I was asking about this is....

>> >                        baseline    patched     change
>> >   buffered              1619.5     1611.2      -0.5%
>> >   dontcache             1281.1     1629.4     +27.2%
>> >   direct                1545.4     1609.4      +4.1%
>> > 

... If we see the performace of buffered and dontcache in baseline case,
then we don't see dontcache doing any good. Even the patched version is
just slightly better compared to buffered case.

But IIUC, dontcache should really shine in cases where we have buffered
writers dirtying the page cache pages which can overflow the RAM size
[1]. The reason why dontcache should show benefit there is, because we
don't see any page cache pressure, since after writeback the pages gets
evicted. Also earlier in the unpatched version, the I/O submission
happens immediately in the same context.

So, I guess, isn't it better to evaluate those scenarios as well with
the patched version - since this series affects those code paths now?

[1]: https://lore.kernel.org/all/20241110152906.1747545-11-axboe@kernel.dk/

>> 
>> Nice :)
>> Some explaination here of why 5x improvement with NFS compared to local
>> filesystems please?
>> (I am not much aware of NFS side, but a possible reasoning would help)
>> 
>
> I suspect that it's because of the "scattered" nature of nfsd writes.
> When the client sends a write to nfsd, we wake a nfsd thread to service
> it. So, if there are a lot of writes operating in parallel, they all
> get done in the context of different tasks.
>
> My hunch is that this I/O pattern (writing to same file from a bunch of
> different threads), particularly suffers from the DONTCACHE inline
> write behavior. The threads all end up competing to submit jobs to the
> queue and that causes the performance to fall off sharply.
>

Thanks!

-ritesh
