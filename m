Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256812;
	b=QFIewV7UNRQoFLCCRf/2O4CxDVGKMkjs6r65VkSqtFbYBhtUsrrogctUrQhNKavHVcsO
	 9iVywo85X9A5Sh5ptN2DXXPMl8VvRPPLVjblQlAZsKUuNhKE0PJEpiuUiwvCKV74VUGY7
	 S5xYKFeQRG010I8NPTV/fA3hkKZzo4V+Z/OIgzr+wbt66PtrENQuWGJCug0v1MKhsmeai
	 XBJXnMPsp0jQCQwTC6qQ6FcMLivwm6KdCQKzfpGAaMq9mByoJU4iwFQdWhy54df1z8BIZ
	 liOs09oGFFUyUQHyBo88dSusq6XkkPUtdB+KHZyYpNr3JyJ7g5t9OY0BCoKvfpcpkTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256812;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=o4cYPm4nikQRXCKmajkr5M1HuTe4y5SdQDfgOMYEdEQ=;
	b=4b/P7AObVBOCmr4yZGjnO9jWTPgZ6Wg0IGLjupqnMXlJ+ALteQpcgf4D4pQr7rKPcyyR
	 Gdu5hQOUEUEhErnX3Xn+IRYfZlFNf9txQFR1FKxRsj2DFppLPfQobIXjpCS48fRFEy8sk
	 wS+NvORORJVv9xKhdap8Xs0RJS5AUILVwfduPkCh4eTk0/eiWEHATkTYceoh45iJgJyOw
	 8cdcfl9IeCavYyDJqlAlDtcRz/cU6zqg2d50FJcltMQ470zCxikj7hSWthDDo85i/dhCB
	 KUDtTsbGQ9sxOOTwgkAOZJhYSyEPlI+fj6VCyA3sM3NhCJHQE35dbqnsUvpjQdidXBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XeNov71o;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAEE606A336
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 10:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEAEE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XeNov71o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795256810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o4cYPm4nikQRXCKmajkr5M1HuTe4y5SdQDfgOMYEdEQ=;
	b=XeNov71o6EOWp0iX+Li3Rm855GqLMGD8GgpbXXzzp2K5siBqDPtXuaxRmK0MRW5IYj49rd
	jUmil9HGscPzcQCSnloxpVoWRqEtTV+aaHwxhri6d2dg98DGg0oKdqbTXJWokH2PC0pENk
	LKawPFmFAue4FNeeFWT+4Lsfhy7x4B8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-S1QN6fshMais8e6vEsH5yw-1; Sat, 21 Nov 2026 10:26:49 +0000
X-MC-Unique: S1QN6fshMais8e6vEsH5yw-1
X-Mimecast-MFC-AGG-ID: S1QN6fshMais8e6vEsH5yw_1795256808
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb8ae35aeaso11793335e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 02:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256808; x=1795861608;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o4cYPm4nikQRXCKmajkr5M1HuTe4y5SdQDfgOMYEdEQ=;
        b=jU5odPJbAkVh/bNdFNx9lTwF2hUKg5NRSJeKBtjXIfdVr7eMSKK9nDP0+pFa+AI4Jn
         sTe1WUgPZeblY2vvHTAEUFxN17WsbsIUet9L2LWjcIqVFvfNySLi4/+Ya8Bof3Z7pNOC
         qiW0wIP+7rL48QO3oCFRhbKZvsMwdabpGjYlhxu/cphCoy+D00o7Eax5WuWzcABfykw/
         7CcNUe/Yt+XeMqf3ExMrlG6Ik1Oz39jjRRE/BrhJ2yq54H/LIo3RsTqZtY++xuxqXsQV
         Ntww1lbo8xecMhpL9lplU6s7aZPhU79blMJQqEAIVfysCO4LkpOWJQDTSgXjQ+W1wltr
         lkzg==
X-Forwarded-Encrypted: i=1; AL+hErGIHo4hc+WaOaKHmzW5rVn1wrOM8rVkpZsEOkw4ZxCmRvahYhDBI88XPYiGc1fy4g4fIlHGg6w3xxqgRGtYg0h2y78=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ppXTl3Ka3BLYPp+Q4pC2vsO0bw+qvaFrd2QY+3FofGuiEqXLR
	EUOzRm6GsGiprHpAvL/Q05ytTljMRCMVXabCwRRAXY5RClGsd4Lclms7Vihm8FUri3r+IICAjlr
	VmqwkdG8d2yYqQnVWblmRTQkBt2VjB68vc+tYZd9ztAKaeV1Yqa61cnebDTQqGtUmBSn499u1WA
	==
