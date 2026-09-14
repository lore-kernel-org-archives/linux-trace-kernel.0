Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC53AE198;
	Mon, 14 Sep 2026 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371489; cv=none; b=BEu6ns7lkwuvm9bw6OyDkJM7xK1gvZKQ5r7/iHzvhRG2MaJU8AUPfeeq42X7gpRvDnMqLY95exRmyzX5dmV6AZGBwGS/K1GqCNzlWsvhhI35WuR80GS1/GsrenxWyVDqug8zLemqJlr+rYWAvpAUHrEVHqZUnOO1ChTDx0U/YEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371489; c=relaxed/simple;
	bh=Tm+mQ421+Wocu9lAdV7dFB9wj/TZx+TkgFxBg8vVLxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoFTqmJF+eVvF4nLVi5+X7icdghHw8qjGzkZwwdLlKG8jBGE915xnVrgbP2QSJsj+z2+basXcCbACFI/PCoMBfaxcR+PBkNt5XjeQq88vbpP31EfPEQ7bu6wklue/mQKmzvH4EC+KxBWvHIQ1v3eE1Zxl+N2KQlYDUDdadltuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TtklKYro; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TtklKYro"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789371483; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AYeier6a0sYH1m4ZQPsRiy+kEyAThBjcd7upAQ2zUUs=;
	b=TtklKYroEmbKeJolBXPtC57Ejtci5DMQ8qRNuS8KlNfOWFKGWEaFLxmei3HOUxSDETJBNJ/sBD5zRalpv40IMzcSa1OrCoJbSseTsI9F2EGCH6iCDk4EZ2O0SWT6b74ZiNkeAqEbpVgCHXU1t7ePY6WWqREvgWnZpBmrc0+em7U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XAsfnHs_1789371480;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XAsfnHs_1789371480 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 15:38:01 +0800
Message-ID: <8e3147dd-0ef5-486c-b635-a34bd29b25e3@linux.alibaba.com>
Date: Mon, 14 Sep 2026 15:38:00 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm/mglru: add tracepoint for inc_max_seq()
To: Ridong Chen <ridong.chen@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 "open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260911102939.2485750-1-ridong.chen@linux.dev>
 <20260911102939.2485750-4-ridong.chen@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260911102939.2485750-4-ridong.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/26 6:29 PM, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
> youngest generation. There is currently no tracepoint on this path, so
> the moment a new generation is created, and how the min_seq of each type
> trails behind it, cannot be observed as it happens.
> 
> Add mm_mglru_inc_max_seq, emitted right after max_seq is bumped, with
> the memcg id, the new max_seq, the anon and file min_seq, and the number
> of pages in each generation for both types, summed over zones the same
> way the debugfs lru_gen file reports them. The nr_anon/nr_file arrays are
> indexed by generation slot, so the emitted max_seq/min_seq say which slot
> holds which seq. They are printed with __print_array(), so the output is
> hex and its length follows MAX_NR_GENS automatically. Paired with the
> mm_mglru_scan_folios tracepoint it makes the full aging-to-eviction
> window observable per memcg.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
