Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25319B3D7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579888; cv=none; b=uLd8yVreOZk7YdvzqweTXe2iBtJV04WMssQFAlxu9zkX4a/hx0I1F+4ZRXjmxeX7OgkQ/+dCd+dpwsSIB2viNvTxX6hoNKs/BKnaryaVmdUMQ4TiWrqFW8obVoN1KNFrTJ9d5zZ/UXJZEIifSlC7KTChYPO+QK011E62u9QXFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579888; c=relaxed/simple;
	bh=i5dx0UhQ/tTF7VQwfxB7kDXoCRCqQDi/mml7CFO95Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOK4qj51MGIQ9Qx6x+gLsGbrVlNfSd7OQqcVZ9HUdTgL6aM+HD/0h01v7FHrQT97HnlIBHYb1gTgI67zP+uI+/DsPg5/jgvrmIWtYVZfZtfTOJmQgZj3akV0Lpt3XPMYOrJ+/tos9suYaAbE+rOooomX8rhC+32i8r+axAzgZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DiY/AwjH; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DiY/AwjH"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso6316155ab.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728579885; x=1729184685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUDkh/kjwV3Ai2AwiP8Kl7C0pSMOQvoqahsvYlIjyPA=;
        b=DiY/AwjH3vRMI8RIly/8DBpdIklJc4macdRuaz7zn4YVoIczvq2qSJ2bZHOinEBign
         dQD5AUcR9pOO7FMPC7vnLuPVvn0Px1iZBhrTp3Gtl/koseS7A79zSGy+l/lL/3xkK2yO
         XCuRSHMmBBjlLU/bGNozV19ei8CJoBTvwoQ+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728579885; x=1729184685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUDkh/kjwV3Ai2AwiP8Kl7C0pSMOQvoqahsvYlIjyPA=;
        b=QtS4xNe+Va2BUeqAOcMiTZGk3cIyDNpbKCw5FlH7GY4bzV3Yu41Oi32eUWCsbTa4dJ
         OBX/gRlYu/pZCz9zPeg3qeJPzB3WUSw7w3chQ496CLOdd3k0SVf8pyTAZZHAwc+lyYCo
         vi6CSq+2NI54zOxU3G41C8MbSUv5kRkusGHOlBGGqqvFDoIhiVRbVaSEiIasdhXyIW2V
         vkTYd5aL+OJ+LHjY5i5n0zLdp18TT1odkOlfGwpt+T3e0dvsrkhai8ZZXXgBvIBMijj8
         9LpY9kLrpbKSvzV6YLl35ItuX9zo++DFhZ2Wu7WxtfXH8QVWtb6abJ3w0f/1cKi4Tl8u
         14Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVyEbvT23bkPEtwLteL4sBtlxmRbvkUMNgQhl3GVdt7lbUB3evWRIsmY3CQjue9TtStZLTomiMm17IXLSUnZfCSbBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWm9tbqTe23LIZMdKNT63XMoBZfNVCXP8fn/+NrCWQ/deReH7
	9iCTnnArqpPqqPPvwvIFGIA8wiXl/4teS4yc7ShhKNammqxlZNtyff6CP2SDooY=
X-Google-Smtp-Source: AGHT+IEmIOQmx+WWs5L52kh0YJyVZPtoP5znB1H5OJDnusEZHA3cnEBsF6SLubdvdK9UJeIt/LZ+bQ==
X-Received: by 2002:a05:6e02:178d:b0:3a3:9337:4ce2 with SMTP id e9e14a558f8ab-3a397cda124mr63977615ab.2.1728579884706;
        Thu, 10 Oct 2024 10:04:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada84990sm311977173.113.2024.10.10.10.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 10:04:44 -0700 (PDT)
Message-ID: <63a7811c-c2cb-472f-bfa1-3b45bc65da10@linuxfoundation.org>
Date: Thu, 10 Oct 2024 11:04:43 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241004145618.18436d7e@gandalf.local.home>
 <20241008093314.8b263b6bd2e23c6a8345b65f@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008093314.8b263b6bd2e23c6a8345b65f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 18:33, Masami Hiramatsu (Google) wrote:
> On Fri, 4 Oct 2024 14:56:18 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> Masami reported a bug when running function graph tracing then the
>> function profiler. The following commands would cause a kernel crash:
>>
>>    # cd /sys/kernel/tracing/
>>    # echo function_graph > current_tracer
>>    # echo 1 > function_profile_enabled
>>
>> In that order. Create a test to test this two to make sure this does not
>> come back as a regression.
>>
>> Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
>>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks!
> 
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Steve, Would you like me take this one through my tree?

thanks,
-- Shuah

