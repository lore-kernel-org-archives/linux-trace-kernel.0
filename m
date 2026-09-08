Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E6242D72;
	Tue,  8 Sep 2026 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830116; cv=none; b=A6BoeJyOAIzfkmlayRgeg16G9176HaAhYErExIXaijMNJnJ6wlvnE6uJaShbct+oxfoBkqYODLwkDKhJrtuDju+8EAprgc+gnlnjvtOunNMr7FZQcIugwkeCLveJ/x/R0zfadyu9gwmcjv1ga4iYpO2YcdfZnKnmKsIWsBkIHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830116; c=relaxed/simple;
	bh=Gy+k7+DDVj2xxByjkqg61Rqjwsbg3NNadUPvA+BHCIY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hAuLIVAwwzDakXGPQjbTaWfmOj0IEWGu8oOYWsDrUeiaJT7FdqD/9FLijfZXrfWQgRzVpI2ZJjy6uZ+4FzDzPYxWfGF+QCUEmpku+0GOFMnUFSWekM7Y7swGbeD0gOpWn/+QgfLIS6D05ZWHS8yYI1Nd3txJYZhYMV5R2QFR8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEaQehHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEaQehHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B808E1F00A3D;
	Tue,  8 Sep 2026 01:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830114;
	bh=w+7FkFBDFQ+GLRLPh0cC29VnEl1BgTg3LuZPeUb6jVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MEaQehHcRMDfmLnUO288XNQtOERtvLtcOA5001TTqZxYYzHhQmHwbVQhHqi+RHeqX
	 z+W9sTsDTMFYzI5KSploJbQ4cIBNqaCcu1sDaaTX0OfKyHVp4qQN5ZMGDZpK6imzvg
	 7l39l4bsNlEejohGCou0XvYtS+SUq/7U49xQqAOEr2QIYz5eE0bFjvT/ThZPDvnN56
	 yHPfvzPdlze6Cdbqswsmb67KWZpljya5H/Sr2ncvYa0MGkUBE4xMYjnHHNph7sTjLH
	 4hCECKNc+R4IBUSdKnwK09pM8xkcB9i0y40JuPbSJe9965dkQokpRupD8Dal/gOpCa
	 5TRFhBP66rCow==
Date: Tue, 8 Sep 2026 10:15:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pengfei Li <ljdlns1987@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel test robot <lkp@intel.com>, Bo Zhang <zhangbo56@xiaomi.com>, Pengfei
 Li <lipengfei28@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/3] trace: stack trace deduplication for ftrace
 ring buffer
Message-Id: <20260908101509.5ca094dacc96053236f7d2f3@kernel.org>
In-Reply-To: <20260903132409.270195-1-lipengfei28@xiaomi.com>
References: <20260903132409.270195-1-lipengfei28@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 21:24:06 +0800
Pengfei Li <ljdlns1987@gmail.com> wrote:

> Hi Steven, Masami, all,
> 
> This is v6 of the ftrace stackmap series, sent as a new thread.
> 
> Previous version:
>   https://lore.kernel.org/all/20260902064242.28606-1-lipengfei28@xiaomi.com/
> 
> The series adds stack trace deduplication to ftrace. When the
> 'stackmap' option is enabled alongside 'stacktrace', the ring buffer
> stores a 4-byte stack_id instead of a full kernel stack trace, and the
> full stacks are exported once via tracefs (stack_map / stack_map_bin).

Thanks for updating!

BTW, to make it easier for review, can you split the patches in
several parts? For example, start from a minimum basic functionality
(just internal stackmap, seq_read, and reset), use it from tracing,
add stat interface, binary interface, and documents, tools, selftests.
This makes the series in at least 7 patches, but nicer to focus on
one thing for each patch.

The patch description is a key area to focus on; if the explanation
proceeds by saying "add Foo, then add Bar, and so on," those changes
should likely be split into multiple patches.

Thanks,

