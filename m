Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ECF2771B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894475; cv=none; b=S4jkOhm6zlMoOU48qS3ySuCqqgOlPrPaBgG3J5K2HytE+ss27oVvqZQsj6/EBEN/UAPWGiq4dSwyDDC+VurwSlECWMgCtbeO4t8nQTBp6zU0n+b7fd3oFzJNMyqVtr9tjtTqlkwCV7Tn5wvUG6z0ZqKcPwZgraNBYJYdDWWfQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894475; c=relaxed/simple;
	bh=nJZD1v0uKmRwmTPQY9fhrdbUR6X2mcRzW3srSSIJVBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkDVI9DOs4vclGpnhLczjbW8LHZeFExADgJZGh4B0P51t/vsfUjW9M3VjjJLnMpbVc8XqqXg107TaLpZTP+zuoOMNRlcxX7dET6X2KCL7rIX7sh3gsBbKcY1KeiZNp3TFRkQnKZY5CrrzHtctx/apE0+dRAEq8Y87srsXPnUtZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BBmW8jOL; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BBmW8jOL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780894470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJZD1v0uKmRwmTPQY9fhrdbUR6X2mcRzW3srSSIJVBc=;
	b=BBmW8jOL6IGP4OdE9Tk2dDZ6XAZ07VWn9whCfkMIctmLJAFFQ8LHl3pqu76fyNCyFSDjaq
	tqprhwUKy/lu381KF5DjqtOYK7/1NHPLjz2i56t5p5q7L9rYSQF2gDaL7zqSaVdhlFOy1m
	42nqER2YRyBfnjvZfD8in49rQbw+DNw=
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
Subject: Re: [PATCH mm-unstable v19 06/14] mm/khugepaged: generalize collapse_huge_page for mTHP collapse
Date: Mon,  8 Jun 2026 12:54:13 +0800
Message-Id: <20260608045413.70658-1-lance.yang@linux.dev>
In-Reply-To: <20260605161422.213817-7-npache@redhat.com>
References: <20260605161422.213817-7-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Jun 05, 2026 at 10:14:13AM -0600, Nico Pache wrote:
>Pass an order to collapse_huge_page to support collapsing anon memory to
>arbitrary orders within a PMD. order indicates what mTHP size we are
>attempting to collapse to.
>
>For non-PMD collapse we must leave the anon VMA write locked until after
>we collapse the mTHP-- in the PMD case all the pages are isolated, but in
>the mTHP case this is not true, and we must keep the lock to prevent
>access/changes to the page tables. This can happen if the rmap walkers hit
>a pmd_none while the PMD entry is currently unavailable due to being
>temporarily removed during the collapse phase.
>
>To properly establish the page table hierarchy without violating any
>expectations from certain architectures (e.g. MIPS), we must make sure to
>have the PMD reinstalled before the PTEs, and hold both PTE/PMD locks
>before calling update_mmu_cache_range() (if they are distinct locks).
>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---

Nothing else jumped out at me. Anything left can be sorted out later, as
David and Lorenzo said :)

Reviewed-by: Lance Yang <lance.yang@linux.dev>
