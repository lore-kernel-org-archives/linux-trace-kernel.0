Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7633E37A;
	Thu, 13 Aug 2026 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593021; cv=none; b=sPujJ5yDWuLM7/IFa8EuJGDXuidVTorhXB6ngo9fNR1NybbfZoMb08OjYW+q3BYblPfMI8PBEmAhdpSsfImglEoDvuH2PnVoJJckWlFUwIKYen90qbSKQ7C653SxXK2pblR26N9BNf+z44XRX0sT7m8VM+b+CrUYDS5gZN467Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593021; c=relaxed/simple;
	bh=Ns/xH6GcCBmS1i+tcQhV2JbxQS4nqkIivlI8t64dovo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lPU2e0aEbULE3yQRNLfywasayP2gZl4WReHl3sUYOyJrI4RaFZ8Il8ov52c3wzu2HFnvw7LpbjvsmGr4wxjT29QmSlnvVR6sMIJB+j4DwYnCji8UEUQuc4aex6gxg3hQuWOnihO4SRPXSKB9Be1kHyZmUz9EumBdCDcwUfMXCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=T6xoeJin; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="T6xoeJin"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hLBFy2hGgzMlMX;
	Thu, 13 Aug 2026 05:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1786593014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BcFrn3fh6XowM0CfCDLPqJ3XCi/Ke60FiRueM8hTud4=;
	b=T6xoeJinvOqEL/fGUMLk4gZ5L2Y6BKn7KsQ+6g8Xdi924M7WLIBvTlv9tj1Y+qCEpzKuR5
	O3OWoHeNLAoP5U2aSRkl+wV3199W9B/sSsIKVa/3YH7XmoBfHtZu6aKX/1dBmbzgwaWa4I
	TH1yftRwSq+qw9UiNjlmgy2/j4kJAt2AINzX1oxAZqmsNriC34cqfIkOi2YDhhZTuq93F/
	k4k0vi1DEfdDDznl8XVabs3bnJUq+AvXM2jVfMaZEsTtyK4KhvK+7ctdJdwBc6C7doQzHM
	lOoSiyoRGtlV4MyqjqQO7wAXAXPAHuPJOalvxYatWYVD7HXbHN0i5G+Th8I22A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Subject: [PATCH v5 0/5] tracing: add refcount_final_put tracing
Date: Thu, 13 Aug 2026 11:49:06 +0800
Message-Id: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALI+fWoC/53QzWrDMAwH8FcpPs9D/nZ62nuMHRxLXs22pDip2
 Sh59zndYB2DDHoR/IX0E+jMJiqZJrbfnVmhmqc8Di2Yux2LhzA8E8/YMpMgLVipeaEUx9Mw85S
 H8MqPp5nPJUTiuuvRRdWqCaytH9tkfr/Qj08tH/I0j+XjcqmKtfuFOthAq+DAe+2dthhEku7hL
 dQcX+6R6nrkWzD/CBERQGgrbehuE4IWqBICeXujAIE6ZQl7Z+BaWH9T1dU/hNiQVJOs09EnUNi
 l7o+kfyQPW5JukiTjrWtWSvhLWpblExWAr5obAgAA
X-Change-ID: 20260624-refcount-final-put-trace-49bd7c39bd5a
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, kasan-dev@googlegroups.com, 
 Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4929; i=m@mavick.dev;
 h=from:subject:message-id; bh=Ns/xH6GcCBmS1i+tcQhV2JbxQS4nqkIivlI8t64dovo=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFm1dgfFDP+9OHUi1U3cYVNreeq8vFypKwuS/NbvOne6m
 svhpdr/jlIWBjEuBlkxRZaarAT3jJWzEo2PTuqBmcPKBDKEgYtTACZSdZuR4SnD3kvXXkpc5lds
 fvDnUTX/XKV9ZfMSd33jXS5pa+8Rbc7wP5hz8rvFewoLeA/ePNV6W9MtccvjBrbZm96/rb3d+oi
 NjR8A
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4hLBFy2hGgzMlMX

