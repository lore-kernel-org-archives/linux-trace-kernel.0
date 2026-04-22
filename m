Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF782F851
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Apr 2026 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822954; cv=none; b=ff/jVXhyU0Ie5A+MoQBuJsTHkIpJwu4FYJgUIHShRut1PAYXeBb1tDwHlsMh0dFU2Jg8uCeL4BaxkYurCZrr0CEa8MR1R16waW1DWQus3zK6bAm2ENrsdMseMapL00w7mSvib00NQ2/11VJltSwcZkShrFI1MmbUvcscgyJWFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822954; c=relaxed/simple;
	bh=FsPj7/rcEceeVIbL/Lon/HzNlRrgPw9fr2OEh/b8gD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exju8j9ygKzWcblHM00VwSmxS3GgEH86JK+u51wZpGDBjJrQdAs/ROEvFW4PnrIikRjv43HBPG3GrxJ61lm/HSHjz7J6mWHntsKN/xYnmFDg6rseGzXqD3XoTQw0JJ0CZbLF/x0qOGZPktNu/LfiRYgSwhKpuCamzYU/XYqim+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tRBhKfDw; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tRBhKfDw"
Message-ID: <6eeac9ec-76f6-43ae-a943-942d1d5da1d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776822941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsPj7/rcEceeVIbL/Lon/HzNlRrgPw9fr2OEh/b8gD0=;
	b=tRBhKfDw62rsBxeomp4gyZqvJv1RoYf0TgmkeC0a2vMdOSuVuzBZN8zxboWWCm2TnqCe+V
	je1b2WlLGWK9F1hL7rEwEwt/0Ijb2b20JDWrrTHfd+YF8mxOGwziPDjEmERzQroGFrAK3l
	Vk/FQk8Kwr2Hu3DBx+HXSplYMRoYlHE=
Date: Wed, 22 Apr 2026 09:55:25 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: validate skb->napi_id in RX tracepoints
To: Kohei Enju <kohei@enjuk.jp>
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20260420105427.162816-1-kohei@enjuk.jp>
 <b943ec1e-417c-4157-ab19-b34aa6d63688@linux.dev> <aeYTImGIRuOf72mi@x1>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <aeYTImGIRuOf72mi@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/20/26 7:54 PM, Kohei Enju wrote:
> On 04/20 19:27, Jiayuan Chen wrote:
>> On 4/20/26 6:54 PM, Kohei Enju wrote:
>>> Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
>>> skb->napi_id shares storage with sender_cpu. RX tracepoints using
>>> net_dev_rx_verbose_template read skb->napi_id directly and can therefore
>>> report sender_cpu values as if they were NAPI IDs.
>>>
>>> For example, on the loopback path this can report 1 as napi_id, where 1
>> So I think veth_forward_skb->__netif_rx could be affected as well?
> Yes. Just in case, I've confirmed the same behavior in the veth path.
> The mentioned loopback path is just a single example of possibly
> affected paths.
>
> Thanks,
> Kohei
>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

