Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420744;
	b=3Cx2dIrwJEFbaoDnTUZAQT+jxcWFTm2bjN2vrdOXNYd+xvq0pqe8XeouZhRb9+31x8Oh
	 mgstOKX0fmEZYsy0MkbIjuvkFuY+jFrHIxKZD9iGZysufqlJ/Jcuu/bj+jhMwshSNidzC
	 CqktD2nv+3j5ZX3nohNhI4EPWflFsO2z7zmqyRBa5Nu1vxNhxAaXwIiWL1gsCvLqgpbaD
	 ALh/hQ12m4PKBOzTwR3oOMv4uDH3uASqWnLyLDwqLHofyDOGJm2TwKv858gcKL39kMxSH
	 1lDC2EFCVCQWWf8Vzt0ZCga90LXaMjaYRcnW+gsxHAwdfxkOeN6f2Qs/KkbgfjgNSGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420744;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=W+zsJJ1aBB5y23DhHkSQAtsEWnBqQa/ccFUCBqopeOY=;
	b=SrsNst/mNSqZwe+Zd79jgDqiYlxS2bIzbAUuC9Gkl4g5YSqKELx+uJ6XzwTf1YSuiINT
	 K96RDJ1/kbGLBei2paxRZSc0VIoDyujiXclvcoSUrnao9585H9B9tqyyJGwSa6W6MgJ2J
	 5YbKztXqoROoiKVLVmn7yQkXilOPBLfufviJpM8Hd7p+A/RGhNRkiTbDLO5lpwa4d9Rgj
	 Sv82W1SzVOdigOu6Qdz0vf4rxzUQp0GmLVsZDYi+Nw60kAlyg3plEudemri5XkObWFOqi
	 +JxX93XaBo63LCOMAwXILuG/VaRXIYtUsdRlBJBdskmO1L/yJg7+wG2IYrkoX7OsgSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QISGdT3k;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06AA606A331
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 07:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D06AA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QISGdT3k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795420742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W+zsJJ1aBB5y23DhHkSQAtsEWnBqQa/ccFUCBqopeOY=;
	b=QISGdT3koEGTFcYByJZX8zPTULxzW7fGETNvivrXfNYBNyK4BH45wd1/PR4X7kNMYwrTJE
	3lAiJgiaKq66ISBPGqto8dyRQyJ8ANbt7l0HC6oWFAwqLUOsbUTL51pwDuxJ0vgomhXrIV
	Ckpc9r1wjEmSZllnwzZ8pbb5rOHXGMU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-O3Y0tXrkNUyU83GUrS_ysg-1; Mon, 23 Nov 2026 07:59:00 +0000
X-MC-Unique: O3Y0tXrkNUyU83GUrS_ysg-1
X-Mimecast-MFC-AGG-ID: O3Y0tXrkNUyU83GUrS_ysg_1795420740
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso20106615e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 23:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795420740; x=1796025540;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W+zsJJ1aBB5y23DhHkSQAtsEWnBqQa/ccFUCBqopeOY=;
        b=yZaROK8GeGNhV7ia/3n8Lc02zvSKrrYCGM+UbFevb/RCbMlgf6Jo9HGZfzPmBUjltD
         pc1OwYmNiH4+uVrdBwSgsd2nOeq1aNf+Tg6o1RcO9Gr9hnMNE9lvxJKmTtCvPyrWULN4
         qgR4G6QU3ECSj3dmNBQ5ffzVpPTUgm/cNZ58847FZxUinuje+jpPQRiWdZ2AIap6EhE4
         3cYNnJf19QTnEMCdiM9++RiepcI/L/G4D5mphr9/XP+q0q+YRvuoQGPuUcQsxmcRuUXb
         q9Gw0q7kKJj44nqRC64Flv14lBaHSduBcGLhKnv4UxO74l0IJnVbhMu3mG55JDdrQmUt
         uSgg==
X-Forwarded-Encrypted: i=1; AL+hErGD6nXmTrsgeZgu28qF3Xbxt02akNE4cL9fsZj12+IOjbKEuIcdBNQu5KJZ9nVFtEC1LF2tfLL25d18FZ9gHegLSO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1jMxzlP+lQjmLjxU1tNN27XPZLn/mbKCSDIm/RYKlMQV1F1sP
	HYy71iI66vRWftSiglZryfbexMJCQyXwb6nCPn95Ek4sGxzOTHSuITFCqcoIagjgFcVzQtTuISh
	VdAOZ+cxJBlR/kyDcjaxHDDpOvdhD4HXypE3QIky1RQKUkhohcxZUoG9Qa8CvZHUnamHRfJQccg
	==
