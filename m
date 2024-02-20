Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80A1EF19
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472465; cv=none; b=fKhjVlQbHuWV86GERR7uEHxh+YWqV5JtoJDQtK7NxnG4AZOKbb6djDxhnKQT8JRC++84eNhjFdhl46IsjC77JTBmO54Ed+8Wp0luWQ/1QRZmTX/KDb81EEEP3NBaAetW25wepjiUIK95SbapzlCMwBVuf53EXBCHl9wda7VzL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472465; c=relaxed/simple;
	bh=gronH/sTNUv0ew6QhMarwGTwQTMnrQvjlXgLIvPHrTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fkh/8AN6gMd5PIiK98OlsgeH9psCO2n7+DhMEu52LCIOArbq5IathXjJy3fsM5keo+4+WgHVE2q/ZA99bPqHJCv97MlujNHl82fj8j1758M2jYxUfM0kz8Aa/dqI4zs3agDk65XvqqAGJGFtvz4Pl4A7fIWhlnVsCTDHhAz6jwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cnunaKmc; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cnunaKmc"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-365306a6455so2685685ab.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708472462; x=1709077262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UnsYW6EfxqDbmgBg2KeWLKrmKZBH6vvHprlR2Mupzo=;
        b=cnunaKmcTUL60+n3ggFcjlJnoFbbm2R8RNjxO7kKE0z5N6cYt34SAn8arkC4XZt4Jk
         jXPQCQD1svKf4i5jEZPRlu68RmlZvI0J6oc6SqU4mcO/X7v3TQg9/0Sd5v/1s3jBqkE+
         zmX6BCpLa+7UEeXzopMHN2jCF6S+pNvWw6oB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708472462; x=1709077262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UnsYW6EfxqDbmgBg2KeWLKrmKZBH6vvHprlR2Mupzo=;
        b=chga41ea9r8cPqn1CnmDubBTPxhaPyQYvSQqgA3oiYo0JcNoQbnAhI0nDi05FhqkpK
         Pd0aRelpxL96HmBgkeCRrwMxd4R1i9pCmSZEbPn/Xlz0sSn68Ge1CIlHG5HXOPXmiUW9
         X7SiLyC/C8gJDbv2T/otK4N7HY5k6cl1+33m/6KoTp3C3pgxeF5Vf8LCJwOxF6IA2yxi
         Scf+vp5NH/kEId1vR63lUB9hJTpK6uIqbtbRHh0dtb+TErE3tI9wgiGcf3JjRdD4qD/y
         4KebYVWqMPaKaRj4q30glm9M4SSXZEbj2CXV+Yb5fqotsp42aKvElIbpaNndLT2ZMoj/
         4bWw==
X-Forwarded-Encrypted: i=1; AJvYcCX2vgAABs+UbRvX6wtQv2xvsB92WKnmoHnzjIosrU5vUkQ6AgYm8JHe6sXtL0eQHD1gwywAPftsUKaBR/JN77KmAbCR9ep6M3eze8o/Rsz1c1GN
X-Gm-Message-State: AOJu0YynYm3/HCyt/YgdkKIbthok1wcmhjCd7lco0GJBkbY19NuTgu6E
	rAd+cVxXQZ4SYLC3VDGfEp1mJLGS9QbEQKOWy/ZTDYhstAYIe00IgLXrtLpcqVc=
X-Google-Smtp-Source: AGHT+IHRrBQWlgEVXB8xMK0wKYzUDkVobcMgKCKkpm5C0SCWhawsu+rb5R/+xQm4pWfEmEPUTiYoBA==
X-Received: by 2002:a05:6e02:198d:b0:363:b545:3a97 with SMTP id g13-20020a056e02198d00b00363b5453a97mr14198470ilf.0.1708472462498;
        Tue, 20 Feb 2024 15:41:02 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b19-20020a026f53000000b00473c4bc1f7bsm2447107jae.20.2024.02.20.15.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:41:02 -0800 (PST)
Message-ID: <7459e07b-80fb-4eae-9414-3dee68cfd173@linuxfoundation.org>
Date: Tue, 20 Feb 2024 16:41:01 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: ftrace: fix minor typo in log
Content-Language: en-US
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240211111818.610211-1-vincenzo.mezzela@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240211111818.610211-1-vincenzo.mezzela@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/24 04:18, Vincenzo Mezzela wrote:
> Resolves a spelling error in the test log, preventing potential
> confusion.
> 
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
> 
> It is submitted as part of my application to the "Linux Kernel
> Bug Fixing Spring Unpaid 2024" mentorship program of the Linux
> Foundation.
> 
>   .../testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
> index 4562e13cb26b..717898894ef7 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
> @@ -40,7 +40,7 @@ grep "id: \(unknown_\|sys_\)" events/raw_syscalls/sys_exit/hist > /dev/null || \
>   
>   reset_trigger
>   
> -echo "Test histgram with log2 modifier"
> +echo "Test histogram with log2 modifier"
>   
>   echo 'hist:keys=bytes_req.log2' > events/kmem/kmalloc/trigger
>   for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done

Steve,

I picked this up fpr next for Linux 6.9-rc1

thanks,
-- Shuah
