Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9A217705
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Dec 2025 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765146225; cv=none; b=JuGcr3QcjDlnkKhz61oyfWYpPO7szJK/uQNE6ofezY1vuIcnrlY7ORBi213UdMkPaif2kDBrE9ncQEqxHJ08WKce7Ab435QbfBeFkUUiuOrnTtJa36PLImR5D/w1vmlBGEEkIQic9TqteSmvLOXIAMSSw3Zs7/BlHmSxH7RjbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765146225; c=relaxed/simple;
	bh=o/UYKSK/gkbLh8FWxRxvVU3OkU/Q+/03bFyedFJp1NA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCyva0+fzgchBOHMfOgDIVMNg1yph2J4QUH9H8qlsm2endFKpTggyQL7xq/qotp2CaiUxF2YUSj+uySLF8nktOqcNSLgpdr8s9iwdZcgSqSsEgt4uptfjS//tyREp9PIG2rGAB0WLoPOh8jn5BIu12fUPEplTM3q8bppeg8ZbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCE66x0+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCE66x0+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso18923915e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 07 Dec 2025 14:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765146222; x=1765751022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+w862P9gwDeWHrowG1HizWcJbg4rpsvYLnk23PcrduI=;
        b=XCE66x0+QMeUsDpmtND2oSsLY+7Y6KU0mm++Nk+/hSjhd6bho1cLaHQULBnsNpx2kQ
         cU+Rd4nt5NavdpcTs7k2G5ihzk45DzkGFChYuPPTywwFrFWHdHWdINI+4fqM6Nac/5BV
         NOx3wVKqPdnTPrYFGGuwtRCSD4FvG9kpt/C4o9vyW2m+zfxvl1PSSfZC/xa/8o/sl+MJ
         zCPI4gl6PCJ2E0XV2ScZ+uFccl0+rn0aCfca976+4Upw0zSF0BZ2+c1UjJlF3VCLFJVA
         wDIIf+eCKD2HxW7jAQ5idegVJLB+6et1wIURJo552U0JMzX0LJn0frkHaxLRsw4JXZqN
         3BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765146222; x=1765751022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w862P9gwDeWHrowG1HizWcJbg4rpsvYLnk23PcrduI=;
        b=OMbWXhLQb1VMN2a5xS7RcEtx+WLx3V/YTYLr1Wjg+Hv2JNpFyZPrVikwL2Qch6Sx1i
         zHX4qFZTVS/eIifBwmNqxlQDuUFvaXcilQh/QeVt32TfnYTZy8P6bRqJeOZ0CAkb+471
         VpuhBwMbMYZj7vcG9++6lh41/taOGkMfCSPX3bVvCqcFtnZfjeW5VBRMkiFIbuCVtlmZ
         5LQqsw8RAw2xYE9zRIZEmGcsykNs5MFzuDhEel0WVpElHlqc0rcTWbg0dY71DT+FbETJ
         r3L7dFHPcy23lIf/nNf4npc9NmPUK9nZd5qV3Xe5KG2UamJLHMBsRVS5EV6XyxiTEJNR
         SKKw==
X-Forwarded-Encrypted: i=1; AJvYcCUPZgU0+ECdhMEIO7wOLfEosMZKVQyI/fNnQVsoL00SI6oyr6KoWk2ItcMSHkBS7eVdeG4coTYfMYlRocf9EODzR4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYb68XgmaLinpfWPTiQPrNOekdS5h2Bptef5UQy0colDrOzNkj
	TnNXKEbfwCM01gfKy3tUNHNS4SwbG3lQNGSlXMiwC6Y3qEPm0rRrmfOg
