Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC25352024
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902860; cv=none; b=F+ejXPrIUO6Hb/en94AKmZam2tC7hyr1i3rfpo+KS2fhLpChOB7faCg0sdwKt9V4RvJETg/XuzoF5jNPqx8Ng4c+pR47iQSdqOFW0UKbnPCh6xbU6QfDFsJMSyTZGlUgimfAP9knWqX8f89vinMQWy/5EQZCMG9a5WhjK159bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902860; c=relaxed/simple;
	bh=VA+9r/z3n+RbhWNhQjtlm5cjRKLYAfjlBGhasnng8WE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8IXlf4OWanO7NUZeraXDGp0KysKS/JfPHclqhMAM42O1et3B798WSpP2sp4LZbtlHfXUiXoDi16fQOi6fxUv2kWQL63na76ALI1jdw8XpM4q0G5FTCseeA5jpUBHw/mee4QbMYKaBn7ISTPUnuxZRH1GNtthxmjzviAkhGSoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rHBdi2+z; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rHBdi2+z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780902846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3DfQ5vwWCckZGkA87/DSfdL+GVPQKWQGnRbRGwtS94=;
	b=rHBdi2+zew9CwX9JzM5CIi0bAAjqQd2xi3+2yfyULKQaqBBpfay7Z6/nK5Y6px4dq86NAt
	H3KNQz9QRnC3ymTmBRIrbdi3ShIKJibCXsKvCwwJdBfGnNZG9jvrXc3IQb6RkxXPpB7Xlm
	pdcWF/RCLj52b0xE2Pdn+dpnpyCMK8w=
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
Subject: Re: [PATCH mm-unstable v19 08/14] mm/khugepaged: add per-order mTHP collapse failure statistics
Date: Mon,  8 Jun 2026 15:13:52 +0800
Message-Id: <20260608071352.77428-1-lance.yang@linux.dev>
In-Reply-To: <20260605161422.213817-9-npache@redhat.com>
References: <20260605161422.213817-9-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Jun 05, 2026 at 10:14:15AM -0600, Nico Pache wrote:
>Add three new mTHP statistics to track collapse failures for different
>orders when encountering swap PTEs, excessive none PTEs, and shared PTEs:
>
>- collapse_exceed_swap_pte: Increment when mTHP collapse fails due to
>	encountering a swap PTE.
>
>- collapse_exceed_none_pte: Counts when mTHP collapse fails due to
>  	exceeding the none PTE threshold for the given order
>
>- collapse_exceed_shared_pte: Counts when mTHP collapse fails due to
>	encountering a shared PTE.
>
>These statistics complement the existing THP_SCAN_EXCEED_* events by
>providing per-order granularity for mTHP collapse attempts. The stats are
>exposed via sysfs under
>`/sys/kernel/mm/transparent_hugepage/hugepages-*/stats/` for each
>supported hugepage size.
>
>As we currently do not support collapsing mTHPs that contain a swap or
>shared entry, those statistics keep track of how often we are
>encountering failed mTHP collapses due to these restrictions.
>
>We will add support for mTHP collapse for anonymous pages next; lets also
>track when this happens at the PMD level within the per-mTHP stats.
>
>Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
