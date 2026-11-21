Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795269681;
	b=tt8owRtjGCQ5pz8Ki55yu4VcouiQSUgmsuRosmb43WL/Ui9PX+NvZzY3i5QbwzlaiM58
	 w/x6TAEiUWRMWybky5MJFbggRkBiiwndcDEf6pJgbAF49sBm75q+eVWvdkFt8YR7H09HZ
	 B64RsAk7sWxtC/dw2W/nKyYgKDDGaprSsqV+wd4I1FTBr94LpawolRId1FoNZ3ta/rFzq
	 gCNRqJiL62eoui47o+5sIJsFpEBj/ap1FGbU3v7qruYaYer5u3d1dLl8cP21rw4pGTZBt
	 s8W09H/TokJJYd4yHPz1Zt8pwkeFuVcrgTYtVfl1teJlSsynV6H494GavQiKU47DMeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269681;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=e2mOK1MMQLYi3VECCKGxNvMEni9pzQtygVngFQX5eIw=;
	b=0+8g1HoPeHA6/AqV7XhQHTew7pG6nSL26Q3zp022C7prPYSLxFm7wtuDy1Os5bJ4FZEV
	 5GJifLUN/V7fGitWTKu8PqWkAJtIMl91wnCnkHBkGVarRsY9fj23Vil25iHOrc8MMmMT/
	 p62V/GhialoHb0+cXQIzM59x+2jw6xQpFClpA2vGaNh28GbGlxvY21iG+RTtuQhHQlxrd
	 0RzbwvUFzUnTeLJAqyHAG6qHPleP6J2JballuCmu3FrOtR0dSkUhuvHbY/92aCKdnu2iU
	 E7qfEQpjyNvnW0iLOwlzJuiyRTqjxAk172IyzOG8d7Hx707pyvdM+f7lbXo+MCP7lVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xn9xkKW8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63063606A32A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 14:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63063606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xn9xkKW8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795269679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e2mOK1MMQLYi3VECCKGxNvMEni9pzQtygVngFQX5eIw=;
	b=Xn9xkKW8+rMLxIShX+rWAglnOp/tH82msIG0w86fkbZXU+1Ujhm97RlO2HUFFAIGxJoOF3
	Jro6wtzNe8m3pQi94uHIkbsHg4GyEGrE4PkEGQPDka3sxpTO/k5asm8Uwm02SHsZZT6Arb
	KXoiDPAlqkJixnoUzseNET7/7aio3wk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-BmZY1K_nNbS1FXSGKvaiFA-1; Sat, 21 Nov 2026 14:01:17 +0000
X-MC-Unique: BmZY1K_nNbS1FXSGKvaiFA-1
X-Mimecast-MFC-AGG-ID: BmZY1K_nNbS1FXSGKvaiFA_1795269676
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so14163345e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 06:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795269676; x=1795874476;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e2mOK1MMQLYi3VECCKGxNvMEni9pzQtygVngFQX5eIw=;
        b=D4NfRPYwwNN59nam6G1bp2QdrW9glf903cVThWoOFlY5yzvzGpZn13bmusZH2Z+sgz
         p1JcAI3kVSdeoqaKHp/ez7C2NWMgrMgz+RGOdVLNkpgGhxZDLg50pDmSZDTSogecieI2
         FBFub/DvRCOAOOUwcXAl4JIYlZhbjS/yKh0bBfnoDKikrVVa2JT4+ZNOvJ93kEdGq4tU
         EddpafJ/lPeE8Pwd8mUVBeEzLd/m7C5QUIF5neTiy27RscuPYQppsac0s+cm4tKtNhNT
         VnvvbJSs00WkqBAp9GopdkKoc5WzvL9pZoqLMoov7XLDhvr9yMKFU3rtqYtHADQD00u2
         lIjA==
X-Forwarded-Encrypted: i=1; AL+hErFbCW9T55A7PEnLXSPROqtO7AA1qqDWxYfPV0rqAZD1pADd/LXQRDSce4cYUfAQ/R2583zrIwewdzIOwfWJR7SJwZQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Fw83+uyEQkwinD5LexTBG6q/P6Jpvbpoisaza8zreyAVnLzTm
	Whx3m4FdWJQe3A7SHc2y3yxky89XQJY4vx6fzfZMSBuN0qQxkk0gdc5xEmnh9pQF5TEozpYstCE
	5tMsqHoxIj41e8ClmAaDbPCzlaNatJrfQPPSFrKIYHDtWIaQDmjgV2QTOUadcIod1zh0/yywaOg
	==
