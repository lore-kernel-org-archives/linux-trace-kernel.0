Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622C12BF24;
	Wed,  2 Oct 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851413; cv=none; b=Vr7Rju/JXet+jkNVMMEz1FjgJ4MgwGgw+HYvknYP57XmFqvsrRbv4kBobnCA/6wkCFkQ58z73b2RmRszMcr/+p6Q/t/Jx+dpl/251yLohxGiT6jUTthMKogbuG2zbCbFZ3YA3utCcifMT8/mzh6XMukmjk13BqrIeg250YtW1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851413; c=relaxed/simple;
	bh=Wjsq4EwcTgjny0p0mnnviABxEKuPOuwFRt8bT6KrNZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFQ/XoO7RDTvVAhqt368JoB34xK4jL5EL4suLRe0eGc8v2kxw2j7zxV3NjLCDsfMGmwodW4TUE3wtDW3bK1mmxuE4G6jldY8/l7nDSVNy8jMJ3MA332SK1ligPJY4OyczBRKzyUP93FMJrhu1hj75w1LVCYvP2M/Zm307jgLAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLEe6Kr2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLEe6Kr2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so4708428b3a.3;
        Tue, 01 Oct 2024 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727851412; x=1728456212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvwcnUAr8kT1iZ4ex1Ce7mUac/8MMgm4lLZSYZ1goI8=;
        b=LLEe6Kr200zMqLu6TegkbJiaDOWp/I+afF4htNEs9bHuz7jqVNib7iSyIL2HlMWFgc
         awov32V1GpBuhbq71wYK7d5CfSn5W3VM/iW3s2MuEekXkVT1YwfqFUD0PvuMH1F78JRC
         10HTiGkyzMosr6dkMiBdd9/ZI5A3mNKhe2ZNofhcNduImzQRC5AnGuD03yx8hzeORTIQ
         S7uyC7b/Unimny5m2APMD8LcExXrYfhCpjYQmSRYrLfV1kUkWavfHzngxJPa8Acs5jGd
         XhS1/wNr5T4AqCkTPgm/ii8qUA8+ejoUE/ncLh0UEpvcGmKOG6CNXJxPBq9sGI6of1yu
         XEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727851412; x=1728456212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvwcnUAr8kT1iZ4ex1Ce7mUac/8MMgm4lLZSYZ1goI8=;
        b=juhUD5TpyLRK/o3ZQWk2F9G7aaJ0ty9K0Ln1lZFv/WxJmXY4C5+gEL8q5yZ2kwiJgF
         deEKNu5BghbU+w8lksvMQ9aegU5geEL7RtWw8B4F4hXnR7XMsftEgbDKjaDZFQljedzH
         htPWOgpaVLCxsYsM7VbhQewl6IDXHrepY2Ve5sw1Ak0gZUJjdzWabOTV/UjdVq/tBETf
         F7v6lUu4wQwwcW0j4UnWcugPKPZm7Vq8Le9nCxFulnx1XXh+CtVZJYnZckcRpGvLrqQf
         Q0tSJ1EMHvNlXjnxIFgeFKewlJq8An699e0YKECJA3dK2hoxCfj9EHJd8f7QVH/50674
         xNqA==
X-Forwarded-Encrypted: i=1; AJvYcCWoKbHdAln+UxUVoIGzkSuIjspcc1Ne2aHQxvBAQgakUqLo/j/aqEkeooL//Wz2RuM7UNL4y83O6w3lfu0=@vger.kernel.org, AJvYcCXpdni/lss+gaEfRQr8X4S9mUbzvtODUmeOX+TAoR8gGG8/4h0YgSQeJ/tw0ZZvzFl9LpSDsqqkcsO59raYJKi5V2ug@vger.kernel.org
X-Gm-Message-State: AOJu0YyrUtMapKuZgBukKPbgw2xz+hTvEgYykkwDUMv5Zwbrum2RFOqW
	sUeQr5CWjjpE8X/Hvd+r1KhjMw12sz5JEZaREqMvE3hYoYPswYez
X-Google-Smtp-Source: AGHT+IHrvLlPYCKOeze87jmqW0iJu0MG71ZImxCsWLNCUioRLdMHBq8cdaLeugIUIOCL2XuT1a3Qyw==
X-Received: by 2002:a05:6a00:1a8a:b0:70e:8e3a:10ee with SMTP id d2e1a72fcca58-71dc5d53744mr2764819b3a.21.1727851411489;
        Tue, 01 Oct 2024 23:43:31 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:4b94:68e0:2d8b:3983? ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bec57sm9220291b3a.69.2024.10.01.23.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 23:43:31 -0700 (PDT)
Message-ID: <b0ec6a2d-8734-46f3-8cfb-f2bbe17dbf59@gmail.com>
Date: Wed, 2 Oct 2024 15:43:35 +0900
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ftrace: Hide a extra entry in stack trace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240926061311.25625-1-tatsuya.s2862@gmail.com>
 <20240930085139.5d34f28236a67ef1e9143655@kernel.org>
 <509829ab-98b5-4429-ba59-e1fc7b300682@gmail.com>
 <20241001094742.1282d2ad@gandalf.local.home>
Content-Language: en-US
From: Tatsuya S <tatsuya.s2862@gmail.com>
In-Reply-To: <20241001094742.1282d2ad@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/24 10:47 PM, Steven Rostedt wrote:
> On Tue, 1 Oct 2024 22:27:03 +0900
> ts <tatsuya.s2862@gmail.com> wrote:
> 
>>> ...
>>>                 sh-140     [001] ...1.    18.352601: myevent: (vfs_write+0x4/0x560)
>>>                 sh-140     [001] ...1.    18.352602: <stack trace>
>>>    => ksys_write
>>>    => do_syscall_64
>>>    => entry_SYSCALL_64_after_hwframe
>>>                 sh-140     [001] ...1.    18.352602: vfs_write <-ksys_write
>>>                 sh-140     [001] ...1.    18.352604: <stack trace>
>>>    => ftrace_regs_call
>>>    => vfs_write
>>>    => ksys_write
>>>    => do_syscall_64
>>>    => entry_SYSCALL_64_after_hwframe
>>> ------
>>> As you can see, myevent skips "vfs_write".
>>> (and function tracer still have ftrace_regs_call() )
>>
>> Thanks for the other tests. This issue may be function_trace_call()
>> specific problem.
>>
>> So I will change the place to increment skip number.
> 
> My fear is that we are going to just break it elsewhere. The problem with
> the "skip" is that there's so many configurations when we get here, we may
> not really know what to skip. If the compiler inlines something, then we
> may skip something we do not want to.
> 
> I rather have extra information than not enough.
> 
> -- Steve

It may not be clean and be bit redundant, but I think it would be more 
maintainable to treat

"skip(and skipped functions)" separately only at the top(parent) of 
functions that display stack trace.


thanks.
