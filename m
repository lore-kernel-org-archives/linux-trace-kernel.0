Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866929AB05;
	Mon,  6 Jul 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340542; cv=none; b=tmoYMW9+C4GWzRhwBGsP2cazGYYLQNJK5NHaS+LPv94+qnW03iyVpdqZQnln9j3E2LKvi/9C9QT+MQ7iVPGnzR/lkA82+JOtpH/s118/GbkNwaM3qEFooaHS09m3MECOMW6J1rkKogtsoFejDcfcYLnSdcCupr0QzTxtnfYqQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340542; c=relaxed/simple;
	bh=LCvKrUyihnFS4hob/L7N3B0mtCrPOVsnb9cK/e8JCi8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l4HSjnaXU2lR4ReZNMEQtgvdbo9e8+TwgPMKcy+kaRZpSkKnG2UZZm9aXa5JeezIvdaXJL22ypMt9cC2S9scMOgghJm50APTEgLdRU3RbiPLy09nqW/oaOlgOOcW3olS07tIubpX+wtQgGHPRvGvtquPplgh+3v53iGMfzUNu40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ao6wcOs8; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ao6wcOs8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FqwiknrRupuJ+YbQZhTDPFtrox28ElGL/EoIq2WfmbY=;
	b=ao6wcOs8Q5O0NVhjycbAW1PzuYgJP4S9ueRwTqolkKu7NjzVYtgU476ZL2YoTz0GZ5CYUG9hW
	q3AhbPYdUrsp0tNVvxM+DIUtCw7piYh62hyoJk4gJwHwEkAjpB4nlSbIveM55jgeWUnNVqe9Xdg
	1IY7cu9UXDg/xwQ3nqpH2MA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gv3Cw5ZCKz1T4Fk;
	Mon,  6 Jul 2026 20:13:16 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C382A40561;
	Mon,  6 Jul 2026 20:22:14 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jul 2026 20:22:14 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jul 2026 20:22:13 +0800
Subject: Re: [PATCH v10 2/6] mm/memory-failure: surface unhandlable kernel
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
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
 <20260630-ecc_panic-v10-2-c6ed5b62eea2@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <157b0e23-9f1e-1af2-bb44-44f1f2cab8a5@huawei.com>
Date: Mon, 6 Jul 2026 20:22:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260630-ecc_panic-v10-2-c6ed5b62eea2@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/30 20:46, Breno Leitao wrote:
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
> Introduce is_kernel_owned_page(), a small predicate that positively
> identifies pages the hwpoison handler cannot recover from:
> 
>   is_kernel_owned_page(p) :=
>       PageReserved(p) ||
>       PageSlab(head) || PageTable(head) || PageLargeKmalloc(head)
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
> No MF_SOFT_OFFLINE / page_has_movable_ops() opt-out is needed: a
> movable_ops page is always PageOffline or PageZsmalloc, whose
> page_type is mutually exclusive with slab, page-table and
> large-kmalloc, and it never carries PG_reserved, so it can never
> match any of the checks above.
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
>  mm/memory-failure.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f4d3e6e20e13f..087658484e242 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1325,6 +1325,38 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>  	return PageLRU(page) || is_free_buddy_page(page);
>  }
>  
> +/*
> + * Positive identification of pages the hwpoison handler cannot recover:
> + * pages owned by kernel internals with no userspace mapping to unmap, no
> + * file mapping to invalidate, and no migration target.
> + */
> +static inline bool is_kernel_owned_page(struct page *page)
> +{
> +	struct page *head;
> +	bool kernel_owned;
> +
> +	/* PG_reserved is a per-page flag, never set on a compound page. */
> +	if (PageReserved(page))
> +		return true;
> +
> +	/*
> +	 * Page-type bits live only on the head page, so resolve any tail
> +	 * first.  The check takes no refcount; recheck the head afterwards
> +	 * so a concurrent split or compound free cannot leave us trusting
> +	 * a stale view.  A residual free->alloc->free cannot be closed here
> +	 * (frozen slab and large-kmalloc pages cannot be pinned), but is
> +	 * harmless: where a wrong verdict could panic, memory_failure() has
> +	 * already set PageHWPoison, which bars the page from the allocator.
> +	 */
> +retry:
> +	head = compound_head(page);

It's irrelevant to this issue but should we use folio?
Anyway, this patch looks good to me.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

