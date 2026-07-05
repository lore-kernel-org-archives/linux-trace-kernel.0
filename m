Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A34189AD;
	Mon,  6 Jul 2026 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320217; cv=none; b=o47b8iBpJCRg2/OR0IEJgi23B8Uf1RHoadjMPBnZNo5vnzdfWMQPac3PdGpuV/wfDf935yw76JIH7LEO9i6o/LPnAnauM1KfDSCd/Q04i3FSctP4b9bqZmXU6NAKjipI6T5BYW5HXz7WTuhb0mBXHR8skkK5P+vTPp6mXxZBjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320217; c=relaxed/simple;
	bh=VAHi+PBb8b+++SWfPayXCtK/lkvsgLLw/50K5jGemuU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s68atg9c34pKyLJFZBiRfhqzjutlmZfagB8qZ3pZQLJsCCxaWGxAL7/RaRwyav1w11NTXOgJeDygzNYACzIc/yKMa9jgyrdOE3GBkOJwIIWbpiLLiXMT4hB8E2MqI8FX6WguyPOf5azlOepc/pSL/gWIcjxO5c6rUK6e90NAfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4gt7qs06Vwz7vTg;
	Sun, 05 Jul 2026 02:37:45 +0200 (CEST)
From: Eugene Mavick <m@mavick.dev>
Subject: [PATCH 0/4] tracing: add ref_trace_final_put tracing
Date: Sun, 05 Jul 2026 08:36:55 +0800
Message-Id: <20260705-refcount-final-put-trace-v1-0-a41d3fd0e869@mavick.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACenSWoC/4XNQQ7CIBAF0KsY1o4BpNS68h6mCwrUTlTaACWap
 neXVheudDPJn8y8P5FgPdpAjpuJeJswYO9yYNsN0Z1yFwtociacckklF+Btq/vRRWjRqRsMY4T
 olbYgqsaUep9noUh+H/IlPlb6XOfcYYi9f65NiS3bN1rSH2hiQKERh1JIo1jLy9NdJdTXnbFpK
 fkIxR9BG0MpE5JLVX0L9TzPL/+OceoDAQAA
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
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmey21X+6y6OWVye0/AZ5Y1L17lvI5JDn6cYiI1LfOFx
 8bJZV/+dJSwMIhxMciKKbLUZCW4Z6yclWh8dFIPzBxWJpAhDFycAjCRW8wMPw5uMYn9xxHwYqPo
 TuXFebp3d/1affJ1WNP+FVtdJnxflcnIcLtOlEHxU9W+3zW+PdN3zlDQKd7R1He6U14pRVPMu2Q
 ROwA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F

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

