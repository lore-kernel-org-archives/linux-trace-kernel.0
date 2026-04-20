Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403C19C54E;
	Mon, 20 Apr 2026 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684468; cv=none; b=BU74M2v7NjoqC8C+orDXjeO58a4RF4U4aoCUimPIalhxD2ml+7SH5v9LNva0JGKax/lbrzlr/LIoZLMjDeq+f31ib3FDFWSe9D3ZAe3Yjd4IWjR+s9uLNfidsKUv6O3uKzwAkMsYE2UJJtCpFxS3oIi8o0zmMkqhj230ihJi44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684468; c=relaxed/simple;
	bh=lcuhLiK78fnxGY3DsHsyrjbNY2/wp+/JiF3BASxfRPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzRpkcpNtlgqS0xIcf9jxpEMLwWoRCai2e4bCQkYkXqiu65oyD32L5uoErmsY2fkOvtynjSBAraas+qsBU6XfDfXEEsumavNtNWKEPSv2QBvdpSOqqm9+KY+HilVZSKO1pDFUPZ5DocLbZUiNdL/mYWNUgzoSIdzsRT7IsfFLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNrR7gOj; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNrR7gOj"
Message-ID: <b943ec1e-417c-4157-ab19-b34aa6d63688@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776684462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FmNftTmL2q6GdFEvWpth7ujw9QbRkrMDpo5qvEDDvQ=;
	b=MNrR7gOj5MqmSHqSUcTnOT6xTypK/4X418TSV2T6ZdN0Egh3Jpy12vF7Dzv48x0MXpNSi9
	nk4VPQUq7HdR6WM7zw+L2yenHqNKxkLOMlf41LZUzlNJsnSzpLax2eF5lj1Wj6vSE+anXT
	xXqdM7Vw/sOocj99V197a/KmexXKAjU=
Date: Mon, 20 Apr 2026 19:27:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: validate skb->napi_id in RX tracepoints
To: Kohei Enju <kohei@enjuk.jp>, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20260420105427.162816-1-kohei@enjuk.jp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260420105427.162816-1-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/20/26 6:54 PM, Kohei Enju wrote:
> Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
> skb->napi_id shares storage with sender_cpu. RX tracepoints using
> net_dev_rx_verbose_template read skb->napi_id directly and can therefore
> report sender_cpu values as if they were NAPI IDs.
>
> For example, on the loopback path this can report 1 as napi_id, where 1
So I think veth_forward_skb->__netif_rx could be affected as well?
> comes from raw_smp_processor_id() + 1 in the XPS path:
>
>    # bpftrace -e 'tracepoint:net:netif_rx_entry{ print(args->napi_id); }'
>    # taskset -c 0 ping -c 1 ::1
>
> Report only valid NAPI IDs in these tracepoints and use 0 otherwise.
>
> Fixes: 2bd82484bb4c ("xps: fix xps for stacked devices")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   include/trace/events/net.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> index fdd9ad474ce3..dbc2c5598e35 100644
> --- a/include/trace/events/net.h
> +++ b/include/trace/events/net.h
> @@ -10,6 +10,7 @@
>   #include <linux/if_vlan.h>
>   #include <linux/ip.h>
>   #include <linux/tracepoint.h>
> +#include <net/busy_poll.h>
>   
>   TRACE_EVENT(net_dev_start_xmit,
>   
> @@ -208,7 +209,8 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
>   	TP_fast_assign(
>   		__assign_str(name);
>   #ifdef CONFIG_NET_RX_BUSY_POLL
> -		__entry->napi_id = skb->napi_id;
> +		__entry->napi_id = napi_id_valid(skb->napi_id) ?
> +				   skb->napi_id : 0;
>   #else
>   		__entry->napi_id = 0;
>   #endif
