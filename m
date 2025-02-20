Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F41E2845
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082743; cv=none; b=kOuF2Y7Ty0eOrWo/+uj/zUIV+cgbj0aDwTC3N8k1m0qyagwo5O8zO2tisOUhejckGY39zqoSLmH6uwNodMjOk6zHkibYUrWbukeNk17x+rtPtVizky8w/zHgX5UiBlB4HBnOKLlHX1gV6af1OCoeMtDf63mbAYoMKro5VAqSw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082743; c=relaxed/simple;
	bh=ufNNg2rNOkDICBHFg0h+S6poNghZSgivhHBZkJrRIyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXqBRsge3IR7TFAjq+1q8ZJmq6sU3/ncfEPnnhalTL5SPRP7nUEaDCKMrIGr7sIgJ+dI0kdXBJGG1VQFlfnexVQl0aFIk9xw/Z5SAdNEZM2Rto0Vvvu7wCI2/YrrE0Tq/mOBkQolW2ipM0RyN7P+6mhMr7pPwJhJe8fClaWdetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsJ392q/; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsJ392q/"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-854a68f5afcso36099939f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740082740; x=1740687540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/Ezzc0bR8B+p/byl9E3hgmtjeFWLzb0FMiOjqIXu3M=;
        b=HsJ392q/wkvDvLQmauQAj8II+0R2/QAaYU27Crjm/FAnRmhN1cW1bI+7iMGZOgSnJz
         HDH2HupVeUndve4vs45NEbAOrLG2iRQEnYWZPwdCUWtvTaeLpZPBW8efug5CFFh29/2s
         J9mOMu2vKMts9wrnk8t1TwTk2YBAWAM7Nij9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082740; x=1740687540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/Ezzc0bR8B+p/byl9E3hgmtjeFWLzb0FMiOjqIXu3M=;
        b=Hx29ecc3o1dVNYDtkf3bImYjko4fg38EDjiVOJ05I3SDeo8/9nWg3WyEOz88LNDK9W
         F7DoUEXCWwdAOODt0hJV4G9feBhSTJLYF1hcTH02BF4EiCP/PObzYr/ecKgB2wi1Ibja
         3K3Lyy14ph/UlYXZ6KdkPFxA5YVfgGR+Qzx0TAj4y9SOblK4kiccuZapflVym1ZCK6dP
         wm8B7OtasBCnH3VzWbATpmZumKquygS0EpqhisnmmJmj4/3/fqB+ugQRvKz/+mrW/RWY
         n8NLERGJ9t8yGIedq4tCEqbGs4XA0rufXTH4K/LJaMmyJOFcGfmoYWSTsrR2tA3HONVU
         NmeA==
X-Forwarded-Encrypted: i=1; AJvYcCWTaUBc42ZtE0P5JXzteopHmofT6v+j7Dqp/5Q88EBXVVBDkADd9vcZmgJ3jHPX8dIVivOH8ibBhhyXq/BtyA/A/AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMmkeRxJt56hdPeWm7pGtWf+/OSZNr//tQ4YYwsG0fj7BvdiH
	kwLhPGZ4j1LbJfBFLjTXC9a9EVNZQeCKu/MOHvNRI6a2DrijwWmwxks2Ynsob7k=
X-Gm-Gg: ASbGncva79szxd+15pZeK9aYYnnGvATisbhw7Iseh5zHYPZftl91R0Oj8TtMvLrLggt
	7vSLXcMjbf4E/YxjUnYcs1EC3wzfQCOJQ1zVhhwDMspINmd4lopdvHlCXlaU/KzZ2c/U3BfP85M
	Z41aNmXudpkivcLHXGeHx8gzzhCgAlbKIsERrHDYf5bOR8cBHsJfguMHiIP1Ih9n8szqVPuxWCI
	sbwHtffhnpogsExKinClP1ANv6sLjYY0g60jqSx28ojfivdnCgnvszoD/UhBUH/I+ctg6a09pMc
	/woQK4sWCpux6XrOv+XtizgVaQ==
X-Google-Smtp-Source: AGHT+IF79ckeVt665lYdXJU7VJLqlE8Q15fFZXr1QkP6ouOQoPFieWVNlE/ofs7NRQPHbTbqq2wz5Q==
X-Received: by 2002:a05:6e02:378c:b0:3d0:d0d:db8e with SMTP id e9e14a558f8ab-3d2cae49deemr4900315ab.1.1740082740482;
        Thu, 20 Feb 2025 12:19:00 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea680c803sm1719151173.14.2025.02.20.12.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:18:59 -0800 (PST)
Message-ID: <16def228-662d-4db5-bb1f-7d79c4ed3ae6@linuxfoundation.org>
Date: Thu, 20 Feb 2025 13:18:59 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH 0/3] selftests/tracing: Test only toplevel README
 file not the instances
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20250220185759.811830333@goodmis.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250220185759.811830333@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 11:57, Steven Rostedt wrote:
> Allow some more tests to run in instances. There's a few tests that
> require something in README to be present to run. But currently README
> can't be used for instance tests. Fix that and then allow 4 more tests
> to run in instances.
> 
> [ RESEND to include selftest maintainers and lists:
>    original: https://lore.kernel.org/linux-trace-kernel/20250116012009.840870709@goodmis.org/ ]
> 
> 
> Steven Rostedt (3):
>        selftests/tracing: Test only toplevel README file not the instances
>        selftests/ftrace: Clean up triggers after setting them
>        selftests/tracing: Allow some more tests to run in instances
> 
> ----
>   tools/testing/selftests/ftrace/test.d/functions                   | 8 +++++++-
>   .../test.d/trigger/inter-event/trigger-action-hist-xfail.tc       | 1 +
>   .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc    | 3 +++
>   .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc    | 3 +++
>   .../selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc   | 1 +
>   5 files changed, 15 insertions(+), 1 deletion(-)

Thanks - applied for Linux 6.15-rc1

thanks,
-- Shuah
