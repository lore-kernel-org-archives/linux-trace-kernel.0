Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16729245AF3;
	Thu, 13 Feb 2025 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473969; cv=none; b=szf12Pu9zw6YeteUb6SKfXD/7Z3QRcRrM8ND4sz1lgy8HCPxahZFZbWSIErDsz4pqCrD80htOqyJldd4bkpcmuwn15rr21QiRd/L2D0Vzouo+D1Fev6U1dketXw05/WuXKS3D71uHSrB4MgEPMXBvzZYIfS2R8XbRErIJpvqPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473969; c=relaxed/simple;
	bh=whJVFJpZ5hjKqod+I+UoQ2c7Oa8tX/YaEntD7dHnm28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulcxvS0ZQvZioMvN5gNR3OmOP+VEsj1+M7JLq54ukOApehgiLCEtX3P1qrrVYR7zJgKk2iZ6fbhEQfVLTTYtIILNMl8q+wZpLc3KljaDnclWqNqUH9zYtY8SlSGlx+MRGGxNhXQUUWGpzNQc9e53zI3ZpC9kqz8cMJrmAW26OGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdmQ/uuS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdmQ/uuS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f6a47d617so21300425ad.2;
        Thu, 13 Feb 2025 11:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739473967; x=1740078767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CyrOUZ4c/O4Rk2lNeVeCefXD2FpT/45K2UAlRvlIaN4=;
        b=bdmQ/uuSjzZvweMCseehgeXv139HgWQ2h68ENGzfDjAhN7txz6QaQNKQp0UzENSJHC
         AeUu4/zCGst5xHuWT2IKXYnMEI7NJTcl7KL54op5kbG9gp7aAsJLi71NK55PRNpPZly0
         mmpOwQmV9+F2ScktIeF7nJDhwoxFXYqS/EJDjyVLGM4S15kCqRHzCvx1WfUB38uwEdCH
         iVmG0j7nldJv8kNu7kQFdnFDxIdL3VW8UZ6Kc0w8YQWORw26FBuzpkNClEzjL8VcNeN8
         Mo0KlKy9B1AWucsD0SqNuvHm8C/J/186l+Bqt2GyVG63ZbEg0MIK5RzGrTSQ8iG1UMG8
         VchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739473967; x=1740078767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CyrOUZ4c/O4Rk2lNeVeCefXD2FpT/45K2UAlRvlIaN4=;
        b=xLuLkMLfpb7fMBI8wpyen7UEe0wsOXgsZrX6bl/YO6YcZdsSoCs025L3zsJ0gjrI6I
         863L++ijJNe/V1c7Ku/aM82VbigErXdnN8REHPi8NjuC7ezpYfm09WRyohhLKDmpn+en
         MXnmSlBt/S7EZ3cfr8W9EKwxi9Cfv39nlFKaYsueExWP7xbAvkZyjuEUxS2OubIWyT+5
         sFDlqd3kc2j7pTOO5wMZwV+CJ3sa3Bnv+OInmsp+Bf1W2RDU/kl13UKBnSyji4Ub3p0v
         WywQ9G8j7F3Ma3zvpY+DNcSOGN0GcQOJ/N1W6Bblut3TMMNbgMCVVJa5xw+C6VFCLQT6
         KKng==
X-Forwarded-Encrypted: i=1; AJvYcCUeHN79V6AEu7yxAuKUN1jzU0IheNJjXAaHY3opyUYk5TzwIyurkxQxU8B6SPI4OS2+1KRSsl95Merbwoivtl8g3/+m@vger.kernel.org, AJvYcCVwNYCEFkUdsro5FSQ7zWE7mdK/wGeq0CPxv7U9O2TOtwcQiBn4cagRqGNFjuIo5JvPWJiusl+amXU=@vger.kernel.org, AJvYcCW66b9oOFmv2qclNap2ci6LfBX6y5MwciUq/j5H+3v1e5JvwA9hpOyksyA9aVkmwyDV9zTznrAULpEt4Y6A@vger.kernel.org
X-Gm-Message-State: AOJu0YwtlBGH1iaisF2ZB6qhLxgjOAC2aNgV6nM3mRNovNW6450weS7b
	7ONKqOOdFUH8Lb8eB0QZTavH9x75HO+GQ9TF/Q+vbPL1+XAPfY1L
