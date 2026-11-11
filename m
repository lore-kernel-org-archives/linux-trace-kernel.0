Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391670;
	b=Je1/xRsvvuW7RrJFYYyMtSCTyMKUWclU6AWBvLyvoGdB/pzCA7l5BQumPkn4Yq3wmUis
	 2Qc+5NIjM5CtTu3i/zMdxjXblR9xcmqZ4GqKm5ws4JQC1J+vWEwpnanW1FjYOr2bwd4WQ
	 5sSRc7cUphFjPRDdBhf3+1aevVICAMPU3eXgAlSeDWV+M5NEgfJlwSPCa6CLFvSpyDfdj
	 46Djblhj+hRESVprWUjsaLO1H7rtz8S/y3t7rUPaxnqltHaRDvpmcwLcg5bZy3GacczaO
	 ERYL1k1LJoNe56odJDR99lBxlajQkaBakFFRZuUcbK/kgzuS9dEVq9jUOgkebC58eHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391670;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Mime-Version:Date:Message-Id:Subject:From:To:Cc:
	 X-Mailer:References:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:Content-Type;
	bh=Niqe2x8zSNcj511Ml9V+Ajvvs2X+B0hTDSBlp/NM8Ng=;
	b=Pfv37vrPFf0hPEDVVZ8FhFToO5nKHir5ksExhO+WtGZ5AowaTVdOu3ix3o3GVP6LNhkM
	 90YKtQv3cwUuBpLtsAsI4hmmurcA7PrQRF9vztTqRIm+SFbrMKs8bf5QdcuewfKJmusZG
	 JMZLFgg2lEZcDL37CHjLN+ZVkK8hGxX704vgh0NJhmFBEcdqHmD8Z5NvR9b9gRe6oNi81
	 /ky7LYAInZLhUH11VO8oshM3eyNNvnPRNnE39IZ09ANwNiWAeUMjrBFUFNUxfVGY4E7qy
	 VrivQZFRrlFqmR2S0mZPp1OvmPhiRCe9Pa88hR5Y+KBqB8x07SGrOp0ldB6cetGtW9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SUgeq7eW;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB857606A32D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 10:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB857606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SUgeq7eW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794391668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Niqe2x8zSNcj511Ml9V+Ajvvs2X+B0hTDSBlp/NM8Ng=;
	b=SUgeq7eWd4xhzL0r5GUBdGUQfoaFn8q15JMvr2WtnyDWdrbOH6Yjoafqx0KreLgkCEZSGY
	ZA0Za/JFs3fh2MeJMM2SDO2kQ5o3ppn6wyK9kt3dpXDag6iaKVnBjQZ0pkZPuOQdHJeXF8
	NI5WAiSVtenXy3MRsL4h59mQyB6oDKY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-bYsbddDYOAqWbvBXUQOWiA-1; Wed, 11 Nov 2026 05:07:47 -0500
X-MC-Unique: bYsbddDYOAqWbvBXUQOWiA-1
X-Mimecast-MFC-AGG-ID: bYsbddDYOAqWbvBXUQOWiA_1794391666
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4903fc8537aso2033051f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 02:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794391666; x=1794996466;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U2QslJdyqbbBi70Vdlv8vhoVpPyWnxyHh1LLlAt8m4Y=;
        b=H1Im+8PxOyRRC/Z/hBRI5taK56Qzby2ngMhrTWR0N/vidZsuJTvtE7iK2if/aw9XG5
         e0txz6qp+nbw8+VBH8dBX/IWcsH2y5YsVAmJpuxpuSyt23TlqYquKgyUYgFQjT4/eFMR
         +zBB5EdBSPqBORZ6wHEDstFEgg14yAchS71iK+FBiOGmc8xd2D1WaFp9HbOIIsWreAcy
         RvsZYlM8jN+thdyEWf6wzsxbmz1gPZ/4G4wikAcva4/mTer3uK2VxcmubRw7t+A2QFvi
         q15zs4f1saHvfIBgDaUsD0zGquEVVqwMDS5mLiyZey3BGB3UgUnM17Gj34mMEeUNCK5e
         ByMA==
X-Forwarded-Encrypted: i=1; AL+hErFN4LplQJW/umH+ff8rBvUjlfOcGZJKfJJfygsyYYkzCvO1OC1+GNS39bTxnvE2XgdVBQqjp+80A/CYLcU8jgbbK8g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EJIwxvf+M+SAB5cSTfVBljE8m1MhEen5w/OO1vcnenvS+z2BK
	CHyZYpHkyCxw2GQ/Kqb6LJ1rjN4B4DODXzfKrcFdw3F4Kpw37o15JHmHEfmQWs5fOCunyRU/IWi
	UYSdIQrKchCOBWhuRMO9k6aM7lA76rzCNwUYgumve4MvaMn6xahKOSc6blR15bB5w5qfJL3zgMQ
	==
