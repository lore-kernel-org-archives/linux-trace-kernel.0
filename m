Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B73246ED;
	Fri, 11 Sep 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136043; cv=none; b=JBhkjhjTmyJkTk0VOv0s7PYLe6xJJI92mwFNlADn/NZuUAg0MHP47hqfRbjRIq8wjNj2Z8H5WkBSLkN7AlUcR15To27+XODxlH3UBive/GEDX2SKtVew1mf5o9bJ98k/xcPb8kO9WLKjHH3Xz4ne0y1tkkAAdqpWlpwBA5UY0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136043; c=relaxed/simple;
	bh=S6vlzaHOdAux3Ddwra4hz2bRHO+mzq2XjnWcy5LThPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DL3v/UR0whFOGRlVpt9cQYoZTvZG0CuFHJYGLaFqvJliaw/ZK8MtTNW9ourdXpr7nmlrSoyoVGSNVmyK4SRh/YhXW38n1AXSwwc22mPnitIM6HNskbYAzjuMRDnsbzss60t8InW6HLF+xwTSm/EN7UfU3GY3g7tDVzdlUJnBsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=gMEucxCm; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="gMEucxCm"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A0465120233;
	Fri, 11 Sep 2026 14:13:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 8732930;
	Fri, 11 Sep 2026 14:13:53 +0000 (UTC)
Date: Fri, 11 Sep 2026 10:15:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Kairui Song
 <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org (open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)),
 Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH 3/3] mm/mglru: add tracepoint for inc_max_seq()
Message-ID: <20260911101514.1fe0d543@gandalf.local.home>
In-Reply-To: <20260911072848.2346073-4-ridong.chen@linux.dev>
References: <20260911072848.2346073-1-ridong.chen@linux.dev>
	<20260911072848.2346073-4-ridong.chen@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qr4g4u3oti97w6r1wxsyfguoh8eifpso
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8732930
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/kRIOymlh/yRyLjmb/AHjuhpRO+qc1TOM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5pF7UOjJ0Hc92aoK/fGuwkSEqe18l+crBILfTSieFQI=; b=gMEucxCmj+6pFz+an9E4ANtASc6LfKKjFrswxZXbzlFzbRl3RMdZLezICim3m1D1g+EltbA0AAxcxjZFkzndutpjigSaREYcKBm39wpsCuSHyuYubGObgHzIORQtGzsUOg33YwZFKldCDQEv6aFsY6RAuM/Ir1V8sGRif+8R4bk=
X-HE-Tag: 1789136033-909403
X-HE-Meta: U2FsdGVkX18Qy0hiLDQcFnE98ah35wCu1vIZzyuKl27gM6+rsq3zuBhpsZz4DS2UvGVcZDbYIned2LtehysThjsjLGLHrdUWkQO224ES2ZkL301BaOUl6XrGBSbFka66RgDtbg6JYpyv9aO8iiY3TRMnOWzfyTrcUqfSAY3/ToMushNHQRVdRsO1VY0kvWMhsLznxmy3891Dh/u+rzgtmDUGFHgWmliyPOkVS5FgDqE72MLKWKK8Cnh3hg1lRCnBkS/HUCLJycBe3E4PEJywVWOxSdwPI6+AI8tfPz/4xya2HNCyXd89jbSacEhJYkeY

On Fri, 11 Sep 2026 15:28:48 +0800
Ridong Chen <ridong.chen@linux.dev> wrote:

> +static void trace_inc_max_seq(struct lruvec *lruvec)
> +{
> +	int type, gen;
> +	unsigned long nr[ANON_AND_FILE][MAX_NR_GENS];
> +	struct lru_gen_folio *lrugen = &lruvec->lrugen;
> +
> +	if (!trace_mm_mglru_inc_max_seq_enabled())
> +		return;
> +
> +	for (type = 0; type < ANON_AND_FILE; type++)
> +		for (gen = 0; gen < MAX_NR_GENS; gen++)
> +			nr[type][gen] = lru_gen_seq_nr_pages(lrugen, gen, type);
> +
> +	trace_mm_mglru_inc_max_seq(mem_cgroup_id(lruvec_memcg(lruvec)),
> +				   lrugen->max_seq,
> +				   lrugen->min_seq[LRU_GEN_ANON],
> +				   lrugen->min_seq[LRU_GEN_FILE],
> +				   nr[LRU_GEN_ANON], nr[LRU_GEN_FILE]);
> +}

I would always look at trying to move as much logic into the
TP_fast_assign() and not have it be where the tracepoint is called.

-- Steve
