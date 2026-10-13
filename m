Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4652D2AF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906403; cv=none; b=Z5mfDmH54frFI3J7+liEcgC8FO9QVf/9thstl2AUj1tutvOKpHIPYArqNM4ZPVw+gbAsl0oMB747Wct/E+wmmQkfhg99Jwb+ob/Z45dQrNev3a1Xa408hFz/ZXy/mTP0KOyiDpmVRw795eCAONjXpbcMRNrV3NPUJPMaOUCzJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906403; c=relaxed/simple;
	bh=qxAhtH0Qz1tc4sXD3RSk0GitMJeJ1buUR5W2lDaw1ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZGUZwGDiKqK0uv+dM75NKMdxUB68elbHgoF5Q1NVEZGSLQwHgnuW6h3SjHDbtgn5Gap1n8MD6qnEYPZ9bOLRr0q56lyI/SajCvO/ViuEEg9GmkqxXd9GxX4NNkMPofcuVErOLrvweKbGA9bDLk1WhBe174a4UFlTbhvUSJ5cow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQIoCC//; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQIoCC//"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-822ddb835fbso2310373a34.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1791906400; x=1792511200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ockmvioh5kYqi16yQi6YbVdMgoCKQuguDfyJFS26lwc=;
        b=TQIoCC//k98OgE1kA0UESU5QWF0tYtO1x3YlqjBVwEgVRPe/0mMjxc5Em9ZIWj2B24
         ZKcsS5js6wM1HI2qV1Jx8WDGVrrN5gneeScRDVwRPJlwVFYcRbZLympoFayXs9HDEKez
         sZ5fL0xte9t7LI+Tc7q2isLhrsO0EVqODHlXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906400; x=1792511200;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ockmvioh5kYqi16yQi6YbVdMgoCKQuguDfyJFS26lwc=;
        b=AwyauFbq/2d8ODPgLG5KburRwI+a8ShkwMKTBDBGAtCC3sdyl6sObKTtR1Hd+jcBaW
         2iU4D2LKydpn6yUOU/sDpNJUuy7zCsRq+yE+Ldc9CPzVL5YIBs1/Kd6t9mM12IK+3INp
         NQL6ah1E+6aHPTN+ygcb3JrWTHBuYpP8aUl9lxT5a5ClKKHHu0Q9pN8PTQ16AjCG7fAo
         ljsUs+lAr5fetQHksWUv6aMmCkiIsEkVWIL+3WANF18Pz+EAqQbCZJnXnWHFUrMq/G7A
         PEg6qQlKK3sUUXd9xw5vuFVpymzfn8okc6ITEPh/KfMBTeQlZtHPJQmo8oSwbA/bOGKN
         8bAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpXdzDrYv5lyAVzixJcFUVso61nAnFUgcXKQwvQXNoDYAn9vMuJM/jbY/b2TFihJ7tIHks13i24/5ssxpKsUJSCVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKq57DL0hJ1055+8L1FCP4RrYVMFfwkAD3HiYIYvfyMCw2OIbCd
	wWYf17INzkXO2VqziOw9awA9sjN1c1wBWsikfyz6IVPAlFIMFXxg8ndjrDWSwZz+jH4=
X-Gm-Gg: AYBFou2D7x8jvLuoGeI0PoyTY8o78h79hmecNJ1y4ddab5oL0Yd3o5hbH+xz+6sRPbd
	QzrF2C8FY6Y9/XFkwuVvlLvJ/nJOa3G2RaBktbHvuJt0f5+7k1GXu1Bedsih6jaz/e6cF5uFnwX
	OkrUq+GZPeurQJYsGIu2Pt/HN20tqfp9XEQ1f4vTvzIw4oLN49WgnRlRWwjIIH4QrTWZA04Fp0g
	VXe6svwHhCm5XPG/gmEa3STzo8ObpQRJP+tKmmDnJpSenJR4JouGKK+TNlrMg21bo+RMbzQu8o1
	tvy4eFvVGk+XuvHSsT4yzQK+fqh0ZyVvfhek6NqOstzr4U2g+QpFA8zJOoYl0QfjLpVzZHmbIZk
	bRJAYVbpjhLBE8XLUPgW8fk2cruyL5fkqaH/J8Q9u/BPm3jIau/mNiECvmaI3xsk42effPToD7c
	840fm3tTtPXsurb8vFAtM687SEqRThfTFPm0ofOwG3wpnF07fS8gnsBg/+SC0dLO7HctINPiyQo
	orFR+hE
X-Received: by 2002:a05:6830:6411:b0:812:3a52:16f with SMTP id 46e09a7af769-83090b2e4aamr13920151a34.3.1791906399829;
        Tue, 13 Oct 2026 08:46:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8367ada5b6fsm6362797a34.21.2026.10.13.08.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 08:46:38 -0700 (PDT)
Message-ID: <d1eba191-d4c3-4727-95c7-bd5736ebf8f9@linuxfoundation.org>
Date: Tue, 13 Oct 2026 09:46:35 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/selftests: Fix incorrect invocation of exit_fail
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, woradorn.laon@gmail.com
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, inux-trace-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, shuah@kernel.org,
 me@brighamcampbell.com, jkoolstra@xs4all.nl,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260918061913.28069-1-woradorn.laon@gmail.com>
 <20261012153601.6DDF11F0089B@smtp.kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261012153601.6DDF11F0089B@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 09:35, Masami Hiramatsu (Google) wrote:
> On Fri, 18 Sep 2026 13:19:13 +0700, Woradorn Laodhanadhaworn <woradorn.laon@gmail.com> wrote:
>> Replace all `exit fail` and `exit_fail;` with exit_fail to keep the
>> usage of exit_fail consistent across the ftrace selftests. This also
>> reduces warning messsege such as 'exit: Illegal number: fail'
>> in test logs.
>>
>> Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
> 
> Looks good to me.
> 
> Fixes: 2f84b39f4847 ("tracing: Update subbuffer with kilobytes not page order")
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Shuah, can you pick this fix via your branch?
> 

Thank you. Will apply this patch for 7.4-rc1

thanks,
-- Shuah
