Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27AF1F9409;
	Fri, 11 Oct 2024 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628437; cv=none; b=SNMHWTdPPFvhXNPia2uWymZulYkjvHkPzM87JxRYAAOHl8Fv6E4Qjyv/UQatVpGPXcZeKJWW+0UaIg9DIR9Ynj0FPGOvL3lAs8no16Yqocm7YgeiQbMQpy9pfbd1fFKIW4X+eVw5GmEa1am3zJlK9SrQSzDy5Y/tviLn3qM5LOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628437; c=relaxed/simple;
	bh=ArjalxxQ+s6rtUD5kzrvbWQPdJuCy05+qv3EO41cnzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUZmkUKQZC6B9ABULwTdu0XOz5tZ8UNUD9/MTpUJySDYkwNkafkon1MESkTMm1tM0IRAyDhyJoLFQwdzX/nNpYTtQLT3/q3sNNuHmvbvabzE4sreAgdxqVbJ8p+kfZr360HKTSsi+y7Nyq4gpXsFUhH+Mg+3JZ5qai9hYWA9ER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhWZoY6f; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhWZoY6f"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c805a0753so14710185ad.0;
        Thu, 10 Oct 2024 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728628435; x=1729233235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WnRI6VJW3LMJo7XyXYei3wi8KKKDu4i1MPedhJrbTs=;
        b=WhWZoY6fKlkmkHhr+XdkKXaP67O6mRMqzorx0TjpL+peeBTK7hP1k4Tl5FGZ1Xqhz4
         lwMJQY8L2xcg+3Y4PTveVs9Dbrxha22+ANB4iVxkC0O8NnoiDgQ5ypj1esF/rLUo4tmq
         fheVDQLz+tpt2vLUq9k5Fklv7DJnv/WKnA21qPFovAXj6DaXSzHwWAuEhmH4f02wxoiR
         ZfVHglnqzZv71wgFHWBvFIPdKboVxm/NmvSYQCbLhNCAt3yi60u3NYQgECoR6trCCCE7
         0+28WQ2wU24fQkqLAxnwhM0quiQ1yjhhz/N/087LmYSG4NSqhHOURcXCSAxaMn8KTAP5
         1P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628435; x=1729233235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WnRI6VJW3LMJo7XyXYei3wi8KKKDu4i1MPedhJrbTs=;
        b=vN32zBD+He80SeNGB1LuBk5Ol7/mL90eIUhdEkOeXNHoParYQSRvH11oPDGi5ZOA0c
         keigWg8wM2/fH9ECetGh0Wust0Jd8Vrivt2wJTwYnqGgmwwU0Je8fk84BbPaNbmyUFLk
         /B8+Wg6ykq5nrD4RQVzPqGg36Qp0ENoLMRIzCqhF0ig5erix0AttABQp0MUw5zffamdS
         PIPA7LYtOdBz4DcJ/pE/63vGuds/Fkp9kRM0/Vf0wMWjlW1UnwcudveVdeLGUKT25IUt
         Sxb5aZHi6MCpKZrn4vCjtNbxkj2/QNJJBF1gu9xN0zvce+Wkz2qhC+AkdjZ5WFcHMEj9
         s5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV6mwPNk/aeHObKoq6vRsGqlL3uIzYlakMS3w0809Emote5nBhcP9tnqj7MnJNxbZg+6VRQFIIrWfjGrTI=@vger.kernel.org, AJvYcCXicqqKOXnxziQYUzbv8SJZRhv4O2Sr4ptJhBG8oe4ErkbbzD3mrYWMDOUFn0qX2C90iF91AplYJOFkB4+KPa4ynT/6@vger.kernel.org
X-Gm-Message-State: AOJu0YxobvbFt7vSVNG2UmvuVHtyRUKzP/zA0iGNb8VIVE3l5k34Yaxg
	cVwJSReLBMNPV/AfI1OXanF7kiUUgx6V7FWmuE+TWIb3hn1JLEdBlAOXqgOa
X-Google-Smtp-Source: AGHT+IGuBokSOGFJjSMAWGi7G5B5xEW5Hzvq7E3ESeZXv9hQ8ngmO1CJIkB5s1U2pM5S8nH44z3Zag==
X-Received: by 2002:a17:903:2b10:b0:20b:8bf5:cd72 with SMTP id d9443c01a7336-20ca16dd70dmr24748315ad.49.1728628434968;
        Thu, 10 Oct 2024 23:33:54 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:4b94:68e0:2d8b:3983? ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33ffe2sm18189905ad.270.2024.10.10.23.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 23:33:54 -0700 (PDT)
Message-ID: <c6cf37dc-a2c8-4b81-bb99-1231636ea3fc@gmail.com>
Date: Fri, 11 Oct 2024 15:34:07 +0900
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: Fix function name for trampoline
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241010130300.2083-1-tatsuya.s2862@gmail.com>
 <20241011000347.4b16dc96221873388475cb40@kernel.org>
Content-Language: en-US
From: Tatsuya S <tatsuya.s2862@gmail.com>
In-Reply-To: <20241011000347.4b16dc96221873388475cb40@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/24 12:03 AM, Masami Hiramatsu (Google) wrote:
> On Thu, 10 Oct 2024 22:02:59 +0900
> Tatsuya S <tatsuya.s2862@gmail.com> wrote:
> 
>> The issue that unrelated function name is shown on stack trace like
>> following even though it should be trampoline code address is caused by
>> the creation of trampoline code in the area where .init.text section
>> of module was freed after module is loaded.
>>
>> bash-1344    [002] .....    43.644608: <stack trace>
>>    => (MODULE INIT FUNCTION)
>>    => vfs_write
>>    => ksys_write
>>    => do_syscall_64
>>    => entry_SYSCALL_64_after_hwframe
>>
>> To resolve this, when function address of stack trace entry is in
>> trampoline, output without looking up symbol name.
>>
>> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
>> ---
>>   kernel/trace/trace_output.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
>> index 868f2f912f28..32a0858373e2 100644
>> --- a/kernel/trace/trace_output.c
>> +++ b/kernel/trace/trace_output.c
>> @@ -1246,6 +1246,11 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
>>   			break;
>>   
>>   		trace_seq_puts(s, " => ");
>> +		if (is_ftrace_trampoline((*p) + delta)) {
>> +			trace_seq_printf(s, "0x%08lx", (*p) + delta);
> 
> If we know that address is the ftrace trampoline, we'd better show something
> like "[FTRACE TRAMPOLINE]"
> 
>> +			trace_seq_putc(s, '\n');
> 
> And this is not needed. So for example,
> 
> 			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
> 
> is enough.

Thanks for review. OK.

> 
>> +			continue;
>> +		}
>>   		seq_print_ip_sym(s, (*p) + delta, flags);
>>   		trace_seq_putc(s, '\n');
>>   	}
> 
> Thank you,
> 
>> -- 
>> 2.46.2
>>
> 
> 

