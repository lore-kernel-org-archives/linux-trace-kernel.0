Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E532634F25C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123649; cv=none; b=TTwDalgIel/62gx7PBgZddV/VR1fA1mG1uj8rtU/uRVcqPkNcs1ilUZk9sRlo5zIK+fVzrT+Nn0Q1CgI9nG7kMGkOHzAZMFHO/ucUWin00QDwov6kjNM3F1rKBrlis3iusQtxyb5pfIwVUMAQcphEIAyWjJytrNHb1MrP7TdM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123649; c=relaxed/simple;
	bh=bbmoJUVzH1blerMXHknH0ZmFmNcKyxY5au5drkkHZH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTDkC4EdfsVZp3bBreYoQwx7e3o6jAjTn7ew0zBDqFgXDwYQtjqmn0DgE6XKvb1O4lo+AyDJYLbCAX3p9vcSnixwJ64UknuAEtYz9uAQcreB+uVs8YQP9gEJSDnGzsg/0+jTpViSpLWC/LwFhj9BaFNnDAXeNVZstDn65opFeiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wZlExFdS; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wZlExFdS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779123634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgANANpR/t++ODnomsXvz08+6RNX17geYX0Fq4dq7OI=;
	b=wZlExFdSNnVZ4ZMNbZxhJWlG5BUETvUK8L5TPRXYLLYTflJBtbmSxx0U6V2MtkbheKynhY
	59GTlYYe5EKaKtJoyb/rIjmeKVy0hRwcacUt8cqiAXF0UG8+4kfUzjx4tL4kd/KZZxUYkN
	GI3yAMVo9A0wL0gz/Z+xivO2v/85CEw=
From: Usama Arif <usama.arif@linux.dev>
To: Nico Pache <npache@redhat.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH mm-unstable v17 06/14] mm/khugepaged: generalize collapse_huge_page for mTHP collapse
Date: Mon, 18 May 2026 10:00:24 -0700
Message-ID: <20260518170025.2228034-1-usama.arif@linux.dev>
In-Reply-To: <20260511185817.686831-7-npache@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 11 May 2026 12:58:06 -0600 Nico Pache <npache@redhat.com> wrote:

> Pass an order and offset to collapse_huge_page to support collapsing anon
> memory to arbitrary orders within a PMD. order indicates what mTHP size we
> are attempting to collapse to, and offset indicates were in the PMD to
> start the collapse attempt.
> 
> For non-PMD collapse we must leave the anon VMA write locked until after
> we collapse the mTHP-- in the PMD case all the pages are isolated, but in
> the mTHP case this is not true, and we must keep the lock to prevent
> access/changes to the page tables. This can happen if the rmap walkers hit
> a pmd_none while the PMD entry is currently unavailable due to being
> temporarily removed during the collapse phase.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 93 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 55 insertions(+), 38 deletions(-)
> 

The patch did 2 things:

Make it work with any order and not just PMD order.

Keeps anon_vma_write held across the copy and install for non-PMD orders,
as mTHP leaves the out-of-range PTEs mapped while the PMD is temporarily none.
rmap walkers cannot reach here until PMD is isntalled.

Acked-by: Usama Arif <usama.arif@linux.dev>
