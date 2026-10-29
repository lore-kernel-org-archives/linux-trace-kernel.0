Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284722;
	b=1BmSzoV+O2S8szuOMUFPxIWozkcQYpdsLHkFxIPBlPHirUnCdKbt4pPQZf/GU06Xr6jh
	 x0nJGvIMBk4TkUrUQ7xSfyWfc/rNXK7F24qpdCMj7pCUY6ufXCnT+Kschhhx0Xmaz8tBM
	 MK5Tgvox4p+CEJ7vpIqv4ea4sz/AurVvPmz8pHvk5Ze/nB3KCaNU9SwRIH5JjzgFOzYa5
	 L+UHAR4JZIca6sqD1qVsT672SnQYz3VD+J8J2m3amgiKRsjoasLfi8nTZA8X9QOVAWX/d
	 drBlYR/YzmHyOCe44g3ApJNJHEXOqhs6u+sZro3a8JdrqkSRdfIzs4u9JGW2LQw/yfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284722;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=kdXpmkBhMAK74pROhWSEfTONYpMVZJ5lVF9TFJipLls=;
	b=5Di8yoVXZauoQ8qTjpqwb8eRa4lEYUwn1K3i3HaKQshrYuamk9+R8drNuY1ci1MaQJwh
	 SE5TSA4XHTcWpULVIOXNHuVtf0RoAf7Af7Jj3HwO4B0O5oZYsNxTeAS6OViklrr2ErOTV
	 iYSZskO7plsQLC7xD5ikU/gI0hHIOUAMOiIguXYr9CS0yBGVo7jdWvQqUlRbZ+m1Wf47n
	 lvjdEa30EIBgO1+yqZEy40MoyhtLsVIr61BFYzoK1qQF9zCVL7G/KW2wK9Or01KKIa7Xa
	 a9QOgtRD5ACJlY5YuHFnyC6cUBCHJ3hA3a2ItV2BCkOgJN1lpGJqWfwVEc70ysBEwsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ufSkkCjl;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC2606A31A;
	Thu, 29 Oct 2026 14:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77CC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ufSkkCjl
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1BB668040E;
	Thu, 29 Oct 2026 14:38:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 2CC5920019;
	Thu, 29 Oct 2026 14:38:36 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:38:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xuewen Wang <wangxuewen@kylinos.cn>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/shmem: trace folio allocation failures and
 fallbacks
Message-ID: <20261029103834.4bc0590e@gandalf.local.home>
In-Reply-To: <20261027094014.2432692-3-wangxuewen@kylinos.cn>
References: <20261027094014.2432692-1-wangxuewen@kylinos.cn>
	<20261027094014.2432692-3-wangxuewen@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 2CC5920019
X-Stat-Signature: kzaet8p8c9fc6h4ufwot3syknsqxr7z4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aAztWkxPEcjua6oz1ZqFSlorTCJ0OwKc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kdXpmkBhMAK74pROhWSEfTONYpMVZJ5lVF9TFJipLls=; b=ufSkkCjlfNP9TMCaTQ5duHM8TE4sa2IissI/2N3n/eI2CnhbZJiumxL0lkKXroa++JMdjmP1F/PKGSTLbWgDPPiYopUe2MRpwj4fsdMI4BriLroiFSdoNIuo4IpFpjDuUdwzA57HJgdZj2k35mSP0xliRczDc6bCmuLHIqVoeDE=
X-HE-Tag: 1793284716-35837
X-HE-Meta: U2FsdGVkX18Lv1U7yfNvg+lCzii0gA9RfshonfQvqAVbrtg+l1UbzKEOxHFwS3dQ/rmXqhL5riN11QIoOQCpYQN8Gc0vAAZ6maHy8pkQDCaLmjiIFhJy9hABR2SOFW2P5ElomrkwMZ8FLS1UVt+KupuTCYphJPYU6lz9zRaBGeJahRNY8SsxiHQCLq+PBpfQyIvl/XU+mzGuG9yNrF/sy3aJ7iy8ihwnZquOCxWO87fD0HMPjdZSpb5lUsiwLlLGW1ozDA7QuhYdSbMFT5txY+N2ZWH65Oy+PbwofBFquiIHVvEcnSIxIF5qg6MXJfpB

On Tue, 27 Oct 2026 17:40:14 +0800
Xuewen Wang <wangxuewen@kylinos.cn> wrote:

