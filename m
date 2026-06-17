Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227F4A2E35
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710900; cv=none; b=WCs25VuxnXdK+z8pkhdj6ZYmi6xwHqlTt0/CotVFgivhMaNiYsRXZt4Hwe6qECqnnFcI0QQYEwJvd9dZ8gscMXGaQXhahvt2Cgn/CABwxwyWnRXqlm1ThT1C/Mi6YEfvq/1YyuE0Iik+EpZF2GROjgwMO1r7bLk0BTLGAEbG3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710900; c=relaxed/simple;
	bh=VMI3zP6udNn1tTLgqjAaNgvl5tKU6bGYelHGhbuIh6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjdKCMTK9VUtx2fN0qL+XkCZukoZrKXR9DlUy2C4qoELPSI6MKqMd5pfaPEEFMFt9M5grvEyYudDkmxsB7DF6fFtHFQYSbsWDIRJ/YbRORZBsZZczj0Ge6kYoUHEXl+kgCN6ayzjeppr6INEkjjTt4r5wW53/6vZb/MEBci0NcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R30V0oh+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R30V0oh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781710885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMI3zP6udNn1tTLgqjAaNgvl5tKU6bGYelHGhbuIh6s=;
	b=R30V0oh+va9kq4sjsnMTyes8IX/JVJKLLYQuBOzMvbxZYDvtgzPU30lNVWm8q9px1xGNgy
	oPbjRFCEWPw4iChj1motVoDMWCL+2NR5emFEhO7nyyXGN4Jw44pnab39345Q1gtMj9kZpT
	vaHZLHxwbQcmlXNxfEOADsGt3K8Bvk0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-iWgb409HNmG-EYdSkjO6kQ-1; Wed, 17 Jun 2026 11:41:23 -0400
X-MC-Unique: iWgb409HNmG-EYdSkjO6kQ-1
X-Mimecast-MFC-AGG-ID: iWgb409HNmG-EYdSkjO6kQ_1781710883
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bdad545342aso744281166b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 08:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781710882; x=1782315682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMI3zP6udNn1tTLgqjAaNgvl5tKU6bGYelHGhbuIh6s=;
        b=oqs3nCf18GqmN4U7bZsQeaiMJZKl62jAGjiCbwef2o0WglBPyxNn6s01/XTJx2GJQI
         nOpp1xMilPjOo3A1mYIm7Ka4sJ2+KgnW+GwG7VxPAPdZESvKzTRTFTQeixLB2wmDYzn9
         CrUkgtu1FvkusMppdJPQPIngFxEPhE00aeWpKTt1rmi8fMjNHlq/AGv+74hZYT11nyg8
         XTQnwJ6nEu0wMarweX9KDT9TepmzpDj54ICn4sd5ST0B2M2RGJiik1zhSGZy1zzlwwxP
         vaMXQObHCRa39uYAElTc+/0xtjwdpfngYhdCnOsvSFbJqiUGCInCDnWnZ6KKJ9wDoajh
         PMOg==
X-Forwarded-Encrypted: i=1; AFNElJ84Gjb+l6DW4qtYuICKibT4fRVRmxw5I2SwH/MAsfTRGHPpZMdHzvDYMvS8D4pE2ePKeIumfrq9x5kosoX3JvQ80Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIxoa/4zT6lCLQv3BEA5cK2Ktb9qosAzUb3kYUn4DSwz9TtRw
	Md1Z6liHeBv3NkQ4HAoPDh9TKGJlK3VDYOYzoY1GVkoeNt02w1TQ6DX4oSor2lQ5/DL9dNrxRDZ
	WrCieeWhN9VsYP99+GsrqaAn0TQ/72rvLjlHCgz5MRfyZ+UEfiuV87sQiqdtk/F+zE0sorwxrig
	==
X-Gm-Gg: Acq92OGSzNbLoLKl2EJ2WpGiK8A0PWJbyxjhmHT1kWaXj0aZ2FGi23iSo0E4AvgdrSi
	l4/gBkeFDft6tOKzYpUSpEmzg8SVAusnuTfCV4RzdqjOE3h9huOSodYbm0G21fVVloVQ00kh4dB
	1FRlNRDg85rqlBXtoYYzsE8Q36xuxZCDElsCW//3p5IZwbUMKB8TrrIGz+U/f96ArxNAjtaH3X/
	9Brn8zVpsUAqQ7KmBU3OKowsT9/eK5bqKbt/59gGXnzD/KwuM6szX/O3s+oKTWmbY34Nz4qQF2L
	NLmWw3ocDlXPbnj4ZNQYrwRHMsFp/6jD6QYBzKZkIqwE19/jQe4TMOuBb5F7tTpGi0NZ38+tKIN
	TBA/uxEAr/Jlw31M=
