Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967E27447
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735270542; cv=none; b=g2myNOkD0c1WmgF5c18CBbhNK3zytA8jxUNniRx3Nx/gVlbOlWyjXBR9u10o/ZH/IZNPajaxCTrCGgmEWVnuAb74dLfZbSsZ76j246k6L8P9rCEV24JlI2RdUn0fcY4YEGahhh7hisLTYAEHLgVzgDybRweeOsnwQxL2A/9hlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735270542; c=relaxed/simple;
	bh=AGXTRv0LmVHEZMilybwu6oh4mQ5OUxVnd/fQq8fjrEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoRdzhH5d+IMn7aZIgMUkSb/eWRsiA/LDWx69wuBxVCApLv45+uFdp9Sxzom0zuYAI+375S27B4GfRMr5J6yq8aiGFb+FgaiWI1IWn/dzcV2yuJFZ+ZeLDO1gOxUcKDJ9UPp1nMcD3ae7quDoNtOjsA/YwoSin0iIqjcyqw6ItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c2J5VW9v; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c2J5VW9v"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so9442604a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Dec 2024 19:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735270538; x=1735875338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zv2Kquny1rwoCYildgERHjuaVV6RvgaxGbRxpY4LP4I=;
        b=c2J5VW9vQctG1E1fBAaLse7/4XRW6Vj1ANFp/SMSbmL11OxYHGnCmaK7BfvGxSZVpi
         NiWXMWxodTbrj0DBqlBknFQzGwwmKFxO+1pVrO6kyTosT/wpZjej8LvePIrN7SEB4Xb3
         lE3/8Jtki4CKBNEBFJsa9T5qZv4ytwwfoqm18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735270538; x=1735875338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv2Kquny1rwoCYildgERHjuaVV6RvgaxGbRxpY4LP4I=;
        b=HhwUc47fRD3DQ7v4t8P2EPcxmdkBUoDecO+Ea9Mx1USZWD1V23cXIB7kYAVoM3+0w/
         Xlfkd/ieQxkoI1GpmpAMjUe9Zi49dBud8eGG6kAbcZA+GZtQK3JJKFgWQ+umtxJNV7Ya
         VU5EwCNDcoP+T/blC2/1eTPC+RFLI0sdPSt7PM2fysJv8zuTwLeWM2NXym4ckKIZqVLk
         TgeQIu4urbjRJd6BKW69dx0Vkmpb7aHQUg7svVwaJbhmKvi0h/MEvas2MAqNo3MJ6d61
         EkzKcqYHEe+RbzNDV+cmHGq8gFcd6qz1viPMHthOTwyKhUjLAF5e3Z87baMZJvxkThmN
         jMOw==
X-Forwarded-Encrypted: i=1; AJvYcCWDtJfrdAssxPuAZUoQL/0mJvPQ6ES1eHXNIy6/BDVdCakndLjnWKC/72Rhu0ta7StiJ3N3CpqWt/KK8zBRgY5cIFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvljaunRQ7YLe99OibD3YYFIPty54G8498MfFV5kx2j0en+jE
	/Bp/jCJzH9HTEV6tOpyH++5SrL/CQ5QWrOC4wlZC6zKdJxFpmWHVrT/kp1XzMmb+sHKvAb2pmQt
	xV2rqfQ==
X-Gm-Gg: ASbGnculeWwfgZAjNtuSgFR5RDUv69CSi/e3NE2KOX+WfmppVfVbZGh/zRoN/Dp1/vI
	Pd9xObPN+AyTVQvsq7hD0ZCkLWdSYp4dH91V8uYaCELqjTyubg1wRhHZOrGktck5xfPjRB4XBCf
	UDMNgGlEMdDU7mq1GyjUYmtsZ0AyjTn/x11nUnsHIlx7Oofwk6pNENLzCumNMzztsrICoC6eDEH
	e8zHRRwr7kvRq66kN12AJfM1Xvz7vWyL2JeY1KKd1zKwyAzH14HlaDzL5gRX1q33TWlGR5Otl3L
	ialDFBqQW5bc0zwr+WVlqcHzt+cL2Wo=
X-Google-Smtp-Source: AGHT+IFRrHbcshoZSHbKWYxylYOasD4pO728ehT7aVHANq1b10IoZ14eGp9dUGm+uIC7x01AspSCag==
X-Received: by 2002:a05:6402:34c2:b0:5cf:e218:984f with SMTP id 4fb4d7f45d1cf-5d81ddfbd24mr24208041a12.27.1735270538521;
        Thu, 26 Dec 2024 19:35:38 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fed4e1sm10433165a12.70.2024.12.26.19.35.35
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 19:35:36 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so9681057a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Dec 2024 19:35:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4TWH68gA2jA84w2gEB3ku+rbJSyIZ5WePq/3+3AFOVqCyQZ3QaT2VYP3TSfNR0///Ovv5b3j2hhhFSOchVS99VKg=@vger.kernel.org
X-Received: by 2002:a17:906:6a27:b0:aa6:9fad:3c1d with SMTP id
 a640c23a62f3a-aac3464881amr1926490766b.39.1735270534947; Thu, 26 Dec 2024
 19:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home>
In-Reply-To: <20241226164957.5cab9f2d@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 19:35:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
Message-ID: <CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian <zhengyejian1@huawei.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Dec 2024 at 13:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But then, when the linker removes these functions because they were
> overridden, the code does not disappear, leaving the pointers in the
> __mcount_loc locations.

Btw, does this actually happen when the compiler does the mcount thing for us?

It *feels* like this might be a bug in the FTRACE_MCOUNT_USE_OBJTOOL
logic interacting with --gc-setions.

Is the problem that --gc-sections removed the function section that
contained the weak function that was then never used, but the objtool
thing with create_mcount_loc_sections() would generate that
mcount_loc_list and nothing realized that it's no longer there?

Or does it happen even with the compiler-generated case (ie with the
-mrecord-mcount and FTRACE_MCOUNT_USE_CC)?

We can disable LD_DEAD_CODE_DATA_ELIMINATION, if that's what triggers it.

It's marked as experimental, and it does smell like either
--gc-sections is buggy, or we're doing something wrong to trigger it
(and I could easily see objtool rewriting object files being that
trigger...)

                  Linus
