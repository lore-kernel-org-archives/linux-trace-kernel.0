Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5044F1FCFF0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068293; cv=none; b=stueqAhueY1KDA2VhGWQiOluCFWpHKuXNnfQjHrMe/dz7bLX/1816W+FRODcN9FTuZvBp45qJyOFX21YeVD8JiGPa8yJPn4TnjJLhUjl6jniC/wpcXec1F85IUnXO9feMCkmMJ9I1S0FyoUIuvGY7pAkJEtuWT/ouL2IdG9Gngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068293; c=relaxed/simple;
	bh=/dWabNOB3H/l45GLrHuFpQul4Awb4+rHqOfNRlYWSVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tqs6x3VSe4+RyAOtRqQLV+3wgyBEVr+w4+KWCUvfHgqf9wJGYlQv+l5NjdkbfCy/z/nfMimfHrITLUXBG9NbIiVpG5RqJM2SsQiGnnfNuyrVqEres8i84VGrZWM57KPubN5DnnP4MAKx/1pIbpqIX8yLUV58iCc1kH6mnASbZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JThSDjfx; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JThSDjfx"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-855a5aa9360so77081739f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740068290; x=1740673090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgyoPRXU6a6kG4N3+disEL2MEnPtdcZMZBxF77QaXes=;
        b=JThSDjfxYNINHmAnk9NMcxlPw/YGxJiLcxuatlHW2d8cem7g3uF7+VCOvam6wXu3jN
         V1nWqwwZZf8QksaJMEYHT4Jx7sX2A5wf+CfAkNyqi70iJ/HrF/2s8q3h1cqgrVZ8y9VU
         91w+O3ObA+uUPuGF7rlYnZDga3LacDjT+RWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068290; x=1740673090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgyoPRXU6a6kG4N3+disEL2MEnPtdcZMZBxF77QaXes=;
        b=Ji2TwSe9L71TUMy5Aio7WmG1Iw+wfSl7q702AGHeRjTRDZI3+BZIhcipwDEjjf8kvW
         mWgKbn51nlQ3e6oWFFnB070NrVGyAQ5DQ50x6Y4y0b80Mm/SCutK3W11+Kzv/0LU3iuh
         wTctNR3uzi2EBz3i4gmD8rXewuHSpxkpA6hy7qMA+EQsc8cFrA1LnmuGAUcXg1+IU0v5
         4yEFcnKIRskQpaQiiPrWQ3q4r+pBYlmuvs99bsqkbDEJLZOxFSSzObVxIpFaNqqOuOqL
         NEInGcNeZW1sySZYp+PNxFHmSHTrqTGe3km7vi6KB6dtNRFe6lH6wDOHA7gfrVm3ua0n
         Igrw==
X-Forwarded-Encrypted: i=1; AJvYcCWP5QFwRyru+LG7wEArcpMapNdHEuc3AoExTCEtvXIgDOD0cQKK3O1xAdC9niIN3Hyf8duxn4dzQ23teDpYO8a/mTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6JlxxKGehdODbyswtrKN6LHV7CF4DEgDHEaLoIITKB0viJgR
	2UGkiv53eV1tYGPbexTKHTNg5G7PdQPONC1v9ZoZTUc43xj0CQfsWxRXoUm6YGE=
X-Gm-Gg: ASbGncvE+RaBDIiXVuzGSY/qS2FpyXq8CGdk8/Ho3cSjYYPnZG67RYMnO0cmNg0w6ku
	jX70pQAW8KacOWenm+BkVAZh2uaWFB0hD8ddr7o6/t2/OjiKKGGqZWh1s7PedpQiXWnwXz782xn
	HgnlWjpM87wz07sargssyNNlr7J/420S7nrYB7XWFeKa5v8hsCYz7flRV8ICa/G+Wr9FRf+A3co
	xNz2bZ4HcSPiSo1pS1m2VJKZMoF1Xm3P3Mw6vcIBX5CWbzJKomsHGNFPIzesBa+QmLKxRJIHehk
	Ovr1j1t1PlFlBjYBRZCgL+IPfw==
X-Google-Smtp-Source: AGHT+IEJ7Oc5HsTMETSfAVR01i2ff6EJ8L0D+zb08Ob/9RlyCuyRRRxFupWsQAosXlRZJP1IxnAqqQ==
X-Received: by 2002:a05:6602:6c03:b0:855:bd9c:717a with SMTP id ca18e2360f4ac-855bd9c724cmr892782639f.4.1740068290492;
        Thu, 20 Feb 2025 08:18:10 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855c0791a3esm56942139f.29.2025.02.20.08.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:18:09 -0800 (PST)
Message-ID: <3ae6c7de-fb0a-4c65-afca-c0c91289650b@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:18:09 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not the
 instances
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250115191758.35b62738@gandalf.local.home>
 <20250115202607.00c6d353@gandalf.local.home>
 <571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
 <20250123172530.474e873f@gandalf.local.home>
 <d39de60f-c87f-4c59-9226-9080f9008f3e@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d39de60f-c87f-4c59-9226-9080f9008f3e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/25 16:54, Shuah Khan wrote:
> On 1/23/25 15:25, Steven Rostedt wrote:
>> On Thu, 23 Jan 2025 14:56:55 -0700
>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>>>
>>>> Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p
>>>
>>> Do I need to do anything or is this taken care of?
>>
>> I think you can take that series. If you want I can resend with you and the
>> mailing list Cc'd.
>>
> 
> Yes please resend.
> 

Steve, did you resend the series?

thanks,
-- Shuah
