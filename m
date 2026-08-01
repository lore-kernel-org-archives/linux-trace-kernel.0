Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6FD34CFC3;
	Sat,  1 Aug 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582070; cv=none; b=IftwZf2VMI5VGan0Sbav6zVhGTbvHtgaFYe2DT69IeaO8J8VDTKtZZnp2DzXnjmrcY7JAlebbWxMqTV2qUK8ibwmyCgknH7W0yVw1pFRLtR/byXjdS1tApiyZP8ELt3gPzIbGmNK2jzZMR/5YMTgxUzqM3Y+rx4RiMmx1xGzqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582070; c=relaxed/simple;
	bh=vVWsfTjSGw6e33WP2d/uyqteLjy9dxiqe2AmCt04NhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FoSwsamcTIEzoisJGFtn4yNHb+PtTbVgYd1AGSETrLkjHxpJP0ZGsmHGK6bhfW9nH+0123EzMvDujWceUOC73KEbjIWB+h0WOOGuzToRh28YwlP1P+FBSR1WGUK7UEFf9D33uBrGMSG3uG+zku+1sws5pSmoRSgiF9CsXtj70IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=ULv7c+A+; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="ULv7c+A+"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hC0NW26qRzMlG2;
	Sat, 01 Aug 2026 13:00:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1785582059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WpDJUffFYkGym8OqsSvgqtunStF+Lue8wI1l/VKbI4=;
	b=ULv7c+A+XtrEfThv/Q/aTfNHm4m5vuNp8oaxIEWB+EiIKIi1CZzpbfhTbqY8Xv9fWH53/t
	IApqH1JzM8fgCZN624DOtTl28kZAqS3H0dWz8UnO0Xndus3evT1PK2mNnAnyJN01PWQuaE
	v4ncoSakk3Z6c5TiqRnlYyEFfE25xdTgn/2KbmoY0Fyjy776rxjweSduYTGdhp8Mj/RunU
	7FxUYA4Kgyot1RVQ23atRYHJ3VTRTLugpoaeQ8ZIuQmcDg8Vk2cf97MSndqjd5ejHbP7wa
	tPGw4RL1smhArVOZ1imMzGZjnO8wLiZf9iS4rfN793SR9oMUEB7cxiHNZeiJ4g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 01 Aug 2026 18:59:43 +0800
Subject: [PATCH v4 3/5] percpu-refcount: add ref_trace_final_put trace
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-refcount-final-put-trace-v4-3-2e58678f0ffd@mavick.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=m@mavick.dev;
 h=from:subject:message-id; bh=vVWsfTjSGw6e33WP2d/uyqteLjy9dxiqe2AmCt04NhY=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFm5FzdyWXXZb8zp+M/n8N/1V8Y3De8Lh26s7SlbfGn56
 /ZHFQ2aHaUsDGJcDLJiiiw1WQnuGStnJRofndQDM4eVCWQIAxenAEzkci3DX0mjUxb3ftbvbzVg
 q/pX+6Ux8RDb/Q4Dt1l8Eic/T2z5VcXwh3PjSvUA/7lmtze/mStzIVOzZsPxdapdMu2Guyu/6x4
 y5AQA
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4hC0NW26qRzMlG2

Add the ref_trace_final_put tracepoint to percpu_ref_put_many().
The tracepoint fires when the atomic counter reaches zero in the
atomic fallback path (after percpu_ref_kill() has been called).

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/percpu-refcount.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..f870ac0e8c06 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -55,6 +55,7 @@
 #include <linux/rcupdate.h>
 #include <linux/types.h>
 #include <linux/gfp.h>
+#include <linux/ref_trace.h>
 
 struct percpu_ref;
 typedef void (percpu_ref_func_t)(struct percpu_ref *);
@@ -331,8 +332,10 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
-	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
+	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count))) {
+		do_trace_ref_final_put(ref);
 		ref->data->release(ref);
+	}
 
 	rcu_read_unlock();
 }

-- 
2.51.2

