Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646236;
	b=2O2hZNSkP+rwxxGEcPDlWiFRKKMQmJWstaD4WB7GtL2JvCAAqFc9Q0TcY6zXwfIeoo5y
	 8qFv3TNIN2/YqXJmM2e6kb71/K+uaK1QIonhowQEL6YmFWNHYwiE9yXdTHFntIFs7bt1v
	 gQ8eT7K3DlJJvUNkWY0xlEn0bs+lwoXuUfVMx2O8VAgJo7mqBhwKhzZLoZNAjlOOkkC4C
	 /S0ZgTUas2ulmqf6JS9h4s8xtkZ4sYx1+C0IIfTiSffK1tPBn3IfFenLja9bCZ1/drbHw
	 2GhJ1lG3/QezHJzmzSXkFi5K+DrnFOTL0AWAoCQdJt89j3qsIPPZai5vuMccEcLKI3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H/SXDgdhEaQ9Leps7ngp4tdnFYLEJykx5g1h92ea+nY=;
	b=R9tMH/EekUulLSBSy56VEBjle4/urnjjF3LIVurfhxxrYZFSExZsSjV5Icpr8K575jrm
	 k80GtDeGb68ajrzoYW2Jvq8UUAh1vEHDhclWWc8+9wPRss7+syu4hheulWxk5mr/FMOzP
	 fEadBgc0kNpTWfapT/cl5UV6wp7HSUSJj1s/G7XL9W98oKS1O4Zcbo75AfzKX8E6IKqNp
	 86xjawyjR/J31sj7PsldnwMy1VHHPiJaZxWs1OO/tGc+bdoc3XVN+efhA2n9R/Cn6ygaY
	 6gM4rVpuk+qXa722FhT0VXfSNDQgV5p9t87yW588FGCoEk/AsvE+O5EZb6xwyxNf7/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwoDzxWk;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC06606A31D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC06606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwoDzxWk
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso15951705e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646234; x=1793251034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/SXDgdhEaQ9Leps7ngp4tdnFYLEJykx5g1h92ea+nY=;
        b=PwoDzxWkA70Wmef14Vvpr9c4fHpU4ChmSg7Dc5eGutsiHbtTrYWNl05zc02Gtlv72r
         4Zq5Cp5q/leY/52RfvlkHWYrZVWtP80pZpjpJU07hEV0rT/E53N3KO4IWShg7/l5ZzfB
         poj2nHlLy8FnxKAmRNLKQsThjETb6zYQCRZnWh+D2hQsraNpceIfbDQoN1EdtuazyWtG
         Xz239Xqggu0HrKDQNYqGFznDgrbku+UIu/jVnKeOMCTNYn8ak5Bg9ETNi333RYgws0vD
         8vT7cU2/CuH54hAwzM/b+N0RwJToGTeuGLcM3zg4fHgXkQRw2e7ZuoNShYA6nVFSLNH8
         xmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646234; x=1793251034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/SXDgdhEaQ9Leps7ngp4tdnFYLEJykx5g1h92ea+nY=;
        b=eF36EbmUZFuoTjP/Z4X/8WZSG5EiSGwR4MxI3pgC6vWQoartjnP62aSw8+YYDbgXjb
         GPznlg7K/mRwBd7dD71pEkNWtCdRKIggJ/AlisgVZKlp6OE4k0OI0bVFccxePFQSsK5H
         ggxmARNSqL+s+PMh3LIjVw1o5pzMqymv/oLuOQYzZhiw6LVBRSW146OymlSsX/pZvXAY
         10/g+sFnqaV6oIu9WVVWL9y9z2gjRgOvZXZsQauvtq3pKtmpewXASqxbDl+rqDKpy3gG
         AFaf0hKYH91RSFeTgwBEeUCvsbmOVg99m3fgp/otyWcEimfg3k1nAaQgz60Qtzi/iDZt
         cgiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfSA/PnwkfvaWNpJWi1cCktqfEeAA3/UnmBRdOXphq63lHQ53/k3FC3d5hTY6pikCkEKmDjuIJg/a5ayOo8biqq8c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6STggNHpwclSu+ykRscjVt3bCPxn7s4+zX/hSnbhUvPhUGcDE
	+IusAuLyJhdMETkGP0wxaDTGrIfnRtfcNQUzqUEFiM59tD3RJne8By6q
X-Gm-Gg: AYBFou3BCxqar0dEWEDvYPgacYM/Y2R5PArE0AV9Vih4F5eXchb0OhGS6R4MWyA+ub5
	OkXXGoAEMNnUkzG7+pXM9f9Xs+y6UNgK8RdsAhHG5LUg+2s5uaLUXXyuy2SwisEEDnmdoxb3K8f
	NMWRGKVaaTV4y2tKofl6vWqH6jGZDAfXpoRtnvBS5Tqk3UGAF40zpPWrpZV+cdVtK8YmK0Vd4bZ
	ORngY4n/7iU3D6p2V/Zg+ahVV0C8WsMW2LlwaxzJhjtO9/VD2WUrsNau1/CqaEdWRHJ9rlF0fSm
	BPiMGcTcV4w9QR8Q9+tkTeJs+s6LcqI2o2Q3DrlEbXphF1b948xOb3ij+FmcNq8rW0kjD96S8rN
	YB60w11o5uaPqYuxmqg1cJWkE6EwpvN3urAK3fbd0Z34LaYdbz3KzfW8xptJhbdtPXKIKKczNKE
	KeLiPJcks9JMGiSa0LVtxgJUdaUUamyNw6SZka3ZogG5CWNY7r1nRBuYabt+oQLKXXZj94hvkLv
	Spgbrtae9X/uPj2Z+r2f/kDt8gQ4VJr6iBQNXyyWTh2HxCmt4Ao6v8f5X1jjgtpW5crMDMt91+F
	1oQxTj5WtNTCAl1cUFF5s7jvfytrEUh/VoUZnMp3C4M3710H6V4V1PsWSWfRzROTqRBJ2HPFJhL
	Dbl4EgzkujXRgrqUxqExiQTRTGDk2iuHlWMFTjiKLRfWtNXPoaBotLJFqBMo=
