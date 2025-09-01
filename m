Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAFA30F549;
	Mon,  1 Sep 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722232; cv=none; b=OK09ol8COH7pY2Zsujpt9L0CYZ2VmkDCK14DiPzlZDvZ94XJ47JBVGrc2T4ificwJ9jTpMoq8N99drg4yBOZXKfk74aOS8Xd1a9K7fwMNmqCJUG8TcFgSS6WfFQQvVUx3rBY+9FwDUGphk6qs1wb6pYEtAmPycO2lGnPTRqr2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722232; c=relaxed/simple;
	bh=D9pbtXHUmgdApi3HMyH5xqcX1zm+tCajPNKyodnaSP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGXOpZqCAiOBLRSti8ILraiPDBXgqvW01v9qf4Gd4XOWjnFE2CyNc+UM1jdpAJvLnMlSKUadDCvflAQCg4KCDqwCGCw263zdI4qctCsox7TBGbmQYqgUiYXgTpm76EN+6Z16p6FF7wXrpr/VJt98V3TnLw6L50tm0As2q43oOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHdPPT3+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHdPPT3+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445824dc27so37305065ad.3;
        Mon, 01 Sep 2025 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756722231; x=1757327031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ldo4EKNNqbGT+Vepx+lQSI49i4EC2FyKj4EafoocNrY=;
        b=XHdPPT3+YOGwO12vQ2/RdtEhwfRKh5ZLMhstr3S/OImlHOoqxxffAOq63rOmUAObPM
         sWhkEf9KAtdp2unXa6VOFfH4zeiQyOaI3y2gB0zln/0wAjCZkn78ZRaBJdZ31fEDNkN8
         Ssl8GgKq8VLhCjqB+HxNkVAHTMaOuXCIK/AsRr9kGa+AGtpXqrBdZ9pk7/NpmbUOspqt
         6r8DYId1mlV7GtQ9h7mkuCuRHRQpzZu1gwxqX7woaxrBo9OzGVhW8ErFb3qLRNTF1zcp
         yZQQ6M2yMWvVBwd3yrKBJrhqvLvv7W9uxpba2nYGpxxT9BnJ9bDbHdnsmDmSG98HqiKs
         5PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756722231; x=1757327031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ldo4EKNNqbGT+Vepx+lQSI49i4EC2FyKj4EafoocNrY=;
        b=HavvDZdVed/pA0Flzqzav+zNApFYxn3gSvhxfaA2WVIej8XFvX3X1i3V71JUlK8bC7
         AU/o07r/eRyGNgZxXpWrFvBEDllWMRnqU9RBqHXB9H30FFLJerJ9c4BcZByBpsQ13uGO
         l0UqRCJXjjfKlhR8C0KKBCWnwvNaw95niF21A0Dk1Y+IXO8ru3bJtQpw29uqyKYroCmz
         ksYvQUiofqlWsT7UOVLmT95kRcyfEcXLLcZugDVjEXfD+/mzhvWYaYF+LwYF4kx4op4r
         0tPCcf3Lc40yhckavwHnFVQNnFXgHxVpq9DD+QZSdQ0ipJ8pwGMIqsjCfp6fp4vrqdch
         wS4w==
X-Forwarded-Encrypted: i=1; AJvYcCUiG6aanGrWsKkVmUe8gRvoBuEG4tZaq+0TnJn4ss3ZD84JJ6dHT+hl0xSEYqUV+s12JBl7Bovzmb/b/GF5GfQKZsZb@vger.kernel.org, AJvYcCWMopKKSGewfnAO8n0EVvcSE5y2xTP2vhziT5NYqpzMVSzvJgsFoRcEWJvEuvAMkEX94/zTBXwa/dpV/Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Jci625PMyxHR306+YQl3lvz/gUEn2ReiaD8YUAJ+NobkTH31
	btMra5+8+Ya0iaYwraTa04F6QimvR4w+AbD7mE+ia8bexZHUWnJQsU0HKSkz5Su8xKGEIA==
