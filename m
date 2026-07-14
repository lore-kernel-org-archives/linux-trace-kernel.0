Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D913CFF62
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053384; cv=none; b=uBaf1s1hg0NMZ9lEmdEVjCiroOYXl3UuhsV8r/oL+/ZiqKSZ6UXRRj4l2+lk1shL8W8YEMa/pNtinSXRxoH/gdV5jV/3DOSau41fmrVOK8hVYfCDPZQR52rfW5t6LHFDMKWTFLSc0Mm6C9DCtXtf0MJ2edxop38ShpnC+5M7WUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053384; c=relaxed/simple;
	bh=90Q3wPqJq9vtC5fD3WzeJQSefMDjzwRVaR4osbPThfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXO0u0SbvIj+m6iFkiuqe/mXiwYOOtn6vA874UJXmSC/Ub7gb2wYtXKwEp5B/RqbSdpACN1UjAqJevt+DDyO5cevoswD2oeEEqkv4mxFXswEipSpipLUnFsePeNaPu4dLCLih0DLtIZ5AwxKBG28u8LXstmuEn45dxY8jjdX7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC2y09wC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC2y09wC"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5b048375so299611185a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053382; x=1784658182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnIZOQELkUux/iVcCPOwRBkQ6Ntjw2d8jEKYPylt2bg=;
        b=DC2y09wCUp7UCwNsfcsrQ43zI2YxxHVv9OudR4P549sBA3ba9mMJkz9oCaSdO1eSz2
         /cFQ8ZTBo+wpXOYSroiIwrj69u0Xi0QCmdeHv50zp91FC6Lmh5RrPsyvxd89RJ08Fgfn
         HhuH4Uo3ozmkkeeyzj+8C4scApLW3tHp9PkrqtmFWSH4SzokUAACDCsPH1DCga6HHPYT
         IQMrNhknacKPjxtMugz2PASZ2YbgyRBH8egzgZYfOTJVPmIIXyNSd9x9tgaH8IdRfNsr
         MtmoMLR3lzQsluRazsATmpbuU8Dk5uDvERoZcL+EFA/Bluqow0BjNekWiGhj40Ap5za7
         N50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053382; x=1784658182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnIZOQELkUux/iVcCPOwRBkQ6Ntjw2d8jEKYPylt2bg=;
        b=kfU2WP3E1pS9Tj8Ljsune04ZurcdIIpgvTlOLH37VEy5Z3txc4awpVokG4/OuZRGdl
         kAt+ulpZEXQcuf7Dje4X9PLDKfG0r86BU4jsWdETtG1AwNm/w1CiCrkpJfG/BWswyAYr
         EtWbjYv6/SwIBJEw/OVbNDqGZnzx9nr0YBXpjou+5zG6kloenIRWi/wg+GZa4/Wq7cx9
         8ONNtM0dhEf2S/X5SPYdn6GMUJjKDjmD7qPGw6pN045hHLU9dbM1u1yL3GeJqHGMOjla
         A/uIZwjIhGyplo7edfpum98l4zvXw7GU+OhDoMCg5pArNBeaT4Aaha8Q68z0/1aKtUtz
         godg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3rdPHQ5v6sE/xP49/2xdKFQly2ab4nScWBMUtOUc3uWduYpr9clPojNn9K9Drto1pCLJ9sZOIOfPKOtGMHMWyU0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNL4eIfw51vUUlP+WKxn1W5ugJ9nJmlKKnYk7//q8vSSXoWYZR
	N6Qj2RAfV744vb3+RtFJSHNgOdhEUYbWV2V9DOvEyGvfSACeTMzA2Vqd
X-Gm-Gg: AfdE7clvuSndZdYGaE7kOhZyh1c4R1yK283eTr4YGw01Gtf+OnJ6S2xiSX0arW7dSLB
	die9Ft18AYYNkdNT8KJ3GswjuaUijElQZDeTVtz0CtSqO6o7apdVq8boQMacihxAi3CtQ22MSVO
	7cXJQlGC7B0QnKj7d2TWsY4wV2WYYtF80h+upGqKlP/Ws5Khwdd7/ukj4aqcVAH/1C5GZErV0JX
	T52G88GVWUdT4//hX7l9Y+HLsu7hmzcfBIAMNc4Poc0KTUH8xA9hDRUCvQlr87PNsJS9y0ALazY
	h9gGbb7S2oL++ApTUr2ovz7N8RAIwAPFeYo1unKIvUKm8580PG3rdhcOBIX5K7bSYPy0Gdu220N
	vADh+hKnKjSDcfdOXiSzIK0QJSrJ+apLnTDD877OaENzQGNHFhSNoYIWxfXJZCtjApCSQDUWgKQ
	H6iCgW+jO76kkq/UNqBZr1+JZoJObASN5fxgpHwdQZapmrRkuk0xI=
