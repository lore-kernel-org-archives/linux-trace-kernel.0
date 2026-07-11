Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CE27E1DC;
	Sat, 11 Jul 2026 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783744885; cv=none; b=XhxIPIXBbRYmUscscdRulEpV7ltoqCUM5MnoobIgiqBjeqVWVqczWM23bhfpwfOkKzJql/FsgN8Re11Gj6cLpOJ0whdvsbHywmxoEgqZK+y67gt/7ktB+L4rrYIqtmG4QO8/E1qmR8BJAEgR+LYPhC2ENioqD9gSUNRsATFSPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783744885; c=relaxed/simple;
	bh=vVWsfTjSGw6e33WP2d/uyqteLjy9dxiqe2AmCt04NhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QwIbF281s6nZwLRP1qh4b5W08t5AaXgd5fFbE3aKb2BzeBMROcIBloi0yTIK5NCkCGsJ4AJTIBdWetgD1h7EBAJY1iverSnxdyOmuMXgxUdGzsRhlo59PI7/6ku5Fs9Knh/n0wpQlCT5lYpSK86CSJJF0OObY8sV6XSEJ1w/1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=Q09mZMDB; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="Q09mZMDB"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gxwy864p4zKnRd;
	Sat, 11 Jul 2026 06:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1783744880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WpDJUffFYkGym8OqsSvgqtunStF+Lue8wI1l/VKbI4=;
	b=Q09mZMDBC3SL2Aw+Qz9LF/nU3tBPOXtA6NdSL96a1e8e8dmySvxy5+Cfav+dkJpUXt22Pi
	JeN7JHaUTsAqERdODP154c/17aUIO4dKH5MAOuelbkZ5GEFW/i/NKgj/6WlHcW5FpM7uhO
	i5rLjrNn5a1pz1g3kA1r7mTnhShvmN8lxPAHrUDN+EQafdh5oIfunKkvPD2J+x563LjEOP
	JRPVKmM3yFLQFzjsRSNWLx2atapc2C4jCSyRqf8Rssc7+dM7+qz1NnnVqBitsri7r/WL+X
	jRVuFMDF3MjMzuovC779vCM5SA7B8CbytS+qTUxu67X96SFDqcx+jN4JTGBedg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 11 Jul 2026 12:40:21 +0800
Subject: [PATCH v3 3/5] percpu-refcount: add ref_trace_final_put trace
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-refcount-final-put-trace-v3-3-674c8f03d9f9@mavick.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=m@mavick.dev;
 h=from:subject:message-id; bh=vVWsfTjSGw6e33WP2d/uyqteLjy9dxiqe2AmCt04NhY=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmBJ23vb111w/3P63trb8dvX1hUVb2tbVrViy+RZlzPg
 soe2hQ+7yhlYRDjYpAVU2SpyUpwz1g5K9H46KQemDmsTCBDGLg4BWAiR58z/C+57H/Vr0pIcnoy
 z/HdNlUnXF9PqMw9nTRVSt3p+OOmJAGG/+GL125TbDn11LJ25e+wI+kO2X/rNbp9ehKjTgduMxd
 14QQA
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4gxwy864p4zKnRd

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

