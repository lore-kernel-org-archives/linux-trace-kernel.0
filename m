Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FF21D3CC;
	Thu, 13 Feb 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447792; cv=none; b=oPc8pn96IV0q0eJFddqRpwvwvGLGfR32Upse1cHyoh7CjgJ+211xuuFp3tP+7fdbCEAFA5HdZ9ieQn2YMAE6z0iBrRiueE9n7eViK6yWl7739k6odsLz6QteoQ0evkc6PqRrLxW8th+60q4Ze9CA128MdC81B/DngrI9G03kzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447792; c=relaxed/simple;
	bh=ghBZb4LeXNFAxRwbZfY/PWXFl1qW/tllSEjqwf4N+Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fonz4uwJAGR1oiUqx4hdZ6IzfIL7/7oq+qQoCLCHVCGijF4P7ntJdClmPzNRt46vRF/mIen6VXzWjS5JHF0x2VHCVo3BrrzLJ+N2DbRBFq0JKTz4Mxl/W2/88ftbRAj+s9IsnTSu0fx8pSKucfHXOAeG80pSQTO0CEY0D/HVZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmOKPFu5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmOKPFu5"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f818a980cso10825645ad.3;
        Thu, 13 Feb 2025 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739447789; x=1740052589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwLhHFYExqqNuiSR4rgH/TrcT4atiQ6G03BeFgZQMC0=;
        b=TmOKPFu5J3epjxZf9jLodv3CWVfC472yJpOuxTZxCAFz2YA70RCrMUbaZmTJ/RkXfJ
         yP0v/kZ0X3E8gPPY1gv/krgYGl7xrhgnzQFZkvC0Q52V3FZ/Evo2OLaAGJFgfQ1Ypx0U
         BRKqy1k7CGNmzLUhwKCVZqtlX1P28ARFxB+eNhMcwYYCcp58zYffiKMAIsZGIGufJjwl
         hr90/ypAiiMCphSoqt/L9xo6YGJq4B9HBsby5CZRX7KUCVVtsvxz9X0hzyhCTgmwoFcA
         s/7FDvMmpZkDb8CqpPmsxMi6ykkOmGwS5p4SeN2QjrTawR3gvkTlFo3XkcBhM9eUIAzD
         q3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447789; x=1740052589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwLhHFYExqqNuiSR4rgH/TrcT4atiQ6G03BeFgZQMC0=;
        b=Cu2wuwJeWJ669gq3XpIVnnfnD3rfM10V8nig9MyV+c+Ol99xJ8Cbo7mzCHtqIeNGCo
         pqTtgxHK1cHTiEkVbXErukCP6YjVfiBDnnPMg01Xj/z1ajtiLRbnRSuriGmHJHeaRLHG
         6XlOv6OYOvCUOkRMZKq5u+cxJEPf1/dIaWPo7BtITEuDKx1uXrAK/D/vufiXwW8H0uT0
         yQ8mihBWuklOEZ3fcK7EKgiIiMpUtDYlgk4RNdunb+ijbhYJH7jUkGq1qYPlbmw3x7wk
         Hs6nbjDYcxQQOu7J8TE6LErYulm/xlBSljb3J/982c22Njiik80oFTB1cCGUw99K3cvT
         oseA==
X-Forwarded-Encrypted: i=1; AJvYcCU3jToIhTudizcllmbdjWn9bll05odj5q1XJ3iKIIbch+UMvloZ+zImBNijXakvZiJWz3r9MQuqEMM=@vger.kernel.org, AJvYcCV8cCutYK6B0cUBKNuwO3GpBY8Uz9ZwfcEXdR5ISTHTmfsqGtXxONdwByZxzLhpWv1u1zWLVLgLzbhtnhUvgVkJNNQe@vger.kernel.org, AJvYcCXZRpX7p2Uo9MMpSNxZCiCxz/8QJu13HzKW+WpvcrK+XwpJbhYdjZEkV30vV5/I6BRn1Oe3sDOoWMWQrbSh@vger.kernel.org
X-Gm-Message-State: AOJu0YwwITFN6RtDVRkXik7c0hx2sFZk+ffKjmRAimkGNCpnOjrsPVqU
	RLN5yN3lmoC4H+GOy/11uoa9IRmkeYqu2PRcgvkSLfjw5edydT9h
