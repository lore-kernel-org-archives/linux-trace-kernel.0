Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3728F949;
	Sat, 11 Jul 2026 04:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783744884; cv=none; b=MKcqQp+m+xYsefrcY1tXEdRkxAPrXKjtxDbcOM//uGQHoi6sOhKEtGlAGcTuCUeJPtPlf6dcMgVA0q8JPUH3jj/Pn5yNB5RuWpymjDM+GPP10+WzEic5pH4HFjTR13BKXoi+gV1lx9ORgyy4kMeqI9oLfZZlufNVQW+NB1EnKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783744884; c=relaxed/simple;
	bh=aDxzfY6bT7IXzsjvVe+q/A+3qkycq7qCD2NucCrMON0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmHKui8uaDTrTNNQESmwrPL0ry9Kups1PRYYrPNg5I8ju2K9GuyUfWaQiFxAfQYqBHOpciDOvpLTKS9WUOPKYMaq6AtHU955tpqI3H/3d8WM7EcvVnFULjcdal3bRITUvhkKU3AuyvWmYuEOgFAXPjEomnC6gyO+1avMMjBRjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=g7EnXko/; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="g7EnXko/"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gxwy20X6BzKnH8;
	Sat, 11 Jul 2026 06:41:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1783744874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyrDKc6+UkaIRpwi1rdgsrlg/YNeGkCxs/T+ipMB7oQ=;
	b=g7EnXko/wyf0WQiL5mY/hafIxjSHVbzwUQZMxD7y2AjmpFOraUFpGjgXeQGUdtmooi7BiD
	+95iclcvJevGEr+gvO5jx6jh8beqtHZ5ASeZeSEoCl7XDwGCtzYthQqS5MAPUY/QLC7TmR
	HiZqrlD+ldR0967fvHLseFSrwD1RYtD5DdHcOgBN05ptp5FpiAts9oq7CcneBV1l0PBBsb
	iiUwVdxtrVsxHeQWpr/qFOUHBKLUiF6bl/a1C/pqihKhWsIc70IgwOS6Yo/R8WFQEzFUuX
	2M3VEi7sXTuPLGXGXj6uOfkSd8rezz/WHUAHHwapS5yPKFb79KXzQOuMYOfgDg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 11 Jul 2026 12:40:20 +0800
Subject: [PATCH v3 2/5] refcount: add ref_trace_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-refcount-final-put-trace-v3-2-674c8f03d9f9@mavick.dev>
References: <20260711-refcount-final-put-trace-v3-0-674c8f03d9f9@mavick.dev>
In-Reply-To: <20260711-refcount-final-put-trace-v3-0-674c8f03d9f9@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=m@mavick.dev;
 h=from:subject:message-id; bh=aDxzfY6bT7IXzsjvVe+q/A+3qkycq7qCD2NucCrMON0=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmBJ22DJp8//+h3OEPKfJ3Ewv/Xkitub5dM3K7tfU5r/
 5/zC3XYO0pZGMS4GGTFFFlqshLcM1bOSjQ+OqkHZg4rE8gQBi5OAZjIRSeG/yW3P+YbybFllu5j
 XOG+Q710ps4jq+cLFoXt+vZv/ZQnRwUYGV6lCb9T3Pv7ktqnjtyS83Nfex9mWiTsPs38UpC3TbT
 NHzYA
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4gxwy20X6BzKnH8

Add the ref_trace_final_put tracepoint to __refcount_sub_and_test() and
refcount_dec_if_one()

This tracepoint fires when a refcount_t reaches zero, capturing the caller
address, the function name, and the refcount_t address.

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/refcount.h | 2 ++
 lib/refcount.c           | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

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
index a207a8f22b3c..cd7e32df3919 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -7,6 +7,7 @@
 #include <linux/refcount.h>
 #include <linux/spinlock.h>
 #include <linux/bug.h>
+#include <linux/ref_trace.h>
 
 #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
 
@@ -56,7 +57,12 @@ bool refcount_dec_if_one(refcount_t *r)
 {
 	int val = 1;
 
-	return atomic_try_cmpxchg_release(&r->refs, &val, 0);
+	bool ret = atomic_try_cmpxchg_release(&r->refs, &val, 0);
+
+	if (ret)
+		do_trace_ref_final_put(r);
+
+	return ret;
 }
 EXPORT_SYMBOL(refcount_dec_if_one);
 

-- 
2.51.2

