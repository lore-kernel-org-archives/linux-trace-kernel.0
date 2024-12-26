Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE6198853
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Dec 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735254090; cv=none; b=RvvFZln3KcbM9fCcY+i0nHV4MjT0x1EbNP7QgjUAEG1uOECh93+Bq+kOQ0jhHsibS33gmyK/T21n0o0A20qnH39a+4XjyKfb2FkgsloZ4Bml5VG/BB2YcD4xtRt/KV9JqC8CRoR6X3fbQCjiDTGp6y6H/RN3nf+bjZX9ydujLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735254090; c=relaxed/simple;
	bh=l3LfCSw34LI9hiP4+YmiSU5XDk8QeFclo5ZoywKRc/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyJzYuUswnQB4VcAOP4ser2eo8XjG3QkPyoYfnH6Iw4BRsLWYmwz9Ti385VuXfZMImezYorVkSBy5/6kGDen5PrcbYdYCR6201+Kf78IAAXycVNguDo5b5SgPDy7yt/qeSZCC3IkFTzNQGbJkzgHIfh0FE1Wzim6l5BrP2BmLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xlv9GSt6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xlv9GSt6"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so1189574466b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Dec 2024 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735254087; x=1735858887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEATQMkfGbTb4fOsLXh4qamgDY3PFH9/p0eJJt63Xx8=;
        b=Xlv9GSt6V3C/U9V2SMDE8cqup8RctsxUWyd1EsBZYFhVUWtukQUzwl2ZppO9skZ3LL
         H89GdSwYcsR5eUsYNKmGP6nBvravpn7QHMmLDwlOc/+fYfl59K/VnBrwItlpjA4WsBUk
         okDGln6NCdNEDgRptWaIrLdkI/kJHTXTcQKXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735254087; x=1735858887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEATQMkfGbTb4fOsLXh4qamgDY3PFH9/p0eJJt63Xx8=;
        b=kZ6uKnWKTEgwJF5q9zaCravFmFO9WZCE/iOS6t+mF3uxufIk5JCGfVN65y9vvpJYi0
         J+8HY7jDDtof9ozzGncKhQpJeEqPQN38R4JaptCk9MKM40yrs/XXZOEXaJ/xmPBEqGj4
         sh954PV2vT2GfTagtL9+68gh+Du/25uYule8Q1jrIJASbF55yuGnIQlSvu6XcW5lJzzG
         0CmUegTTDq3P3WRKWEZdA3URMzj/u/Zo1iSG+gKQV8NUQLe9Lx/J0A0LK3BiU+268ayF
         8M0oFF75/AZ16gdmy0KtmN+RSYFZHTvB3TRTuAIyiDY4l4B+8B1ptAYrYIMYH4S13yTu
         zuiw==
X-Forwarded-Encrypted: i=1; AJvYcCU7lEXR7drDOIR7SIiUUNiNLqdFuHftzYtWFY0YItR4mG235dw9mBWIn9B+DsZyRT9djLhgIseObL6DOlQJ03lh1Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzps0d+DSgedYcbUZAAygCIIIdfmA+CzurfUNLc9EAM3SVIQrKm
	7h+Fg7Ppkw8TSkhw9AF1WQaoy2/8X9A4Xa8aJ9XENTzo/ZMy4m1Rm1Ywz6/AX59MIwuaG+ejDxl
	8AiBPEg==
X-Gm-Gg: ASbGncvV94mvu0dwFx1WbXwduZz+DBosIgA+RI71Vp4z++n3HilKGZLy1hOK/HsHZZG
	paJO/qpwSjZojnmqEW7pSapHqsv3xQt+C9spbX/MRdYWjzUuxZBHdFEvPQABd93tA9pPuQW40qL
	KexbpKSl10zI0iUyb07qauJEWl7YWn9WgdxnvoQXz4hw2cMgpt/uNzezDC+KSlXeYYfJphZVEai
	NdA4U7OlFzW5jLlWfa1En3VEMJHz2yHC2BPSLyZsRWa2a6gENUQw2D1/oUTarygcm3IKo+vJ68b
	o7IKDFE9cqipP5McqARU9td/TLGCvag=
X-Google-Smtp-Source: AGHT+IEZnJNPVvRL3Ef0CR2K2iFJi0sGB42FG7W3KsFFmLIElCxiXrlj0MUy0PWQug66sYa5axuvaQ==
X-Received: by 2002:a17:907:1c9e:b0:aa6:6276:fe5a with SMTP id a640c23a62f3a-aac3465010fmr2016275466b.43.1735254087312;
        Thu, 26 Dec 2024 15:01:27 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8954adsm1035522266b.64.2024.12.26.15.01.24
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 15:01:25 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so9507529a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Dec 2024 15:01:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9Y7g0cL4Fig4g2akzR9z118UJj9vJkxXtcZ6NP6QMDRe6F5cv/nOKHyj1ElpB7KsG4s7wESOonsbdid+MKL+DFdA=@vger.kernel.org
X-Received: by 2002:a17:907:2da0:b0:aa6:5201:7ae3 with SMTP id
 a640c23a62f3a-aac3465011bmr2079637066b.40.1735254083855; Thu, 26 Dec 2024
 15:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home>
In-Reply-To: <20241226164957.5cab9f2d@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 15:01:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
Message-ID: <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
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

This seems entirely unrelated to weak functions, and will be true for
any other "linker removed it" (which can happen for other reasons
too).

So your "fix" seems to be hacking around a symptom.

And honestly, the kallsyms argument seems bogus too. The problem with
kallsyms is that it looks up the size the wrong way. Making up new
function names doesn't fix the problem, it - once again - just hacks
around the symptom of doing something wrong.

Christ, kallsyms looking at nm output and going by "next symbol" was
always bogus, but I think that's how the old a.out format worked
originally.

But "nm" literally takes a "-S" argument. We just don't use it.

So I think the fix is literally to just make kallsysms have the size
data. Of course, very annoyingly out /proc/kallsyms file format also
tracks the (legacy) nm output that doesn't have size information.

But I do think that if you hit real problems, you need to fix the
*source* of the issue, not add another ugly hack around things.

             Linus
