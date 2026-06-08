Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF7397E89
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901982; cv=none; b=bfv51GMNAcTrim63e0bK3s/SJQ0ENBwxwWFxR6+WEatWbirbaFJlTn+ML/PsSsDLnHBvQL/pTdRaF50i352IQgXnMyoBa8t5mrb68uk4rVXPRafswiWCY7DB8x3LfOMyBLlLvZvbrutuyBWsX8e3QAoJuXzFphXLw422a1SlvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901982; c=relaxed/simple;
	bh=S6gLya0AdKg0zcUdyzdBhBdBUKql8AmIkZI/Kjnkprc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6CehNKEeIAVE/hcnwmC9R/II6wZU7bfQmHE+gWjdmXCJybEDJo8HHeKj6NhQrTswOnEkF+m0rJRvp7x7FN72h2SqWWJfJ0bgzU8/aVeiv3GU3r354RyW9/Y+hE3tzlqpXj06SVcgkKhSjxLrYJVqLaMqTreW9IFYRCkVIZpExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EUapOzUX; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EUapOzUX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780901976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3/06Trq5FpnxHyx8TwAa3S5P3cfEJjPOzAapv5j8wo=;
	b=EUapOzUXzSldul+SfubS/o+1vi1bdkmgOGo33ORWMjo36vmrsTNcL+aaGW03/YjqAZSW2R
	k6K4Jlx7h9j38VtG8xzTPjXnNZRTsV7JRAyL8HPHWR9Zi+NmmnQyClmfyWfUeVsdt9mjuP
	MnaxxTrabdkE3hKr88UNKrlypvcKGKk=
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
Subject: Re: [PATCH mm-unstable v19 07/14] mm/khugepaged: skip collapsing mTHP to smaller orders
Date: Mon,  8 Jun 2026 14:59:06 +0800
Message-Id: <20260608065906.66125-1-lance.yang@linux.dev>
In-Reply-To: <20260605161422.213817-8-npache@redhat.com>
References: <20260605161422.213817-8-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Jun 05, 2026 at 10:14:14AM -0600, Nico Pache wrote:
>khugepaged may try to collapse a mTHP to a folio of equal or smaller size,
>possibly resulting in a partially mapped source folio, which is undesired.
>Skip these cases until we have a way to check if its ok to collapse to a
>smaller mTHP size (like in the case of a partially mapped folio). This
>check is not done during the scan phase as the current collapse order is
>unknown at that time.
>
>This patch is inspired by Dev Jain's work on khugepaged mTHP support [1].
>
>[1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.com/
>
>Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Acked-by: David Hildenbrand (arm) <david@kernel.org>
>Acked-by: Usama Arif <usama.arif@linux.dev>
>Co-developed-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---
> mm/khugepaged.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index c2769d82a719..191e529c185c 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -697,6 +697,14 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
> 				goto out;
> 			}
> 		}
>+		/*
>+		 * TODO: In some cases of partially-mapped folios, we'd actually
>+		 * want to collapse.
>+		 */

Partially mapped folios can be handled later :)

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>+		if (!is_pmd_order(order) && folio_order(folio) >= order) {
>+			result = SCAN_PTE_MAPPED_HUGEPAGE;
>+			goto out;
>+		}
> 
> 		if (folio_test_large(folio)) {
> 			struct folio *f;
>-- 
>2.54.0
>
>
