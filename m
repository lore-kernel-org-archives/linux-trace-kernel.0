Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F51CAA88
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669419; cv=none; b=KUnr0fkN4sb72v/bKamV52vqdL3x9YtxRm99+tBxWzHTksus88kOM2ZVzAbvFUXJisr/eqmDv2X5Cn62XcSgFf9d7wEyftou0udLjompvCUK1nvpG8dUiyEnjqntXxhdx3LIX2tvfFJHSG7nbG2ruKFLBrNjVrnVxHZ8EZHQHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669419; c=relaxed/simple;
	bh=ET0YpMKcnEM4kXMJlil3SBGzPFm72b+kLPD1LpTlE1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuYXeERNprOrYArIYWDvAG6vykvY3huZ6uyqO2q0r4/eE43Oz9SQHF7mEjNUKVn87LsqHwpqIuG0846ivS3D5FR1KcgzQB0xjNQ5p6MzshtgNu3T/FTM7pUi84rx07gHkI7kTAyfEMxObrb1FWqnHCMfvQA/DYLsIZGiuwWHpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nkx//i1C; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nkx//i1C"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso11802395ab.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 13:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737669416; x=1738274216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/MnMokqSKu9BN0xk+SORtAOPFwZI9wvc/uRSw/lRyE=;
        b=Nkx//i1CRHstIwax0Ummp1k1/67Mkya1TyEpEwlia9vF68M00T154gHLu01xMQfjav
         9bN+vrO7ietvpZlpj4DMG4vmkrgLDZTcqC+2hO3m3LaZi6v+7LR/h5/C+1bNEyVDq/3J
         ngsaLSWI5JGqkR5MXxjaPGtYdaAqbZ39ev4RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737669416; x=1738274216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/MnMokqSKu9BN0xk+SORtAOPFwZI9wvc/uRSw/lRyE=;
        b=CTMZttCXOv+kvDPI3u8j/MQJVMNiM7WAZ9gCE69pBpWfCksiu86WeHxBZes+lUpi1O
         jV26E3GcckpUsG22XMeCxxsoFSYbIRjGVCPTUDTBc1bVC6cU3p0L1SThVD84CvGHNTPQ
         7sKXNsJN2/1ijdfBzYiGhxg+/WHaNJaW90VRz2ysfRoLE6b/uLO07HRd2Q29uuwGl94F
         Wl8uOIb8OAEU/ZYmIFXvOz7HK/fRSSpiuGNtttehw1ox9LNxq/pCv3ZVxSkbq+R2z/9k
         K/6HAaxZbRzOFPvQUR4kZ8ukgdxOZMSNlAAujDXXTRV2KtuOv13FPISr0SHEja+S3qJp
         X5ag==
X-Forwarded-Encrypted: i=1; AJvYcCWicV+P8Ox40rVANGx/4PEfcsQxqw2nEZo5sghrGjdYyEjKyPXaRSVaiZ52X7mMQ0GLilOakKm/UizLlCNHNPFSSnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEjZUszoS5bp1I+L4ViZS6rYrwc1SgiAKnVXYYT8oqL5hPArJZ
	a9gyl4fnWwOeR0iNSO/GIK5bkYvhDIq03NR5ydn9fs+Q86OyjCgzdbR2rEoV2fs=
X-Gm-Gg: ASbGncv21R4rFKTNZF9UP0DX11N+ewk1l2P4TxBqVrv34nfApdkLBIEbFNhpTMl/01f
	E/hy+tAtyweZB1bBEKusxHQ38XMCUYOKSSaUWhie3rUTnNeuV7WqyHdukRnnpF0CdurGc7H3OBm
	PkiB0kdftiZMe4A25CpFBym43JEbS9r9/hrffPl0FdaTJGqDcig4mfUaTvAJwREbNsSEDoF3cNI
	jv4HwoOXApEbGz9FI23OgjLXIlwlF80AEu9edN2p6PGTpjgL4JsIeuxmYdZrZwN0R+9Yv8kWfsw
	Fe9LuMnaHZ+0p4M=
X-Google-Smtp-Source: AGHT+IGYTAArNpdyyZwafhJ+kc2ko45bmyLxeOp/XuBVSjl25NBhXrOxRgs+f5XK9soZP6J3iUbJXA==
X-Received: by 2002:a05:6e02:160b:b0:3cf:b3ee:59e8 with SMTP id e9e14a558f8ab-3cfb3ee5b5cmr79160885ab.7.1737669416350;
        Thu, 23 Jan 2025 13:56:56 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfc74e9472sm1859335ab.55.2025.01.23.13.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 13:56:55 -0800 (PST)
Message-ID: <571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
Date: Thu, 23 Jan 2025 14:56:55 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not the
 instances
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250115191758.35b62738@gandalf.local.home>
 <20250115202607.00c6d353@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250115202607.00c6d353@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 18:26, Steven Rostedt wrote:
> On Wed, 15 Jan 2025 19:17:58 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> For the tests that have both a README attribute as well as the instance
>> flag to run the tests as an instance, the instance version will always
>> exit with UNSUPPORTED. That's because the instance directory does not
>> contain a README file. Currently, the tests check for a README file in the
>> directory that the test runs in and if there's a requirement for something
>> to be present in the README file, it will not find it, as the instance
>> directory doesn't have it.
>>
>> Have the tests check if the current directory is an instance directory,
>> and if it is, check two directories above the current directory for the
>> README file:
>>
>>    /sys/kernel/tracing/README
>>    /sys/kernel/tracing/instances/foo/../../README
> 
> This is the same patch as:
> 
>    https://lore.kernel.org/all/20250116012041.326701057@goodmis.org/
> 
> But as there are other patches that depended on it, I just added this one
> into a patch set with them. But decided not to make that patch set a v2 as
> there was no changes with this one.
> 
> Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p
> 

Do I need to do anything or is this taken care of?

thanks,
-- Shuah
