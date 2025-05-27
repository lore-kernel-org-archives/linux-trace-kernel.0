Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0E1EF1D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748356512; cv=none; b=ROuoTbokc1Dxq7J+DtbFMpmJLuOF2pxC5YGzSkh1wd8Gn46w/pQXPTn5KCR4DH/tuYQIkS+mrOkt7GbFnzerFPmjiKObI3RZ5a7NBQgNZa22xg1UQReEbzX3gXxqTibKjoCAwAfdceRTq1MrfYJRFgOs5Q15KT2ez7W00Ri+lyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748356512; c=relaxed/simple;
	bh=uLlDS7ehu5ldtiIWabFbrHv7rhtaxbfIJBQZqnhbKrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpZz5nknp3ChsBZpFKKNgUF9whe0JkxzMvP2qZ+pCFI7ERXyKtvEzkL87d8WXEHeA/YpaJdJw7aczNnSQYu1xub/O6OdMU39491rGeQwe6q/H0yTN8fOstrLJPz2+h+4zG8qweXcJ0cA/RDfsSqQ4EPUenUH/doz6skE0vP7/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEdz3oo+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEdz3oo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748356510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uLlDS7ehu5ldtiIWabFbrHv7rhtaxbfIJBQZqnhbKrk=;
	b=DEdz3oo+xIoue1SDfMxwRG9o3oB28AYLJX46NJ1IMiRPIRT0JjEUsyOlj7MApO3hJKITlZ
	XRfR/l7as3eitN3k/1b+j0wAPZiE+cEnyuJumpy5hesxE58l2wek0Gg3JAkitrPkroZCKy
	1Ncm8Jni2Njoi1HelXT4gKHmYuBFZqc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-sdAVJCYuNF6CyAhXxTOaTA-1; Tue, 27 May 2025 10:35:08 -0400
X-MC-Unique: sdAVJCYuNF6CyAhXxTOaTA-1
X-Mimecast-MFC-AGG-ID: sdAVJCYuNF6CyAhXxTOaTA_1748356507
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a36bbfbd96so1233096f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 07:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748356507; x=1748961307;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3GI2gbUmIa7mOJoCzehrNV7F2gboefZH5wJFgdPvXA=;
        b=Z0EpSfk71ealAvvOpGMglw4xXutB5qAsSCP/ZKBC8bpMwR4eBZXLWtJuKGuHUEU6N2
         lHdg0wsmeijs3ma6O1itPVcr2cMyUZHVR+rpOeBi2F8AXMUDzfCtV8STbZGK73wByhQC
         4attymLb4lVKHl/lJkCmmqnXcFhPNDcyKnAA9tZ83ym7eYuc28re0D/Q9YXc1Vh9WMTi
         L733P0npZ0XfQg+VRi1hQXytRdorU+1iBMBbR13+07TnypNYsOx1MGDNlI9egfugKuME
         lHUIkH0WaF5DELnpcnTcxuurNukW3/Tw4MDu51Kua9s0ss8xRbLbAVPo3EMP5iO61uDf
         LZfw==
X-Forwarded-Encrypted: i=1; AJvYcCUsH5vBXK0ZMzWTlQ3vwMp1zjhWmslVYhZepKVHDS6zOcTaHthjO2UmBLqbTCZCeAUBkvczxDEhv1FFIDkakMlgB4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB59VT/xaM0YEWcxIvIy1khndak/25X/dANdPz30FzPYygrmLo
	QuCuGt7xhgxpuRlqdfmVHhOH2UhBZwcTqoGF/j7dA2y1aMlj1z92oa2RYwa4JmDGkwI2ByObU5K
	rphBYkpKkWttajB+DzAi3/T3xjC09GsOENcCIUKY3O1Shi32o73PQiEs5isaPa14o5qqOb+3mTA
	==
X-Gm-Gg: ASbGncvMXmaECQuOuxTwRgZUi5oJIJgrwQQLPGx1+uT/dZD/09yFXN5P4zhjTGg6oXZ
	8dxii8H0BE+x26N0LqchWbu3VfTlx1rcw7XNz77grMuHdGPQWWWrn5cuwOl72rBylmIEm3v41C1
	poTTEIJnf1MU8ztYLT0C4+9BOKE5H3XYoJOBrrwH8Bdf8xUuxj0BSlQ//sNwREC97AzT86xflso
	cYkD8rfeJDSt0QFsBTahexoew759QJL33sFVhQ0vGQ36HdHTHV5ws+fdH3Ir0tN0WWYDqLYeoBs
	O3Nf9aTIz/jRoZECfcZqzR/j9ueclu9OF2uebQ==
X-Received: by 2002:a05:6000:178b:b0:3a4:d6ed:8df7 with SMTP id ffacd0b85a97d-3a4d6eda61amr8126388f8f.59.1748356507402;
        Tue, 27 May 2025 07:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRv/OfRRiDQA7X9BzrxYr9prABUS7Bh2GUtwtYTwY+TNdKzDqXiTPEpURBylbaeVKLg3wH2A==
X-Received: by 2002:a05:6000:178b:b0:3a4:d6ed:8df7 with SMTP id ffacd0b85a97d-3a4d6eda61amr8126364f8f.59.1748356507047;
        Tue, 27 May 2025 07:35:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d67795eesm7198027f8f.86.2025.05.27.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:35:06 -0700 (PDT)
