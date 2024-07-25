Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE503376E0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940088; cv=none; b=PIOPH0Sfbyhu8PTd7+xmLgWvc7GnCZxF1tLQ0CsNUEzrY6zoPKb1GFyWjN3JBsVynZam4/6FIpH0+RjvCrOM56X671TIYwtBBrgaTL5p8tl3lpK5vDx4O5ZgW4iGKyK2L9mivzXkwyzUscqZE82MZUmUBOs4gpVscehB94qnXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940088; c=relaxed/simple;
	bh=uHxDggZn2EeWv/j0Ki5ZFoztPbZxVAeaLa6F9F4zQbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAedyWUTpCDTMB1Aeb4TXnDbnv3GCvMP9mXu6So3WVKylXEGAvy8b03Wy4n4Dt7WtgW4jhy3oN8cvbjpdFKh6Wee+1j6cq0Ufb3u2w5ktk3cLQjPnTKpMCy23FiDHK0Lj5g865gS451u95SQZdPNYL7++CTLjXg534AxrbDkGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=Z7IX88S6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="Z7IX88S6"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so1941723a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721940085; x=1722544885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aYBPb/0ZXc28yYuKCIzC+mCh32077RrzZFNnlIIkkLs=;
        b=Z7IX88S6V9M6smxEuMZUA0s6C9mO1iThFjOdfq/vzYrmmvfMulJbcJXKy2pUglOR11
         fyLxjPM9xIRoonMcA5gGkOqQGaSiYBOCmVI7DUKqkG3kpGC6SfZGg/kKAqGeY0mNvfEP
         4/nmJGNQ0st0sRzGPOqkYQtV5BVtlKsLB6KE5HQ7M2u/H2yTEbA+vpK7Rf8wCpIlhCiH
         pGwfybvaSKqBDjWAuVFmqrxZD9tVWdsiU0K9DXYYU5Tqg+Xr93yinAMOH/naKyHH7vq8
         wUAmGx3fGnTKPbUuUjhqT8KHT2QdtJQQcESHSZ1cBzFQPoaRMnuNjpmyfCZjphEvF+qX
         FnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940085; x=1722544885;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYBPb/0ZXc28yYuKCIzC+mCh32077RrzZFNnlIIkkLs=;
        b=YPx7t+AEsdR+Is8zjG0hv3O1WcQc7iM+u8D1axcMGKV4fgf2BVC+8r6ktAgOhk/GVj
         8z8noksbWqiES7sxVKdmCUCt7HYm+vlMZNRCtEIsPwFW74Cl+/l0UwPbXtu6mp2vwVsL
         bawRX2WhtAslT1tb9czo+/glWb0I6l4SV1wBuvhl2hMPkRgkGCO4rs0EyrFIo8/hg0zO
         pwFtmxD+IxrulmIN4jzJPiLXPgG6WqN4RbUKA/XUCPEGyzfaiqDUxl77zXpw442LS7nx
         e3FJMtoQNUYfTjv9a++13H6BRFTiL72W3wkXpPxOp98wx2zf5/k+A4jWsHY3JNcM0Jsv
         3AGg==
X-Forwarded-Encrypted: i=1; AJvYcCVPGnjZHpK0QwMaUEGi+bj6VeJrwHhaFDpU8CF0jooWogM1JRSzWUcYWcs14LLF3olrlgGv2mO0MZ03cATDW6BRX+MNfCtonAJF8ZCsr3h4X1LO
X-Gm-Message-State: AOJu0Yy6siTm5XR7poSraFm47F4FojpaPh961ON6PyDAHsWksArJbTiB
	XzClefHhS6yY6IdRTiqFavs0/lS2slDPJ3NWCSJ/Xv4HtKQ84I8x4pc3XwtqLKY=
X-Google-Smtp-Source: AGHT+IE7vK7kGgIWxBymU5BmGGcqkGywPebPMUOrPx0I4pb6c6j0ZQuDmXQllupleCO1SM3VvyKIBg==
X-Received: by 2002:a05:6402:50c6:b0:5a2:350d:dfb9 with SMTP id 4fb4d7f45d1cf-5ac6203a596mr2640079a12.2.1721940085050;
        Thu, 25 Jul 2024 13:41:25 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0d:f500:3285:7112:e461:c95c? (p200300f6af0df50032857112e461c95c.dip0.t-ipconnect.de. [2003:f6:af0d:f500:3285:7112:e461:c95c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3a18sm1149964a12.75.2024.07.25.13.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:41:24 -0700 (PDT)
Message-ID: <1b1b09fa-0064-429c-9f78-385119c5e691@grsecurity.net>
Date: Thu, 25 Jul 2024 22:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tracing: user events UAF crash report
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
 <CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
 <5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
 <CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
 <CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
 <CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
 <20240725131021.788374d0@gandalf.local.home>
 <20240725131632.64cab267@gandalf.local.home>
 <cff51d4b-80eb-4587-b4ad-bfe7d7361b19@grsecurity.net>
 <20240725150517.3184e078@gandalf.local.home>
 <0d1a8c46-43a7-42d6-bcbf-647a5a68c3c5@grsecurity.net>
 <20240725161519.35fd3bd6@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240725161519.35fd3bd6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.07.24 22:15, Steven Rostedt wrote:
> On Thu, 25 Jul 2024 21:42:41 +0200
> Mathias Krause <minipli@grsecurity.net> wrote:
> 
>> Right. But the point is, that 'event_call' is really some '&user->call'.
>> With 'user' being free'd memory, what gives? Dereferencing 'event_call'
>> is UB, so this function is doomed to fail because it cannot know if its
>> only argument points to still valid memory or not. And that's the core
>> issue -- calling that function for an object that's long gone -- the
>> missing refcounting I hinted at in my first Email.
> 
> Ah, I missed that the call was part of the user structure. But I think I
> found the real fix.
> 
>> [...]
> 
> I believe the issue is that f_start() needs to check if the event file has
> been freed.
> 
> New patch:
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6ef29eba90ce..5fbfa1c885de 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1627,12 +1627,14 @@ static int f_show(struct seq_file *m, void *v)
>  
>  static void *f_start(struct seq_file *m, loff_t *pos)
>  {
> +	struct trace_event_file *file;
>  	void *p = (void *)FORMAT_HEADER;
>  	loff_t l = 0;
>  
>  	/* ->stop() is called even if ->start() fails */
>  	mutex_lock(&event_mutex);
> -	if (!event_file_data(m->private))
> +	file = event_file_data(m->private);
> +	if (!file || (file->flags & EVENT_FILE_FL_FREED))
>  		return ERR_PTR(-ENODEV);
>  
>  	while (l < *pos && p)
> 
> 

Nope, still the same splats.

Sorry,
Mathias
