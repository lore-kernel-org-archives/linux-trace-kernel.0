Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C352066E1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jan 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736496821; cv=none; b=h+FEis+gn8NvUwLWwE6dGUfcaTP2GXfXhA8LdeaGp+txPWCxL/pCCCWQO5nWA+w/E1K+5turZPT42+sif2FmyOmFQ41fJA9pn1l5A3WOtA1SPYb3f3nMI+YEmySYYnBsJRfVicwlTC7uOlFHB7JCSoPcKCPDQbJI3xlkz+gn9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736496821; c=relaxed/simple;
	bh=lLjOkjf1wXpzYZ4sT4TWPRX6MLmiW6g8LMJeKNMGu00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1V82F0mMGVlMO9FsXcsN0EX3pxzINp7eM57LbLJeBWhhh+m74WOhE85N862c2xMZNu1zz5U6FOACuxhK5H6IUg9pxtYr/uNvdfr9uFe4b3K/ZWtNtj2xfKG1vvc84lP2ttkQfpKfRFL3al2MoQKSc/OInVZzNddbA9H+nc36Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+Upftb4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+Upftb4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4368a293339so20506715e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jan 2025 00:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736496818; x=1737101618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0EV045k8CG4Yg/GfxO4KvlU6Rqe6kFmO58kVT3kSXY=;
        b=C+Upftb4+fldE5YMFoduCKTGwcGd6lGvAC4RqKSY7t7YkanJNZ30TprlPFbtYvNcQB
         mg+Wb7Hn2xbkkBUSuldr7tDWbEiKkNh8WVpsEeaILlQG46fYv9oAag8KICsMqkyaWr9e
         u+BG11MB7T43Ue9+htQZfyiiaXaM1F/M0xL7kq9jdizkOkdFnYCGr0UKAZtX3SFkUyKl
         0gYwVTyltbJt+iZEgIUe7t0P4I4yhPebGk8AT07IaFmd3jczBym2NYpmUMXc9fkxgQGA
         YtT4zizuJIaGjhw59fokeUH+cVIzQKq9tJMGadf4ZYvbHnQcpJNn9by9yZo1AE/90lRj
         KNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736496818; x=1737101618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0EV045k8CG4Yg/GfxO4KvlU6Rqe6kFmO58kVT3kSXY=;
        b=oIDVbWAj3hdT41wTr7Vd++pmCHR8d1enycsymPj2P8OXAHr+bNfZH/06rVt48+KF0u
         QY1vM1cNQqMPCVVaWasFruAQ5vNGf9ERB+Vg/NuLmzt511QuUBm+W4C2jxpA6WR7XsHX
         2EB4IS6vCmsCtEiJNeYrHwwshR50g5oO/8aK5yI7esubVS57lZ+/C3KnYA3nrJrZqR32
         DTKhY1WT91Omy1GPujP6fOqtg/syT4DtBciiK6xZ41PJxVeKyDfc8QhtECUiQp8IFpJX
         dsnK5UQ+VQS8W5GE8GuPros89xYLALKS4weyRgmsoVYNEhe7KHFzmR53PC7DPkfoTg03
         /o+w==
X-Forwarded-Encrypted: i=1; AJvYcCVDpYsGlJaZ/rDSzXu1N4tnXy6tlKRuZBpAPaRxxzbUqNq9P39nYm48MbawOE89s/gxb1ZW05Z5q/9TWIIgQ5htCJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7cxX2YblzSU5kdoqQOO2gePUyQFAILB++qneBJYpYmYQcDwv
	smKvxBI9EC8M1Us4ImmcPe3x5owxtRcVB4g7mlc0TVbqaw9b8UuKZjDBh7wyyIY=
X-Gm-Gg: ASbGncsybDpAmRwkGBdaea3gJkaV2mLnBkMk/81O0reUGZRauWrOrUBpaU8I8n5aDnp
	aXpXpKqDs5UXH4fiFp6eEP8rliZc7Yi/1HzjNSePqXa+CK+A6t41VHxxFrBnC2ju9+BaIr5ctxn
	R+1enUakFYR4seZF6N1sulY7AT/dml8uYz3VrnCHq88jlOOADqDP2nqEo1UPsPmq/lUqxxH7y3W
	vlDmNHnqY1e9NaTuslgiTdgp04os9nXngcoRCuo+k7n++W9fI9tHBjmnUMr4/k0xF6t+T+ImA1y
	MSnXLj7TvSd2pVr/HcxrSM41Aq0=
X-Google-Smtp-Source: AGHT+IFpjInhd33mWgPk1P2BS4pHVpZXIpbSheFxrXN+9gDHs3qr5/NnCurtOhyxygGxHMuzuxoe9w==
X-Received: by 2002:a05:600c:46ce:b0:436:6ddf:7a27 with SMTP id 5b1f17b1804b1-436e27072a7mr80662725e9.23.1736496818143;
        Fri, 10 Jan 2025 00:13:38 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e6249csm43923755e9.38.2025.01.10.00.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 00:13:37 -0800 (PST)
Message-ID: <d4d4c1f6-84d8-4168-991e-dbd36091d520@linaro.org>
Date: Fri, 10 Jan 2025 09:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] MIPS: ftrace: Declare ftrace_get_parent_ra_addr()
 as static
To: WangYuli <wangyuli@uniontech.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, tsbogend@alpha.franken.de
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, xzhong86@163.com, wuzhangjin@gmail.com,
 srostedt@redhat.com, linux-mips@linux-mips.org, ralf@duck.linux-mips.net,
 jeffbai@aosc.io, zhanjun@uniontech.com, guanwentao@uniontech.com,
 jiaxun.yang@flygoat.com, gregory.clement@bootlin.com, tglx@linutronix.de,
 rppt@kernel.org
References: <527F9AFF0430AB45+20250104144708.18438-1-wangyuli@uniontech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <527F9AFF0430AB45+20250104144708.18438-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/25 15:47, WangYuli wrote:
> Declare ftrace_get_parent_ra_addr() as static to suppress clang
> compiler warning that 'no previous prototype'. This function is
> not intended to be called from other parts.

Since 2009 in commit 29c5d3462f7c ("MIPS: Tracing: Add function
graph tracer support for MIPS") eh :)

> 
> Fix follow error with clang-19:
> 
> arch/mips/kernel/ftrace.c:251:15: error: no previous prototype for function 'ftrace_get_parent_ra_addr' [-Werror,-Wmissing-prototypes]
>    251 | unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
>        |               ^
> arch/mips/kernel/ftrace.c:251:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    251 | unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
>        | ^
>        | static
> 1 error generated.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>   arch/mips/kernel/ftrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

