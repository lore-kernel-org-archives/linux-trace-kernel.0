Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F1E1F9A90
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459607; cv=none; b=Ghy2hUjSaAH3JwPIqcpGTTZoh9AiBzNxBsW+en6dmM6ddFNa/eYMk5m2WuwcIL4ZPM2y9K1Xypgw0pk1CzcNCnvdSl7HE/dRQqEghEhVHvCZyD1LBD6K1OWXgvKUndMt92OM+CxbUEaXiFvG21m9v/Kzxs9fhzi2tgw42WmuyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459607; c=relaxed/simple;
	bh=l2yRZ36y2wW9dvgVix4csSbmNDAJNiwmbO6uhLXvPm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oe7lPlSvxG/aPXPf3widSRNK6mDNyeV6fsG4wNvC1B7IUaF0KnSEb7YdPpfolFflBMxsTE5qWyjN3QB3N3x9TZNW40clObYMLRxEHDeRSOIfyhKxQT6IJd29S+lJG+lHMt1TC67fQ/DAGd2K3+ar2YcGyBpld2L6w+yztfwmQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gwZpeegf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gwZpeegf"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so12359174a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734459603; x=1735064403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ucYQz3pug45wlWkI5/rqDm7d8VUZXMh7k+KyEWxY/qg=;
        b=gwZpeegftA6CLxCNKk6lELmJnEBdX7H0jBk3hTlM/xKpnJoPjRh8yXN8EJVfSkoTJe
         XEYSi5lpQATtNFixduQzjm0OEYIoi/uL6+yyoian5p1se7HwSMNKhXLUSs8b7yGx3d/l
         m2Ol7orgx6b3jqjdJ6mTRoniwGd03rCPRthMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459603; x=1735064403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucYQz3pug45wlWkI5/rqDm7d8VUZXMh7k+KyEWxY/qg=;
        b=YBdyqCShIXbHsHobKbNHlabdEpEZ1czIeWEOK1/onCc2Tyk3dXZ3aue7UlhOY5wrw2
         KZlYZn5xt/glK8cMOLtg9rU5AlS+fX3nsdHSXtvhCW/Tv6AjgyFLJBjI+P7rXxOjaKf2
         LKOh0AlyGT7sDIW/fA06FXkoxL6k2kwT67y6LQDq2TurMB+kDbULtwu3arKZsTVMeggc
         tqN9JdYV54hOHa2ns1OAjNLTVcwIp9MSutRHVV0fxm8WrCl+zIpd+hn2R9d7iLgQeRaW
         GhO3zRAiYEXLvyg1kj/Um+PWegLU3qSptchNth7pHE2OPv3i/OGzkIwvkBsy3TYQ2aHh
         8q0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3eAZHMmALowZo6RchOxyGr87oslj5g17hK/yMCltAPcayXFab/hubngYmF6bysYLX2E50DyNOgjiCsac9yRaxEtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTFX1LT4qs7DGAi9h5TbbUiAAfHUDc+kffN5mhVuEG12S1feS
	nbyaoO/1Lhtg6Z1tzEZTNBv67u+ad6DshHznZeotA4fOLnm7MHbyFahM5HwZABcBcOTi9zeTZ5J
	0Meo=
X-Gm-Gg: ASbGncsq8UkBJ2FR627/HKC3mHKcAhtZZhWjVtN5hvf34fkT09RKTywEOZtdkch33/m
	vyOeeUHi+P3JoCGxREM6sSfeqjO4s3KHNbY9E7vhjaslVCMxkV7lXUDHHVC+AG9DMCfKmE20Thq
	MAZwJQKoit1w2T9ejqCUPCIPi4shD3nFMRKUk62Pno3d0StVW4NWEkBeBZSinOyPISH6A752ekn
	chDxNtDj4vMkME4Y3oq5ZmrZRjozXuaIuwhp1HFIaC9sCOoRI9+wiRGiUQ/E5UmUrysFWEsmV3D
	Fo7YMciEuLOS2V9J5OHlZIpt4woyvLI=
X-Google-Smtp-Source: AGHT+IFt3tsDujeesq1xGGWH3pG1119PdFCVt53fm5tyqizkDQDeOBoEQTbn4F5Vwvlo82ua/UNM4A==
X-Received: by 2002:a05:6402:2713:b0:5d3:d8e7:d6d2 with SMTP id 4fb4d7f45d1cf-5d7d556a03dmr3996384a12.1.1734459603284;
        Tue, 17 Dec 2024 10:20:03 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab604fsm4574752a12.2.2024.12.17.10.20.02
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:20:02 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa662795ca3so1271569366b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:20:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYwsNMnxjh7VVAFDY2V910irV2itypBQAulJM5iY6TMn2VgUqVBeNXya5RJBRboxbuGQj+W3gPSu9NWkgwywbXqoY=@vger.kernel.org
X-Received: by 2002:a17:907:d1c:b0:aa6:7ff9:d248 with SMTP id
 a640c23a62f3a-aabdc88c2bcmr443639066b.8.1734459601680; Tue, 17 Dec 2024
 10:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com> <20241217130454.5bb593e8@gandalf.local.home>
In-Reply-To: <20241217130454.5bb593e8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 10:19:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
Message-ID: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 10:04, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm not sure what you mean. If the kernels are the same, then the pointers
> should also be the same, as KASLR just shifts them. This no longer uses
> module code. It only traces core kernel code which should always have the
> same offsets.

 (a) the shifting is what caused problems with you having to hack
round the format string and %pS.

 (b) the data addresses are more than shifted, so that "data_delta" is
*completely* bogus

 (c) neither of them are AT ALL valid for modules regardless

Stop using the delta fields. They are broken. Even for the same
kernel. It's literally a "I made sh*t up and it sometimes works"
situation.

That "sometimes works" is not how we do kernel development. Stop it.

What *woiuld* have been an acceptable model is to actually modify the
boot-time buffers in place, using actual real heuristics that look at
whether a pointer was IN THE CODE SECTION OR THE STATIC DATA section
of the previous boot.

But you never did that. All this delta code has always been complete
and utter garbage, and complete hacks.

Remove it.

Then, if at some point you can do it *right* (see above), maybe you
can try to re-introduce it. But the current delta code is pure and
utter garbage and needs to die. No more of this "hacking shit up to
make it sometimes work".

             Linus