X-Received: by 2002:a05:620a:288b:b0:92e:eeb6:b879 with SMTP id af79cd13be357-93086a8fbf5mr351375685a.41.1784053381649;
        Tue, 14 Jul 2026 11:23:01 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61facsm1539300585a.42.2026.07.14.11.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:23:01 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 00/13] mm/kwatch: dynamic hardware watchpoints for hunting memory corruption
Date: Wed, 15 Jul 2026 02:22:30 +0800
Message-ID: <20260714182243.10687-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motivation
==========

The hardest memory corruption bugs are the silent ones: a rogue writer
scribbles over a live object through a stale pointer or a race, and
the victim crashes in a code path far away from the culprit. Any
single developer hits such a bug rarely, but across the kernel's code
base and install base they keep arriving, and each one is
disproportionately expensive to localize. The existing tools report
the symptom, not the writer:

 - KASAN/KFENCE catch invalid accesses, but a targeted use-after-free
   or an in-bounds logical overwrite (a *valid* pointer written at the
   wrong time) never violates memory safety, so they stay silent - and
   KASAN's rebuild, overhead and redzones often perturb the bug away.
 - Hardware watchpoints via kgdb or perf can watch one fixed address,
   system-wide, for the whole run. But the interesting address is
   usually per-object and per-invocation ("field X of the object this
   function is currently operating on"), which cannot be expressed.

Design
======

KWatch implements two key mechanisms: a function-scoped watch window
that decides when the hardware breakpoint is armed and released, and
a flexible expression engine that resolves which address it guards.
A watch is configured through debugfs with a single line; hits are
reported through a tracepoint, carrying the writing instruction and
a stack trace.

The window: a kretprobe pair opens the watch at function entry and
closes it on return; inside, a per-CPU hardware breakpoint from a
preallocated pool is re-pointed at the target address. The pool is
managed locklessly, so a window can open in whatever context the
watched function runs in - real NMI excepted - and a hit can fire
and be handled in any context.

The window is also what makes the scarce hardware affordable: x86
has only four hardware breakpoint slots per CPU, and every corruption
happens within some execution context, so a breakpoint is armed only
while that context runs. The rest of the system runs at full speed and
only the watched function pays the kprobe cost, which keeps KWatch
usable on busy, highly concurrent systems. Global variables can also
be watched without a window, in a time-bounded anchor session.

The expression engine: at each entry it evaluates the configured
watch expression to resolve that invocation's target address. The
base can be a function argument, the stack pointer, a symbol or an
absolute address; offsets and pointer dereferences chain on top, so
heap fields reachable from an argument, globals and stack slots are
all expressible - no objdump session needed.

KWatch is also designed for painless deployment: it is fully
self-contained and can be built as a module, loaded only when a
corruption hunt needs it. It is just a debugfs entry until a watch
is configured, then just a kprobe on the watched function, with the
breakpoint armed only when needed.

A real case: dummy_hcd
======================

Gadget requests were completing through a clobbered req->complete.
Months of KASAN-enabled syzkaller runs produced only downstream
symptoms, with no lead on the root cause. Watching the victim field
with KWatch:

  func_name=usb_gadget_giveback_request watch_expr=arg2+56 \
  watch_len=8 access_type=0

caught the writer in the act:

  kwatch_hit: KWatch HIT: time=370.399836 ip=memcpy+0xc/0x30
              addr=0xffff888109cf5218
   => usb_ep_queue+0xf1/0x3c0
   => raw_process_ep_io+0x5e4/0xd80
   => raw_ioctl+0x251c/0x41c0
   => __se_sys_ioctl+0xfc/0x170
   => do_syscall_64+0x174/0x580
   => entry_SYSCALL_64_after_hwframe+0x77/0x7f

on the same request that crashed an instant later - the crash RIP was
the just-written garbage value. Root cause: dummy_queue()'s single
shared fifo_req is struct-copied over while dummy_timer() is
mid-giveback. Neither a use-after-free nor list corruption, so KASAN
and CONFIG_DEBUG_LIST are blind to it by design. A fix based on this
diagnosis is under review [1] - KWatch's part was pinpointing the
root cause: who clobbers the pointer, and from where.

Series layout
=============

Patches 1-4: a minimal "reinstall" operation for hw_breakpoint.
Re-pointing an already-installed breakpoint from a kprobe handler is
not possible with the current API (register/unregister may sleep and
rebalances constraints); reinstall lets the arch rewrite a slot it
already owns, and modify_wide_hw_breakpoint_local() exposes that for
the local CPU - cross-CPU propagation is the caller's job (KWatch
uses async IPIs). Patch 4 is Masami Hiramatsu's work, carried
unchanged.

Patches 5-11: KWatch itself, in mm/kwatch/ (patch 7 exports
stack_trace_save_regs() for the modular build).

Patches 12-13: KUnit tests and documentation.

Testing
=======

