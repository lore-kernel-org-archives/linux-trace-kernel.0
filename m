Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAE52F9E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937191; cv=none; b=USOtRXSVhG6qSgT/CCSKajIhJWwtgwRnx/SviCkMXOwSdTGyG81sRVTdSk8Ci9wYODJgYhZb8wYQR/eUTZ5g1JABiH41sDCalDszbrrfJl1YBMRpxe8lryWz6E0i2o+ht8QBHzGP4tNFMbReZKJzndYU4sP/D2gznVsJos47CMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937191; c=relaxed/simple;
	bh=qrjAX8ZtHszttz8vYdvcF125vc7Dv4IRgnScP5SMCZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHRhcHWTmGyb7isbfVRPIzkMXg3k3+IlmYIAzYV3CujK5uZ4i8KW8tSctepyl46XszIrj2eu1KESnj8TYIQ3Jtcez+mrruxdBsMdBi7e9cuFgMC0sEiVlpvDCWDvXITBlKM7INd4zzib7JV6fRxymU4j7xGu4llklMjLD3Mz7f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=Pe/xwgN+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="Pe/xwgN+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7979c3ffb1so53657466b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721937187; x=1722541987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yatjSPCxEhwoast5v6pfaV1MSY3YApoRr8CTZJv1ZFM=;
        b=Pe/xwgN+XshlstaDPMStX4gkrVOFdgAhI2/0qr0AnX9UUsKugiuZvwdLHyrehihkfX
         x6ujJWl4uFgRrVFFv7RRNIEh2Ae+qEjX1FgGIXk4VX4t0z9Jb3rfmM6lgUqM259n06zb
         syLysvxCZzPM+I6zxBIU1cR3bN4zzO9X9SMfaLNGN4YaIa+FiRM30eU25cieJ6fvEPtX
         7yi+8961By0VcQGqpZJuIUvyKPB3A09rydutQkCICSTEOV8rvvo8gT31XVMVT8IAcn9Y
         zMW+APJwwl8OwZNWiYVYW0kAIZz84Fpfu6O7Fd0K4XycKDJbZuY+iASWYfB45YbkRRGn
         mz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937187; x=1722541987;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yatjSPCxEhwoast5v6pfaV1MSY3YApoRr8CTZJv1ZFM=;
        b=iDHTan7V5pQ2AC9ttxuUQcJfdXUr6hYUGTM8VZ6rTeHoC8xMFwNFJfl2eQ+o0MDUwN
         EMJh1Vz1jluzfFv67QafszPaKF2oO7GAiNEGB0eGDMSU1UcZGGS7wYVJWHpLCL85fJHP
         hBs9rsM0qvLou/DONsHNxKUCSkJHc7a2woUO7T/hX93vXb3DQVTUXNQhwEw03J/bEt18
         DW0Mw/w/s2H5hgQ4Si6pVMQH9A9LHiADduHv0+s0YW/7AvY+t+JoYWtndkUsSZwz5Cdc
         XwIhM7ktnKBdA68pyjhhPvBeBQzxbBxM5riYw/gX5/8uap6XUtjdhgUA8BDfLqrzS3vW
         zmtw==
X-Forwarded-Encrypted: i=1; AJvYcCWQrOF6barrfhaUjsI62+F7WTUXoMsrnXu1jh9LQ7KGuY3w3z3rYjFMqo7vxF+PyydbbGtIF56YWr5xRXHp/Nr29RDOS7LP7al16Zj0jYmZJVVD
X-Gm-Message-State: AOJu0YyYvfeEk3QkZMHsWqdS3Sdmf735LqYG+ghksPDalPqOnrvxBOPp
	1JKKeUeEtSveBDSwR3qq5Sbwr+hNJcvx9cuaBfUznqVpliviFYbp++5w4yN+pks=
X-Google-Smtp-Source: AGHT+IFs3lsnbIAhS4feK8PTtWLYT9H0xjTGQ5V1Cz9O6ywu3vLst4rAEJ0budxAVRrhMcoSy/Yzqw==
X-Received: by 2002:a05:6402:2684:b0:57d:3df:f881 with SMTP id 4fb4d7f45d1cf-5ac6203a217mr3720133a12.3.1721937187016;
        Thu, 25 Jul 2024 12:53:07 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0d:f500:3285:7112:e461:c95c? (p200300f6af0df50032857112e461c95c.dip0.t-ipconnect.de. [2003:f6:af0d:f500:3285:7112:e461:c95c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b5a7absm1111914a12.54.2024.07.25.12.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 12:53:06 -0700 (PDT)
Message-ID: <b8d5c42d-160d-47a9-81e8-289b49606c9d@grsecurity.net>
Date: Thu, 25 Jul 2024 21:53:04 +0200
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
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240725150517.3184e078@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.07.24 21:05, Steven Rostedt wrote:
> Here's the proper fix:
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6ef29eba90ce..3a2d2ff1625b 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3140,8 +3140,10 @@ EXPORT_SYMBOL_GPL(trace_add_event_call);
>   */
>  static void __trace_remove_event_call(struct trace_event_call *call)
>  {
> +	lockdep_assert_held(&event_mutex);
>  	event_remove(call);
>  	trace_destroy_fields(call);
> +	call->get_fields = NULL;

That should be:
+       call->class->get_fields = NULL;

>  	free_event_filter(call->filter);
>  	call->filter = NULL;
>  }
> 
> Can you try it out?

Just tried, dies the same way, as expected.

Thanks,
Mathias
