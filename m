Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490501;
	b=v+qkaLLhnOFNyj3JzNQJc1N+AwlN8OzlTtge1xysDnKIs+z6WRpZis1wssgDHgzknh0r
	 cXpaDHTh7TwFhkEOUalW51jH+bFMG/vxA1c4lIQAelo3iT+NrAu23aEsGAW21ywHYuAus
	 f+0EJ+9muHpxQgOaEb8a5EORX60TVz2rQWCCmFo7VtTECx3YsdElYiK6bFTfM0/1nF79N
	 sT1Lhs4qwxVl5AVEhlNqorNf5vbCmFBJpWqlxO+sDVlfkDJsQInUS/SYceGSX3pep5BCO
	 KDMuyVj3KsGCA1RixeQsp89f/DkvVCOqpd1FCvdSgMx0ll0abCjg488FMk7Rmg4xz0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HdRijAXEsZDim5gvppdkeJMWJz45RebInPZ6gU9sYj8=;
	b=lKOMjTJ8vkQsu3CyUxq0ii/rQZ6qw9ki4zQNxD3IXuo00OMZVOgk2EsodpLcBCq0r95p
	 iaC+EzreU5MwuiROFUDgclPWPYaKWqqUFHwwF4XA0n1M7fTL1j2sRfVRp2Ud1jj0repfg
	 vVXaStt01V0b1Qd+elfZKEmVGRicOWs6bh9f4xVRgai+LU5E5B817fR5hWl1SdJTP5p7D
	 rB//tytF5KJ9LHSHCC2bc2LkTCeKpXgXsjxZkGZrHv6atoGbtCMKfsZ7Fk0l1vJ22niaI
	 IUiw4pfZZ5bKPD6c+qrJ0W1YWw2BmOh4NlePv152VORHwyx/Kei86GQWNxpfgU1e3Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0OIaxwP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3592606A339;
	Tue, 20 Oct 2026 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0OIaxwP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753821F000C5;
	Tue, 20 Oct 2026 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490500;
	bh=HdRijAXEsZDim5gvppdkeJMWJz45RebInPZ6gU9sYj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j0OIaxwPCs2TcSuyPIf3g0eq/B9KXJkpJ47AgfF8eYMcUF8lFxMRHVeBCwETMLown
	 obTXdZeS2L9yjjxi+OSzJZ0197FkAvQGQsmNGm58IQ8ScfHBANTLmyu3H7r6oF+4+B
	 zyaC6aXXYYExFFIM71tagPMTzuUwJfRCo87bZqBUojlFrxG6MPT9tOE6yfhfjezZHx
	 +P73ZaCrQzL9wawAKeN8whJE4jeA0BTboAQTveT8fJXx/cFHIjgSCYKOo4b09nx2Hm
	 di8motcnVXCJBBJ7o+6iuOlVc3b3UnP/JeuxvgoZEv2oBGmV7iHMCAjhPSWnTYMpQR
	 /K8H6cy1AiEDQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Alex Deucher <alexdeucher@gmail.com>
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [RFC PATCH v2 1/3] dma-fence: Remove RCU protection for fence->ops
Date: Tue, 20 Oct 2026 12:00:32 +0200
Message-ID: <20261020100034.759183-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020100034.759183-2-phasta@kernel.org>
References: <20261020100034.759183-2-phasta@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One issue dma_fence suffers from is that the implementation can run into
the driver through dma_fence_ops pointers. The driver, however, might
have unloaded at this point, or the callbacks might run into other UAF
issues.

It has been attempted to solve this with RCU protection, creating a set
of sophisticated rules that the driver must follow. Notably, the driver
must delay unloading by an RCU grace period, and must delay freeing of
resources needed by the callbacks by a grace period also.

This is fragile because the dma_fence implementation has no control over
it.

Subsequent patches present a more robust implementation. Remove the RCU
protection for the backend-ops.