The dummy_hcd hunt above exercised the function-window path against
a live reproducer. Global watching, session auto-stop and the KUnit
parser suite were verified end to end under QEMU on x86_64. Both
KWATCH=y and KWATCH=m build.

arm64
=====

This RFC deliberately targets x86 only. On arm64 the watchpoint
exception fires before the access, so the arch must single-step over
hits, and today it only does that for the default overflow handler.
Rather than hardcoding a KWatch hook into arm64 core code, I plan a
follow-up that adds a generic way for in-kernel breakpoint consumers
to request stepping, and arm64 support on top of it (a prototype
exists).

Relationship to KStackWatch
===========================

KWatch grew out of KStackWatch [2], an earlier tool aimed at stack
corruption only, and has been substantially reworked since. The
hw_breakpoint prerequisites are carried over from that series.

Major changes since the KStackWatch v8 posting:

 - The watch expression engine widens the watchable range from the
   stack to any address expressible via function arguments, globals
   or stack addresses plus pointer dereference chains.
 - The task_struct and scheduler hooks are gone; KWatch is now fully
   self-contained, as described above.
 - A time-bounded anchor context was added for watching global
   variables (duration=N, auto-stop on expiry).
 - Hits are reported through a tracepoint carrying a stack trace
   instead of printk: safe in NMI-like contexts, and recoverable
   after a crash (ftrace_dump_on_oops, kdump, pstore).
 - Invocations in real NMI(-like) context are detected and rejected,
   with a visible nmi_rejected counter.
 - arm64 support and the auto-canary, profiling and test-module
   extras were dropped from this first posting to keep it reviewable.

Feedback on the design, the implementation or the usage is welcome;
if you are staring at a corruption that KASAN and friends cannot
attribute, give KWatch a try, or simply Cc me - I am glad to help.

[1] https://lore.kernel.org/all/20260714064829.172098-1-wangjinchao600@gmail.com/
[2] https://lore.kernel.org/all/20251110163634.3686676-1-wangjinchao600@gmail.com/

Jinchao Wang (12):
  arch: add HAVE_REINSTALL_HW_BREAKPOINT
  x86/hw_breakpoint: Unify breakpoint install/uninstall
  x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
  mm/kwatch: add watch expression parser and dereference engine
  mm/kwatch: add lockless per-task context pool
  stacktrace: export stack_trace_save_regs()
  mm/kwatch: add hardware breakpoint backend
  mm/kwatch: add probe lifecycle runtime
  mm/kwatch: add anchor thread for global watchpoints
  mm/kwatch: add debugfs control plane
  mm/kwatch: add KUnit tests for the watch expression parser
  Documentation/dev-tools: document KWatch

Masami Hiramatsu (Google) (1):
  HWBP: Add modify_wide_hw_breakpoint_local() API

 Documentation/dev-tools/index.rst    |   1 +
 Documentation/dev-tools/kwatch.rst   | 193 +++++++++++++++
 MAINTAINERS                          |   8 +
 arch/Kconfig                         |  10 +
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/hw_breakpoint.h |   8 +
 arch/x86/kernel/hw_breakpoint.c      | 151 ++++++-----
 include/linux/hw_breakpoint.h        |   6 +
 include/trace/events/kwatch.h        |  57 +++++
 kernel/events/hw_breakpoint.c        |  37 +++
 kernel/stacktrace.c                  |   2 +
 mm/Kconfig                           |   1 +
 mm/Makefile                          |   1 +
 mm/kwatch/.kunitconfig               |   9 +
 mm/kwatch/Kconfig                    |  27 ++
 mm/kwatch/Makefile                   |   4 +
 mm/kwatch/anchor.c                   |  82 ++++++
 mm/kwatch/core.c                     | 325 ++++++++++++++++++++++++
 mm/kwatch/deref.c                    | 174 +++++++++++++
 mm/kwatch/deref_test.c               | 137 ++++++++++
 mm/kwatch/hwbp.c                     | 358 +++++++++++++++++++++++++++
 mm/kwatch/kwatch.h                   | 107 ++++++++
 mm/kwatch/probe.c                    | 263 ++++++++++++++++++++
 mm/kwatch/task_ctx.c                 | 105 ++++++++
 24 files changed, 2005 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/dev-tools/kwatch.rst
 create mode 100644 include/trace/events/kwatch.h
 create mode 100644 mm/kwatch/.kunitconfig
 create mode 100644 mm/kwatch/Kconfig
 create mode 100644 mm/kwatch/Makefile
 create mode 100644 mm/kwatch/anchor.c
 create mode 100644 mm/kwatch/core.c
 create mode 100644 mm/kwatch/deref.c
 create mode 100644 mm/kwatch/deref_test.c
 create mode 100644 mm/kwatch/hwbp.c
 create mode 100644 mm/kwatch/kwatch.h
 create mode 100644 mm/kwatch/probe.c
 create mode 100644 mm/kwatch/task_ctx.c

-- 
2.53.0

