Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6E41324E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108611; cv=none; b=lUakkc27utol4faC4iikwy2Z5z6ISIM3dWbe6j6DgDUuluCc9OFM5C0XSxWjeEMuAJxVhnG8o9pmh6neARIW8hTmcEd7t6/C3PYutGj859eP3HUKiMQGed/bpggT69e3+JAc2jOoUFu28LTL/CjaPBVFiSWLuxVs7XgcMvMGeKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108611; c=relaxed/simple;
	bh=71B0nRHlWp/xojgpspfis42HrCowovQsOla+aGirePQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR9KOmg26VYNnLWK6VGWLKRuhdBPfhwaozCx3YNRRCfGSwsyqAG4IwFbwhIYzqmFMut0+M3NKZ17DQGz535bgNImtRg8lieUi7knGUl+6GmDZb4dIhWcWxPKjUaeC0JiZOp4FTgbrv3IawERFvm5WysIjN3eYLJD0AAj5eFYDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec0dCnIp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec0dCnIp"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd6460b0d11so356059566b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779108608; x=1779713408; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKGGrrG5MRCv9nIegptkqAObQ0mJWvKMrBMMlmCctkg=;
        b=Ec0dCnIp7CP5F2PJoqTEPCggb70l4WstiLwLV+aM60gbS171HBPP1NwejxlSBoXH0V
         blDYHGqA61Ia+Mfdd/YZ6fHldjPKCal+EycFIojAZuzQ/j/0H5yKUeSf1OF8hVF6R3hf
         lqcq1AFHIVpP7uDkCPM+WItGGNT7I4zR9QZWlEaEvJdr9rzeO9Zq8DSxprko/VzD7tnz
         8xdAcpezIDDrZ9yCA39tyWJc7QtUR3JvtoH/Gng6Bk+t70sEDpePjt/Fv9tluQNWJTJC
         Q5aoc9Va7tgQ4arsTNLlfAvPs/cE5JYN8tQne0EWHIwP+7LP5tQg39ExDNZc75yc2HiH
         D82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108608; x=1779713408;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKGGrrG5MRCv9nIegptkqAObQ0mJWvKMrBMMlmCctkg=;
        b=RIEW+1TQPeQpSeJmQzCDlj6AnTh30tqGv6r29Abi/BYN/2ZkQbPzHLy0lCWRvmQl40
         klwyfx4A+8HHGpBHVVL7lKjzDuPkw2XS4BycYGyO3d8/ZJROZ+Cgh/Ki7+OLvWz+xKG3
         3KjfuBwEgsLXyp2zyY4gdhN93RNWteKbkg7FbBbQWREUqteRRBzI79SMEkcjKqBbEa1y
         9AmfMiMVRkDpYckf3i9ttyh44b49LtAmgN+9P61S3wreOAX3xnoHxRHsdHgFq7O2nUJz
         bcFMyq4z1wewLCmlkLq9D/uazWfTwdQQQqo+8r31b1qmF/U9luzcwzVa0zAVGHV0tYFa
         BSEg==
X-Forwarded-Encrypted: i=1; AFNElJ/EoTCH7KnU8aqXTEiJng2dH+duTCdGUFd8eO5f8/OgEY6c8RnaZrH5wsrXnxWXCHuDqC64+QUUk8zpQOE2EPF2B9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YykzYm7+NqopaXf0ZgqGeH018JW4BtZnav1+LdSdp6/r2woGKYW
	JxOfn6UII9NNBh619KXzW7+mkb/Ol2RMbt/cUHGyvRIN/YL5LsRnp3mS
X-Gm-Gg: Acq92OGDLbepngZicFtJO9qWSBINZB0k1n553IYCXyhq7n8q/3owi8PQd0p6QVDXmzk
	B06BXtsmKwtEhZ6FlkQkWKD4/BKrvh3Fao4XWyoUQH60Mc5Sg5sZfcHWlq5sEvx/amfgfZ7vojJ
	qwsVkVg5hxwRImQ02i50IGCRbJWSxrqRSe6Vez+eB447Igd9dVUDhH+TB8x9ect4lJFit3ZC3QF
	Z2uhDhkRkgORnRfqeo6R2qhJ6o5mt95ugq1C4mLlt2K0ZsVLgJv2OZys1H5TBI5A85eC5Lg3o98
	yOBeBVKSKgl7p5aCF8Qy5PXjCWuoQ+q0DEV4kanixgK8hxBw6anbGltyBSz90WKkVUmyzNfw2/n
	UHO1HRcMqJS2OqowoiIOF3C4+DHzCbB4PmHU0wDUoFoME2vPpnS3jlt4AwDbBWr5LeNjPyfVDet
	F7fzwCOvXASkITXPsIwbxuwjpHyg99aC9G
X-Received: by 2002:a17:906:ee85:b0:bd1:ba38:c724 with SMTP id a640c23a62f3a-bd51790b3a8mr743116466b.32.1779108608313;
        Mon, 18 May 2026 05:50:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dec7c4sm577430666b.40.2026.05.18.05.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2026 05:50:07 -0700 (PDT)
Date: Mon, 18 May 2026 12:50:07 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	aarcange@redhat.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, byungchul@sk.com,
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com,
	jack@suse.cz, jackmanb@google.com, jannh@google.com,
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org,
	lance.yang@linux.dev, liam@infradead.org, ljs@kernel.org,
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com,
	pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
	rdunlap@infradead.org, richard.weiyang@gmail.com,
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com,
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de,
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com,
	ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v17 00/14] khugepaged: mTHP support
