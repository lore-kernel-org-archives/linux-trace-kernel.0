Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491639;
	b=g1WZAlaOspW63mHJUWMCQKMczhZ099i1PepPwAujByMzUyrwPciiJlRXlZGceouAXAdb
	 rXvSuEstpAWN0IyYaiPFG12wmamjnrcGYBKVCjU43O8I13ewijdSlPeIc7RUZXuZtDt4+
	 TcYWouaXSNhYI4hTxF68KVmKc+qTD1oiRpYuw5aAgpjesT9ZR6r5l+nQCmd4sxkFwlcW+
	 fksVo8tqHw+V75Ivz/plRkjWrMM7hREdQndZ9AgcmGAn5kH9CQpy8dsHQ5YilKx4SwIUy
	 FYVO+PbEmnGjIoDHqHbH36CHrsrbq2W1DzLAxclyKLUGBcwryJoO4mv+WoKox8esxsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491639;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+vdKuUGJZcTOExS2dver0qpBvfiNikQcdfx2t1t7sVA=;
	b=ziKidbfbxJ33mvmjjxrt/yYenVf7u5gE0ioSMyMYt1ASiODiUcQWpR1hHO0C0FowkIEH
	 tMVV0cL/h2mXPaROFgaLgMrClKLDkOKlfWhqn/RGtA9GO1siqqMsHdrJKHVM+30/LhHse
	 com6Nx6WYX0nnF97BuMSe6o47jS0tmxxArFc9Otqs+eHrH2WF1w5sXBUzwC5HNU0dN2Ix
	 fkSmnJvEYTe73c025mOjLiV8GzjxI6iybktVXtaLym68acH2xcs0kjg5y5JkTjTcW+8ae
	 9OXDg7L2QS9ohNsUXydo7O1Ds22CNoUPKDwmeATJlCAOpNXXWe3hA2x6XSki6mt5/Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iT3P1u1d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42267606A319
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iT3P1u1d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8BB1F000C7;
	Tue, 20 Oct 2026 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491638;
	bh=+vdKuUGJZcTOExS2dver0qpBvfiNikQcdfx2t1t7sVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iT3P1u1dAbbMWDd+6rHAtve53lay2EwuGOVUaR7WAMBrNpSifjR7i+27GNXB4pXOr
	 TjlZw50cvhifgCH/t809FQLTk5qmSmOSh3SXwVJJueYhxdIA4ZM8TD0/b9P8Vg6XCj
	 qEzSHDcEDA7KqG3+j0ifXj4+TAp8sBan4S4weQRy8XFS3ti/zWYmvjY405W+QIo83m
	 VskhRQ3fH0ncFJXTEmLQ5HY1J3AE5Vcq+BuCCarfTjOoFrLEKvryTiePQzw+HnxUVa
	 VlF4oTWtqmF18t2eTUo24X1rBfDwZdPIH3LAx5aDfbSV53RJK/RWMVi4yy9LKHnv54
	 Oi6wR9JKQzhcg==
Message-ID: <sashiko-outbox-178825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/3] dma-fence: Remove RCU protection for
 fence->ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261020100034.759183-3-phasta@kernel.org>
References: <20261020100034.759183-2-phasta@kernel.org>
 <20261020100034.759183-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:20:37 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dma-fence: broken KUnit test_signaling() after keeping fence->op=
s on signal
- [Low] dma-fence: sparse warnings from remaining rcu_access_pointer() on f=
ence->ops
--

commit 4607587506fc5e0428c9d4ca148fc5a0c94b0003
Author: Philipp Stanner <phasta@kernel.org>

dma-fence: Remove RCU protection for fence->ops

