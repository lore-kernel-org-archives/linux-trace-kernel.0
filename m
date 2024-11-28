Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646583CD2;
	Thu, 28 Nov 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799772; cv=none; b=ENlWejEUxzJd3IRd5dufp4TBRav0/X0ih5Cxh5gq9ig1VThTKi0t7Jdq4K0J9XiGfWnmLBIgge6TbtXzdqwK5I9jRRxuwhZp52QLCqiD1Ofww+6vw0ZEw+HpnDk1FrpDSJuDA5BtJhrLjCZn8KTgsE/8Gp/5u23GKBBIU12w2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799772; c=relaxed/simple;
	bh=AHbe3ONgT0iXahqOuCrLNzCJiHyzjS930w/ljbnUOgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y21noc9VgGiRVEF0/x0XkF1EQ8au2q3IIbXf9bSDQyTmbHy1IVbf6s69gCCt4vNHbr1/jfdpgRld8Akg3qWphpiY4uqoe8Vty80U81WY5uuKZLoYjzIbLy8xS6cCTC9CdOzs5AoDSy9PFeN0ge0pFeRUgkFjomH1AOoQBLzbsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT3jAWMx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT3jAWMx"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7248c1849bdso805201b3a.3;
        Thu, 28 Nov 2024 05:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732799770; x=1733404570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI1pCwJkAn6t4ZfEbkZqeKTjuje/rHQi5jRrfZ4wz7c=;
        b=gT3jAWMxFa+iS0i7gawIjIOs+qB8/ZSHO0tREyRvj4HDmp50fdPreDm8Vv2WUtizOq
         gl6I9VM96+FG743g70yvsi2XdxwshE1zb9kyxatFtbKVjY+C+nyoC/qskvVH/NL8F8Pc
         8lV661m6QJEfGxYvfCqNk7Msr9LoAtNNbqb7jCTypiMA8vySQ3KCWO6lANVmkMXUScq7
         Ndj6OirwTkI3iEmBtoF7SVPj3i0MdoHK9ihjjL44DxckdADs0TSy37mb8OqfwXg4Ema3
         y5m1jkRvoDpeQGMWmFZ0IBeEamrbBl8nCrbQbwvF/Emj0uW1i+PFDkJg5KA+ri8if40y
         tluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799770; x=1733404570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DI1pCwJkAn6t4ZfEbkZqeKTjuje/rHQi5jRrfZ4wz7c=;
        b=Pk+N2Ffvx5wRSuqSnXI670vOar97ooaK0+RJstONF9OeYkSBcePtBDA+2fAZwbwcsQ
         L5eIPfy438i2rdbb9Lv55mO9fpMsuYDDvmmoes4v+M9AAxyzUlFv2i88bLUK1+BYkGaG
         9MIl00RtbIIOVmoYZmkkfa8vPRmzVc+7k0D0lIb2wyfvgvdgU1N/8FM59yqqJagcM4xi
         Ve7BWszq8yORBTTBn0YTaqXS3lRJ/FhvKQBia+coxcsbLbK05u4x7g/7U871HdkiskLx
         AZ5fQhYMVVp/niumiUnNjrmd8Gr8nGpUSitBdspURt+Ki4mehLWHfZqtrnjfZZJolcGp
         WtwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKSGnS+jY4beEHGpLKZVwedp5kVImOjVhjcM1dJXHKTMZaGJGojTQLDZkZiW0UD0VEl0npBIs2QbG2mHpUj0tQc7z7@vger.kernel.org, AJvYcCW7He8iSg0h5R64fQAIR4kwjfkogB8B5sen6nnHUi2aYar61o/i+noRnckNBsBMkSmhImEym6hVEIHuD3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG//XB6Nh2zr0VQ+67jDOSOBLjyc3KIAMNSEyneXL4xRQHbRRG
	JM+1loezYBmSLlDEUFT52ltMpYFMz0wkFWpjP++VqAkNhk84K02x
X-Gm-Gg: ASbGncvXI7842sSSJcvGImgaDJPsNqvb41vvKcM15RVH3jPiGCP0fB6B/APnvUuVu4c
	CdP9dnZp2JiP0twYpDVJ670y5EJh1nl0k4Df9voM8zBq3MEQIK+5NOkpb0NjiNKcmnAb3jEoDei
	xOFxx7NNAG8kev7+5qc0gcLJu8UDC+umddyddw0ogF0ImSrHbb2ZA0cfjmx6MBZ3/SNZZfKDemE
	/Fi6xWTPIdXM1jZmJpowtW1DhWI7Li35FWvuOi/ati72IaBUS3KNiTsuzEbNVI5kQ==
X-Google-Smtp-Source: AGHT+IFXaQUF/tUU/5tzXgZy0o6O6p53ZAx8FFFPC/UpXtecSQNiB0AEgGrqag8SYV5qJHTxHG9RmQ==
X-Received: by 2002:aa7:88c3:0:b0:71e:db72:3c87 with SMTP id d2e1a72fcca58-72530103f57mr10252530b3a.20.1732799769748;
        Thu, 28 Nov 2024 05:16:09 -0800 (PST)
Received: from [172.23.149.93] ([221.12.5.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbacdsm1464372b3a.95.2024.11.28.05.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 05:16:09 -0800 (PST)
Message-ID: <8d4796dc-ef5b-43d8-8ec0-3891b7994428@gmail.com>
Date: Thu, 28 Nov 2024 21:15:31 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add WARN_ON_ONCE for syscall_nr check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241128115319.305523-1-chen.dylane@gmail.com>
 <20241128074623.063bf253@rorschach.local.home>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <20241128074623.063bf253@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/11/28 20:46, Steven Rostedt 写道:
> On Thu, 28 Nov 2024 19:53:19 +0800
> Tao Chen <chen.dylane@gmail.com> wrote:
> 
>> Now, x86_64 kernel not support to trace syscall for ia32 syscall.
>> As a result, there is no any trace output when tracing a ia32 task.
>> Like unreg_event_syscall_enter, add a WARN_ON_ONCE judgment for
>> syscall_nr in perf_syscall_enter and ftrace_syscall_enter to give
>> some message.
> 
> So on a system that has "panic_on_warn" set and they trace a 32 bit
> system call, it will cause their system to crash. Is that the intended
> behavior?
> 
> WARN*() is for self testing the kernel to detect real bugs, not to
> inform users that something isn't supported.
> 
> BIG NAK!
> 
> -- Steve

Hi, Steve, thank you for your reply, as you say, so what about 
pr_warn_once api just to print something ?

-- 
Best Regards
Dylane Chen
