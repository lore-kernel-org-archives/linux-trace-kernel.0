Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA6148FF3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673310; cv=none; b=fR6m4qBaMjKyN1URz/b4ms8otyhm1KV+UxpwMOeWJoSVoy59n5cMbJavye/yTDZxBiOLXOa01ydimhYfh6ey7tk1u3Kgio1EGEuVw6cvREX6x7U+HmjUYO90cJBd7SOf4PFUMYigl0yTcTQR9lHiQ4zjJv10fJCqsLhFbO7qRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673310; c=relaxed/simple;
	bh=zxmgpZj+uNafJJSM0FuRn/1ucicfHuJwYTUtE+RYZfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9sfSZuwatjJuz0UcNjaK0wVcUFhOU0c+IUwBDktrQu1sJU9CT7R84TMo/WxETQyxbbyqhGdz0nqNESFY8gXEpf3HbdXjg3S3SsvGApAeyMqHXJ3do8LPpIfi8rhNet2xRgZfF3nX6mPhFMIu+NpJwNoSOVG6K2b2Bl/PJTiVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=sej+4oZV; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="sej+4oZV"
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XYN471DWszDqP1;
	Wed, 23 Oct 2024 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1729673303; bh=zxmgpZj+uNafJJSM0FuRn/1ucicfHuJwYTUtE+RYZfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sej+4oZVpiDbxxk1osAA3UGCztwiwTwgC1VYcDoDl2aH6jCJgFTAoAnQibaNTLWz8
	 XF8mbeA/8jeSG7U4sNc2j0sHzZuMDAEYpKPDUVd5UkzdE7Q++azn91tty4i4YoljSG
	 9WnbBP7P0yu45IfQYeJPlyPBm/mBAoL/Atyg/Xdg=
X-Riseup-User-ID: D44E42525645740D1ED78E6B1D41889280576DF6B52AFB0F16353932084BF072
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XYN460wZYzFskv;
	Wed, 23 Oct 2024 08:48:21 +0000 (UTC)
Message-ID: <71e24cc4-ce84-4f52-8b76-efbfd778e057@riseup.net>
Date: Wed, 23 Oct 2024 10:48:19 +0200
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
 <88bc4212-8bca-45ff-9078-d0f7b9e6a64b@riseup.net>
 <20241022144045.429a1a8a3f55e9df43d9a869@kernel.org>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <20241022144045.429a1a8a3f55e9df43d9a869@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 22/10/2024 07:40, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> On Thu, 5 Sep 2024 00:19:16 +0200
> "Fernando F. Mancera" <ffmancera@riseup.net> wrote:
> 
>> Hi,
>>
>> On 26/08/2024 01:56, Masami Hiramatsu (Google) wrote:
>>> On Sun, 25 Aug 2024 19:06:22 +0200
>>> "Fernando F. Mancera" <ffmancera@riseup.net> wrote:
>>>
>>>> Hi,
>>>>
>>>> On 25/08/2024 09:41, Masami Hiramatsu (Google) wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, 13 Aug 2024 13:25:40 -0400
>>>>> Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
>>>>>
>>>>>> When initializing trace_probes::nr_args, make sure the maximum number of
>>>>>> probe arguments is honored. Oherwise, we can hit a NULL pointer
>>>>>> dereferences in multiple situations like on traceprobe_set_print_fmt().
>>>>>>
>>>>>> Link: https://bugzilla.redhat.com/2303876
>>>>>
>>>>> Sorry for replying later. I'm not sure why but I did not found this in my mbox...
>>>>>
>>>>
>>>> No worries!
>>>>
>>>>> Anyway, trace_probe_init() should return -E2BIG in this case because
>>>>> it is actuall wrong value.
>>>>>
>>>>> Can you update your patch?
>>>>>
>>>>
>>>> I agree this is the right solution but it would mean a change in
>>>> behavior. Is that fine? Before merging 035ba76014c0, it was writing up
>>>> to the maximum number of arguments and ignoring the rest. If you confirm
>>>> it is fine to change the behavior, I will update the patch.
>>>
>>> Yes, I think this is the better behavior for users too, rather than
>>> silently droping some arguments.
>>> We also need to handle this error code in callsite and log an error,
>>> and add a testcase in the syntax error testcase. But that should be done
>>> in another series. We should fix this first.
>>>
>>
>> Just in case this fell through the cracks, I've sent a V2 patch. In
>> addition I also have a series ready for the logging and syntax error
>> testcase in kselftest but I didn't send it because it requires this
>> patch to be applied.
> 
> I think that v2 was lost in my mailbox, but I found that in patchwork.
> Let me pick it.
> 

Sure, let me know if you need me to rebase it. Thanks for taking a look 
to it :)

> Thanks,
> 
>>
>> Thank you,
>> Fernando.
>>
>>> Thank you,
>>>
>>>
>>>>
>>>> Thank you!
>>>>
>>>>> Thank you,
>>>>>
>>>>>
>>>>>>
>>>>>> Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
>>>>>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>>>>>> ---
>>>>>>     kernel/trace/trace_probe.c | 8 ++++++--
>>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
>>>>>> index 39877c80d6cb..f577b5e71026 100644
>>>>>> --- a/kernel/trace/trace_probe.c
>>>>>> +++ b/kernel/trace/trace_probe.c
>>>>>> @@ -2043,10 +2043,14 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
>>>>>>     		goto error;
>>>>>>     	}
>>>>>>     
>>>>>> -	tp->nr_args = nargs;
>>>>>> +	if (nargs > MAX_TRACE_ARGS)
>>>>>> +		tp->nr_args = MAX_TRACE_ARGS;
>>>>>> +	else
>>>>>> +		tp->nr_args = nargs;
>>>>>> +
>>>>>>     	/* Make sure pointers in args[] are NULL */
>>>>>>     	if (nargs)
>>>>>> -		memset(tp->args, 0, sizeof(tp->args[0]) * nargs);
>>>>>> +		memset(tp->args, 0, sizeof(tp->args[0]) * tp->nr_args);
>>>>>>     
>>>>>>     	return 0;
>>>>>>     
>>>>>
>>>>>
>>>
>>>
> 
> 

