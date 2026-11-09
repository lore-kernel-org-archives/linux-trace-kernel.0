Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216592;
	b=zqYyPyG2EzpAQLfrEW2IeSapq8V0TKs2Zh3cqzvq4pOBbWBzYI3JGvXYvYa+C9y9WwxP
	 fgfiaJTn6L9wW2w9iPQ8MLXiSvaWc/GrFZt9WoCxIHqXYCP8nvQZr7JeA4O9/KvUYH5bF
	 SZJNP0jzHZqezUwL1QzlEjIM8uulUY3RQqi/xj1wTFNzglP3lzqNCRxCVsyb9AuryRlqa
	 N30mv/X39f4XRUUsFQSHU+rbV4O2K29wsCISaoEfxG3083jSTdaHHezTWoOdwCHEaM2ZX
	 QgV5pWrDLe5BRTOkGQioWcVr9aIre/V5QGnWQ27HutN9DIGeIgWI3CE+I7OYHxyw5xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZXXc4X9dovkYM5a/fEThQZ7EDvrdJNyD5C3ugviYz/M=;
	b=mKnpNWdWYShKZWtws3nfCoTgynl+c6oaokwWCIZykf16ZGSymFMOsqsB46+F107oP/G5
	 SOpZfMxeOqsxSWOpu/OHJBtXQU1B+ZqLrpWIgJOgxImlaRh4EdZgUQJnTC37bmkXD2I8d
	 o0+iQf4ZHat2G/FTUlm95QVY5t3MonL89pqDT1btRix22gQ6WhemZesU/AXty0yv8z15M
	 UO078F/LcUgWTL1F42zw9hsnoMjoRe5QwzsiWv92P1eKX45dF6tuj8yZR7GMPY+cowfR0
	 RWrYRF82jcXqfnjmtbkl5RDhQAbLeGCW0U3X4+hu+luvViYKd3gJqPeb639NGPmsyEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RINbViMs;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA11606D83F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 09:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA11606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RINbViMs
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490c1d337d8so427621f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Nov 2026 01:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794216590; x=1794821390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXXc4X9dovkYM5a/fEThQZ7EDvrdJNyD5C3ugviYz/M=;
        b=RINbViMskdkdDD1XIUqS/5yIDdrgWUV2uqbKv1P/JTNHfdMRb7DnESO9HN3sHMYqjj
         2mgHa8SZADIfxxBG/f0Fhx1NBmXQ+K2++Xhl9Sw3/mB50aa+VOy7/5lGa1V2qYVDv7mp
         RO9j2MandVyl7T6UeaEpVKiO+QADW+T97aKb8aSMoM43DbFyfdd8wCu7Hk2NfWYfnJCE
         RqwOINassPtNSGN8dVTEsjiYLLP5mvsMPYzMLJ9vafUt9FaXcTerXob8AxoNhh7XZyg7
         duwWjIT6NKDvbvgffGSdcQTFGDZDo1DKzdkoQstR/4zknkoVqPKUfFhw4yBO9+noYFOt
         CZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216590; x=1794821390;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXXc4X9dovkYM5a/fEThQZ7EDvrdJNyD5C3ugviYz/M=;
        b=CqiuANQzOAqTdYTggl8T8bJey+be+YwaVogC8Q0IIx3JWTo7Tkqvxm3AV361RUk9f3
         HYZyczosh/J5lUP4TUySG1p7rGjvaiGp1TfJGJME46cCZ+8QSsY6OYSzO0gOsFUQf50E
         XPyCSzCZFf7JhzOPOLpIW/Sox0XpMfr3aFKMN0eJI3QQWvgyu2qffRf1wudXduajvkTF
         Ow2kfj5Go3jvEq8omSz0ZJqf8AhxOHnlkr2/f/jP97ZpjaQazDZGWv6in2QBlU74R1r/
         NBfeoif4v5c/XOcI/dt99AIyFWOxukTnYVpT0MK432hKLOqq/lXgY+yWDU6K7kvQr+zp
         DLXA==
X-Forwarded-Encrypted: i=1; AL+hErFhYV4HsGWf8OTbj3m8yApYiulHjShZWAHkclCCx/yZPZHfwYsB1eoeDTgOQYXHd48kWoRFrFZ/OTk8cm844Q1f/7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IPlk2d1pXIJgSsiumt/qj0WsYxxUletHBzQaVCbiMsS1ys/T0
	2Zekj+dlHWase2hQDQwqqEsNr+fM96mlg7I5KkIvB2SuyPbzpuZi8aqeYt3Z9kXqtQ==
