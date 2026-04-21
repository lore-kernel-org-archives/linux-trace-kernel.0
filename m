Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D781377004;
	Tue, 21 Apr 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789200; cv=none; b=l+k0N9UNPpJ1IdToKijNs417zn6PnhlfYJ9QLO/PTtVugEluzEswXTEawfZ36/Xx7Pj8yr/2sahKUD5/FSH71T78lwnYed4WWhNjDiUk5IEChRRoulv7tXVehfvVFpKWr2EHJPFa3LtTsDjWX9U4WN2ICjtnNlbtqCJZPIi2bOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789200; c=relaxed/simple;
	bh=ck+/1JcnR8lax3S93FFASNLkLcRjRvKPDzNieJgqEsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrQABiJWTq7yeR+ICM+UyeRnqpafXtvHiUlfZEtt8aA8pe61cbFPy+xh8flOcRji6ZykSqzdPoBFHL24lZRZwWgs6l45wo2RISjjC9pZ7rX+M1N8ClCxUpXnJQlQaadDppMuBKrTCYpaM/Rozwfh0Unb3ZInR23nK8wZ0bpR2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1fFbg9+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1fFbg9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FB0C2BCB3;
	Tue, 21 Apr 2026 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776789200;
	bh=ck+/1JcnR8lax3S93FFASNLkLcRjRvKPDzNieJgqEsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1fFbg9+ownra5GmuueQclj8fiLFudWpERkbB9Q0mKmOgFBKkZrFArMafq2ufGmar
	 2za6MSZud4cU06VzuQQcb1j9WbuSs/tu/lVpFz3AIq1ar7WRo8CMeXrb9lQ3NVXQ+X
	 qJFC10VyBOUCNuHOKRKN5iVmkK8qCOrCefJTh6DP/jfRwcNxkhqBcrzVxNfYdzOR3Y
	 rrDz8SDuUtp/sO36Y4fbF9xQS3SOIb0/CKtvOBvDjufEGEGQdKSH8aBHLVk++8I35e
	 8QHmI0g+lisPkWGIReJvZD0+BukmTpdifyOruquHWlwYylosEs61lkhq/icPesljEF
	 kEX67PswAoHmQ==
Date: Tue, 21 Apr 2026 17:33:15 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH net v1] net: validate skb->napi_id in RX tracepoints
Message-ID: <20260421163315.GG651125@horms.kernel.org>
References: <20260420105427.162816-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420105427.162816-1-kohei@enjuk.jp>

On Mon, Apr 20, 2026 at 10:54:23AM +0000, Kohei Enju wrote:
> Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
> skb->napi_id shares storage with sender_cpu. RX tracepoints using
> net_dev_rx_verbose_template read skb->napi_id directly and can therefore
> report sender_cpu values as if they were NAPI IDs.
> 
> For example, on the loopback path this can report 1 as napi_id, where 1
> comes from raw_smp_processor_id() + 1 in the XPS path:
> 
>   # bpftrace -e 'tracepoint:net:netif_rx_entry{ print(args->napi_id); }'
>   # taskset -c 0 ping -c 1 ::1
> 
> Report only valid NAPI IDs in these tracepoints and use 0 otherwise.
> 
> Fixes: 2bd82484bb4c ("xps: fix xps for stacked devices")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  include/trace/events/net.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> index fdd9ad474ce3..dbc2c5598e35 100644
> --- a/include/trace/events/net.h
> +++ b/include/trace/events/net.h
> @@ -10,6 +10,7 @@
>  #include <linux/if_vlan.h>
>  #include <linux/ip.h>
>  #include <linux/tracepoint.h>
> +#include <net/busy_poll.h>
>  
>  TRACE_EVENT(net_dev_start_xmit,
>  
> @@ -208,7 +209,8 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
>  	TP_fast_assign(
>  		__assign_str(name);
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> -		__entry->napi_id = skb->napi_id;
> +		__entry->napi_id = napi_id_valid(skb->napi_id) ?
> +				   skb->napi_id : 0;

Note to self: they key is that if the storage at napi_id is
being used as a sender_cpu then napi_id_valid because
the valid values for a sender_cpu are disjoint from those
of a valid napi_id. This can be seen clearly in the
implementation of napi_id_valid() and the comment above it.

>  #else
>  		__entry->napi_id = 0;
>  #endif
> -- 
> 2.51.0
> 
