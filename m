Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415939FCD0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Apr 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690366; cv=none; b=dy35oUVPBoDfhtlL18d3HBcTxbVvTm7sUgjrAqBCV+WwpI4egmYX5XRpNbV6YH4Ssg6mEzyFY7peHeHfIn6A1fB7gFIhp8pdGxZOGuoUVPrxQ20R4S+AkDphaQILWqMHMB+9KkPADjqCsdiESelv+ws/SJPjSXu8yhY8BC5oIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690366; c=relaxed/simple;
	bh=DaQyWMKydwbGfqZaQx7oR0M7i7mMBqwBBYyalOJ48TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETXKJHNDZfF61h3aTqol87R6qdnDRqaTUfhyMFAxLT5z35PUQmpGPWNd5KORaZp76KN7ixnAlxilzjCbckphECYbmqdhgGSP+GuMP3bHHJNmOWE9nN5wi84iD5ffXVZbrx6jSlrQZoFdwxeh2xUY5+YJwQKMp8cCI0xf2DSLeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xTp6KYy0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xTp6KYy0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776690347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o1Kvc1FhWv3hcUBdL9Fd1FKJEXKxrOb0wzsGmpz0qg=;
	b=xTp6KYy0xa4dIGcf4gFeKo7RLoE8gL95mM2ODmIY1tlpjleQnN0sElKN9BwkisufynAsag
	67Xm/OY1u/29XcXRdR3es/MdW66TZnW5SH/XVez4i/sUxnYFsvKz1T3eAOT13qdFidzrv8
	scpzSE2lP5JsR70T5RDPDui/uPsIFrY=
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
Subject: Re: [PATCH 7.2 v16 02/13] mm/khugepaged: generalize alloc_charge_folio()
Date: Mon, 20 Apr 2026 06:05:36 -0700
Message-ID: <20260420130538.3537743-1-usama.arif@linux.dev>
In-Reply-To: <20260419185750.260784-3-npache@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sun, 19 Apr 2026 12:57:39 -0600 Nico Pache <npache@redhat.com> wrote:

> From: Dev Jain <dev.jain@arm.com>
> 
> Pass order to alloc_charge_folio() and update mTHP statistics.
> 
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |  8 ++++++++
>  include/linux/huge_mm.h                    |  2 ++
>  mm/huge_memory.c                           |  4 ++++
>  mm/khugepaged.c                            | 17 +++++++++++------
>  4 files changed, 25 insertions(+), 6 deletions(-)
> 

Acked-by: Usama Arif <usama.arif@linux.dev>