X-Gm-Gg: AZFdTZdFzuG4OplAOrm9ZnIA7xh/rrVO1DKZ2wppHv2ucaxZq4vCqQKKxA0cHNp84Z0
	yku6vPFew04PNR7JyxZzE1wYswFcUAsvRFl312OuFOG08ex8VdrkS5ded42pZFOPsbCa3N9waH1
	cRmKZBS7Y0ZLUatudAnAo8E0sS+b2IbOud6i8CvnGejeScqH6HZ84R253OERrP5o+ljtSpr+rCA
	VG104CgSrsMFfZIhjUmzktjaoojSpqc4V6y7i5G0btihfntgXVlhyP3QFVCt6h075sDWtBJfgbZ
	G1zeUOUHdoIge7NTV2uSOtWj65xWaCGLLcASS/TSGWS+HlErlGlel8OL8XHfVNs9X0f7cscS8Q7
	SDb7/6u3uVo41uRgGA6dktjZAIjQORhIhUCDmSBfikhBuYcqfU0gBG2Cajk6Hq5Xl8KMe/r+wFW
	Wt
X-Received: by 2002:a05:600d:82d0:b0:4bb:818d:8d8f with SMTP id 5b1f17b1804b1-4bb88818955mr254816235e9.23.1795420739751;
        Sun, 22 Nov 2026 23:58:59 -0800 (PST)
X-Received: by 2002:a05:600d:82d0:b0:4bb:818d:8d8f with SMTP id 5b1f17b1804b1-4bb88818955mr254815915e9.23.1795420739428;
        Sun, 22 Nov 2026 23:58:59 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906640a2sm148906565e9.0.2026.11.22.23.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:58:58 -0800 (PST)
Message-ID: <b8c1ad21d862b1da1cab0f5370f3a2885501e9f6.camel@redhat.com>
Subject: Re: [RFC PATCH v2 4/9] rv: Add a monitor for IRQ-exit scheduling
 ownership
From: Gabriele Monaco <gmonaco@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers	
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@kernel.org>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Ingo Molnar	 <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Andy Lutomirski	 <luto@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot	 <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,  Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>,  K Prateek Nayak <kprateek.nayak@amd.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,  Randy
 Dunlap <rdunlap@infradead.org>, Wen Yang <wen.yang@linux.dev>,
 linux-trace-kernel@vger.kernel.org, 	linux-rt-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 23 Nov 2026 08:58:56 +0100
In-Reply-To: <20261107171252.25090-5-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
	 <20261107171252.25090-5-kmehltretter@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IdLZR9_hczHtq3NDskX2N9A2bzKVfo2LYr1t0xEjQ3w_1795420740
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-11-07 at 18:12 +0100, Karl Mehltretter wrote:
...
> +static void handle_resched_entry(void *data, struct task_struct *owner)
> +{
> +=09da_handle_start_run_event(owner, resched_entry_irqexit);
> +}
> +
> +static void handle_resched_exit(void *data, struct task_struct *owner)
> +{
> +=09/* Do not hide an invalid return behind enable-mid-invocation sync.
> */
> +=09if (owner !=3D rv_get_current() || hardirq_count() || !irqs_disabled(=
))
> +=09=09da_handle_start_run_event(owner, resched_exit_irqexit);
> +=09else
> +=09=09da_handle_start_event(owner, resched_exit_irqexit);

What's the added value of this logic? As far as I see from the model,
resched_entry is only available from the initial state and reschd_exit
is always going to the initial state.

You don't need to set both up, since both are equally likely, you're
eventually getting to start the monitor anyway.
But in case you really want a start from both, I'd say you can do:
* resched_entry -> handle_start_run (we are in init and handle)
* resched_exit -> handle_start (we are now in init, handle next event)

No need for any further condition.
Or am I missing something?

> +}
> +
> +static void probe_resched_entry(void *data, struct task_struct *owner,
> +=09=09=09=09unsigned long pc, bool irq_off)

Do you really need this level of indirection?
Just give all arguments to handle_* and drop the probe_*

> +{
> +=09handle_resched_entry(data, owner);
> +}
> +
> +static void probe_resched_exit(void *data, struct task_struct *owner,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pc, bool irq=
_off)
> +{
> +=09handle_resched_exit(data, owner);
> +}

Thanks,
Gabriele

