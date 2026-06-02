Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF3383986
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420962; cv=none; b=Eu6TBRWPCMBZPiQOaGGRkUNBvZwgV/IIEw3FKx3d9/0F0SMTxlXzT9TAVs3geIKWvmeGwCKSygHrNuYZTCOaIC5d6jf5y67fPnhJTRIng5NbLRZc2b7YECxTSk6CAqq4ntJgIWapHqOXTDUsHeqAGYpYj92pu/CR0OGfo+P75kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420962; c=relaxed/simple;
	bh=zOcgH7aInPc9DuePjHuqW3JgCKzVQGrRE6ifX6caW7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kt6IxCATrz3DaGi8cFYZzXeuUoPB7Ge6TiqhS1JpoY1L7YashcOZd4B780n7XZnteVPeh18wW2ozjDVpESi+OKtcvtoHap9SNl4POVQeO4SAye6aTx8N8ec2TO3rGaQwzvG3ClLbgqbuQjEeQtlSTgYvwDJlcIF1dxPaaqbK9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTtnjxuy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTtnjxuy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780420958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxVSpoXcqWMDSv7EE6VMZFwvrzt1MkGFJIAnUJakhK8=;
	b=gTtnjxuy1CI8mMuo1r/f6kbaXVgPgQZyOfekLa18Ky1k37CE+z2ZWEwDL7h25gRUkPMmo1
	XIO2O0ouNbMCori8fFqFz+fLZ8I/MAQn+CV56+2S1iFMuIspurDh9u50ABzSIA6ROuUtUO
	fehFjjRRTWpdWxeMnDsRoXk36Ud/KOk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-bFSuFGBNPlSaK9GkJ2yf0g-1; Tue, 02 Jun 2026 13:22:36 -0400
X-MC-Unique: bFSuFGBNPlSaK9GkJ2yf0g-1
X-Mimecast-MFC-AGG-ID: bFSuFGBNPlSaK9GkJ2yf0g_1780420955
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ae4d89e2so16624865e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420955; x=1781025755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxVSpoXcqWMDSv7EE6VMZFwvrzt1MkGFJIAnUJakhK8=;
        b=jD9xJbDmLkpl7EEteFnH+rSOzuhEyc55ild2orwyA72wMWDp3mVM1jppuH4lat4urx
         j1XRdNVQN+4mOCwh7a8aR3gUDFxpo5Ah3ply9QmNmGS5/e26V4rC7Bp5w9QL7ZeTj2BJ
         UamIHt66IWB3ngvUUiEjPbLNoY98m8mbKIB7xnir85qJZr4IKI+NCT5XzwWVNaXC17YB
         pSPLKuhGQqk3uMqCPmLttq1pnZmu54lMtksQgKuVCGYbdnvv6XgPu01Cjnzzf6ONBFgg
         lGjFkrtKwl0N+K6K6LuXoxZl9JgOmHZFQUsFj8TCs2AHBsKaL2IXxp++iO/svKI7a1WN
         AJMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5mC7/El6uOrT56b/fzKfnt+dVLlO1cF5jfwoUBoBRtS8LpsiCNk7KdRaMUPVAFL7phvLg2TFGC+ZaNza9t4yu+CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4m70NVY2T8Afs+DrCOIMaTBfOLR53c8HxrDCn/w/4AJAxeJ6B
	V6rrXbci3LHDoNM7ZI7WZcZq/wKY0H01lp/EexNNwG5UZqDBvtx1jrGsUF35D4pNK/VF4Gn9qSS
	sOBf4qms5fXTyMN+xEgSJZfe68+RGcidohQwCtuLuTw/OaQ15S9FBNinXIfgdpGtA1lCxx8gAiA
	==
