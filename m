Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503253;
	b=o9fOIQYuLLBkS39AEw8T11CfmcJ6xidusbTdG7h0KvZ6JlQo3BrnhvuNEPufuhXN0yTG
	 CfvsFqk0HExQgHdhBm82Yc6uu62+0VI7G/6xE+HaIxn+ZpyhLjOm60DX6M014B+QKaCqv
	 KZHw5A/J8+utb0DcDmbSryOIz1X05o4Df2pMul+RXQk5ubeY2BmBQoX06k43abh8ri6D3
	 Lr6mfGPeGR+L/dVOr5MC+19XqheIOIRaDXaJ0vCA3I7xmEX0hP8pgL1kZ0iJtv2cfXOOg
	 jOTKtEDCLYWu36Fq7Wibqrf3PV/b5n1njJQLuGCEiKCDuShwCoVOjHK74LomFIncflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503253;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FbZweDIxhmL7siggWffrhdl3D49Th5aeEe2VbeYB8MQ=;
	b=N3B7sEEgIF6qhScMezqeOIjBFLLUjsOfQHPkqT4RKX3z9mh/j2dVxpKPqGSezNxDoqgo
	 5NzCnCi/zS4FDuYMDek3movmpapHs6CnxzUrKoyW0ttVAIjeY0EIWMWRxSMOHNC5G0oGu
	 n2wj1SiNyiiKzm2Q+DTF3u3h301c7TYln21oX7HRbQR91dsYW0np2kBTBiLw+9ddN/c+p
	 5ELinkU1CFscVEG3XKc8ZDuZo6kfXyKV6I4rob74R6PCU74Kg8NRxaqUDDZMstfPhu7Pd
	 F2Dza+XlwVGVq+b+7H2hIcz3oVnVoxp/m/u4/PG+lxfrVW0yJdjyRADU0+2n5HxVgig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AsHsd6iv;
	arc=none smtp.remote-ip=95.215.58.168
Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F74606A327
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 03:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31F74606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AsHsd6iv
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DY5Hprcbq1eAPJOCDEu5rT8kzGVBeBju20d+Mp3qU9Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793503250; v=1; x=1794108050;
 b=AsHsd6iv+QMCCWQMCEf+Jdxm7nXGSTHuufXbC+H9Va2YBuno7SRw/fjOnQnmLdqZwY8vHfgz
 3y+FEoSWmigW7CguhUpgy7DNRQUSOnQN0PKmPPF1N9JAdBjMFMOHHVB0prULwZrdVH3L/NTU66r
 v92lrCSOdpPT0Igh5kIZN/P8=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 307f81ddaafada5e;
	Sun, 01 Nov 2026 03:20:50 +0000
X-Mizu-Trace-ID: 307f81ddaafada5e
X-Migadu-Flow: FLOW_OUT
Date: Sun, 1 Nov 2026 11:20:41 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH v5 1/6] mm/memcontrol: drop unused vmscan tracepoint
 include
Message-ID: <auawCfHE-jUUZunl@bogon>
References: <20261031090041.58574-1-ridong.chen@linux.dev>
 <20261031090041.58574-2-ridong.chen@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031090041.58574-2-ridong.chen@linux.dev>

On 10/31/26 at 05:00pm, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> memcontrol.c includes <trace/events/vmscan.h> but does not use any of
> the tracepoints or macros it defines: all tracepoints invoked here come
> from memcg.h and writeback.h.
> 
> Drop it ahead of moving the vmscan trace header under mm/, after which
> <trace/events/vmscan.h> will no longer exist.
> 
> No functional change.
> 
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
>  mm/memcontrol.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 84f4a8fd4d16..8a35f5b635e0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -77,8 +77,6 @@
>  #include <trace/events/memcg.h>
>  #undef CREATE_TRACE_POINTS
>  
> -#include <trace/events/vmscan.h>
> -
>  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
>  EXPORT_SYMBOL(memory_cgrp_subsys);
>  
> -- 
> 2.43.0
> 
