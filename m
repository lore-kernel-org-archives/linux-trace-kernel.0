Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC607640E;
	Tue,  6 Jan 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715708; cv=none; b=TQbqLQXiRXCD6otE8YClqeSwCatarkpVzvqzllFOeQXKc9V14xtRU+4bbTLqubwhXEzJgkOewKuW2u4JvUG+EECAqwarf9IgoTBWJLTra67sJKPlhxvFikrdfdFWl6F4BAX4sxux7yDwhnJIHooapfCAbDwT/1iO7ewfdC2u7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715708; c=relaxed/simple;
	bh=hre8a82biCiIv73MGm7C0haSZzXilCTf37nW3k5hvtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbThWpilLJgO51TBNRJNdTGpRSvBhAAQvixCabkQRkisS6tqS2LjvBowfEQhJ63vf/u27IeDdr1/UFvLyK8Z6Dip7VPy9bWtMgAEFdPeR1lVFkIhZSHge9QYMYW9LkTIY67Kmqg4WmU/MUcdCus5DzKdPilq0EUf4HKUumkK0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WubNPb4r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WubNPb4r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6VK71SdtADu1Pk4+IDQOOejh7lZTXK9NItsNHxTrQhM=; b=WubNPb4rNstkLGRL4RsOzQsL4G
	DQwUOtjI7jwYhYVtjbqcY0Utl9J8WZRABAWa28/B5NTktsMOdyKCpKeEtkXXUIEPS4wNoqJUzlD7b
	UJI1dJPQ/aA2DTYUyenBsNWdQSZortQs+9AtAR9KiQw7SjWfAFnuYRWRP+i26QAgB73WQgbiYND4n
	k8YUBu43WTVpa8DzkLI/ll/YmNqjury+0vLWM0/qSfBwvKXERIbE9wIRI6rydb8K8nn2fc7SIsIEX
	IN+QTTEbxV1VakPkOrAWPoWWQX94nYUdL2N5cXuH5VbaUTx07IqiQyboJi/29SEk8U9wQryU7S9wL
	Ca/zJmOQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd9bX-0000000DSqj-2NJU;
	Tue, 06 Jan 2026 16:08:19 +0000
Message-ID: <b08ad926-8582-4a43-ba17-3a987b7a0ca6@infradead.org>
Date: Tue, 6 Jan 2026 08:08:17 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 2/2] tracing: Add show_event_triggers to expose active
 event triggers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 neelx@suse.com, sean@ashe.io, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260105142939.2655342-1-atomlin@atomlin.com>
 <20260105142939.2655342-3-atomlin@atomlin.com>
 <95feb439-2298-4539-8833-e05ed06f273b@infradead.org>
 <20260106101701.7dd20845@gandalf.local.home>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260106101701.7dd20845@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/6/26 7:17 AM, Steven Rostedt wrote:
> On Mon, 5 Jan 2026 22:10:39 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Hi,
>>
>> On 1/5/26 6:29 AM, Aaron Tomlin wrote:
>>> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
>>> index 4ce01e726b09..b9efb148a5c2 100644
>>> --- a/Documentation/trace/ftrace.rst
>>> +++ b/Documentation/trace/ftrace.rst
>>> @@ -692,6 +692,14 @@ of ftrace. Here is a list of some of the key files:
>>>  
>>>  	See events.rst for more information.
>>>  
>>> +  show_event_triggers:
>>> +
>>> +	A list of events that have triggers. This shows the
>>> +	system/event pair along with the trigger that is attached to
>>> +	the event.
>>> +
>>> +	See events.rst for more information.
>>> +  
>>
>> Isn't this the same chunk that was in patch 1/2?
> 
> No, patch 1/2 has:
> 
> @@ -684,6 +684,14 @@ of ftrace. Here is a list of some of the key files:
>  
>  	See events.rst for more information.
>  
> +  show_event_filters:
> +
> +	A list of events that have filters. This shows the
> +	system/event pair along with the filter that is attached to
> +	the event.
> +
> +	See events.rst for more information.
> +
>    available_events:
> 
> 
> It is simply a s/filter/trigger/g difference though.

Ack. Thanks.

-- 
~Randy