X-Gm-Gg: ASbGncsHMHpsdKMwDSgI8pjyoEnKVspV3gEdQ/ihpkPiAL4QiIuE1vZmw1XeSUX39cP
	oIy9DG9Xo2wNPN1bYzEN1quMjBlfc9HKTBtfRba4ZgtsV1BwROvzOXIpfYQR+lsw065g5lZeO8S
	4bsv7ID1OWoPr6Ma+SXadTneodq7kvJdko0/NHHQ6kCQnwFkVUsuIT4OIXrJqpiR5MQffyuvlUn
	wPaAwg/QfghIL25pycYxUOc0UqfZ3byiNzgH5k/ZpALqjU2JPt1tACUNa1DZa0Hbkphx6kduZO7
	u9gLJV8azJKnQpkdyRdTLWDtPMn1qQyPeRqUjYMJq9T+dZ6uMacJc1HcdQyipg==
X-Google-Smtp-Source: AGHT+IHFRukuPnsM1+aB0U8OHPzTcRhhSW++4oxsMgoBPq9AHW/FUPktX2NqfA3m+ZacWs4Le13y9Q==
X-Received: by 2002:a17:902:e848:b0:21f:14e3:165d with SMTP id d9443c01a7336-220bbca9c47mr162275775ad.44.1739473967277;
        Thu, 13 Feb 2025 11:12:47 -0800 (PST)
Received: from ?IPV6:2409:40c0:2e:ea4:cc2e:af72:ec63:143a? ([2409:40c0:2e:ea4:cc2e:af72:ec63:143a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d111sm15550855ad.169.2025.02.13.11.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:12:46 -0800 (PST)
Message-ID: <7dc0e44c-32ae-402c-a89e-aa0824770bcd@gmail.com>
Date: Fri, 14 Feb 2025 00:42:39 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: trace: Refactor index documentation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250206141453.139613-1-purvayeshi550@gmail.com>
 <20250210174556.70fc53b7@gandalf.local.home>
 <1906f93a-dc32-4dbe-9b11-eabd4aad196e@gmail.com>
 <20250213114721.23d07909@gandalf.local.home>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250213114721.23d07909@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/02/25 22:17, Steven Rostedt wrote:
> On Thu, 13 Feb 2025 17:26:21 +0530
> Purva Yeshi <purvayeshi550@gmail.com> wrote:
> 
>>>> +Tracing in the Linux kernel is a powerful mechanism that allows
>>>> +developers and system administrators to analyze and debug system
>>>> +behavior. This guide provides documentation on various tracing
>>>> +frameworks and tools available in the Linux kernel.
>>>> +
>>>> +Introduction to Tracing
>>>> +-----------------------
>>>> +
>>>> +This section provides an overview of Linux tracing mechanisms
>>>> +and debugging approaches.
>>>>    
>>>>    .. toctree::
>>>> -   :maxdepth: 2
>>>> +   :maxdepth: 1
>>>
>>> I don't really know what the maxdepth gives here, but there was no mention
>>> in the change log why it had to be converted from 2 to 1.
>>>    
>>
>> I changed :maxdepth: from 2 to 1 to simplify the table of contents,
>> keeping only document titles instead of also including second-level
>> section headings. The intent was to improve readability and navigation.
>>
>> Additionally, I referred to commit '270beb5b2aae', as suggested by
>> Jonathan Corbet in the v1 patch, to align the documentation structure
>> accordingly.
>>
>> I'll update the commit message in the next revision to explicitly
>> mention this change.
>>
> 
> Can you make that a separate patch. A commit should do only one thing and
> that change isn't necessary to be part of the rest of the changes.

Okay, I’ll separate this change into a new patch.

> 
>>>>    
>>>> -   ftrace-design
>>>> +   debugging
>>>> +   tracepoints
>>>>       tracepoint-analysis
>>>> +
> 
>>>> +
>>>> +Hardware and Performance Tracing
>>>> +--------------------------------
>>>> +
>>>> +This section covers tracing features that monitor hardware
>>>> +interactions and system performance.
>>>> +
>>>> +.. toctree::
>>>> +   :maxdepth: 1
>>>> +
>>>>       intel_th
>>>    
>>>>       ring-buffer-design
>>>
>>> The ring-buffer-design should be in "Core Tracing Frameworks".
>>>    
>>
>> I'll move 'ring-buffer-design' to the Core Tracing Frameworks section.
>>
>>>>       ring-buffer-map
>>>
>>> This describes how to map the ring buffer in user space. Maybe it should go
>>> at the "Introduction" section?
>>>
>>>    
>>
>> For ring-buffer-map, placing it in the Introduction section could
>> provide early context, but since it is more implementation-specific, it
>> might fit better under Core Tracing Frameworks alongside
>> ring-buffer-design. Would that placement works?
> 
> 
> But it's not kernel implementation. It describes how to use it in user
> space. That is, it's not part of the tracing framework.
> 
> -- Steve

Thanks for the clarification. I’ll move it to the Introduction section 
in the next revision.
