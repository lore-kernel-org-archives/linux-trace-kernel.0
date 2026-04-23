Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1137B40B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966424; cv=none; b=mAoxYW6Y5XNTIqB+/pBmmN8BcKW6pp0c+JOQTC2XEfm+GLzkxH6dTxseq+1+x58ASJR6j7hI3b+txzHhxIB3PTfOmC9vEOWG4SLCMToDQdtekS8p5wNTsGbAPD+YtHNuUYX4ZHXMjQN95AfLdl7FqiKGyQXPNACXPjvz+/3ri3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966424; c=relaxed/simple;
	bh=vjIKe7kl5sDZofM3PgeyAZu6CZ2DHx1btatU9tOUE1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2VvmV98068K+BxXS0Aw/LtGIwp16QP4mBGnUO9qZDfTyoFa7p+T20LpTAolX8mAM4lsnR/2reiZsr0mpCMdeS5TgDb9H5QY9OZqNY9/rlAGdxP0c+3M+6y8hCT3oT71EsAPtbkW0UtuQhjFfuXAle2DOapLeUOIOvU1WgsV2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vQQu5ula; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vQQu5ula"
Date: Thu, 23 Apr 2026 10:46:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776966420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hxsr+udpgbwIYSFqjXA38j1VeRgFqtPhxMcbAqGt65A=;
	b=vQQu5ulazW72Tyv0T5UWjs7MxU9nwVAXIS1eg0GWewP+Ht1SgXyT4DnYC6k6AFCp0fJZ9t
	Ql1oxZJ58pQzxwVJADzvXumiZQxlta99GSevB52Xg2XhkBBEopVx7tMNMg2Ctd6f9MGIhr
	diPBR6XAbkR69VRGs6Yndoz3BmgewHM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, david@kernel.org, mhocko@kernel.org, zhengqi.arch@bytedance.com, 
	ljs@kernel.org, mathieu.desnoyers@efficios.com, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: add balance_pgdat begin/end tracepoints
Message-ID: <aepavbLy7H3odp6p@linux.dev>
References: <20260423103753.546582-1-b.suvonov@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423103753.546582-1-b.suvonov@sjtu.edu.cn>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 23, 2026 at 06:37:53PM +0800, Bunyod Suvonov wrote:
> Vmscan has six main reclaim entry points: try_to_free_pages() for
> direct reclaim, try_to_free_mem_cgroup_pages() for memcg reclaim,
> mem_cgroup_shrink_node() for memcg soft limit reclaim, node_reclaim()
> for node reclaim, shrink_all_memory() for hibernation reclaim, and
> balance_pgdat() for kswapd reclaim.
> 
> All of them, except for shrink_all_memory() and balance_pgdat(), already
> have begin/end tracepoints. This makes it harder to trace which reclaim
> path is responsible for memory reclaim activity, because kswapd reclaim
> cannot be identified as cleanly as other reclaim entry points, even
> though it is the main background reclaim path under memory pressure.
> There may be no need to trace shrink_all_memory() as it is primarily
> used during hibernation. So this patch adds the missing tracepoint pair
> for balance_pgdat().
> 
> The begin tracepoint records the node id, requested reclaim order, and
> highest_zoneidx. The end tracepoint records the node id, reclaim order
> that balance_pgdat() finished with, highest_zoneidx, and nr_reclaimed.

Do we need to trace highest_zoneidx at the end? Can it change within
balance_pgdat()?

> Together, they show the requested reclaim order and zone bound, whether
> reclaim fell back to a lower order, and how much reclaim work was done.
> 
> Signed-off-by: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>

Overall looks good. 

