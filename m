Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1930134BD;
	Mon, 16 Sep 2024 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464850; cv=pass; b=OjvldgrYYIapUFwHqLf3eraCUjXJFUwoHMSPxmpyRlersfZRtljLrkohv8afr6DGbgzuz2dYfYJOJNTNqbf57aghiCl2QBX4vQW7uRlV+o/92GpsI9g4Y0VdNhaAVbLM7u27Z4FNNCUpIMAdTaTABnSM2J48tZ2sWfJnglE+zj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464850; c=relaxed/simple;
	bh=34qGeTO/Y/p11RVt+zifaL0yAYJNxE+WVf8jP/6JUU8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n+pJRynkYCHNq1xfZWfK3Y/LI4NQnNGZPtV67nzbE5PIuxqwI8yMab885p3y9dRDoH799WdlpOMjBBTWic5K32SefAnr5Y2hTzz/3WWllh0gdC96FJea27kbdS1tr3G25BP7IRvy5e6gvYEGVrSkDtXi6Kf/gZ9KEIpy5GsQGKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=JvIlPtB+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="JvIlPtB+"
ARC-Seal: i=1; a=rsa-sha256; t=1726464837; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BJ8Tt0yZ0UbVwR9RthmcNPkW990Cht2xUd/LKwpvhXv6pEU7yB/kGXHgTVWcqDM5C2nLsqOQLXVcGvPYLK7lzU5g4vUtHTC2RBrQPNUjATqnv4nv+KbQaGwFhyGAasFbpYG5muUPmnoo8uQWf2L0o44yb4d1ok1M6AlUbBY6B04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726464837; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XbjH4XBzgY2HoXkpITtf/KzqoIar+GVTSpiIDHcPY9U=; 
	b=oFwkU1zEpTvOfKFOlrrgE/NX8rmK4s3qwSbFKNToOyyIK1NGJLa3clbUIWmbAgO0xEznrbkS/61mX+usWuBbomfoGg7s8Jj65aWAYpi1dMfaJQ9ZB+wAe0jQ6tpBSIwSSQ1zRGLurIR5v/Sod1vtGMPtJ6Nr8OorMABLVTNPgX0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726464837;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XbjH4XBzgY2HoXkpITtf/KzqoIar+GVTSpiIDHcPY9U=;
	b=JvIlPtB+n8nRZuU5mnm2/vXPcKElZ9juqgz1EEh7d05JFPlLRHgoiI8SynylAva6
	RURWuiYXaZZlYJMyG0Yw6ry0EtZuIAKn3USMqBN0yybD9L9vS/ROFNb81t9JNDbhqpi
	oE/7GwmCWmWpZ82RDszBlBjM8KWTI/A9s/6DNf74=
Received: by mx.zohomail.com with SMTPS id 1726464835114940.5451116990921;
	Sun, 15 Sep 2024 22:33:55 -0700 (PDT)
Message-ID: <a7977fd3-2c48-4f31-be64-8d8007824f8c@collabora.com>
Date: Mon, 16 Sep 2024 10:33:47 +0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Bristot de Oliveira <bristot@kernel.org>, kernel@collabora.com,
 gustavo.padovan@collabora.com, helen.koike@collabora.com
Subject: Re: [Report] rtla: Failed to set runtime and/or period
To: Daniel Wagner <wagi@monom.org>
References: <d3468fce-088c-45d0-8543-a2bc9fef07c9@collabora.com>
 <5b7e6aa4-8fe1-4ba3-b5e9-80bfa710afb9@flourine.local>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <5b7e6aa4-8fe1-4ba3-b5e9-80bfa710afb9@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Thanks you Daniel for replying!

On 9/13/24 6:47 PM, Daniel Wagner wrote:
> On Thu, Sep 12, 2024 at 06:58:02PM GMT, Muhammad Usama Anjum wrote:
>> We are running rt-tests on KernelCI. I'm looking at failures and I found
>> out that rtla osnoise and rtla timerlat are failing. We have just
>> enabled these tests and they are failing from day one.
> 
> Thanks a lot on working on this!
> 
>> The first thing I fixed in my local setup is to sync the version of rtla
>> with that of the running kernel from the source. It resolves the Tracer
>> timerlat not found!" error as we had installed the older rtla package
>> from Debian on CI.
> 
> There is some dependency between kernel version and the rtla tool suite.
> I suppose there is a window of version which you can differ but I
> suppose the Debian packaged version is way too old for recent kernels.
> 
>> I'll update it. Is the version of rtla dependent on
>> the exact kernel version or any recent rtla version is acceptable?
> 
> I have to figure this out. It could be that we need to build/provide
> matching rtla versions to the kernel. In theory the API should be stable
> etc but I suspect the APIs got broken (not on purpose) in the early
> days. Anyway, we have to figure this out as we can't ask Daniel sadly.
> 
>> The other errors are persistent:
>>
>> ➜  sudo ./rtla osnoise hist -r 900000
>> Failed to set runtime and/or period
>> Could not apply config
> 
> This works on my Tumbleweed kernel (pretty much a vanila kernel)
> 6.10.9-1-default with the matching rtla version 6.10.9.
> 
> What version do you use?
I'll report back the version.

> 
>> I thought maybe some argument are wrong. I ran the example from man page:
>>
>> ➜  sudo ./rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -E 25
>> Failed to apply CPUs config
>> Could not apply config
> 
> Same here. This works on my local kernel.
> 
>> Is there some configuration which is missing for running rtla? Please
>> let me know.
> 
> Are these
> 
>     CONFIG_OSNOISE_TRACER
>     CONFIG_TIMERLAT_TRACER
> 
> config option enabled in your kernel?
I'd missed these configurations. I'm trying with them now. I think this
is the root cause. I'll test with them. Hopefully problem would be gone
after it. Otherwise I'll look into installing the matching rtla binary
as well.

> 
> Thanks,
> Daniel
> 

-- 
BR,
Muhammad Usama Anjum

