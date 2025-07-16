Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6922D7B6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676724; cv=none; b=SCr7jTdXRjBANKkAwGcX3XpwboRqlt5OX/aDSglwBQS+0zYGQK6uWGzkZqUV6+CuvFxWLRXxDeEFLd+I2KdYxU74J907ml9P13r8Kly7iGan6JelvAQxwja+/ZEnQn1owZlRXwMK20fTy1lC0ATqv/YchS/rqgvJf5q2kH3T4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676724; c=relaxed/simple;
	bh=pootL239b8vihYx7ghu2E071YuSYjSAykBGJJk4PkvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKcCZmDfqgfhT28+OL5YvkrsallDQoyhyuI2JiyfkLrSZV7sySI1bco9t+TnWHUMWpjamFoc12MuFnCOxIIoUguq8AdsU4+N0FeO7vheEmDaISk1FVxeW635ggBB3i4iYUlOkJxuBZOFGDDX8H1E2V29k8Oa36jjWjaC14UvVC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TctwJdec; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TctwJdec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752676722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pootL239b8vihYx7ghu2E071YuSYjSAykBGJJk4PkvM=;
	b=TctwJdec+rU5yDFT+RzcDjngZ4y3IsNcq0lgeUOPOF9hhlNbG2itaxzYJwEebRmuUq69Yz
	bHIo/q/E3UzgZeO3+kZU8D/mEQZ9yxe+r+JFjGJF0ZGmwmDPD2g+tFx5QK8sGVLJOU/p+j
	tMs7/4uqRFTdmcivC5/BZEAzd2ILN44=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Un9QssLMPkaVY19TmxUlqg-1; Wed, 16 Jul 2025 10:38:41 -0400
X-MC-Unique: Un9QssLMPkaVY19TmxUlqg-1
X-Mimecast-MFC-AGG-ID: Un9QssLMPkaVY19TmxUlqg_1752676719
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so2653281f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676719; x=1753281519;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pootL239b8vihYx7ghu2E071YuSYjSAykBGJJk4PkvM=;
        b=IntOPyO2LLkd85IihXwMRGVbeOz0/1lkPfHOnN6cwX7BOlU0XS+0gVhdrEWEOLNs8o
         QqG6BGR2o7BoLT578+pDhWY/0WfEMbfTQXx4GMeb95zhtuYXPpweQr2gEnemnb4XHNrn
         LnlW6fcO4WC0ynuKQUas9b2o1xFXybTwAYonRsAsvmNt6sXQOGv4QfOQjujsg/QhpdcS
         O3MpK/7lWCjBcK4Qvjw5cN1EQEiNZH7Za/IJLSHuH4oo7V8jCRfs4M5eKlyN4lsYQd2x
         6FwN9K49F9BsK6dN04Mc9x+fTeZH7z1ZBQ0gqgduumsBYzV2vJE0sgIahRD7FjBoWOc+
         KK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNp4wM7rDdu+ldzo3oG+0JgsSRK1OQapLnvpXN3/l9GehUZK/0/uG8kdplpbxZUK1VQXuYDPIHG1yVqjTCdcnCOYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRmbBiv1AD95YRF2Dp4CLFTMHfHpVu215pocQ8Tw+9WAxYb97
	mATjVC5xCwznxuJnvBfK98rRP7V4PyHiRCbk/DnYAV1ETskYLKVpIuUfUtCR7bdNYNCJeY/aTI7
	3pnQ52MwNU2XF9KTL2wFbTokaGkcsi0Y9oAdlqQRJuNg4q56YTnKHCOGAZHXKRTKbu3ycm07t6g
	==
X-Gm-Gg: ASbGncuMkWn+Jpa1mTal7ECcV3fSRdQc2Rv75RJTftlk9qreg9svfr0mfxrRsVk3Bp4
	0zGvL73h2YiAW8q2z3+gnzLBUaocOxrru4l/OM97MaIjR/m0mMrnfx8XXlbekJ2quDqhSlA7Flp
	znvu89p/i84pJKg0hGdifoyiuVlA4IlrPNdWJ4S7lSGFyevCJN3TeouiDXEB7uCkJrvPgtY0Q1S
	woI5XbkQlNIbvd+IGYDPFzhQedDUUTxq7pguHltCO4g3Pg3aD3oYWksWRkjSV17+7rk5/yOh4Lu
	TPmaVV3klWh/edHCFtek4hF4MjEGJoM2Xcr+vjsusMvUZ0s3Ju9TRNyemCURzGo+iQ==
X-Received: by 2002:a5d:5f50:0:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b60dd54803mr2670865f8f.18.1752676719004;
        Wed, 16 Jul 2025 07:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFptKKgabK4YSBzr4A23TCNpKLWSztNfIHJhjjgHgXZXCD1z41s30Edp5+SqPDwLIWCpRXH1g==
X-Received: by 2002:a5d:5f50:0:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b60dd54803mr2670833f8f.18.1752676718428;
        Wed, 16 Jul 2025 07:38:38 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5f16a6016sm16163068f8f.69.2025.07.16.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:38:38 -0700 (PDT)
Message-ID: <be966ed3d4a7ace6aa430bbc5c16ecbff3118426.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 16:38:36 +0200
In-Reply-To: <20250716141958.GC905792@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-13-gmonaco@redhat.com>
	 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
	 <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
	 <20250716134513.GB905792@noisy.programming.kicks-ass.net>
	 <fe38ba0b9da0209bcc97c2f348f5a6b266991073.camel@redhat.com>
	 <20250716141958.GC905792@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fADkNjfWJoHtEJbGjYOBNXlFHR0xatRAAqtMiGhTjdk_1752676719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-16 at 16:19 +0200, Peter Zijlstra wrote:
> So in general I'm a minimalist; less is more etc.
>
> Even if you care about latencies, I don't see what that tracepoint adds. =
In
> fact, I don't even see the point of the .is_switch argument to
> trace_sched_exit_tp(). That state can be fully reconstructed from having =
seen
> trace_sched_switch() between trace_sched_{enter,exit}_tp().
>
> As for the IRQ state, if you see:
>
> =C2=A0trace_sched_enter_tp();
> =C2=A0trace_irq_disable();
> =C2=A0trace_irq_enable();
>
> You already know all you need to know; there was no switch, otherwise
> it would'be been:
>
> =C2=A0trace_sched_enter_tp();
> =C2=A0trace_irq_disable();
> =C2=A0trace_sched_switch();
> =C2=A0trace_irq_enable();
>

Or you could see:

 trace_sched_enter_tp();
 trace_irq_disable();
 trace_irq_enable();
 trace_irq_disable();
 trace_sched_switch();
 trace_irq_enable();

Where in fact there /was/ a switch, that trace was actually something
like:

 trace_sched_enter_tp();
 trace_irq_disable();
 **irq_entry();**
 **irq_exit();**
 trace_irq_enable();
 trace_irq_disable();
 trace_sched_switch();
 trace_irq_enable();

So as you said, we can still reconstruct what happened from the trace, but =
the
model suddenly needs more states and more events.
If we could directly tell whether interrupts were disabled manually or from=
 an
actual interrupt, that wouldn't be necessary, for instance (as in the origi=
nal
model by Daniel).

I get your point why we don't really need the additional tracepoint, but so=
me
arguments giving more context come almost for free.

> Also, can we get rid of that CALLER_ADDR0 argument as well?

Yeah good point, this might have been be useful to understand some things
(__schedule called from preempt_irq for instance) but it's a pain to make s=
ense
out of it.