> index 7a0050a1686f..72b20d6b3caf 100644
> --- a/include/trace/events/shmem.h
> +++ b/include/trace/events/shmem.h
> @@ -80,6 +80,61 @@ TRACE_EVENT(shmem_swapin_folio,
>  		  __entry->fallback_error, __entry->error)
>  );
>  
> +#define SHMEM_ALLOC_ALLOC	0
> +#define SHMEM_ALLOC_CHARGE	1
> +#define SHMEM_ALLOC_CACHE		2
> +#define SHMEM_ALLOC_ACCOUNT	3
> +#define SHMEM_ALLOC_DONE		4
> +#define SHMEM_ALLOC_FILTER	5
> +
> +TRACE_EVENT(shmem_alloc_folio_finish,
> +
> +	TP_PROTO(struct inode *inode, pgoff_t index,
> +		 int requested_order, int suitable_order, int actual_order,
> +		 unsigned int stage, int error, int ret),
> +
> +	TP_ARGS(inode, index, requested_order, suitable_order, actual_order,
> +		stage, error, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(unsigned long, ino)
> +		__field(unsigned long, index)

Same here. Move dev to after index.

-- Steve


> +		__field(int, requested_order)
> +		__field(int, suitable_order)
> +		__field(int, actual_order)
> +		__field(unsigned int, stage)
> +		__field(int, error)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev = inode->i_sb->s_dev;
> +		__entry->ino = inode->i_ino;
> +		__entry->index = index;
> +		__entry->requested_order = requested_order;
> +		__entry->suitable_order = suitable_order;
> +		__entry->actual_order = actual_order;
> +		__entry->stage = stage;
> +		__entry->error = error;
> +		__entry->ret = ret;
> +	),
> +
> +	TP_printk("dev=%d:%d ino=%lu index=%lu requested_order=%d suitable_order=%d actual_order=%d stage=%s error=%d ret=%d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino, __entry->index,
> +		  __entry->requested_order, __entry->suitable_order,
> +		  __entry->actual_order,
> +		  __print_symbolic(__entry->stage,
> +				   { SHMEM_ALLOC_ALLOC, "alloc" },
> +				   { SHMEM_ALLOC_CHARGE, "charge" },
> +				   { SHMEM_ALLOC_CACHE, "cache" },
> +				   { SHMEM_ALLOC_ACCOUNT, "account" },
> +				   { SHMEM_ALLOC_DONE, "done" },
> +				   { SHMEM_ALLOC_FILTER, "filter" }),
> +		  __entry->error, __entry->ret)
> +);
> +
>  #endif /* _TRACE_SHMEM_H */
>  
>  /* This part must be outside protection */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 3b910aec5bcf..68321d61dfdb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2155,17 +2155,23 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>  	unsigned long suitable_orders = 0;
>  	struct folio *folio = NULL;
>  	pgoff_t aligned_index;
> +	pgoff_t orig_index = index;
>  	long pages;
>  	int error, order;
> +	int requested_order, suitable_order;
> +	int charge_error = 0;
> +	unsigned int stage;
>  
>  	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>  		orders = 0;
>  
> +	requested_order = orders ? highest_order(orders) : 0;
>  	if (orders > 0) {
>  		suitable_orders = shmem_suitable_orders(inode, vmf,
>  							mapping, index, orders);
>  
>  		order = highest_order(suitable_orders);
> +		suitable_order = order;
>  		while (suitable_orders) {
>  			pages = 1UL << order;
>  			aligned_index = round_down(index, pages);
> @@ -2181,19 +2187,35 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>  			order = next_order(&suitable_orders, order);
>  		}
>  	} else {
> +		suitable_order = 0;
>  		pages = 1;
>  		folio = shmem_alloc_folio(gfp, 0, info, index);
>  	}
> -	if (!folio)
> +	if (!folio) {
> +		if (suitable_order < 0)
> +			trace_shmem_alloc_folio_finish(inode, orig_index,
> +						       requested_order,
> +						       suitable_order, -1,
> +						       SHMEM_ALLOC_FILTER, 0,
> +						       -ENOMEM);
> +		else
> +			trace_shmem_alloc_folio_finish(inode, orig_index,
> +						       requested_order,
> +						       suitable_order, -1,
> +						       SHMEM_ALLOC_ALLOC, -ENOMEM,
> +						       -ENOMEM);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  allocated:
>  	__folio_set_locked(folio);
>  	__folio_set_swapbacked(folio);
>  
>  	gfp &= GFP_RECLAIM_MASK;
> +	stage = SHMEM_ALLOC_CHARGE;
>  	error = mem_cgroup_charge(folio, fault_mm, gfp);
>  	if (error) {
> +		charge_error = error;
>  		if (xa_find(&mapping->i_pages, &index,
>  				index + pages - 1, XA_PRESENT)) {
>  			error = -EEXIST;
> @@ -2208,10 +2230,12 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>  		goto unlock;
>  	}
>  
> +	stage = SHMEM_ALLOC_CACHE;
>  	error = shmem_add_to_page_cache(folio, mapping, index, NULL, gfp);
>  	if (error)
>  		goto unlock;
>  
> +	stage = SHMEM_ALLOC_ACCOUNT;
>  	error = shmem_inode_acct_blocks(inode, pages);
>  	if (error) {
>  		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> @@ -2242,9 +2266,17 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>  
>  	shmem_recalc_inode(inode, pages, 0);
>  	folio_add_lru(folio);
> +	if (folio_order(folio) < requested_order)
> +		trace_shmem_alloc_folio_finish(inode, orig_index,
> +					       requested_order, suitable_order,
> +					       folio_order(folio),
> +					       SHMEM_ALLOC_DONE, 0, 0);
>  	return folio;
>  
>  unlock:
> +	trace_shmem_alloc_folio_finish(inode, orig_index, requested_order,
> +				       suitable_order, folio_order(folio), stage,
> +				       charge_error ?: error, error);
>  	folio_unlock(folio);
>  	folio_put(folio);
>  	return ERR_PTR(error);

