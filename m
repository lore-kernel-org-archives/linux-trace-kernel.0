Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406231E830;
	Sat,  1 Aug 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582063; cv=none; b=c6XYHUBwufJ4YqPAXKmMA5iGwKKCmWsfomepo5w7OlgylaLSuExv+PDQUVa2U640fmCJWedY8q1X5dSfOMs8rqPk+TzT0azljxjkfjthD7b0qxwR34IJ4v+bGy3aC2CT1tSiyl3w08V6Z5oEakfaw61ovz2LWyCLQVUaCyKFvEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582063; c=relaxed/simple;
	bh=6SxDI3lnGUVOqQynlBB5KrL+oi0ZqISwEqlbLLcv/7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBRgd7BrS8AOY2AsJxHnUbbz8dBPYPPiBERp5GfgBTpJiZXgUoc7E918UmKe9aJVQbslEM1otLiKz/oEzVjB1lT1zNNdjoELnjqZM5DabDBTQBsvUdHqveHYpUK2/pFewhXQBOzuF0Z/DpJxg1YfVtkqWEJt3/2PwLCQrXKN6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=b7oXTNTj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="b7oXTNTj"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hC0NM5NPrz8twy;
	Sat, 01 Aug 2026 13:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1785582051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C912dpGQcVcNQokG8z6F9kwSDBoO6n2Gknkhy/XwQHc=;
	b=b7oXTNTjj2ZCjCrjXH+4onJXBZ6okt7C6WdM+iEtplUoOlZh0An8Gt1LjzqSL5V97xIZT4
	h7Vkq7kXdpBxiePE+e1Oo7O+4aCj4HDTlio+MwKv31V7yZetw03K+6hRotzC1IvPSipcyp
	aO9aKbTG+FscVo4yCU020JW1nEY2VAIATiXBYprDl99x7J7KBELWSUFVGyI5wVOidvM3PI
	ocmxALYuXyiTEcxHaHyxI8wnw5Cc0RQmfx+zteGZobHxeiPopl8XeWsM+Ff54vL8pYq42i
	CXcKgsPMj9LdyKM6HtN1KmZOGa2Wj7TMU2F6OlBg3h7eEY2e2WkTFlT0uUwVwA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 01 Aug 2026 18:59:42 +0800
Subject: [PATCH v4 2/5] refcount: add ref_trace_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-refcount-final-put-trace-v4-2-2e58678f0ffd@mavick.dev>
References: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
In-Reply-To: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=m@mavick.dev;
 h=from:subject:message-id; bh=6SxDI3lnGUVOqQynlBB5KrL+oi0ZqISwEqlbLLcv/7A=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFm5FzdeTp94SLNX3H9W4vWzJQy1ntvEAl8fNlzxQov11
 zxpDbnFHaUsDGJcDLJiiiw1WQnuGStnJRofndQDM4eVCWQIAxenAEzkvyfDP+vKxR8r+V5M/+XX
 EisVfOAMe7m22o3lgjd7ilweRTKZWDAyrBTY4lr+ubyZp1b30KMN1yo+a/4Rmctz5tetDbpGEa1
 8HAA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4hC0NM5NPrz8twy

Add the ref_trace_final_put tracepoint to __refcount_sub_and_test() and
refcount_dec_if_one()

This tracepoint fires when a refcount_t reaches zero, capturing the
caller
address, trace wrapper macro call address, and the refcount_t address.

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/refcount.h | 2 ++
 lib/refcount.c           | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index ba7657ced281..70d07a462da1 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -107,6 +107,7 @@
 #include <linux/limits.h>
 #include <linux/refcount_types.h>
 #include <linux/spinlock_types.h>
+#include <linux/ref_trace.h>
 
 struct mutex;
 
@@ -393,6 +394,7 @@ bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
 
 	if (old > 0 && old == i) {
 		smp_acquire__after_ctrl_dep();
+		do_trace_ref_final_put(r);
 		return true;
 	}
 
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..ab88d4674942 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -7,6 +7,7 @@
 #include <linux/refcount.h>
 #include <linux/spinlock.h>
 #include <linux/bug.h>
+#include <linux/ref_trace.h>
 
 #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
 
@@ -56,7 +57,10 @@ bool refcount_dec_if_one(refcount_t *r)
 {
 	int val = 1;
 
-	return atomic_try_cmpxchg_release(&r->refs, &val, 0);
+	bool ret = atomic_try_cmpxchg_release(&r->refs, &val, 0);
+
+	do_trace_ref_final_put_cond(ret, r);
+	return ret;
 }
 EXPORT_SYMBOL(refcount_dec_if_one);
 

-- 
2.51.2

