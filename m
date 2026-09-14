Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7034D3B9;
	Mon, 14 Sep 2026 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369777; cv=none; b=Wx099F431FUVCekUR7Eby1A/56/zyG0sEZFBE8AdCJuedtaRNdB+FfzWPioKkCJnVs07PuUqBHIvaFG90BRpSibkkBIqoecrM+JGkFwVIn+4eyBeaK9sc46hnXtRSQa0X67i/aI6voeV7IUkRZu84OLCzPsfTPWy3E2tXAlCmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369777; c=relaxed/simple;
	bh=DoYL3snGn616IhdKPpLUNFMaWRRKzjQKy1uQEI5wzFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6X5tKvtjG7jjXXeXejCw+uJS631e6AwTWEUFJMQi7537SPChAzu3FGbmO173tXpVkMtwQ1BkzhhZXb7ew+Ebk+Sr1LIud+K7i7dGm0LVbgNlqsiNOHnBiDKWqxSAm+kIaNa+8IIfE3Rx8N8ZwYVX6jGdQu3kQPvkueJpggPugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M3Gv9R1q; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M3Gv9R1q"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789369772; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dY/tbtHXJyrWy4yy4iw+QpX+GNXsYElEvogCXMRcIqg=;
	b=M3Gv9R1q9HThYMM90V0YMMBL4OO2m4lZ5UO9dkdj4/DlqoNoOpxD4unL3KWTQPooQa6qZel+LR85x7iRrpa4Apr2IsGDIlOwuT599UknwfTAY88IzazrDyhPZTI1j6q9KSsnnY6+BZOWY+Huj++C5UYQpHVWSHDtviEaDQE2WMQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XAsx57d_1789369768;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XAsx57d_1789369768 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 15:09:30 +0800
Message-ID: <093148f4-ed10-4e41-939d-be82e2844fc5@linux.alibaba.com>
Date: Mon, 14 Sep 2026 15:09:28 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/mglru: factor out lru_gen_seq_nr_pages()
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
 <20260911102939.2485750-2-ridong.chen@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260911102939.2485750-2-ridong.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/26 6:29 PM, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> Both lruvec_evictable_size() and the debugfs lru_gen_seq_show() compute
> the number of pages in a generation the same way: sum lrugen->nr_pages
> over all zones for a given (gen, type) and clamp each term to >= 0.
> 
> Factor that out into lru_gen_seq_nr_pages() so the open-coded zone loop
> lives in one place. No functional change.
> 
> A follow-up patch adds a tracepoint that needs the same per-generation
> page count, and will reuse this helper instead of open-coding it again.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
