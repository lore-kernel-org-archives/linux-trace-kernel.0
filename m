Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05320B7ED;
	Tue, 18 Mar 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297748; cv=none; b=BTI7j/42oF5NDkifalMWIdPs7oonYWVKyARgMCvpOuwFeDz+wS+vK3ERyWpTi73fmBwlrYx+zWzkbH4wMKOHpEdG9o0+g/ArIXWc2BDO9OXG6N1dcmLAaSBuhRFT+MiGH39fok0etdPnWSO3kL92jn2kbESRK+3BlhU/Uzlgh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297748; c=relaxed/simple;
	bh=Oo5Rb8+Ng9GPmuJ70nHR1J7BG8YZnuFUuDLGpMRu5Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1wsjQKuIWYnz+yEHK087PpkHb9+KJe3H0lWZZ2vlkxWmx76QNWteTmE02oVy5QAcWQei5LBhWtiJ4iy4WjzZjpnO64EZd+iy1CNuXSGxps9Lfy6ntp7LRW56UuVpox/gEm1eyqVs5YxrhQwL+M1zF4P+vqL5JPo7O44VqzN9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX0YmYwN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX0YmYwN"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff80290debso4704597a91.3;
        Tue, 18 Mar 2025 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742297747; x=1742902547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lt93u+3xE/W+Cmzf7bmN03zxBQ/l7okUOSYfUSihUhQ=;
        b=iX0YmYwN1WU7Vkj9ZpNTNxx0gEp6c4IMHldeyCJFC6RiUM3POYaLBlWnRHJ/mPuXvd
         Crt3Ba1DB/Qg08l700PtUuhsIqEkLsaMv1O1MYG99n5nL7QHiPbaW3y5njeGaNK4/+za
         P/npgveTgPStStEwMXV309fG/5mxspGMfZPCmfd8Uywr7qwAl+B2d6SIKg96Czqx1jQM
         /rLGPMtm3cXdyz15HvBflqxpCtwMmabBuEol6FoEstzK3aDJaeDmh8CFM8cijgRHnuPZ
         A9QSC9qCAi4Zf4415lFg0eQa26UOilJh87UqvtMXJq0rzMOflC0boLsZ2cFBO7wSG1dU
         0ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742297747; x=1742902547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lt93u+3xE/W+Cmzf7bmN03zxBQ/l7okUOSYfUSihUhQ=;
        b=vdE7ey0jg2dPzcyQrDmfWttXq10GbaP1KawI045S5i5uRhKkvDRHMz4gqoOxL/iDfz
         dd0nazbhlHy2KNkT5Uin4pRP0j3I/2o4UzE1nlhW+rh6Rn68lnB5dX+L2TCi9CnhGgdM
         I7DIaz4Hxit4SMomlfEliHsWq09vYuDeWB8iQKpQn/a5c7DVbDKB1igxrI7+lIPNYf43
         KRIe6ZqfoPQ+pDTLFlBhe8yne085h8B9tJXzvFud3OJWIiYQsJuUXFeiw9x/5XgwDP98
         UnOrM4OgIGInq9nQcLWGyuq0BnggXbmo61iayn0r/7DD+N5Ylnr3O1SEczABC5GINTmK
         +WiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD07Iu0w58mITKlNYUfo1V/vrS06+GBVixJg1Y00xSpR27gopXW/srrD3Gp+7Z6Pnu3ILzm4TApZ3AMyZtjPHT3Guc@vger.kernel.org, AJvYcCVsQqvNLOmt0+CX4V8tO5nGETEftWhtLlJpFGizziOf9n+ekPiGuAIxqZPX+sTVkBuM5gR8IQXLMeu1BGDv@vger.kernel.org, AJvYcCWQRIGCm3Yje/biRNlAdAcntJ6cgdeFLHHnwO04OBK8Kde/ThZhqKHQHEUPkPu3GhnR7yqwI/A6lLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzh4v6RCObbTrn2hJszO+O2ImKylBRFSK6ZdHXogjCGwfF5uR
	4wOHPwX2Sa/ZuMa0nihByJe5Pf6ULkNA2yyQ+kTC2wyWa/tGti7A
X-Gm-Gg: ASbGncuaPzOIrtvanXEB2a9FO1NxgR0s3mhX6lhcF8FNwqqxRXVBMBs5mynLt7WNomo
	sW086GlIPvPA33MKBFJ4OIsj2UBMW3MnifuIBjOx2kMv3Wo8ieF5q5Od+H9V+fUP0T8LXhA7DU7
	NPLKxzitDYS/3w14zaWqs7dUs3kIOW9UQpIgm4RfRkwMNLGv3chq64iuoc6hgoenRd2BEzDaPzj
	wBEo9cQPd+vbYfk1r3xOI9kEGuoMXMQvIgtIF8MYCQDAp9u8fdzETJAGEIo2bOajzOXN+FjakzU
	w6mTDUbjwkGcPOMMKvecLjZJtrfvnCd/+kRdc35gBae7SFstA42O4A==
X-Google-Smtp-Source: AGHT+IFVaY96rQ1MIKrGux34tD4f7j0/KybkBdC4jQu1kYtIggPHmETgmVeeIdlXlbNhYJBdy9z39A==
X-Received: by 2002:a17:90b:3d06:b0:2ff:7cb8:6eca with SMTP id 98e67ed59e1d1-301a5b8a043mr3242659a91.24.1742297746631;
        Tue, 18 Mar 2025 04:35:46 -0700 (PDT)
Received: from [192.168.0.125] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015364ebe0sm7910944a91.43.2025.03.18.04.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 04:35:46 -0700 (PDT)
Message-ID: <23f1706f-e12e-4a4a-9919-6e654df8cc31@gmail.com>
Date: Tue, 18 Mar 2025 17:05:39 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index
 documentation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250312124717.7208-1-purvayeshi550@gmail.com>
 <20250312134907.06d27d78@batman.local.home> <Z9JKqVvG1iw0bFXR@archie.me>
 <20250313070457.647c8c57@batman.local.home>
 <4cc0a072-3eaf-4fbf-a334-012aacf9039f@gmail.com>
 <b1882a1f-3ed0-4307-8a34-3236bdfb79a6@gmail.com>
 <20250314084155.20c3e662@batman.local.home>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250314084155.20c3e662@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/25 18:11, Steven Rostedt wrote:
> On Fri, 14 Mar 2025 14:26:37 +0530
> Purva Yeshi <purvayeshi550@gmail.com> wrote:
> 
>> Thanks for the reference. I will keep this in mind for future patch
>> series and include a cover letter.
> 
> Note, a cover letter isn't really necessary here. Why? because these
> are pretty much two agnostic patches. One fixes the maxdepth, the other
> is changing the layout for readability.
> 
> Cover letters are best when there's a bigger picture being had. That
> is, the patch series is set out to accomplish a single goal that is
> broken up into little steps. A cover letter explains what the goal is
> and why and how. Each patch after that explains what that patch is
> doing (why and how), but from the focus of that particular change.
> 
> As these patches could theoretically be sent as two separate patches
> and not as a series as they don't really share the same goal, a cover
> letter's only purpose here would be to make the email thread look a 
> little nicer ;-)  But that's about it.
> 
> -- Steve

Got it! Thanks for the clarification Steve.

Best Regards,
Purva Yeshi