X-Gm-Gg: ASbGncuPlepW9sgF3JO+JZWaU7iWEQ2VzOV4ISvwiHxkIys+HT05RH1FaJQXaDNEUqK
	qm/fu1X/ODi9pO1w9UOd1817FShvsspsnGi5+VxvRbPym05BET0paJINCNdJzmclnhWh/bKXNTR
	rlKyd2DPzXyJlyROQ26aho36jtJtLcrznDM0BE1uz2G8Wa+intlhOQUgoQmQV81i+PJQuMbT9J1
	NXY2bBlw0GvsSclsxMw6Iok0vdgjvvekqJs7MIkKgffypVlVPEZfwXLnNeaN33V7yyDWk8LXgF5
	LT85g4cF2TZ9InSQzkX7m4hDUQv+CKz0CAeRH1/bFZc3D17COVUz+s+IVw0=
X-Google-Smtp-Source: AGHT+IH5EtHF6E0reonc0RlrObvvjZqnrmXCtbMq77TTjxaNrST/fPrT6LmatZzXAocrJaP51f/gVg==
X-Received: by 2002:a05:6a00:2da7:b0:730:7885:d903 with SMTP id d2e1a72fcca58-7322c3768fbmr10012244b3a.5.1739447789447;
        Thu, 13 Feb 2025 03:56:29 -0800 (PST)