X-Gm-Gg: AYBFou2rzR6enwvho0whPni0iuZurmz9lbCFc9kMeX4YaavW/g39rWM8rR5ZwT9WqbT
	SAd+GXkrnl8/XLEnhov8/94mCe3BBKOy05YPT5EF4dYDA2krqdsd4O5EdESTOHOrRK7StZr5XTs
	mvW5vHMM09RawmGJTN5r82S2YAfo7GO5bgBl7jFDr8iMQ+EZaT6bodDz4ZdbnygxqzEIXGPeuRa
	IUl6IGKKesVpm9rsWd7Y5RJa7VSYL0NFeJ0yJVHFMBtCf4KbSaghKBzzLdhmmTNm9D+v+VG6k3C
	ZfsgmJHo1roiozrDda4LXFd8GRdoB1/vNCl2rVeCnlgnoAgRDbxgkPDbp4EX2BfyjrB99T5/Tov
	5d08DNuzIvs/HqD1EczqbJj0gsxI2kkqQ5FWTNwab21L80A==
X-Received: by 2002:a05:6000:4a06:b0:493:f3f2:223b with SMTP id ffacd0b85a97d-499c5f3113dmr3181816f8f.12.1794391665853;
        Wed, 11 Nov 2026 02:07:45 -0800 (PST)
X-Received: by 2002:a05:6000:4a06:b0:493:f3f2:223b with SMTP id ffacd0b85a97d-499c5f3113dmr3181770f8f.12.1794391665484;
        Wed, 11 Nov 2026 02:07:45 -0800 (PST)
Received: from localhost ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498357648f0sm10555289f8f.12.2026.11.11.02.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 02:07:45 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Date: Wed, 11 Nov 2026 11:07:43 +0100
Message-Id: <DMSARAAS9QNH.2HFOWZ6ZHCK3O@redhat.com>
Subject: Re: [PATCH] rv: Normalize opid IRQ state to a boolean
From: "Gabriele Monaco" <gmonaco@redhat.com>
To: "Karl Mehltretter" <kmehltretter@gmail.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Gabriele Monaco" <gmonaco@redhat.com>
Cc: "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Nam Cao" <namcao@linutronix.de>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261020035158.90190-1-kmehltretter@gmail.com>
In-Reply-To: <20261020035158.90190-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pq3AJBbAQRkJHwezmn6CYZZy6IOrXEsSuk2auNYnaTY_1794391666
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Oct 20, 2026 at 5:51 AM CEST, Karl Mehltretter wrote:
> The opid hybrid-automaton guards compare irq_off with 1. However,
> irqs_disabled() only guarantees zero or nonzero. On 32-bit Arm,
> arch_irqs_disabled_flags() returns the CPSR I bit, 0x80. Consequently,
> valid events with interrupts disabled fail the guard and spuriously
> trigger the reactor.
>
> Normalize the value before returning it. Add a KUnit regression test
> that handles a need-resched event with local interrupts disabled.
> Without the normalization, the test triggers a reaction on Arm.
>
> Fixes: 2b406fdb33387 ("rv: Convert the opid monitor to a hybrid automaton=
")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---

Looks reasonable, thanks!

Acked-by: Gabriele Monaco <gmonaco@redhat.com>

> Tested with an ARMv7 GCC 16 W=3D1 build and targeted SMP1 QEMU run:
> rv_test_opid and the RV KUnit suite pass.
>
>  kernel/trace/rv/monitors/opid/opid.c       | 2 +-
>  kernel/trace/rv/monitors/opid/opid_kunit.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monit=
ors/opid/opid.c
> index 9ae619f176fa1..a14532cc41778 100644
> --- a/kernel/trace/rv/monitors/opid/opid.c
> +++ b/kernel/trace/rv/monitors/opid/opid.c
> @@ -20,7 +20,7 @@
>  static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_opid env, u64=
 time_ns)
>  {
>  =09if (env =3D=3D irq_off_opid)
> -=09=09return irqs_disabled();
> +=09=09return !!irqs_disabled();
>  =09else if (env =3D=3D preempt_off_opid) {
>  =09=09if (IS_ENABLED(CONFIG_PREEMPTION))
>  =09=09=09return (preempt_count() & PREEMPT_MASK) > 0;
> diff --git a/kernel/trace/rv/monitors/opid/opid_kunit.c b/kernel/trace/rv=
/monitors/opid/opid_kunit.c
> index 3cb087a74241e..8aa1fb9c62344 100644
> --- a/kernel/trace/rv/monitors/opid/opid_kunit.c
> +++ b/kernel/trace/rv/monitors/opid/opid_kunit.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/kernel.h>
> +#include <linux/irqflags.h>
>  #include <linux/rv.h>
>  #include <rv/kunit.h>
>  #include <trace/events/sched.h>
> @@ -17,6 +18,11 @@ static void rv_test_opid(struct kunit *test)
>  =09guard(migrate)();
>  =09KUNIT_EXPECT_TRUE(test, preemptible());
> =20
> +=09/* Need resched with interrupts disabled */
> +=09scoped_guard(irq)
> +=09=09rv_opid_ops.handle_sched_need_resched(NULL, NULL, 0, TIF_NEED_RESC=
HED);
> +=09RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
> +
>  =09/* Wakeup with preemption and interrupts enabled */
>  =09RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
>  =09=09rv_opid_ops.handle_sched_waking(NULL, NULL);
>
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222


