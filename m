Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA0494271
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175567; cv=none; b=Fn5S7joSFFmGX/pDoVFV5JlZFymjAoKVEcMwqsg7pcCwUN8bfc2cFPqdiFhOaj2SlDMUpA1LmrSkSbiVZZlkdmN2ykFOjeGWTPK5XqPTqC8QbRwWC2lXIrI16WYdv4PvzHnBhflc13h4RV2eI/hWgakiulxyCsG2RkX713hXDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175567; c=relaxed/simple;
	bh=V2E/yhEZzQeNxMqnt0P5cG6VMozPSfQrlO7FbeSChk8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=M42tSFbWgF1B1UDbeINjCnglQPc5JJ9jnrMVITf69chadkSMzOAy9mz7GWVUEdskFYkDSkxwedx1yVw1mn+9b9Lu5MvMCM/DDGFWQcsfrxPybuwB7qqjIaqWNEEY1LDeoYwwmIAiutyObi9g81fsnZ+olsOoWhg4Z9Alp4n+hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD5gn8D8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD5gn8D8"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so154145a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792175566; x=1792780366; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2E/yhEZzQeNxMqnt0P5cG6VMozPSfQrlO7FbeSChk8=;
        b=ZD5gn8D8TJoOUMTW9QeaCxTaO83fhuMtup2923FKFzNIsm8QG+T654FjVOQf8Nn6lC
         LDJjeV43GZIkuQbkTpLTYKDWZhjODxBdiZA+yeQQ1md30jn8xXEeBGujxGo+voZnoZxy
         brJncbnO2Mik9TP3bHzCz5bBTGHpPVlNF9nf3tDYO7G30l9DOj9BqQEBjjIFWX8KZL0m
         JaMITv5348J10meCNu4e/jaOlQZh7CCGd1qnJ7uBvzM1rxvjodU4iFIS9z4/extC9W1/
         Y+uG9TDTYo3Fx0nAMJr+D3prkldZsdBbjIRw1hDj25HEJeGQmhyOT5p8JMgi37RhgCDL
         d5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175566; x=1792780366;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2E/yhEZzQeNxMqnt0P5cG6VMozPSfQrlO7FbeSChk8=;
        b=MSGBRffHehkCNs5YSSOsMj0hfzT7ZmvrWc7USUB1jIgtCLIEalkYmijwv3O1E/wdL8
         CcEBKIFpwwfpK/Pr1Goz6WZBtATphNYGRC8byJcA+UFzEaTtNHcuA28/xjSWufkn8+/s
         avN3nOPCot+IQE+5sn07tNREL0YpK9tbLfvILZFXibFYzYCzeaU+9+jWsv9RmjaxPoIw
         9G34vvEh5+OF1jTNWRH0igeYJonsstvAERUOTBNlaSPYWDDYZXGMtv2tQuHA63A4fvHr
         MUZ6tnADu36VFu3TwaPYNjfrTPH69szo79cSjMrbjGzQnNQ1emxmlbkT4yUK9q2CVBEc
         sMZg==
X-Forwarded-Encrypted: i=1; AKwUvBxZiEDAUZ/Sqi4RF+K+J2LMdCTimQBL8ofV2LUdzzb6ImA68Gx1lSga2EA6+vfyODFq3cmjqes6Wb0EqDRiugvn9uY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6OU3IjM0bYYVuzCHsIbNkPO5+J28y2bQpMN0msNY+4svQcCfn
	KXUpbjCwEMTiIdfSs7sElUVYvZTblXnLTgfFTMW465VnpqjsIWhIVxpu
X-Gm-Gg: AYBFou1BPHh99XDwvAmARJxgqdNN8QXJQnbWKMEwHKz52TP6P2znKyGr0RKLGoxT55C
	caW/2wMjkKrejJWrcQdelcjokXreJXkl86nSBkSWQkWYFaK1rsjzpW8hI4X9H3kYaZ1mbvXr+Zc
	jVOJrQdeXLvJmRxkZfjaujtnkKSNoMTov1xKuE7xNJhqy2FLLWWwNBdtxM259TusP8hwAcl75GA
	Y8JNWinxDqEb5vj+UFZ7vsWxUwTMsqEH9lN7IiLi+F+8ooerXQWEQb/CCYwsXGzOVPgNa9gQs7Z
	P6xGG4e17sPs4qJWuZRJD7PqJQkJ4UiWbQ2XWBlWUytFiZG4HsROB2k5qHSuPg4MCAC2kZRfqIg
	cth3l5FcU/JWn4uRxKf7+q8nFl4mbtBnWLNVflQ8ugoWBLJN/ci0fESqbdqXTDXs+F7ZScz4vMz
	oXlxp0qHX9/7GBNkSU9CnR9uws1oxXuZJg2z/uAmsaI0kp+4KxwN/VsUZLLYwaZNLDUe5btelvF
	9nCOw1n2p6/Tau+EYuPXMEd4WA2EV/cylXtUUPfaFXLM9pyFsLeOHklOBqRMhIffNLGyT96Q6/m
	PFo0affLo4vjtA==
X-Received: by 2002:a17:90b:2ccb:b0:3ab:be66:ddc7 with SMTP id 98e67ed59e1d1-3acef134be1mr574089a91.10.1792175565793;
        Fri, 16 Oct 2026 11:32:45 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm2768789a91.0.2026.10.16.11.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 11:32:45 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 18:32:44 +0000
Message-Id: <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
Cc: "Nam Cao" <namcao@linutronix.de>, "Wen Yang" <wen.yang@linux.dev>,
 "Tobias Schaffner" <tobias.schaffner@siemens.com>, "Viktor Malik"
 <vmalik@redhat.com>, "John Ogness" <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
In-Reply-To: <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com> <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 11:54 AM Gabriele Monaco <gmonaco@redhat.com> wrote:
> Reactors in this patch use bpf_printk(), which is in fact a trace_printk()
> instead of a real printk, is there a technical limitation forbidding us to
> create a kfunc using some flavour of printk_deferred()? Or am I missing an
> existing one? (this need was brought up by John, Cc'd here)

No technical limitation, and there is no such kfunc today.
printk_deferred() is a lockless store into the ring buffer plus irq_work.
It's ok in any context where tracing progs run.
The closest we have is bpf_stream_vprintk(). That's stdout/stderr of
the prog. User space has to read it.
rv tool is around for as long as the monitor is loaded, so it can read
the stream and log it anywhere like /dev/kmsg.
If the message has to reach the console when user space cannot run
then the kfunc makes sense, but using bpf_stream is imo much cleaner.

> Not needed in this patch but potentially required for more complex monitors. In
> kernel, when timers are required, we allow monitors to use hrtimers (precise but
> heavy), or the timer_wheel (lightweight but less precise).
> I'm not aware of any wrapper of the wheel in BPF, but I think a few kfuncs for
> these could be useful, in general, also for other programs needing a lot of
> timer instances or simply light timeouts.
> What do you think?

I don't think it's needed.
bpf_timer is hrtimer only, but hrtimer vs wheel is not where the cost is.
bpf_timer_start() cannot call hrtimer_start() directly.
bpf_async_schedule_op() does kmalloc_nolock()
and irq_work_queue() instead.
I don't think timer wheel will help.