X-Gm-Gg: Acq92OG6jedvRLzXUBQQBI4BgZvr6srAOgZ9jjuMi75mQIS9P2E+mJDXINw9NrmrsZZ
	ca56KO/jW1vIyf9KiP0wGPU2aA15BJ9JcWA/lI6leGNAoFeZOSXs2pkwQ7Cz7a6cOgh21e1M/XB
	dgHeWbv7b4d2SeXgbV/9iYCFDL+6de+dGNkqvIYqo2l0EEhTTpqpU/1Z3c4CZzIc/nhkBnohnOk
	lJYYZKFKqqme9NQZ8TvVm7pEBWm+kk1XgltHQd4/1pMbFbAICGVcu8eJoEoGvDAHXmLkXmBK9sv
	DmhMoEM/fYWmADvW5FnakDi7DZnZdKQiDA6PWNZodgeiDnJas4/T/h6vqc7Nqd4yYA//zAno1Iw
	7yDfI+Qwur0c20kkTpE0+UrvyoxoBC6rUl+zhDZb251d/e+5+Ccme0u/XprPc3w==
X-Received: by 2002:a05:600c:8518:b0:490:b1bb:cdc6 with SMTP id 5b1f17b1804b1-490b503f584mr11183665e9.5.1780420955125;
        Tue, 02 Jun 2026 10:22:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8518:b0:490:b1bb:cdc6 with SMTP id 5b1f17b1804b1-490b503f584mr11183195e9.5.1780420954698;
        Tue, 02 Jun 2026 10:22:34 -0700 (PDT)
