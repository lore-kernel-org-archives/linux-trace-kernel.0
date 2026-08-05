Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6983D6689
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Aug 2026 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961531; cv=none; b=dJil0a35TwSZxYY2C9qW4PytPDSQeabgB/j3PX2+enSJ5I5vT/u1oxhogT723XjG1TAJhPz4j54iE093xt+7aHGX3ocT2khGHf+lmmrQN3QmKCw+p3B781+oZwStadXf5DefdMVDKNMKUfBwmgt3E++hkKTicb7Z1LqYlBBMupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961531; c=relaxed/simple;
	bh=XloeEc0VC7CzKRCx+z/BAvyR2vU4IIPzzZHEOTfwaI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzwNmNCUemhwwNvwF+eb/YwRm6BWfQfnQapj9eriSeH61vwBHTWHPVAYPTN6E0YNv4vML+02Mntlcpy18mi8cXUSklx++AaFTXSjOFgIWwfz5rHGo1eDg73HSqppoFHkGLdH3plfwFcMDUehNY2Yvm71bRV90oTkoJmplHt2C+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmNTrwrV; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmNTrwrV"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6ab04bbcc8fso819015eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785961528; x=1786566328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Qc29af7044Ktsuo50pkEIXiXat2x/FckVqq57fZa/0=;
        b=fmNTrwrVnsLagfbdhDNyca5miUrit5LAWnXzw0oUTMnUf18qufxR85EZcjZPp/5mWp
         fxnSs76zaxzHptHNJkIOLfj7joBCmHqz6ITIBUc2otKE8Hs3gb8svElLFZNPEeZy/sNA
         Wl0J4wu4vGHyhQVABwAGIiyrEKmMRtj9ybu4XIFy1EuX4NXnCm6w5aXpeekwWuG2ghq1
         8xp+yPqg0Yi0MDHWDmuFPNHls6ClE1YWNeJrfeaZxovdQNW2jVCuziF9AVBEnkd47GA7
         Dwn3wWr7u8JkOUTrUlmnK7ZO5GkxiWISLmj/nIkERi8ePpkPzrs5Y1j3ZE3zUY399YyD
         RONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785961528; x=1786566328;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Qc29af7044Ktsuo50pkEIXiXat2x/FckVqq57fZa/0=;
        b=ZXmHD/VAF3Ec5spwU3tHZ0gdlHsiIYLpTFXdXWRi1mGarBjnb9yy31WCkc56aNXeoZ
         NaSpRZ1cFUmZdhbgfLLKPK2Aqk9fyi97uZVbVCpEryvoxZ5M+MHtL2D8z7bBV/YOzcoh
         dIVLfuq5XI/YXxzJAGg4BsPsbGqJz1qTNUg3670jdiWdDO9PasKEj4D6BMT+HgtX8KKB
         eN03469vLkODXTnwX9MV5hQUuQ2SGYzxqlCMY+LbNBs8Y7Y/nRKMwFk7sV0QUv2q3xsg
         J78Oy4EtjHSEd+fCXHsx3yUDvy7gPKECYAAS3CPUtKCY4xgeFhzLcaW1OEFqtPOMsw4f
         m1ug==
X-Gm-Message-State: AOJu0YwAFtDQIY2ikizQD+a/aAnJwx3VedQ1/A5KXno7Dpel1NQ57H4M
	u1N1pOBdkVVkm9uYeRqsueLa1Jsm81Bk5YCGio49MqtgNEk/XHUYBqeO
X-Gm-Gg: AR+sD1194y5Ag/hjglNPndxXNYa3Lsz/V3yoKedWUFvDfsXAM1Re9w2lUbVX2f0E9JE
	g+rhiUYYOafwbAdmiKFXXFrNzjkYL37BveSUelrFz/6MEukugzruobp86AQEfbaJHPo3DtBJHXL
	CI/WlwwLKV0cZlFmFftkjZS75bWtHQ+7Uw6rKjMC0UHH5Tm6SFc7WqipS+uHesc+g+OlK9JyWog
	Fa7yyi/Eui8mMnjdKRZVjYmouYF6o/W4I2Ye4c7cfBXc79CvvN0QQW2mt3V3nj7CY4P4gbkQNW0
	fjRa+aJf5VyvqvYdERYfPH/UvfILUoBe72Tt9jcyfP5g4iWWyPvCbNaIF87lFGRDdOb08SaxsQb
	Sqddivf6P8MYJwOFC2dgBZ5afODVsAGu/l3zLuWborhDMJoMJABnfrkTeUXG+mPFcRkjpwTVJTa
	HyHABk5GsLVh2mXSzxewO3IxKBVdsBbcs9wPi0QK498WiQwbMrVoiVf1VSnr0jm7LAxinJnXwJ1
	urX876KircDXpWpmjLMTjnrj7Hs+oFqvdTJ74IpQE9qnw==
X-Received: by 2002:a05:6820:4ccb:b0:6a1:40ad:cfac with SMTP id 006d021491bc7-6ae96c8c786mr5192892eaf.13.1785961527561;
        Wed, 05 Aug 2026 13:25:27 -0700 (PDT)
Received: from ?IPV6:2607:fb91:ac9:d9bf:2112:37bc:94a6:a6db? ([2607:fb91:ac9:d9bf:2112:37bc:94a6:a6db])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599e24dfc5sm3683651fac.7.2026.08.05.13.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 13:25:27 -0700 (PDT)
Message-ID: <b0d9df6c-c408-4482-b221-34093c110580@gmail.com>
Date: Wed, 5 Aug 2026 13:25:35 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kprobes: Fix NULL pointer dereference in
 unregister_kretprobes()
To: Luigi Rizzo <lrizzo@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Naveen N Rao <naveen@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805161221.2428623-1-lrizzo@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20260805161221.2428623-1-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/2026 9:12 AM, Luigi Rizzo wrote:
> In unregister_kretprobes(), rps[i]->rph can be NULL e.g. when called
> after kretprobe failed registration. Under !CONFIG_KRETPROBE_ON_RETHOOK,
> the unconditional access to rps[i]->rph->rp, causes a kernel panic due
> to NULL pointer dereference.
> 
> Add a NULL check for rps[i]->rph before invoking rcu_assign_pointer().
> 
> Fixes: d839a656d0f3 ("kprobes: consistent rcu api usage for kretprobe holder")

The bug was not introduced in this commit. It goes further back to:

d741bf41d7c7 ("kprobes: Remove kretprobe hash")

> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>   kernel/kprobes.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index bfc89083daa93..5dd4786c455de 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2359,7 +2359,8 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
>   #ifdef CONFIG_KRETPROBE_ON_RETHOOK
>   		rethook_free(rps[i]->rh);
>   #else
> -		rcu_assign_pointer(rps[i]->rph->rp, NULL);
> +		if (rps[i]->rph)
> +			rcu_assign_pointer(rps[i]->rph->rp, NULL);
>   #endif
>   	}
>   

