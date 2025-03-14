Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439832C85;
	Fri, 14 Mar 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942606; cv=none; b=Mud96/JwgYQltWEi2rzgXtLFitLJqBsR4EaozbNup6YtTUtO5ZP6Wa34GgB0uH4Y/+S6rEQvrkE8PpLv2OaHqKHLTywdswsL2D3ezsAduSNRuKKeVVJNaVYC8G6EcoiafLfL4yvzziIH0JrhGlnVr7tV6rhJMXqmptgnif8PMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942606; c=relaxed/simple;
	bh=QLyMwjsZtXxK1jY3SWBM7wMH3m1w4+gwsm3Hy9Ser+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EInuRxdegfAEZXIV8N7hgSYO1Q3wZrPqr/GVz+oK7ApoOUWsaEOFf/fxBSFFdfpw2K6TrSS/CvgSKcNPrTj/xjLs/owuIA1jgU7hBYdtowuhT1x3exTLDyRt2x/psG/abjrtLVzEQi8tqAQTyZ+Pxuo3GT2fGjq4z+a9NXnO5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDPa7L2F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDPa7L2F"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223959039f4so39318035ad.3;
        Fri, 14 Mar 2025 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741942604; x=1742547404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftfEQdTm72xkfn+mdf+x14iHvTM0uwjPjWeDA0BK8wE=;
        b=iDPa7L2F5zl7EJr8C6dBu4qB8hE0GaoqdAm/NdX12jKZqRhxE1gYnmv6muPxvEklj4
         nVnO3wRYBL05t6Yjwh0M23wbIxJPnncS1/bQMFSrWdoTpTnKeUwrdTW++zo+OEJviFrV
         3AjILzXs3538OhDEUXjZDSmZQ7dS7NHJJNwd1uwQ/6r3gTlP7d6j7oeqPxHqJyESZFPR
         iIDMWqX3QWJKwcMyXMn7W2w0BEWHaokd8/1bba/kiC9PlxRjVfuXhHFoSAq7yO2xBY7r
         ITrmO9xz+v5Mqn511IALpXExFTVWkjdZOa2jlHcfTaeaVyD2bHKS30OQ75N0ftX/NS+H
         e4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741942604; x=1742547404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftfEQdTm72xkfn+mdf+x14iHvTM0uwjPjWeDA0BK8wE=;
        b=U+Oi9vscku8kEHrIVWQ+czZfP8G/DsdiUtb8hf3vH4k0PNAMHTM+m5gLtVVWMBlKXQ
         ZzO6/m/2I5NG9SMaphYjrbZKNnaMgPIhggIQGL+6G8h9lD7B0/UV/8fb4dPQuGl6A1nA
         DZoWRCwOlqnBxsE5X2dYq9m0w7QXkGYnXsrWDysdhW+acQeRehbJoScNpKbex+ySaHaK
         zlBwyd8xIJH7lC1GkPznoZU2YrF8yBwX3x14rJJX7nG8ZCgsE7lGIX40KoCHVbuS0gtx
         m0YUxt2zWMrYlVa52gIO5CorZMEpgyAlA0pSC7GvCPVQXX4uRv6e0rIiwrglvGYoO4yW
         WRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/xDIE8MfiV42xpqRTxRdcy2K4LkEh+AildDHVAaQE865oJPY6VlQvKbjWgxDZ3c4rrRW9kEWTrLLNL2tv@vger.kernel.org, AJvYcCW3rSwbShb43LLBx8kYaHpMdeSEKJUxbZn0TrlrjS0kPhBiqBOS70jsHcCg2PZYgDsjATXSBYW2VbGHzdEX3nJp4xy2@vger.kernel.org, AJvYcCWqR8M6lNTIycE5MTigig1dpc3IhdAQ0cJC1VlDEkuzZwzr3mg0TngzHaof2jdot25AqMbQP7qWJTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuTcviKyJD3msk9Isk96mpxA+I2Gls2WLHyQXsQYwUfEbWnnc
	yzfnfNKnZaEAI2+IBBgevA29qvboMvq9DMvoXgvaVXRsChxL82nP
X-Gm-Gg: ASbGncvJEnkzfM2TzKn5+h/BHl7+fj2yn9uB6mZfV72yRVI2/nhA01qaw1wkAdZazhn
	6SHqG8w2JDYcr6VPENPTgHBO1lx8O02JVjuhV1beKS/VG4lFUOi3y1AtI6sXVa7hmpMmB5Myeza
	zJ1UnX1gDCwr2vaMb0kPiWeq0rEYowRDhWz3DmlgimI9xVTJOUZ+ONSd29SwhAATrmoSPkG7Nm1
	G1TXkpEkQcx0re+Z72/2x+7hlyNlkwgrm0ieDZc+EMSid3w7pFogWvyqKe6UtIDMoIA9sBIXuqv
	43sXoKe9Bv5+b2nMGNgs21X/1jm4TqRLRzUdt0H51+vaIIMAzrZmqx1McSOvgP6yv3PpB4g0dq7
	h/3LQ/WFfdCvnEWUUa6kAFoLt
X-Google-Smtp-Source: AGHT+IFkHAs56yagSZOwh3L76DEzQQHRblLwhIx9gbXSDvYUUKATBY72wgulZSwXPSnQZw7/mhvIdQ==
X-Received: by 2002:a17:902:f684:b0:220:fb23:48df with SMTP id d9443c01a7336-225e0af4fa7mr25477585ad.36.1741942603891;
        Fri, 14 Mar 2025 01:56:43 -0700 (PDT)
Received: from ?IPV6:2409:4081:1112:2682:6150:d7c3:7955:f419? ([2409:4081:1112:2682:6150:d7c3:7955:f419])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a7f87sm25237265ad.81.2025.03.14.01.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 01:56:43 -0700 (PDT)
Message-ID: <b1882a1f-3ed0-4307-8a34-3236bdfb79a6@gmail.com>
Date: Fri, 14 Mar 2025 14:26:37 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index
 documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250312124717.7208-1-purvayeshi550@gmail.com>
 <20250312134907.06d27d78@batman.local.home> <Z9JKqVvG1iw0bFXR@archie.me>
 <20250313070457.647c8c57@batman.local.home>
 <4cc0a072-3eaf-4fbf-a334-012aacf9039f@gmail.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <4cc0a072-3eaf-4fbf-a334-012aacf9039f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/25 17:46, Bagas Sanjaya wrote:
> On 3/13/25 18:04, Steven Rostedt wrote:
>> On Thu, 13 Mar 2025 10:02:01 +0700
>> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>>> If you'd like to generate a patch series, you can refer to thoughtbot
>>> blogpost at [1].
>>
>> ??
>>
>> This is already a patch series.
>>
>>>
>>> And you can also add cover letter by passing --cover-letter to
>>> git-format-patch(1).
>>
>> It's simple enough it doesn't need a cover letter.
>>
> 
> I mean I'm directing my reply to Purva.
> 
> Thanks anyway.

Hi Bagas,

Thanks for the reference. I will keep this in mind for future patch 
series and include a cover letter.

> 

