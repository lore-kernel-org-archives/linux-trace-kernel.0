Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191873;
	b=a2bY9sn7QHTCV9C+bGsnH8CD8Agu565m7EK7RR6Dor2dm2T2GrhWGi5eQpVBdIfp8lWW
	 iR7BTbVsJTuqb81h2Enir2yMMmtOclYQlcY+VLHUaC0Z2J8MTgInXVOiwkZ0GReMt9jtc
	 iAmj/EfgG1pvoXVg/N5CXHZTgxjk7FsPUMqqVJo5+rXCWHgdbb2pr+n5aqRzY/L4lydnu
	 +96xx7h17PnsnJ6LMB7yYee9XgFW2QxH6wwn4lQ5VI5toGdSfXz/Y6nI02WenkShdxjCT
	 cafdYNNj0qilSOCWyY1nLs5fuYKHGzI6wr0ZarvjxnypO0GCneaUarQ8OwoEpJIv8CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191873;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AEGX0/KL7mXbSaJY8zHxrw7A5L4IFOgbizn++kyw2IE=;
	b=Su6OUxJKshNKpAUL4+lO+jRVTQ5thTunRGqPHga6+ViaElRQ0rJ7PB64P3Z5b6s59KDi
	 Ng5asvrDmYLxfz8AGApKx8gHG4Pzw21c25buMx7eRT95Npcl3m8clkgVB8FVUUpPlaHfU
	 +u4dL+3qZEUCugwt21xOFKIDRovAKWJcc2W9KRRkT2yHnV0KHFZOhQB1+MANw6BT7iK6Z
	 c3FGEDeBHb67GWOZgR1Hb9Q1+mosSC/HtQwx6F9GiNuJnQ/rGaOj751teKXb3gvOCYiR6
	 al7zUtkht9fVJ36neH1E4ClyTYHmc+lbJXJ39DuH7QYLVd5U7WZywfQmZ02Xd6Eb1aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XL2WHWTD;
	arc=none smtp.remote-ip=95.215.58.47
Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E276606A331
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 02:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E276606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XL2WHWTD
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BSLLWUjqysUniWqaKos+1oTfbUDYuJJnNJuIc0pgFwo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794191871; v=1; x=1794796671;
 b=XL2WHWTDldq8dc4J+S5VCwQikjlgRsEG8sCdf/g6J4yLzejet5DgbiFD8IVyo9je8po4cF2p
 Jw0384EKoWqB18dC453JHT0pAHeiO2yXJCNMIF2qCFTC5OabTZPbEg7Hh2R6YOb90xpbTCYbOwD
 wx+r2xZlOW1wCBc0dsFb6yJU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d646f8317d3d17bd;
	Mon, 09 Nov 2026 02:37:50 +0000
X-Mizu-Trace-ID: d646f8317d3d17bd
X-Migadu-Flow: FLOW_OUT
Message-ID: <16b5464d-d4a2-420e-9de0-2ccddb860e3b@linux.dev>
Date: Mon, 9 Nov 2026 10:37:34 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-mm@kvack.org,
 James.Bottomley@HansenPartnership.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
 will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com,
 robin.murphy@arm.com, mason@kernel.org, aesteve@redhat.com,
 tjmercier@google.com, harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn,
 media-ci@linuxtv.org
Subject: Re: [PATCH 6/7] io_uring: account the ring context and SQPOLL thread
 data to memcg
To: sashiko-reviews@lists.linux.dev, akpm@linux-foundation.org,
 dgilbert@interlog.com, mkp@kernel.org, loberman@redhat.com,
 jmeneghi@redhat.com, kraxel@redhat.com, vivek.kasireddy@intel.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, rostedt@goodmis.org,
 vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca,
 kevin.tian@intel.com, axboe@kernel.dk
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-7-cui.tao@linux.dev>
 <sashiko-outbox-202923@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <sashiko-outbox-202923@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

在 2026/11/7 21:27, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] io_uring: commit message omits rsrc and tctx changes and
>   uncharged allocs
Thanks for catching this.

You're right that the changelog should better match the actual changes.
Besides io_ring_ctx and io_sq_data, this patch also switches the
allocations in io_coalesce_buffer(), io_init_wq_offload(), and
io_uring_alloc_task_context() to GFP_KERNEL_ACCOUNT.  I'll mention
those explicitly in v2.

You're also right that "the last per-ring allocations" overstates the
current state.  Patch 7 still leaves some infrastructure allocations,
such as the percpu pieces and the io-wq cpumask, unchanged.  I'll drop
that wording and instead describe what this patch accounts and what
remains.

As for commits 075d5837bafc and 0b34e7b20a48, this series is based on
linux-next (next-20261104), which already includes the
io_uring-7.4-20261029 tag containing those commits.  If the review is
performed against a tree without that tag, those objects will indeed
still appear uncharged.

Thanks,
Tao
> --
> 
> commit 3d47975c4208930279f98824279734ca99b5e9bd
> Author: Tao Cui <cuitao@kylinos.cn>
> 
>> io_uring: account the ring context and SQPOLL thread data to memcg
>>
>> The io_ring_ctx and the SQPOLL io_sqd are the last per-ring allocations
>> made with plain GFP_KERNEL.  The larger surfaces around them are
>> already charged: io_mapped_ubuf and io_rsrc_node since commit
>> 075d5837bafc ("io_uring/rsrc: charge buffer arrays and nodes to memcg"),
>> the tctx node and its XArrays since commit 0b34e7b20a48 ("io_uring:
>> charge tctx nodes and personalities").
>>
>> Charge the context and the SQPOLL thread data the same way.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> [Severity: Low]
> Does the commit message match the actual changes and current tree state?
> 
> Alongside io_ring_ctx and io_sq_data, the patch also switches new_array in
> io_coalesce_buffer(), ctx->hash_map in io_init_wq_offload(), and
> io_uring_task in io_uring_alloc_task_context() to GFP_KERNEL_ACCOUNT without
> mentioning them in the subject or changelog.
> 
> The changelog also says these are the last per-ring GFP_KERNEL allocations.
> While commit "io_uring: account the remaining per-object allocations to
> memcg" later in the series converts io_alloc_cache_init() and io_wq_create(),
> percpu_ref_init(&ctx->refs, ...) in io_ring_ctx_alloc(),
> percpu_counter_init(&tctx->inflight, ...) in io_uring_alloc_task_context(),
> and alloc_cpumask_var(&wq->cpu_mask, ...) in io_wq_create() still use plain
> GFP_KERNEL.
> 
> Finally, the cited commits 075d5837bafc ("io_uring/rsrc: charge buffer
> arrays and nodes to memcg") and 0b34e7b20a48 ("io_uring: charge tctx nodes
> and personalities") are not present in the base tree, so io_alloc_imu(),
> io_rsrc_node_alloc(), io_tctx_install_node(), tctx->xa, and
> ctx->personalities remain uncharged.
> 