Message-ID: <6f33e6b7ad296f4fd0e9c089ac92e53c08cfd850.camel@redhat.com>
Subject: Re: [RFC PATCH v2 12/12] rv: Add opid per-cpu monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Date: Tue, 27 May 2025 16:35:04 +0200
In-Reply-To: <20250527133712.CFW5AcNE@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
	 <20250514084314.57976-13-gmonaco@redhat.com>
	 <20250527133712.CFW5AcNE@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 0KI4H-47EDsYkYUpa4tcpUORn52Y9JHRtwppf1qvMeA_1748356507
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-05-27 at 15:37 +0200, Nam Cao wrote:
> On Wed, May 14, 2025 at 10:43:14AM +0200, Gabriele Monaco wrote:
> > Add a per-cpu monitor as part of the sched model:
> > * opid: operations with preemption and irq disabled
> > =C2=A0=C2=A0=C2=A0 Monitor to ensure wakeup and need_resched occur with=
 irq and
> > =C2=A0=C2=A0=C2=A0 preemption disabled or in irq handlers.
>=20
> This monitor reports some warnings:
>=20
> $ perf record -e rv:error_opid --call-graph dwarf -a -- ./stress-
> epoll
> (stress-epoll program from
> https://github.com/rouming/test-tools/blob/master/stress-epoll.c)
>=20

Thanks for trying it out, and good to know about this stressor.
Unfortunately it's a bit hard to understand from this stack trace, but
that's very likely a problem in the model.
I have a few ideas where that could be but I believe it's something
visible only on a physical machine (haven't tested much on x86 bare
metal, only VM).
You're running on bare metal right?

> $ perf script
> stress-epoll=C2=A0=C2=A0 315 [003]=C2=A0=C2=A0 527.674724: rv:error_opid:=
 event
> preempt_disable not expected in the state preempt_disabled
> =09ffffffff9fdfb34f da_event_opid+0x10f ([kernel.kallsyms])
> =09ffffffff9fdfb34f da_event_opid+0x10f ([kernel.kallsyms])
> =09ffffffff9fdfba0d handle_preempt_disable+0x3d
> ([kernel.kallsyms])
> =09ffffffff9fdd32d0 __traceiter_preempt_disable+0x30
> ([kernel.kallsyms])
> =09ffffffff9fdd38fe trace_preempt_off+0x4e ([kernel.kallsyms])
> =09ffffffff9fee6c1c vfs_write+0x12c ([kernel.kallsyms])
> =09ffffffff9fee7128 ksys_write+0x68 ([kernel.kallsyms])
> =09ffffffffa0bdbd92 do_syscall_64+0xb2 ([kernel.kallsyms])
> =09ffffffff9fa00130 entry_SYSCALL_64_after_hwframe+0x77
> ([kernel.kallsyms])
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f833f __G=
I___libc_write+0x4f (/usr/lib/x86_64-
> linux-gnu/libc.so.6)
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f833f __G=
I___libc_write+0x4f (/usr/lib/x86_64-
> linux-gnu/libc.so.6)
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 193=
7 thread_work+0x47 (/root/test-tools/stress-
> epoll)
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 891f4 sta=
rt_thread+0x304 (/usr/lib/x86_64-linux-
> gnu/libc.so.6)
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10989b clone3+0=
x2b (/usr/lib/x86_64-linux-
> gnu/libc.so.6)
>=20
> stress-epoll=C2=A0=C2=A0 318 [002]=C2=A0=C2=A0 527.674759: rv:error_opid:=
 event
> preempt_disable not expected in the state disabled
> =09ffffffff9fdfb34f da_event_opid+0x10f ([kernel.kallsyms])
> =09ffffffff9fdfb34f da_event_opid+0x10f ([kernel.kallsyms])
> =09ffffffff9fdfba0d handle_preempt_disable+0x3d
> ([kernel.kallsyms])
> =09ffffffff9fdd32d0 __traceiter_preempt_disable+0x30
> ([kernel.kallsyms])
> =09ffffffff9fdd38fe trace_preempt_off+0x4e ([kernel.kallsyms])
> =09ffffffffa0bec1aa _raw_spin_lock_irq+0x1a ([kernel.kallsyms])
> =09ffffffff9ff4fe73 eventfd_write+0x63 ([kernel.kallsyms])
> =09ffffffff9fee6be5 vfs_write+0xf5 ([kernel.kallsyms])
> =09ffffffff9fee7128 ksys_write+0x68 ([kernel.kallsyms])
> =09ffffffffa0bdbd92 do_syscall_64+0xb2 ([kernel.kallsyms])
> =09ffffffff9fa00130 entry_SYSCALL_64_after_hwframe+0x77
> ([kernel.kallsyms])
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f833f __G=
I___libc_write+0x4f (/usr/lib/x86_64-
> linux-gnu/libc.so.6)
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f833f __G=
I___libc_write+0x4f (/usr/lib/x86_64-
> linux-gnu/libc.so.6)
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 193=
7 thread_work+0x47 (/root/test-tools/stress-
> epoll)
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 891f4 sta=
rt_thread+0x304 (/usr/lib/x86_64-linux-
> gnu/libc.so.6)
> =09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10989b clone3+0=
x2b (/usr/lib/x86_64-linux-
> gnu/libc.so.6)
>=20
> I'm not sure what I'm looking at here. Do you think these are kernel
> bugs,
> or the monitor is missing some corner cases?
>=20

As said, likely a missing corner case, I believe it has to do with IRQs
(which is what makes this monitor more complex than it could be).

Thanks for the pointers, I'll try reproduce it this way.

Gabriele

