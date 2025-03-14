Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5581953A9;
	Fri, 14 Mar 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942533; cv=none; b=uTUUqJwORTDt0la5RZs1ACxBsLLzWcm4BF6pdx/NWmJwePSFpJl+ZG5JJCbhHeBTakjXb7Tj9F0S44eOEz/ppM6TMSmhHeMJOU3AYTO0rEkXi2jnjN5H+Dwy0MFDdHb2Z2YzQf3N9y4nZj7CGKlvVozTuoWgZKoL9/O6RQtjyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942533; c=relaxed/simple;
	bh=eUpx6PPv6NUTNUR44/ALbykGGVYEXEgsQa3CHMneV3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBxdyZjlIHNGTB2m1e+gL0CjfTJw2PVQSZmVULBjP1cWtpXiS4uMiR8oV01F9KZi1A9fagsIT7AtBS8OegwusDHi9+YfBLD09ikjZY+UixpPQS5B0jtDhxvRu5G3xYGvtjMeysJdRkRgJK8JtyvvfJRmjHsi+MbbO3i5wFbTz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNXgSNgM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNXgSNgM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22355618fd9so37102895ad.3;
        Fri, 14 Mar 2025 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741942532; x=1742547332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iL2j1fTRrW48+4gZ+gvHRZFd3B7e5O0a++OqZvQyu8=;
        b=kNXgSNgMzySaje4eMJFQ5bgAhPkR0i3zc+6i7PmAFBczBsAeqxOZUyOEuEdvTxQngi
         q95oZwLiDyp/XovKwls80s+Uu8szc7XZU5Tn4CBEOht49UUjuhiBaIFFbeY7hY0Jffo9
         6+hq7JsALoaJyGSH3W6QAMh46wuFIHvVVQITIWG5Zzmkx9J2mTIwto7vxfSMFTeJVDKP
         PEX+pz8Hw8F14Mjn/c+zWm2PfikGZdazoN6Oe6wFHSi6NfvipcWX3C7zgCdkEJu7YEBb
         0micvu5nZaz+eolKFdw1JDWoA1YLjOFIIgIjZDrctquBJ7GpZqXq+K2hZ9CHkDsMtm+D
         gEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741942532; x=1742547332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iL2j1fTRrW48+4gZ+gvHRZFd3B7e5O0a++OqZvQyu8=;
        b=aoAx2Bnl+swb+mlg2Pxig74D2Te9K2nYsPI8AEdR583OiCCR6uiCdrFcTK0msx8CFh
         z4zxjaaqlTjqH0Bmx80ralh12Z4faw1iTxQ1NMs+jfMRujGxnQKaCvlrZo7Fn4KX6Per
         5MeTFdK8OvK7rNMez/UJnZaSWQ651xlo+cXbPyFfJ9CBB4Up+6Gce2QqGLd8qYa/OYs7
         1nJJ22YuN0+OdAB01ksT2S4c5w67jrqIewGECiWL2tT3/5OjgeUzZhwf9RThdfg14Bwi
         hhryCnO0TBF1lxNJjTeZerzrRjMNR7Yj+DZbis0cB6CJHiHm0oBuRPHj/o3mMyNiITkO
         OiEw==
X-Forwarded-Encrypted: i=1; AJvYcCV9E28lMZhEFIfZeVP1N63zy8ztIWTZTYw5Fu5nBxwHOgjwcCUc0HtWEOi7uAXcLGcswm/NcbVp8jSMjc/H@vger.kernel.org, AJvYcCVOQQABiRNlIqqzj10byTjLygx6z+OakhbyGMmHBGaNpe9GwXGbJvwPEIs9Q/dAjOp1yfXPVNYnXTo=@vger.kernel.org, AJvYcCWo2wf2UT8ybxFKNXEOoDocOvHJFbAlPu02jcBpABRsOwYEmXnRVjNTuniLmlonkL9GoZWolnT6vibuvtRB9XntdSrj@vger.kernel.org
X-Gm-Message-State: AOJu0YxaFKPluA+2xovX4SDOg/Qx2w1NQi+N8Nfon7kvB66Bdl9Pmo+q
	KEQnck2/yRn9ssB8sRvjKDnsCFBn0Qao9LULSUMGmukDCIp6Jphn
