Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B093CC300
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947624; cv=pass; b=fh8b2RKZilVRWRQ6bfTi+ckumS9koWE3Oz2IVXAzi+3NwrHMb9a0aSwhNhTurkYiOv7s4nPNJziqySqBO59OCH4jW05uOED57/tIAb7neMFrg+KpDEUajxM++86iHL3GtcKfg9t6El0XvgLJqFNeczCu+qia/+JzKc2lK7urG84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947624; c=relaxed/simple;
	bh=9kGV8CyVxLcaJZbg++5JPpVVoREAGtbzkfrX4BGDMs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDtlQMqHVI/Ve0UMTYC5GAs6rnGIptvlNLI9enhFvv1MajK0867ARmvxoeomOm7OW6V/eXuU452j0osMe3HJfxBsYuQZRs0cYGPdZM9k4w7a7FquQ/BSU9bRSpQuFpzgzVIhPTRZP87k4MGg/t0ii9YEz3i5uP57afn7RIt6HZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d229esoi; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d229esoi"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ca70925c25so12053515ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 16:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782947621; cv=none;
        d=google.com; s=arc-20260327;
        b=aStOn3z3uZceZ+G+/3+c7VZisjGoHERhXGaNhA5Ht+oU9iBzFW8JdSze5duSCKfqTB
         g/9AhRdzI5gVv+25Kpp0aln1q5qiPU/97BVPBD76oVrfOmiN2IytsQeCdBhN+KmynFJr
         6QAlbIPdKMHxZ541ojeAR/EFOO247lUvczpOfRPjKmE/CzxcslLAd05G3xuANxkl0iNS
         s4HF9Ij8d8XyAvT0yQjb6G6JC+uIUN3PmIFXA8aDVc3cerzC2yIOmBXxqrUIhOzXsHbm
         KIl8G3pakVaMD9Af2qhSOawU7wfiv1TWhx4JXtrZGZQeAffYe0v3MJTfMQKqIV+YwH1l
         2xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T+CX+/b54k/V7ua69NJvB7q7CM/ZsjpBZRYGMYkSc1w=;
        fh=qmCbpkJ1ZkQ2PptNIbPbjQ+cePuypvDLC8qQN8VdK3s=;
        b=O+9ZGqgn3R5a8oZyrz2a0s8V+zRdeZ26yl0s2VVZ8QFe2Z6RqPwkCtLLR3nplpAFlC
         xvfCPkpslT4jFzAxQ2QQVL/OUj/dat9JjNf6T4GkIuGh5GWbidQOtgyHr+mUbRXL2Fsp
         8QXuEgcM7fwMEu2LvlShGYkRimc04DAH7G35reg8QHVQwUIYoqkJL/znQfPseuU2TY4q
         yrS3tPFPXZOrfBsllRhZ7CU5EXv2AdXdyY9gaLZLHFvjfBIwWBivk3/Ulp2VdL4Wn68E
         2aOoFlQzPSlFYLY2RO8Xcb7Xr4lYJMwHRG+z0Xn7VN7DOhRr0d+NHBVI9gkicIjF0Ls9
         3tbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782947621; x=1783552421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+CX+/b54k/V7ua69NJvB7q7CM/ZsjpBZRYGMYkSc1w=;
        b=d229esoi/wFMKjLMEQHqeRULf/gp8+SP34idSxuyjw7TYFxhM9/kZOCOnXy71idh05
         TKMu/NeADahNP8uwVFtb049ewtzG/1orCjh+wVkocK3ahYeZoQjWVqN8DfnxdwHn01gQ
         8otqfGjzPkfq43ILVHL9D92voCxXBhveos2g4s+dYV8qnAbAOSyiVg2MxsKXRBhYXwZ5
         rqVHJPQwqtnDqQhyr0Ii7rX9zRAL/bGceW6t/ww8R8enwQVzy86Uydg6hjyAuEF+9Z0a
         i565gRa9jiUXHezTDXZhKQE7YXslCbcN+aNQQ4aZNj3sxo11W7lq4Zfwv/OJBUYWE0/N
         Iq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947621; x=1783552421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+CX+/b54k/V7ua69NJvB7q7CM/ZsjpBZRYGMYkSc1w=;
        b=pZTeTc99kGITssXE69tnTBm/U0syqlCJyxTaHQaDqLI9ciGCKNTRr0qfRPWBRFjV+U
         1xeJZzHvlSjQqa/asV11aPIgtZToOx7G3Rh/F0qcGyN8Y8eGqWBkgTGrb1HcnRB+a1tz
         LbJaOuQ6R5RVrLPw8ZO0jnVoadytRXUza3Zytv7GZU54l117mHGZu71LLTx83dtqqafM
         ztB57YJYWtB7dM6VtKh0gaL0rPlZhZycnR1T6rWsb3d4Eqk89yP9CO4qnAyXYYhE9Lrq
         5BPwpzVkmIAcD/JmQjMJ7KMTN3nGtxFg91L7MYCLusAmYF3SIFHdTKcoT7qQVRuO98Cf
         EehQ==
X-Forwarded-Encrypted: i=1; AHgh+RrW2JH8TLBQ6EisJZEkqs+X4RNGu7SVTF8wWaYzeyJidqxtxwRhG1HolPgalppGj2HyTLuhxXNIxCe6N/hmlvLA16E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvhYhR4W7tXIpcHSbpANj/HAo4+LLQoTMoltJrhCWPHd53/gL
	pfR2eQyXoFw54K2PNYbXqCyxxjURIOnQh4YCAJXmtuC1/4TZYFPSbv1qMLYxYAwXqdNXVnUFVfB
	MMgOg0Tr88JR6okhEYIDUv6m+xSgfyXQ=
