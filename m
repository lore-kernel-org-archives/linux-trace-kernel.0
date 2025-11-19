Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0720C48A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590568; cv=none; b=QbpJEqsEXPbf8JlD7s6eee5CzcOnA/1A/Dl/v+Gp8HKoN4hb0cff7WCXL9WqQpiesdg/eMmj+R2QrajxqRCr1VAJVNbkxczK82xOpwX5/J/cHBpiOWIPRMEBgvwNnkjKBUUN/t3XTjiJuMzOIXrOPbTA1u+piYs1cga2Wu3qAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590568; c=relaxed/simple;
	bh=8yQKhB8cDwXTanOKPCM8whTN+PBOthIJtZK31gPpfOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBtBnCnWRUp/mT/6sNkwtSGz8uOe/ldKqh/3ShCBSPlgw6xWvTndiCpgnS6xceruZRdV5yw3k8zP/+EC4QgYMRo+M3KKS4KPWU/vhsDqLde/1Uo5uK2aNcGYMncrPQxaTYk06GJ/Xd7v1Z9UQIgzV0vStB+6RpS7YWyApKK6Hao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EyOcpRdo; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EyOcpRdo"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4332ae0635fso1131995ab.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 14:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763590565; x=1764195365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+5oVO7Fj+kTc9HFM5rezv6tYzXM5pbpAjlYLPbZLSo=;
        b=EyOcpRdoN08OXFfKBDYy0ugilUBukj092T34EKW9z0IeGSdDXNrNdUJiRoco/hOMzd
         1UmJ1jykn4TK+w74hU8IEZFXNY1i1EFEQBl1aP8hPsTSGt/Ow8f3x5AfDJ4HzQtQAJSv
         snW4E2iCcndozpaOwynHCh/nbH68za+iVMrQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590565; x=1764195365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+5oVO7Fj+kTc9HFM5rezv6tYzXM5pbpAjlYLPbZLSo=;
        b=dLJWe3X9LbXyMZ7j4iA/wDw57gfv3vzYeAOC/t/6abXscvAvoG4Rx+Rqs+OokSXc/U
         AYkxfw9FS5BmR57249r051hMP0omt3JPR1hh91RbsaTJYoiINzePAJfrN7loZCRMLfJy
         K1L990ZnEi1qep8EyRKPc0GJHFpVsuD7Pc3j1BQfnw/2H6z5jvnYl+3Nmh7hrMTJkSuY
         sy+XVyBKLn9FovOQGqQV7cflxiDUHFQ/ufTwVRyqp6+2xXuHU16rBrcWEJl4fwIbCYCe
         o9FSuPavsIQZgEG39amJ1REXYvWcYHkk/YKqYutL/p5KqYXOJ8lX+ZFQJSeOMW9+z44Z
         uq/g==
X-Forwarded-Encrypted: i=1; AJvYcCWGKd2KlDf/g2Koev5bk4FOU4xQJazOZcKPEUyFg48E7T+c+TnQyDaKVEJsz/wlHSoOUuyGdHITvLYiAJeamh1GsTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/VWeUovLfyaDFoTbU4zXBawKvO3LobHp3bc5NPPxAeRExm76
	U5icoxWljUwvWazeIB9ISOnKZev5/EPGCGBxgq0kKb+ruG4Iv0qwWsKtPGtNMV4lk0w=
X-Gm-Gg: ASbGncuK4OrkYJcQgR1VWy7akOKd+eaWDaEJsMX9EvL9ZlJ2L3XsKdqoofQkc5bXPhS
	oz0U4oe/WF9l917rCvVpYwzZfO4YaWGInjL3IouNHkufndT/d6dnOZ5pt4nZzMyKIjYPxJySkfW
	4o5NEieRnHSpCE8bXF0hif+uBQ4tjLJYwPuurA8YFQjqOZLkn8nIWe695PmuCEZ0ypf33BkIlJ5
	0QU0qYhlPVBlmB23kF3FHCFwgozKx+vBV7PDvJjMpgZi5JBAjYCUty9FLrLjwtqZRGMpqMaaJTB
	4iOjciaATpNFrQVh7EH2pgF8zGgGJOmYHOHGlY353hiEYQZaMcNCpSth4OYxXJ+g4joMZ/N1f15
	vfYa8L0WL9FF0DHNHw8qHjJ8te1RfvZm+/uKmeUCLNgPZpTYY8bHar4RQfLzppdUiDiEZ+wpqOj
	lpITNRPvkA5IOZ0U6Z9EHFOuccWmzFqSVR7w==
X-Google-Smtp-Source: AGHT+IEb7sFMium6Qlegeyb4ntAkPNGU2yaln5lmSa5i7P8rdF+g/+/084yxEnhSPqDWQXjYUWLDJg==
X-Received: by 2002:a05:6e02:2501:b0:433:2b02:af4d with SMTP id e9e14a558f8ab-435a902d62dmr11116195ab.12.1763590565591;
        Wed, 19 Nov 2025 14:16:05 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a44d60sm210907173.20.2025.11.19.14.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:16:05 -0800 (PST)
Message-ID: <f6831d9a-4ea6-4100-9b1b-716ac93e1cdd@linuxfoundation.org>
Date: Wed, 19 Nov 2025 15:16:04 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Update fprobe selftest for ftrace
 based fprobe
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176295318112.431538.11780280333728368327.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <176295318112.431538.11780280333728368327.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 06:13, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the ftrace fprobe is both fgraph and ftrace based implemented,
> the selftest needs to be updated. This does not count the actual
> number of lines, but just check the differences.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
>

Steve, do you want me to take this through my tree?

thanks,
-- Shuah
