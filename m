Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793910734;
	b=HN8wOPKsmw0gnWihakJ28VhaVfYmg9RvZI+pJS2kGXuvAUdzZqJYnTqs19ttXZ9sxiw7
	 UrcTISK+buYweWzWChLdI2OApdG7YVD8QPPHFf28M3moo1COjE7KzZl+By9dLBluoK+h8
	 NJzZtesVnAh5xd2jjenXSStlhvaWwwgDKEVoIeIZn/85toyapXK2k6dv/jYmUSFHD8VKD
	 mY1yP9uK07OMTCTHV0Qv8x5EaVMJUBNXvS6T4FqHZLN8tfQRSwqwOoyJaIEcLmwzv2869
	 dZTVSPWzSZOy30uDjxtRAX5CwV6F6HhwltdArC05INP/5Iw+u5XfcJlnqZ0eH5Y7yQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910734;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RiRoU5OgJXo06INlNWZ9Bkbf6Z6zd3CcI/JCpLo707w=;
	b=ie/1t4gD3vYeITv906fcZzuviuGgi5ab+f2kTLhyl81MFjk+YoWfYm2hI5wvOv327eSa
	 Sh6VQ91Boq+q20GFpsMU3vlNgaKm+DfIHYmW6cqzWInH174rSWgpmBWqogVjBuE3EsnTm
	 Lwaz/t6IeM2Nk/IfR2Y2EDyFhP5eh4bWFmiOjB1C9Agd0Ftk0Lt+C7KfW42IdD59lTiMa
	 TI34xpK8U7BPABk4hHXwTRtW8iF0y/ZA9D/SAhqYFR9l60tbQUVAHcAyMuCVUEs8XkpBc
	 lE5qLMSd0viaCokb15VOcD0g9K+d86w+LDCN3mh81qKqmcSCrxDw/lLdirjGAux52uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwfv71nj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2B606A33E;
	Thu,  5 Nov 2026 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwfv71nj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793910734;
	b=O3HzVsUz/49FM5KnzxwX3cCNz/886F7qSKG36k7WPZgkUXoHIbxJEmAKd86yZ8IrQOpt
	 CDKpodZGYodQKaO6CNT3EdwBRwxJQEXZ0gjC3wvvLHN4hQ2Jfr1MK4Iv5wEFLy/R6ytis
	 3ZRHGDw/ASGBo3w3OdYQUCijQ12ZpqLEPk3KXvEK8zaLRjhpo4Lz4uUxM4jkOyharJk/i
	 cvvGK+r+Ykx6xcF3ec5cNEgSwJDKvwWjjl4ivCz6/Kvmcw51cEnnSPr8nCD2bbY0ayWfE
	 skAT0RONLvrSbVcG26j7Y9CzQ6mVOutRDfRVNUT9VXV5Mt91Ocs1or/ZZZh6LIXIyAw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793910734;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RiRoU5OgJXo06INlNWZ9Bkbf6Z6zd3CcI/JCpLo707w=;
	b=Q9u6tTnpaUTg0WThRmmTEy1cZ2ePC3hmhoEqYs7e5V10kZQMq+74SYMfsovCFxTfJo3J
	 aSUxUtbjI6EJ0NjsImbyxuAxUSO2DW+G6fpWnTm8JiFUWl4dxYpj/qizbqxvPHavTFwCs
	 2trW/A+0XdKT32EYVnC7ixy5RGhL4zfDRysfyYNMnmWO0rPchkM0mxcan3r6XC8YUqaex
	 hzo/mKMCjtX7XQRh5wML0n3G6p5yfoE5phKgMCNUfMGBPZ9oRVI9bCUwFqFWFRItN/xtu
	 Rx4RSaOJOZKdLf+Se4B2jROik0IoVZ46ukbeNnUV3eZAELzRTdI9S/MFtPtmflT51bQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3AC151F008A3;
	Thu,  5 Nov 2026 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910734;
	bh=RiRoU5OgJXo06INlNWZ9Bkbf6Z6zd3CcI/JCpLo707w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bwfv71njopTO/nMSree5Yb19pT9RTJOTlMzFOwalYL0ink3PmmJ1ShTj/py0tqmSD
	 sKKExOoI+nxLxJQzchiCX0o1kzjlh+6OMo1ndECKV7B+pxG2VqMYmaU+HyPdN2N2Px
	 iy7dQ0EjEgZcG4sCa3hF8XMIw7ifJENKF5dLfSJQsC6y0/hGV7Y1C0yBQ+xGfeBqWu
	 yceVBm1bkbKqKFyH5FJ7YbbcMKi1y7WBkIxJmhw+SWBWikdFb/BiU+aCU6+rpi9eMv
	 HUFzzQ8QzPMKyJSBBpBMMzZRMrjnAy8sZd7g2ewDw6NYmTxBVK0ZSU7ICXhserWAeh
	 EEdM08VOCVejA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B62CF41DE6;
	Thu,  5 Nov 2026 20:32:12 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Thu, 05 Nov 2026 15:32:14 -0500
Subject: [PATCH v2 3/3] kprobes: Arm reused optprobe on cooling list
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-kprobes-optprobe-state-v2-3-7a2f5290baa0@columbia.edu>
References: <20261105-kprobes-optprobe-state-v2-0-7a2f5290baa0@columbia.edu>
In-Reply-To: <20261105-kprobes-optprobe-state-v2-0-7a2f5290baa0@columbia.edu>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793910731; l=2160;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=/HCAv1Fv22PKOX1Qzyg9tXxCq5Zh9hIH5VnZqnVHksw=;
 b=ftE/orfEOyDjW80q5zI9iiCT+8OyojyN8qC5+QqeNDmikou06iUZOqX1EUfK+MCZdeqhsGSqC
 lNfP//+EoNCABHJJ/XqJqKnqiTeGJuhQ0JUzVLKZR+GYU1DpuQF63VJ
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

A new probe that reuses an unused probe still on a cooling list doesn't
fire.  reuse_unused_kprobe() clears DISABLED, so register_aggr_kprobe()
doesn't arm it and the probe has no int3 until it's optimized again, or
ever if it can't be (e.g., it has a post_handler).

Keep a reused cooling probe disabled instead, so register_aggr_kprobe()
arms it if the new probe is enabled, or enable_kprobe() does it later.
The probe is then still unused when add_new_kprobe() force-unoptimizes
it for a new probe with a post_handler, which would unhash it and queue
it for freeing.  Skip that since a cooling probe is already unoptimized.
With the fix, the new probe fires.

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Changes in v2:
- Keep a reused cooling probe disabled so register_aggr_kprobe() arms it
  only for an enabled new probe (Masami, Sashiko)
- Skip the forced unoptimization in add_new_kprobe() for a cooling probe
---
 kernel/kprobes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 099a38ca146a..5f8ce6892bd1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1059,6 +1059,10 @@ static int reuse_unused_kprobe(struct kprobe *ap)
 	 */
 	op = container_of(ap, struct optimized_kprobe, kp);
 	WARN_ON_ONCE(list_empty(&op->list));
+	/* Already disarmed, the caller arms it only for an enabled probe */
+	if (optprobe_queued_cooling(op))
+		return 0;
+
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
 	/* Optimize it again. (remove from 'op->list') */
@@ -1571,7 +1575,8 @@ void kprobe_busy_end(void)
 /* Add the new probe to 'ap->list'. */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
-	if (p->post_handler)
+	/* A reused cooling probe is already unoptimized */
+	if (p->post_handler && !kprobe_unused(ap))
 		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */
 
 	list_add_rcu(&p->list, &ap->list);

-- 
2.53.0


