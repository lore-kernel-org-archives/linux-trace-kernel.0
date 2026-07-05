Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39862477E2B;
	Mon,  6 Jul 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320464; cv=none; b=krWv0wlOyZJ8c9N3a4OEKJzFQs2Sau9mZ7N8IBA/dIL+DkELIiU8y/6EVdfnNUtLDhml1CCueNWhZA2eC7Z0jTSBUWzUh4tGaPIqN/Qlk7AxnSrSP4UhFwCv/v6y9Pk33of7223kZDzvAnmatbLX/BFWwWaSUT25RN1mlq35C0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320464; c=relaxed/simple;
	bh=oxdQX1dkebrHkQOKFGbMe1L7jn1KmiWYDIa5MeosIJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4YBgW+kfDGU2ALy6RgEgqfjXJChFJEb/3eCjwmIDZgp9j90PJF7rLzMSXWZPrx7NZ61yPZIgt0Q5nG/iyLl1xU8kgNipQI0os1r5p9xiQrceo6nZU30+QvYRe8oQ45fQDkSDy4QDIdB97RpSXhcQ/kuHE/kVT9ConiIQaip7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4gt7r818DjzMlfC;
	Sun, 05 Jul 2026 02:38:00 +0200 (CEST)
From: Eugene Mavick <m@mavick.dev>
Date: Sun, 05 Jul 2026 08:36:57 +0800
Subject: [PATCH 2/4] refcount: add ref_trace_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-refcount-final-put-trace-v1-2-a41d3fd0e869@mavick.dev>
References: <20260705-refcount-final-put-trace-v1-0-a41d3fd0e869@mavick.dev>
In-Reply-To: <20260705-refcount-final-put-trace-v1-0-a41d3fd0e869@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=m@mavick.dev;
 h=from:subject:message-id; bh=oxdQX1dkebrHkQOKFGbMe1L7jn1KmiWYDIa5MeosIJI=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmey21LVNYs/T5DfbKt57w5905zelUz5NZ4BFh3hdty3
 fmiYLilo5SFQYyLQVZMkaUmK8E9Y+WsROOjk3pg5rAygQxh4OIUgInICjP8lY6tyRF/t3b3x1XX
 rz5s4mfaVaP9+Iu1zEqGsyvZ2hhvsTMydEqbnQi9Jb+RJ+Xnmgc7rn310OS8YWnPLtp58ufvax0
 pvAA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F

Add the ref_trace_final_put tracepoint to __refcount_sub_and_test().
This fires when a refcount_t reaches zero, capturing the caller
address, the function name, and the refcount_t address.

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/refcount.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index ba7657ced281..7b1fbf326a21 100644
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
+		trace_ref_final_put(r);
 		return true;
 	}
 

-- 
2.51.2

