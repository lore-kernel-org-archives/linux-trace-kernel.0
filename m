Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9D25761;
	Sat,  6 Sep 2025 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757126060; cv=none; b=sDgXUm3OzElsQtKFhsfozeHUvdPpr/WFHYABL/g88NJ60f8ZJ6ZO7aT51oWBoQfMFC96+g4QJc3djvnFXtml0QkSdoHbPDN4FZRe5Mkx+abmDOyHi7eTclUJfctA2RTtVUOLx11Wb4Q8petk4RTpiRs/2MW2kDKU1tNIpRxnAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757126060; c=relaxed/simple;
	bh=0zqj2V77+wl8joj18pG/LyTWZKmEqo0FZWJfry3iY1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFP3+pxrZdrTr9wAqzfGjZHSwCSVIrje9OtpOYnLdKBHEk6ue9Azo04uVuvudYBeTLtSn9LKFNRUaqsAoqS4wFj76jrrqlQS6bHGlAekagsrvjR2u6oT3NBMKxMaswRsKCYyCKHQsN21vbI3kxtkSkXGJrrKnDjQK1Ex/8lKuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbHufwub; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbHufwub"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24c7848519bso26408095ad.1;
        Fri, 05 Sep 2025 19:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757126058; x=1757730858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ebb0+GX7jxRV/Dgig4ua9NExiay0EIM4IGbBtoZim1E=;
        b=DbHufwubw5MGJ1urMv6Gkil0oV1YAECrR2yUjYWFtYKGyZ+HPIg5a5fH0H/Oztjdyk
         s6/6j8uApkvJn3chIhppoYHWsLb8AlNIZ0YJGzOvuuHcQ0klGyO5P0ee9ktCPBj9x46A
         zqymW8buZSrCXZfRR0Jakp2T86O7HhDLdrYxkk9a/vr7PHPLervOo/olm+e5aZFjMHz9
         IKwfa+PlP4P58qapyodwOO08HJbG4C0zVIRj6ZwxO9tdL/6873bMQaGxl4K94rvJiuUP
         V+k3MPMXW01X8yRWjSxbfGGVWs8Ce0Ixb4qIS4y9EGbrwn790+arAbnGn8/goUZ4/MQD
         69QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757126058; x=1757730858;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebb0+GX7jxRV/Dgig4ua9NExiay0EIM4IGbBtoZim1E=;
        b=KeQLH/JFqQjNRjzuNBm8ARX5qV3x9ZNqMXbUBsE1XclfLRW6pk2OmeghrFg28Uy9/Y
         m+Lq2ndQLQjYskC96/d/WRHM7GU9XfCGY+mcvJLgZcqAG034CMKBuw/kC0le0JXGE3q8
         xxMdJt+txNT624HBhS9c8vWJQlLFN1e4tGfqM5wIttAZtzDE7BmXpaSxcRGCX/ZwH1J3
         7549ERKJAQf4wUMPAHDhRmUiH36hFayL6dL3R26lIXHBgA0cGULBLPOQixpGKidIVET2
         tKll/fwq1kAaTmtVS1bsOfxq3zsOUf65pbVZev2rCPYZis3kuVVrukfjLy8bZ7DT7OG6
         iz+g==
X-Forwarded-Encrypted: i=1; AJvYcCV7XvGPtWvUoHHdR+K3MnOQMocpsrEi6gKzsC7szZudOhWVO8ZgGv+lxT4bpjnyEodyR1/xFwbFElHyCoQ=@vger.kernel.org, AJvYcCWtbZG46VhkcjbJ2w406s+qGlKU8I9DEJ8ImWcHwEMYZSSBtni0pKi0gFrdsPdFw4H5mE1BsWu95nXduivTXbQwkP8R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5VHc3QZtcye0IvHhjmkOp5aLbZSAsszferFTgpYOizIu2f36/
	IO83Q/T5vjtPxaUnI5HLUtOG+I+hpyu8M6cqtbACqJLTEK5uClQ/xm6x
X-Gm-Gg: ASbGnctvILDPTu+4UNxY6ofYUE0FcBuMj9kI5WTp5IsyddrOFCsufQJMLA2RX4Ebt4G
	ti7s72XhnfZqV9ei4vDXPJDX4Ik4oezndZu8nbdTaKIH39GpImOip9DeBImWCzr7kRTxtF+8e9j
	koQjoY3dWD75C44Vw8UAN+UBMbGJXm7QqdsMGUw756OfQaTaK2rcQ4GUT8TxnZT3Age364gv9i6
	9p7CSx88299sVy3Vn1G0pUIyEusN30IT6q4Lpl9bQYWrT6bFaSiaedo7VrNpRtzeitnX8VGBXFP
	h0turU0pP3bKjEXee6WXBFOGaOSuwS+3aZkj4rO+qRJImt0O7IHxa5C+9YSLAF7IJFCUsU31yME
	TLW/WLfKk5P9FSlorOgcvvsld8zjQfMD+v/ArNyCovAyYKzVkDi/+IXEa/cGexeOlzCQ5GoE=
X-Google-Smtp-Source: AGHT+IFate08/VMcXn+cnoIHzva0ENuiawnOhlHREm2z3BbTozoGhzbrdy9d7/S9aHe+g/MRRQ4Gyw==
X-Received: by 2002:a17:902:f550:b0:24b:270e:56f4 with SMTP id d9443c01a7336-251736df030mr11692715ad.37.1757126058087;
        Fri, 05 Sep 2025 19:34:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced597370sm36157805ad.128.2025.09.05.19.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 19:34:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <63b0ba5a-a928-438e-84f9-93028dd72e54@roeck-us.net>
Date: Fri, 5 Sep 2025 19:34:16 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] trace/fgraph: Fix the warning caused by missing
 unregister notifier
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ye Weihua <yeweihua4@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818073332.3890629-1-yeweihua4@huawei.com>
 <9d6ee97b-5b0a-48a7-850d-de18d3107bce@roeck-us.net>
 <20250905223029.4fee615b@gandalf.local.home>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250905223029.4fee615b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 19:30, Steven Rostedt wrote:
> On Fri, 5 Sep 2025 16:19:02 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> +++ b/kernel/trace/fgraph.c
>>> @@ -1391,10 +1391,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>>>   error:
>>>   	if (ret) {
>>>   		ftrace_graph_active--;
>>>   		gops->saved_func = NULL;
>>>   		fgraph_lru_release_index(i);
>>> +		unregister_pm_notifier(&ftrace_suspend_notifier);
>>
>> Is this really correct ? The pm notifier is only registered if
>> ftrace_graph_active==1, but not if it is larger than that.
>> The above code unregisters it unconditionally, even if
>> ftrace_graph_active > 1. I can see that the resulting double
>> unregistration in unregister_ftrace_graph() doesn't really
>> matter since the error return will be ignored, but is it really
>> irrelevant for the successful registered graphs no longer get the
>> benefit of the pm notifier callback ?
> 
> Ah right, it should be:
> 
> error:
> 	if (ret) {
> 		ftrace_graph_active--;
> 		gops->saved_func = NULL;
> 		fgraph_lru_release_index(i);
> 		if (!ftrace_graph_active)
> 			unregister_pm_notifier(&ftrace_suspend_notifier);
> 	}
> 	return ret;
> 
> I missed that there's a:
> 
> 	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
> 	if (!ret)
> 		fgraph_array[i] = gops;
> 
> Just before the error label, so the goto error isn't the only path there
> that can affect the ret variable.
> 
> I could add a patch or you could send one.
> 


I'll try to send a patch later tonight.

Guenter


