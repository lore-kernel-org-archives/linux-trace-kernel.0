Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38485134414;
	Tue,  4 Jun 2024 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717543430; cv=none; b=SM+CTQtV6CV5FR5qOb7G50VqJNZEJQh6PvwUvC7WOFydIb0aCmoFqVZ9WzWQCeYZFSYOqBEaSNpCFo9axHEgIWdcFoLaWP9xVxHs3RdtHzvrc855k4ty5aWXMFvRckeWsIqB2PhND512jFsyesm0hm9bX/MmAKakxjlrtz9XD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717543430; c=relaxed/simple;
	bh=jtW37IPedqBng+fjiD25haPgjvd1pezodV5MYPdwaOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6tOA8Ta8R6kqMueYMJ1Twf96ucs40Q2z1eRWEVmTxTtDSP0T5rUOgde6fDpj9j4do57xYaCn4s2bZcRn+BDkYaHI7WBa5EK3Bkfh059o2HNfiPu1WsbKycvk3S/C9WgEi1HSWtoKGhPvCwc5f8wVVimgPS6os1+wG5H1Tj6QzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liLbga7j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liLbga7j"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f692d6e990so16003465ad.3;
        Tue, 04 Jun 2024 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717543428; x=1718148228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9m0oOpwKYgyRDnyieTbEk5CVDgAB0ndZuyco0J6K2w=;
        b=liLbga7j0KtQUEVgnKnWaAozDiOFsAIfbI8Mk5c86ZGPgyTYpeQUCCllHQA1feue4L
         JJpODps1FSfFqaZZbtxBdmDU20BjZxTvNPNuE/xsovtVdaKk7Ik/x27hhqNciX/eXdpG
         mLTIifdPmBC5dyb33SvpTTP7AgBl3fJR4VI568EpBwLo6Y2UqmlHERtM9QaOIEtLmnBr
         ooWX6tcSYvHmTNG3/fugTHXaZi2BcZDGauSVvwwPSAE/yKbXIA+PhXjn9xHWl3CWCfAc
         i4c9kDT0pN38QmhEH40BM1fBEvR0PrnsD+e+KjtKjdL8obYDKYPWMwTW/0NCZbtwXJiw
         0oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717543428; x=1718148228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9m0oOpwKYgyRDnyieTbEk5CVDgAB0ndZuyco0J6K2w=;
        b=GIN7jRYVpS4AscrffxV/GYi3VGVw1GvdPQXSLc8FbVIXXGEaD08NLGf66uwbsIrmgz
         7Eix/j0CYjjv1UUXnUybuWJgvzb9TwtNfOQ76WnqzNyI10jbaCKC9d9lgDCIinyTb4B3
         H3oVw7JuBnbVCyhVM3yyZs4BjU6Vq9Wozdw87tnnD0zy8a4IgvaQpXXqh6lzF2F4vZEo
         pSA8P4Vojh4wSAsNgEUDZqZrh0jmVOApb0alLLJkje3Qyv8rX4Ph8MMTO38nweI2Cd6e
         KlYfHjboAOAoCNwYLMxQftLLvlw8aE6IkY5hsXl5HSKBZ+ZgMQMviDZ0pTponT4JNeYt
         WIIA==
X-Forwarded-Encrypted: i=1; AJvYcCVb6mp5KJbwLrx+GAB8Rk+ACk1M7GNgjaUx1ldtcY7eGLnd2lYoMG/GjylcwZHch9T/a/eeUfyg8Qx2LyfeiImcKldHnnZQemxPAkizjkMwTJmqDtSTP941ez2UOmVXddyv3kG6aPTUVIiu04jhWN7t
X-Gm-Message-State: AOJu0YzsFufTd1YbONeNaWsbqDqnlSikOlHmJfx3WuBF112q+MtkCkDW
	d6qmZc3NOKGx0eouMhWj6zt2RQ3COjn7TnCqmZpB7d65bTbz6p+h
X-Google-Smtp-Source: AGHT+IGxH4HaSJY31yZN21ecpQ9TvWrPlG6nha8Zg4Ngg5C57E918Tu1wnkCrsF5RDY5lzpDJzzYKA==
X-Received: by 2002:a17:902:d918:b0:1f4:b43f:9c18 with SMTP id d9443c01a7336-1f6a5a253d7mr11014505ad.33.1717543428289;
        Tue, 04 Jun 2024 16:23:48 -0700 (PDT)
Received: from ?IPV6:2804:431:cfd3:42f5:5d7e:7952:2a52:2cb2? ([2804:431:cfd3:42f5:5d7e:7952:2a52:2cb2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232f1bbsm90116635ad.29.2024.06.04.16.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 16:23:47 -0700 (PDT)
Message-ID: <87d6a52f-27e5-4b88-8a8c-c4c58d969a18@gmail.com>
Date: Tue, 4 Jun 2024 20:23:42 -0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: adding the missing parameter descriptions of
 unregister_ftrace_direct
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240528005046.3778431-1-marilene.agarcia@gmail.com>
Content-Language: en-US
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
In-Reply-To: <20240528005046.3778431-1-marilene.agarcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/05/2024 21:50, MarileneGarcia wrote:
> Adding the description of the parameters addr and free_filters
> of the function unregister_ftrace_direct.
> 
> Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
> ---
> Hello,
> These changes fix the following compiler warnings of the function
> unregister_ftrace_direct.
> 
> The warnings happen using GCC compiler, enabling the ftrace related
> configs and using the command 'make W=1'.
> 
> kernel/trace/ftrace.c:5489: warning: Function parameter or struct member
> 'addr' not described in 'unregister_ftrace_direct'
> 
> kernel/trace/ftrace.c:5489: warning: Function parameter or struct member
> 'free_filters' not described in 'unregister_ftrace_direct'
> 
>   kernel/trace/ftrace.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 65208d3b5ed9..6062e4ce1957 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5475,6 +5475,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
>    * unregister_ftrace_direct - Remove calls to custom trampoline
>    * previously registered by register_ftrace_direct for @ops object.
>    * @ops: The address of the struct ftrace_ops object
> + * @addr: The address of the trampoline to call at @ops functions
> + * @free_filters: non zero to remove all filters for the ftrace_ops
>    *
>    * This is used to remove a direct calls to @addr from the nop locations
>    * of the functions registered in @ops (with by ftrace_set_filter_ip

Hello everyone,
Do you have any feedback to me about the patch?

Thank you,
Marilene
