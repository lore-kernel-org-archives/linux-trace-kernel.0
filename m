Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D318DF79
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372028; cv=none; b=m/3SYKiLsJEX0sUbJntdsA03y60pij+TWWSS40mpnm0PZalEJNkmry6PK2HAuc1SwTu9aDu1TiG0zsrGfcnDtKcTD89JDFTt0E6pl9s7Pj11rJZ7PxFVOo3xAa3lhy6e0E8KIJodQ/E97ByXsGaglQNM42kSzN2uAMG0WUomXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372028; c=relaxed/simple;
	bh=X7QJhhWf9adpBk8dzUifgR68jrI5E9zE4IEI79fNvC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwATHgozK2cRriiaFMBQmwtz3yuPyWTZ2hYPIVo9h6djaqixs0Fk88xtFK8Uci9hqolkZiZEUwG+qeLDsaFsdfF3ytUMsMYBDUVn/Ug3TVEzP7zjzgOkv4qjipqTa8bgcina3UkQ73Vy9EQyK/kN9qxO9AgyghkAauww+xgxZn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=X50IsJ1f; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="X50IsJ1f"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso658893966b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1722372023; x=1722976823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gzm3B1tMEgBJlgCIHRNTr0nMrh6fgKAU8aA9ggNB7Y=;
        b=X50IsJ1fITRnwF/gg4HxBvvIEoyEx3gZPJHt9Ep4fjk9aIqoDgjqh+wMCF74qi0DGy
         gRn6Q3TU6s6L10+OUUMtPiOgnp23EzUrMDMWAIkok9AlvzZ3N082g0jES1BDE7L2KCFf
         FHzOhuDaLa6NnkIIcPknz81GsifRP+KZZrUvy+o9R/snCcROKzVy/lPjYi0r9899mosD
         X1/oR17X8mQS0yLrT4i4XBQ7cm5dow9USmDIrQ9hDA6mBoaHVAVvpkrEKXx2Mu9zlpZH
         EOo9t37iGmO8kgiPCT389x4fXWXhbskjq0cjnFrrVXjbRIErq/XeT58HSmHBBB/UpiUi
         X/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722372023; x=1722976823;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Gzm3B1tMEgBJlgCIHRNTr0nMrh6fgKAU8aA9ggNB7Y=;
        b=V6F9UTFTiqjIOlpuTU4MZ2HjqIdEpNmLchvpPTsrd6UhwCmZTnVEonfaKx11Hdtefc
         aOdGx7gcsmZ5SW1HgkymbfLfDnfefd3mXZxHde5qVGfaEKbvhniLiIkDN8HGZ0EHIb8l
         N3NMBOK+uOYCot7cxfIwiLO3jJyoHpS2MlhegOePCkvW3f5lbYL3d2jqqBNm3eFu7NpT
         ASXCdN3LNnfUVJe+pMsqX7HoTWa1PBLeI97Lc4z3VvnYIONIsbMdDTnLcDhuAjGsYg2D
         2RZrwI9bPO5FP5/3gXNl3rCwpBrroTPc1XmuIVcsdNksqQxDtR38S6MHD4+Mvo29tpR/
         ufzA==
X-Forwarded-Encrypted: i=1; AJvYcCX28h4LIgvJ5etvGkQrwPFZQISSUfsZJSs2q7HehtMTuekEtPl9JEc6x6TtdKQYArfNdr/lsAH2kd0Jze8CUZGPSOWtZDo1+7QX5qZxa7697++V
X-Gm-Message-State: AOJu0YzP05eV4LzqMTWp7WEPw/WKiNpWF6he9O5qAI57ZLYu+ibQhJww
	Aafz+QNJQlCSzxjVg/Vc3hDEMJ2pFdvL02E63CWpSuBPaSn/IeZoS50m6WAkyok=
