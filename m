Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866904;
	b=LGwfJvF1eH+iufbefMOGDvdoBb7PBVtdWLtt1yaFkaiHz/OxRGN6P0ATbghZrrBtw++G
	 AoS0qdSiwus2EJF+RrkUgFTCfF4pJO9ll9rJV3mDCYqVwQFIp/I07/xFQ7ZGhygfvbcTL
	 7mnl33iqCCmdrz6KzPvUNfaI9jOwve/RjG94bNGoI8++U3YcFtRBv2VUBKhP8PDCCyQ8z
	 N9l3+cjAhDS6cUgNvZE5YkfZTIf0jx1wSeIPuWp8sxGjfRXkHKrHl3h7muiezcoG7EMVe
	 tKmrSlwEGYIU8ZHKYEwZHqBHqxwlJ/NpSu1idLiqoRzz52mcefiOtnIJ6SxBD5I6fKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aYcr/Vbck1ztUmS15ZTJlw73vVEYDKhMroKfUy1hlew=;
	b=ENiiCf7bIbcf4FWC0/Hh1PE9BAIhqLUzQfDwnC7mUj9mhmu6ddbV9HbCk1/PTjpIeDXM
	 SN2ua1VYzbLlTXkVrr6Vcu5KcoW9fyphFvoqG2HsaOInCBy3hQ4HcMt8vV9Bpo0gMoy9a
	 JThx+KxES0xwfVEobQ03F+PzT7StkN0AcaYuYFY9Y+Eu7uG+biHC/ZwbalyKcE/I5DcjO
	 RYZv7wBpnzQ2QWIB74ppp+Hwc71w/ONhMT4n3FdqUSAprhdhYSPFgSmNF1nV/q3Kj+ZAv
	 xZv5Fi1Ng8ZQ7A/gVcgEFlFepSV2PngSe1w+IdtIpblBfZ2UbrmJ6DYwyaQddjC3+Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmabmFsJ;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860AE606A31C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 11:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 860AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmabmFsJ
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so59089805e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 03:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866903; x=1796471703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aYcr/Vbck1ztUmS15ZTJlw73vVEYDKhMroKfUy1hlew=;
        b=BmabmFsJdICXPiXcElnIe1TFv/o26HwlXPW87Y3amLlU3xobT8vLUI0LHU0ruwO1fR
         cYJOtu9/Aw+LgWS6Gbue3B/Qep33qVgKS8Rw+3OFFPJ7V4MCx47Psgay3TJMIhhw3nin
         bmoAXRjBMLeQZNr+UjhI4DYYwUstfHd5b4OlWqM1nT6Qjo1r49lTSTW6i4jjxIGj7iDo
         2b0c14Ul4qIhk+Z9VlQ96cqjdKCHUEHY8L4wkQdhBWqpetzJN/hlKeMQlzqnEdtPokbX
         aqPdwKUX+D0wW23gg6jpFMM1QJTagyzW/Sl0bKjPNI9BVUzmyE0T4PvDNu0qrTRGdPM1
         ou6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866903; x=1796471703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYcr/Vbck1ztUmS15ZTJlw73vVEYDKhMroKfUy1hlew=;
        b=Wctv1LkZAEGdyRbLLIlwyXSgadtUqXWaoXx0gLPwIi9FgaOWjZLe5+wbXJB6d/85K7
         vSYtfkZ8gQPOCKJBtY8AOGKn07jkaP/iXSmE9mAptJWg2CoBC5w6L/ie2Hnfik2ZzS7R
         c4nmiSsC5ypcqe5a+Tkxvl48YF0ntB4cNY8CEfjd3ZcYLDtZF2r6xVNb6YjsHG4cdPyL
         +/kFgLbwOaTBa6mC2mWbzlIkB9ZDUtXlcj0ep/L9QuE+WKm8EnDxl6cu6yrKVGzFHC4x
         IoUxvORv4kinGO/624Am27sdQEV++jCQnPe9EV5JFVvEB2xrUYoPXGTffOsDswfUt3OB
         3jNQ==
