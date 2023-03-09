Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEB1C61DA4
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  9 Mar 2023 22:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCIWbU (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCIWbS (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:31:18 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60703FAD58
        for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:31:17 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D11775C004A;
        Thu,  9 Mar 2023 17:31:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 09 Mar 2023 17:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678401075; x=1678487475; bh=Ts
        hmSi4sKyJmYkhUswzIQUoZRQHyDR6KbclhIwMyEgg=; b=TCP5EA/Wi2FgyrFi5R
        IvVjvoRLKfzY33MXGS7Kog63HPW2unY3gqDuauzAdOXoXqQcDFOJm4TQsv8ROraA
        svWdaEOcWwz7SSoH1alyt5yhswUIDB8yf3J/YG42BugpAkz+eGBGo9QRxpTEimKq
        opQinRLp9cAPgqdhxGdGBCBcMch2E4jvZZsJt2vRmJS0k119k1gYVf57oU2VLGYv
        oJb9/yZdrwMoql/PyPw142ERRJ0PSnrCFL0qPxkEPhvrOyief+PDEkmB6YRnx9+6
        weYCiOxmTv9mqGZFvnnTgtx0Iuz/9EwAqQDBvFNVJEj8xfBnlsSOtA5jVcVcd5o8
        aYNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678401075; x=1678487475; bh=TshmSi4sKyJmY
        khUswzIQUoZRQHyDR6KbclhIwMyEgg=; b=suBqbqvgaGc4ea6UnH1NV00k/zOXJ
        ryr3rDwJ8guIiWCpGe1S/T3u6dEleAlmKZrYYOWBnBgcJQ4EKkJ5GcjupJO5mR/7
        Aek2i/I2x/m8VRmFj8nD1aCBCur6ZP8NyWuDmWUwTLcwChgjuqc3x44r0fafaujg
        b9mTq7kpaVeco50V9zh9kKP0NxGSGU2oOW6fmWzurfazKw7WE7qrp/FrAsbeDm6k
        +AZmXkhDk/dJGrSV3BX37icxlEHQF0ukKAI+8ivDCKXqWj1tRpD5E7Qpb2pGvfFp
        5/9tAXljEz385X8AVtJy9CTIh/V+zVbj2Z5kRqjFj9hFX/xuVZCUZKXhA==
X-ME-Sender: <xms:M14KZAQS0nklDkba9OVLjEGNJoeNzBP-l_Jy-tkFX1eOz45a6XqP0Q>
    <xme:M14KZNxfR_Z5g9twtRalzfN3WcTs3bi12K_szv_Ck3aBbg7N_QyedOcGUbMr1mcOu
    1OD_O1pQC1qStBdGb8>
X-ME-Received: <xmr:M14KZN3Qsxqlt2VZNVZztS1G8HgeM3amKIAb7m0Xx-zWiNv7mfc6QyYSADLq95qVHJmMoLUhXsqzpAOBG81KNTejkWaP0lQgj-7T3pGV7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduiedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:M14KZEDo1WKeh_LbMOpFXShIk6NR_d4D6eTcrNHgf0X6k5fFpWe8gw>
    <xmx:M14KZJgnARv0nmptXlY2tmE-i2hVR7gAi903vjpWHLfhAOeforv0Mg>
    <xmx:M14KZAoIF1qu5u4VVaSAFlWy7WobCE4fEIZM84YKyijwUYuI9FPoSg>
    <xmx:M14KZOukEDCgQCTGlaRcuShQlL4V-_bg-nuygOzdWiXP6F6CkU7rJw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Mar 2023 17:31:14 -0500 (EST)
References: <20230210214645.2720847-1-shr@devkernel.io>
 <20230309172726.14fca32e@gandalf.local.home>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v1] mm: add tracepoints to ksm
Date:   Thu, 09 Mar 2023 14:30:34 -0800
In-reply-to: <20230309172726.14fca32e@gandalf.local.home>
Message-ID: <qvqwedpxo8up.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 10 Feb 2023 13:46:45 -0800
> Stefan Roesch <shr@devkernel.io> wrote:
>
> Sorry for the late reply, I just noticed this (I had the flu when this was
> originally sent).
>
>> +/**
>> + * ksm_remove_ksm_page - called after a ksm page has been removed
>> + *
>> + * @pfn:		page frame number of ksm page
>> + *
>> + * Allows to trace the removing of stable ksm pages.
>> + */
>> +TRACE_EVENT(ksm_remove_ksm_page,
>> +
>> +	TP_PROTO(unsigned long pfn),
>> +
>> +	TP_ARGS(pfn),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, pfn)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->pfn = pfn;
>> +	),
>> +
>> +	TP_printk("pfn %lu", __entry->pfn)
>> +);
>> +
>> +/**
>> + * ksm_remove_rmap_item - called after a rmap_item has been removed from the
>> + *                        stable tree
>> + *
>> + * @pfn:		page frame number of ksm page
>> + * @rmap_item:		address of rmap_item  object
>> + * @mm:			address of the process mm struct
>> + *
>> + * Allows to trace the removal of pages from the stable tree list.
>> + */
>> +TRACE_EVENT(ksm_remove_rmap_item,
>> +
>> +	TP_PROTO(unsigned long pfn, void *rmap_item, void *mm),
>> +
>> +	TP_ARGS(pfn, rmap_item, mm),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long,	pfn)
>> +		__field(void *,		rmap_item)
>> +		__field(void *,		mm)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->pfn		= pfn;
>> +		__entry->rmap_item	= rmap_item;
>> +		__entry->mm		= mm;
>> +	),
>> +
>> +	TP_printk("pfn %lu rmap_item %p mm %p",
>> +			__entry->pfn, __entry->rmap_item, __entry->mm)
>> +);
>> +
>> +#endif /* _TRACE_KSM_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 56808e3bfd19..4356af760735 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -45,6 +45,9 @@
>>  #include "internal.h"
>>  #include "mm_slot.h"
>>
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/ksm.h>
>> +
>>  #ifdef CONFIG_NUMA
>>  #define NUMA(x)		(x)
>>  #define DO_NUMA(x)	do { (x); } while (0)
>> @@ -655,10 +658,12 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
>>  	BUG_ON(stable_node->rmap_hlist_len < 0);
>>
>>  	hlist_for_each_entry(rmap_item, &stable_node->hlist, hlist) {
>> -		if (rmap_item->hlist.next)
>> +		if (rmap_item->hlist.next) {
>>  			ksm_pages_sharing--;
>> -		else
>> +			trace_ksm_remove_rmap_item(stable_node->kpfn, rmap_item, rmap_item->mm);
>
> Instead of dereferencing the stable_node here, where the work could
> possibly happen outside the trace event and in the hot path, could you pass
> in the stable_node instead, and then in the TP_fast_assign() do:
>
> 		__entry->pfn = stable_node->kpfn;
>
>

I'll make the change in the next version.

>> +		} else {
>>  			ksm_pages_shared--;
>> +		}
>>
>>  		rmap_item->mm->ksm_merging_pages--;
>>
>> @@ -679,6 +684,7 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
>>  	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD <= &migrate_nodes);
>>  	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD >= &migrate_nodes + 1);
>>
>> +	trace_ksm_remove_ksm_page(stable_node->kpfn);
>
> Here too?
>
> -- Steve
>