X-Gm-Gg: AYBFou3oWcrVpdqU1/n6hVG8cA+MPn48gbBbf0mf6NAWL8eReeqIWTboJmdIDmEmrZd
	P0GfTRtYvIJ5T4XUpTnG4ICthD9kfegkyYwmgO9DlbAMB1zH1gseX4AXMlHXJD9Bkq2o6IjvLJO
	7/PGDSi57M54DODIX7uuGvisBZBJypUmA5bklBsrSAwh0lR6i7HmndR9pgOvzxNavrQhNZO2WbZ
	dqajb66AEFsLCa2ODn56clLgACjdA/ntSP0ijjl70i9qd9zbK8rxbdd3FUrhqsu7GTsOxTLnct+
	E+zN2AxAnJRuNIcKgnFWBiru2ZLP1g3ZrzNfownf72UVtN2CDW/fhjHugVUFaC1Ic3fHFmj7faY
	smuY+8rud7FOENTWOs7noEViSGvPMu/cZC6ExN2+Cz8ttelf7/i/2gZ0G7uS9VblrbIbJeQZ3bE
	8elB+vX5XPAGWlzNORhCkljYI/VDC5QhxtQ7LLgySlKDNWoOHuItdl0UrIQVQ3Kwksg8Sm4aIFE
	SyezL1UqJWvpXerVFFP4xdhKRY5knYoDxLa0jaOKiG88C1+jSHRnZ9HBRycA6oxsCM0+CLAwZeY
	Ru1Qc2rHHutYIpdAxKAPBWP35Nlb3KAnRc/CyyOPziPzPmpT5WseU+qr/EBo0znYczlaDUtLTHL
	mHxyP9GGsRw==
X-Received: by 2002:a05:6000:4381:b0:487:13f:f612 with SMTP id ffacd0b85a97d-49585401367mr7418535f8f.37.1794216589888;
        Mon, 09 Nov 2026 01:29:49 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959774736bsm9646558f8f.43.2026.11.09.01.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:29:49 -0800 (PST)
Date: Mon, 9 Nov 2026 09:29:46 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring-buffer: Do not WARN when trace_rb_cpu_prepare()
 fails to allocate
Message-ID: <avGSispr9aIXliex@google.com>
References: <20261104222558.863948-1-christian.aurichzm@gmail.com>
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
In-Reply-To: <20261104222558.863948-1-christian.aurichzm@gmail.com>

On Wed, Nov 04, 2026 at 07:25:58PM -0300, Christian Aurich Zanettini Martins wrote:
> Creating a tracing instance allocates the buffers of the other CPUs
> through trace_rb_cpu_prepare(), which WARNs if the allocation fails.
> But __rb_allocate_pages() bails out on purpose when si_mem_available()
> is too low or the task gets killed, so a mkdir in instances/ with a
> large trace_buf_size is enough to trigger it:
> 
>   WARNING: kernel/trace/ring_buffer.c:8094 at trace_rb_cpu_prepare+0xf1/0x100
> 
> The same failure for the current CPU, or in ring_buffer_resize(), just
> returns -ENOMEM. Use pr_warn() here instead.
> 
> Fixes: b32614c03413 ("tracing/rb: Convert to hotplug state machine")
> Reported-by: syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a707c4f.13bfb6d0.1ecdd5.027e.GAE@google.com/
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
> ---

I do not believe Steven is keen on this change [1]

[1] https://lore.kernel.org/all/20260806174638.6012fa24@gandalf.local.home/

> 
> Notes:
>     Tested in QEMU on 05441d697f7f (4 CPUs, 1G, trace_buf_size=350M): mkdir
>     in instances/ WARNs every time before and only prints the message after.
>     Same with a mkdir killed during the allocation.
> 
>  kernel/trace/ring_buffer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1fd28a72e6ee..c018559ad61a 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -8091,8 +8091,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
>  	buffer->buffers[cpu] =
>  		rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
>  	if (!buffer->buffers[cpu]) {
> -		WARN(1, "failed to allocate ring buffer on CPU %u\n",
> -		     cpu);
> +		pr_warn("failed to allocate ring buffer on CPU %u\n", cpu);
>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.43.0
> 

-- 
Vincent
