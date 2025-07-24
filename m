Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4812239E77
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394039; cv=none; b=VbYaTC/FPueo+howWwnXyqLSGMhvXew2KugQAuZUHJU2QanI+ft/lMJdFfF72UctlMWIxM9PyVx8oDO9sxvnEZVfdIPd1vDlCQSmK5OUpwmt7w3pLbhFLjMYpbYYRqH5Dai0oLASwXG8Twsn9ICUBDLvoBx7ve3bOTjtCzZhD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394039; c=relaxed/simple;
	bh=cONpRMMRR0j8+5IMSCW+w3Dv5UbjFMlpzxjvfBz12sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq5qZ2a/bwsSJWPPcpXFunJJOjOujP1JpW/E5bFY24qPxY+DuGzgVK/Rsm7rhwVa7XJwA9/P2GZH68maTJiISJGXQh993datPubTZu5DH8onC9dexKQqugaAc1TTnXS9rmFff/Up2cNqsj+SbvtpT4fclhd8RmOz+x7A6bm3FXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WqAYOTFG; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqAYOTFG"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6159e23a6dbso336339eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753394037; x=1753998837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ec+I/bNfYceVzsyoj94ElkmRmpTwfXXUO1soT24vA9Y=;
        b=WqAYOTFG5W0pBbtUTx1mY5uINZDOF3UvPO27BIGeBgYRA1RzZMeHHCsX+4BGWhWnKi
         ZDTt7FYgHtI1sCw9Lwl5SfsPwRjTV16l/2vXS4FJAj/Apoy0XiJLKr4xHsTdIUJ+a8we
         wUNBYdkI0c7BOjn3NoIko9W0ws5jxZTjr6Z3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753394037; x=1753998837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec+I/bNfYceVzsyoj94ElkmRmpTwfXXUO1soT24vA9Y=;
        b=HfM6Nq5VwaxUT/BIZwSNPthocDNuqZixsHaLPena6mDfMtAx0OP82E6mRm6dFmqlS/
         +5nTqAij9J1NKJLBcdlfCKS9L6P2n5SwJn39B36sBT2Usy1jx/79qL9fRL5XbAYyeetQ
         Ps5UfJLZbiIs7v4L6JxW7QjM6qMw604Wv8NCK3timO+vJ7YHov7kfhRTy2sWp14rklwh
         KvKgUeEVlDClGR0mCD6D3wMQ3/5UGQ4HNWNfyLvoUq1NZnK3WIBmSIH8bho7VZFruDmf
         IHndm2y2RU+7ZY8NS4Rk6C9PaNf5Lg7ERse8nCwnrTzucs++X7+R5AFota1r1H2reJ+z
         1ijA==
X-Forwarded-Encrypted: i=1; AJvYcCW/estdA+HtqsOEzQe6BlOT2lG0Z5XELTCrE88r66ncVHTfsxHqUpmEj+L99T9SihkvMn3nUzIO9ihJYZbf9vAvN6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6jBhg8oYJ4GYxc7ifhBGHQAbL+bTTHGH31SQuofmNd8thzaw
	WA2LzFF0lmZobxsbVcW8fkOcdxCXNVWMazZFQCaPAt1Oyrmpt6tI8ZrPUJuIu9e/3HrHHt0Kxmc
	8vBW4
X-Gm-Gg: ASbGncsrhtt1k16sYhZFNYDOkFGX3DLBGf2ik2PUxsbIYurJPCJUISTOZxz5VOtr4Bp
	NRgrcGxr9Vc/Fbynoov2VGwuLxpw1/GTvO862eiPG0C7rsTBNHf2kogj5wWRTnL9m8HoX3Nhswp
	s2nhxuUm8G07qFJQySG1RyMUiTYMUB0Uv5eU/jQSgoP4waKrKU3jip43wJ2UIgWhwQhKHRoUW7E
	gnoiH6cAtJy5XjC2v62Lp6rtgZCUFL2yiPjxnq39ZxvpG43u6p+yGjRirzG88hxYownWzIXVClL
	BRsxc8iCJQX8wrOFVTvK1wV/f2nW8fbuDgrYGm2k6AlbR6OdjvArpSYcnzbfwg1KIRCMSMPJwkT
	uRm8hEG9UpCqVa9S/SAfHgr0HPV2lidMnzA==
X-Google-Smtp-Source: AGHT+IEjVIBgoKwU7JAUm1idxYByEHXiDmed8r9RKzj3gIzufCwMdyKungjHAWAI3Qak8OLj+PIjsA==
X-Received: by 2002:a05:6870:a550:b0:2e8:7953:ece7 with SMTP id 586e51a60fabf-306c72032afmr5665997fac.24.1753394036875;
        Thu, 24 Jul 2025 14:53:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7412cf44fa9sm424813a34.0.2025.07.24.14.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:53:56 -0700 (PDT)
Message-ID: <94813f6a-e789-460c-a898-7c7fdfdfad2f@linuxfoundation.org>
Date: Thu, 24 Jul 2025 15:53:55 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Fix false failure of subsystem event
 test
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuahkhan@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tengda Wu <wutengda@huaweicloud.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250721134212.53c3e140@batman.local.home>
 <20250724095309.480882c8@batman.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250724095309.480882c8@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 07:53, Steven Rostedt wrote:
> Shuah,
> 
> Can you take this patch?

Done.

> 
> Thanks,
> 
> -- Steve
> 
> 
> On Mon, 21 Jul 2025 13:42:12 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>

Applied to linux-kselftext next for Linux 6.17-rc1.

thanks,
-- Shuah
