Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C413DBD70
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556356; cv=none; b=hfvBG/+vm0PS4MSpHlY9phhzeMHrdV5909qm0r3dbhA3V8ToPbt4zSoh7RwIlqVIr5s2vH8uE5L7D4rkB8yWBlfCkK0lb5hsJlm+57IrdZbwpXl7+Us8Qf9HROpEtealX91F/6k54D8JY1Yy7GhZS3tiVmoG5wRoPMZmBSI4Fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556356; c=relaxed/simple;
	bh=zxZ/VfvaIkS8TII9oKq7ntOzkOx/HjhDAV7ClGFnQxc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui/0SHReWbLBNrPiM721xMWYx14C1nv7PBGgXPDTQ/9dwpbVN+iNn0N1tewjQvrnMYAo4kZhYTV8ck18YejRniCzD5H/wuzppNB8lW3zoZkw65/niQrVNKQeMFV7uwI70SDr60eTp2sJqIjv/T83lte2VdhewYNI/8oPL5+Iod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYYSrxO/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYYSrxO/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b12270b3so1898655e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780556353; x=1781161153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQc7wrvwx7HHBh4oNqeCqn4s+4+3EeZ70ok5+jemqmk=;
        b=FYYSrxO/IPtigwZP5e+UlKTthfR5LitG7sUSnXsLiPYAlrbMiTNiTehpzEtzkzYY06
         e1N19mO5O0E5EDO44hvD3ERL6IoecySftP/nKje9AS+o4nmkPYvDVUfSH8YxBQ2lQmsZ
         JHkq9y4E835RvAKFznK+/aY3AO0X6cCaZXwDRblMR15FqxKj4TQSB4DiFqqCn4B/KhCr
         uLujmMi6GCbnst0KJvk4uiZ6MiT9aD1Cjg432WK+mkqaeAu3YPdE5/m2+PbUKky/PKo6
         R/J00f2nK4FryXL+ykw2gwm80P1WvfqI7aNIqZbnJ28MPzopfaKV1KXGlRf1KY3tXdeW
         TOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780556353; x=1781161153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQc7wrvwx7HHBh4oNqeCqn4s+4+3EeZ70ok5+jemqmk=;
        b=DatRXIFVwSU6yqiVgB8s2r+ZZ2I9IrBv4/E/hzfFD08nGEiEYJPjORQJ7sXoWbZ1/F
         U8V4948UgiOxDuoa9TbqrMnvsmhhSuBfQbmnpFIoZrr9DGy0tkL+p9LYIa8pnYsXdvit
         Ywu2eBGo0mHtpMjn9SUs4St4XfsJ6eIr4dE8DCBn0eNJQ2gp6uXLCqnrKNJHfNDmiwdT
         1VPM0mI9rcfpOov2zXepdWbqtrLifyoyhqgcRH/vJdxYVHdrJYJpPB/HtiPRzYgLqPVR
         zmLLE3dgziki1eGKz72F8lEM+BJQHrMe+OcQRJ3k3og8s2hH24OYiju5RE5/DLv4vIRO
         fjyg==
X-Forwarded-Encrypted: i=1; AFNElJ9iKr9bysXrzmd0fZu0gZDVSPGYJPmECIU3J0HpmlBP0yOx6tI+p1JnjMkhiJxPu+3Pq5/1y26WMrIR1VV+CJY8/SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4Dou4FyxnrluOrEYQssHGR7eNopw5OJr183qC8q7jr69ZgKa
	AIZDD1gh4vvbzIUWztB7xnk55aobBQCtuzD524gvstt+GKLf176oZcRI
X-Gm-Gg: Acq92OFwAX/oz+kPlP3YRVd8wZNUHFuOHNIPKDuilsp20dybo6nYiklLXwTpk6zESD6
	ILyEFnNL+JCGmKhqIlUtn1Mtyd2Z+6+F1s+SiLkt4Ziln8p+gw0kSU9vjLJgzPfI42jppDdSKeN
	jm74gfNQw21B9BsLb4g8QyAMFUHbhNrBaEo2RpXsPISdRMpvTPyOLmh+OAEdSrs1egS9iDenm5T
	2JB7tcAVPlBZF+QBVEhJb9nSC3RDGRl7NXcTpsKQFnnQzKu1J1gQTeVnng7ozAizdi4fQxd22x4
	VYJjqf/HvF6bug9hpYI0B7EDF6mKrEcbRc7/LFQomwGRqgKRiM/78sDXBapsJG18N/Iru7LtgFz
	n8i0wAi8puFbETeS/VFmCYxjF0kdvAdLUUWWJTBqtFso8BXUwQFRRrvaTgvPlxO8ylNIzlpCTsb
	9V0wf6UFAHI7zaHEUAFCF6KUa9lA==
