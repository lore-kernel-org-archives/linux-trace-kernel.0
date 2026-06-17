Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC8316190
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781738368; cv=none; b=DF/Sn8Vv0i+nI36nPV1I8Wuju2MSP9dEyEOX3wF7VBUxZqlc0faBjPqbq1sZ3zIYpqHJAVWhZ1tx3cNHjoNbWItyjWSNOcbEXfC+rcrLcQMzeCIOSJzYO2PXBwmDtMzkk8kEs8RFquheMuzK2oLe9H0c583WHmspwU+OhEprxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781738368; c=relaxed/simple;
	bh=kjmM2f9Y4tTpSANdrgbzkRs/GfUPSsXsu6fFj7lu1Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bys3OlONRHUk56dqarNp3ros6Mbgk1KchCMG/Rjke2H7CNAhZLH4YrBgQtK2Os7e6LZIBWDUn2z/T/tvZSnBnFYEh744h/VVQfRNYwQcwFvB1mro8plQSkPXjK3jp5o5myobTuPcZoCU8mZ5agrnHh5vBxh1hZibIpStIKIOQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NWhZdEHX; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NWhZdEHX"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e709dd1ab2so140162a34.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 16:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781738365; x=1782343165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMBMjuCrro73P2KY+e0B51nJwwuq2WSOY+l9c5fER/U=;
        b=NWhZdEHXP2pPa4HY/2a5P/BLElzgETN2gIwP9bslL0sdvGc5WQP8YMgxFBGIyXlMc4
         b32u8xz/V3Y5E0zczUEY37LJ1WRO6GGgjd8DRJs4cyJirttEh53Wj0diwYtXagqoFH1q
         p4wi/PocscpYyJuMvj07yEMAKyP6PuirYH6A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781738365; x=1782343165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMBMjuCrro73P2KY+e0B51nJwwuq2WSOY+l9c5fER/U=;
        b=amHavNIm5NyZLMDQxT6f15KNbRhfHiViXK2ZWkU5lhVcsW+w1yFovqv09TzCso9f27
         e0cW8pxDMTOyRdAGYlEQ2NhjQr0SKcPQ0coN5C99gxYm7pwhsTPMjcZRSP6eUTmFCEy1
         lPChRw5OnJzHuAuYnaocA7stJFdnbJ8weKkAxacsyxJ5rw3Nz7tyTsA89snC5NuUjm14
         X0YGtIjCfyihjAvTnjSNEVy3KGwqqtCwW8FkGXhsRKipApTtpixb8v4ZaCWKo2TPHlGE
         9QbOMPenANuSLsvT3kg+hXGpQKKvwllLhYJLidsQkQPLBL8GoESqhKY/yMIuHc8TwvYv
         h7ig==
X-Forwarded-Encrypted: i=1; AFNElJ/ba6l8h1njsss8lQ4GUUFaB2H2vsLlyVBFFM/9FEelwDB25HBcapx5c1+0LOvCEN7XtdcKr9j/0zuTXjhKAiGzThM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx452MpuXWrP6yp341hNEH/tN9Hx1iy3w68YE3d9oBE0zGcVoA7
	8W7R5bYk1w8zNdP1xJlGfllxPMOkq+hsKqmD6BlIBDkuQvxABXPXM55TjZLsyuCo+sw=
X-Gm-Gg: Acq92OHEbZ9zux2IabETQaKGBHXpaQadvc3yCVmocARB4BveAsZjPR5FnOfaRtWpqmg
	GURkbetAch01/5p37cU2iP7ZtONcg4ZV2Gae7aYzW/ZzzxIkffYq0iSbZkMVFbVh0O0z/AIo2t+
	bDS7xhEsJEQ2GbSjKea5AJBHqzCg3Pj/vNWvFhtG7tTOFHaLqe2yBqv/NET4qL2U+MofMpYZv9g
	epBSNHPHncEWJLNVeEFsYld1vzDc1dzK9ju33E+WroGR8ukYrarvA7ThWLeDfYJxEwwi06k0PUS
	l84Baf9c7/ozXPgl2I5Qk++P47FdeeQnvnd6fwHQ594BNWjmDQEt1CFhevqSAYPvS5w4y29LyjI
	ttKLnyMCeoGixn53fmpCP7zqL2c5Tg9WVSJ7fqIsuJxZMOd/Ws0D4MHDjl1JA/RxeiFi4syULie
	a8mMUObPU+Lt+AU12W8ahq
X-Received: by 2002:a05:6830:916:b0:7e6:ed97:ce5a with SMTP id 46e09a7af769-7e90b2af148mr5858277a34.4.1781738365560;
        Wed, 17 Jun 2026 16:19:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6df8d6sm10146721a34.22.2026.06.17.16.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 16:19:24 -0700 (PDT)
Message-ID: <602d46d6-0ca1-4f05-8cfd-a6007aff560b@linuxfoundation.org>
Date: Wed, 17 Jun 2026 17:19:23 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/ftrace: Account for 8-byte aligned
 trace_marker_raw events
To: Steven Rostedt <rostedt@goodmis.org>, Hui Wang <hui.wang@canonical.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, pjw@kernel.org,
 linux-trace-kernel@vger.kernel.org, shuah@kernel.org, wangfushuai@baidu.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260607072431.125633-1-hui.wang@canonical.com>
 <20260607072431.125633-3-hui.wang@canonical.com>
 <20260608125049.092d4543@fedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260608125049.092d4543@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 10:50, Steven Rostedt wrote:
> On Sun,  7 Jun 2026 15:24:31 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
> 
>> trace_marker_raw.tc assumes that the raw marker payload length
>> reported in trace_pipe is the result of int((id + 3) / 4) * 4, but
>> that is not true on kernels with CONFIG_HAVE_64BIT_ALIGNED_ACCESS
>> enabled.
>>
>> With forced 8-byte alignment, the ring buffer event forces 8-byte
>> alignment. The event length is stored in array[0], the payload data
>> and id are placed in a struct raw_data_entry which is stored starting
>> at array[1]. In this case, the printed payload data length is 8*N+4
>> bytes.
>>
>> To make the testcase pass in this case, add a kconfig_enabled() helper
>> and use it to detect CONFIG_HAVE_64BIT_ALIGNED_ACCESS so
>> trace_marker_raw.tc can calculate the expected length correctly.
>>
>> Assisted-by: Copilot:gpt-5.5
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> 
> NACK
> 
> Let's not change the kernel for a broken test. Also this has already
> been fixed but appears not to be applied yet.
> 
> Shuah, can you please apply the below fix.
> 
>    https://lore.kernel.org/all/20260601023251.1916483-1-dtcccc@linux.alibaba.com/

I applied the above to linux-kselftest next - will send it up later
this week to for Linux 7.2-rc1

thanks,
-- Shuah