X-Forwarded-Encrypted: i=1; AL+hErGCQMxtNG3L9PUTbgX0CohfNCa/XYiClrmjVQFVejFu/bEkU71JzkoAmvrVCiqhR3fXczb65iji3JT/BtZKdNuvKNM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ot2ttPc8IsLK9BiJAZk7l1bFxlVplu25z8jURpJre+xMW6LxJ
	DmkN/WgX5sb8VIY7spmaIs6jq3QwCrVTs8ICHOPgW42xnjz2Z84HBqz1
X-Gm-Gg: AZFdTZeiCEuHKG1qnorQqwSBWDtijxe4Q9gHW2Te9Cvd/uOuvTmUgLQVB+ge1nPOsyO
	uu6gyMABZTVD/7Wz99U8jqAUV/dlbe1imfpuxQM+8t3yCirg0Rj0YUxq439nFTFpmv4fC1b3M0U
	Ed6TjAACYzofceqDaS5E+QOV+zq3lXGxqEJW1XuClg3sTgbZkpE5Se0TBTsjSZyV71g8GkLRHFY
	NBEUTN22S+YBp7CNImpccqjwVVhW1aPAMM7+sB3/bELdAE2vAOZYNAIAQQhvurz10horBv9pxUZ
	TlBiC2xsAE4nlqG6fCnx74zTOgWK37uU9ggdSBBwqKWvBQdfgo4BJV5xEaqvBEAQQvaLTcl1nVJ
	KzjlHzHy88PYQJ5jslfl2ja1OO7mmxe6wek3kMVepoCalM/mq9nxtzyFWABOEg4dQPSA4vC0Fy7
	QpGiRabIpkE0PqxY85R6tAbO4gOCZy1bGDOS89djarSaLClnSA+ylmuX1vTpN5BODJRbhnxJkfB
	/ydlOIbt73Q3QdNJRkZKR1J6cX288JZXfYjZupz1mGSrlJLu6omIUcuVJVkKXf3FmRMr+x7SA4x
	diZQSB+iP5Bew3v3PQZHcefSFJjRK2cLYalVQSaui7OOrI7GdKIRwNa2mi3rwUjSQGIK8iVPVvO
	Lc2oMcJAwj2UkejcjKaP+kYHIMf8qxuFPLgvT+DsidmImx1oTafjZXc+ZPWk6nlLS
X-Received: by 2002:a05:600c:1da9:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4bb88819294mr573223175e9.30.1795866902705;
        Sat, 28 Nov 2026 03:55:02 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-095-117-034-170.95.117.pool.telefonica.de. [95.117.34.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm634936515e9.9.2026.11.28.03.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:55:02 -0800 (PST)
Date: Sat, 28 Nov 2026 12:54:31 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/9] rv: Verify generic IRQ context transitions
Message-ID: <awq_lh1x7P6NQrx8@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
 <9419fa94de8acc8f1ae445004b77d20d0be3e98e.camel@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9419fa94de8acc8f1ae445004b77d20d0be3e98e.camel@redhat.com>

On Sat, Nov 21, 2026 at 03:23:08PM +0100, Gabriele Monaco wrote:
> Maybe, you could somehow reuse the __schedule() tracepoints and understand you
> came from interrupt context, but that would obviously not match the
> interrupt/preemption counts, although they are (now) guarded by a BUG so you
> don't really need them.
> The loop should work fairly well anyway.
> 

Good point. With the BUG_ON() in preempt_schedule_irq(), every irqexit
check is already enforced elsewhere.

It seems dropping irqexit and its scheduler tracepoints is best.

For irqstate, I injected faults on arm64 and x86_64, with and without
lockdep, and went through past IRQ context fixes:

- Its only unique catch was an injected traced entry paired with a raw
  exit.
- A leaked PREEMPT_RT serving-softirq bit was reported first by RCU or
  lockdep, even with lockdep compiled out.
- It would not have caught any of the past bugs I looked at. Most were
  preempt_count disagreeing with lockdep, irqtime or nohz.
- On a Raspberry Pi 500+, it added about 73 ns to each
  irq_enter_rcu()/irq_exit_rcu() pair and had no measurable effect on
  hackbench or locktorture. PROVE_LOCKING added only 12 ns to the pair
  but made hackbench eight times slower.

How do you see it? The results above only measure detection beyond the
existing checks. Is irqstate worth a v3 for other reasons, such as
running a model of the IRQ context rules on production kernels, or is
there something you would like me to investigate first?

Thanks,
Karl
