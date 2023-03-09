Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E49C64EC4
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  9 Mar 2023 22:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCIW1c (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCIW1c (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:27:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB08A394
        for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:27:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6DE61CD8
        for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Mar 2023 22:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A0C433D2;
        Thu,  9 Mar 2023 22:27:28 +0000 (UTC)
Date:   Thu, 9 Mar 2023 17:27:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v1] mm: add tracepoints to ksm
Message-ID: <20230309172726.14fca32e@gandalf.local.home>
In-Reply-To: <20230210214645.2720847-1-shr@devkernel.io>
References: <20230210214645.2720847-1-shr@devkernel.io>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 10 Feb 2023 13:46:45 -0800
Stefan Roesch <shr@devkernel.io> wrote:

Sorry for the late reply, I just noticed this (I had the flu when this was
originally sent).

> +/**
> + * ksm_remove_ksm_page - called after a ksm page has been removed
> + *
> + * @pfn:		page frame number of ksm page
> + *
> + * Allows to trace the removing of stable ksm pages.
> + */
> +TRACE_EVENT(ksm_remove_ksm_page,
> +
> +	TP_PROTO(unsigned long pfn),
> +
> +	TP_ARGS(pfn),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, pfn)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pfn = pfn;
> +	),
> +
> +	TP_printk("pfn %lu", __entry->pfn)
> +);
> +
> +/**
> + * ksm_remove_rmap_item - called after a rmap_item has been removed from the
> + *                        stable tree
> + *
> + * @pfn:		page frame number of ksm page
> + * @rmap_item:		address of rmap_item  object
> + * @mm:			address of the process mm struct
> + *
> + * Allows to trace the removal of pages from the stable tree list.
> + */
> +TRACE_EVENT(ksm_remove_rmap_item,
> +
> +	TP_PROTO(unsigned long pfn, void *rmap_item, void *mm),
> +
> +	TP_ARGS(pfn, rmap_item, mm),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long,	pfn)
> +		__field(void *,		rmap_item)
> +		__field(void *,		mm)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pfn		= pfn;
> +		__entry->rmap_item	= rmap_item;
> +		__entry->mm		= mm;
> +	),
> +
> +	TP_printk("pfn %lu rmap_item %p mm %p",
> +			__entry->pfn, __entry->rmap_item, __entry->mm)
> +);
> +
> +#endif /* _TRACE_KSM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 56808e3bfd19..4356af760735 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -45,6 +45,9 @@
>  #include "internal.h"
>  #include "mm_slot.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/ksm.h>
> +
>  #ifdef CONFIG_NUMA
>  #define NUMA(x)		(x)
>  #define DO_NUMA(x)	do { (x); } while (0)
> @@ -655,10 +658,12 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
>  	BUG_ON(stable_node->rmap_hlist_len < 0);
>  
>  	hlist_for_each_entry(rmap_item, &stable_node->hlist, hlist) {
> -		if (rmap_item->hlist.next)
> +		if (rmap_item->hlist.next) {
>  			ksm_pages_sharing--;
> -		else
> +			trace_ksm_remove_rmap_item(stable_node->kpfn, rmap_item, rmap_item->mm);

Instead of dereferencing the stable_node here, where the work could
possibly happen outside the trace event and in the hot path, could you pass
in the stable_node instead, and then in the TP_fast_assign() do:

		__entry->pfn = stable_node->kpfn;


> +		} else {
>  			ksm_pages_shared--;
> +		}
>  
>  		rmap_item->mm->ksm_merging_pages--;
>  
> @@ -679,6 +684,7 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
>  	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD <= &migrate_nodes);
>  	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD >= &migrate_nodes + 1);
>  
> +	trace_ksm_remove_ksm_page(stable_node->kpfn);

Here too?

-- Steve

>  	if (stable_node->head == &migrate_nodes)
>  		list_del(&stable_node->list);
>  	else
> @@ -1367,6 +1373,8 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
>  	get_anon_vma(vma->anon_vma);
>  out:
>  	mmap_read_unlock(mm);
> +	trace_ksm_merge_with_ksm_page(kpage, page_to_pfn(kpage ? kpage : page),
> +				rmap_item, mm, err);
>  	return err;
>  }
>  
> @@ -2114,6 +2122,9 @@ static int try_to_merge_with_kernel_zero_page(struct ksm_rmap_item *rmap_item,
>  		if (vma) {
>  			err = try_to_merge_one_page(vma, page,
>  						ZERO_PAGE(rmap_item->address));
> +			trace_ksm_merge_one_page(
> +				page_to_pfn(ZERO_PAGE(rmap_item->address)),
> +				rmap_item, mm, err);
>  			if (!err) {
>  				rmap_item->address |= ZERO_PAGE_FLAG;
>  				ksm_zero_pages_sharing++;
> @@ -2344,6 +2355,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  
>  	mm_slot = ksm_scan.mm_slot;
>  	if (mm_slot == &ksm_mm_head) {
> +		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
> +
>  		/*
>  		 * A number of pages can hang around indefinitely on per-cpu
>  		 * pagevecs, raised page count preventing write_protect_page
> @@ -2510,6 +2523,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  	if (mm_slot != &ksm_mm_head)
>  		goto next_mm;
>  
> +	trace_ksm_stop_scan(ksm_scan.seqnr, ksm_rmap_items);
>  	ksm_scan.seqnr++;
>  	return NULL;
>  }
> @@ -2661,6 +2675,7 @@ int __ksm_enter(struct mm_struct *mm)
>  	if (needs_wakeup)
>  		wake_up_interruptible(&ksm_thread_wait);
>  
> +	trace_ksm_enter(mm);
>  	return 0;
>  }
>  
> @@ -2702,6 +2717,8 @@ void __ksm_exit(struct mm_struct *mm)
>  		mmap_write_lock(mm);
>  		mmap_write_unlock(mm);
>  	}
> +
> +	trace_ksm_exit(mm);
>  }
>  
>  struct page *ksm_might_need_to_copy(struct page *page,
> 
> base-commit: 234a68e24b120b98875a8b6e17a9dead277be16a

