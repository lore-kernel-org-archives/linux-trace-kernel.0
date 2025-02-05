Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2D195;
	Wed,  5 Feb 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762286; cv=none; b=Iu6m3i0UJ76cndFQtxArlPArJyf3JLXx2y/H6MUW6MySrNPvO5ThqbObXQhVIYEYuVLIgNllCkd/aMJ49rAs7mbb00cVorM0PxZsLZco1LgR1vJdEnmrX0wOtRR9yXTVFNIIYtpp1yPgORZlcVkVr+u1Z8eGjVb9L6Q0EiNnL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762286; c=relaxed/simple;
	bh=PAljcVzx8/+pDzLyTm0A1TgyYBbspSeIRvqJcAn2DFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud5w5ZrHtUDqYXqJPB2dwDbjNLPMEH4pHzqY7/JyfDOdcAmnq++cWIzil4llaglkIPJXOWMa8Miv351a2CKbYLjrPtqCMrJOUiR/KKhcMFyRMOZQ17nzZ9BGOTnCBxzOEpO4W7Wom27tBAhnjwbYLbDnrzbZRx/wkK39wg0Caek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUwk9/g5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUwk9/g5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f200014f1so5883195ad.2;
        Wed, 05 Feb 2025 05:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762284; x=1739367084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zA2t7oNikSSHmfgs1NiNV/HZL4pGrhABLa5TnRYPbT0=;
        b=CUwk9/g5J2ixZc9OJf8oz/4tcQBErzGk8Uz2GCqGqnKFNzydH/NMa/BR8pKCUac+VI
         sX1Tr/OmRzLpSvlCyTnocA5y8DXqzwukZHMdKqdwVPhSmQ5FmmhK9cnBkRtPH1T4rSWc
         dFTkmtQptOnREz5rS5AMmNEkqHZPr0xq13O9TC/pvacJbg+ICTBdhrVppDWo1d9aPn7r
         4fCrFeXt7YzHNSm8LwXJoanLRZ6fxJM5XeAijd0wxHPx69CN6139hfnFJQx2074mL8z5
         cED17muMsSoAwAIMp6NpGOeqyEcjyRQpWx2VMGQRynGeEctA0uJPz+dDYVw1WuY66XWH
         Trfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762284; x=1739367084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zA2t7oNikSSHmfgs1NiNV/HZL4pGrhABLa5TnRYPbT0=;
        b=bxMca8gPHNNT1bejjC/ar+2CBM//x7ujcLnykspC2Zu8gO2yb/qiNJi58OhcLQFbK/
         DuWqwA5AMt2mJOeqRBrTP7nab+ictYpTDe7Mf7eTOZjQBBBS0UQe7CXoxIx5I0a0kqHV
         M3BTqkcDeCC2Pr6m4y7zJnCG7jPs2WsGAV1o6Fg+dLXDoTnTVYqWgd7YmZh4Owh5mBUy
         gFBFptpBP6iutWGNHF7HNTcKN2EDfqQ8/djQGtFdkEqAhdIBqwcMId9i87nrn6F6VLpE
         xM29Y27SJmQwQeOjbcAuQRREXpjzbYurHBk5mXhUKhYFKYckoZhduuZfJ6NHoj6bHSj8
         ROKg==
X-Forwarded-Encrypted: i=1; AJvYcCViL5YVCq83PCVKysApiv5+jJH7SXaMDHQLvSsj1A1cS/5Pk2q/CV9a1nLAJS6nGWWcfFzjFNY5Kg2oLNrqpYM2C9LB@vger.kernel.org, AJvYcCWDbaGcc6Hs52jW41yaPLlfjLKziVRo9aRgBsP+LFFfF/kOMwyxKEHyrSGM7Y3Ady5Sm8pyRACHp7k=@vger.kernel.org, AJvYcCWrwIr27mbmQMDlH4st5MumCPjnzdQ2/7vBLpvZhjvqQ2oyBCCpAa0HPWlglXeWPdAFAwhdFw7H2coH2e8q@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1L9V5wA9otkSGRCFxgSdgOLCNFKgDvDclFuT6SQ3fDhysDQ5
	EPMu06AQK0BKAeWTgvVtn0gBsz5oDlAq5zqltdwu7Z4FAsKzfqE1