X-Google-Smtp-Source: AGHT+IEQ3245uCXnav7MAOPrp/CKV0Scpb9ILRtKEN7iKMX6iOq02v57iz39MEXj4+8cuUEpvQPucA==
X-Received: by 2002:a17:907:3182:b0:a7d:3ce8:131c with SMTP id a640c23a62f3a-a7d4015fd1amr833389066b.62.1722372022985;
        Tue, 30 Jul 2024 13:40:22 -0700 (PDT)
Received: from ?IPV6:2003:f6:af10:1b00:f3ec:2c43:19a0:988e? (p200300f6af101b00f3ec2c4319a0988e.dip0.t-ipconnect.de. [2003:f6:af10:1b00:f3ec:2c43:19a0:988e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad93105sm686722166b.167.2024.07.30.13.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 13:40:22 -0700 (PDT)
Message-ID: <b14bdf3a-b24c-4765-b3e0-971880e40fb0@grsecurity.net>
Date: Tue, 30 Jul 2024 22:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing: Have format file honor EVENT_FILE_FL_FREED
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, regressions@leemhuis.info,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
References: <20240730110657.3b69d3c1@gandalf.local.home>
 <20240730111508.75448556@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 xsDNBF4u6F8BDAC1kCIyATzlCiDBMrbHoxLywJSUJT9pTbH9MIQIUW8K1m2Ney7a0MTKWQXp
 64/YTQNzekOmta1eZFQ3jqv+iSzfPR/xrDrOKSPrw710nVLC8WL993DrCfG9tm4z3faBPHjp
 zfXBIOuVxObXqhFGvH12vUAAgbPvCp9wwynS1QD6RNUNjnnAxh3SNMxLJbMofyyq5bWK/FVX
 897HLrg9bs12d9b48DkzAQYxcRUNfL9VZlKq1fRbMY9jAhXTV6lcgKxGEJAVqXqOxN8DgZdU
 aj7sMH8GKf3zqYLDvndTDgqqmQe/RF/hAYO+pg7yY1UXpXRlVWcWP7swp8OnfwcJ+PiuNc7E
 gyK2QEY3z5luqFfyQ7308bsawvQcFjiwg+0aPgWawJ422WG8bILV5ylC8y6xqYUeSKv/KTM1
 4zq2vq3Wow63Cd/qyWo6S4IVaEdfdGKVkUFn6FihJD/GxnDJkYJThwBYJpFAqJLj7FtDEiFz
 LXAkv0VBedKwHeBaOAVH6QEAEQEAAc0nTWF0aGlhcyBLcmF1c2UgPG1pbmlwbGlAZ3JzZWN1
 cml0eS5uZXQ+wsERBBMBCgA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEd7J359B9
 wKgGsB94J4hPxYYBGYYFAmBbH/cCGQEACgkQJ4hPxYYBGYaX/gv/WYhaehD88XjpEO+yC6x7
 bNWQbk7ea+m82fU2x/x6A9L4DN/BXIxqlONzk3ehvW3wt1hcHeF43q1M/z6IthtxSRi059RO
 SarzX3xfXC1pc5YMgCozgE0VRkxH4KXcijLyFFjanXe0HzlnmpIJB6zTT2jgI70q0FvbRpgc
 rs3VKSFb+yud17KSSN/ir1W2LZPK6er6actK03L92A+jaw+F8fJ9kJZfhWDbXNtEE0+94bMa
 cdDWTaZfy6XJviO3ymVe3vBnSDakVE0HwLyIKvfAEok+YzuSYm1Nbd2T0UxgSUZHYlrUUH0y
 tVxjEFyA+iJRSdm0rbAvzpwau5FOgxRQDa9GXH6ie6/ke2EuZc3STNS6EBciJm1qJ7xb2DTf
 SNyOiWdvop+eQZoznJJte931pxkRaGwV+JXDM10jGTfyV7KT9751xdn6b6QjQANTgNnGP3qs
 TO5oU3KukRHgDcivzp6CWb0X/WtKy0Y/54bTJvI0e5KsAz/0iwH19IB0vpYLzsDNBF4u6F8B
 DADwcu4TPgD5aRHLuyGtNUdhP9fqhXxUBA7MMeQIY1kLYshkleBpuOpgTO/ikkQiFdg13yIv
 q69q/feicsjaveIEe7hUI9lbWcB9HKgVXW3SCLXBMjhCGCNLsWQsw26gRxDy62UXRCTCT3iR
 qHP82dxPdNwXuOFG7IzoGBMm3vZbBeKn0pYYWz2MbTeyRHn+ZubNHqM0cv5gh0FWsQxrg1ss
 pnhcd+qgoynfuWAhrPD2YtNB7s1Vyfk3OzmL7DkSDI4+SzS56cnl9Q4mmnsVh9eyae74pv5w
 kJXy3grazD1lLp+Fq60Iilc09FtWKOg/2JlGD6ZreSnECLrawMPTnHQZEIBHx/VLsoyCFMmO
 5P6gU0a9sQWG3F2MLwjnQ5yDPS4IRvLB0aCu+zRfx6mz1zYbcVToVxQqWsz2HTqlP2ZE5cdy
 BGrQZUkKkNH7oQYXAQyZh42WJo6UFesaRAPc3KCOCFAsDXz19cc9l6uvHnSo/OAazf/RKtTE
 0xGB6mQN34UAEQEAAcLA9gQYAQoAIAIbDBYhBHeyd+fQfcCoBrAfeCeIT8WGARmGBQJeORkW
 AAoJECeIT8WGARmGXtgL/jM4NXaPxaIptPG6XnVWxhAocjk4GyoUx14nhqxHmFi84DmHUpMz
 8P0AEACQ8eJb3MwfkGIiauoBLGMX2NroXcBQTi8gwT/4u4Gsmtv6P27Isn0hrY7hu7AfgvnK
 owfBV796EQo4i26ZgfSPng6w7hzCR+6V2ypdzdW8xXZlvA1D+gLHr1VGFA/ZCXvVcN1lQvIo
 S9yXo17bgy+/Xxi2YZGXf9AZ9C+g/EvPgmKrUPuKi7ATNqloBaN7S2UBJH6nhv618bsPgPqR
 SV11brVF8s5yMiG67WsogYl/gC2XCj5qDVjQhs1uGgSc9LLVdiKHaTMuft5gSR9hS5sMb/cL
 zz3lozuC5nsm1nIbY62mR25Kikx7N6uL7TAZQWazURzVRe1xq2MqcF+18JTDdjzn53PEbg7L
 VeNDGqQ5lJk+rATW2VAy8zasP2/aqCPmSjlCogC6vgCot9mj+lmMkRUxspxCHDEms13K41tH
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240730111508.75448556@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 30.07.24 17:15, Steven Rostedt wrote:
> On Tue, 30 Jul 2024 11:06:57 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/
>>
>> Cc: stable@vger.kernel.org
>> Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")
>> Reported-by: Mathias Krause <minipli@grsecurity.net>
>> Tested-by: Mathias Krause <minipli@grsecurity.net>
> 
> Hi Mathias,
> 
> I kept your "Tested-by" tag because you did test the part that fixes the
> bug you reported. I just added on top of that one to handle other possibly
> cases. Let me know if you want me to drop that tag, or if you tested this
> version as well.

Hi Steven,

I retested this version and it's still fixing the bug, so you can keep
the "Tested-by" tag.

Also nice catch with covering the write part of "filter" as well!
Testing this specifically, I saw a few ENODEV's, so it's definitely
possible to hit this one as well.

Thanks,
Mathias

> 
> Thanks,
> 
> -- Steve
> 
> 
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> ---
>> Changes since v3: https://lore.kernel.org/20240726132811.306a449e@rorschach.local.home
>>
>> - After inspecting the code, there's several users of event_file_data()
>>   that return the trace_event_file descriptor when it could be set to be
>>   freed. Add a new helper function: event_file_file() that will make sure
>>   the event_mutex is held and check the flag and return NULL if the file is
>>   freed.
