Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1A420868
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599931; cv=none; b=k5aZdSeMJIkO1lgMKSBpj0O8ktvS2gchWrhIvc/x8fxfIBPbsw7qvecb9Qia5dfsjXzCvzq3YjHht3XqOMDU54tHYjjCT9ybLbOh0aHpTDWgzXxYFCUjjNkZMzcKj64lxeGXjfPsT5uCZlrUnQyUZZWq6YRcFMNFkaeJssJ1i+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599931; c=relaxed/simple;
	bh=2f84/nJZ2VgJabR+1a6ihDF3698u7R6LbS1dCMgWNUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6oxDQ76ZHPMCHnGKWZ5dv70ETTWmZj3/I8khb+4EsZDe5S0L0NpcAWbnnQUqfPgvActFY/Po3rGFIW/8Mn8VBMQ6aX73e4e+xjWygZGG4Grus4WCJOBwzMvHIMZRSI1rcKUvL/HTr7E9lGwpoCwL2FjBAgJaf18YLtX74bwa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXZX53Pb; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXZX53Pb"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cabe9335f1so11745385ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783599930; x=1784204730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DjINX5M4wTaoTW4+GDvLh6TXbZ20xVVmAICykKIells=;
        b=lXZX53PbW+g71BEkCtc9hjBWQb+ppjNYQZl2sKlWr2IrdLHlxtJCFQbf0TsoF8Q8h0
         76mf+oqV/Za6AxEra5PMf1XzOLU748t5RxQp4QenH0YwnDVdgW/7e1K/PwxFo+3D+6QF
         Z9OBor8cq7OwWFuYpY7TFgwktSv8fnWHrmw/ZjAwEpjfR98mBVfJVqGjHc3p42H1k/+8
         fpCiaSoqjw3sSUXhD2Stletw+6ztTih7CxaXV0MrlEJzy4h7/3E4U3xz7W/w7PujlzZI
         lW3ZTl0cvhpApZYptvlIk1aHY7O0eUlwzm6NFzwoFKO4RsGEjOk7oSPshWNE6Y5zx3r5
         fpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783599930; x=1784204730;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjINX5M4wTaoTW4+GDvLh6TXbZ20xVVmAICykKIells=;
        b=UgS7YUXI/GyYGiWHY3cUkZ2u2fnianFAILDzBsH9wUlDWQEI3Zi2Oz2/lK3Viv39a1
         soHlFmmr8ela0EcLKPPTO3aROPWVCw2HBpScDZIZxzu5wbOOMzEhHo4iyaobIcfNNx9A
         WVbMFev7Wg6Er+lTUVOuGcImth3qdUE0vIOktJFt16XbSezyDPZspMtqd2nREGoRyrrd
         aFwM2PjVrEWysCJ2//jUetkfBr8Xhi/AULfLH7X1vevb2Ks1vGJ2gJHZ14Zv0R1WXRhz
         8hXLNg9whz2a9yjeNu134xi9AWQ4J90e9uJQ22JHmlp46yeV+pfgcsg9MsfzHZTMs2q9
         Fw8g==
X-Forwarded-Encrypted: i=1; AHgh+Rqa9FWwkAOh7T/QB75lRfWIR4fA7EcODAysPy56UJPsMg7nNHDXFGAdW5MqjKTdiI7KaCl7XRK21G7MnSxoRo2HAOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPLUgybWMj9p4WrdHRwOl5acv2wVG///urFnszvQ9E0WtCqBr
	8SR+Z1Zv1gpAb/X55A7mbB94aqQTiGR2YPNyeykdntTPuhZe5T4fMHp2
X-Gm-Gg: AfdE7cnppT4+I/i3bJgKLPMMme6Adhkd8ihZJodAPHuCd+0ph4N+SgCU+cXGlFxEhjX
	knfe2poTtK9H2XwFU64iOT0+bGneOunqMQ+6j3cCSQYxGt6GsaTr56PVr0ihldrmZG2RhnpK8ru
	BlZr09BEz90fNBNpdzxW81pLu2tfkFMmKl5CRBpPCTbBjBysJVbhL8CznqK6+rqY2CytohkmmiI
	e8JwiS1SNYe295Gd1lc3iJTOcdZibV2aOcTKdrUptAmeXYHgIarqz+Xy4UNvNslNbDqo0DOYdwk
	MlJOmdte0tNoZrNGuIEqLEr70flo+Fx+HIPdFFG/+Mx6DVpRydujDTGgfDfAytR5ez5dy6lPNzE
	zA3+vPZfxJGDHEAyf0LasTsXFhM6vN9VTC69dGYvQIyE+3yEXMmze1v5tQVV9tN+IRmWy4xyCjl
	icVWsYVedpRdUkI/TzPChJSWQMUDNGK8A=
X-Received: by 2002:a17:903:1b0d:b0:2c9:97a7:3289 with SMTP id d9443c01a7336-2ccea47c30cmr71676685ad.43.1783599929924;
        Thu, 09 Jul 2026 05:25:29 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e1aesm44089605ad.39.2026.07.09.05.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 05:25:28 -0700 (PDT)
Message-ID: <6f2e6fe2-c8c0-450c-bedb-8b4fd68839ab@gmail.com>
Date: Thu, 9 Jul 2026 20:25:11 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com,
 fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, riel@surriel.com,
 liam@infradead.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com> <ak0OZKzapUefmA3v@lucifer>
 <20260709091316.TFgtBZlE@linutronix.de>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260709091316.TFgtBZlE@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 17:13, Sebastian Andrzej Siewior wrote:
> On 2026-07-07 15:54:57 [+0100], Lorenzo Stoakes wrote:
>> On Tue, Jul 07, 2026 at 08:59:25PM +0800, Wandun Chen wrote:
>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>
>>> The region covered by mlock[all] may contain CMA pages. cma_alloc installs
>>> migration entries in the page table, if a memory access occurs at this
>>> point, it must wait for the migration to complete, which may cause
>>> latency spikes on the RT kernels.
>>>
>>> Try to move the migration cost into the mlock[all] caller, which is
>>> typically a setup path. So reduce the chance of latency spikes on RT
>>> kernels by migrating the currently mapped CMA pages out of CMA region.
>>
>> 'reduce the chances of latency' so do you have any data to back this invasive
>> change or not?
> 
> The application gets pages assigned which belong a CMA area. If the
> pages are in need by the CMA then those pages are replaced with other
> pages during a migration phase. Since there is no guarantee how long
> this will take and is also subject to general scheduling in the system
> it will be measurable and painful once hit.
> 
>> And for RT, but nothing in here at all checks for RT? You're using this
>> compaction sysctl as an RT check somehow? That's gross.
> 
> The man-page for mlock says that it guarantees to stay in RAM and/ or
> preventing to be moved to swap area. I would however argue that
> replacing physical pages in the background should fall under this since
> the application can't access them and is blocked while trying. The notes
> section (in the man-page) lists "real-time applications" and
> "deterministic timing".  Therefore I think it makes sense to do this
> unconditionally for mlock areas regardless of the sysctl knob.
> Security related application probably only care that their memory does
> not hit the swap area and probably wouldn't mind 10ms delay.

Thanks for helping to explain, that helps a lot, Sebastian.
Wandun
> 
>> This doesn't feel like the right solution.
> 
> Sebastian