X-Gm-Gg: AfdE7clAl1PYzNwMvd4zFp34sCV92p7F++L8nxIROqOMl4h5B6LUkOYp0wDXN0jljee
	HdjdvGQPEx102Z7v/Z6WXCq9J9E92epUJsjKDftIZ2RspnsqX00MTv+JsW7brn2cFH/U7V9w/aN
	uedRz1Pf7VWJ1KlHhxsr83MqYJ4MWXRasrn8Qx9hwIpJjdZNRFjjykzSAWCRxqP5EpRGjDj+m2q
	K+KZ/yPlRAFR+a+vY/ppQ3PxyJX+aKr8u7ckJ5W9U/E6+fnCbqQxHaxcRj1h3tPF9QKq3uRrWXy
	euHxb6qIiQm8TCjhAqpz8AlWaSmNiAHLa/qum9wJG/4T5fjYPqo+eTzbOJ0J8yHy
X-Received: by 2002:a17:903:2411:b0:2c1:98b7:ecf3 with SMTP id
 d9443c01a7336-2ca911de5d0mr26553335ad.23.1782947621169; Wed, 01 Jul 2026
 16:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701111337.53943-1-jolsa@kernel.org>
In-Reply-To: <20260701111337.53943-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 16:13:26 -0700
X-Gm-Features: AVVi8Ce49cRoGV8Wq1_JPig46tZ_iCuIR06d8w4lI2M5CCey7X7uBJJCKj25XyM
Message-ID: <CAEf4BzYiPeLTbgeVEDKqU45oHBFJgU6ULgK=3i1J7dbzKS2+yg@mail.gmail.com>
Subject: Re: [PATCHv5 00/13] uprobes/x86: Fix red zone issue for optimized uprobes
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 4:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
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
> v4: https://lore.kernel.org/bpf/20260526205840.173790-1-jolsa@kernel.org/
>
> v5 changes:
> - several selftests changes and reviewed-by tags [Jakub]
> - add more comments in int3_update_unoptimize [Andrii]
> - several other minor changes and acks [Oleg]
> - move insn_decode out of uprobe_init_insn to simplify the code
> - align uprobe_red_zone_test to 64 to make sure nop10 is not on page boun=
dary
>
> v4 changes:
> - do not use 2nd int3 (ont +5 offset) because the call instruction
>   is allways the same for the given nop10 address [Andrii/Peter]
> - unmap unused trampoline vma after unsuccesfull optimization [sashiko]
> - small change to patch#2 moved user_64bit_mode earlier in the path
>   and pass/use mm_struct pointer directly from arch_uprobe_optimize
>   instead of gettting current->mm
>   Andrii, keeping your ack, please shout otherwise
>
> v3 changes:
> - use nop10 update suggested by Peter in [2]
> - remove struct uprobe_trampoline object, use vma objects directly instea=
d
> - selftests fixes [sashiko]
> - ack from Andrii
>
> v2 changes:
> - several selftest fixes [sashiko]
> - consolidate is_lea_insn and is_call_insn insto single check [Jakub Sitn=
icki]
> - use proper mm_struct object in __in_uprobe_trampoline check [sashiko]
> - allow to copy uprobe trampolines vma objects on fork [sashiko]
> - change uprobe syscall detection error from -ENXIO to -EPROTO [Andrii]
> - added fork/clone tests
> - I kept the selftest changes and nop5->nop10 changes in separate
>   commits for easier review, we can squash them later if we want to keep
>   bisect working properly
>
>
> [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org=
/
> [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programmin=
g.kicks-ass.net/#t
> ---

ASAN-enabled test_progs runs are not happy in CI, can you please check?

> Andrii Nakryiko (1):
>       selftests/bpf: Add tests for uprobe nop10 red zone clobbering
>
> Jiri Olsa (12):
>       uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
>       uprobes/x86: Remove struct uprobe_trampoline object
>       uprobes/x86: Do not leak trampoline vma mapping on optimization fai=
lure
>       uprobes/x86: Allow to copy uprobe trampolines on fork
>       uprobes/x86: Move optimized uprobe from nop5 to nop10
>       libbpf: Change has_nop_combo to work on top of nop10
>       libbpf: Detect uprobe syscall with new error
>       selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
>       selftests/bpf: Change uprobe syscall tests to use nop10
>       selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
>       selftests/bpf: Add reattach tests for uprobe syscall
>       selftests/bpf: Add tests for forked/cloned optimized uprobes
>
>  arch/x86/kernel/uprobes.c                               | 416 ++++++++++=
+++++++++++++++++++++++++++++++++-----------------------------
>  include/linux/uprobes.h                                 |   5 -
>  kernel/events/uprobes.c                                 |  10 --
>  kernel/fork.c                                           |   1 -
>  tools/lib/bpf/features.c                                |   4 +-
>  tools/lib/bpf/usdt.c                                    |  16 +--
>  tools/testing/selftests/bpf/bench.c                     |  20 ++--
>  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 +++----
>  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 326 ++++++++++=
++++++++++++++++++++++++++++++++++++++++++----
>  tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++++++=
+--
>  tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
>  tools/testing/selftests/bpf/usdt.h                      |   2 +-
>  tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
>  14 files changed, 698 insertions(+), 256 deletions(-)
