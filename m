Received: from smtp186.sjtu.edu.cn (smtp186.sjtu.edu.cn [202.120.2.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A1191;
	Fri, 24 Apr 2026 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776991593; cv=none; b=aNBnBr1kScjucbkfVOh6JpyOeFUC7Yq/Wfabdty+aNWBuw0u7EVSIu284/mNeLpu2rbQmOe8zGWLO06WdXUuS/zBXKeBQHOr9btBsUNMSYIjKZ9DAast/Ow/WkURUNYAT4cBhfj5IHmkBqcAxOMqzfMhPf6wUbI9Q1zYlSR3eUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776991593; c=relaxed/simple;
	bh=aIh3vuNWs698cufhEU48wc0UUTbQ+aQCfDyolphe4Y0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=G25p7j8DG4f7s1uf6/6la0Qi2lyOkyQGilxi06UAXJflGY93W/8WLos58IlOZg6SwPkRK+qfHNdldft9Z7QC4gQhDxGOG5OBSJ3AvoW0QQgy+2Wg7YoazK1B3zX8Ra3BxdqxT6NLHvSJpyGKZ93XKtot8eMXr4oqt0XvfP2PteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=KW/W8u26; arc=none smtp.client-ip=202.120.2.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="KW/W8u26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1776991586;
	bh=aIh3vuNWs698cufhEU48wc0UUTbQ+aQCfDyolphe4Y0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=KW/W8u26MLjmPK5gqJxgNhzyt0nHC7gcQTPIxf79Cw7UKILQq0OzKqQCXb/R1tSLt
	 97L3wKrTRcshdrb6448Mh5amaJiI+O3KVQ5d++Hyb+vdpfybx5tJnuF2bHLKjbgkOu
	 kkDDAYR0nTUJCIN1D9WmF9HsPQV9lqjq7PgLxvbDGiymwoYpQW4lqudosjRlAFLrFC
	 xNwdWcQu41TAlF1/u+gQrhj7KAaQFubTISgAz1HvsUKzue+yP5mY31ki7FN5e9y8/L
	 jLHQ4BmdycEe69BzSLwJ2Wx0N9skmyYLd379ePo9Bgmr3AObEBIEUsPXsNJjYpUOXG
	 V1L7RhYaUnGOA==
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
	by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 102562FF455;
	Fri, 24 Apr 2026 00:46:26 +0000 (UTC)
Received: from mstore137.sjtu.edu.cn (unknown [10.118.0.137])
	by mta91.sjtu.edu.cn (Postfix) with ESMTP id A55EF37F802;
	Fri, 24 Apr 2026 08:46:25 +0800 (CST)
Date: Fri, 24 Apr 2026 08:46:24 +0800 (CST)
From: SUVONOV BUNYOD <b.suvonov@sjtu.edu.cn>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, david@kernel.org, mhocko@kernel.org, 
	zhengqi arch <zhengqi.arch@bytedance.com>, ljs@kernel.org, 
	mathieu desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Message-ID: <1868971658.1970916.1776991584726.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <aepavbLy7H3odp6p@linux.dev>
References: <20260423103753.546582-1-b.suvonov@sjtu.edu.cn> <aepavbLy7H3odp6p@linux.dev>
Subject: Re: [PATCH] mm/vmscan: add balance_pgdat begin/end tracepoints
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.0.18_GA_4835 (ZimbraWebClient - FF149 (Linux)/10.0.18_GA_4828)
Thread-Topic: mm/vmscan: add balance_pgdat begin/end tracepoints
Thread-Index: FmqamJoTP0RVjIuNzdboLtlnAuPAew==

Thank you for reviewing Shakeel,

> Do we need to trace highest_zoneidx at the end? Can it change within
> balance_pgdat()?

highest_zoneidx does not change within a balance_pgdat() invocation. It
is passed in as an argument and remains the classzone bound used for the
balancing checks throughout the function.

I kept highest_zoneidx in the end tracepoint to make the outcome event
self-contained. In principle, begin/end correlation is possible, but
under sustained memory pressure kswapd reclaim can be frequent enough
that consumers may prefer to analyze end events directly, and any
dependence on matching begin/end becomes less convenient and less robust
in the presence of filtering or dropped trace records.

Since nr_reclaimed and the final order are only known at the end, having
highest_zoneidx there allows end-only analysis without correlating with
the begin event.

For example, it lets users answer questions like:
- this pass reclaimed too much or too little memory; what highest_zoneidx
did that result correspond to?
- how much reclaim was done when balancing up to ZONE_NORMAL vs other
classzone bounds?
- when highest_zoneidx == ZONE_NORMAL, how often did reclaim finish at
order=0?

So it is there because it provides context for the end-of-reclaim result.
Do you think this is sufficient justification? If not, then I can drop it
from the end tracepoint in v2.

----- Original Message -----
From: "Shakeel Butt" <shakeel.butt@linux.dev>
To: "Bunyod Suvonov" <b.suvonov@sjtu.edu.cn>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, rostedt@goodmis.org, mhiramat@kernel.org, david@kernel.org, mhocko@kernel.org, "zhengqi arch" <zhengqi.arch@bytedance.com>, ljs@kernel.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Sent: Friday, April 24, 2026 1:46:55 AM
Subject: Re: [PATCH] mm/vmscan: add balance_pgdat begin/end tracepoints

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
