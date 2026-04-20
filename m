Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F83AB27F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Apr 2026 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690989; cv=none; b=OnfN8Gc+UG+aUtrBOdBY0SfjBUhxBUSJuLzWOPwLUuWyUt+x5xhv6/WpM0h5n4MAvK4zZazUmSoruwZBlPU5Ywb8OLeGLWYnev8xW4w2j1GuTuz32Uex6MnU90WqJnJ69eyDVkefG33R0nchVA1/grV6ZY4mVQOGirlmlI6Xn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690989; c=relaxed/simple;
	bh=JIo7dZkT6VZYhrI91hnDATjlBULDOeJvY7ZXahco84I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ8IPqp0xo5/qL8DTKyvI/MDIgrfw2KxAWC3iYvtLMZneZB65a3k72UVFeb/DVlXE6oukBdNr9KEyeNeqc2jxe8IgxVrv4xBohw+NyVApcI4y2LLaFg9WuL/BJ2JFhRLZ9fofqw1PgO1U8d7jG7ExSwR++cJ6Z8zbYzMJThpc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T2LV6+Is; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T2LV6+Is"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776690974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsatqlpFXZFNi8Kl9ZLgdLvl4wOAHcOCp2o0dzIKpJY=;
	b=T2LV6+IsNzeXUOci7LW3i7gkiXJBoEaQxrMm8jqfQoQgsCiebwzcF3GmF6j5s+nonfNmAl
	ihVck8om9+Gy2IOQu2HefU5g4FAUS4zaBANZdgWWntieO5VCLJfyqhW7Y5foXCOqj5+976
	y6CLSWU58gqI2rcnbNAfmn6UjTr3xLA=
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
	Liam.Howlett@oracle.com,
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
Subject: Re: [PATCH 7.2 v16 03/13] mm/khugepaged: rework max_ptes_* handling with helper functions
Date: Mon, 20 Apr 2026 06:15:48 -0700
Message-ID: <20260420131549.3673619-1-usama.arif@linux.dev>
In-Reply-To: <20260419185750.260784-4-npache@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sun, 19 Apr 2026 12:57:40 -0600 Nico Pache <npache@redhat.com> wrote:

> The following cleanup reworks all the max_ptes_* handling into helper
> functions. This increases the code readability and will later be used to
> implement the mTHP handling of these variables.
> 
> With these changes we abstract all the madvise_collapse() special casing
> (dont respect the sysctls) away from the functions that utilize them. And
> will later in this series to cleanly restrict mTHP collapses behaviors.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 114 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 78 insertions(+), 36 deletions(-)
> 

The old code re-read khugepaged_max_ptes_* on every loop iteration; the new
code snapshots them once per scan call. If userspace writes the sysctl
mid-scan, old behavior reacted within the scan, new behavior uses the value
sampled at entry. This is completely ok IMO, but might be good to call out.

Also might be good to write no functional change intended apart from
above in the commit message?

Acked-by: Usama Arif <usama.arif@linux.dev>

