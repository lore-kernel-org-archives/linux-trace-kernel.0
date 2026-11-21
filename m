Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257315;
	b=cEpxytFIY9i4qwYJ7zo+PzXtsioFT74r0kJF3vtOpOy6nbLoKsLZ5ZFxVOACxCl+3/Pn
	 X7aOI4V0W+Gmg0MJB9Aj0nTBVzLmkeGurrnh/EU/SMKCskA6/K3dBKkzq6g/+xPwh6Dm+
	 7jXlQdTOTy+2ikj8ClL/4Vg20Oue+aY3BZRY9mAihI7YEajccTRtL42QJa9Ayv+tnnawL
	 TrntUnQkg3VTDEmufA+G68e6G1YcWfb1MLg+udmzI0t0vynLFacJqL2dRqUaxrwxnCuTp
	 lQUHk/kppD+lY8bj3PBK31FJDY6KmjmTDVt2k8EDuy0W+obMRn4t6+piaHBl+5e6kVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257315;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=9bsvYKUqqiIEmbO2aiAG3E5Ax6t0fNk6OQ/rRTGZEtM=;
	b=saNS1UEX3x9Qy60BA6IDom4VpJJ/F2FD05Xli6NhFjK39V3FM3VcDNJVbr5YefJHe8IM
	 qeKHfc5fpSDx3mPcnD9oFpV4wwjOxxWtSSiYJ0dab1PtFOeXwx0uXeW0UywX6JiBTj6PC
	 WwYuqnmSsQSwzEcXEURH/Jsc+UjAEoXV2/aq4+87w+zIiuJd/zhlqyJdzlbbYxKmBKtZC
	 AG0MBBYGpRGXox4D6cOSYX+5dAIu2XliBQTq7+K71cvJrWv2s/YqYssCTTtadLOnBBysk
	 ZhKY0BOHqQWjEpmKkkd1EkyE3Vvaj+n5OeLn0dAYcy9vHpddiTZEQipoFWHzbl7qfHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="T06V/NK5";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836B606A320
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 10:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5836B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T06V/NK5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795257313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9bsvYKUqqiIEmbO2aiAG3E5Ax6t0fNk6OQ/rRTGZEtM=;
	b=T06V/NK5+dY7JdHwvdPwQG8fzDOLDWPMkf/lRpaDG95YoizlwQc0kJMdv3bgQu6AyJjqr+
	OLVUjH+zk1SGdk6p7pYXwARhx6bYHMvBJG0mjcqLMgxZ2s2jLbef0f5fxAu6G3MMJ4Yzch
	Sv406BK65IXypEE9peNczxOaiJFdCnI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-T02rfSsHMu2K4Zyurd6UhA-1; Sat, 21 Nov 2026 10:35:11 +0000
X-MC-Unique: T02rfSsHMu2K4Zyurd6UhA-1
X-Mimecast-MFC-AGG-ID: T02rfSsHMu2K4Zyurd6UhA_1795257311
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a7c864000eso919963f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 02:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795257310; x=1795862110;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9bsvYKUqqiIEmbO2aiAG3E5Ax6t0fNk6OQ/rRTGZEtM=;
        b=g5/Wey1UjGtah/Vq6u9e1fE3Y3/oUwxU08daJH2cwFvyLrXbmxoUvtyy5BsEkut2oi
         sYrkX/hpPOCbByBbfN6n59UwwxsJ0ThDv4e13t8dyWYLVgiYeJTr6TCC7lRq32vPsRs7
         RwvhGMNDTRusUBumLF0DO0SjcE5ZD9A9lRUbFDEAWl/kQNioKcrD7lWJhT1x06k5J4mU
         Kva06xVNDb6U/9c/mlgN+iTS1ufCeey7jk5Dx+giN2E2lZg/llNJPrl29vMYGaTW8tA6
         Cxm73aUKPM0bQ/X8Gxy3J//y5c4IH3vdDj3sjZMvYk3PUsz43oPgsdIDkSJfyf+wkcZx
         W77A==
X-Forwarded-Encrypted: i=1; AL+hErFgdmWuBfgB9FPOCNA3hKhNebFDeey9brJkitgzeko29Vp9zBfTlSTwV1+wnkBJWnAurZsugDJe1B+hDuoBK0YJzvA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9nuhP/i91m5rYncyDMcWS03WwCTuK3+wvBiZG5kV5/igK2ml2
	ubi5z+eqXxoszID1ZA+4gm9iR71k1AR1sNt5CXtwElgKPAfRrVeYHR8AEGvLuJ13XhcPV3eOhk7
	n55ThpRBX2ToTZvuCA8tUyKd1tt1F22hEYk2A1KmyFFZqIEaMB5oYFL1zA5f/MCQ7ytO8OboMQw
	==
