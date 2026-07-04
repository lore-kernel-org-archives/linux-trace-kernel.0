Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181040B6DF;
	Mon,  6 Jul 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320462; cv=none; b=U9UVzW9puDybugxkq88t598vNOLKvmdkVRrVEQuGmtPH09ZOeF2syE6V5h2ebuEA23/O2vRQ7UxgwgyJYEwcBlPuwROCHMye4h1oEuhKYNVnPaHQgSEbE96rrij0DvpRo1AHG0Z2xaCCpGGjc0+ZfYLgKdocTfvSOdEoUbjUxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320462; c=relaxed/simple;
	bh=VAHi+PBb8b+++SWfPayXCtK/lkvsgLLw/50K5jGemuU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bYTpKv1yCoDQFuRUCMeFVZ9eYsMTUMuWjMV6jaU4b1BE5102aGIuoRbZAov78fE3LHFNJrbghq6L4SJ5bMOWieU1sgZVyAE9nTyIJBe2cioSYqsBOXiAKx5vLWIlCXGUXomUwXaVTlyt0WrQIS9uck/n8DHoJdPqy+yaBmtbG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4gt66635JfzMlcT;
	Sun, 05 Jul 2026 01:19:58 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Subject: [PATCH 0/4] tracing: add ref_trace_final_put tracing
Date: Sun, 05 Jul 2026 07:19:19 +0800
Message-Id: <20260705-refcount-final-put-trace-v1-0-cdd0014626a9@mavick.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPeUSWoC/32NQQ7CIBBFr9LM2jGAWLQr72G6oEDtRKUNUKJpe
 nex7t1M8n7+f7NAdIFchKZaILhMkUZfgO8qMIP2N4dkC4Ngoma1kBhcb8bZJ+zJ6wdOc8IUtHE
 oz51V5lDuUUOZT6VJr019bQsPFNMY3tunzL/pT6rYH2nmyLCTJyVrq3kv1OWpM5n73roM7bquH
 7W3lW7BAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625; i=m@mavick.dev;
 h=from:subject:message-id; bh=VAHi+PBb8b+++SWfPayXCtK/lkvsgLLw/50K5jGemuU=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmeU5l0mb+pzLrx2OpOQE3IPgYTWysVB97a7QY11zv3P
 f4Tt+hhRykLgxgXg6yYIktNVoJ7xspZicZHJ/XAzGFlAhnCwMUpABO5IszwP463Sk32nW2tdd5m
 jeV1e+SvdR/Udb74YjeLhZiPwt6wIEaGx5LTt+iK/fPfKZ4YUzlf621d/Pe5s3aULPpUEfA5Ro+
 JCQA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4gt66635JfzMlcT

When debugging use-after-free(UAF) bugs, knowing when the object reaches
0 references and enters final release can significantly aide the
debugging process.

There is currently no universal way to trace this information.

This patches traces the final puts in the most widely used refcounting
implementations, refcount_t(and thus kref which uses it), and
percpu-ref.

The tracepoint records three fields:
- caller: function that called the refcounting
  function(refcount_sub_and_test, percpu_ref_put_many)
- fn: refcounting function(eg refcount_sub_and_test)
- obj: refcount object(struct percpu_ref, refcount_t) 

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
Eugene Mavick (4):
      tracing: add ref_trace_final_put tracepoint
      refcount: add ref_trace_final_put tracepoint
      percpu-refcount: add ref_trace_final_put trace
      kunit: add test for ref_trace_final_put

 MAINTAINERS                      |   3 +
 include/linux/percpu-refcount.h  |   5 +-
 include/linux/ref_trace.h        |  26 ++++++++
 include/linux/refcount.h         |   2 +
 include/trace/events/ref_trace.h |  46 +++++++++++++
 lib/Kconfig                      |  10 +++
 lib/Makefile                     |   2 +
 lib/ref_trace.c                  |  12 ++++
 lib/tests/Makefile               |   1 +
 lib/tests/ref_trace_kunit.c      | 138 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 244 insertions(+), 1 deletion(-)
---
base-commit: df685633c3dbc67441cc86f1c3fee58de4652ba2
change-id: 20260624-refcount-final-put-trace-49bd7c39bd5a

Best regards,
-- 
Eugene Mavick <m@mavick.dev>