X-Gm-Gg: AZFdTZcC7WAUHiP2/yejx1i+opfGyUsnFsVvDSiUxZc9pk2IQOvRh3zk/XfV3m99pTE
	nR+eOSzu1jWp8zq1qe+U2JCNHv3gXX0wFKzDxh4UjxTAEyGDzpPTmtGHShUA8HAtIgqsCMP0O7b
	N4H98kykLMI+NKEbyVj8OuCpIDcjSWwfFZEj6DXDjxH4rr0kBpLjufOgjaFWBOW3NdUCkq2b1kU
	XKKEHIuNxgNCYl1hM/bw9rAujivf0EWa64OR8YDBZ0XQ5wzcVLwozO9/zSiWlpS3FYRxORmMYJ7
	VkTNRK63AmeGXSLZ7beCkRQP9TlKuWjZWOY2THWVWOxlzseQR+wc8ubAyCC3stabVOoJ29sWlbt
	j+rGa72WrqNGM1rEIgzWenNWA5Q3bhSj/BWlxh7bwsRmFQOzgZ+6mARWGwtVLSEqPDC62j/uEgK
	o2
X-Received: by 2002:a05:600c:5306:b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4bb887c9af4mr131050305e9.4.1795256807699;
        Sat, 21 Nov 2026 02:26:47 -0800 (PST)
X-Received: by 2002:a05:600c:5306:b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4bb887c9af4mr131049895e9.4.1795256807347;
        Sat, 21 Nov 2026 02:26:47 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9065744esm39169705e9.1.2026.11.21.02.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:26:46 -0800 (PST)
Message-ID: <661a3aad86b215989dfc916fa9f568c66e18a466.camel@redhat.com>
Subject: Re: [RFC PATCH v2 1/9] tracing/irq: Add generic IRQ context
 boundary tracepoints
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
Date: Sat, 21 Nov 2026 11:26:44 +0100
In-Reply-To: <20261107171252.25090-2-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
	 <20261107171252.25090-2-kmehltretter@gmail.com>
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
X-Mimecast-MFC-PROC-ID: 0i-y2OS3dAydH140ofW1teH0xNQvDBZ1soKCVNhM-iM_1795256808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-11-07 at 18:12 +0100, Karl Mehltretter wrote:
...
> =C2=A0void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> =C2=A0{
> +=09unsigned long trace_flags =3D 0;
> =C2=A0=09unsigned long flags;
> +=09bool trace_serving;
> =C2=A0=09int newcnt;
> =C2=A0
> =C2=A0=09WARN_ON_ONCE(in_hardirq());
> @@ -200,6 +202,16 @@ void __local_bh_disable_ip(unsigned long ip, unsigne=
d int
> cnt)
> =C2=A0=09=09}
> =C2=A0=09}
> =C2=A0
> +=09/*
> +=09 * A serving interval starts here, before handle_softirqs(). When its
> +=09 * entry is traced, keep IRQs and task switches from observing the
> bit
> +=09 * before the event. Any blocking BH lock was acquired above.
> +=09 */
> +=09trace_serving =3D (cnt & SOFTIRQ_OFFSET) &&
> +=09=09=09trace_softirq_context_entry_tp_enabled();
> +=09if (trace_serving)
> +=09=09local_irq_save(trace_flags);
> +
> =C2=A0=09/*
> =C2=A0=09 * Track the per CPU softirq disabled state. On RT this is per C=
PU
> =C2=A0=09 * state to allow preemption of bottom half disabled sections.
> @@ -233,15 +245,27 @@ void __local_bh_disable_ip(unsigned long ip, unsign=
ed
> int cnt)
> =C2=A0=09=09=09raw_local_irq_restore(flags);
> =C2=A0=09=09}
> =C2=A0=09}
> +
> +=09if (trace_serving) {
> +=09=09trace_softirq_context_entry_tp(!!in_serving_softirq(),
> false);

Probably someone more experienced with this code can comment whether the
tracepoints and other things you do make sense, you're going to need an
ack from these folks anyway.

From the tracing point of view. You're doing good avoiding any extra
action if trace_##_enabled() is false. Since you are already checking
for it, you may simplify the call to the tracepoint, essentially

 trace_##_tp() <=3D> if (trace_##_enabled()) trace_call__##_tp()

As you see, you're basically checking for the static key twice. Not a
big deal but you can use the new API and skip it:

  s/trace_softirq_context_entry_tp/trace_call__sched_set_state_tp/

Obviously you do the trace_call__##_tp() function ONLY if you're already
checking the static key.

> +=09=09local_irq_restore(trace_flags);
> +=09}
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(__local_bh_disable_ip);
> =C2=A0
> =C2=A0static void __local_bh_enable(unsigned int cnt, bool unlock)
> =C2=A0{
> +=09bool entering =3D (cnt & SOFTIRQ_OFFSET) && !in_serving_softirq();
> +=09bool trace_exiting =3D (cnt & SOFTIRQ_OFFSET) && !entering &&
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 trace_softirq_context_exit_tp_enabled(=
);
> =C2=A0=09unsigned long flags;
> =C2=A0=09bool sirq_en =3D false;
> =C2=A0=09int newcnt;
> =C2=A0
> +=09/* Callers already disabled IRQs around the counter and its events.
> */
> +=09if (trace_exiting)
> +=09=09trace_softirq_context_exit_tp(!!in_serving_softirq(), false);

