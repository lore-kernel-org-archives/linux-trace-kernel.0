Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE69185954
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070865; cv=none; b=f43GNmF93ErYiPIJnddujQ0gHURp1eSPUQrF1my08NhcDsy35Kc2y6mBHXseK13b7aIJGyGKr5bdkHQaLHvBolf3mzbd5zGaVusgWDaZOBVT/pvPQH8HxXPvKSjLfPvqGQHFYyggZGRwRS2F5whvgvsgLIRG//Ey/6SjiTNCpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070865; c=relaxed/simple;
	bh=gGSZGUKeQVT4ZwzLlokUxbSN1eRYqJmr3gBNVK+rgJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qs9mx5TX0X2C9Qoxd816YtmmKJAD/+4bRICrpOgI5Lg0fXYtC7Hpd4Tplpj6ujTe0DSMDaDs6DKOR6ZVsLjObvIAy0sGhd8RTan7FnvkvK1fRIKo9AeU1bI+tP2Op5faNBsYVObX/WWR7WZFQirqmw8RsSzpj9OOto+tbSIBo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KhdS3fDi; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KhdS3fDi"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82d07f32eeaso85940839f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726070862; x=1726675662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KatlnqVDdtDHNzA3/VvJS4Anj9gvfC556sbE+09mqc=;
        b=KhdS3fDiMMLr6ieI2Ou4nUYXcnKrBA1uRtI0AiQDUBM1FVIaBfBfoTSlySlSn3DQxs
         RtqlMXTkCFX35HaxIhdYYPmWVbdMW82Rj4r30St1BlaZVcZSxBuvYcoLOJcdUO4q6cnu
         EslasYnnZrUsD+DzLGO2V2ujjgdH5oEQUu+nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070862; x=1726675662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KatlnqVDdtDHNzA3/VvJS4Anj9gvfC556sbE+09mqc=;
        b=X6jMQQalA+jcBkZ0aNol5hPpRsfj4mC8kD0CRXizUiCEPP3E4ev3qJQHplEzC424IA
         Oay+8dJsm/7/HvJWnhaJizYiObbbI61zbU7THsvWnoJ6WevzRlN+3EWudsAuOiT/94ei
         w5uH3lyzUTAbi6jPYfyCjgzhalLnGwuQKwtDNH67gHZZWA4zhg4x2us0W0WOziP8s+Pu
         IMzPc2wDhD59eSJgACR0IZeq3tbC2n18RiNzoqN9HhcxvI86Rr8CQzqbzQ1G+OjZFF3/
         7OpzZeQRIRXbyfEBvOzyFTbX/E6VZCbWKbThxRq8Cw2dSkLltjCPovIiKG3Ezd101Sjl
         YJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCUd5p/UPSCb4AlI4jzbj+vWT8daB7lowVaVF0yYujIUK6iHIWa6HlnEYq8zjaB8tL9Ngo2JlQMh/AUz4nkyy0liwlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhs8mVOCU5X+/4qW1SHwAYuJze8OXq3giIM4T2UN7aWMqg+t0m
	W69Y+frOFr6hYPmqwX1WALnoVoYuRwmvXi+tJAg31zmut58lRpoZixFy1Cfjwfo=
X-Google-Smtp-Source: AGHT+IEtx7ZNKIzeVnQ3i3tBxUubPcG6cNPINitY1trPy3JPEme5x005QR3erw4KJL1JQ4gK9UAsaw==
X-Received: by 2002:a05:6e02:1ca8:b0:39d:300f:e8fd with SMTP id e9e14a558f8ab-3a04f06c881mr206357585ab.2.1726070861691;
        Wed, 11 Sep 2024 09:07:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8da6cdsm56731173.121.2024.09.11.09.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:07:41 -0700 (PDT)
Message-ID: <2df38d7a-682e-4af5-be01-67adb6fdd5b0@linuxfoundation.org>
Date: Wed, 11 Sep 2024 10:07:40 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] ring-buffer/selftest: Handle meta-page bigger
 than the system
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-3-vdonnefort@google.com>
 <20240910124555.180428eb@gandalf.local.home>
 <bf48db12-1e97-4690-b733-bad6b2363edb@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bf48db12-1e97-4690-b733-bad6b2363edb@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 12:50, Shuah Khan wrote:
> On 9/10/24 10:45, Steven Rostedt wrote:
>>
>> Shuah,
>>
>> Can you take this through your tree?
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Yes I can take it through my tree.
> 
>>
>> -- Steve
>>
>> On Tue, 10 Sep 2024 17:23:35 +0100
>> Vincent Donnefort <vdonnefort@google.com> wrote:
>>
>>> Handle the case where the meta-page content is bigger than the system
>>> page-size. This prepares the ground for extending features covered by
>>> the meta-page.
>>>
>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>> Cc: linux-kselftest@vger.kernel.org
>>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> Vincent,
> 
> Can you please rebase these on linux-kselftest next branch and
> resend. This patch doesn't apply.
> 
> Also please fix the subject to say:
> 
> selfttests/ring-buffer

Once this is fixed:

Steve, This is yours to take due to the dependency on linux-trace/ring-buffer/for-next

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
