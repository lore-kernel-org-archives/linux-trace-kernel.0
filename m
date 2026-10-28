Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158302;
	b=t53Jb8r/4owqyVQc8lrvVRgGawqx8bnzfmTgEm3pHfsZNkdTh959Idz91INEsl6m+JKJ
	 47BT46K4uQstjxClJ65BQaslTyvcXY4kTTYZVT89uZ21fboIIEGzZ+1wNBMPGFUPXhF0l
	 u+KgvxSLqIlFRbhYjaH7pINJWfOCUo37RF8QBONu8VTnTIhRppdexxztBWKryMkB/P12Y
	 nSxY3Ahy/keEiTJkvHZoV263i9isZSg+2gSexiHCKakzjUhYOdys8MOyHX9yJqRj1hdyH
	 qjH/KDH1Zkmqiq5XdBQYN+AYAipbtkkHpRm7YxhRWvxASmmc4q+Zg6ffGeYgboTdY5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pAM/k5pso5Rh97rJEUAxgzfJJtw2xRFXFv7FuWc2YG8=;
	b=cdkuZEp03IEsTfarNifwtW9qwrb5AjZcS6JSj42Av8w/0DnaDmxT2kEPhVarr10hrrdA
	 U8iEHdw9ASgy7va4RlmQsvlnHaV3OtDz2PKg3qzazwHXpaRmmkjhuwls7ewLO8HRRGM0B
	 n3BEuKB4kJ0jbLWojY49ZvMWvW4I3/E7gz1a/A1QdbVk5NLhq0kSwX6qC4P3HkkDkwByf
	 p1HQOGS8Cvgc6H2nA6oWleG9vDfH9OlhU7lAHy4TIPr7iVZB9xaQWMnZTW/wTR0d11L2i
	 B0CRHVzK2zjoIKzDepIrKlvSJqeAsuGOC1Quwqb6aSCE0UutJ9FmTWlP0aoglPMUj4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TKtjJ26A;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419D606A320
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3419D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TKtjJ26A
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso309124f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158300; x=1793763100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pAM/k5pso5Rh97rJEUAxgzfJJtw2xRFXFv7FuWc2YG8=;
        b=TKtjJ26AyrOIvKgM9gSHFzJVttQbAz7K1tgJp45DycwwDWK02uZU6yUuN5GwZynQ2B
         ae0frFGOWjd309EoPcVd5OgqfbszpyuiYp5YrQrQG70TRaTJmHZC2TK8Z/FbQ7nptU32
         EcuTWSVYgfBHwyhMfr6qwDHMO9yMpAGpb1USH8bRFoIFUhF8aFBuDidcxuuU7/D2JMJs
         DdlXYlVBr1mCxKadUP++/8uDXOaWn4yyxoWoC6coD6uBtOFgSUfCOIBlTZdnTJ/geT/7
         Uy4dBpgUnPpx7rU6540gzKpyiG+bcPgbcYfUqiL3thAuUeGv8n054uxHYrnTHF1BhVGU
         CbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158300; x=1793763100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAM/k5pso5Rh97rJEUAxgzfJJtw2xRFXFv7FuWc2YG8=;
        b=Gmau1WFGNwJ/Ssv+5ireZWMIr6pBALEN1m3XF1keDTrm/ZxscjJ1jg7BM1SxqomLz/
         fFv7EPqSMHdrs8W0dtqpyDo8LKuP2e9ka+OVjRRQ+gkvQ2AP31Q3xY86Ydt579fDRPmv
         8mm+/gbybL1qEANHGsXc8tiScOrWhjm6U9ozyu4kxpZSKVZvhxBHP1QDEUy+W3uSLj7g
         5Fp+1JDIg7SE9jEErMjwLVpB6/a0TmdYgSB0g5CDSAr2NhUbnEm73cqrre8FvBomAkoH
         vb45oolorAk9ZDASnwt12YAu6bbNF+5bxZc56990YrL+O5mKw8VKdcpTZB1Ujnk26MBp
         9Dng==
X-Forwarded-Encrypted: i=1; AKwUvBxzt8QNKCc1E9IIXG0vaCR0cCZOt+ePnSs2GlNclIGHxzGTN4ewThNVk+yUZkkSSsHv7CWgWcdo/nJNgXkTQD/PXv0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpCdCiwvQeCKmqh4qEz8I9GEzAP7RfRER0tMJfyJhTdlG05R1d
	k57Ms03q7ku4Uoi9myhq6J0DLd3b8NjTSToYa3/+Sy4PG7M+JjcjHXQq
