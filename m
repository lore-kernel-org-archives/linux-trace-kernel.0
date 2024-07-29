Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F80149E09
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257159; cv=none; b=CMuysi7x0kXW5U8ebLGDx1XyXU0fep0+Md++1Nm9NW9hfp6SbIeTwUiQen74G89X+TXBIGJuadvJkYPnPI7zqcv0GmZJ9F0FZrnvOL5MnXepAxNC4nY4opAPtg2qQgnmRaRT5MfpFyLnHPy9xttdbrV1aQHzBH6yAUczXKzhLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257159; c=relaxed/simple;
	bh=+8434lN6ua4CcFvv8st/GhvaYrStkp0uclRD4U2eGv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pf01H3yMahls9G95FGSFS2iHSAUh7yIQ/vtxc1Vjziu1Qm5qVIRSlWxDveS6fpiNe90RKh2QE8upD6t5+lbbEH5kF5ZMVkQo4SXNvSTLzTWjE1XSWR7MDMQLkEcO+t3k6t9rTmjmKYS60up11fau0ynWqjVL/RCCudln08R4ti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0j2aVwqa; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0j2aVwqa"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4f51551695cso1123616e0c.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722257157; x=1722861957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oZgdZG91J97JhZAPZXIGBxb7mC3XZ4lMKL0buOQ+YVk=;
        b=0j2aVwqaQuWsFJI6gJ8oy2ni84NX5jdyxl46nTuALihaJo6QtrOyOGPUjpnkB9Xo3f
         MyPLKpfHw1/RryGvIZNbOyiWKKMC3JHWr85cmkyvADKb9c1JHBqSG49+nSK+tl6fJ3bL
         Uq26BWeDlU2THsT1+DscNV9CTvdgrlbkBz2Bjuzr2rV2gxvuUUoanGeKA86oDMopYF0K
         eqGbt8Nenuexsvle8oWTfOuon2wvlKTJOqiSZIReoFeWnq4kFdTntMKqPvZDkIYpft7z
         +KEg5k5IwYR8XqKzgUpAyXnQG3d9tMd75jsgbCsdPpjBALJMPVubD88hAIrLbl874cVf
         VqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257157; x=1722861957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZgdZG91J97JhZAPZXIGBxb7mC3XZ4lMKL0buOQ+YVk=;
        b=qYJaWYQkyOE38wkVhi4/uj1cgb904u568CR30JrkGZJoBNywc380y7ZCbNE/qv1tzu
         V5obw1NFhZkqCQoVSBvDcMv4QA1mfmYjF2WCdKY3ErJ7PoTCILMrYgjpLp3sK3S/K1kc
         A3NUTvSImu16VddBpenVARDlxUas8cKAk0r16kFVu+xISPQkAn7u5qSSeTRPHWeNPeCQ
         B7glYL7Q2vX6UkzrTg74biIhhWz/LCuvQkP5p8HGABBLmRnQ6Z4crrfIuv3YQ6O/JL76
         RQt5jAUQcW+XwkrouYFKRAPoNAll3q2ZbAP0plcemvoJ+TKcIswsT2Rp46qjm9ZnZ0Aq
         +nXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgLMJVCHW9YPMb9WneZyJh88AHNzZKx04HAI3vHJ5QYAWekcwuo9R8ZuFHrPuiExml7aY9WpVLhPXxNIczKdHIgCMn4PuaEjyL1rFSc7bWxzbz
X-Gm-Message-State: AOJu0YwlqpZEOXg3CECfiT/TDHIno3pXZg5rgmibCP9j/A/wdUxze3HU
	fS8pAofd1ljm0x1Trv3PZtcmmQ5t0uWvDzCBVVzm81tpYz9p2Zl2EwGdoTyyL8D4TfrR6sajwjb
	1B5TkATJbMMLklL4U0DMrbZ57EEVQYj+BuWZe
X-Google-Smtp-Source: AGHT+IHmnfE1ygzY/qhGH4DKTImqmNpWMjOFZPler9WZ32cIt3tMKFcZ4e9BHs2Z3oXOtRZrptJpw5lnmnh2EiHF8no=
X-Received: by 2002:a05:6102:32c5:b0:493:bf46:7f00 with SMTP id
 ada2fe7eead31-493fa61bdf0mr8035840137.5.1722257157146; Mon, 29 Jul 2024
 05:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729114608.1792954-2-radoslaw.zielonek@gmail.com> <20240729122726.GA33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240729122726.GA33588@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Mon, 29 Jul 2024 14:45:19 +0200
Message-ID: <CANpmjNPrHv56Wvc_NbwhoGEU1ZnOepWXT2AmDVVjuY=R8n2XQA@mail.gmail.com>
Subject: Re: [RFC] Printk deadlock in bpf trace called from scheduler context
To: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, song@kernel.org, jolsa@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	mattbobrowski@google.com, qyousef@layalina.io, tiozhang@didiglobal.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 14:27, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 29, 2024 at 01:46:09PM +0200, Radoslaw Zielonek wrote:
> > I am currently working on a syzbot-reported bug where bpf
> > is called from trace_sched_switch. In this scenario, we are still within
> > the scheduler context, and calling printk can create a deadlock.
> >
> > I am uncertain about the best approach to fix this issue.
>
> It's been like this forever, it doesn't need fixing, because tracepoints
> shouldn't be doing printk() in the first place.
>
> > Should we simply forbid such calls, or perhaps we should replace printk
> > with printk_deferred in the bpf where we are still in scheduler context?
>
> Not doing printk() is best.

And teaching more debugging tools to behave.

This particular case originates from fault injection:

> [   60.265518][ T8343]  should_fail_ex+0x383/0x4d0
> [   60.265547][ T8343]  strncpy_from_user+0x36/0x2d0
> [   60.265601][ T8343]  strncpy_from_user_nofault+0x70/0x140
> [   60.265637][ T8343]  bpf_probe_read_user_str+0x2a/0x70

Probably the fail_dump() function in lib/fault-inject.c being a little
too verbose in this case.

Radoslaw,  the fix should be in lib/fault-inject.c. Similar to other
debugging tools (like KFENCE, which you discovered) adding
lockdep_off()/lockdep_on(), prink_deferred, or not being as verbose in
this context may be more appropriate. Fault injection does not need to
print a message to inject a fault - the message is for debugging
purposes. Probably a reasonable compromise is to use printk_deferred()
in fail_dump() if in this context to still help with debugging on a
best effort basis. You also need to take care to avoid dumping the
stack in fail_dump().