X-Gm-Gg: AZFdTZdLchSNtbP/ved3bUhH9nUI9PbQrtqrJ8d0OJlRIdHFy51ecMFeqILBXCTeqSj
	20h8YjwVedbkUVpOiO9V8xX0vU1uui0o4NKxLTKY2U7WihB6kmKjTQpl5UrRUvDPMl4C9gmBnof
	25YK7XoI6OOAwofqeX5YRMAS4fVqFy1+lSHNFat5Ve38YWhQDTdGQ7O9dT3oB8FXp/nbVRYJ6sK
	0fFNqvnaWsZqrHCtZdJ0Gl6SDGQ2sa31XbeaNYSPkAWPA513iLyDKT8oxFdZLAkLJYc7jR3mo5c
	frm23Y2Cd3OLxNYSxWL5fUedjdKF7BnL9LEXDhQYLqksP3P6CMr31Vh6BCSUc7Z67skWWnuOQJl
	H9Nei/8j+HD5PzeKPJSQ0IiurtsWI9TJ/pzu1T1VHohp7R1omzTFd3Z4Nr7bmpTQek5HdtBRQgp
	j2
X-Received: by 2002:a05:600c:1389:b0:4bb:7347:d5c0 with SMTP id 5b1f17b1804b1-4bb88826937mr123102015e9.9.1795257310563;
        Sat, 21 Nov 2026 02:35:10 -0800 (PST)
X-Received: by 2002:a05:600c:1389:b0:4bb:7347:d5c0 with SMTP id 5b1f17b1804b1-4bb88826937mr123101795e9.9.1795257310278;
        Sat, 21 Nov 2026 02:35:10 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm165089265e9.5.2026.11.21.02.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:35:09 -0800 (PST)
Message-ID: <6c3fa853697803c63e2b87c7f8a9d4ff2f561820.camel@redhat.com>
Subject: Re: [RFC PATCH v2 2/9] tracing/sched: Add IRQ preemption lifecycle
 tracepoints
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
Date: Sat, 21 Nov 2026 11:35:07 +0100
In-Reply-To: <20261107171252.25090-3-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
	 <20261107171252.25090-3-kmehltretter@gmail.com>
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
X-Mimecast-MFC-PROC-ID: ng0eTUDZ2pDO_YGtSEdZEzOS1fpS6-uzVljADu9k7Tc_1795257311
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-11-07 at 18:12 +0100, Karl Mehltretter wrote:
...

> =C2=A0asmlinkage __visible void __sched preempt_schedule_irq(void)
> =C2=A0{
> +=09struct task_struct *owner =3D current;
> =C2=A0=09enum ctx_state prev_state;
> =C2=A0
> =C2=A0=09/* Catch callers which need to be fixed */
> =C2=A0=09BUG_ON(preempt_count() || !irqs_disabled());
> =C2=A0
> =C2=A0=09prev_state =3D exception_enter();
> +=09/* Sample before tracing bookkeeping can change the observed context.
> */

What's this comment for? You're tracing before disabling preemption to sche=
dule,
what bookkeeping?

> +=09if (trace_sched_irq_preempt_entry_tp_enabled())
> +=09=09trace_sched_irq_preempt_entry_tp(owner, preempt_count(),
> irqs_disabled());

I don't think you need to check the static key manually, arguments are expa=
nded
inside the trace_##_tp() after checking it, so you can just trace here.

> =C2=A0
> =C2=A0=09do {
> =C2=A0=09=09preempt_disable();
> @@ -7664,6 +7668,8 @@ asmlinkage __visible void __sched
> preempt_schedule_irq(void)
> =C2=A0=09=09sched_preempt_enable_no_resched();
> =C2=A0=09} while (need_resched());
> =C2=A0
> +=09if (trace_sched_irq_preempt_exit_tp_enabled())
> +=09=09trace_sched_irq_preempt_exit_tp(owner, preempt_count(),
> irqs_disabled());

Does the owner here makes sense? Do you use it as the /initiator/ of the fi=
rst
switch? Is it only to match it with the entry (although, as you said, it ma=
y be
somewhere else, running again, or not running at all).

Thanks,
Gabriele

> =C2=A0=09exception_exit(prev_state);
> =C2=A0}
> =C2=A0

