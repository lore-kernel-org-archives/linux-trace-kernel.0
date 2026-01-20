Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BBC258EFF;
	Tue, 20 Jan 2026 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768879000; cv=none; b=i8zF3DbcdVaySKp4oj6Fbv31g6zOhDen5MA/pwVCMLSKgW1FHdp0ifC2IgBF1bXX2gIhmmUPcF31X2He8+VqadSTss7gRqEx+Yi9ttcq4PXsvX/EUQPHbMVhQbGlivn4wgHetrqGscf1eW9qB1IwxYql+ZWIlIxXhRJz6gnnlJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768879000; c=relaxed/simple;
	bh=0NPysdhi2GjhIK0vCCT+8t5U/XO6x5yKRTXlf5b/EV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3Rao6L6xjR1V1w9uMHKXu3tGxJFv8kG7yt/w9yyfmKLCtMfHvXKHkD2y+eh96qYLLudGOJgOQrW0CphwoR4st4zzoz9HeRZomNHMdiYbDdoBed04ZVOdS4INtCGUuBt2E+665jr3xovSAPX3f2sfn79m4ADahRSKgTGFxKZcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=svlB/xlD; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="svlB/xlD"
Message-ID: <b676baa0-2044-4a74-900d-f471620f2896@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768878990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o77/xJrdIVcmsJwVRdRj7mJP7YPfFW3Cxhs6zF4aiGA=;
	b=svlB/xlDvBvu3G7Bqj0Ebs6QRXdAMiZuXSKP7oA9qoqZPwM5hk69VJjHReRknARsXpuoh4
	YlgXOLUUamlIOqKg0Gvw7TkKCzFX+h/HaFbfNrVaIx+w1xNs5L+TY/dbIXZjlLEqogpavH
	gn763tGfU+nytAcyIC3Nj5yY2W8oYP4=
Date: Tue, 20 Jan 2026 11:16:20 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] page_pool: Add page_pool_release_stalled
 tracepoint
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, kerneljasonxing@gmail.com,
 lance.yang@linux.dev, jiayuan.chen@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Leon Huang Fu <leon.huangfu@shopee.com>
References: <20260119102119.176211-1-leon.hwang@linux.dev>
 <20260119083759.5deeaa3c@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260119083759.5deeaa3c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 20/1/26 00:37, Jakub Kicinski wrote:
> On Mon, 19 Jan 2026 18:21:19 +0800 Leon Hwang wrote:
>> Introduce a new tracepoint to track stalled page pool releases,
>> providing better observability for page pool lifecycle issues.
> 
> Sorry, I really want you to answer the questions from the last
> paragraph of:
> 
>  https://lore.kernel.org/netdev/20260104084347.5de3a537@kernel.org/

Let me share a concrete case where this tracepoint would have helped,
and why netlink notifications were not a good fit.

I encountered the 'pr_warn()' messages during Mellanox NIC flapping on a
system using the 'mlx5_core' driver (kernel 6.6). The root cause turned
out to be an application-level issue: the IBM/sarama “Client SeekBroker
Connection Leak” [1].

In short, some TCP sockets became orphaned while still holding FINACK
skbs in their 'sk_receive_queue'. These skbs were holding inflight pages
from page pools. After NIC flapping, as long as those sockets were not
closed, the inflight pages could not be returned, and the corresponding
page pools could not be released. Once the orphaned sockets were
explicitly closed (as in [2]), the inflight pages were returned and the
page pools were eventually destroyed.

During the investigation, the dmesg output was noisy: there were many
inflight pages across multiple page pools, originating from many
orphaned sockets. This made it difficult to investigate and reason about
the issue using BPF tools.

In this scenario, a netlink notification does not seem like a good fit:

* The situation involved many page pools and many inflight pages.
* Emitting netlink notifications on each retry or stall would likely
generate a large volume of messages.
* What was needed was not a stream of notifications, but the ability to
observe and correlate page pool state over time.

A tracepoint fits this use case better. With a
'page_pool_release_stalled' tracepoint, it becomes straightforward to
use BPF tools to:

* Track which page pools are repeatedly stalled
* Correlate stalls with socket state, RX queues, or driver behavior
* Distinguish expected situations (e.g. orphaned sockets temporarily
holding pages) from genuine kernel or driver issues

From my experience, this tracepoint complements the existing
netlink-based observability rather than duplicating it, while avoiding
the risk of excessive netlink traffic in pathological but realistic
scenarios such as NIC flapping combined with connection leaks.

Thanks,
Leon

[1] https://github.com/IBM/sarama/issues/3143
[2] https://github.com/IBM/sarama/pull/3384

