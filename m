Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490508;
	b=aYiCusWWcRAELXy6Za+i8yNkJJXCMqErZq2sMt71cHuHOFMeMs5O7Y5/sO1aJLr9WzSx
	 b5VW0p7UK/LfZkEGvddpW3IhTIdASbdzlbIOGPJhOS83Lc6+W7od+XDYRkAoG1n9f2r3a
	 iuS+hKl/zc4nZwDWj2WyXlcX2WBAJnSRgpUOuO8vydWg5A+Sko52wti1erS6bESlhsZ4L
	 vGeFON/3aaN9bgtm9pr46gt/26FRtXeeLS05lc5o0WrD2JP9PQacKkzZbTGaW6/gfcktZ
	 /V+XN8OJt8c8fnQxBvrQTDAaNWSby+KPAOlIaybVOeYmxfzX9byQAHSzmFoI5c7g2qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JGDgmrNrY/Zf3/bNe/po5mMDHbPIY3J54PXDSn4VlJM=;
	b=UUoNCfs99Abf2ymnmJ9hSmupAMcNxfViyoWetEUfC0C9+ivCm0thoXIy6Jcs69Np0OZB
	 EuFYk9d7POYuR/Lda6iznNQ6WRCEAzWUu2S/53caJ/s8lZEHSb8IRARfOCp17XWnUNjXQ
	 jqBQIG+exvmrkRoZu2z8ItJeEo/qHrivmTMvo0ZcWrRwIdEORF8EFlWlrV9+eGtmXvbqD
	 ssSpMGboaqFBGSjfrE/fHCB93Gmf6OC+Umad98m9lf9kGhC1XA0SvDk0xXhH6nusbrvkH
	 MaH38DFqUE/lNlPoLlPG2GpSKzD+JDLsI7aMIHp/PgDC9xLCUCvns7vmFi/5jJPR37Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4yAhkeh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A083606A32D;
	Tue, 20 Oct 2026 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4yAhkeh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D262D1F000C7;
	Tue, 20 Oct 2026 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490507;
	bh=JGDgmrNrY/Zf3/bNe/po5mMDHbPIY3J54PXDSn4VlJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4yAhkehkx9HsNQho0qWUb9H/5LCMTo9aUxdM7CTQcLXsv2QY7OtwovpuxYSzWX+1
	 SZUKL7mzlWUa3FaObHkgkAD9Uul20Tvcx4ccOZ0kALkkQEuzZK4+OLCKDd9bBxT1x6
	 NhkHwq0poOdVOavBHYKALA+VdghhTbPtXmchpdq4aG2DYyngzKGmsWWwQV67aL79QQ
	 AOwM7EqoxYjqSHegGg2G0HyXSue807pIRRFokuYv3J3xv0TYn6H8u9vHjWglbQNq20
	 cM60+0zphZ6sQVrjufVwsZcmHC+ON97X2nVnSLJRT00MUwDiGOCkdQrelhiQtUPp3I
	 gbnP7arDCjE9g==
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
Subject: [RFC PATCH v2 2/3] dma-fence: use lock to protect against module-unload
Date: Tue, 20 Oct 2026 12:00:33 +0200
Message-ID: <20261020100034.759183-4-phasta@kernel.org>
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

dma_fence's lock already guards the signaled-state, and most fence
backend_ops callbacks are already called with the lock taken.

The contract already relies on the fact that a producer must signal all
fences before unloading. The callbacks then must never run on a fence
that is already signaled.

Currently, driver unload is supported by RCU-checking the fence->ops
pointer. However, the design ended up with two partially redundant
mechanisms, the other being the signaled-state:

	/*
	 * Make load ordering irrelevant by checking both signaled state and ops
	 * pointer and ops pointer is only set to NULL on newer implementations.
	 */
	if (!dma_fence_test_signaled_flag(fence) && ops)

We have seen multiple bugs, such as ordering issues, because of that,
for instance in:

035219a760ed ("dma-buf: dma-fence: Fix potential NULL pointer dereference")
3ed11c671ff7 ("dma-buf/dma-fence: fix checking signaling bit for timeline and driver name v3")

Additionally, our RCU requirements can by definition not be controled by
dma_fence, resulting in a burden on users and an unnecessary grace
period delay. Most recently, this came to light in CRTC:

https://lore.kernel.org/dri-devel/d54ba24b0a4748b5c00052d4542460ea014aa50d.camel@mailbox.org/

It appears to be the natural solution to guard the fence's signaled
state *and* accesses to the driver and its data through the lock.
However, in the past it has been argued that one cannot hold the
fence-lock while running a callback, because this might lead to
deadlocks, since drivers might want to access data protected by a driver
lock.

De-facto, it is already the case that ops callbacks are called with the
lock taken, and don't run into the driver if the fence is signaled
already. Thus, we merely need to make that rule official.

This commit proposes making it standard to guard against UAF and module
unload by holding the lock while running fence->ops.

The current situation of the ops is like this:

- release() and wait() are deprecated and can never work with module
  unload in any case, thus neither RCU nor lock help them anyways.

- enable_signaling() and is_signaled() are already being invoked with the
  lock, thus continue doing so is fine.

- get_driver_name() and get_timeline_name() can elegantly be solved by
  copying the name-strings. See subsequent patch.

- set_deadline() is the only callback for which a locked call would be
  new. It has very few implementors, so correctness is easy to verify.

For dma_fence_is_signaled(), dma_fence_is_signaled_locked()'s existence
proofs that we can lock the former's ops->signaled() call, too.

The fact that most callbacks are already invoked with the lock taken
proofs that the drivers support it, and doing it consistently will make
the entire API far more robust and consistent than RCU-guarding.

Current users keep working, and future users can be well-informed about
the locking considerations.

Let's go for full, consistent locking. Add lock guards around the two
missing paths running into non-deprecated backend_ops.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c |  7 ++++++-
 include/linux/dma-fence.h   | 21 +++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 5dab647e3f3f..e4350bce9cf9 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -997,9 +997,14 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
 void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
 {
 	const struct dma_fence_ops *ops = fence->ops;
+	unsigned long flags;
 
-	if (ops->set_deadline && !dma_fence_is_signaled(fence))
+	dma_fence_lock_irqsave(fence, flags);
+
+	if (ops->set_deadline && !dma_fence_is_signaled_locked(fence))
 		ops->set_deadline(fence, deadline);
+
+	dma_fence_unlock_irqrestore(fence, flags);
 }
 EXPORT_SYMBOL(dma_fence_set_deadline);
 
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 874848a4aec4..2223d75c5a49 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -549,16 +549,29 @@ static inline bool
 dma_fence_is_signaled(struct dma_fence *fence)
 {
 	const struct dma_fence_ops *ops = fence->ops;
+	unsigned long flags;
+	bool ret = false;
 
+	/* Fast-path optimization. */
 	if (dma_fence_test_signaled_flag(fence))
 		return true;
 
-	if (ops && ops->signaled && ops->signaled(fence)) {
-		dma_fence_signal(fence);
-		return true;
+	dma_fence_lock_irqsave(fence, flags);
+
+	if (dma_fence_test_signaled_flag(fence)) {
+		ret = true;
+		goto out;
 	}
 
-	return false;
+	if (ops->signaled && ops->signaled(fence)) {
+		ret = true;
+		dma_fence_signal_locked(fence);
+	}
+
+out:
+	dma_fence_unlock_irqrestore(fence, flags);
+
+	return ret;
 }
 
 /**
-- 
2.56.0