X-Gm-Gg: ASbGncugTgH+Cw2fACHERrJGcJwxkIKtojR4FfqzDSsF6Xagqw3JtXPxNadJ8hzxckA
	Ebfq/l0IA0VVnGLi+Tax8go8MAbkOrd3WEGu/fzgUnGbJw2WK5tVJLePVOmurq556dbuHYD+Qq3
	VoMOEkfh750rFdZSfd+bNHJHP98hcJq2oYPQpxiTroSUL/40Sibt5fe1DxCY68eMXvnnwmFzu1P
	PhUCmijaTG0jBtDZVmBcyudDX2Dhc7zEorWyNVlGU8oyZdhh3giENf5o4l2lwi88f4yZ6+D0BPK
	Eb1bu0ug4W31WsUYt8YQ12ex/Op8odHwIgGyMXkzrtAV8Crpf7ztJhVQrnfCm2UhPOXM80JPcyo
	UUmompAnvwKqUs+L37dfN9StTF4IhBnZpbokmDl7QMKv3ybPp/Dsaho5ebzWZAaIDw+kD4OwWaT
	E=
X-Google-Smtp-Source: AGHT+IEm2HK0eaJoyNa2SSzEora5+85e9+DGsx6tJi0vt33FJbGSHrWsG8eiRmYxrXpGu63DFLG+Fw==
X-Received: by 2002:a05:600c:820b:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-47939e043d3mr66573745e9.14.1765146222181;
        Sun, 07 Dec 2025 14:23:42 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226e7sm22659293f8f.27.2025.12.07.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 14:23:41 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 7 Dec 2025 23:23:40 +0100
To: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/8] uprobe/x86: Add support to optimize prologue
Message-ID: <aTX-bIYKXHOFXv21@krava>
References: <20251117124057.687384-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117124057.687384-1-jolsa@kernel.org>

On Mon, Nov 17, 2025 at 01:40:49PM +0100, Jiri Olsa wrote:
> hi,
> the subject is bit too optimistic, in nutshell the idea is to allow
> optimization on top of emulated instructions and then add support to
> emulate more instructions with high presence in function prologues.
> 
> This patchset adds support to optimize uprobe on top of instruction
> that could be emulated and also adds support to emulate particular
> versions of mov and sub instructions to cover some of the user space
> functions prologues, like:
> 
>   pushq %rbp
>   movq  %rsp,%rbp
>   subq  $0xb0,%rsp
> 
> The idea is to store instructions on underlying 5 bytes and emulate
> them during the int3 and uprobe syscall execution:
> 
>   - install 'call trampoline' through standard int3 update
>   - if int3 is hit before we finish optimizing we emulate
>     all underlying instructions
>   - when call is installed the uprobe syscall will emulate
>     all underlying instructions

David, sorry I used wrong email.. I think the update here might
be a problem, any chance you could check?

thanks,
jirka


> 
> There's an additional issue that single instruction replacement does
> not have and it's the possibility of the user space code to jump in the
> middle of those 5 bytes. I think it's unlikely to happen at the function
> prologue, but uprobe could be placed anywhere. I'm not sure how to
> mitigate this other than having some enable/disable switch or config
> option, which is unfortunate.
> 
> The patchset is based on bpf-next/master with [1] changes merged in.
> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/lkml/20251117093137.572132-1-jolsa@kernel.org/T/#m95a3208943ec24c5eee17ad6113002fdc6776cf8
> ---
> Jiri Olsa (8):
>       uprobe/x86: Introduce struct arch_uprobe_xol object
>       uprobe/x86: Use struct arch_uprobe_xol in emulate callback
>       uprobe/x86: Add support to emulate mov reg,reg instructions
>       uprobe/x86: Add support to emulate sub imm,reg instructions
>       uprobe/x86: Add support to optimize on top of emulated instructions
>       selftests/bpf: Add test for mov and sub emulation
>       selftests/bpf: Add test for uprobe prologue optimization
>       selftests/bpf: Add race test for uprobe proglog optimization
> 
>  arch/x86/include/asm/uprobes.h                          |  35 +++++++---
>  arch/x86/kernel/uprobes.c                               | 336 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  include/linux/uprobes.h                                 |   1 +
>  kernel/events/uprobes.c                                 |   6 ++
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 129 ++++++++++++++++++++++++++++++++-----
>  5 files changed, 434 insertions(+), 73 deletions(-)
