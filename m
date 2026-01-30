Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5A32FA18
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736302; cv=none; b=W7EGSD4KL0bxYAVbJQOmtB6Z7Aj2H4eLbYR+B9oC1/2d6dqyPXK70Q/tURMKcaZwVOW4cXKHU7IoQ14eFqCGfMsWsi/DZrKMTlBS8wDWA87w+bZ2zrjmU9Dqqk6zBymQQUlIsLQPaWjUEgLUQqyTHgHwQShbjGU2YYw6yu8OkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736302; c=relaxed/simple;
	bh=QPCRSENA4SFJhAH+HmqmvpZoOVaVA5wKYXLmrxDmbR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA82ursgEnkj6J1eA24XLpc1DQE3h7tGMcOHzNwBQKK/qmpPeXbi03dP7K15i8sw+EDvswufYO+FndCedBs6Y2Ly6dMBry1TMEVZfupDygt3otUvRfLHQRvtmwq+DtFaC+4wEbzOdcCVRSvo5C8X0o2Xmkd857jLCz/KgSPZEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE5sX8U9; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE5sX8U9"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1233c155a42so2736852c88.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 17:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769736300; x=1770341100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryNCiIbjOxXcd/t0kCSD2wpxWRoodaQ92ia7l5T9br8=;
        b=UE5sX8U9LI3MzdfQoGoE4Pk7IEbEt5SrNS19zUhpKD6Br/xVh9BpD/tD0vdu3fW/Ht
         t9yxpqUHJcJ1VlTleZ4IH2vH+wYLXjCHR/o84++C70wch8mkRoPlzBEezJKC+78gTV2N
         NCKCRCUaeX8JrYhH3LpBMq7agdjo9FK5MLJzY+ghSLkclQSgvXzyTwSHK4x3zZwPraOw
         g/74oCTY1xd+JDrRA9duVM3+jYF58IjmJHm/R2r8Ao2aom2tO6XQhUckVwzZ0CaFgVIn
         +djCRYGViVEcXi8Ryp0KrGbXqj8llvr1VbvEP9WsGX7p5dzNeFVYuBP55CGi3Pxs3YDa
         kn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769736300; x=1770341100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryNCiIbjOxXcd/t0kCSD2wpxWRoodaQ92ia7l5T9br8=;
        b=bMLJNMkI9232X6r40vPysjvT4Z+fwjuEogBmWGBufoTNKquLycahpgB2Ha8mg2pm1y
         7u2zsL9/+R5V5dD/qOLUjPnIeHuXjQA/iBuaycdDYDy9Jh11yhdDYZL9BUWGqQ+yzJtV
         wP/vTAYuvi3zU2CsNeK2uKdBwuZzeTBdq7Nxe6ARFpujO8PZNsLcmFqSIj7wMCLVYX8Q
         i1OIWg5vKO28FggluJjwKSclabZnb0XN3t6blcgRlaHDhgeOGZCpS8XtKgmkdO29sqjJ
         KrdQxOP5h08wTl39TBGIxdeFMuLC8MSyOM63dIFJXqZBPRwnQC/CEEArTmuxuXDHnle+
         I5tA==
X-Forwarded-Encrypted: i=1; AJvYcCUUOQJHAulJNRDgdNLvTdzi54ottU+dRYfx8Wy6d8U/vZ3f4A3NNOlEochK+lyhktEwEoIpzCD2kLycuwpa/XtEuvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzpX3BPA3tWekVpzOTMeXpNezTfBx5sMubMiA9BDMZ7bpRZB9G
	WUhKHFTEzQi+sPjAhU9ezD+C43ZMKzNhz7rKDoxu95CwVVxGnwjL6VNc
X-Gm-Gg: AZuq6aJRNvy70Bqp1+4rsRrmIhh15ans435MoYy6ABEDc57zA8xLSvLhboVGNdQ2Oxv
	4ApFJnLaEv+a383g1d8no94XMMbiI/1ulKONgNXsKa2vDC3lIp4RHiSfYLbqDQY6dDdzFZU5Sxx
	3OVqifd2o8M9SaeujWGKMWMYr+i3UW/b8Ww0ZbqyE+7+cVsWbNgStzV+F5cpTk80Tp4og0Xwbfh
	n/tv75JhUtvIklZlQVaY4DohGriDptVb2zYW71fMsEMqHAevOp7YjLFnT06pJ4YmlNlno766khl
	xrKYbgx+skKqQ/8aK3Em1/gXxWKQPsPiEnggIipzXPchb06ZDIrOZhL0XiFdxLnoAAi0ZBtFP5U
	5gHzXzX98AOYE7vTxCWi1cjjh8rAW0rRxxXpll2d+K8zMyO0JU7pdf/o/KecPCrY3D2u9O9jfU8
	AzWj2rOmhHpY8HemOX6XxfFTW4crYwUDxKImHr5yVwnbv+
X-Received: by 2002:a05:7022:b91:b0:11f:3483:bbaa with SMTP id a92af1059eb24-125c0fa0ed6mr768887c88.19.1769736300463;
        Thu, 29 Jan 2026 17:25:00 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:416e:86d1:92cd:3741? ([2620:10d:c090:500::2:15ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f789sm8300091c88.6.2026.01.29.17.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 17:25:00 -0800 (PST)
Message-ID: <d1a0f008-1834-4e9d-8c6e-6ae7cffa4c08@gmail.com>
Date: Thu, 29 Jan 2026 17:24:58 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16 to
 32
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shakeel.butt@linux.dev
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20260129063133.209874-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chen,

On 1/28/26 10:31 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The current cgroup subsystem limit of 16 is insufficient, as the number of
> subsystems has already reached this maximum. Attempting to add new
> subsystems beyond this limit results in boot failures.
> 
> This patch increases the maximum number of supported cgroup subsystems from
> 16 to 32, providing adequate headroom for future subsystem additions.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
[...]

I gave this a run with with 32 controllers enabled (16 pre-existing, 16
custom) and can confirm it works as expected.

Tested-by: JP Kobryn <inwardvessel@gmail.com>
Acked-by: JP Kobryn <inwardvessel@gmail.com>