This commit removes the RCU protection and __rcu annotation for
struct dma_fence::ops, and stops clearing fence->ops to NULL when
signaling fences without release or wait callbacks.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index bd58688b81a72..5dab647e3f3f9 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -353,7 +353,6 @@ void __dma_fence_might_wait(void)
>  void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>  				      ktime_t timestamp)
>  {
> -	const struct dma_fence_ops *ops;
>  	struct dma_fence_cb *cur, *tmp;
>  	struct list_head cb_list;
> =20
> @@ -365,15 +364,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fe=
nce *fence,
> =20
>  	trace_dma_fence_signaled(fence);
> =20
> -	/*
> -	 * When neither a release nor a wait operation is specified set the ops
> -	 * pointer to NULL to allow the fence structure to become independent
> -	 * from who originally issued it.
> -	 */
> -	ops =3D rcu_dereference_protected(fence->ops, true);
> -	if (!ops->release && !ops->wait)
> -		RCU_INIT_POINTER(fence->ops, NULL);
> -

[Severity: Medium]
Does keeping fence->ops set here break test_signaling() in
drivers/dma-buf/st-dma-fence.c?

In drivers/dma-buf/st-dma-fence.c, test_signaling() (added in commit
3695d754ffbb ("dma-buf/selftests: test RCU ops and inline lock v2"))
creates a mock fence using mock_ops (which defines neither .release nor
.wait), signals it via dma_fence_check_and_signal(), and then checks:

	if (rcu_dereference_protected(f->ops, true)) {
		KUNIT_FAIL(test, "Fence ops not cleared on signal");
		goto err_free;
	}

Since dma_fence_signal_timestamp_locked() no longer clears fence->ops to
NULL, won't this KUnit check unconditionally fail?  Additionally, passing
the non-__rcu f->ops pointer to rcu_dereference_protected() there will
trigger a Sparse address-space warning.

>  	/* Stash the cb_list before replacing it with the timestamp */
>  	list_replace(&fence->cb_list, &cb_list);
> =20

[ ... ]

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3b..874848a4aec46 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -72,7 +72,7 @@ struct dma_fence {
>  		spinlock_t *extern_lock;
>  		spinlock_t inline_lock;
>  	};
> -	const struct dma_fence_ops __rcu *ops;
> +	const struct dma_fence_ops *ops;

[Severity: Low]
Should the remaining rcu_access_pointer(fence->ops) callers in the tree
also be updated now that the __rcu annotation is removed from
struct dma_fence::ops?

While dma_fence_is_array() and dma_fence_is_chain() are updated below,
several other functions converted in commits f4cc3ab824d6, 764f241ad227,
and 7519ba791b00 still wrap fence->ops in rcu_access_pointer(), which
causes Sparse to emit address-space mismatch warnings when building with
C=3D1:

drivers/gpu/drm/drm_crtc.c:fence_to_crtc():
	BUG_ON(rcu_access_pointer(fence->ops) !=3D &drm_crtc_fence_ops);

drivers/gpu/drm/scheduler/sched_fence.c:to_drm_sched_fence():
	if (rcu_access_pointer(f->ops) =3D=3D &drm_sched_fence_ops_scheduled)
		return container_of(f, struct drm_sched_fence, scheduled);

	if (rcu_access_pointer(f->ops) =3D=3D &drm_sched_fence_ops_finished)
		return container_of(f, struct drm_sched_fence, finished);

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:to_amdgpu_amdkfd_fence():
	if (rcu_access_pointer(f->ops) =3D=3D &amdkfd_fence_ops)
		return fence;

drivers/gpu/host1x/fence.c:host1x_fence_extract():
	if (rcu_access_pointer(fence->ops) !=3D &host1x_syncpt_fence_ops)
		return -EINVAL;

>  	/*
>  	 * We clear the callback list on kref_put so that by the time we
>  	 * release the fence it is unused. No one should be adding to the

[ ... ]

> @@ -769,7 +761,7 @@ extern const struct dma_fence_ops dma_fence_chain_ops;
>   */
>  static inline bool dma_fence_is_array(struct dma_fence *fence)
>  {
> -	return rcu_access_pointer(fence->ops) =3D=3D &dma_fence_array_ops;
> +	return fence->ops =3D=3D &dma_fence_array_ops;
>  }
> =20
>  /**
> @@ -780,7 +772,7 @@ static inline bool dma_fence_is_array(struct dma_fenc=
e *fence)
>   */
>  static inline bool dma_fence_is_chain(struct dma_fence *fence)
>  {
> -	return rcu_access_pointer(fence->ops) =3D=3D &dma_fence_chain_ops;
> +	return fence->ops =3D=3D &dma_fence_chain_ops;
>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020100034.7591=
83-2-phasta@kernel.org?part=3D1
