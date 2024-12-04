Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6C33D1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733274070; cv=none; b=ojy81WrT+8JyVXpzVSLhaEVNeRw9bGW9BtIJulZK+j8zmlFv5KgVLUquOId/+hQL9uKN+h6QBq67B1l6LWqnYl6hH6kBJnguZOVcI1WWMCqu4b22KzAXxpqE3BDE4X8Bc/4bqkad9ax1qtcduDX5zJ772TE7Ec5hk4SBxIX+amU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733274070; c=relaxed/simple;
	bh=+PnW8Rx8QB0eXrlBZgoHpq6Fxpv9sFiJp0O5DS2PCTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3gIF6wwPnEc0cG87bjeHFj2ZrBGwIxDeLjuQasi58TOQIOITVUmFpPnkBmf+rp1T+cH9PHw9JPQfkLQN3FTHX9r7FuBJ3e7oXxRr92uzKYvvphm67VlAyVHBvzQwZBMvV/3U8dE+APmLNMe05yrSasrqnjdPorHO4eDHdp+F/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O21RvWsB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O21RvWsB"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a75c24f447so23319045ab.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Dec 2024 17:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733274068; x=1733878868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NA+ElRETJKY5CqdJTdKRnj5fYbwfNKrJQ8Yc5F8bfeI=;
        b=O21RvWsBnhtQ/WVgO05CT5EXVUCJcnWaxDuH6WVNl3DuOEKN+579/pYgVGyzXLP50L
         0s2pMeoDAuJjzWa92LlUslWOUPz6dng5QjgDF0CPgKUutLekMwR3woO3VydXbYZzO+r0
         OS6/tvfn0D4ilchWmRBKaYDpxrPgfIILMNlA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733274068; x=1733878868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NA+ElRETJKY5CqdJTdKRnj5fYbwfNKrJQ8Yc5F8bfeI=;
        b=NWPRH+cVd2q2vKVhCcqketE2XxBHpRveUyBeb7EJ7QLngUV3PS4UNvK72v7tlj8S3G
         JOppZIpXope8QgPIbNVWDDBkD4ZokmFIM01NTVHCyc86Qxeg9uXfjHdAJlYgbWt+Uxf6
         7em4/fa4j989AojXkfrsyyWZJlWxAyT8vvWgC+KSPPis41FWTNi9ii0pX7zuGEykwPMl
         UFxqfpLj2VNKwma5CPu/14/IgqdVk7r9FLFFiVu2hUYGFH4y8zjo0GsIByg4y4RQWWU8
         UNl2pGHkShKv3r8OJynfr7MO48Ipg2V9wV9ZPlzUD+Qd30C1JBbxKE+9WSuqdjUPkX38
         zQlw==
X-Forwarded-Encrypted: i=1; AJvYcCVTgJ6xS4mATkyQN4K9541if8512OiuDQcfJSiQMicyF0ViZ6rcuYP8OB90shRn3yB18cTzPg3/FWMolEOhCNg8zMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvyQS99YD9UDsYXMhG7MZTUE6Rg6ZU5lZLBTYFEzHa8xFOwar
	VLU7k10CXJej3IGRecaO/iW6cv+MugCb78B1/um/Y6vkCm0F5qo4Qm6i8Rnvs14=
X-Gm-Gg: ASbGncssQklIg4XUER78kt51Vsoa+gqir0auAAIWpBLdcH0FrZQ5gESeCx5utMhtdQV
	axvxg1JP93V3AOWzKPWO7rkftklIHSJDMGYKAtjhDa20vt2hjWL07ZOHGbxlufREWOxmG7whvyY
	ABKXO93tB9bUVozOBQuK9hZlGhHuxpYkDhXVbTUtaUBhERjJUr5SMAe8u174kU8HwiLLe5Zaf9/
	0M5GRwqkLByNJIIs6s8zt0W7xeAutsd0Lma+TCYzXbqqh26d/OP08J/Dbv/9Q==
X-Google-Smtp-Source: AGHT+IFa+Bd2NpYOHu6EHzfrniiaLxPU/ePwfT0m1+/YTPvjeHG3Isi7m4kg/5QlpdI+LxP5aHV9sA==
X-Received: by 2002:a05:6e02:164f:b0:3a6:ac4e:264a with SMTP id e9e14a558f8ab-3a7f9a46431mr58360885ab.10.1733274067594;
        Tue, 03 Dec 2024 17:01:07 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e779e8sm2783394173.137.2024.12.03.17.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:01:06 -0800 (PST)
Message-ID: <fa1e747f-1823-4d20-86c0-b85a3b959952@linuxfoundation.org>
Date: Tue, 3 Dec 2024 18:01:06 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/ftrace: adjust offset for kprobe syntax
 error test
To: Steven Rostedt <rostedt@goodmis.org>,
 Hari Bathini <hbathini@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Naveen N. Rao" <naveen@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241129202621.721159-1-hbathini@linux.ibm.com>
 <20241202144111.75d1bb3b@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241202144111.75d1bb3b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 12:41, Steven Rostedt wrote:
> On Sat, 30 Nov 2024 01:56:21 +0530
> Hari Bathini <hbathini@linux.ibm.com> wrote:
> 
>> In 'NOFENTRY_ARGS' test case for syntax check, any offset X of
>> `vfs_read+X` except function entry offset (0) fits the criterion,
>> even if that offset is not at instruction boundary, as the parser
>> comes before probing. But with "ENDBR64" instruction on x86, offset
>> 4 is treated as function entry. So, X can't be 4 as well. Thus, 8
>> was used as offset for the test case. On 64-bit powerpc though, any
>> offset <= 16 can be considered function entry depending on build
>> configuration (see arch_kprobe_on_func_entry() for implementation
>> details). So, use `vfs_read+20` to accommodate that scenario too.
>>
>> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Can you take this through your tree?

Yes I can take it. I do have question about whether this is
a fix - sounds like it is from the change log.

Clearly stating that it is a fix will help so it can be picked
up for stables.

thanks,
-- Shuah
