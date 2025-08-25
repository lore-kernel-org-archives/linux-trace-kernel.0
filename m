Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B222DF95;
	Mon, 25 Aug 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127500; cv=none; b=ZWyl4yXbX8XC2xBwcvI9MFGdSkOi43JEqSmwRrY3hWbnBL/Jr5TZpA7L2z21Wu8vq0BfQqm0N/WQjmhuRQVIs4BfYwXJ8gfp8bgWe+8aBvSf5tDPgtYvLDCCbmc5qGYX30kwk8QdoicZNj0947NLFaMqpRWfOOayDyeyihmlUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127500; c=relaxed/simple;
	bh=OIgIaGr+BE+306Y6Tl8h4/650F+sm369Z7GPCzSsVho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rz7ErRJeapsc0NRtGl6UEqqCD83nnvBtRuxcqrSXpi6rCLPjHWuG5pZECF4qWVrf+CAtuQCjflMW6osDcAXX08M5N+jkHuwNI+geTy/MBAvLqzDf/Yy8i1xlv8Fd+XDaDb2OCx8C/U4KiGbsyDBNmF7Uh+PtS4e/5kLHNe73hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2BWl5VT; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2BWl5VT"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so2824022a12.0;
        Mon, 25 Aug 2025 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756127498; x=1756732298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7uHrtrZhpgZRk0gGbUgDzQJCGEajHuc5dkdvC0IEnM=;
        b=g2BWl5VT/Duus0Zsqr8q3YPCySZbuIboYsB3kgWJLg/FwBpQDYPDCFojdO4Dd0CJiG
         bPCsicWKPfuH4vsfQrCEv7jvr2355WIcH8LV6xMkjPOo/OQ6YOGhiJax5SFF9inGeU8Z
         Sox93AxCXCs1btHCmX0SRGZ3kgHY+xu+qFQ4LH+ZhuwbBXuTaI7h4rdCZWjOVH0zXTq+
         iwmYfJkn8TlKOe8HjHoSVRgQjfyd7bJL01IasS0sBeZSCpRdTRTCEKdCu0mTSXW1inAe
         4mscWc1Ic2etDGgMvjozm5+YEBCtvJjdgBOPUKhJ1ERR4I4n9/GATNaDST5XvHPP8GEl
         mhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756127498; x=1756732298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7uHrtrZhpgZRk0gGbUgDzQJCGEajHuc5dkdvC0IEnM=;
        b=XVATSp1HISfBsVbRJJRVu9YAdVye/B37W1Ay3/VNerLxTcXSBiATRstD4sYLjO7XNi
         Gr2fYeklTuonOT5DBQD6CVa8KFJ3XDHX2WHTgwu8v8+vJVJG0J1tP/CkMwjwtSAK0s1Y
         7xN8DgnEQ/GtM+qTmaEBUFTvM3Llsp4oSdhHTIsso3NUqAvW8cPwYkCMbeDtGBNHfcUx
         4K/KkVb/QkPi3BFsUd1uDXz+NRB96Dn6KOTGAMhmemKJaHQpBZlFV+Vrn/rvTaUuk5hj
         xvdFeCgnir+uLwQNMkUQwYmc/akeSCsmZH1RHJg7WB+kf8ZZMqrkekfGqkjw8NmNnZjp
         4IRg==
X-Forwarded-Encrypted: i=1; AJvYcCWwavw/przDe8H0upyBAP84dwwT8tNh5RPIvj/fmR2TuEcjv3k2RhlXZvCfp5lEMhvv7TT+quGUqja6HCs=@vger.kernel.org, AJvYcCX/D5ANYdQC9dJ2Fk996Jo4R6Edu3RjdEpgya8BUsVxCdvf4PGeD+udxHsqhzH9IUT5zRvA6cORnFUw9Vx76kJj49OX@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuhsZZwhmGiX5P44Klz57mnvGNTjePMe7WULFbaaIbZFpL8aZ
	bjstAOP+TJOQQQ9LOpBr45vn4/6f/O8BKr0M+GR6H6zCNkvRq1D1ib/j29bsRIDe0FszvQ==
X-Gm-Gg: ASbGncs7gv93TANKoUr/w53o3KF7cGibSe0IT3MAa0JtucIC6jUhWcM3W3dyaLkmqMS
	Swogh98ftp1sSIB7UisKthva9gw0BEmSzqFlEXd7ZEPDxoG+hku9TThCIfw1qRpm5rSeDPcV7/D
	kvEMhT1AbcHZj8KrRJA/6CU7hmoUU3pMZchhgC8szz7RHcb/rWgscPnQ47WJvJ3GQ6ci6QDiQGI
	158KV47VAJNMpkZGCYi3IZy2/6RFM6txRPGbSBI2QIEIhpVzlAS2vXH0fsXXw6Aq+NCg92M5G6b
	tgidz6gOxfLIWaEQIngH+WDCOA4KC3VopXmC6jY/dJDg2NRPSk1fvocLrj6TkPZ4cXg/e06GSV/
	ZCUKWl1/k57N1BiVJC8CtzxGtHw==
X-Google-Smtp-Source: AGHT+IFbVFBJFVzIAzDQKA+W3eY4HXKeve+wc3ajfKtFsEqnzzGcvnDoGfuQcjBfLypQsN30CCxKvQ==
X-Received: by 2002:a17:902:ec88:b0:242:9bbc:3644 with SMTP id d9443c01a7336-2462efacca1mr191818555ad.54.1756127498092;
        Mon, 25 Aug 2025 06:11:38 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:6::3058])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885ed8fsm68579725ad.71.2025.08.25.06.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:11:37 -0700 (PDT)
Message-ID: <abcfe0ce-0c0b-4717-9069-a6798bb13b76@gmail.com>
Date: Mon, 25 Aug 2025 21:11:30 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/13] mm/kstackwatch: Add kprobe and stack watch
 control
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, naveen@kernel.org, davem@davemloft.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
 <20250818122720.434981-5-wangjinchao600@gmail.com>
 <20250818122720.434981-6-wangjinchao600@gmail.com>
 <20250818122720.434981-7-wangjinchao600@gmail.com>
 <20250818122720.434981-8-wangjinchao600@gmail.com>
 <20250825193127.a0acb9831733e0e51a5ef81d@kernel.org>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250825193127.a0acb9831733e0e51a5ef81d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/25 18:31, Masami Hiramatsu (Google) wrote:
> On Mon, 18 Aug 2025 20:26:12 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
>> This patch adds the core logic for controlling the kernel
>> stack watch mechanism using a combination of kprobes and kretprobes.
>>
>> A kprobe is registered at function + ip_offset to turn on
>> the hardware breakpoint that monitors the stack. This allows
>> the tool to begin watching from a specific instruction within
>> the function. At the same time, a kretprobe is registered to be
>> triggered when the function returns. Its handler is responsible
>> for turning off the hardware breakpoint.
> 
> Could you use fprobe instead of kretprobe for hooking function exit?
> kretprobe is an old feature and will be replaced by fprobe.
> 
> You can find an example in samples/fprobe/fprobe_example.c
> 
> Thank you,
Hi Masami,
Thanks for the feedback.
I will respin the patchset and replace the kretprobe with fprobe, as you
advised.

-- 
Best regards,
Jinchao