Message-ID: <20260518125007.a4z3pw4r73uuwja4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260511185817.686831-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511185817.686831-1-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, May 11, 2026 at 12:58:00PM -0600, Nico Pache wrote:
>The following series provides khugepaged with the capability to collapse
>anonymous memory regions to mTHPs.
>
>To achieve this we generalize the khugepaged functions to no longer depend
>on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
>pages that are occupied (!none/zero). After the PMD scan is done, we use
>the bitmap to find the optimal mTHP sizes for the PMD range. The
>restriction on max_ptes_none is removed during the scan, to make sure we
>account for the whole PMD range in the bitmap. When no mTHP size is
>enabled, the legacy behavior of khugepaged is maintained.
>
>We currently only support max_ptes_none values of 0 or HPAGE_PMD_NR - 1
>(ie 511). If any other value is specified, the kernel will emit a warning
>and no mTHP collapse will be attempted. If a mTHP collapse is attempted,
>but contains swapped out, or shared pages, we don't perform the collapse.
>It is now also possible to collapse to mTHPs without requiring the PMD THP
>size to be enabled. These limitations are to prevent collapse "creep"
>behavior. This prevents constantly promoting mTHPs to the next available
>size, which would occur because a collapse introduces more non-zero pages
>that would satisfy the promotion condition on subsequent scans.
>
>Patch 1-2:   Generalize hugepage_vma_revalidate and alloc_charge_folio
>	     for arbitrary orders.
>Patch 3:     Rework max_ptes_* handling into helper functions
>Patch 4:     Generalize __collapse_huge_page_* for mTHP support
>Patch 5:     Require collapse_huge_page to enter/exit with the lock dropped
>Patch 6:     Generalize collapse_huge_page for mTHP collapse
>Patch 7:     Skip collapsing mTHP to smaller orders
>Patch 8-9:   Add per-order mTHP statistics and tracepoints
>Patch 10:    Introduce collapse_allowable_orders helper function
>Patch 11-13: Introduce bitmap and mTHP collapse support, fully enabled
>Patch 14:    Documentation
>
>Testing:
>- Built for x86_64, aarch64, ppc64le, and s390x
>- ran all arches on test suites provided by the kernel-tests project
>- internal testing suites: functional testing and performance testing
>- selftests mm
>- I created a test script that I used to push khugepaged to its limits
>   while monitoring a number of stats and tracepoints. The code is
>   available here[1] (Run in legacy mode for these changes and set mthp
>   sizes to inherit)
>   The summary from my testings was that there was no significant
>   regression noticed through this test. In some cases my changes had
>   better collapse latencies, and was able to scan more pages in the same
>   amount of time/work, but for the most part the results were consistent.
>- redis testing. I did some testing with these changes along with my defer
>  changes (see followup [2] post for more details). We've decided to get
>  the mTHP changes merged first before attempting the defer series.
>- some basic testing on 64k page size.
>- lots of general use.
>

Two links are missing. I got them from previous version.

[1] - https://gitlab.com/npache/khugepaged_mthp_test
[2] - https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.com/

And the test in [1] is a performance test. I am thinking whether we want a
functional test in selftests.

I did a quick try with following change and some hack.

@@ -744,6 +765,51 @@ static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *o
 	ksft_test_result_report(exit_status, "%s\n", __func__);
 }
 
+static void collapse_mth_ptes(struct collapse_context *c, struct mem_ops *ops)
+{
+	struct thp_settings settings = *thp_current_settings();
+	void *p;
+	int i;
+
+	/* Disable mthp on fault */
+	for (i = 0; i < NR_ORDERS; i++) {
+		settings.hugepages[i].enabled = THP_NEVER;
+	}
+	thp_push_settings(&settings);
+
+	p = ops->setup_area(1);
+
+	ops->fault(p, 0, hpage_pmd_size);
+
+	/* Expect all order-0 folio after fault */
+	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
+	expected_orders[0] = hpage_pmd_nr;
+	if (check_folio_orders(p, hpage_pmd_size, pagemap_fd,
+					   kpageflags_fd, expected_orders,
+					   (pmd_order + 1)))
+		ksft_exit_fail_msg("Unexpected huge page at fault\n");
+
+	/* Enable mthp before collapse */
+	thp_pop_settings();
+	settings.hugepages[2].enabled = THP_ALWAYS;
+	thp_push_settings(&settings);
+
+	c->collapse("Collapse fully populated PTE table with order 2", p, 1,
+		    ops, true);
+
+	/* Expect all order-2 folio after collapse */
+	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
+	expected_orders[2] = 1 << (pmd_order - 2);
+	if (check_folio_orders(p, hpage_pmd_size, pagemap_fd,
+					   kpageflags_fd, expected_orders,
+					   (pmd_order + 1)))
+		ksft_exit_fail_msg("Unexpected page order\n");
+
+	ops->cleanup_area(p, hpage_pmd_size);
+	thp_pop_settings();
+	ksft_test_result_report(exit_status, "%s\n", __func__);
+}
+
 static void collapse_swapin_single_pte(struct collapse_context *c, struct mem_ops *ops)
 {
 	void *p;

This leverage check_after_split_folio_orders() in split_huge_page_test.c to
check folio order in PMD range.

-- 
Wei Yang
Help you, Help me
