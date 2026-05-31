Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15244360EF6
	for <linux-trace-kernel@vger.kernel.org>; Sun, 31 May 2026 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780211973; cv=none; b=S2a9glgdLjlvPpaw6B2it8b/iXG6A4aMYWVfZyg3iQOSPCzRtNNze3PtNo3RBt52H/1oTK/B9WtO7tvsj6NcFgtpxrSUJysAQ97uC5tMqTi2eU+9xQdi0uCVtz2xYZeFD9gzzYU1dNL2YNZnZvVp3Pur41K8TRGqXyxGgdqjA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780211973; c=relaxed/simple;
	bh=4oQpFIVJnyhvUIU2EIwvLfR93Esgnrj76UG6pXPvXzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ialUaH0DiAh/vmfM5WaB4v4CMglgVlDcPv9OOd8b9Rn/OddUGlI7HeW+i23shlXjQHkILMAce2Hjf7vdFPeYn3shbY2V+uWFZStpL+3TzpqFeZ2310oZk5ILIbyLWp91q5XjUU4tCgg+E4+hU+3008D/k2L5xYIq47ANZdwqRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OKYxp2/e; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OKYxp2/e"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780211958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgyOMSo1NQT9NR/s9Gmh5C++kaNJthsUpAzUGUjKh8k=;
	b=OKYxp2/euq94yW/BPlLJPwdiYfRQcuT145cwocxP1tMXDQnxVH8DFOnodfv1FPZXMlXLCc
	kRTYcgDt2gUggNPJiWjwTB5Smh2j0coJATntxq/OKgA9TmbAefd+z7fbWApU/qd8xKAYxI
	SMqIEnb+vlsE2yUpzPce/xXrgmk12Tc=
From: Lance Yang <lance.yang@linux.dev>
To: npache@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jack@suse.cz,
	jackmanb@google.com,
	jannh@google.com,
	jglisse@google.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	ljs@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	rakie.kim@sk.com,
	raquini@redhat.com,
	rdunlap@infradead.org,
	richard.weiyang@gmail.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shivankg@amd.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vbabka@suse.cz,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP collapse support
Date: Sun, 31 May 2026 15:18:45 +0800
Message-Id: <20260531071845.10875-1-lance.yang@linux.dev>
In-Reply-To: <20260522150009.121603-12-npache@redhat.com>
References: <20260522150009.121603-12-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, May 22, 2026 at 09:00:06AM -0600, Nico Pache wrote:
[...]
>@@ -1587,10 +1749,11 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> 	if (result == SCAN_SUCCEED) {
> 		/* collapse_huge_page expects the lock to be dropped before calling */
> 		mmap_read_unlock(mm);
>-		result = collapse_huge_page(mm, start_addr, referenced,
>-					    unmapped, cc, HPAGE_PMD_ORDER);
>-		/* collapse_huge_page will return with the mmap_lock released */
>+		nr_collapsed = mthp_collapse(mm, vma, start_addr, referenced,
>+					     unmapped, cc, enabled_orders);
>+		/* mmap_lock was released above, set lock_dropped */
> 		*lock_dropped = true;
>+		result = nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;

Hmm ... don't we lose the allocation-failure result here?

Previously collapse_scan_pmd() propagated SCAN_ALLOC_HUGE_PAGE_FAIL from
collapse_huge_page(), so khugepaged would call khugepaged_alloc_sleep()
in khugepaged_do_scan().

Now if allocation fails and nr_collapsed stays 0, we just return
SCAN_FAIL. So we won't back off via khugepaged_alloc_sleep() anymore?

Cheers, Lance
