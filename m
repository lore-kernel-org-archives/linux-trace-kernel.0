Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127533DFC94;
	Thu, 25 Jun 2026 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388987; cv=none; b=gwqn7rtRpzv1t0vpB0vco2DW2aiLe2DwKVfLIC2j3tYefmj9MnlvoEocW5lAtRCLlhfZMVzJdsV65EGbyFwuOe8CCmFtvERe20hZ9rS3nWsu4APmz/DsfdNKGtbKrPxwvSVdoA3spBKeDTOBEbedbNfLt5rgLng1HRzpo+zItCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388987; c=relaxed/simple;
	bh=y6pnxycqnS6Yrnhzaa9OthbedQ16hQUMrGp6S/xslXU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QMk6YtrJPBry+BsHTR/PvHbHpPpxZcCogp8IXWPMmkdH1Pdxnhd+Pn+e9dPorlg+pg8JPjfC45Nj1iLiR22gcZA8Nezzp9U+TD1/NrPsCkcYPwr1lodRfFxNfP7DP9lhh2exlZU0ruezIckYrHFOWuikqh3c/p4JJOGAJVc4Shk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pDGoeaE1; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pDGoeaE1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=a4j6eh/6cDVnwatb6KUay56xQddDfixH7xVv0MM7dHQ=;
	b=pDGoeaE1orqaJuUJF3YlL+Vnw287fopT68i+dG6xsA9o5W7Z/5+UeuoCGW+WptLLR4UURY6IL
	xZNK5JwLo+OpKLANAFYGC9as9LVvkWPIpklDpvXfHHJo2ajLvwl+LTek1d3/1AFfaQBZZchBLx7
	820A4Szmx7RopIm47ARiuvw=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gmHJP1w0Cz1prnF;
	Thu, 25 Jun 2026 19:53:41 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 47D4B40537;
	Thu, 25 Jun 2026 20:02:49 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Jun 2026 20:02:49 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Jun 2026 20:02:47 +0800