X-Gm-Gg: AYBFou0oSKk7EIUrekCA7KZ9FfOIb8WbL3KcP6NVqnUovI/G6sGo0SvylfjaT+z9sxe
	X+/y+7mkgXCxKg+sMXasCUwem+zsF8awhq3oWYfO+BY/2e357X3xg5iOKjYr1tfgkCxvnhMWY69
	Ntr0oOnpq1ZrO53AXz3dGW4NybXlsRX4kPQ3IFUlg+Pp1XdVhrGyxRsevYR0ZTfc2TfT6WNHUl6
	H/4lm3/BQCmMMurPdH7biM8s3mVgNC9NZ4eQrO4pGc6kCQW+4vvaOmIPTIbLc+AKxK3yzn7QHu1
	Rnl+I1WEf/aW+FcDWDTSrhX52PV5vpJDO+3Q8ey4G6zIiFWQ/FBJD0ZU0bOyHiWYhOVC8el2pec
	L3ekRCV/uzWUJ8u1F9HYsdAY0fRx4xgfvvzR7ksvyfUDJP1MQFmsd7WJuG8Wt+2X9Yh7vjActUb
	EU9TwfOzJqPVyleXD3iFZeH9o/NF8y6q0aXq8voli9eajGhR8gLymI4s+21ywMFueVvy3fgWR0a
	tGZ7RxPIxHHdNahVhLigVlmNdJhaoNQkL+3hfMTFQNaYwhqNE6iHzbMyUc0OlwC1LWg2v7Xqjbe
	3iPzIC6RO57d9M8v0lMIGZFrRP5TJrkG93nHY/Z7Y75R0fytzM53SV80t1eW3kgflfHQ60eV5c6
	bQmImMu/XuPxOEhAbkDu9vhqVm0priMjJyMOz/rdYoefg0YpEKRuDK3jSJABs/MYNxAz6KquF+a
	w8RtQKKltOWymAseP6dLza56tTESmUesIdtXGBUv7/kBIc227yP5FvCg==
X-Received: by 2002:adf:e011:0:10b0:487:930:8acc with SMTP id ffacd0b85a97d-48e5d5c275bmr1961357f8f.16.1793158300262;
        Tue, 27 Oct 2026 20:31:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:39 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 00/13] entry: Classify very early hardirq entry and return-tail callbacks
Date: Wed, 28 Oct 2026 04:31:14 +0100
Message-Id: <20261028033127.82193-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracing still needs a transition recursion allowance because a callback can
run after architectural hardirq entry but before generic entry updates
preempt_count(). Steven asked whether HARDIRQ_OFFSET could be installed
early enough for those callbacks to observe hardirq context. This RFC
implements that contract for arm64.

arm64 must first distinguish ordinary interrupts from pseudo-NMIs. For an
ordinary interrupt, stage the raw preempt-count addition and establish
lockdep state immediately after that decision and before instrumentable
entry work. Keep time, tick, RCU and IRQ accounting at the existing generic
boundary. With DEBUG_PREEMPT and without separate reschedule bits, an
already-negative count preserves the legacy DEBUG_LOCKS_WARN_ON() oops short
circuit, attempts deferred reporting at the instrumentable finish, and skips
post-add bookkeeping and the matching subtraction when rejected.

The exit side has a second gap. Keep any applied hardirq count and lockdep
classification through traceable generic exit work, then remove them before
a possible schedule. Carry ordinary-hardirq provenance through that schedule
in a compact three-state byte, keeping irqentry_state_t two bytes wide, and
restore a classification-only tail around architecture tracing, deferred
hrtimer work, IRQ-on preparation and context-tracking preparation. The tail
does not repeat RCU, tick or IRQ accounting.

This is a design RFC, not a merge-ready proposal. The questions are:

  - Should generic entry expose separate raw-update and bookkeeping phases?
  - Are preempt-count and lockdep state sufficient for the return tail?
  - Is arm64 a suitable first user of this contract?