I'll make the change in the next version.

>>  	if (stable_node->head == &migrate_nodes)
>>  		list_del(&stable_node->list);
>>  	else
>> @@ -1367,6 +1373,8 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
>>  	get_anon_vma(vma->anon_vma);
>>  out:
>>  	mmap_read_unlock(mm);
>> +	trace_ksm_merge_with_ksm_page(kpage, page_to_pfn(kpage ? kpage : page),
>> +				rmap_item, mm, err);
>>  	return err;
>>  }
>>
>> @@ -2114,6 +2122,9 @@ static int try_to_merge_with_kernel_zero_page(struct ksm_rmap_item *rmap_item,
>>  		if (vma) {
>>  			err = try_to_merge_one_page(vma, page,
>>  						ZERO_PAGE(rmap_item->address));
>> +			trace_ksm_merge_one_page(
>> +				page_to_pfn(ZERO_PAGE(rmap_item->address)),
>> +				rmap_item, mm, err);
>>  			if (!err) {
>>  				rmap_item->address |= ZERO_PAGE_FLAG;
>>  				ksm_zero_pages_sharing++;
>> @@ -2344,6 +2355,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>
>>  	mm_slot = ksm_scan.mm_slot;
>>  	if (mm_slot == &ksm_mm_head) {
>> +		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
>> +
>>  		/*
>>  		 * A number of pages can hang around indefinitely on per-cpu
>>  		 * pagevecs, raised page count preventing write_protect_page
>> @@ -2510,6 +2523,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>  	if (mm_slot != &ksm_mm_head)
>>  		goto next_mm;
>>
>> +	trace_ksm_stop_scan(ksm_scan.seqnr, ksm_rmap_items);
>>  	ksm_scan.seqnr++;
>>  	return NULL;
>>  }
>> @@ -2661,6 +2675,7 @@ int __ksm_enter(struct mm_struct *mm)
>>  	if (needs_wakeup)
>>  		wake_up_interruptible(&ksm_thread_wait);
>>
>> +	trace_ksm_enter(mm);
>>  	return 0;
>>  }
>>
>> @@ -2702,6 +2717,8 @@ void __ksm_exit(struct mm_struct *mm)
>>  		mmap_write_lock(mm);
>>  		mmap_write_unlock(mm);
>>  	}
>> +
>> +	trace_ksm_exit(mm);
>>  }
>>
>>  struct page *ksm_might_need_to_copy(struct page *page,
>>
>> base-commit: 234a68e24b120b98875a8b6e17a9dead277be16a