X-Gm-Gg: ASbGncuXx2tiXFKzdv6gtVMcO+o7AF4S4CmKyUyhuaf3QIUCpkLcwD3pXkD8pJv1h2Z
	jgMYlENJfoddyffVWhmq7jpcidZHhqeZIyppp4ofyRszglAWvXh3BaqJ1GrjSX5sg98QQex9uRz
	DKb+GyX4Jli0pTACqHsJ4ULteRxD+JklpvIidyGFq4cXGZnjKjLtW3SBBzXJz5FdB9UOAdHIvWF
	HIBcnp9Pp59rD3jp71eN432QjHvAIoQD/cyX0x1z5QDRRC0MBpuXgYiwEOuGBwhCrV6IphOGsAG
	F6CcRKd8ZPSGDe3sHySIIhf6J6IsgT6JWvP/IZBCKXaRvb2mFmYJWketGqpqxFq3BkKCMRKxab0
	6kOfwEV0l/jjy8rpv/SxC1B4V
X-Google-Smtp-Source: AGHT+IFZnVe3YyGRQyCS39o3yTmwtM/2BsUUU3P1VtBnahMC/I2S/5KtSeKdgJ+N92yAqjKj/JrkiQ==
X-Received: by 2002:a17:902:c949:b0:223:5945:ffd5 with SMTP id d9443c01a7336-225e0af042bmr22225235ad.32.1741942531583;
        Fri, 14 Mar 2025 01:55:31 -0700 (PDT)
Received: from ?IPV6:2409:4081:1112:2682:6150:d7c3:7955:f419? ([2409:4081:1112:2682:6150:d7c3:7955:f419])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6913sm25001395ad.142.2025.03.14.01.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 01:55:31 -0700 (PDT)
Message-ID: <8147edd6-074e-4888-a7a0-798c8d0de612@gmail.com>
Date: Fri, 14 Mar 2025 14:25:25 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index
 documentation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250312124717.7208-1-purvayeshi550@gmail.com>
 <20250312134907.06d27d78@batman.local.home>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250312134907.06d27d78@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/03/25 23:19, Steven Rostedt wrote:
> On Wed, 12 Mar 2025 18:17:17 +0530
> Purva Yeshi <purvayeshi550@gmail.com> wrote:
> 
>> Reduce :maxdepth: from 2 to 1 in index.rst to simplify the table of
>> contents, showing only top-level document titles for better readability.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   Documentation/trace/index.rst | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
>> index 6b268194f..5ddd47ee7 100644
>> --- a/Documentation/trace/index.rst
>> +++ b/Documentation/trace/index.rst
>> @@ -14,7 +14,7 @@ This section provides an overview of Linux tracing mechanisms
>>   and debugging approaches.
>>   
>>   .. toctree::
>> -   :maxdepth: 2
>> +   :maxdepth: 1
> 
> If you made this the first patch, you would only need to modify one place.
> 
> This is a patch series. If the end result is going to be maxdepth 1,
> you shouldn't add a bunch of maxdepth 2 and then in the next patch make
> them all maxdepth 1 as the only change.
> 
> Just change the one maxdepth 1 first, and then you can update the code
> with the new maxdepth of 1.
> 
> -- Steve

Hi Steven,

Got it. If I understand correctly, you’re suggesting that I reorder the 
patches so that the 'maxdepth' change happens first. That way, I won’t 
introduce maxdepth: 2 only to change it in the next patch. Does that 
sound right?

> 
> 
>>   
>>      debugging
>>      tracepoints
>> @@ -28,7 +28,7 @@ The following are the primary tracing frameworks integrated into
>>   the Linux kernel.
>>   
>>   .. toctree::
>> -   :maxdepth: 2
>> +   :maxdepth: 1
>>   
>>      ftrace
>>      ftrace-design
>> @@ -47,7 +47,7 @@ A detailed explanation of event tracing mechanisms and their
>>   applications.
>>   
>>   .. toctree::
>> -   :maxdepth: 2
>> +   :maxdepth: 1
>>   
>>      events
>>      events-kmem
>> @@ -65,7 +65,7 @@ This section covers tracing features that monitor hardware
>>   interactions and system performance.
>>   
>>   .. toctree::
>> -   :maxdepth: 2
>> +   :maxdepth: 1
>>   
>>      intel_th
>>      stm
>> @@ -85,7 +85,7 @@ These tools allow tracing user-space applications and
>>   interactions.
>>   
>>   .. toctree::
>> -   :maxdepth: 2
>> +   :maxdepth: 1
>>   
>>      user_events
>>   
> 