> 
> The series is based on v7.2-rc4-102-g4539944e5151.
> 
> Motivation
> ==========
> 
> The target use case is long-duration, from-boot kernel tracing where
> the same stacks recur enormously often and the bottleneck is ring
> buffer space, not CPU.
> 
> Concretely, consider tracing the slab allocator from boot for hours to
> study memory aging and catch the allocation backtraces behind a usage
> peak. With a stacktrace trigger on slab tracepoints, every event today
> carries a full kernel stack (roughly 80-160 bytes). On a fixed-size
> ring buffer, the buffer wraps in seconds to minutes and the early-boot
> history is overwritten before it can be consumed.
> 
> For this workload the set of distinct stacks is small and highly
> repetitive. Storing a 4-byte stack_id per event and the full stack only
> once significantly increases the time span covered by the same ring
> buffer. The intended model is to trace for a long time and resolve
> stack_ids offline through stack_map or the included stack_map_bin
> parser.
> 
> This is complementary to the existing full-stack recording. Deep
> stacks, reset windows, map insertion failures, and the early pre-init
> window fall back to full stacks.
> 
> Effect on retention
> ===================
> 
> Same fixed per-CPU buffer, slab allocation workload with a shallow
> kernel stack (kmem_cache_alloc), stackmap OFF versus ON:
> 
>                   retained events   bytes/event   time span
>   stackmap OFF        645,068          ~104 B        15.0 s
>   stackmap ON       1,397,741           ~48 B        27.7 s
>                      2.17x             2.17x          1.85x
> 
> The benefit grows with stack depth and stack repetition.
> 
> Changes since v5
> ================
> 
>   - Correct all three commit messages to describe map-only reset:
>     reset works while tracing is active and does not clear the ring
>     buffer.
>   - Restore tracing_reset_all_cpus() to a private static helper and
>     remove its unused declaration.
>   - Add EXIT cleanup to the instance selftest and track instance
>     ownership so cleanup cannot remove a pre-existing instance.
>   - Reject truncated stack_map_bin entry headers and IP arrays in
>     stackmap_dump.py instead of silently returning partial output.
>   - Install stackmap_dump.py from the tools/tracing install target.
>   - Define stack_map as the required resolver/reset node and
>     stack_map_stat plus stack_map_bin as auxiliary observability nodes;
>     align selftest requirements with that distinction.
>   - Remove an unreachable basic-test branch around successes and drops.
>   - Keep success_rate present as 0% after reset and define precisely
>     what successes, drops, and success_rate count. Bypasses that never
>     call the map are not included in the rate.
>   - Reset the map at selftest entry and EXIT to avoid cross-test state;
>     declare od as a required program for the binary ABI test.
>   - Make ftrace_stackmap_reset() private and correct its tracefs
>     write-handler documentation.
>   - Clarify boot-time activation: deduplication starts only after the
>     map is created, the required stack_map resolver exists, and the map
>     is published to global_trace.stackmap. Events before publication
>     use full-stack fallback.
> 
> Reset semantics
> ===============
> 
> Reset clears the map and nothing else. It does not require tracing to
> be stopped and does not clear the ring buffer. A trace can therefore
> still contain <stack_id N> records after reset. Such an id either no
> longer resolves or, after slot reuse, resolves to an unrelated stack.
> That is misleading userspace output, not kernel memory corruption:
> reset frees nothing and only clears storage still owned by the map.
> Read the trace out before resetting if existing ids must stay
> meaningful.
> 
> Test results
> ============
> 
> Final v6 candidate b22d31e6e672, QEMU aarch64 virt:
> 
>   - Clean arm64 Image build: PASS
>     KERNELRELEASE=7.2.0-rc4-00105-gb22d31e6e672
>   - Function tracer stackmap suite: 20/20 PASS
>   - Function-graph stackmap suite: 4/4 PASS
>   - Boot-time activation suite: 3/3 PASS
>   - No BUG, WARNING, Oops, Call trace, or Kernel panic in these runs.
> 
> The immediately preceding code-identical candidate was also
> exercised with the full stability matrix before the final
> Documentation-only wording correction:
> 
>   - bits=14 concurrent stress for 30 minutes: 15/15 PASS
>     work=9,372,378, reset_ok=27,177, binary reads=449,497, errors=0
>   - bits=10 saturation for 20 minutes: 16/16 PASS
>     entries=1024/1024, successes=4,722,487, drops=56,842,925, errors=0
>   - bits=18, 3 GB guest, concurrent stress for 10 minutes: 15/15 PASS
>     work=2,719,022, reset_ok=5,501, binary reads=60,123, errors=0
> 
> The final candidate differs from that tested candidate only in the
> boot-time activation paragraph and its matching commit-message text;
> all kernel and tooling code is identical.
> 
> KASAN and lockdep were not enabled for these runs.
> 
> Local Sashiko review used sashiko 0.3.3, prompts revision
> 4e9a9051bc4237b6543cda194d2143080127671d, and the subjective-review
> prompt. The full three-patch review found only the boot-time wording
> issue above. A targeted review of the corrected final patch 3
> completed with no findings.
> 
> Known limitations
> =================
> 
>   - Per-instance stackmaps are not included. The option is gated to the
>     global trace instance in both tracefs and set_tracer_flag().
>   - Allocation is eager at fs_initcall when CONFIG_FTRACE_STACKMAP=y:
>     roughly 8 MB at the default bits=14 and roughly 130 MB at bits=18.
>   - Deduplication is best-effort. Under contention, two CPUs may insert
>     duplicate entries for the same stack and split ref_count between
>     them; memory remains bounded and each entry is self-consistent.
>   - Reset can make ids already present in the trace unresolvable or
>     misleading, as described above.
>   - stack_map_bin is a best-effort snapshot serialized against reset,
>     not a fully atomic export.
>   - Only kernel stacks are covered.
>   - trace-cmd/libtraceevent integration is left for follow-up.
> 
> Usage
> =====
> 
>   echo 1 > /sys/kernel/debug/tracing/options/stackmap
>   echo 1 > /sys/kernel/debug/tracing/options/stacktrace
> 
> Pengfei Li (3):
>   trace: add lock-free stackmap for stack trace deduplication
>   trace: integrate stackmap into ftrace stack recording path
>   trace: add documentation, selftest and tooling for stackmap
> 
>  Documentation/trace/ftrace-stackmap.rst       | 187 ++++
>  Documentation/trace/index.rst                 |   1 +
>  kernel/trace/Kconfig                          |  22 +
>  kernel/trace/Makefile                         |   1 +
>  kernel/trace/trace.c                          | 226 ++++-
>  kernel/trace/trace.h                          |  16 +
>  kernel/trace/trace_entries.h                  |  15 +
>  kernel/trace/trace_functions_graph.c          |   1 +
>  kernel/trace/trace_output.c                   |  23 +
>  kernel/trace/trace_selftest.c                 |   1 +
>  kernel/trace/trace_stackmap.c                 | 871 ++++++++++++++++++
>  kernel/trace/trace_stackmap.h                 |  55 ++
>  .../ftrace/test.d/ftrace/stackmap-basic.tc    | 101 ++
>  .../test.d/ftrace/stackmap-instance-gate.tc   |  67 ++
>  .../ftrace/test.d/ftrace/stackmap-reset.tc    |  84 ++
>  tools/tracing/Makefile                        |  13 +-
>  tools/tracing/stackmap_dump.py                | 164 ++++
>  17 files changed, 1843 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/trace/ftrace-stackmap.rst
>  create mode 100644 kernel/trace/trace_stackmap.c
>  create mode 100644 kernel/trace/trace_stackmap.h
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
>  create mode 100755 tools/tracing/stackmap_dump.py
> 
> 
> base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
