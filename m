Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75A373C1A;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661476; cv=none; b=TgzBue0UAk081/SXdtqyiRo8ot4EgCSypxCtq3seYoRg+v6zdhMxfyd3FuTrd0Y1pLy3JZ4UUu23+glioEGZG7KtELDJAmRpmz0DugHx/BxhMOkz72PEOrphmlJFkcpzHfEeU6bK78OGqX+mukWnxsq7RuGd5BJKiQ3VsJDAeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661476; c=relaxed/simple;
	bh=BqhzH8win7IsFt3bVsGRfLZJqVQoC3H+EYEyrwbBQro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8X77odM7ye47TwJj9YWz0QtZlpGGSJqagNxVOR3C6o6fUTV1Nm0/p273fb8MEvo/e8g7JmSzvSYnyslLteTPtFLO67qm6DtbwdXHVrsd3iaUAEQNFx/24+ddOJG3fOjM+Z5/BLzQm6fWzQoiKBdDJqxP+gfYb0R0ythTCoMi3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erKo23p/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erKo23p/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F0CFC2BCC6;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783661476;
	bh=BqhzH8win7IsFt3bVsGRfLZJqVQoC3H+EYEyrwbBQro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=erKo23p/n5kFc0MNyrpiiMJlVgZNgKrb5Cqa0Xj3d4eC7KXuhU3/Kuh2tQ+f54nBT
	 yc/6LvcIXQDlOgq/iaatx+8GAG6oVcSzcNSuQh5U3PMtH7i8oUNvjl8furd1fyhIGp
	 JIUPxGbl4hr55lV+/pU7N3KNl0AGzQAVn6T7bsl+8AhPqQPpGT1NznD653qUcM0I1h
	 IRCSbAdmylu5BRyRNoX7XIXnu+tcMs5qxdI/HBI8mArYQjO12jrJn/tTR4EZ0niG7i
	 c7BMnHzo5VvIy412ijtdWSpq1ybrjDhgy3en1/ttAvo7DqWWXfHEzAR1QQIJjQyiPo
	 qOy+vnlH83AOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0225EC44507;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
From: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Date: Fri, 10 Jul 2026 13:30:40 +0800
Subject: [PATCH v2 2/5] refcount: add ref_trace_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-refcount-final-put-trace-v2-2-557cfce860a2@mavick.dev>
References: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
In-Reply-To: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=m@mavick.dev;
 h=from:subject:message-id;
 bh=LlgAKLvSTzT+rMKMAXMt37/mjMTpw1NXPXF0CRuqRZw=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFkBzT33jpy6k7R1+kNdW73wjXUfb26Iv7hoxdSVcvOmh
 rm/cvrs2VHKwiDGxSArpshSk5XgnrFyVqLx0Uk9MHNYmUCGMHBxCsBEnKMYGVab93IpL7he/jLA
 ddYj7ctyQnPDJzFeuLVL5dQpt+0l9UUM/4NabsonXO9+eaX0QMPN2z0a//MWS3reFtgW57Lj7cd
 mBTYA
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Endpoint-Received: by B4 Relay for m@mavick.dev/default with auth_id=850
X-Original-From: Eugene Mavick <m@mavick.dev>
Reply-To: m@mavick.dev

From: Eugene Mavick <m@mavick.dev>

Add the ref_trace_final_put tracepoint to __refcount_sub_and_test() and
refcount_dec_if_one()

This tracepoint fires when a refcount_t reaches zero, capturing the caller
address, the function name, and the refcount_t address.

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
v2:
-update commit message
-add tracepoint to refcount_dec_if_one(), suggested by Usuma Arif
-move MAINTAINERS file entries to new MAINTAINERS commit
-v1:https://lore.kernel.org/all/20260705-refcount-final-put-trace-v1-2-cdd0014626a9@mavick.dev/
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