Subject: Re: [PATCH v9 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
To: Breno Leitao <leitao@debian.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <kernel-team@meta.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>,
	<lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>
References: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
 <20260609-ecc_panic-v9-2-432a74002e74@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ce2757e8-cb90-bf97-866a-b0a094411235@huawei.com>
Date: Thu, 25 Jun 2026 20:02:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260609-ecc_panic-v9-2-432a74002e74@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/9 18:56, Breno Leitao wrote:
> get_any_page() collapses every HWPoisonHandlable() rejection into a
> single -EIO via the __get_hwpoison_page() -> -EBUSY -> shake_page()
> -> retry path.  That is correct for the transient case (a userspace
> folio briefly off LRU during migration or compaction, which a later
> shake can drag back), but wrong for stable kernel-owned pages: slab,
> page-table, large-kmalloc and PG_reserved pages will never become
> HWPoisonHandlable(), so the retry loop is wasted work and the final
> -EIO loses the "this is structurally unrecoverable" information.
> memory_failure() then maps -EIO into MF_MSG_GET_HWPOISON, which the
> panic-on-unrecoverable sysctl deliberately does not act on.
> 
> Introduce HWPoisonKernelOwned(), a small predicate that positively
> identifies pages the hwpoison handler cannot recover from:
> 
>   HWPoisonKernelOwned(p, flags) :=
>       !(MF_SOFT_OFFLINE && page_has_movable_ops(p)) &&
>       (PageReserved(p) ||
>        PageSlab(head) || PageTable(head) || PageLargeKmalloc(head))
> 
>   where head = compound_head(p).
> 
> PG_reserved is a per-page flag (PF_NO_COMPOUND) and is tested on the
> page directly.  The slab, page-table and large-kmalloc page-type bits
> are only stored on the head page, so those tests resolve the compound
> head first, then re-read compound_head(page) afterwards: a concurrent
> split or compound free that moves head invalidates the just-read flags
> and the loop retries.  The lookup still takes no refcount, mirroring
> the rest of get_any_page(); the recheck closes the common split race,
> and a residual free->alloc->free in the same window can only mis-tag
> a genuinely poisoned page, never reclassify a handlable one.
> 
> The MF_SOFT_OFFLINE / page_has_movable_ops() opt-out mirrors the
> same exception in HWPoisonHandlable(): soft-offline is allowed to
> migrate movable_ops pages even though they are not on the LRU, and
> we must not pre-empt that with an unrecoverable verdict.
> 
> The list is intentionally not exhaustive.  vmalloc and kernel-stack
> pages, for example, do not carry a page_type bit and would need a
> different oracle; they keep going through the existing retry path
> unchanged.  This is the smallest set we can identify with certainty
> by page type.
> 
> Wire the helper into the top of get_any_page() to short-circuit
> those pages before the retry loop runs.  On a hit, drop the caller's
> MF_COUNT_INCREASED reference (if any) and return -ENOTRECOVERABLE
> straight away.  Pages outside the helper's positive list still take
> the existing retry path and return -EIO, leaving operator-visible
> behaviour for those cases unchanged.
> 
> Extend the unhandlable-page pr_err() to fire for either errno and
> update the get_hwpoison_page() kerneldoc to document the new return.
> 
> memory_failure() still folds every negative return into
> MF_MSG_GET_HWPOISON via its existing "else if (res < 0)" branch, so
> this patch on its own only changes the errno that soft_offline_page()
> can propagate to its callers.  A follow-up wires -ENOTRECOVERABLE
> through memory_failure() and reports MF_MSG_KERNEL for the
> unrecoverable cases, which is what the
> panic_on_unrecoverable_memory_failure sysctl observes.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/memory-failure.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f4d3e6e20e13..eed9de387694 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1325,6 +1325,46 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>  	return PageLRU(page) || is_free_buddy_page(page);
>  }
>  
> +/*
> + * Positive identification of pages the hwpoison handler cannot recover.
> + * These page types are owned by kernel internals (no userspace mapping
> + * to unmap, no file mapping to invalidate, no migration target), so the
> + * shake_page() / retry loop in get_any_page() can never turn them into
> + * something HWPoisonHandlable() will accept.  Short-circuit them to
> + * -ENOTRECOVERABLE so callers can panic on operator request instead of
> + * spinning through retries that exit as a transient-looking -EIO.
> + *
> + * The MF_SOFT_OFFLINE / page_has_movable_ops() opt-out mirrors
> + * HWPoisonHandlable(): soft-offline is allowed to migrate movable_ops
> + * pages even though they are not on the LRU.
> + */
> +static inline bool HWPoisonKernelOwned(struct page *page, unsigned long flags)
> +{
> +	struct page *head;
> +
> +	if ((flags & MF_SOFT_OFFLINE) && page_has_movable_ops(page))
> +		return false;
> +
> +	/* PG_reserved is a per-page flag, never set on a compound page. */
> +	if (PageReserved(page))
> +		return true;
> +
> +	/*
> +	 * Page-type bits live only on the head page, so resolve any tail
> +	 * first.  The check takes no refcount; recheck the head afterwards
> +	 * so a concurrent split or compound free cannot leave us trusting
> +	 * a stale view.  A free->alloc->free in the same window is still
> +	 * possible but closing it would require taking a reference here.
> +	 */
> +retry:
> +	head = compound_head(page);
> +	if (!(PageSlab(head) || PageTable(head) || PageLargeKmalloc(head)))
> +		return false;
> +	if (head != compound_head(page))
> +		goto retry;

Looks good to me with one comment: should we write above as something like below:

	bool kernel_owned;
retry:
	head = compound_head(page);
	kernel_owned = PageSlab(head) || PageTable(head) || PageLargeKmalloc(head);
	if (head != compound_head(page))
		goto retry;

I.e. we should always check whether compound_head has changed, regardless of whether
the page is owned by the kernel, so we can obtain a relatively stable result?

Thanks.
.

