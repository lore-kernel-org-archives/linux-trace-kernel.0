Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A452B9A2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070730; cv=none; b=IruN6Nhm6O/Sz7y5cEmD8KaNa3rWPjp51ArYpE7a4ob3PB4shq7J0U7pecrVhMid02j+YZLfYGXSHyftuES070uBt+qQip9w3Zw8P1Y+M/Uw/r4DX1EbKkCumPF+1niQnofIf18Zg0inhCGqExth4I22p8rN+Z1XWZqWapJMbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070730; c=relaxed/simple;
	bh=vVZnPoaE4LggcEZLAPIaQZAUImydt4yJz2th7TcSAng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNrcOKKHPTQM2AjYLDzT+UM2s4PF+SVWcD7mbKSPYQAYegph0sJzQn2zpB8ChZOchLBCRa7S/NPrbw+9T048NCe17b/2fGlSQ879rOfYqAhY/HeB2dl5szGeyQWURimLMBdOvyj/jHoGDyQL34b9C3izZ5LmHLQR8OlUFv9Tq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M6teSROF; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M6teSROF"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82a238e0a9cso316053039f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726070727; x=1726675527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5Iw9687spOPNQCPbJFKxHUyq06TwqtAPtEJ5vZKod8=;
        b=M6teSROFNydjTBzX58tX+cL6vELBY8AUooloRjYO1frbc0Yvb852U6rxJs3v1uOtjl
         4wXU/wx0bc+FITuU7fOg7TbrtXU0oLtNigAG1PeYxoDvPubS0ig9IB0CZxJePbRSUqnw
         ZrPeHdJQ6s/L1hChXNbapujx+5cZdeS8crK5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070727; x=1726675527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Iw9687spOPNQCPbJFKxHUyq06TwqtAPtEJ5vZKod8=;
        b=Hzc/+FaoQM1VVhObXR5LKANa+qT88hfzcRHt5gRa/tYheBKTCajv13+wSR+DjlNd52
         OZikF1gsU5x/dPx7E06nzGDpd7RyVZK6yZvsvCSGnYnp3EubmkGqLhOtW2rXPx45hzDy
         t+4H5RoopbNfXNbud9eA0YrZ3GgCePBat/yicSc4nwjlfORcQx0jcrUz4AeWISOLGeuq
         Y04acCvO27sfUudxPLJXvGJjZr08sJ6AmrW+4C4Ijt0m9X10Zri3ecGw+UMqSEmY1J1W
         zpuckDCxeRllC/hLii+KrbLOUkMSHxz+05tLRWY3FTEaX7+Uz/PyvB/PNDvQIn8zsmDP
         vGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU90I75Ruhh8n4XTtyblN9POWEz+dDHDiqnLXOCEgfJClsnqm3I4y71zoOBIC1jUuRimfzhu5rZqFNJCAdSKTZjZrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdC31c1JJ5BYekckTjWt7rcyXWbWdqxp3BRFGjF+kUakwQvFMc
	7Q9f1Qtn1pRz5xqpPX+XNi96AHmw1FrpLujeAblH8/K1TGjqgP1xVlWfj6Y1Ksk=
X-Google-Smtp-Source: AGHT+IGEh7vjg7kq8R20aGT4OVcirpJB3SMMzymLEMZ/gLxeZmcW+d+B8YzJGPUgnDl45eazKCfULw==
X-Received: by 2002:a05:6e02:174b:b0:39b:640e:c5fa with SMTP id e9e14a558f8ab-3a04f0ce28cmr207759325ab.19.1726070727091;
        Wed, 11 Sep 2024 09:05:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8da6e4sm54775173.124.2024.09.11.09.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:05:26 -0700 (PDT)
Message-ID: <67cac093-e50c-44d7-8cdf-16b6624765ee@linuxfoundation.org>
Date: Wed, 11 Sep 2024 10:05:25 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-2-vdonnefort@google.com>
 <20240910124541.23426cee@gandalf.local.home>
 <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>
 <ZuFMK7yndArZo4pA@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZuFMK7yndArZo4pA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 01:52, Vincent Donnefort wrote:
> On Tue, Sep 10, 2024 at 12:49:58PM -0600, Shuah Khan wrote:
>> On 9/10/24 10:45, Steven Rostedt wrote:
>>>
>>> Shuah,
>>>
>>> Can you take this through your tree?
>>>
>>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> I can take this through my tree.
>>
>>>
>>> -- Steve
>>>
>>>
>>> On Tue, 10 Sep 2024 17:23:34 +0100
>>> Vincent Donnefort <vdonnefort@google.com> wrote:
>>>
>>>> Improve the ring-buffer meta-page test coverage by checking for the
>>>> entire padding region to be 0 instead of just looking at the first 4
>>>> bytes.
>>>>
>>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>>
>> Vincent,
>>
>> Can you please rebase these on linux-kselftest next branch and
>> resend.  This patch doesn't apply.
>>
>> Also please fix the subject to say:
>>
>> selfttests/ring-buffer
> 
> Will do, but it depends linux-trace/ring-buffer/for-next which hasn't make it
> yet to linux-next.

In which case it has to go through tracing tree.

Steve, This is yours to take due to the dependency on linux-trace/ring-buffer/for-next

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

