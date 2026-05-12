Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD83019DC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561101; cv=none; b=WgIo4sXfnftabcyYCwKNisMWa55/Yve+ES+nxBJ9omOjYNX9maJ5Ia4RZ23BmnrMrH8FkI8L2gRGyHJm4qqHhUuJVZ2yHkjmNXSBRuHLjW88zpuhlBkM0k1Hb2RMajoDTtEFkYIU2WsPEVS7MRpcRUG3rS3M9tVElZ1vJ1d/1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561101; c=relaxed/simple;
	bh=nTjBBouXxbsK5tE23oLCYyGFMpN52UWYf/GWtqGZ2mY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHtTu5c5Fs0E44HJFDLxwfv3kYlwoa+dNuOcv1nCR5IKfC1mzx886yN20zYCIwb2QVYUe/mRwi65eMXCLVRGcSL3VBOzKmzRv0b3OYowWqAOWlpkzzTlWf5JWoorIrTyElaQoL0+gaAdvbC0J8uT27aVAq+KOvt8qBvVbnJoYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rPymqSEB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rPymqSEB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778561096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLBqEVqOtA0L9B/FBEFQZHxIvKYLTaOc7iFirBA8GiM=;
	b=rPymqSEB7ksQeLp2kXClF6xGrRcrtPRC6k7yv726vYMSQEmkKfG8uwEcPDk5G6OqXp5d53
	0h73lztm/ioh6KuUgtZJh4V8ofHz9eJyrpXqZAKKLiX66KAeLK7i0ZIGOjp7gBm/Mh8c/r
	/29FxCR53BgaL0mjYeUHQiJntl+h1wo=
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
Subject: Re: [PATCH mm-unstable v17 03/14] mm/khugepaged: rework max_ptes_* handling with helper functions
Date: Tue, 12 May 2026 12:44:44 +0800
Message-Id: <20260512044444.71798-1-lance.yang@linux.dev>
In-Reply-To: <20260511185817.686831-4-npache@redhat.com>
References: <20260511185817.686831-4-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 12:58:03PM -0600, Nico Pache wrote:
>The following cleanup reworks all the max_ptes_* handling into helper
>functions. This increases the code readability and will later be used to
>implement the mTHP handling of these variables.
>
>With these changes we abstract all the madvise_collapse() special casing
>(dont respect the sysctls) away from the functions that utilize them. And

Nit: s/dont/do not/

>will be used later in this series to cleanly restrict the mTHP collapse
>behavior.
>
>No functional change is intended; however, we are now only reading the
>sysfs variables once per scan, whereas before these variables were being
>read on each loop iteration.
>
>Suggested-by: David Hildenbrand <david@kernel.org>
>Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>Acked-by: Usama Arif <usama.arif@linux.dev>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---
> mm/khugepaged.c | 118 +++++++++++++++++++++++++++++++++---------------
> 1 file changed, 82 insertions(+), 36 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index f0e29d5c7b1f..f68853b3caa7 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -348,6 +348,62 @@ static bool pte_none_or_zero(pte_t pte)
> 	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
> }
> 
>+/**
>+ * collapse_max_ptes_none - Calculate maximum allowed none-page or zero-page
>+ * PTEs for the given collapse operation.
>+ * @cc: The collapse control struct
>+ * @vma: The vma to check for userfaultfd
>+ *
>+ * Return: Maximum number of none-page or zero-page PTEs allowed for the
>+ * collapse operation.
>+ */
>+static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
>+		struct vm_area_struct *vma)
>+{
>+	// If the vma is userfaultfd-armed, allow no none-page or zero-page PTEs.
>+	if (vma && userfaultfd_armed(vma))
>+		return 0;
>+	// for MADV_COLLAPSE, allow any none-page or zero-page PTEs.
>+	if (!cc->is_khugepaged)
>+		return HPAGE_PMD_NR;
>+	// For all other cases repect the user defined maximum.
>+	return khugepaged_max_ptes_none;

Nit: kernel code usually uses C-style comments. This could be:

/* For all other cases, respect the user-defined maximum. */

Also, s/repect/respect/.

>+}
>+
>+/**
>+ * collapse_max_ptes_shared - Calculate maximum allowed PTEs that map shared
>+ * anonymous pages for the given collapse operation.
>+ * @cc: The collapse control struct
>+ *
>+ * Return: Maximum number of PTEs that map shared anonymous pages for the
>+ * collapse operation
>+ */
>+static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
>+{
>+	// for MADV_COLLAPSE, do not restrict the number of PTEs that map shared
>+	// anonymous pages.

Ditto.

>+	if (!cc->is_khugepaged)
>+		return HPAGE_PMD_NR;
>+	return khugepaged_max_ptes_shared;
>+}
>+
>+/**
>+ * collapse_max_ptes_swap - Calculate the maximum allowed non-present PTEs or the
>+ * maximum allowed non-present pagecache entries for the given collapse operation.
>+ * @cc: The collapse control struct
>+ *
>+ * Return: Maximum number of non-present PTEs or the maximum allowed non-present
>+ * pagecache entries for the collapse operation.
>+ */
>+static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
>+{
>+	// for MADV_COLLAPSE, do not restrict the number PTEs entries or
>+	// pagecache entries that are non-present.

Same here.

>+	if (!cc->is_khugepaged)
>+		return HPAGE_PMD_NR;
>+	return khugepaged_max_ptes_swap;
>+}
>+
> int hugepage_madvise(struct vm_area_struct *vma,
> 		     vm_flags_t *vm_flags, int advice)
> {
>@@ -546,21 +602,19 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
> 	pte_t *_pte;
> 	int none_or_zero = 0, shared = 0, referenced = 0;
> 	enum scan_result result = SCAN_FAIL;
>+	unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
>+	unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);

Nit: could these be const, as David suggested earlier?

Nothing else jumped out at me. LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