X-Gm-Gg: ASbGncvXv32KYtbBodF16eRNiu6YAKtslaTS3GRGCseVaabSCk0IDuz7DCgwTDpHtKk
	1bCnp6iyMMHHu8VjqOi5hpo9bC+vZUHAVbnqn5LmMr6LV2b9KnpmCVfeTIu1OVMHfIS8HuT/kVO
	QByayUbVs2O7ng+xPA0fe+4jMuLnq7hwyyqM6wFd9FOga6LXepiInn1uL6CC8nmWfO4BaOf3+56
	s8YOTalMeYtp+eL/019ymN9/UcVAC5xvpxQRKKjdM/W8FG7IeSwZwdrQtKEIPPSX/wIpdFDoCE2
	LKrlZy1YhRnkTrxlaBT2a3NQPArDBFieql2oitcRzqNA43XKh7evi1O4CHOI7S4WnkVjwmePA5S
	AnjZuWNHeDkTEuxXdDlShQpdudQ==
X-Google-Smtp-Source: AGHT+IFFwZhB9y+TlZG7OlVbwdnGHByUNBZiARL4xPw+3fhoQc5acmxkQW/2JBcaU/HDkzW4M82tDw==
X-Received: by 2002:a17:903:2383:b0:242:9bc5:31a0 with SMTP id d9443c01a7336-24944b15ef5mr97480325ad.56.1756722230481;
        Mon, 01 Sep 2025 03:23:50 -0700 (PDT)
Received: from [127.0.0.1] ([2a12:a305:4::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705b91sm101030495ad.12.2025.09.01.03.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 03:23:49 -0700 (PDT)
Message-ID: <284d5eef-447f-4e12-a121-3742d708c96f@gmail.com>
Date: Mon, 1 Sep 2025 18:23:44 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/13] x86/HWBP: Add arch_reinstall_hw_breakpoint()
 for atomic updates
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, naveen@kernel.org, davem@davemloft.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250901160602.e25f0107e7b0ef4af1078fb7@kernel.org>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250901160602.e25f0107e7b0ef4af1078fb7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/25 15:06, Masami Hiramatsu (Google) wrote:
> Hi Jinchao,
> 
Hi Masami,

> On Mon, 18 Aug 2025 20:26:07 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
>> Add arch_reinstall_hw_breakpoint() to enable atomic context modification
>> of hardware breakpoint parameters without deallocating and reallocating
>> the breakpoint slot.
>>
>> The existing arch_install_hw_breakpoint() allocates a new debug register
>> slot, while arch_uninstall_hw_breakpoint() deallocates it. However, some
>> use cases require modifying breakpoint parameters (address, length, type)
>> atomically without losing the allocated slot, particularly when operating
>> in atomic contexts where allocation might fail or be unavailable.
>>
>> This is particularly useful for debugging tools like kstackwatch that
>> need to dynamically update breakpoint targets in atomic contexts while
>> maintaining consistent hardware state.
>>
> 
> I'm also trying to find this interface for my wprobe. So the idea is good.
> But this looks hacky and only for x86. I think the interface should be
> more generic and do not use this arch internal function directly.
>

I agree with your point about the architectural dependency. I have been
considering this problem not only for the hardware breakpoint 
reinstallation,
but also for other related parts of the series, such as canary finding and
stack address resolving. These parts also rely on arch-specific code.


> It seems that the slot is allocated by "type", thus, if this reinstall
> hwbp without deallocate/allocate slot, it must NOT change the type.
> See __modify_bp_slot. Also, provide CONFIG_HAVE_... option for checking
> whether the architecture support that interface.
> 
Regarding the slot allocation, I would like to clarify my point. I 
believe the
event->attr.type should not be changed when reinstalling a hardware
breakpoint, as this defines the fundamental nature of the event. The type
must always be PERF_TYPE_BREAKPOINT.

The event->attr.bp_type, however, can be changed. For example, from a
HW_BREAKPOINT_W to a HW_BREAKPOINT_RW without needing to deallocate and
reallocate the slot. This is useful for future applications, even though the
current use case for KStackWatch only requires HW_BREAKPOINT_W.

By the way, I have sent an updated series.
https://lore.kernel.org/all/20250828073311.1116593-1-wangjinchao600@gmail.com/

Thank you again for your valuable review.
-- 
Best regards,
Jinchao
