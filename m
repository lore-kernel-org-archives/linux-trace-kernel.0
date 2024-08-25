Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B52119
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724605594; cv=none; b=PHGIbAilBth3W+sSzJx3CNdHtM1NY5XpjSf8fdsfFqhYbpmIEoe5JNZy2QBS963H2zNjLIolfyM6XCXh5eb3O+bWzgFlFoTIiOl3+Zv1kLow/CyqfpLMrsi4yzJmJFQVu42JgPyBmQ66DqL4vKjjBdRiv+gLwuXmqm3eSM8KnLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724605594; c=relaxed/simple;
	bh=j7o9817QjX3ggvQ2lfI0cANrl3TwM61TUpT8YNxB27c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efTWytzKbcqnVsEnJLJqPk04iqNV3gwc/6hH24wGzspNfgNNLQR0G95Ws/GPaOa5mj4zbStD8v0GYONpyWbByyc0aNmvsoH9l4pG1FLS85GLCnH64zLkmVFQMhRfZxprJyLYRprnFGVZ/y8tsxqf7tKixr5oE+DzsVFAxK2FzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=OZskYdkF; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="OZskYdkF"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4WsKw21WZmzDqBG;
	Sun, 25 Aug 2024 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1724605586; bh=j7o9817QjX3ggvQ2lfI0cANrl3TwM61TUpT8YNxB27c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OZskYdkFwtR7d2S8SR3adA6NWZv8fV93NfD01d5o457ao80Zhu0i2YkrFLiBQuqM+
	 ruXsJMzbfkvLeP3FWDaireXJbcywjQxIs9cJLVSP9R3X5PdYLS/assumccbHMqSe3G
	 VJgbRrwemrlw26vdlb8NRL90+pyFQ3cpSRe8zosY=
X-Riseup-User-ID: CB79EE183104D5A36DEDE607D4DD801606BC937140F0D3326ED75345A308A010
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4WsKw11NHfzJv0V;
	Sun, 25 Aug 2024 17:06:24 +0000 (UTC)
Message-ID: <fc31cca4-bec6-461c-9843-b4121ac1ba20@riseup.net>
Date: Sun, 25 Aug 2024 19:06:22 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tracing/probes: fix traceprobe out-of-bounds argument
 allocation
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
References: <20240813172546.3151-1-ffmancera@riseup.net>
 <20240825164132.024faee7897e0ac126d8c58e@kernel.org>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <20240825164132.024faee7897e0ac126d8c58e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 25/08/2024 09:41, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> On Tue, 13 Aug 2024 13:25:40 -0400
> Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> 
>> When initializing trace_probes::nr_args, make sure the maximum number of
>> probe arguments is honored. Oherwise, we can hit a NULL pointer
>> dereferences in multiple situations like on traceprobe_set_print_fmt().
>>
>> Link: https://bugzilla.redhat.com/2303876
> 
> Sorry for replying later. I'm not sure why but I did not found this in my mbox...
> 

No worries!

> Anyway, trace_probe_init() should return -E2BIG in this case because
> it is actuall wrong value.
> 
> Can you update your patch?
> 

I agree this is the right solution but it would mean a change in 
behavior. Is that fine? Before merging 035ba76014c0, it was writing up 
to the maximum number of arguments and ignoring the rest. If you confirm 
it is fine to change the behavior, I will update the patch.

Thank you!

> Thank you,
> 
> 
>>
>> Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>> ---
>>   kernel/trace/trace_probe.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
>> index 39877c80d6cb..f577b5e71026 100644
>> --- a/kernel/trace/trace_probe.c
>> +++ b/kernel/trace/trace_probe.c
>> @@ -2043,10 +2043,14 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
>>   		goto error;
>>   	}
>>   
>> -	tp->nr_args = nargs;
>> +	if (nargs > MAX_TRACE_ARGS)
>> +		tp->nr_args = MAX_TRACE_ARGS;
>> +	else
>> +		tp->nr_args = nargs;
>> +
>>   	/* Make sure pointers in args[] are NULL */
>>   	if (nargs)
>> -		memset(tp->args, 0, sizeof(tp->args[0]) * nargs);
>> +		memset(tp->args, 0, sizeof(tp->args[0]) * tp->nr_args);
>>   
>>   	return 0;
>>   
> 
> 
