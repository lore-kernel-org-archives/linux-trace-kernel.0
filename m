Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428135DA40
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 May 2026 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238740; cv=none; b=Vqz0dXHohzYpn2JuDoFddtaaSjyd3IsaFMtYtpU3DYrWIXFhidnBHSOwdLZaKxKhsann6B1WtIamE+bBBMD4QpKYuH2jFZPg9dJY85hlLiwpdALtwl7qKoggMupaF/5cm0+HO4ow8/9bwTxR3aL3VdkjxDSsE0DTzoTL5Fp/MGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238740; c=relaxed/simple;
	bh=WQis/+eM7l1uAKIgv3HxViGZpt+nFeQRW+hLB5igYBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeINmfBFCKIRLsYXHl3KccM30DU7MAE14YET/v8pCFnjVb6cDjex6mLmKAqisX3LcpYcT6YEonvQ8reZ1ePTjPWJBcjWCQU/SoAGXGNlODOPUGeM7WYGP918m8yB+YpBXWgU0+8UyJkqR0oT9pnrKXEunfoCuYdAL4IT3Uz3ezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
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
Date: Fri,  8 May 2026 19:11:50 +0800
Message-Id: <20260508111150.16625-1-lance.yang@linux.dev>
In-Reply-To: <20260419185750.260784-4-npache@redhat.com>
References: <20260419185750.260784-4-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Sun, Apr 19, 2026 at 12:57:40PM -0600, Nico Pache wrote:
>The following cleanup reworks all the max_ptes_* handling into helper
>functions. This increases the code readability and will later be used to
>implement the mTHP handling of these variables.
>
>With these changes we abstract all the madvise_collapse() special casing
>(dont respect the sysctls) away from the functions that utilize them. And
>will later in this series to cleanly restrict mTHP collapses behaviors.
>
>Suggested-by: David Hildenbrand <david@kernel.org>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---

Nice. It should all be an equivalence-preserving refactor.

With David's suggested changes:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
