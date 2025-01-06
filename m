Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C56C145A03
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jan 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179190; cv=none; b=lBTMrTwlISmcmyvqvCbnBxJt7PDyPHqiATikDEEXtRXLDJNKTEw3DL2JmPsoXuCBToHrsgaHBuuAvGdOB7HcAsgIZtdeBVcigXZzVxKfxj2m3QW7EC53pD4+d+ZBOnWxtCM5SA1BnV+TBabBTtziAewpKx2LM8PR6EiA/NhzEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179190; c=relaxed/simple;
	bh=6gnDGMIOxppdGHB/yf8LoNP9GKGmL4ydJ7hG20q8fZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vB5xVEEdwRQXKSIwJnf5IIWBd+p03d8VKzfj5w592QD16inOo9JDitIw34XVe5T2vLuxEm/rubhADWVvX0MoTiC7BHWjcgkExrR+qB4f3EN7/hdfwAo89+LtzmMSYFP4CrMM+3K6b2Q2cBV5fVeX7dUXtmyQbraEZP4Z04OK4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EtwJuadq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtwJuadq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436345cc17bso105364505e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jan 2025 07:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736179187; x=1736783987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cL83fy9fUiyWAQO9Y10o5TV/KydC3Qa+Hru6k+93+SU=;
        b=EtwJuadquAmIwoOQBgAyqg6C4/KcuTxVUKV0MVvos3gZawxL8Ao2LnTu4BJh2viBLQ
         yTMDQh/fR1MtAJGQhtzEwfOHe+bKpVqgRf0PoekBrJwVpNUHmZgYwSQ9019qB6rVVO1b
         qRjD4LKCvCvjjDXJA/dFywIySAl4Ettp3X/L4Cyrmz0gJ55mDUeZjJnb6rj9oHkj1Vtl
         o8NoUWgIwmqaPeIdVM/GUClMzBu45BEO8MBSPwgL2c1V7gcCpAx00Htxro5auZ2HBYs3
         Zm4pr8oaT05eXu4M0jOyGe3gP6gZKXde5Drybyj8joAkk8BJAw3xajBgrgAyij1wwUQM
         1h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736179187; x=1736783987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cL83fy9fUiyWAQO9Y10o5TV/KydC3Qa+Hru6k+93+SU=;
        b=fV8+e+P91A1i+8+SQE7gpObZ7eVfjflqAxrS1iKwH2YgyUg+bcpE6bapHFoeP8gR2B
         xk26t7IuDw4hUcjhkskJ3PzlB/mjPkUiOXyU7PXg1TMsuSw/EOUm/FcOE25a47LIprU0
         sV/eupCB3AC8fR8JFhxJE88PsFZOFzdiUg9me2IXUvOhhq+eQIkdTw7xapJGGjNr4BH0
         TwB2sPESMff6TahVfHdEcg4SOP/+6TzbUBSk6NwGLqLqFvryIl+6kWC6VP3/lX/oOC2J
         PhzeSVyb+2x3PsYapsQvrwKCOkA7wMfPgyDAzPx7ebIWGTPXwgv3m627e5PWWgkXuXU3
         pHzw==
X-Forwarded-Encrypted: i=1; AJvYcCWX1fSd6z/1H+v3mW0BP6e54QPdH/B9JaldgxBn3zS74EhEZ36OHT7Nc6Jy5NB2pMtnPX4gEPk8/x23w9oOT0Cw5hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+gGmnrE7pMEUDwwmZESc0b4E1k1uQN3w4NsEASSbuz6FYbc1a
	S8K5Q1Xzi1pgc/kIibdHfWIFeGPwn7c876Qe1sFaxFEQzO28qVWGpadO5ZIag4c=
X-Gm-Gg: ASbGncvxGRz1BMC8S6kp2sfcLmViTl3giGuGn0xmYhvwTTEMPUtLrZFEb92h/wRYot9
	NywG4DJo/QY/JxIXO+NhaMqSJVVMk8A8yzPQuIv+0a0iD01r6SKABAVheQBC1X67aejDrCzqeOy
	Mtm6zIAb5ZkS0eJF8NU3aR4AyXo5ot3glFSh57RWoALn2cesEBugiC6P3JaG7KWaFk0YN65ZKkp
	W9XBxiw+PvsH6y3ICbjaNTmpdrI5o2EWp28YZxZ6J3iTLFMidULgAJcvMUDOKCiteY=
X-Google-Smtp-Source: AGHT+IFuwfTtqezqCyqXjnvoll9stdZwnDMHbjcpJGGm/Jkum+CB4+ty+n/TPU5uXnz6f5z8AKwJSA==
X-Received: by 2002:a05:600c:1d1d:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-43668b5e172mr471554025e9.22.1736179186712;
        Mon, 06 Jan 2025 07:59:46 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b14f241sm535958045e9.1.2025.01.06.07.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:59:46 -0800 (PST)
Message-ID: <57627eec-10b5-4eb0-bfe2-f404a3492eee@linaro.org>
Date: Mon, 6 Jan 2025 15:59:43 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next 2/2] perf: Return EACCESS when need perfmon
 capability
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, will@kernel.org, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 stephen.smalley.work@gmail.com, omosnace@redhat.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <20241223070650.2810747-1-luogengkun@huaweicloud.com>
 <20241223070650.2810747-3-luogengkun@huaweicloud.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241223070650.2810747-3-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/12/2024 7:06 am, Luo Gengkun wrote:
> For perf_allow_kernel and perf_allow_cpu, both return EACCES when require
> CAP_PERFMON or CAP_SYS_ADMIN permissions, so update perf_allow_tracepoint
> to keep them the same.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
>   include/linux/perf_event.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 5d2ec4283ebf..c1bc0d7a275b 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1685,7 +1685,7 @@ static inline int perf_allow_cpu(void)
>   static inline int perf_allow_tracepoint(void)
>   {
>   	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
> -		return -EPERM;
> +		return -EACCES;
>   

Is this necessary other than for consistency? If not it might be best to 
leave it inconsistent even if it's wrong. I see quite a few "if EPERM do 
this..." type things in Perf, so changing this would break error 
messages being shown to users.

If anything, EPERM seems more correct because EACCESS is more about file 
access.

Thanks
James