As an additional bonus, this allows users again to identify their fence
through the ops-pointer address, as is frequently done throughout the
kernel.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 78 +++++++------------------------------
 include/linux/dma-fence.h   | 18 +++------
 2 files changed, 19 insertions(+), 77 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index bd58688b81a7..5dab647e3f3f 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -353,7 +353,6 @@ void __dma_fence_might_wait(void)
 void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 				      ktime_t timestamp)
 {
-	const struct dma_fence_ops *ops;
 	struct dma_fence_cb *cur, *tmp;
 	struct list_head cb_list;
 
@@ -365,15 +364,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 
 	trace_dma_fence_signaled(fence);
 
-	/*
-	 * When neither a release nor a wait operation is specified set the ops
-	 * pointer to NULL to allow the fence structure to become independent
-	 * from who originally issued it.
-	 */
-	ops = rcu_dereference_protected(fence->ops, true);
-	if (!ops->release && !ops->wait)
-		RCU_INIT_POINTER(fence->ops, NULL);
-
 	/* Stash the cb_list before replacing it with the timestamp */
 	list_replace(&fence->cb_list, &cb_list);
 
@@ -524,7 +514,7 @@ EXPORT_SYMBOL(dma_fence_signal);
 signed long
 dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 {
-	const struct dma_fence_ops *ops;
+	const struct dma_fence_ops *ops = fence->ops;
 	signed long ret;
 
 	if (WARN_ON(timeout < 0))
@@ -537,19 +527,11 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 	dma_fence_enable_signaling(fence);
 
 	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
 	trace_dma_fence_wait_start(fence);
-	if (ops && ops->wait) {
-		/*
-		 * Implementing the wait ops is deprecated and not supported for
-		 * issuers of fences who need their lifetime to be independent
-		 * of their module after they signal, so it is ok to use the
-		 * ops outside the RCU protected section.
-		 */
-		rcu_read_unlock();
+	rcu_read_unlock();
+	if (ops->wait) {
 		ret = ops->wait(fence, intr, timeout);
 	} else {
-		rcu_read_unlock();
 		ret = dma_fence_default_wait(fence, intr, timeout);
 	}
 	if (trace_dma_fence_wait_end_enabled()) {
@@ -572,7 +554,7 @@ void dma_fence_release(struct kref *kref)
 {
 	struct dma_fence *fence =
 		container_of(kref, struct dma_fence, refcount);
-	const struct dma_fence_ops *ops;
+	const struct dma_fence_ops *ops = fence->ops;
 
 	rcu_read_lock();
 	trace_dma_fence_destroy(fence);
@@ -604,8 +586,7 @@ void dma_fence_release(struct kref *kref)
 		dma_fence_unlock_irqrestore(fence, flags);
 	}
 
-	ops = rcu_dereference(fence->ops);
-	if (ops && ops->release)
+	if (ops->release)
 		ops->release(fence);
 	else
 		dma_fence_free(fence);
@@ -628,7 +609,7 @@ EXPORT_SYMBOL(dma_fence_free);
 
 static bool __dma_fence_enable_signaling(struct dma_fence *fence)
 {
-	const struct dma_fence_ops *ops;
+	const struct dma_fence_ops *ops = fence->ops;
 	bool was_set;
 
 	dma_fence_assert_held(fence);
@@ -639,18 +620,14 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
 	if (dma_fence_test_signaled_flag(fence))
 		return false;
 
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
-	if (!was_set && ops && ops->enable_signaling) {
+	if (!was_set && ops->enable_signaling) {
 		trace_dma_fence_enable_signal(fence);
 
 		if (!ops->enable_signaling(fence)) {
-			rcu_read_unlock();
 			dma_fence_signal_locked(fence);
 			return false;
 		}
 	}
-	rcu_read_unlock();
 
 	return true;
 }
@@ -1019,13 +996,10 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
  */
 void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
 {
-	const struct dma_fence_ops *ops;
+	const struct dma_fence_ops *ops = fence->ops;
 
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
-	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
+	if (ops->set_deadline && !dma_fence_is_signaled(fence))
 		ops->set_deadline(fence, deadline);
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL(dma_fence_set_deadline);
 
@@ -1065,13 +1039,7 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 	BUG_ON(!ops || !ops->get_driver_name || !ops->get_timeline_name);
 
 	kref_init(&fence->refcount);
-	/*
-	 * While it is counter intuitive to protect a constant function pointer
-	 * table by RCU it allows modules to wait for an RCU grace period
-	 * before they unload, to make sure that nobody is executing their
-	 * functions any more.
-	 */
-	RCU_INIT_POINTER(fence->ops, ops);
+	fence->ops = ops;
 	INIT_LIST_HEAD(&fence->cb_list);
 	fence->context = context;
 	fence->seqno = seqno;
@@ -1166,17 +1134,8 @@ EXPORT_SYMBOL(dma_fence_init64);
  */
 const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
 {
-	const struct dma_fence_ops *ops;
-
-	/* RCU protection is required for safe access to returned string */
-	ops = rcu_dereference(fence->ops);
-
-	/*
-	 * Make load ordering irrelevant by checking both signaled state and ops
-	 * pointer and ops pointer is only set to NULL on newer implementations.
-	 */
-	if (!dma_fence_test_signaled_flag(fence) && ops)
-		return (const char __rcu *)ops->get_driver_name(fence);
+	if (!dma_fence_test_signaled_flag(fence))
+		return (const char __rcu *)fence->ops->get_driver_name(fence);
 	else
 		return (const char __rcu *)"detached-driver";
 }
@@ -1204,17 +1163,8 @@ EXPORT_SYMBOL(dma_fence_driver_name);
  */
 const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 {
-	const struct dma_fence_ops *ops;
-
-	/* RCU protection is required for safe access to returned string */
-	ops = rcu_dereference(fence->ops);
-
-	/*
-	 * Make load ordering irrelevant by checking both signaled state and ops
-	 * pointer and ops pointer is only set to NULL on newer implementations.
-	 */
-	if (!dma_fence_test_signaled_flag(fence) && ops)
-		return (const char __rcu *)ops->get_timeline_name(fence);
+	if (!dma_fence_test_signaled_flag(fence))
+		return (const char __rcu *)fence->ops->get_timeline_name(fence);
 	else
 		return (const char __rcu *)"signaled-timeline";
 }
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..874848a4aec4 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -72,7 +72,7 @@ struct dma_fence {
 		spinlock_t *extern_lock;
 		spinlock_t inline_lock;
 	};
-	const struct dma_fence_ops __rcu *ops;
+	const struct dma_fence_ops *ops;
 	/*
 	 * We clear the callback list on kref_put so that by the time we
 	 * release the fence it is unused. No one should be adding to the
@@ -516,19 +516,15 @@ dma_fence_test_signaled_flag(struct dma_fence *fence)
 static inline bool
 dma_fence_is_signaled_locked(struct dma_fence *fence)
 {
-	const struct dma_fence_ops *ops;
+	const struct dma_fence_ops *ops = fence->ops;
 
 	if (dma_fence_test_signaled_flag(fence))
 		return true;
 
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
 	if (ops && ops->signaled && ops->signaled(fence)) {
-		rcu_read_unlock();
 		dma_fence_signal_locked(fence);
 		return true;
 	}
-	rcu_read_unlock();
 
 	return false;
 }
@@ -552,19 +548,15 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
 static inline bool
 dma_fence_is_signaled(struct dma_fence *fence)
 {
-	const struct dma_fence_ops *ops;
+	const struct dma_fence_ops *ops = fence->ops;
 
 	if (dma_fence_test_signaled_flag(fence))
 		return true;
 
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
 	if (ops && ops->signaled && ops->signaled(fence)) {
-		rcu_read_unlock();
 		dma_fence_signal(fence);
 		return true;
 	}
-	rcu_read_unlock();
 
 	return false;
 }
@@ -769,7 +761,7 @@ extern const struct dma_fence_ops dma_fence_chain_ops;
  */
 static inline bool dma_fence_is_array(struct dma_fence *fence)
 {
-	return rcu_access_pointer(fence->ops) == &dma_fence_array_ops;
+	return fence->ops == &dma_fence_array_ops;
 }
 
 /**
@@ -780,7 +772,7 @@ static inline bool dma_fence_is_array(struct dma_fence *fence)
  */
 static inline bool dma_fence_is_chain(struct dma_fence *fence)
 {
-	return rcu_access_pointer(fence->ops) == &dma_fence_chain_ops;
+	return fence->ops == &dma_fence_chain_ops;
 }
 
 /**
-- 
2.56.0