X-Received: by 2002:a05:600c:3513:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1fdd1e97emr87433205e9.31.1792646233938;
        Wed, 21 Oct 2026 22:17:13 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:12 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Subject: [RFC PATCH 00/12] entry, tracing: Classify early hardirq entry and return tails
Date: Thu, 22 Oct 2026 07:16:42 +0200
Message-Id: <20261022051654.79224-1-kmehltretter@gmail.com>
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

Tracing's transition recursion slot exists because a callback can run after
architectural hardirq entry but before generic entry increments
preempt_count(). Steve asked whether the count could be updated soon enough
to remove that slot. This RFC establishes that entry contract on arm64 and
closes a separate recursion window exposed by the same tests.

This is a design RFC, not a merge-ready proposal. I am looking for
feedback on the entry contract before extending it to other architectures
or removing TRACE_CTX_TRANSITION.

Clang can outline raw preempt-count updates and
__kern_my_cpu_offset() from noinstr entry code. This series applies to a
tree with the following two patches added:

  - Hongyan Xia, "arm64: Always inline raw preempt count updates"
    https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
  - Will Deacon, "arm64: percpu: Annotate __kern_my_cpu_offset() as
    '__always_inline'"
    https://lore.kernel.org/r/20260918161407.2300-12-will@kernel.org

Those patches are external prerequisites and are not included in this
RFC.

Patches 1 through 11 split raw preempt-count updates from generic IRQ
bookkeeping. On arm64, ordinary interrupts add HARDIRQ_OFFSET after the
pseudo-NMI decision but before instrumentable generic entry work. The
remaining accounting still happens in irq_enter_rcu().

The exit side has a similar gap. Function-graph and MTE callbacks can run
after the real hardirq state has been removed, and kernel return may
schedule before them. The series records ordinary-hardirq provenance and
restores a synthetic hardirq classification after the preemption decision.
That tail changes only preempt-count and lockdep state. It does not repeat
interrupt accounting, RCU, or tick entry.

Patch 12 keeps tracing's recursion state inside one preemption-disabled
interval. It closes the transition collision reproduced at the IRQ-exit
reschedule boundary. TRACE_CTX_TRANSITION remains unchanged because
unconverted architecture entry intervals can still run before
preempt_count() reflects hardirq context. An x86-64 no-transition control
still recorded recursion at system-vector entry and exit and in the
deferred hrtimer return tail.

The base includes "entry: Account the deferred hrtimer rearm as hardirq
context for lockdep" and "softirq: Preserve interrupt context on return
from interrupt".

The main questions are:

  - Should generic entry expose separate raw-update and bookkeeping phases?
  - Are preempt count and lockdep state sufficient for the return tail?
  - Is arm64 a suitable first user of this contract?
  - Should the recursion-lifetime fix travel with the entry conversion?

Karl Mehltretter (12):
  sched: Split preempt-count bookkeeping from raw updates
  lockdep: Use raw access for pinned hardirq state
  entry: Add the pre-counted ordinary-hardirq entry/exit contract
  entry: Skip inactive IRQ-return reschedule calls
  context_tracking: Split IRQ-exit preparation from the EQS transition
  lockdep: Prepare IRQ-on state from a hardirq return tail
  entry: Carry ordinary-hardirq provenance through kernel return
  entry: Classify ordinary hardirq return-tail work as hardirq context
  arm64: Use the pre-counted hardirq lifecycle
  docs: entry: Describe the pre-counted hardirq lifecycle
  locking/selftest: Exercise hardirq return-tail preparation
  tracing: Pin recursion state for its complete lifetime

 Documentation/core-api/entry.rst     |  75 ++++++++++--
 arch/arm64/include/asm/preempt.h     |   2 +-
 arch/arm64/kernel/entry-common.c     |  25 ++--
 include/linux/context_tracking_irq.h |  32 +++++-
 include/linux/hardirq.h              |  29 +++++
 include/linux/interrupt.h            |   2 +-
 include/linux/irq-entry-common.h     |  96 ++++++++++++++--
 include/linux/irqflags.h             |  14 ++-
 include/linux/preempt.h              |   9 ++
 include/linux/trace_recursion.h      |  14 ++-
 kernel/context_tracking.c            |  78 ++++++++++---
 kernel/entry/common.c                |  38 +++++-
 kernel/locking/lockdep.c             |  48 +++++---
 kernel/sched/core.c                  |  68 +++++++++--
 kernel/softirq.c                     | 166 +++++++++++++++++++++++----
 lib/locking-selftest.c               |  53 +++++++++
 16 files changed, 648 insertions(+), 101 deletions(-)


base-commit: 779ab5d73a22c798d1273b4aaf50cf5b8d750be9
prerequisite-patch-id: 9c009809614854fbff979d65aad6732757d006d5
prerequisite-patch-id: 764fd197db36a3889548bbc41890dd5b3d902f99
-- 
2.39.5 (Apple Git-154)