The series is based on d135ab453a74 ("Merge tag 'backlight-next-7.4' of
git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight"). Patches 1
and 2 include two arm64 noinstr inlining prerequisites so the series
applies directly to mainline:

  - "arm64: Always inline raw preempt count updates"
    provenance: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
  - "arm64: percpu: Annotate __kern_my_cpu_offset() as '__always_inline'"
    provenance: https://lore.kernel.org/r/20260918161407.2300-12-will@kernel.org

The first is the relevant hunk extracted from Hongyan Xia's larger posted
RFC. The second is a current-mainline rebase of Will Deacon's posted patch.
They preserve the authorship and links of the original submissions.

Repository: https://github.com/kmehltretter82/linux

  prerequisites: steve-early-hardirq-arm64-prereqs-v2-20261027
                 8bdce63fa17d
  generic core:  steve-early-hardirq-core-v2-folded-20261027
                 8651af55ecbc
  arm64 RFC:     steve-early-hardirq-arm64-rfc-v2-folded-20261027
                 56016d197e1b

The transition recursion slots remain unchanged. A separate
recursion-lifetime series keeps the task recursion bit inside one
preemption-disabled interval. A development-only patch removed the slots
for a matched experiment. Neither that removal nor the lifetime series is
part of this RFC.

All three kernels in the experiment contained this early-hardirq series.
On a native 16-vCPU Google Axion system, matched arm64 debug kernels
completed 100 deterministic ftrace callback and IPI overlaps per cell:

                                done  litmus  mixed  collisions
  Slots kept, lifetime fix   100/100       0      0           0
  Slots removed, no fix      100/100      33     60          13
  Slots removed, lifetime    100/100       0      0           0

The litmus and mixed columns count ftrace recursion records. The collisions
column counts transition-sensitive scheduler and return-tail records.
Complete dmesg captures were clean in all three cells.

The second cell is a counterexample to removing the slots without the
lifetime fix in the tested path. The third supports the combined design on
this machine. It does not establish every architecture-specific early-entry
interval, so this RFC retains the slots and keeps the lifetime work
separate.

Before this rebase, the patch-identical tree was validated across a
nine-cell cross-architecture W=1 full-link matrix: RISC-V 64, i386,
powerpc64le, arm64, x86-64 and ARM32 with GCC 13.3 and Clang/LLD 18.1.3. It
also passed 600-second arm64 SMP8 and RISC-V SMP14 stress gates, a RISC-V
AIA/IMSIC SMP1/SMP2/SMP8 gate under QEMU 11.1.50, and a focused four-row
DEBUG_PREEMPT staged-add oops oracle with 403 of 403 locking selftests.

An ARM64 PREEMPT_RT SMP4 build passed targeted return-tail tasklet and
forced-thread timer closure tests, three SMP2 priority-masked pseudo-NMI
return runs, and an SMP1 NO_HZ_IDLE and RCU_EQS_DEBUG return gate with 386
Startirq-to-Endirq intervals and 1,229 IRQ-disable/enable pairs. All
patches remain unchanged according to git range-diff after the rebase.

Changes since v1:

  - rebase onto d135ab453a74 and include the two arm64 noinstr inlining
    prerequisites as patches 1 and 2 so the series applies directly to
    mainline
  - keep the recursion-lifetime change in a separate series
  - carry a scoped hardirq-entry cookie across staged count updates so
    !HAS_SEPARATE_PREEMPT_RESCHED_BITS && DEBUG_PREEMPT configurations
    preserve the legacy DEBUG_LOCKS_WARN_ON() oops decision and skip
    post-add work and teardown when rejected
  - encode ordinary-hardirq provenance and staged-count application in a
    three-state byte so irqentry_state_t remains two bytes wide
  - fully initialize the arm64 EL1 debug entry state before provenance is
    added
  - retain irqentry_exit_pcpu_adjust() ordering across the return tail
  - accept and test nonzero nested lockdep hardirq depth in the tail
  - add a matched native test of the separate recursion-lifetime work and
  - tighten the contract and documentation wording

v1: https://lore.kernel.org/all/20261022051654.79224-1-kmehltretter@gmail.com/

Assisted-by: LLM

Hongyan Xia (1):
  arm64: Always inline raw preempt count updates

Karl Mehltretter (11):
  sched: Split preempt-count bookkeeping from raw updates
  lockdep: Use raw access for pinned hardirq state
  entry: Add the pre-counted ordinary-hardirq entry/exit contract
  entry: Skip inactive IRQ-return reschedule calls
  context_tracking: Split IRQ-exit preparation from the EQS transition
  lockdep: Prepare IRQ-on state from a hardirq return tail
  entry: Carry ordinary-hardirq provenance through kernel return
  entry: Classify ordinary hardirq return-tail work as hardirq context
  arm64: Use the pre-counted hardirq lifecycle
  Documentation: entry: Describe the pre-counted hardirq lifecycle
  locking/selftest: Exercise hardirq return-tail preparation

Will Deacon (1):
  arm64: percpu: Annotate __kern_my_cpu_offset() as '__always_inline'

 Documentation/core-api/entry.rst     |  89 +++++++++++--
 arch/arm64/include/asm/percpu.h      |   2 +-
 arch/arm64/include/asm/preempt.h     |   6 +-
 arch/arm64/kernel/entry-common.c     |  34 +++--
 include/linux/context_tracking_irq.h |  32 ++++-
 include/linux/hardirq.h              |  33 +++++
 include/linux/interrupt.h            |   2 +-
 include/linux/irq-entry-common.h     | 130 +++++++++++++++++--
 include/linux/irqentry_hardirq.h     |  81 ++++++++++++
 include/linux/irqflags.h             |  14 ++-
 kernel/context_tracking.c            |  78 +++++++++---
 kernel/entry/common.c                |  45 ++++++-
 kernel/locking/lockdep.c             |  49 +++++---
 kernel/sched/core.c                  | 101 +++++++++++++--
 kernel/softirq.c                     | 181 +++++++++++++++++++++++----
 lib/locking-selftest.c               |  53 ++++++++
 16 files changed, 828 insertions(+), 102 deletions(-)
 create mode 100644 include/linux/irqentry_hardirq.h


base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.39.5 (Apple Git-154)
