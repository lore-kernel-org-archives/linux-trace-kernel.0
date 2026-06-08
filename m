Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DB318EFF
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903170; cv=none; b=lmI/WED6Mf0N6abemxSPsBLraRodN8InhtWn3QJtQFXFlySmsKRS6WSsP74ASTLFUaloB2gQ/i/3wGDpySJw0RFoUDRGMQOc1TXQQ17x4GEVYBbWNqxz/RCALh1HXUT2IFV4SQwXjFPSi4hgMQZxW9I2hX59qDkzz+T3H59KRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903170; c=relaxed/simple;
	bh=2l3Ys9A0d7kMMYqyWyEIIwgaM2b28UgnM/Zf6Rmaavs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jb1IyVy9j8BM3I/NXh1UricbI2C+KaTYD6aH0lcWHVDaKyrmVL6fZ78fT+hT9eJ+9K/asNEMZay1/Y4UOKjyMxF1Bd0kIOrydBWeJgLneNMg+0nlcNRx8Tmc6dB4+1VsWmUil4CVPlMgPgoHmQUWAWYk5BUH+2Kc7gryBHSt7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D0JOnQZu; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D0JOnQZu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780903164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2l3Ys9A0d7kMMYqyWyEIIwgaM2b28UgnM/Zf6Rmaavs=;
	b=D0JOnQZuPDhZzxZuSjhJhdOLC+GZpAev1ypxJ6uQBHSkd6EdY6SwAOV915TmagKr2IOF6x
	TGVaaIZy2hJhjPEDqYrjbCaLBN31Ph86m1L1SuK8edrzff325L4wKYQ0RTMz0JxzpCb/dT
	SEFZsbuASzgj7yeeY4Bv/8kqMJIbhyI=
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
Subject: Re: [PATCH mm-unstable v19 09/14] mm/khugepaged: improve tracepoints for mTHP orders
Date: Mon,  8 Jun 2026 15:19:13 +0800
Message-Id: <20260608071913.81568-1-lance.yang@linux.dev>
In-Reply-To: <20260605161422.213817-10-npache@redhat.com>
References: <20260605161422.213817-10-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Jun 05, 2026 at 10:14:16AM -0600, Nico Pache wrote:
>Add the order to the mm_collapse_huge_page<_swapin,_isolate> tracepoints to
>give better insight into what order is being operated at for.
>
>Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>Signed-off-by: Nico Pache <npache@redhat.com>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
