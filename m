Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87EE15D5C3;
	Wed, 23 Oct 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679420; cv=none; b=FkVLOStU+/ij/G0XU6XFxzX8DO6Lci2XJjBEKoQzPQgGUBYdH3O+pk9pRAknPax+JKVHR6NsGkOVU5m12XJhRI39wRkUsq6maZfrkxLSeaYdhEH1MKhE8MpGgpV3EydWkNV6ZFbW5UUS2RxKNVFi/yj1KV6/bkLuRL6+3EKJOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679420; c=relaxed/simple;
	bh=dOCQHfeOAkgXh2JrunAu9gHeLhGEIKF9LRTDykv07m4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mxM6X5l73qhSW5Ex4pRZYUDWdV3c4ZQzeUmavVcDt00LOoISZXf2/OakbdoVxenK2Um0RgPj/QHvSHp3QhXLuAlsNMsyGWvhnTIKKevXyl8Ovmlt1cDWDbrYfJ5mFDt/aleUVsyzLTZN6x9wgHKPTSTSMKPjdsPE1ARJQQ6uz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=l+5jMATm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="l+5jMATm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B45EA1BF212;
	Wed, 23 Oct 2024 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729679417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMFTUHAj70OERwwWzi9yxbynPpD8S8y4BGK+6PB4HEU=;
	b=l+5jMATm4m4Ezx0EVbIVhHbJWaDtJHmKEV9YtgZCabCwKgTm1DP4ZXx7hKS2HIvUvF+NIn
	r1ckqEHVCbSrk2coJVjwDgUBxAiCPBL+THYam6OmnqVfHJnwB/So0GWfN0HEw7wXTeyht5
	NlGRZrBu90OOuZamArfvRauuYqulHh8EPZgQyjrbUA2BCHUrKSrrJ/gsoBau5DUJV3tekP
	1Gi8lu1vDA4+ftFJerue03hDe5pBLS87lYC3iYqR/KqjkT+HdmKIyw0HVdDFXuLehnYX9m
	TmRGvWttQoEvHg6eK/nwnviHjaecTr584Yw3XR+i/f5NdIWg0QGoB3kuBo0ZZg==
Message-ID: <d84debf0-5e98-4c2e-88a7-e1db73fdbac3@yoseli.org>
Date: Wed, 23 Oct 2024 12:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
 <20241022012809.1ef083cd@rorschach.local.home>
 <075d6720-a690-437c-a10f-e2746651e2a8@yoseli.org>
 <20241022043037.13efb239@rorschach.local.home>
 <2c79be22-1157-41e4-9f3a-53443112ca9a@yoseli.org>
 <20241023044711.3eb838fe@rorschach.local.home>
 <262d7758-c752-49f6-87ef-4f75d681a919@yoseli.org>
 <CAMuHMdXKCWnFuyOzQyAWdEV4EhqXYXJFn4vCw5ptZ5=sbOCbxg@mail.gmail.com>
 <ec30a0d3-6d53-4350-a26b-c4d8b41057ec@yoseli.org>
Content-Language: en-US
In-Reply-To: <ec30a0d3-6d53-4350-a26b-c4d8b41057ec@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Geert, all,

On 23/10/2024 11:31, Jean-Michel Hautbois wrote:
> Hi Geert,
> 
> On 23/10/2024 11:13, Geert Uytterhoeven wrote:
>> Hi Jean-Michel,
>>
>> On Wed, Oct 23, 2024 at 11:07 AM Jean-Michel Hautbois
>> <jeanmichel.hautbois@yoseli.org> wrote:
>>> On 23/10/2024 10:47, Steven Rostedt wrote:
>>>> On Tue, 22 Oct 2024 11:21:34 +0200
>>>> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
>>>>> I was not really expecting you to review the m68k one no :-).
>>>>> I think I have other issues which might have impact on ftrace too.
>>>>> For instance, when I launch cyclictest I have a warning about 
>>>>> HRTIMERS:
>>>>> # cyclictest -p 99
>>>>> WARN: stat /dev/cpu_dma_latency failed: No such file or directory
>>>>> WARN: High resolution timers not available
>>>>> policy: fifo: loadavg: 1.21 0.40 0.14 1/122 245
>>>>>
>>>>> T: 0 (  245) P:99 I:1000 C:  11203 Min:     92 Act:  623 Avg:  775 
>>>>> Max:
>>>>>      3516
>>>>>
>>>>> The latencies are quite high...
>>>>
>>>> Yes, if you don't have high resolution timers, the latency will be 
>>>> high.
>>>
>>> According to my config, I should have those:
>>> CONFIG_HIGH_RES_TIMERS=y
>>
>> Does your hardware have a high resolution timer, and do you have
>> a driver for it?
>>
>> $ git grep hrtimer -- arch/m68k/
>> $
>>
> 
> No, there is nothing with hrtimer. But, the architecture has four dma 
> timers, with a 8ns resolution at 125MHz says the documentation. I will 
> try to find a way to implement the missing part.
> 

I gave it a hacky try. And it seems to be *a lot* better:
# cyclictest -p 99 -l 10000
WARN: stat /dev/cpu_dma_latency failed: No such file or directory
policy: fifo: loadavg: 1.18 0.71 0.33 1/122 258

T: 0 (  258) P:99 I:1000 C:  10000 Min:    118 Act: 1104 Avg:  418 Max: 
   1858

I will try to clean it a bit for another patch set :-).

Thanks,
JM