Here as well, you're checking so you can simply trace_call()

> +
> =C2=A0=09if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
> =C2=A0=09=09DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 this_cpu_read(softirq_ctrl.cnt));
> @@ -276,6 +300,18 @@ static void __local_bh_enable(unsigned int cnt, bool
> unlock)
> =C2=A0=09=09=09WARN_ON_ONCE(current->softirq_disable_cnt < 0);
> =C2=A0=09=09}
> =C2=A0=09}
> +
> +=09/*
> +=09 * An exit probe can raise a softirq while serving state still
> suppresses
> +=09 * the normal ksoftirqd wakeup. Hand it off once no outer BH-disable
> +=09 * reference remains.
> +=09 */
> +=09if (trace_exiting && sirq_en && unlikely(local_softirq_pending()))
> +=09=09wakeup_softirqd();
> +
> +=09/* local_bh_enable() can turn BH-disabled state into serving state.
> */
> +=09if (entering)
> +=09=09trace_softirq_context_entry_tp(!!in_serving_softirq(),
> false);

Here for example, entering doesn't check the static key so you must keep
the tracing as is.

> =C2=A0}
> =C2=A0
> =C2=A0void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
> @@ -640,11 +676,15 @@ static void handle_softirqs(bool ksirqd)
> =C2=A0=09 */
> =C2=A0=09current->flags &=3D ~PF_MEMALLOC;
> =C2=A0
> -=09pending =3D local_softirq_pending();
> -
> =C2=A0=09from_irq_exit =3D softirq_handle_begin();
> =C2=A0=09in_hardirq =3D lockdep_softirq_start();
> =C2=A0=09account_softirq_enter(current);
> +=09if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +=09=09trace_softirq_context_entry_tp(!!in_serving_softirq(),
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from_irq_exit);
> +
> +=09/* Include work raised by the context-entry event. */
> +=09pending =3D local_softirq_pending();
> =C2=A0
> =C2=A0restart:
> =C2=A0=09/* Reset the pending bitmask before enabling irqs */
> @@ -692,6 +732,14 @@ static void handle_softirqs(bool ksirqd)
> =C2=A0=09=09wakeup_softirqd();
> =C2=A0=09}
> =C2=A0
> +=09if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +=09=C2=A0=C2=A0=C2=A0 trace_softirq_context_exit_tp_enabled()) {
> +=09=09trace_softirq_context_exit_tp(!!in_serving_softirq(),
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from_irq_exit);
> +=09=09/* The final pending-work decision above has already
> completed. */
> +=09=09if (unlikely(local_softirq_pending()))
> +=09=09=09wakeup_softirqd();
> +=09}
> =C2=A0=09account_softirq_exit(current);
> =C2=A0=09lockdep_softirq_end(in_hardirq);
> =C2=A0=09softirq_handle_end(from_irq_exit);
> @@ -722,6 +770,7 @@ void irq_enter_rcu(void)
> =C2=A0=09=09tick_irq_enter();
> =C2=A0
> =C2=A0=09account_hardirq_enter(current);
> +=09trace_hardirq_context_entry_tp(hardirq_count() >> HARDIRQ_SHIFT);

Here again, no check, so keep it as is.

Thanks,
Gabriele