When debugging use-after-free(UAF) bugs, knowing when the object reaches
0 references and enters final release(final put) can significantly aid the
debugging process.

This patch series adds a tracepoint, refcount_final_put, with
compilation toggleable with CONFIG_REFCOUNT_TRACE_FINAL_PUT.

refcount_final_put fires when a reference
count reaches zero and the object enters its final release path.

refcount_final_put records three fields:
- caller: function that called the refcounting
  function(refcount_sub_and_test, percpu_ref_put_many)
- ip: return address of trace wrapper macro call
- obj: refcount object(struct percpu_ref, refcount_t)

bloat-o-meter stats:

CONFIG_REFCOUNT_TRACE_FINAL_PUT=n :
Total: Before=24703933, After=24703933, chg +0.00%

CONFIG_REFCOUNT_TRACE_FINAL_PUT=y :
Total: Before=24703933, After=24764816, chg +0.25%

Alternatives to obtain this information require live reproduction, and
incur a significant performance cost, making them impractical to have
enabled on fuzzers like syzbot.

refcount functions performing final-puts are also inlined, further
complicating alternative dynamic tracing possibilities.

Debugging UAFs without final-put knowledge is possible but is often
significantly harder and requires broad code reading and mapping,
whereas knowing the final-put allows narrowing the scope, thus
decreasing time and effort required.

Local live reproduction and alternative tracing are time, hardware
resource, and manual effort exhaustive. Time-sensitive UAFs which
require many iterations to reproduce further worsen these requirements.

Remote-fuzzer report based UAF debugging is an incredibly frequent
occurence.

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
Changes in v5:
-rename ref_trace to refcount
-add CONFIG_REFCOUNT_TRACE_FINAL_PUT Kconfig option, due to high footprint
-improve cover letter, add bloat-o-meter statistics
v4: https://lore.kernel.org/r/20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev

Changes in v4:
ref-trace:
-remove fn
-add ip variable
-change trace wrapper macro respectively, _THIS_IP_ is used for ip variable
-change relevant code respect to fn removal and ip addition
-fix style issues in include/linux/ref_trace.h
-add new macro do_trace_ref_final_put_cond that only calls tracepoint if cond is
 true
lib/refcount.c:
-change from do_trace_ref_final_put to *_cond
-remove if statement above since _cond already performs the check
KUnit:
-change relevant code respect to fn removal and ip addition
-check if caller and ip are valid addresses
-change timeout from 10 jiffies to 10 seconds
-move didn't timeout assertion from before to after probe
 unregistration, to prevent it from impacting next test

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

Changes in v2:
-include/linux/ref_trace.h: change macro name, use direct tracepoint
 call in macro to avoid double check
-add tracepoint to refcount_dec_if_one
-kunit: make significant improvements to design, fix critical bug, add test case for
 refcount_dec_if_one()
-Link to v1: https://lore.kernel.org/r/20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev

---
Eugene Mavick (5):
      tracing: add refcount_final_put tracepoint
      refcount: add refcount_final_put tracepoint
      percpu-refcount: add refcount_final_put tracepoint
      kunit: add test for refcount_final_put
      MAINTAINERS: add entries for refcount_final_put trace

 MAINTAINERS                      |   3 +
 include/linux/percpu-refcount.h  |   5 +-
 include/linux/refcount.h         |   2 +
 include/linux/refcount_trace.h   |  33 +++++++++
 include/trace/events/refcount.h  |  55 +++++++++++++++
 lib/Kconfig                      |  18 +++++
 lib/Makefile                     |   2 +
 lib/refcount.c                   |   6 +-
 lib/refcount_trace.c             |  14 ++++
 lib/tests/Makefile               |   1 +
 lib/tests/refcount_trace_kunit.c | 141 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 278 insertions(+), 2 deletions(-)
---
base-commit: df685633c3dbc67441cc86f1c3fee58de4652ba2
change-id: 20260624-refcount-final-put-trace-49bd7c39bd5a

Best regards,
-- 
Eugene Mavick <m@mavick.dev>

