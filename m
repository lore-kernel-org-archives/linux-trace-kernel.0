Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976A1A3160;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783214479; cv=none; b=kDnSGDL+ACiGVLYR6bxS5YGxIhR55+SEUMA6riSXal8Zt68jN1nd2SPLk5DNJTxCxFo2ZDlss4zxUtx+kbe5bs2PA70Mohsn1ecWc+aAlPACzh8u25KAUjrgN2yEgWsJeNZZcMAdrFr2tFyjUiQYXJlufUdxHE7HMznHtqQ3dBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783214479; c=relaxed/simple;
	bh=aJl7nlLOWLA1emiT3W2w+Al8DEuLxD7KOL2U/1Me0R4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpcD/RCf5/RWfc7/vUkQnXdKqFstb09i36HGR8muUdj+KMmVkJtJR9zLHhFuRdIOfOfL0kAHcWwGqaOW9Di6eeOqBUep/C3Ur4uvdnhGSiexS5DHPwL4dQ2bMJPKS6zWEaLjxdEmKxd9CIDWUfLphSRja0w+5Cqms52T2gUnGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvIeACEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvIeACEb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3777DC4AF0B;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783214479;
	bh=aJl7nlLOWLA1emiT3W2w+Al8DEuLxD7KOL2U/1Me0R4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CvIeACEbSj+AOfNaRgYMCZGKu+lLtS8WS9X586BjNPYzHeyA6WJ3bCcIwNNSezb02
	 D17g0J8LDrLTA/hmoiZGqcg5kZxYYZ1FZZvQwAu5xDdmjGtNZX92ikIWXGly2Dog8M
	 Zo2n3Sh5Hbb9b12Tll07xY501t6NIu9eqJHUFcWxb+ycFzOmrX8GFuX7bfQCKoJQ2G
	 30yYlo1dvX4ufffod6YouNt+e1HPFSwk5Bft+r5Fxvs5I5T4YPp7/Yl0ao8w/BRQeI
	 likpXVKeInaxtHqQKYnyllw1cC2wj8aL2iLEx+Kr0VBz3bMHNU2FO9nU+oGIcyEEuZ
	 2L8b40f+vHfHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18989C44501;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
From: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Date: Sun, 05 Jul 2026 09:20:52 +0800
Subject: [PATCH 2/4] refcount: add ref_trace_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-refcount-final-put-trace-v1-2-0ae936edb750@mavick.dev>
References: <20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev>
In-Reply-To: <20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=m@mavick.dev;
 h=from:subject:message-id;
 bh=oxdQX1dkebrHkQOKFGbMe1L7jn1KmiWYDIa5MeosIJI=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmeGyv/807KiA0NbPXYPkn7mHjaVUmpXYse5O2/nPh50
 8XpL0UudJSyMIhxMciKKbLUZCW4Z6yclWh8dFIPzBxWJpAhDFycAjCRI7WMDA/MrTK8W0pXGvLM
 14mQLjER/Vx4pUtRfGNCYHGoZ7NZMyPDgq+JyszX12/Ufi2bXiGsJ/xxrXn5lo5M4zYNvpwAwxk
 MAA==
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Endpoint-Received: by B4 Relay for m@mavick.dev/default with auth_id=850
X-Original-From: Eugene Mavick <m@mavick.dev>
Reply-To: m@mavick.dev

From: Eugene Mavick <m@mavick.dev>

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


