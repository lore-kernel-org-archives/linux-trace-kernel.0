Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EBC146D6D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063618; cv=none; b=MNVx6HUpKqwhYDKDHOis8mOMKyXHTVBFsL1M+CQD+X0380eF2sWR6633y6NaT7M+GSOI36ep1NajX5g2MXOSU2C4wzo40d25D1K/3dvTL6msurASgCep7epHofZfe5fb0Lt7TGIafvthb45BEGhjQ2YsMvTOpEkqM517yGLufI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063618; c=relaxed/simple;
	bh=EdBhtzfqLSsBAVJRjdv1ckOtbFndr92/RF3/x62BOCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFP9L+HfyIV0qUYsPlHBiYLJQFdS/yzF/jyRsG3JVhW7K5G9qfQ9EhcqPZ6CojaNhsZV8U7mC8q+OPeLklijYV3M3mifJTvDbld92/gvBfHXw8IeW4ypK/KdRl300HJ3wE9nqc1Oi88gapHa3FpAc3sA2S9JE8uaxOtJajS4U0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CMqUanrO; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CMqUanrO"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39b37637977so219935ab.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723063616; x=1723668416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqgcGDUaTNp/sTXO9LQ0+BWl+Zjdb1Zqdieng1PIeM4=;
        b=CMqUanrO4/kfSRTt3dV83U1cPAbnV/CdKhmO6SLiI2+NhdZ/RoIrHoGZbsRO0v/A7u
         MZuyNN8mM86+ovQfqLoYMT/YCp6XxeF57uBtWEpBhVdJ/rd04bL+PBo5PWCvadZEWthg
         yFbF/pkHVeVCSwv4R6A08hrmIF8BZ0rsZyUPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063616; x=1723668416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqgcGDUaTNp/sTXO9LQ0+BWl+Zjdb1Zqdieng1PIeM4=;
        b=ABDfUP/bZcmCGkR/wQo1QXBkLgj5bGbDdv7o3xc9sW2Pg290Os2pvymAH26ksnH2XC
         wQSB0VV4Jv8OMtAkQAbAlNsy/a69i80pZvB6MtXyQblgYW/pyHevuYh+2NrIAH424oE0
         XRbN+r3IdXd4zX7rW2HXybVApradePQqukuji2solGPQeMGS2t9JL37zXeiIAZEhGQ5L
         BjhSb8hXm9wrt6PeItHq+rDHGB2zju1BvoVYlklyVfnftbPmF51Pr2oJciNjQ7VZ27TA
         RWZ9YGk6ecJ/Jx2iVDnHdLDivxBYTxb5kbEGNgbFBU6GEMJlEyPVI4BD8zktK9TwN88C
         PWPA==
X-Forwarded-Encrypted: i=1; AJvYcCVzkiuK59Fs3+Ii7PIalTzP7dNutfPzhDTUJiT5VLBgUNXMIpXSTuPZw7lWRWbRRgCR0TBn1Erm8SPNnvoCN/jIDB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpW575h990TlWrB0WdthSZrh8h+3arpnGt59aVheP1RlCEX6e
	nihOVRhb1nAAKb1LLdz4IsXt9beW1RhcMv2cpEn0VdR9Wya8eE0Pba6YRfA98sc=
X-Google-Smtp-Source: AGHT+IFB+Zx0494eTKzW3GVBD7MHU8uPNoAfHKFsQqBPKr+K5SAwkwE8u/oTmRkBv6+IFzrktgEChw==
X-Received: by 2002:a6b:7c4c:0:b0:81f:8f3a:5689 with SMTP id ca18e2360f4ac-81fd42bcd22mr1222964139f.0.1723063615771;
        Wed, 07 Aug 2024 13:46:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69a87b4sm3007508173.64.2024.08.07.13.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:46:55 -0700 (PDT)
Message-ID: <5cbf7f15-cea7-4f82-ae9f-62e08d1afa93@linuxfoundation.org>
Date: Wed, 7 Aug 2024 14:46:54 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/uprobes: Add a basic uprobe testcase
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 oleg@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <171651179523.161068.3164659198838770307.stgit@devnote2>
 <20240807163638.528b72a1@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807163638.528b72a1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 14:36, Steven Rostedt wrote:
> On Fri, 24 May 2024 09:49:55 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Add a basic uprobe testcase which checks whether add/remove/trace
>> operations works on /bin/sh.
>>
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah, can you take this too.

Yes.

> 
> -- Steve

Applied to linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

