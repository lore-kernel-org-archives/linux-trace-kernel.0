Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C543199934;
	Wed, 23 Oct 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675905; cv=none; b=n/I77ofjyPkRyJitWiJBfYFsuVBUyjRJ0iZyAuLGUdpi4zrPSGv70NBbKTgY8KZkuAyzWkxs4bNJTz3YDpPI1U90otUJJNlaypEZfgsuWyPt0hyC9xob6w4b+SxJFoBoRK5qO5FPWagDxugbqb4mLddO0eLbkxmdXNwDuKffOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675905; c=relaxed/simple;
	bh=qFxknWteh7THbDKN6AwkAtb5Of8AmQTACmf1bSoCwlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lK0cLHIbPFEaOLGy0l2o7w117oXKCUv4nIPXb+wpwxw5woYit57rMDHqeF9otMkgIDVxESznDQ1gjTmSh31TsF+yoGg5lEcrRq2YPcNMm4PNBdx12rX/LnfSdKrpcipkGVodajO/Fb50zfKFKsjRZDUcS++S9syJ6kjVfb7o/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=Y9hCF4NF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="Y9hCF4NF"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAF4D240005;
	Wed, 23 Oct 2024 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729675901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGsZBUC5Q1TR6BORMjGHARVC2ruLW+vf2yXzVOKUo2c=;
	b=Y9hCF4NFASVI7MuEkaOlQf1KiE9g10dVdQHNrbqE80Eq74trMxpjmLjXAk/iLwhwRzCEE4
	IvqdeLbe/+Nt2HBKWCmWfhj3yAei5Z1OlGHjNvYir7Ti3kU6GyI63hT0IIDnDTyYJFSOof
	+FFwjMNTPv1Fm/N4iz0j78plpNN77Zc8oBCdSXFVdF+bonQDhw2u7zbTuYvtdqPtAXMxqs
	9e08/LFSLh8KvC86qvbtQlD/z+Tgo3aZaaV/xkxNuJY+ehlE66JqjqYh1iwbdf6KZUDp7A
	2agRZ0IlIejcA3fUwcls4X4heIEhq7IJzKRbZgwvNeO1KGqFgrSquKFiNaMWOw==
Message-ID: <ec30a0d3-6d53-4350-a26b-c4d8b41057ec@yoseli.org>
Date: Wed, 23 Oct 2024 11:31:40 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
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
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <CAMuHMdXKCWnFuyOzQyAWdEV4EhqXYXJFn4vCw5ptZ5=sbOCbxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Geert,

On 23/10/2024 11:13, Geert Uytterhoeven wrote:
> Hi Jean-Michel,
> 
> On Wed, Oct 23, 2024 at 11:07 AM Jean-Michel Hautbois
> <jeanmichel.hautbois@yoseli.org> wrote:
>> On 23/10/2024 10:47, Steven Rostedt wrote:
>>> On Tue, 22 Oct 2024 11:21:34 +0200
>>> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
>>>> I was not really expecting you to review the m68k one no :-).
>>>> I think I have other issues which might have impact on ftrace too.
>>>> For instance, when I launch cyclictest I have a warning about HRTIMERS:
>>>> # cyclictest -p 99
>>>> WARN: stat /dev/cpu_dma_latency failed: No such file or directory
>>>> WARN: High resolution timers not available
>>>> policy: fifo: loadavg: 1.21 0.40 0.14 1/122 245
>>>>
>>>> T: 0 (  245) P:99 I:1000 C:  11203 Min:     92 Act:  623 Avg:  775 Max:
>>>>      3516
>>>>
>>>> The latencies are quite high...
>>>
>>> Yes, if you don't have high resolution timers, the latency will be high.
>>
>> According to my config, I should have those:
>> CONFIG_HIGH_RES_TIMERS=y
> 
> Does your hardware have a high resolution timer, and do you have
> a driver for it?
> 
> $ git grep hrtimer -- arch/m68k/
> $
>

No, there is nothing with hrtimer. But, the architecture has four dma 
timers, with a 8ns resolution at 125MHz says the documentation. I will 
try to find a way to implement the missing part.

Thanks,
JM

> Gr{oetje,eeting}s,
> 
>                          Geert
> 