X-Gm-Gg: ASbGncsmG35ICCqsFWl1Qxam2A1alQ5fgMYtzia5DhOdmXWMvEJqmeKmXFVT/8E4suj
	cqFfljeKSiAefo7qG+i+M9UFDxsCUVuZ59T8w1z4pVmUOJsD9uC2APsxFtl5uE/+JNY5JjMZ82T
	YXTM8BJGFEqkd7ZSX2KgCEgN5qToehSkZa0Eb1u4fFFhCBALzLikvr3XMb3bNWcC7GxxbhUTHWg
	txAtj3VU3BAcabjFDZtbA+A+VybE19mzl3m0cWdRQ1/hcUVrxHSk+pqZbDy04AHCHq4OmGXpwZj
	Obnheqsp/p3KXNptYSABzhUTJAF29/YGom9EIdxy4HVBI35k0rfiuSWwWOx2vZt2Zvllgg==
X-Google-Smtp-Source: AGHT+IEk4cw5QaXB6aXevacjUjmrhCCft+g+obBnIfQpmhc6h1r5EZUjgK2VSFAyJb9M8/xqYt/BcA==
X-Received: by 2002:a17:902:ec92:b0:20c:5533:36da with SMTP id d9443c01a7336-21f17ebb572mr41481735ad.42.1738762283636;
        Wed, 05 Feb 2025 05:31:23 -0800 (PST)
Received: from ?IPV6:2409:40c0:101d:c4fc:7d0c:2c80:3117:848c? ([2409:40c0:101d:c4fc:7d0c:2c80:3117:848c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3303024sm112948395ad.189.2025.02.05.05.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 05:31:23 -0800 (PST)
Message-ID: <ffe61212-1b2c-4db2-9e7b-e50748075495@gmail.com>
Date: Wed, 5 Feb 2025 19:01:15 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Move "debugging" section to the top in index.rst
To: Jonathan Corbet <corbet@lwn.net>, rostedt@goodmis.org, mhiramat@kernel.org
Cc: skhan@linuxfoundation.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250204133616.27694-1-purvayeshi550@gmail.com>
 <87bjvhhdf2.fsf@trenco.lwn.net>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <87bjvhhdf2.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/02/25 22:09, Jonathan Corbet wrote:
> Purva Yeshi <purvayeshi550@gmail.com> writes:
> 
>> Move the "debugging" entry to the top in Documentation/trace/index.rst.
>> Turn index.rst into a good starting point for people wanting to learn
>> about tracing. Make it the first document users see, as it serves as a
>> tracing tutorial
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   Documentation/trace/index.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
>> index 2c991dc96ace..f3d235c8438b 100644
>> --- a/Documentation/trace/index.rst
>> +++ b/Documentation/trace/index.rst
>> @@ -5,6 +5,7 @@ Linux Tracing Technologies
>>   .. toctree::
>>      :maxdepth: 2
>>   
>> +   debugging
>>      ftrace-design
>>      tracepoint-analysis
>>      ftrace
>> @@ -24,7 +25,6 @@ Linux Tracing Technologies
>>      histogram
>>      histogram-design
>>      boottime-trace
>> -   debugging
>>      hwlat_detector
>>      osnoise-tracer
> 
> So I totally approve of improving our index.rst files.  Without some
> occasional maintenance, they become unorganized dumping grounds, and
> Documentation/trace appears to be no exception.
> 
> This small change does not really help, though.  Could I please
> encourage you to consider bringing some real order to this page?  As an
> example, you could look at commit 270beb5b2aae from 6.13.
> 
> Thanks,
> 
> jon

Thanks for your feedback. I'll review commit 270beb5b2aae and work on a 
more comprehensive reorganization to bring better order to 
Documentation/trace/index.rst page.

I'll follow up with an updated patch soon.

Best regards,
Purva Yeshi
