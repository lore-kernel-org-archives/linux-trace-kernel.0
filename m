Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337C318EFF;
	Mon,  8 Jun 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903694; cv=none; b=q8z8N1tEZ6xITJ6yGFNEMoyCLR3X2W8HjkO/Nlg5gbzkMuvwALYAKpqQVEuzc0GXIldWuSNqEU/XgIF3hM7BMpA1+80DEAkbLhYomVcyIcFD13jl/kpqaSwnjFCwSzsI2mp9c2i4VYWsrBQNNv5y36z9/JApT8TM+cSt/05KYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903694; c=relaxed/simple;
	bh=o+UEQbg6AU+TfmK805SP5EpbQqdODkwRVAGdZoxB4k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkgzy6RFJ8hL7ghbvhVfG/PVQHOYNPG2vvql1yrgrgjFNsjEwGmGqE2qv7/hqYauUxUN39H5zzkx0zM/JONfk+GBuCt32SLJr3yKihud1SFLnQUbD+5rsGTx+NdVsgjaj8DCCGdsZk/KpUNkrXxfCNFUiJSikYc69OZ4KrOj+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JpHaj0hz; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JpHaj0hz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780903686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+UEQbg6AU+TfmK805SP5EpbQqdODkwRVAGdZoxB4k0=;
	b=JpHaj0hzUy6GWQsoTGmReTbCiT4mzU8p/9whZkTeag+RVJS1KqdqB4P11lEZ5gdN3qeXnk
	Sc4Wh0u1hgK7ingH1qu7mkNb3ZzFeUCmIzLy5JbnPQinOCngV6DG7j0F77wzzvoaUgYYG9
	aNWKbMFCupxYA3dOUJp1SES55xPBXCk=
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
Subject: Re: [PATCH mm-unstable v19 10/14] mm/khugepaged: introduce collapse_possible_orders helper functions
Date: Mon,  8 Jun 2026 15:27:47 +0800
Message-Id: <20260608072747.88417-1-lance.yang@linux.dev>
In-Reply-To: <20260605161422.213817-11-npache@redhat.com>
References: <20260605161422.213817-11-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Jun 05, 2026 at 10:14:17AM -0600, Nico Pache wrote:
>Add collapse_possible_orders() to generalize THP order eligibility. The
>function determines which THP orders are permitted based on collapse
>context (khugepaged vs madv_collapse). We also add collapse_possible()
>as a thin wrapper around collapse_possible_orders() that returns a bool
>rather than the whole bitmap.
>
>This consolidates collapse configuration logic and provides a clean
>interface for future mTHP collapse support where the orders may be
>different.
>
>Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