X-Gm-Gg: AZFdTZfTIFU83EoCs6kQbtDs/RxQzbyk2g2GwdUyAKGMSLlzhvcghgRjbnOlRgakGEo
	YiyZyvP9EjVlwK2MX204y1B1ZOZP/uNAjAVfLNckd0hL5nLNSbXrKo3sxIGdKE8DB/VaOKX2QlF
	FT5RdXiisG0aaYmznU3cGMcxf4v2TAm2AYi2OkPOjo4N122jI0lbKSHqd51PgXAtOcrEQK1yFSw
	8lujIFobw4kCePnxQjuGpLVT1iyhN0MHfyWJN1WKrDdwStSfhxpq7aInGtLFbqka92Ww9TLjr8n
	W4wVOE0DvjNBiddoPnzK/SA2GjMD+pNyl8wLqMTIAsU7tFBaJRWnMt6rDvpUG/epzgQiaT/alRF
	PMq22yLHVI7YMK+qboUbVYfPTdbS6b/ChrtuuXjuT6RVU5vFwoXqSQKLgCHPD4twD4NI7LIS8f5
	Yz
X-Received: by 2002:a05:600c:64c9:b0:4bb:679a:86ee with SMTP id 5b1f17b1804b1-4bb88938dbemr145650325e9.29.1795269676272;
        Sat, 21 Nov 2026 06:01:16 -0800 (PST)
X-Received: by 2002:a05:600c:64c9:b0:4bb:679a:86ee with SMTP id 5b1f17b1804b1-4bb88938dbemr145649735e9.29.1795269675930;
        Sat, 21 Nov 2026 06:01:15 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm228383265e9.3.2026.11.21.06.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 06:01:15 -0800 (PST)
Message-ID: <e8b9a9afb9587ed1f41c0fafd486ec9be82928db.camel@redhat.com>
Subject: Re: [RFC PATCH v2 9/9] rv: Test IRQ-exit softirq provenance and
 handoff
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
Date: Sat, 21 Nov 2026 15:01:13 +0100
In-Reply-To: <20261107171252.25090-10-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
	 <20261107171252.25090-10-kmehltretter@gmail.com>
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
X-Mimecast-MFC-PROC-ID: 6tw7SY5oXZN-G4_EKLlkdZQU1-xWJMRsPa5hSYJnudA_1795269676
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-11-07 at 18:12 +0100, Karl Mehltretter wrote:
> IRQ-exit softirq processing preserves hardirq state until it finishes. Te=
st
> the resulting hardirq-to-softirq-to-hardirq sequence, including a nested
> hardirq and monitor attachment during the transition.
>=20
> Boundary and tick-exit callbacks can themselves raise more softirq work.
> Raise work at softirq entry, softirq exit, the final hardirq boundary, an=
d
> a full-NOHZ tick_stop event. Verify that ordinary work reaches ksoftirqd,
> forced-thread timer work reaches ktimerd, and a timer-wakeup callback whi=
ch
> raises ordinary work gets the final ksoftirqd recheck.
>=20
> Track the synthetic owner and serving-softirq interval so unrelated neste=
d
> interrupts do not corrupt the expected sequence. Reject the handoff setup
> while bottom halves are blocked, attach observers before waiting for
> workers, and recheck the setup with interrupts disabled.
>=20
> On PREEMPT_RT, verify that worker events do not report hardirq provenance=
.
> Do not run the synthetic inline IRQ-exit cases there. IRQ exit defers
> softirqs to workers, and serving-softirq state is task-local rather than
> encoded solely in preempt_count().
>=20
> Snapshot reaction counts inside synthetic IRQ-disabled and hardirq
> intervals, then evaluate the KUnit expectations after restoring normal ta=
sk
> context.
>=20
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

I still couldn't read the KUnit tests, but from what I get quickly scanning
these, it's massive. A total of almost 3k lines of KUnit tests for 2 simple
models is probably a bit much.

Keep in mind you are testing your unit, which is an RV monitor, so you may =
want
to stress transitions, mess around with the environment as little as you ca=
n
(e.g. disable interrupts) and use mocks/stubs where you can. It isn't alway=
s
easy, but the fact you're touching softirq.c doesn't look right. Your
unit isn't the softirq machinery, you should interact with it as least as
possible.

If you really want to test the system as a whole, you do a selftest,
which stresses from userspace, more like an integration test than a unit
tests.

Thanks,
Gabriele