Received: from ?IPV6:2409:40c0:2e:ea4:cd5f:9fc:dd5e:c44e? ([2409:40c0:2e:ea4:cd5f:9fc:dd5e:c44e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e3c3sm1136732b3a.92.2025.02.13.03.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 03:56:29 -0800 (PST)
Message-ID: <1906f93a-dc32-4dbe-9b11-eabd4aad196e@gmail.com>
Date: Thu, 13 Feb 2025 17:26:21 +0530
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
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250210174556.70fc53b7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/25 04:15, Steven Rostedt wrote:
> On Thu,  6 Feb 2025 19:44:53 +0530
> Purva Yeshi <purvayeshi550@gmail.com> wrote:
> 
> Note, subject should start with: "docs: tracing: ..." as "tracing" is the
> subsystem and not "trace". Even though the directory is "trace" the
> subsystem is "tracing".
> 

Thanks for the clarification. I'll update the subject line in the next 
version of the patch.

>> Refactored Documentation/trace/index.rst to improve clarity, structure,
>> and organization. Reformatted sections, added appropriate headings.
>>
>> Background of Patch:
>> This patch is inspired by the maintainer's suggestion on the v1 patch to
> 
> Usually it's bad form to have a patch reference itself as "Patch". The
> above could be written as:
> 
>     Background:
>     These changes were inspired by...
> 

I'll reword the commit message as suggested and resend the updated 
version shortly. I'll make sure to be more careful next time to avoid 
such mistakes.

>> bring the documentation into real order, similar to commit '270beb5b2aae'
>> from Linux 6.13, improving clarity, structure, and usability.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>> V1 - https://lore.kernel.org/all/20250204133616.27694-1-purvayeshi550@gmail.com/
>> V2 - Refined formatting and improved section organization.
>>
>>   Documentation/trace/index.rst | 86 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 75 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
>> index 2c991dc96..c4ff7e7de 100644
>> --- a/Documentation/trace/index.rst
>> +++ b/Documentation/trace/index.rst
>> @@ -1,39 +1,103 @@
>> -==========================
>> -Linux Tracing Technologies
>> -==========================
>> +================================
>> +Linux Tracing Technologies Guide
>> +================================
>> +
>> +Tracing in the Linux kernel is a powerful mechanism that allows
>> +developers and system administrators to analyze and debug system
>> +behavior. This guide provides documentation on various tracing
>> +frameworks and tools available in the Linux kernel.
>> +
>> +Introduction to Tracing
>> +-----------------------
>> +
>> +This section provides an overview of Linux tracing mechanisms
>> +and debugging approaches.
>>   
>>   .. toctree::
>> -   :maxdepth: 2
>> +   :maxdepth: 1
> 
> I don't really know what the maxdepth gives here, but there was no mention
> in the change log why it had to be converted from 2 to 1.
> 

I changed :maxdepth: from 2 to 1 to simplify the table of contents, 
keeping only document titles instead of also including second-level 
section headings. The intent was to improve readability and navigation.

Additionally, I referred to commit '270beb5b2aae', as suggested by 
Jonathan Corbet in the v1 patch, to align the documentation structure 
accordingly.

I'll update the commit message in the next revision to explicitly 
mention this change.

>>   
>> -   ftrace-design
>> +   debugging
>> +   tracepoints
>>      tracepoint-analysis
>> +
>> +Core Tracing Frameworks
>> +-----------------------
>> +
>> +The following are the primary tracing frameworks integrated into
>> +the Linux kernel.
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>>      ftrace
>> +   ftrace-design
>>      ftrace-uses
>> -   fprobe
>>      kprobes
>>      kprobetrace
>>      uprobetracer
>>      fprobetrace
>> -   tracepoints
>> +   fprobe
>> +
>> +Event Tracing and Analysis
>> +--------------------------
>> +
>> +A detailed explanation of event tracing mechanisms and their
>> +applications.
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>>      events
>>      events-kmem
>>      events-power
>>      events-nmi
>>      events-msr
>> -   mmiotrace
>> +   boottime-trace
>>      histogram
>>      histogram-design
>> -   boottime-trace
>> -   debugging
> 
> 
>>      hwlat_detector
>>      osnoise-tracer
>>      timerlat-tracer
> 
> The above 3 probably should be in the hardware interactions section below.
> 

Okay, I'll move hwlat_detector, osnoise-tracer, and timerlat-tracer to 
the Hardware Tracing section in the next version of the patch.

>> +
>> +Hardware and Performance Tracing
>> +--------------------------------
>> +
>> +This section covers tracing features that monitor hardware
>> +interactions and system performance.
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>>      intel_th
> 
>>      ring-buffer-design
> 
> The ring-buffer-design should be in "Core Tracing Frameworks".
> 

I'll move 'ring-buffer-design' to the Core Tracing Frameworks section.

>>      ring-buffer-map
> 
> This describes how to map the ring buffer in user space. Maybe it should go
> at the "Introduction" section?
> 
> 

For ring-buffer-map, placing it in the Introduction section could 
provide early context, but since it is more implementation-specific, it 
might fit better under Core Tracing Frameworks alongside 
ring-buffer-design. Would that placement works?

>>      stm
>>      sys-t
>>      coresight/index
>> -   user_events
>>      rv/index
>>      hisi-ptt
>> +
>> +User-space Tracing
>> +------------------
>> +
>> +These tools allow tracing user-space applications and
>> +interactions.
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>> +   user_events
> 
>> +   mmiotrace
> 
> mmiotrace traces events between hardware and the drivers. Perhaps this
> should go up into the Hardware and Performance tracing.
> 

Okay, since 'mmiotrace' primarily traces MMIO interactions between 
hardware and drivers, it makes more sense under Hardware and Performance 
Tracing. I'll move it there in the next revision.

>> +
>> +Additional Resources
>> +--------------------
>> +
>> +For more details, refer to the respective documentation of each
>> +tracing tool and framework.
>> +
>> +.. only:: subproject and html
>> +
>> +   Indices
>> +   =======
>> +
>> +   * :ref:`genindex`
>> \ No newline at end of file
> 
> 
> Thanks,
> 
> -- Steve

Thanks for the suggestions. I'll incorporate these changes in the next 
revision.

Best regards,
Purva Yeshi

