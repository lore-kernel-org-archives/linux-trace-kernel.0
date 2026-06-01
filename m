Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664A377553;
	Mon,  1 Jun 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316942; cv=none; b=B6haL1cVYjthUxI9izXHVCuukF/aBneDYFXnC8x+QT02x3b83hN2vIXlNIrBpelE+gkoEa2J83BXTG9PCxWC2gnikwdhy+UjIqHyrFpUjy20eq5QOlgGx4qQLIbbp8YuSiSgMI/0M/wRemxrvi6LxjmD1vO8VO+nz/laOqm5ZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316942; c=relaxed/simple;
	bh=cpZgAN/MGy/3NF9gxMObMXDYl8Ge6z4esSx9KnOh0VI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OC+8wRxP1eOObWN9erIDGCm2C0VBB7UKRfvkBCQeFZuf4Yy3cSaMxQfFJNfjPnh3nviSwF45++dLkTtc53VxE0rkeRQo6D3N3PTS0ZRyMbX1Cwr7nMEkAtyiPPYtXie6Cn6qka8Ga/mz3VZ2KPs8yg6FVcVChXl1dee+FerS+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Cnn6g6+O; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Cnn6g6+O"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RHRyrguBPu7WjFl1OHUlddAxvq9NBpFCk9kVGplZSR0=;
	b=Cnn6g6+ODFK5wT4XaBHnaTObdw/QAowqd8m5e/D1t6KdWIMpekWyf/wMlVDUoi/FgBj4WI8sL
	hHTe87/L/JKvtrBfk8gISf7rANXbXLO23ONE0J5rx7EC9zCFKxs9/faVTOqGiV8K+ul03BlKouf
	owJHccQmj/dOTETfgKp3ewE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gTY2c5HP5z1T4GP;
	Mon,  1 Jun 2026 20:20:40 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D9DC4056D;
	Mon,  1 Jun 2026 20:28:49 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jun 2026 20:28:49 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jun 2026 20:28:47 +0800
Subject: Re: [PATCH v8 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
To: Breno Leitao <leitao@debian.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <kernel-team@meta.com>, Lance Yang
	<lance.yang@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan
	<shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Liam R. Howlett"
	<liam@infradead.org>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
 <20260527-ecc_panic-v8-2-9ea0cfa16bb0@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <19f968f5-1289-f573-4406-e5c91dcd8923@huawei.com>
Date: Mon, 1 Jun 2026 20:28:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260527-ecc_panic-v8-2-9ea0cfa16bb0@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/5/27 22:06, Breno Leitao wrote:
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
>       (PageReserved(p) || PageSlab(p) ||
>        PageTable(p)    || PageLargeKmalloc(p))
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

Thanks for your patch.

> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/memory-failure.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f4d3e6e20e13..8f63bdfeff8f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1325,6 +1325,28 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
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
> +	if ((flags & MF_SOFT_OFFLINE) && page_has_movable_ops(page))
> +		return false;
> +
> +	return PageReserved(page) || PageSlab(page) ||

Once shake_page finds a lightweight range-based way to shrink slab, slab pages could be freed
into buddy and above PageSlab test should be removed then. Maybe add a TODO or XXX here?

> +	       PageTable(page) || PageLargeKmalloc(page);

I'm not sure but is it safe or a common way to test PageReserved, PageSlab,
PageTable and PageLargeKmalloc without extra page refcnt?

Apart from the above nits, this patch looks good to me.

Thanks.
.