X-Received: by 2002:a05:600c:8b25:b0:490:b92f:ef5b with SMTP id 5b1f17b1804b1-490bc3b9bffmr42377065e9.13.1780556353179;
        Wed, 03 Jun 2026 23:59:13 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39e024sm60093735e9.4.2026.06.03.23.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 23:59:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 08:59:11 +0200
To: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized
 uprobes
Message-ID: <aiEiP54zktDqAZpG@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526205840.173790-1-jolsa@kernel.org>

On Tue, May 26, 2026 at 10:58:27PM +0200, Jiri Olsa wrote:
> hi,
> Andrii reported an issue with optimized uprobes [1] that can clobber
> redzone area with call instruction storing return address on stack
> where user code may keep temporary data without adjusting rsp.
> 
> Fixing this by moving the optimized uprobes on top of 10-bytes nop
> instruction, so we can squeeze another instruction to escape the
> redzone area before doing the call.
> 
> Note we need upstream update first for patch 3 (github.com/libbpf/usdt),
> if we decide to take this change.
> 
> thanks,
> jirka
> 
> 
> v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.org/
> v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.org/
> v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.org/
> 
> v4 changes:
> - do not use 2nd int3 (ont +5 offset) because the call instruction
>   is allways the same for the given nop10 address [Andrii/Peter]
> - unmap unused trampoline vma after unsuccesfull optimization [sashiko]
> - small change to patch#2 moved user_64bit_mode earlier in the path
>   and pass/use mm_struct pointer directly from arch_uprobe_optimize
>   instead of gettting current->mm
>   Andrii, keeping your ack, please shout otherwise

hi,
I think bots did not find anything substantial, I have just small
selftests changes queued for v5

any other feedback/review would be great

thanks,
jirka


> 
> v3 changes:
> - use nop10 update suggested by Peter in [2]
> - remove struct uprobe_trampoline object, use vma objects directly instead
> - selftests fixes [sashiko]
> - ack from Andrii
> 
> v2 changes:
> - several selftest fixes [sashiko]
> - consolidate is_lea_insn and is_call_insn insto single check [Jakub Sitnicki]
> - use proper mm_struct object in __in_uprobe_trampoline check [sashiko]
> - allow to copy uprobe trampolines vma objects on fork [sashiko]
> - change uprobe syscall detection error from -ENXIO to -EPROTO [Andrii]
> - added fork/clone tests
> - I kept the selftest changes and nop5->nop10 changes in separate
>   commits for easier review, we can squash them later if we want to keep
>   bisect working properly
> 
> 
> [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programming.kicks-ass.net/#t
> ---
> Andrii Nakryiko (1):
>       selftests/bpf: Add tests for uprobe nop10 red zone clobbering
> 
> Jiri Olsa (12):
>       uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
>       uprobes/x86: Remove struct uprobe_trampoline object
>       uprobes/x86: Allow to copy uprobe trampolines on fork
>       uprobes/x86: Unmap trampoline vma object in case it's unused
>       uprobes/x86: Move optimized uprobe from nop5 to nop10
>       libbpf: Change has_nop_combo to work on top of nop10
>       libbpf: Detect uprobe syscall with new error
>       selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
>       selftests/bpf: Change uprobe syscall tests to use nop10
>       selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
>       selftests/bpf: Add reattach tests for uprobe syscall
>       selftests/bpf: Add tests for forked/cloned optimized uprobes
> 
>  arch/x86/kernel/uprobes.c                               | 379 +++++++++++++++++++++++++++++++++++++++++++-----------------------------
>  include/linux/uprobes.h                                 |   5 -
>  kernel/events/uprobes.c                                 |  10 --
>  kernel/fork.c                                           |   1 -
>  tools/lib/bpf/features.c                                |   4 +-
>  tools/lib/bpf/usdt.c                                    |  16 +--
>  tools/testing/selftests/bpf/bench.c                     |  20 ++--
>  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++----
>  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++++++++--
>  tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
>  tools/testing/selftests/bpf/usdt.h                      |   2 +-
>  tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
>  14 files changed, 653 insertions(+), 245 deletions(-)
