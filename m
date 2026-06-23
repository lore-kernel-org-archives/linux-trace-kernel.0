Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEE37C907
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241880; cv=none; b=N+OLuzP9d4qGfjSHWfb4/+xy7zLPEzR3jGXiikaOdL2rR1kENBMTZbqKI2RulbgC3WBrJQ+AdhkXrKeC1nOaJWyTp2FDotm5s9Op6elDuK9xvgHa46wcFWLXzXTTbjMKF/tDEqImgMdO5CrCCBWBgu+vdC8x7Xu/w6wDCzI4Uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241880; c=relaxed/simple;
	bh=ak2Pag302wzIU6JvetlLqwWRWhBzDXIm/3d0p/6xjDU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJsRikBz7Y10yPZ7QPzwvCTqnqFmt/lJ4VQ/RJMWH3WWHcQaxtYYGqguK0axCXKoQ4JNVqmLSYIRYOGr03yy1N0HayYGmaQhScAWKhDsSIYhxfrjrpbbiaxXGDrXrLucXss9hIm4SvEWV1ugMs/hxv7ER/MFKte2ouzmZATfnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJOpDK8E; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJOpDK8E"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-463f1165e16so281605f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782241873; x=1782846673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6oU+L9zQu/aklDl++k+2cg0xhcWLV/5t/SZwmgE+09o=;
        b=jJOpDK8EoGAYU1uOUQB/YMRlIjyQYQX7RLUzFQZYY+CWml4gsOtNDVdcuQjDpvGqbQ
         BJBv8GoWxP2hX0JDB1M4c7axMl/ujLM8tMF24wJpyUv9LGvJep0IYdi/b34cfa1duCZW
         2tWp9+3kdQzbFV1ek3/7c5QgkNtMwAFnn3vfnJG/ia92EEPH79YtcflCpwyVHIQ2cXsT
         IkvA++yjnt7/1a0lD0rdmyXXuHCYm6H2FeHFqkzFa7wlWSI2QIe9A5oQKxqBgo9CaWfp
         SeaGw4KEneVgf7kmgu24fA+d2lfxcv7Qyr7GzkEC7iFPWp3vOBizjGDIjwQBmvKzr3H0
         x50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782241873; x=1782846673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oU+L9zQu/aklDl++k+2cg0xhcWLV/5t/SZwmgE+09o=;
        b=Cv/XCF1oxmc6zTugPDimd/ZIN6Uxz2tSIrAB/Afv5ALGdWkZ3GtPc+ByI0uTPzCNvg
         F4GocexNCkfQWJ12w3q4X/uDjXZW89n8NwqX0P9yXfDHZUeBK34n32MjgE1G+s44TGw6
         4YZrB4Z3i+Uvz3UMiHUL9E2tIqyXBlmQRymTx6n8VJvNlKR2El0m3zwi/m1svaOz3P5S
         JzdHMFrdISWZDt2uXjdh0hAtmc7UvOQuB+ZtXPylm3DpqpTfRYG/oO0BlF0uq5fUXu/U
         VuKt4RIl09Aao5LB+BI7UWs8RwihtihwtMMykwWY47wcUBu6VZ7X9vUfbzIh+mqoIsxB
         jQwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqWtT1bRyP5HEqJiclQuDBujdY+EgiDfmUvAGfa8uIcNHwvr6nXBmDlmfqF1/wHklv338k8QGPbIA46aBCRRYFysHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhwSBgTYDdQqaKipdeJfBiDVv+8eggpABy1uCAO3L+yyQKbOt
	sZutnDrRE5jJS1UC16Es8hifhQtmoKoMoVg+EQDEG2euSRiZbrjreguW
X-Gm-Gg: AfdE7ckyOA/7CSdmlk8ihzCLNIphqmnT60L3XlHtgFUAlexDyM9hMIrwEAAwXALhTE6
	yxLoQQsBnSUFFp81ofKq9se/27ocnZC71FMJRS3wF+zA5yeRy60N0UYdcJ3HPHjIyw+276x5ZE+
	roiFmS+SeOyGvzHW0AFgIbNfYsYRa7M4QiGcNDqCG7kUvvtn9kHSePpY8DVWABjNeDxlABeOwaI
	9gF/lmE0q7TYfaJz1ufnnzM0742hUpsEWa4xLzl2xt+1zRRFpWO8zyBWMY1iNkvjfWxcWnVa0vo
	XBVOutJcwiOC4dZhLaA6LGqi08TWPaDEC5BdGfe+5lfzMh3sjfHJpEgWzxtRp4PCVqq7uyugHDM
	bsV4Lieq9zoB+hcpms43Wg9bwpR+mMrLdj4jugV0NcMP8seiHHUHm3O224DESEXcdm6TRk2Wb9I
	J3