X-Received: by 2002:a17:907:3cc6:b0:c05:84b7:550d with SMTP id a640c23a62f3a-c05a7ab65d7mr310349066b.43.1781710882475;
        Wed, 17 Jun 2026 08:41:22 -0700 (PDT)
X-Received: by 2002:a17:907:3cc6:b0:c05:84b7:550d with SMTP id a640c23a62f3a-c05a7ab65d7mr310346066b.43.1781710881884;
        Wed, 17 Jun 2026 08:41:21 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-695ba3d76easm26413a12.28.2026.06.17.08.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:41:21 -0700 (PDT)
Message-ID: <2bcfa0bda551c0e1ba137b728dbe7886ff5c2579.camel@redhat.com>
Subject: Re: [PATCH 0/3] rv/reactors: fix lockdep warning and add KUnit tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 17 Jun 2026 17:41:20 +0200
In-Reply-To: <cover.1781541556.git.wen.yang@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YlQuJxUg84t22b63tChLlQfaHjKzljQ2C01h7toy0tU_1781710883
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 00:44 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> We occasionally hit a lockdep "Invalid wait context" warning in
> production
> environments when rv_react() callbacks are interrupted.
>=20
> The bug is intermittent in production. KUnit tests with busy-wait
> callbacks
> can reproduce it by holding the CPU long enough for a timer interrupt
> to fire
> during rv_react(), exposing the lockdep constraint violation:
>=20
> [=C2=A0=C2=A0 44.820913] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0=C2=A0 44.820923] [ BUG: Invalid wait context ]
> [=C2=A0=C2=A0 44.821137] 7.1.0-rc7-next-20260612-virtme #6 Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 N
> [=C2=A0=C2=A0 44.821203] -----------------------------

It's nice to have reactors kunit coverage, I need to go through them
more carefully but I like the idea.

Are those tests supposed to trigger this issue though? Under what
configuration?

I reverted the lockdep fix and run the tests in vng on both x86_64 and
arm64, both preempt_rt and not but I see no splat.
Repeating the tests multiple times from debugfs also didn't seem to
help. Both machines were relatively large (128 and 48 CPUs).

The config was the bare vng one with kunit built-in, lockdep and the
reactors tests.

What am I missing?

Thanks,
Gabriele

> [=C2=A0=C2=A0 44.821211] kunit_try_catch/209 is trying to lock:
> [=C2=A0=C2=A0 44.821244] ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}, at:
> __schedule+0x102/0x13d0
> [=C2=A0=C2=A0 44.821688] other info that might help us debug this:
> [=C2=A0=C2=A0 44.821708] context-{5:5}
> [=C2=A0=C2=A0 44.821730] 1 lock held by kunit_try_catch/209:
> [=C2=A0=C2=A0 44.821745]=C2=A0 #0: ffffffffb6ba62c0 (rv_react_map-wait-ty=
pe-
> override){+.+.}-{1:1}, at: rv_react+0x9d/0xf0
> [=C2=A0=C2=A0 44.821803] stack backtrace:
> [=C2=A0=C2=A0 44.822110] CPU: 10 UID: 0 PID: 209 Comm: kunit_try_catch Ta=
inted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 N=C2=A0 7.1.0-rc7-next-20260612-virtme #6
> PREEMPT_{RT,(full)}
> [=C2=A0=C2=A0 44.822197] Tainted: [N]=3DTEST
> [=C2=A0=C2=A0 44.822210] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX +=
 PIIX,
> arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [=C2=A0=C2=A0 44.822328] Call Trace:
> [=C2=A0=C2=A0 44.822377]=C2=A0 <TASK>
> [=C2=A0=C2=A0 44.822806]=C2=A0 dump_stack_lvl+0x78/0xe0
> [=C2=A0=C2=A0 44.822860]=C2=A0 __lock_acquire+0x926/0x1c90
> [=C2=A0=C2=A0 44.822888]=C2=A0 lock_acquire+0xd3/0x310
> [=C2=A0=C2=A0 44.822901]=C2=A0 ? __schedule+0x102/0x13d0
> [=C2=A0=C2=A0 44.822919]=C2=A0 ? rcu_qs+0x2d/0x1a0
> [=C2=A0=C2=A0 44.822954]=C2=A0 _raw_spin_lock_nested+0x36/0x50
> [=C2=A0=C2=A0 44.822966]=C2=A0 ? __schedule+0x102/0x13d0
> [=C2=A0=C2=A0 44.822979]=C2=A0 __schedule+0x102/0x13d0
> [=C2=A0=C2=A0 44.822993]=C2=A0 ? mark_held_locks+0x40/0x70
> [=C2=A0=C2=A0 44.823009]=C2=A0 preempt_schedule_irq+0x37/0x70
> [=C2=A0=C2=A0 44.823018]=C2=A0 irqentry_exit+0x1da/0x8c0
> [=C2=A0=C2=A0 44.823032]=C2=A0 asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [=C2=A0=C2=A0 44.823093] RIP: 0010:mock_printk_react+0x2a/0x50
> [=C2=A0=C2=A0 44.823250] Code: f3 0f 1e fa 0f 1f 44 00 00 41 54 49 89 f4 =
55 48
> 89 fd 53 e8 18 8b db ff 4c 89 e6 48 89 ef 48 89 c3 e8 fa 8e ed ff eb
> 02 f3 90 <e8> 01 8b db ff 48 29 d8 48 3d 3f 4b 4c 00 76 ee 5b 5d 41
> 5c c3 cc
> [=C2=A0=C2=A0 44.823303] RSP: 0018:ffffd1c3c0733d38 EFLAGS: 00000297
> [=C2=A0=C2=A0 44.823332] RAX: 00000000000119f3 RBX: 0000000a74e60d1c RCX:
> 000000000000001f
> [=C2=A0=C2=A0 44.823342] RDX: 0000000000000000 RSI: 000000003348c8a2 RDI:
> ffffffffc1abbfd9
> [=C2=A0=C2=A0 44.823351] RBP: ffffffffb671b613 R08: 0000000000000002 R09:
> 0000000000000000
> [=C2=A0=C2=A0 44.823359] R10: 0000000000000001 R11: 0000000000000000 R12:
> ffffd1c3c0733d60
> [=C2=A0=C2=A0 44.823367] R13: ffffffffb575a5fd R14: ffffd1c3c0017be8 R15:
> ffffd1c3c00179f8
> [=C2=A0=C2=A0 44.823397]=C2=A0 ? rv_react+0x9d/0xf0
> [=C2=A0=C2=A0 44.823437]=C2=A0 ? mock_printk_react+0x2f/0x50
> [=C2=A0=C2=A0 44.823448]=C2=A0 rv_react+0xb4/0xf0
> [=C2=A0=C2=A0 44.823455]=C2=A0 ? rv_react+0x9d/0xf0
> [=C2=A0=C2=A0 44.823476]=C2=A0 test_printk_react_called+0x83/0xb0
> [=C2=A0=C2=A0 44.823486]=C2=A0 ? __pfx_mock_printk_react+0x10/0x10
> [=C2=A0=C2=A0 44.823502]=C2=A0 ? __pfx_mock_printk_react+0x10/0x10
> [=C2=A0=C2=A0 44.823513]=C2=A0 kunit_try_run_case+0x97/0x190
> [=C2=A0=C2=A0 44.823534]=C2=A0 ? __pfx_kunit_generic_run_threadfn_adapter=
+0x10/0x10
> [=C2=A0=C2=A0 44.823544]=C2=A0 kunit_generic_run_threadfn_adapter+0x21/0x=
40
> [=C2=A0=C2=A0 44.823551]=C2=A0 kthread+0x124/0x160
> [=C2=A0=C2=A0 44.823562]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0=C2=A0 44.823574]=C2=A0 ret_from_fork+0x291/0x3b0
> [=C2=A0=C2=A0 44.823585]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0=C2=A0 44.823595]=C2=A0 ret_from_fork_asm+0x1a/0x30
> [=C2=A0=C2=A0 44.823641]=C2=A0 </TASK>
>=20
>=20
> Patch 1 fixes the lockdep bug by correcting rv_react()'s
> wait_type_inner
> from LD_WAIT_CONFIG (which inherits the outer context) to
> LD_WAIT_SPIN
> (the tightest constraint callbacks must satisfy).
>=20
> Patch 2 adds KUnit tests for reactor_printk. The busy-wait in the
> mock
> callback reproduces the timer interrupt scenario that exposes the
> bug.
>=20
> Patch 3 adds KUnit tests for reactor_panic, exercising the panic
> notifier
> chain without halting the system.
>=20
> Tested with CONFIG_PROVE_LOCKING=3Dy and CONFIG_KUNIT=3Dy.
>=20
>=20
> Wen Yang (3):
> =C2=A0 rv/reactors: fix lockdep "Invalid wait context" in rv_react()
> =C2=A0 rv/reactors: add KUnit tests for reactor_printk
> =C2=A0 rv/reactors: add KUnit tests for reactor_panic
>=20
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++++
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0kernel/trace/rv/reactor_panic_kunit.c=C2=A0 | 106 +++++++++++++++++=
++++
> =C2=A0kernel/trace/rv/reactor_printk_kunit.c | 123
> +++++++++++++++++++++++++
> =C2=A0kernel/trace/rv/rv_reactors.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> =C2=A05 files changed, 258 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 kernel/trace/rv/reactor_panic_kunit.c
> =C2=A0create mode 100644 kernel/trace/rv/reactor_printk_kunit.c