Received: from [192.168.1.144] (88-149-243-171.dyn.eolo.it. [88.149.243.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0da5ae2sm75001205e9.0.2026.06.02.10.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 10:22:33 -0700 (PDT)
Message-ID: <19639b08-5bf1-4974-9635-c458d512fa38@redhat.com>
Date: Tue, 2 Jun 2026 11:23:35 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net,
 hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com,
 jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com,
 kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, ljs@kernel.org,
 mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
 mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de,
 rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org,
 richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org,
 rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, vbabka@suse.cz, vishal.moola@gmail.com,
 wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
 yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com,
 zokeefe@google.com, Usama Arif <usama.arif@linux.dev>, usamaarif642@gmail.com
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-12-npache@redhat.com>
 <b8380eb3-096a-49f1-9ace-99c1e75888b4@kernel.org>
 <CAA1CXcBg1su-bk3i_H+TW4-nTgvGSGqRNeC9MpQo7sGeH8ejnA@mail.gmail.com>
 <d3c2b00c-6810-434a-b837-0707b0a11611@kernel.org>
From: Nico Pache <npache@redhat.com>
In-Reply-To: <d3c2b00c-6810-434a-b837-0707b0a11611@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e5JLUZ63jDqVq7WZzKt1JBSAqGtnbbLHSUholj6gQQw_1780420955
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/1/26 7:15 AM, David Hildenbrand (Arm) wrote:
>>>
>>> Reading this, it is unclear why exactly do we need the stack.
>>
>> So I looked into your items below. It seems logical, and I think it
>> works the same way; however, your method seems slightly harder to
>> understand due to all the edge cases and more error-prone to future
>> changes (the stack holds implicit knowledge of the offset/order that
>> must now be tracked in the edge cases).
>>
>> Given the stack is 24 bytes, I'm not sure if the extra complexity is
>> worth saving that small amount of memory. Although we would also be
>> getting rid of (3?) functions, so both approaches have pros and cons.
> 
> I consider a simple forward loop over the offset ... less complexity compared to
> a stack structure :)
> 
>>
>> I will implement a patch comparing your solution against mine and send
>> it here, then we can decide which approach is better.
> 
> Right, throw it over the fence and I'll see how to improve it further.

Ok heres what the diff looks like on top of my V19. 

you can access the tree here https://gitlab.com/npache/linux/-/commits/mthp-v19?ref_type=heads for easier review.

So far I have no problem with this approach it appeared cleaner than i thought. Did some light testing. Gonna throw it more through the ringer tomorrow. 


From 9496c5d17eba7f6d04820d78c7c6f1592a58888a Mon Sep 17 00:00:00 2001
From: Nico Pache <npache@redhat.com>
Date: Tue, 2 Jun 2026 10:26:18 -0600
Subject: [PATCH] convert from stack to forward loop

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 96 ++++++++-----------------------------------------
 1 file changed, 15 insertions(+), 81 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 498eba009751..6de935e76ceb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -100,28 +100,6 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 static struct kmem_cache *mm_slot_cache __ro_after_init;
 
 #define KHUGEPAGED_MIN_MTHP_ORDER	2
-/*
- * mthp_collapse() does an iterative DFS over a binary tree, from
- * HPAGE_PMD_ORDER down to KHUGEPAGED_MIN_MTHP_ORDER. The max stack
- * size needed for a DFS on a binary tree is height + 1, where
- * height = HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER.
- *
- * ilog2 is used in place of HPAGE_PMD_ORDER because some architectures
- * (e.g. ppc64le) do not define HPAGE_PMD_ORDER until after build time.
- */
-#define MTHP_STACK_SIZE	(ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER + 1)
-
-/*
- * Defines a range of PTE entries in a PTE page table which are being
- * considered for mTHP collapse.
- *
- * @offset: the offset of the first PTE entry in a PMD range.
- * @order: the order of the PTE entries being considered for collapse.
- */
-struct mthp_range {
-	u16 offset;
-	u8 order;
-};
 
 struct collapse_control {
 	bool is_khugepaged;
@@ -137,7 +115,6 @@ struct collapse_control {
 
 	/* Each bit represents a single occupied (!none/zero) page. */
 	DECLARE_BITMAP(mthp_present_ptes, MAX_PTRS_PER_PTE);
-	struct mthp_range mthp_bitmap_stack[MTHP_STACK_SIZE];
 };
 
 /**
@@ -1458,50 +1435,14 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 	return result;
 }
 
-static void collapse_mthp_stack_push(struct collapse_control *cc, int *stack_size,
-				     u16 offset, u8 order)
-{
-	const int size = *stack_size;
-	struct mthp_range *stack = &cc->mthp_bitmap_stack[size];
-
-	VM_WARN_ON_ONCE(size >= MTHP_STACK_SIZE);
-	stack->order = order;
-	stack->offset = offset;
-	(*stack_size)++;
-}
-
-static struct mthp_range collapse_mthp_stack_pop(struct collapse_control *cc,
-						 int *stack_size)
-{
-	const int size = *stack_size;
-
-	VM_WARN_ON_ONCE(size <= 0);
-	(*stack_size)--;
-	return cc->mthp_bitmap_stack[size - 1];
-}
-
 /*
  * mthp_collapse() consumes the bitmap that is generated during
  * collapse_scan_pmd() to determine what regions and mTHP orders fit best.
  *
  * Each bit in cc->mthp_present_ptes represents a single occupied (!none/zero)
- * page. A stack structure cc->mthp_bitmap_stack is used to check different
- * regions of the bitmap for collapse eligibility. The stack maintains a pair
- * of variables (offset, order), indicating the number of PTEs from the start
- * of the PMD, and the order of the potential collapse candidate respectively.
- * We start at the PMD order and check if it is eligible for collapse; if not,
- * we add two entries to the stack at a lower order to represent the left and
- * right halves of the PTE page table we are examining.
- *
- *                         offset       mid_offset
- *                         |         |
- *                         |         |
- *                         v         v
- *      --------------------------------------
- *      |       cc->mthp_present_ptes         |
- *      --------------------------------------
- *                         <-------><------->
- *                          order-1  order-1
+ * page. We start at the PMD order and check if it is eligible for collapse;
+ * if not, we check the left and right halves of the PTE page table we are
+ * examining at a lower order.
  *
  * For each of these, we determine how many PTE entries are occupied in the
  * range of PTE entries we propose to collapse, then we compare this to a
@@ -1517,26 +1458,20 @@ static enum scan_result mthp_collapse(struct mm_struct *mm,
 {
 	unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
 	enum scan_result last_result = SCAN_FAIL;
-	int collapsed = 0, stack_size = 0;
+	int collapsed = 0;
 	bool alloc_failed = false;
 	unsigned long collapse_address;
-	struct mthp_range range;
-	u16 offset;
-	u8 order;
+	unsigned int offset = 0;
+	unsigned int order = HPAGE_PMD_ORDER;
 
-	collapse_mthp_stack_push(cc, &stack_size, 0, HPAGE_PMD_ORDER);
 
-	while (stack_size) {
-		range = collapse_mthp_stack_pop(cc, &stack_size);
-		order = range.order;
-		offset = range.offset;
+	while (offset < HPAGE_PMD_NR) {
 		nr_ptes = 1UL << order;
 
 		if (!test_bit(order, &enabled_orders))
 			goto next_order;
 
 		max_ptes_none = collapse_max_ptes_none(cc, NULL, order);
-
 		nr_occupied_ptes = bitmap_weight_from(cc->mthp_present_ptes, offset,
 						      offset + nr_ptes);
 
@@ -1553,7 +1488,7 @@ static enum scan_result mthp_collapse(struct mm_struct *mm,
 				collapsed += nr_ptes;
 				fallthrough;
 			case SCAN_PTE_MAPPED_HUGEPAGE:
-				continue;
+				goto next_offset;
 			/* Cases where lower orders might still succeed */
 			case SCAN_ALLOC_HUGE_PAGE_FAIL:
 				alloc_failed = true;
@@ -1581,15 +1516,14 @@ static enum scan_result mthp_collapse(struct mm_struct *mm,
 		}
 
 next_order:
-		if ((BIT(order) - 1) & enabled_orders) {
-			const u8 next_order = order - 1;
-			const u16 mid_offset = offset + (nr_ptes / 2);
-
-			collapse_mthp_stack_push(cc, &stack_size, mid_offset,
-						 next_order);
-			collapse_mthp_stack_push(cc, &stack_size, offset,
-						 next_order);
+		if (order > KHUGEPAGED_MIN_MTHP_ORDER &&
+			(BIT(order) - 1) & enabled_orders) {
+			order = order - 1;
+			continue;
 		}
+next_offset:
+		offset += nr_ptes;
+		order = min_t(int, __ffs(offset), HPAGE_PMD_ORDER);
 	}
 done:
 	if (collapsed)
-- 
2.54.0



> 
> [...]
> 
>>>> +     bitmap_zero(cc->mthp_bitmap, MAX_PTRS_PER_PTE);
>>>>       memset(cc->node_load, 0, sizeof(cc->node_load));
>>>>       nodes_clear(cc->alloc_nmask);
>>>> +
>>>> +     enabled_orders = collapse_allowable_orders(vma, vma->vm_flags, tva_flags);
>>>> +
>>>> +     /*
>>>> +      * If PMD is the only enabled order, enforce max_ptes_none, otherwise
>>>> +      * scan all pages to populate the bitmap for mTHP collapse.
>>>> +      */
>>>
>>> You should note here, that we re-verify in mthp_collapse().
>>>
>>> But the question is, whether we should relocate the check completely into
>>> mthp_collapse(), instead of conditionally duplicating it.
>>>
>>> What speaks against always populating the bitmap and making the decision in
>>> mthp_collapse()?
>>>
>>> Sure, we might scan a page table a bit longer, but the code gets clearer ... and
>>> I am not sure if scanning some more page table entries is really that critical here.
>>
>> Someone asked me to preserve the legacy behavior (PMD only). Although
>> rather trivial, if you set max_ptes_none=0 for example, we'd still
>> have to do 511 iterations for no reason if PMD collapse is the only
>> enabled order rather than bailing immediately.
>>
>> I'm ok with dropping it, but I think its the correct approach (despite
>> the extra complexity). @Usama Arif brought up this point here
>> https://lore.kernel.org/all/f8f7bb71-ca31-46ee-a62d-7ddfd83e0ead@gmail.com/
> 
> We talk about regressions, but I am not sure if we care about scanning speed
> within a page table that much?
> 
> After all, we locked it and already read some entries.
> 
> Having the same check at two places to optimize for PMD order might right now
> feel like a good optimization, but likely an irrelevant one in a near future?
> 
> Anyhow, won't push back, as long as we document why we are special casing things
> here.
> 

