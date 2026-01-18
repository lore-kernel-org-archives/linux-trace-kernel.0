Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016319C54E
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712958; cv=none; b=M7gUNIE5Q3XtSruLEFzlVimKsHIqJJH5pcehUdJUBNQ1cAyBKwOxX+X45x35RdqJ6a29HnzkG6PPj9JDMdkoezARWokccwIuOj557B8ROR3PVs9WlwNf+dYmrQn/7Mxu43rRa3Ck+IWSwOgNiSm4QRt6bgfzHk9OzrCLJeZygSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712958; c=relaxed/simple;
	bh=TX/0WT/iMd81H6VN9GAm1XBW6cDZA2LMJ0HATXySQgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ6M/kpJh2psIVPdmOgMiPRPs01gvj22gumCQiayys2WX03IbwdtksZGuyxYp+nSbONg+uORUPCdlOqDHHzMwVAlBZACVFGbAf1u2eXGf9wLHvwcWnZaWKD9RkvN1Y6ZPRlwbRwTrsNTU5y/AQGjl51j+pYzm2CLpMQusw73H6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MtKxHAq5; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MtKxHAq5"
Date: Sat, 17 Jan 2026 21:08:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768712944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcdCzCeZyy+3wcJ3ycr2MFhPXDKfMUMZ+CbutgXspfU=;
	b=MtKxHAq59xa92tBu3FCniyhCEgQ/N3jO/AK5C2D6xr2EtCr1iPYL6VkwbyipSetlILjwL3
	dcEaP3370HFnVDEftsUmPo4xrJHlw0xGVq2YoTG0MpDqeWDPFk3c4QnQmgMhXbvaqsd4PQ
	9vxcB8SatgqtNQTbnQ0MtphswQk3nPk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/vmscan: add tracepoint and reason for
 kswapd_failures reset
Message-ID: <eincfrroi5qp254yv7stkayzy2eayw2zgrjbq2w4icrknkze2l@yodvhzqggxkm>
References: <20260114074049.229935-1-jiayuan.chen@linux.dev>
 <20260114074049.229935-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074049.229935-3-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 03:40:36PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Currently, kswapd_failures is reset in multiple places (kswapd,
> direct reclaim, PCP freeing, memory-tiers), but there's no way to
> trace when and why it was reset, making it difficult to debug
> memory reclaim issues.
> 
> This patch:
> 
> 1. Introduce pgdat_reset_kswapd_failures() as a wrapper function to
>    centralize kswapd_failures reset logic.
> 
> 2. Add reset_kswapd_failures_reason enum to distinguish reset sources:
>    - RESET_KSWAPD_FAILURES_KSWAPD: reset from kswapd context
>    - RESET_KSWAPD_FAILURES_DIRECT: reset from direct reclaim
>    - RESET_KSWAPD_FAILURES_PCP: reset from PCP page freeing
>    - RESET_KSWAPD_FAILURES_OTHER: reset from other paths
> 
> 3. Add tracepoints for better observability:
>    - mm_vmscan_reset_kswapd_failures: traces each reset with reason
>    - mm_vmscan_kswapd_reclaim_fail: traces each kswapd reclaim failure
> 
> ---
> Test results:
> 
> $ trace-cmd record -e vmscan:mm_vmscan_reset_kswapd_failures -e vmscan:mm_vmscan_kswapd_reclaim_fail
> $ # generate memory pressure
> $ trace-cmd report
> cpus=4
> kswapd1-73  [002]  24.863112: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=1
> kswapd1-73  [002]  24.863472: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=2
> kswapd1-73  [002]  24.863813: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=3
> kswapd1-73  [002]  24.864141: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=4
> kswapd1-73  [002]  24.864462: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=5
> kswapd1-73  [002]  24.864779: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=6
> kswapd1-73  [002]  24.865103: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=7
> kswapd1-73  [002]  24.865421: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=8
> kswapd1-73  [002]  24.865737: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=9
> kswapd1-73  [002]  24.866070: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=10
> kswapd1-73  [002]  24.866385: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=11
> kswapd1-73  [002]  24.866701: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=12
> kswapd1-73  [002]  24.867016: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=13
> kswapd1-73  [002]  24.867333: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=14
> kswapd1-73  [002]  24.867649: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=15
> kswapd1-73  [002]  24.867965: mm_vmscan_kswapd_reclaim_fail: nid=1 failures=16
> kswapd0-72  [001]  25.020464: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=1
> kswapd0-72  [001]  25.021054: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=2
> kswapd0-72  [001]  25.021628: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=3
> kswapd0-72  [001]  25.022217: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=4
> kswapd0-72  [001]  25.022790: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=5
> kswapd0-72  [001]  25.023366: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=6
> kswapd0-72  [001]  25.023937: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=7
> kswapd0-72  [001]  25.024511: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=8
> kswapd0-72  [001]  25.025092: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=9
> kswapd0-72  [001]  25.025665: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=10
> kswapd0-72  [001]  25.026249: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=11
> kswapd0-72  [001]  25.026824: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=12
> kswapd0-72  [001]  25.027398: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=13
> kswapd0-72  [001]  25.027976: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=14
> kswapd0-72  [001]  25.028554: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=15
> kswapd0-72  [001]  25.029140: mm_vmscan_kswapd_reclaim_fail: nid=0 failures=16
> ann-416     [002]  25.577925: mm_vmscan_reset_kswapd_failures: nid=0 reason=PCP
> dd-417      [002]  35.111721: mm_vmscan_reset_kswapd_failures: nid=1 reason=DIRECT
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Thanks for adding this.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
