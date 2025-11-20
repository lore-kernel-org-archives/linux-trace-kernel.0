Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28032D9ED5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656833; cv=none; b=D3L6ZM+L/MgrEa3AK3Q53hq8ZWhrcUq7zIucNkTuWBC5O2hcokcz+kS1bXQqAuTubq5/zSrPi3IkVysd6O8LtTQ4w/hxERVx8yj6lolECMJsBBgooIupxjpCdJMQ2CdULV9sQKu67qXoCQ2u24OTxBZ9Pe21zYZJxC6Z7UPTfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656833; c=relaxed/simple;
	bh=0rLW36iyOf5x4MMAHLt7ZJRKB7UhffR6LbUm9J0KINk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qT0Vqn3b5HQLekyP89+maDkVAA+jNmajopCufoL9ZQQWFN45KZYVR2r5p89is1IuprwJFxNsIH0+Ka81fhg1TkzHwJM2KlnjxzDPJcLUbyNdYFZQHUqo3LTzxzg9G6+ccvW9/aEB1IUTEIr+4nA00AvxpK7D90fCKqqCGTttFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qna/Gj5W; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qna/Gj5W"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-94900d3ef9bso43092239f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763656831; x=1764261631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aa1AkRLymUeMfi+gvxg2H2c9FzoNzzQchV4cefwGG74=;
        b=Qna/Gj5WikmcXneAJgNzupCB7vXhKIHbcGbe4Bih3eqOVfOfgFryRU/AxsvGtM+Y6M
         AZJB+QdIlY8/Hr5Ru+9kN+wWZjQiwIRrKy0P86l4zGtK4nF1cgI9U1453OyhrGuSm7UX
         ystIrTkBybvrwjkPtQiYsHpV0uFpDNe5/VEO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763656831; x=1764261631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aa1AkRLymUeMfi+gvxg2H2c9FzoNzzQchV4cefwGG74=;
        b=qZYe3crMMnxEj0K4hyodmiBD4JObJXZ5txdEVpfek28IP01U6i9ekGBHMaxMyGw0+6
         9d30zuHFOuqioPLgXDcINRnEVgQHqsuzjDj5qtQxQ+oNOxmmEDGFNQWsOOqOuKJLM3rH
         pZT94Y6WBV/m5kzuW1KdmU7ixrZDD+3TENWcbdGe+4W+cWRokJHXR79sMnhHAjp6dBs/
         0wdgkZQCK1jxTpHKSDl0ig24Y0wQxwnrWoOB/YTdZ+E7L4OY/tTo/uAN2Q/VtO9YOz7f
         ATHqle6aKfPQRD4yEuyzjELYa3S0aD4wkNkrmUz2aZz07/yBR3t+J8RIJ+6oJA/v8+R4
         7ZOg==
X-Forwarded-Encrypted: i=1; AJvYcCUZxI4cunMCcx973n2jTvHIKTva+KaT0PKIUnRiXbztSctknSgnZBV3L172ETz/T8/Mav5OdaiAhzRTbrdKkh+c0No=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHSyetd4vlMv4ZpKsl0k16ljPpsqsHAaXZyMrr4FD3hEgvfh9M
	sOvk+B5S7rwWChpQSps51hAP6AMfMRy4oXYgojj0Pm1a5h2O0v77hrc0hHNhf+ohu+o=
X-Gm-Gg: ASbGncvDC4elt0ObaBJLeZmvsmsssKxPM8MbCaFdRKusQUSprOmBdpzWRfa0/T6mayt
	CNovdNBIJTYmjnMoPT6HfBokUg/Av1464Ze2sKK3K4uiZpakYpYBnW93lU2UXs6dgd4tgjfe4hu
	Ln79H4GUdhd6vadmJnLzRwDLNM6KKZIm5igr4p0k0mt1sCfSPQ+LirbzUdks+i9DH5V2VxrywBw
	zztZJMZpUyMq/M9mKftocIhDz2qUGIs0CqUsxGUw0plY4BZSCoQ6fAqd0VkoBge8slvUSrKsmzp
	jKICaeKvyC0GH4DTvj8SpZhdWuQmKufGC7whk3xSHVpaqsdAUZ3LpDampzDfAtPxBZbTp1V0B7j
	HfFKNECeQyBFh64vF8/zs5O5n0LkF9Zo6phObWgE+HKJ/2L00s/Uyxvbu9qkTXzMzopPWiS3IQd
	CaB9g4i+KPw6yCYrBGBt7vV1s=
X-Google-Smtp-Source: AGHT+IFsgTAAQrcv0Z7q9/prVRarkjR54xZam1Bd2zaiU428gFS16ceXIp7y0FoUhB6GTW5mK9UwtQ==
X-Received: by 2002:a05:6602:371a:b0:949:15f:6226 with SMTP id ca18e2360f4ac-94938ad740fmr250309839f.16.1763656830706;
        Thu, 20 Nov 2025 08:40:30 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949385d34a9sm108901139f.8.2025.11.20.08.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 08:40:30 -0800 (PST)
Message-ID: <f0774852-fe3c-4236-91b1-f38045ea26f7@linuxfoundation.org>
Date: Thu, 20 Nov 2025 09:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
 <f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
 <20251119170611.6eff8df7@gandalf.local.home>
 <b61a339e-f80f-4ecd-861e-e9bb834d5101@linuxfoundation.org>
 <20251120102526.e5e9332fcab1db3ce18c6d15@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251120102526.e5e9332fcab1db3ce18c6d15@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 18:25, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Nov 2025 15:56:57 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 11/19/25 15:06, Steven Rostedt wrote:
>>> On Wed, 19 Nov 2025 14:44:22 -0700
>>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>>> On 11/7/25 07:35, Masami Hiramatsu (Google) wrote:
>>>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>>>
>>>>> Commit 2867495dea86 ("tracing: tprobe-events: Register tracepoint when
>>>>> enable tprobe event") caused regression bug and tprobe did not work.
>>>>> To prevent similar problems, add a testcase which enables/disables a
>>>>> tprobe and check the results.
>>>>>
>>>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>>
>>>> Steve, do you want me to take this through my tree?
>>>
>>> Yes please. Masami's an official maintainer and mostly handles all things
>>> "probe" related. This is his domain ;-)
>>>
>>> Thanks,
>>>
>>> -- Steve
>> Applied to linux-kselftest next for Linux 6.19-rc1.
> 
> Thanks Shuah! This and other regression fixes is better to go
> through selftests tree because those are checking existing
> features. Maybe better to add [PATCH -selftests] or something
> like that?
> 

Let me know which ones you would like to pick up and apply to my tree.

thanks,
-- Shuah
