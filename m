Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D8476055;
	Wed,  2 Sep 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369443; cv=none; b=ImAgUvA1Zdk25Oi4o35fr95UmXTHk/DSFrx/2V07L6w/VBRbDBURN7sKpLgF+hbDm3FSNZBBIYSw+Yhj8i9vQdmj/bFi1u/1HUypYVIhCpk7KxOIPN8LHp8rej4Pq0eUsXz2vjIJK6r9RZdpiKzlhVM2nN+RnkC86Hha/0zcDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369443; c=relaxed/simple;
	bh=Kf8iOLL/oK/xM4IISV7gQzZdZcdKU0vIyyxOi9MLkPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNYexeOTZp6mSTe9vYS1SXGoh4Z90WoEqf7714rdZmzRWdEiPC495tFG1hGInI1kYiG+q8RdU63d3a3mnC2+/wLhcy4pztASWW2tZij0vKLkguMZO3hmys2pCkI0fzIMxUwnv2mom86MUId2hpzw3vqxl00ZR0JlgVS0td2Bh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vCUKh0Vb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vCUKh0Vb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=eF4juUrbhNqhHjtflWtqgPAc4Y/UG+CSO89tj/V20dU=; b=vCUKh0VbIzMkQMmX8xKy98i/Cw
	K470Y655tbXjQu50Hz0s6fqy1xfsUuH5L8lfppXeXAX1cdwlVY1NsBqVqYEwFsJooU2UiVmCdhe0s
	JJhn3oga6k8eE4vZTIoZ3CX/UwoQ1GT2+ip7Nf3g3lsrqeLjzFepNtrw0yerzBxLZeeCpqQ8rqM9J
	XKJ+EZSUzYUvxnU9LbWgieWde7oRJb7rpHd+IibWT3Y15HF1lwCky+jRD3QDT81SHJbZGv9YAKUOZ
	OIITabV8/U2LBXOMa77BF6Dc3yYTHiX6z1siAaLCQl31kuNAe155xtQ2xsq9SRTQCTSlXuMRk+p+B
	Sc8q6pjQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oaL-0000000FPum-3hH1;
	Wed, 02 Sep 2026 17:17:17 +0000
Message-ID: <c0edc549-7dd1-4d96-a4d2-55ec6fee5caf@infradead.org>
Date: Wed, 2 Sep 2026 10:17:17 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: trace: histogram-design: fix bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260902151032.706407-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260902151032.706407-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/26 8:10 AM, Manuel Ebner wrote:
> Remove needless ')' from sentence.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  Documentation/trace/histogram-design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
> index 41a726cd3..b757afa22 100644
> --- a/Documentation/trace/histogram-design.rst
> +++ b/Documentation/trace/histogram-design.rst
> @@ -876,7 +876,7 @@ next_pid field on this sched_switch event, we retrieve the
>  variables specified in the wakeup_latency() trace action, and use
>  them to generate a new wakeup_latency event into the trace stream.
>  
> -Note that the way the trace handlers such as wakeup_latency() (which
> +Note that the way the trace handlers such as wakeup_latency() which
>  could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid)
>  are implemented, the parameters specified to the trace handler must be
>  variables.  In this case, $wakeup_lat is obviously a variable, but

Seems to me that the "which ..." should be a parenthetical phrase,
i.e., with parentheses at both ends of it. IMO.
But let's see the the TRACE maintainers have an opinion about it.


-- 
~Randy

