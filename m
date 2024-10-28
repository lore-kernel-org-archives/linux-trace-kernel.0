Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366214375C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730085902; cv=none; b=f5Jb/AaCATRJKe512VrDxqxYU58DOxaWuj6FQoslSAhJVv7Cil90TM6MB1f9CZNtnIwxOdH+xCC585sowmj7mdF9nZyNVn1941A0SGaZhlrWgbiTr3ZQtIqNSrG/L3RZCdpzWe6wDWmw9uCLQGNRiL9XjB2+U6mQpde7oMwx+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730085902; c=relaxed/simple;
	bh=BgAxH7BuovLSb/VyMg+CeBt7AY44ASR1oxeFqo3yo44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kExa6orpYwBPHbnYxOyCJ+QUhr59uUEaYKJC1yAfVBaBcaup/Z8oUwKX3U6QbfKmoIgg7rMw7iETothY0Mu4CMcBotQ5kZUMrmHcoqzujQ1NDoK5ryQiE5fuHtCaDRxS2nk8QvNVB/dstQbd8XLFyPY0sd7oThjTnpPfBnDyXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CLOlYape; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CLOlYape"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2884e6ed0daso1361860fac.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730085900; x=1730690700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQps+ZocWxrGBOwCyIh53YeKrI3fc0l3GGoMpgWYcYE=;
        b=CLOlYapeHgS7qupjvOvjXCSufM9OGk4V80iE3+Lgxny41pwpLnlauhIJgGQpzbIgTA
         dLpWDwOwQS7GOjFmZagsxLJaFf71R9eW3yeY7VGXnNeBOjes6Sz266bzPib7nI9UtXv7
         Um302kJ9X+BN8eNXMRMqwktxlY900lh7BT+lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730085900; x=1730690700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQps+ZocWxrGBOwCyIh53YeKrI3fc0l3GGoMpgWYcYE=;
        b=YPqv0rzkj1JUEELEPIUOVs226yipC0xmuliVtCPAaVU8U33qwSx3uj3TuprwZAXW0w
         qCc/43v/2M51vC5842J8f3Pqmzuz2TxLmbAdlmZfWBN0gu16K4ol/Eo3ArzimLFvxrA0
         Dpv+HwEYoKK6daPKKUZ0wuVDckvEYdZia0Av4L/n7MzBKn9Rpninq4rk6hnPDXe43Zgw
         UCV9i6BTKvnh5UcAkqDrO6TjclSNgmxuYcoQz0XIp5Voj68giHbGde7+0YMMFapqwLH6
         fkIuxnVkJi80d5x2GY8O/HYki2Ac06aONqkFWy6LwhhekaEA/YEgQbwfpd8GASbaufdh
         w8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/OyEQZUSLof0FGuCX1ykZFhAr5NNN16MS3iuiMwQcAtBSpwirr/kWFgP5qs/QX7CEuNgiCW5WfNWCx0BMQgR5PbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGn1esrmEA76MouNzr6wx9g9mBKZk7HOP+8Np5YJIy9Y+6F6XB
	Bfv9xTfCnfokOHm2QUS3JL4j3tQBYUhzZZGyuqvJqPwiVRtuYEA3V9SVM46/hAo=
X-Google-Smtp-Source: AGHT+IGE75zSHhwyyDDQtRp4FgDHkbHA5Xo/zZuHaCPkdqAGRqL3DWjJapnemFbOWTvX+FJ/kTXKiA==
X-Received: by 2002:a05:6870:32d2:b0:286:f2cc:7a71 with SMTP id 586e51a60fabf-29051d705b0mr4868242fac.32.1730085899683;
        Sun, 27 Oct 2024 20:24:59 -0700 (PDT)
Received: from [10.200.3.216] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8661061sm4781718a12.17.2024.10.27.20.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 20:24:59 -0700 (PDT)
Message-ID: <5d87c8ba-8464-4d9c-9152-611097b5ae3e@linuxfoundation.org>
Date: Sun, 27 Oct 2024 21:24:55 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Removed unnecessary initialization of "ret"
To: MottiKumar Babu <mottikumarbabu@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 anupnewsmail@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20241027211913.26718-2-mottikumarbabu@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241027211913.26718-2-mottikumarbabu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/24 15:18, MottiKumar Babu wrote:
> The initialization of ret to 0 was redundant since ret is set to meaningful values later in the function. This change simplifies the code and avoids confusion about its initial state.
> 
> The issue was reported by Coverity Scan.
> 
> Report:
> CID 1633338 Unused value - An assigned value that is never used may represent unnecessary computation, an incorrect algorithm, or possibly the need for cleanup or refactoring.
> In register_ftrace_graph: A value assigned to a variable is never used. (CWE-563)
> 
> 

Check submitting patches document for how to write short log and change logs.

> Signed-off-by: MottiKumar Babu <mottikumarbabu@gmail.com>
> ---
>   kernel/trace/fgraph.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 69e226a48daa..b13ab2ad0e88 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1249,7 +1249,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>   {
>   	static bool fgraph_initialized;
>   	int command = 0;
> -	int ret = 0;
> +	int ret;
>   	int i = -1;
>   
>   	guard(mutex)(&ftrace_lock);

It makes sense to initialize ret - i think you might see a warning about
ret being not initialized before use. I don't see much value in saving
unnecessary computation.

thanks,
-- Shuah

