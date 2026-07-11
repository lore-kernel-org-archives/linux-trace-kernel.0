Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6E2AD35;
	Sat, 11 Jul 2026 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783744867; cv=none; b=fCUoT3FiOT/u0X2U+iSbnVZ1cCGnAvzVdFtKDh69B/FvDgtnXJ3lP2fMTR1pHozjiTAV1SXVd2BUcsEvtFYqJ22TSfgPqHlPg3i06ztpqqewE9aP0tw7FXfzSaX1QBCYiT+I6PGRa95pmw76Dle5foNctXXUwwztzB94DDgM15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783744867; c=relaxed/simple;
	bh=8irLUPm5Lq6cNJ89PXbBgzxwq7P/2J537PB1GhrlIzU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MyNo+Pka27uYgtgKo86ax96wf4st49yafCLuj859jTM7tZtkF3ky9nrgv8gzos5EcUCTl4zGpfrJuiv1IUrSjgZ7qskFCYcMPdfFO3naRBUUJazADJYQlEZsyGnyDCY9wf7HJi5/epxF4ghnHt0TZhVlX0FXoSVogw6Caaiwxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=Dw+VcXvF; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="Dw+VcXvF"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gxwxl1MHpz8txV;
	Sat, 11 Jul 2026 06:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1783744859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J8SZk0InEttprJDG8mhzTigtAJH/J1bkTIxhCwzTmU0=;
	b=Dw+VcXvFWtGuNenkEtsfTh3g1xjYxDSW8O4jev99FvCELwD+/GBbx9VgCmf4WpHT+L+aWs
	PLOnwO3KPedWAcZXiO+BqCEjGQW8xPoxO/kWxbmihXP4JybM/TbvMxpNbXLLNRe2OxWEzw
	I6WXqNnJsv5XqqETMXRAFySvrysPDY+4foU6YCmHIjTXE+Ec6qZti3oR54F13rDSNrl5WK
	min9LNdMxJCLDS2V/xlfTfgZJKl7N50VvxF2G+0V9Jr/jwc4X04dNW2veFOginm7o9FjSL
	nTuYQDME14Z4Ihd1Csc4p/xEuInLCOPLJM/qDaDyyQsdcwARA78Un92YPtM+gw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Subject: [PATCH v3 0/5] tracing: add ref_trace_final_put tracing
Date: Sat, 11 Jul 2026 12:40:18 +0800
Message-Id: <20260711-refcount-final-put-trace-v3-0-674c8f03d9f9@mavick.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLJUWoC/53NPQ7CMAwF4KugzAQ5aZpQJu6BGNzYhQhoq7REI
 NS7E34GJpBYLD3L/t5NDBwDD2I1u4nIKQyha3Mo5jPh99juWAbKWWjQFqw2MnLju3M7yia0eJT
 9eZRjRM/SVDU5X+RZosjvfb4Mlye92ea8D8PYxeuzKanH9oU6+IImJUHWZumMJVSNdusTpuAPC
 +L0KHkL5Q/BEwEoY7XF6j8BjaKiIeCl/VMA5KqwTLUr4VPYTtN0B/0hmgKHAQAA
X-Change-ID: 20260624-refcount-final-put-trace-49bd7c39bd5a
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2848; i=m@mavick.dev;
 h=from:subject:message-id; bh=8irLUPm5Lq6cNJ89PXbBgzxwq7P/2J537PB1GhrlIzU=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmBJ217dtxMUysV1Tb6q6Ods0+w3ecF94YlCec+MXw5v
 mDLp86YjlIWBjEuBlkxRZaarAT3jJWzEo2PTuqBmcPKBDKEgYtTACbCpc3IcHyTcf3D9JjWzj4D
 Fr6HS1bYnD/l3fDDUvZQw8HWy19YVzL8z9thax6oPX1p0d3+fAv1Da8PqB6Mvum/xktcOthJWqC
 ZAQA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4gxwxl1MHpz8txV

When debugging use-after-free(UAF) bugs, knowing when the object reaches
0 references and enters final release can significantly aid the
debugging process.

There is currently no universal way to trace this information.

This patch series implements tracing of the final puts in the
most widely used refcounting implementations,
refcount_t(and thus kref which uses it), and percpu-ref.

The tracepoint records three fields:
- caller: function that called the refcounting
  function(refcount_sub_and_test, percpu_ref_put_many)
- fn: refcounting function(eg refcount_sub_and_test)
- obj: refcount object(struct percpu_ref, refcount_t)

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
Changes in v2:
-include/linux/ref_trace.h: change macro name, use direct tracepoint
 call in macro to avoid double check
-add tracepoint to refcount_dec_if_one
-kunit: make significant improvements to design, fix critical bug, add test case for
 refcount_dec_if_one()
-Link to v1: https://lore.kernel.org/r/20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev

Changes in v3:
include/trace/events/ref_trace.h kernel doc comments:
-caller of refcount function -> return address of refcount function
-ref_trace_final_put->do_ref_trace_final_put
lib/ref_trace.c: add include trace/events/ref_trace.h
kunit:
-change Kconfig depends from FTRACE->TRACEPOINTS
-EXPECT_FALSE->ASSERT_FALSE for calling percpu_ref_init
-add tracepoint_synchronise_unregister to test_exit macro
-added timeout to capture.count waiting
-remove noinline and __always_inline from function attributes
 (added for testing, but accidentally submitted)
-add period to the end of Kconfig help text
v2 link:
https://lore.kernel.org/all/20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev/

---
Eugene Mavick (5):
      tracing: add ref_trace_final_put tracepoint
      refcount: add ref_trace_final_put tracepoint
      percpu-refcount: add ref_trace_final_put trace
      kunit: add test for ref_trace_final_put
      MAINTAINERS: add entries for ref_trace_final_put

 MAINTAINERS                      |   3 +
 include/linux/percpu-refcount.h  |   5 +-
 include/linux/ref_trace.h        |  26 ++++++++
 include/linux/refcount.h         |   2 +
 include/trace/events/ref_trace.h |  46 +++++++++++++
 lib/Kconfig                      |  10 +++
 lib/Makefile                     |   2 +
 lib/ref_trace.c                  |  13 ++++
 lib/refcount.c                   |   8 ++-
 lib/tests/Makefile               |   1 +
 lib/tests/ref_trace_kunit.c      | 141 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 255 insertions(+), 2 deletions(-)
---
base-commit: df685633c3dbc67441cc86f1c3fee58de4652ba2
change-id: 20260624-refcount-final-put-trace-49bd7c39bd5a

Best regards,
-- 
Eugene Mavick <m@mavick.dev>

