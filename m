Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BD189511
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684333; cv=none; b=IVXtbel/uabIxh3kmkf0Fd+N6lzL4s3hRg7itGujDdwfmhyA3Pzh1M5+obTaq6U7Eg7V/brlt4FwfSeD8nZZaNhZbTRodZq1nB0rqF0zKjqtgoKdh8b+OlMrsABiyUBHEsYYJMa9EuA0igXx2JzobULzFjWzKltzjaWnccrdd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684333; c=relaxed/simple;
	bh=Ld3Ih08LGC2rVSuAWlW1kVHyGOXK+qk+QGCIJ/EaP20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1DhudsJU0L/VV4qmdKohdIXAxwcf9RuS9XqOUO0lNpYOms0jbAPE75tZPKBVEQuCiv0AybX53tEf8OOu6Q/rz1St/VPmwqerG+PZnlBnQIX6RSNEZIlH5J8xyzuvM8+Mbm1MtJPxUdhXDUMc6WTbX9EuLxKxsnEl6JGwC3+Oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=J4lFzuFx; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="J4lFzuFx"
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Wsv2D1P10z9vd5;
	Mon, 26 Aug 2024 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1724684326; bh=Ld3Ih08LGC2rVSuAWlW1kVHyGOXK+qk+QGCIJ/EaP20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J4lFzuFxqJmkNJZUggRTf3fgCHZwrNCMmKLR+5jK6eXzeed3CytiJ9W7NZ+epFPtH
	 LnjA3Zn5fgYRSwN0W2QLXJfwHAc2kYQozKqD/hcwbsWN0zeltllRPIh1f3SGJXktAe
	 XuKUGshW29DUSMGhkmxQdZf8hW97Kdp1qBJngc70=
X-Riseup-User-ID: ED0CFDE72EFCF4BA5E9AF872D075836F16E0B31E27EF099AD809ADCAAE53D244
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Wsv2C1BLNzFwfL;
	Mon, 26 Aug 2024 14:58:42 +0000 (UTC)
Message-ID: <6b5dd26e-99c8-452c-9619-9dbfd17316a1@riseup.net>
Date: Mon, 26 Aug 2024 16:58:40 +0200
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
 <fc31cca4-bec6-461c-9843-b4121ac1ba20@riseup.net>
 <20240826085659.939bde641e4bf13249dec6ec@kernel.org>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <20240826085659.939bde641e4bf13249dec6ec@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/08/2024 01:56, Masami Hiramatsu (Google) wrote:
> On Sun, 25 Aug 2024 19:06:22 +0200
> "Fernando F. Mancera" <ffmancera@riseup.net> wrote:
> 
>> Hi,
>>
>> On 25/08/2024 09:41, Masami Hiramatsu (Google) wrote:
>>> Hi,
>>>
>>> On Tue, 13 Aug 2024 13:25:40 -0400
>>> Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
>>>
>>>> When initializing trace_probes::nr_args, make sure the maximum number of
>>>> probe arguments is honored. Oherwise, we can hit a NULL pointer
>>>> dereferences in multiple situations like on traceprobe_set_print_fmt().
>>>>
>>>> Link: https://bugzilla.redhat.com/2303876
>>>
>>> Sorry for replying later. I'm not sure why but I did not found this in my mbox...
>>>
>>
>> No worries!
>>
>>> Anyway, trace_probe_init() should return -E2BIG in this case because
>>> it is actuall wrong value.
>>>
>>> Can you update your patch?
>>>
>>
>> I agree this is the right solution but it would mean a change in
>> behavior. Is that fine? Before merging 035ba76014c0, it was writing up
>> to the maximum number of arguments and ignoring the rest. If you confirm
>> it is fine to change the behavior, I will update the patch.
> 
> Yes, I think this is the better behavior for users too, rather than
> silently droping some arguments.
> We also need to handle this error code in callsite and log an error,
> and add a testcase in the syntax error testcase. But that should be done
> in another series. We should fix this first.
> 

Thanks I will update the patch. If you don't mind I would also like to 
do the follow up patch series.

> Thank you,
> 
> 
>>
>> Thank you!
>>
>>> Thank you,
>>>
>>>
>>>>
>>>> Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
>>>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>>>> ---
>>>>    kernel/trace/trace_probe.c | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
>>>> index 39877c80d6cb..f577b5e71026 100644
>>>> --- a/kernel/trace/trace_probe.c
>>>> +++ b/kernel/trace/trace_probe.c
>>>> @@ -2043,10 +2043,14 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
>>>>    		goto error;
>>>>    	}
>>>>    
>>>> -	tp->nr_args = nargs;
>>>> +	if (nargs > MAX_TRACE_ARGS)
>>>> +		tp->nr_args = MAX_TRACE_ARGS;
>>>> +	else
>>>> +		tp->nr_args = nargs;
>>>> +
>>>>    	/* Make sure pointers in args[] are NULL */
>>>>    	if (nargs)
>>>> -		memset(tp->args, 0, sizeof(tp->args[0]) * nargs);
>>>> +		memset(tp->args, 0, sizeof(tp->args[0]) * tp->nr_args);
>>>>    
>>>>    	return 0;
>>>>    
>>>
>>>
> 
> 