X-Received: by 2002:a05:6000:2209:b0:46a:8fab:ec6f with SMTP id ffacd0b85a97d-46c04a365damr367834f8f.4.1782241872756;
        Tue, 23 Jun 2026 12:11:12 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm39639063f8f.29.2026.06.23.12.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:11:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Jun 2026 21:11:11 +0200
To: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized
 uprobes
Message-ID: <ajraT7xBqcKa83fy@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <aiEiP54zktDqAZpG@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiEiP54zktDqAZpG@krava>

hi, ping, thanks

jirka


On Thu, Jun 04, 2026 at 08:59:11AM +0200, Jiri Olsa wrote:
> On Tue, May 26, 2026 at 10:58:27PM +0200, Jiri Olsa wrote:
> > hi,
> > Andrii reported an issue with optimized uprobes [1] that can clobber
> > redzone area with call instruction storing return address on stack
> > where user code may keep temporary data without adjusting rsp.
> > 
> > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > instruction, so we can squeeze another instruction to escape the
> > redzone area before doing the call.
> > 
> > Note we need upstream update first for patch 3 (github.com/libbpf/usdt),
> > if we decide to take this change.
> > 
> > thanks,
> > jirka
> > 
> > 
> > v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.org/
> > v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.org/
> > v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.org/
> > 
> > v4 changes:
> > - do not use 2nd int3 (ont +5 offset) because the call instruction
> >   is allways the same for the given nop10 address [Andrii/Peter]
> > - unmap unused trampoline vma after unsuccesfull optimization [sashiko]
> > - small change to patch#2 moved user_64bit_mode earlier in the path
> >   and pass/use mm_struct pointer directly from arch_uprobe_optimize
> >   instead of gettting current->mm
> >   Andrii, keeping your ack, please shout otherwise
> 
> hi,
> I think bots did not find anything substantial, I have just small
> selftests changes queued for v5
> 
> any other feedback/review would be great
> 
> thanks,
> jirka
> 
> 
> > 
> > v3 changes:
> > - use nop10 update suggested by Peter in [2]
> > - remove struct uprobe_trampoline object, use vma objects directly instead
> > - selftests fixes [sashiko]
> > - ack from Andrii
> > 
> > v2 changes:
> > - several selftest fixes [sashiko]
> > - consolidate is_lea_insn and is_call_insn insto single check [Jakub Sitnicki]
> > - use proper mm_struct object in __in_uprobe_trampoline check [sashiko]
> > - allow to copy uprobe trampolines vma objects on fork [sashiko]
> > - change uprobe syscall detection error from -ENXIO to -EPROTO [Andrii]
> > - added fork/clone tests
> > - I kept the selftest changes and nop5->nop10 changes in separate
> >   commits for easier review, we can squash them later if we want to keep
> >   bisect working properly
> > 
> > 
> > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programming.kicks-ass.net/#t
> > ---
> > Andrii Nakryiko (1):
> >       selftests/bpf: Add tests for uprobe nop10 red zone clobbering
> > 
> > Jiri Olsa (12):
> >       uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
> >       uprobes/x86: Remove struct uprobe_trampoline object
> >       uprobes/x86: Allow to copy uprobe trampolines on fork
> >       uprobes/x86: Unmap trampoline vma object in case it's unused
> >       uprobes/x86: Move optimized uprobe from nop5 to nop10
> >       libbpf: Change has_nop_combo to work on top of nop10
> >       libbpf: Detect uprobe syscall with new error
> >       selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
> >       selftests/bpf: Change uprobe syscall tests to use nop10
> >       selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
> >       selftests/bpf: Add reattach tests for uprobe syscall
> >       selftests/bpf: Add tests for forked/cloned optimized uprobes
> > 
> >  arch/x86/kernel/uprobes.c                               | 379 +++++++++++++++++++++++++++++++++++++++++++-----------------------------
> >  include/linux/uprobes.h                                 |   5 -
> >  kernel/events/uprobes.c                                 |  10 --
> >  kernel/fork.c                                           |   1 -
> >  tools/lib/bpf/features.c                                |   4 +-
> >  tools/lib/bpf/usdt.c                                    |  16 +--
> >  tools/testing/selftests/bpf/bench.c                     |  20 ++--
> >  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++----
> >  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++++++++--
> >  tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
> >  tools/testing/selftests/bpf/usdt.h                      |   2 +-
> >  tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
> >  14 files changed, 653 insertions(+), 245 deletions(-)
