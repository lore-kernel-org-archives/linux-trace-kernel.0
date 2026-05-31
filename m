Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48AF35838A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 31 May 2026 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780212693; cv=none; b=nzkte5fTAxX8LXBw0j9a0cF+n9h6cOnM9ZdWssezezll7VeytSIwXWBh5zatCbc742UfgdSPOla/AEONAYmgSWG7QjOEposQWj16giyknP7RVuUdF8A7SFfFhHUFeiirfdCdpIvjIvfEsH3WUYa3kSOEHjQYmihPhbQ3SGqVVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780212693; c=relaxed/simple;
	bh=k3wTY1riKpxj4w2KDLPS0/W88O4SZmB1j+/ICOH5GzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYQNjRFlIsrEkIOWJx2JNy4RfGCgYReSllTsRFgq+m5l87Oo8Ui1C0BQ6mUJpMIj/owHeLJ/SjtnLryYboipC8BWGfF0XuryHCbvSb8/q011HTcJKNgTlDXN17OBm94+dJGTVGyMfU89tQUSHdwpsalfsroAV3LpFk469HeGcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GLxC/+IQ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GLxC/+IQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780212678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygMusJ4OhxFWYgfdJFdjk6JjCc/P5Yv4lLsq+6asc2I=;
	b=GLxC/+IQoaYnWqMbHdZqSraF09cYIqx1TkB97Iseulqg7tgBNUbFR46llX5lxy/ymBtQqv
	ta1xf7DjhgeW2OqmHLXsTMw/0Ulf6309h0NH56ha+aGc/AaAGZdFlMvFzL8F4qoKgQF23n
	J+dGGm1xnDWnqudtQmP4PWNJD6sQVHo=
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
	zokeefe@google.com,
	usama.arif@linux.dev
Subject: Re: [PATCH mm-unstable v18 12/14] mm/khugepaged: avoid unnecessary mTHP collapse attempts
Date: Sun, 31 May 2026 15:31:02 +0800
Message-Id: <20260531073102.20318-1-lance.yang@linux.dev>
In-Reply-To: <20260522150009.121603-13-npache@redhat.com>
References: <20260522150009.121603-13-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, May 22, 2026 at 09:00:07AM -0600, Nico Pache wrote:
>There are cases where, if an attempted collapse fails, all subsequent
>orders are guaranteed to also fail. Avoid these collapse attempts by
>bailing out early.
>
>Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>Acked-by: Usama Arif <usama.arif@linux.dev>
>Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---
> mm/khugepaged.c | 24 +++++++++++++++++++++++-
> 1 file changed, 23 insertions(+), 1 deletion(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index d3d7db8be26c..15b7298bc225 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -1535,9 +1535,31 @@ static int mthp_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
> 			collapse_address = address + offset * PAGE_SIZE;
> 			ret = collapse_huge_page(mm, collapse_address, referenced,
> 						 unmapped, cc, order);
>-			if (ret == SCAN_SUCCEED) {
>+
>+			switch (ret) {
>+			/* Cases where we continue to next collapse candidate */
>+			case SCAN_SUCCEED:
> 				collapsed += nr_ptes;
>+				fallthrough;
>+			case SCAN_PTE_MAPPED_HUGEPAGE:
> 				continue;
>+			/* Cases where lower orders might still succeed */
>+			case SCAN_LACK_REFERENCED_PAGE:
>+			case SCAN_EXCEED_NONE_PTE:
>+			case SCAN_EXCEED_SWAP_PTE:
>+			case SCAN_EXCEED_SHARED_PTE:
>+			case SCAN_PAGE_LOCK:
>+			case SCAN_PAGE_COUNT:
>+			case SCAN_PAGE_NULL:
>+			case SCAN_DEL_PAGE_LRU:
>+			case SCAN_PTE_NON_PRESENT:
>+			case SCAN_PTE_UFFD_WP:
>+			case SCAN_ALLOC_HUGE_PAGE_FAIL:

Nit: shouldn't SCAN_CGROUP_CHARGE_FAIL go with SCAN_ALLOC_HUGE_PAGE_FAIL
here?

If charging the current order fails, a smaller order might still fit :)

Cheers, Lance

>+			case SCAN_PAGE_LAZYFREE:
>+				goto next_order;
>+			/* Cases where no further collapse is possible */
>+			default:
>+				return collapsed;
> 			}
> 		}
> 
>-- 
>2.54.0
>
>
