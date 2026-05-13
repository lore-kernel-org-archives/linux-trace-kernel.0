Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202403839B6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658427; cv=none; b=N8d0Ith81MzpmKOx56BOu/zBXeiJnUOXQhKsB0RVjBCfPXtbtBTCbyNQr+5zMovUV/SLH4rnL/V94Iq7LeR8JgxRV1O6RCIhcjGd8EDCVpj14rWykaDkmNXHQToy5MnSwVUbC9FNpm+pZPtMUKrZDWRq0KwVOC4OQ5i90x4CH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658427; c=relaxed/simple;
	bh=uk4wQvJ+iHbzWyG4rAxbaEnmwtZr15Xvy0+W1sDTUNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNeR2grIvfJNjT5sAb41GrO8+nL9Ygf6U8YbUMG6UP2Wb40Hi6MzIV17/9Mq9UUd/Ciqf27PID8JqPV1VkF0OTMHuzZdIQaTLeOLUIv3ukBKx145Wy0OhjjOl2NpccwJhw2jxTdEQA7ZfomeOIWlFWe6OOSDIbapDfIznlGymik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYFwXd6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYFwXd6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778658420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lmjNQcdA/gBia2ofRg/fDP7IbyKSrw4jD9C1D+OrYLw=;
	b=aYFwXd6ns3+8MvT2guhL1S71ninp/Bjbn3mrk+pvbsVRTxc7Xt0GtkLmaVogF9AnzgMeZh
	3ueHEdzwyL33rTE6dm0FiI5cKaxadX7SjyAOlWlRn+kYqSPHeCB/PaZw/rYPamSa2o/jGI
	/5718pj1W8b922LruAG7TNms0aPyYpM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-aUx0deglMLCj28UhLZqqyw-1; Wed, 13 May 2026 03:46:58 -0400
X-MC-Unique: aUx0deglMLCj28UhLZqqyw-1
X-Mimecast-MFC-AGG-ID: aUx0deglMLCj28UhLZqqyw_1778658417
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a36715dso4588889f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 00:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778658417; x=1779263217;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMfjUpiy91iFYDprvUhTP/IGJhaJ5BAMaWv3syto9ZE=;
        b=hxTo/sTHdquwsC2S7BgovOgNLoVv4xyvsHuqq2XiaD5wPttGUcWXYwo0W87Vf2vXnY
         wo/Rg79P7Vyzt5ynxi4oqgbwcoTQRsDwkGEyuUggEJ3cgfL+gX2FFrBQ8qlnZeq9FDkT
         Tsz91oU9dshJHvbXWb7xACB0T1b9qIA0s9jnNFiKIgrSVTV9erl30j2KUFBnDVcAP7XY
         VwyB0w9Ma5B9TcGw4BoLFi9szN/t2NTbrzQmACd3JT5qDWNZ8MwFfubz9w3cieWOlrUO
         cj+IDoLy9DN1Aiz55kPjrWq7eyVT4KbCEJFh2rRR1etdcBiQEEFqYJ9pXT7dodACsEYA
         zjWw==
X-Gm-Message-State: AOJu0YwIxtk9qGpFARNlU1LL41Td3jCY6CbH8wyasRYw7e7QfvsKgOsg
	aG8hep9tonLIpU6JwKQ/yNpGPDaS28nLvgFjlT/GJ4tEJi3e2COBqTN5ycLwatB3H60hdMpXPjj
	NXdZyU6nPwx+7o3Z1RjikP+jSUl8zpuX9WawsUmZZqEwOjVIHApQm6P5Ge+0Tbg+VyikyYsGMLS
	3qJnIt/6Ff
X-Gm-Gg: Acq92OHy5htowL9uXCHRmDgMCVbTy1cPD+OHwRBOUv0j3E5Q54K9D/DsPBlXAckdmFu
	r7WQDNGZLq6NBv8l1mYfl0hMziYDucSfkTKoHRadP2hMLbvLK9eouec4Bl1TNEt1ovBqV7NzDuN
	0LOIw8hPPMXPwl0v/Pt+6T6C9dIk/P3WWEKYoXEWymgceD4haLbrVwkePAFoTIOdx6V9Vc4nn1B
	0EMFWP6I1558CIj4XMB07CoOrf/8zEatTBdWBwVulBU/8LX94uKPl4ZCnEps/gnYWGa4QV6xeNW
	V50hzeKAvtQdjtlBezKyt65wpkMXS8OFJboTOUiR0eNUcbiOHipztW1km+xdCYLIjM3qIZ9lf2d
	GIcIzK6QT/NvJaFxIJX+Kv4ronOzORRFyiziPgBX52cY5Wd2uS3Ar0nkd1Ss6zwDCrOR0W0oevh
	0yM/6+lwFmPPA5o+M=
X-Received: by 2002:a05:6000:200b:b0:446:96b1:f5f with SMTP id ffacd0b85a97d-45c5859eab3mr3177037f8f.8.1778658416713;
        Wed, 13 May 2026 00:46:56 -0700 (PDT)
X-Received: by 2002:a05:6000:200b:b0:446:96b1:f5f with SMTP id ffacd0b85a97d-45c5859eab3mr3176967f8f.8.1778658416066;
        Wed, 13 May 2026 00:46:56 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491304505sm38747011f8f.22.2026.05.13.00.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 00:46:55 -0700 (PDT)
Message-ID: <f5913e8612606cc1c6419ecf1a77f2a981f6fbda.camel@redhat.com>
Subject: Re: [RFC PATCH v2 10/10] selftests/verification: add tlob selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Wed, 13 May 2026 09:46:53 +0200
In-Reply-To: <8148267505ef90175b6b69e1ffb3aa560ff42d35.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
	 <8148267505ef90175b6b69e1ffb3aa560ff42d35.1778522945.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DV-cBAA7Tm505XVYwM4aKXLBtRViRFL1imCR7nD7z1Q_1778658417
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add selftest coverage for the tlob RV monitor in
> tools/testing/selftests/verification/.
>=20
> Two helper binaries are built by tlob/Makefile: tlob_helper for the
> ioctl interface (/dev/rv) and tlob_uprobe_target for the uprobe tests.
> The top-level Makefile delegates to tlob/ via a generic MONITOR_SUBDIRS
> pattern so monitor-specific build details stay within each monitor's
> own subdirectory.
>=20
> Eight test files cover the tracefs control interface (tracefs.tc), the
> ioctl self-instrumentation interface (ioctl.tc, 8 scenarios), and the
> uprobe external monitoring interface (uprobe_bind.tc, uprobe_violation.tc=
,
> uprobe_no_event.tc, uprobe_multi.tc, uprobe_detail_sleeping.tc,
> uprobe_detail_waiting.tc).

Thanks for the deep test suite!

I run it on a VM (virtme-ng on my x86 16 core fedora box) and have it hangi=
ng at
step 9 (you see 8 is ok and after I get an RCU splat):

$ sudo vng -v -- make -C tools/testing/selftests/verification run_tests
...
# ok 5 Test tlob ioctl self-instrumentation (within/over-budget, error path=
s)
# ok 6 Test tlob monitor tracefs interface (enable/disable and files)
# ok 7 Test uprobe binding (visible in monitor file, removable, duplicate r=
ejected)
# ok 8 Test uprobe detail sleeping (sleeping_ns dominates when task blocks =
between probes)
[   53.989561] tlob_target (1756) used greatest stack depth: 11792 bytes le=
ft
[   75.100818] rcu: INFO: rcu_preempt self-detected stall on CPU
[   75.100825] rcu: =090-...!: (26082 ticks this GP) idle=3Da8e4/1/0x400000=
0000000000 softirq=3D0/0 fqs=3D13 rcuc=3D26078 jiffies(starved)
[   75.100833] rcu: =09(t=3D26000 jiffies g=3D17333 q=3D146 ncpus=3D16)
[   75.100836] rcu: rcu_preempt kthread timer wakeup didn't happen for 2404=
0 jiffies! g17333 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
[   75.100839] rcu: =09Possible timer handling issue on cpu=3D7 timer-softi=
rq=3D317
[   75.100840] rcu: rcu_preempt kthread starved for 24043 jiffies! g17333 f=
0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D7
[   75.100843] rcu: =09Unless rcu_preempt kthread gets sufficient CPU time,=
 OOM is now expected behavior.
[   75.100843] rcu: RCU grace-period kthread stack dump:
[   75.100845] task:rcu_preempt     state:I stack:14104 pid:17    tgid:17  =
  ppid:2      task_flags:0x208040 flags:0x00080000
[   75.100856] Call Trace:
[   75.100859]  <TASK>
[   75.100870]  __schedule+0x4f1/0x1490
[   75.100890]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   75.100898]  schedule+0x5b/0x210
[   75.100901]  ? schedule_timeout+0xae/0x130
[   75.100905]  schedule_timeout+0xae/0x130
[   75.100911]  ? __pfx_process_timeout+0x10/0x10
[   75.100925]  rcu_gp_fqs_loop+0x114/0x880
[   75.100933]  ? lock_release+0x2ea/0x4a0
[   75.100945]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   75.100948]  rcu_gp_kthread+0x26b/0x320
[   75.100951]  ? preempt_count_sub+0x5f/0x80
[   75.100963]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   75.100966]  kthread+0xf3/0x130
[   75.100970]  ? __pfx_kthread+0x10/0x10
[   75.100978]  ret_from_fork+0x3b4/0x420
[   75.100984]  ? __pfx_kthread+0x10/0x10
[   75.100989]  ret_from_fork_asm+0x1a/0x30
[   75.101018]  </TASK>
[   75.101019] rcu: Stack dump where RCU GP kthread last ran:
[   75.101021] Sending NMI from CPU 0 to CPUs 7:
[   75.101106] NMI backtrace for cpu 7
[   75.101118] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 7.1.0-rc2+ =
#160 PREEMPT_{RT,(lazy)}=20
[   75.101124] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   75.101128] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   75.101139] Code: 75 70 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 25 6e 1c 00 fb f4 <c3=
> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[   75.101142] RSP: 0018:ffffd22ec0103eb8 EFLAGS: 00000296
[   75.101147] RAX: 00000000000529f3 RBX: 0000000000000000 RCX: ffffffff8ca=
56131
[   75.101170] RDX: ffff8de4c185c280 RSI: 0000000000000000 RDI: ffffffff8ca=
56131
[   75.101172] RBP: ffff8de4c185c280 R08: 0000000000000000 R09: 00000000000=
00000
[   75.101174] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000=
00007
[   75.101176] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   75.101373] FS:  0000000000000000(0000) GS:ffff8de56a091000(0000) knlGS:=
0000000000000000
[   75.101379] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   75.101381] CR2: 00007fb886a53f98 CR3: 000000003be5c002 CR4: 00000000007=
70ef0
[   75.101383] PKRU: 55555554
[   75.101384] Call Trace:
[   75.101388]  <TASK>
[   75.101389]  default_idle+0x9/0x10
[   75.101397]  default_idle_call+0x85/0x240
[   75.101404]  do_idle+0x291/0x300
[   75.101412]  ? schedule_idle+0x22/0x40
[   75.101415]  cpu_startup_entry+0x29/0x30
[   75.101418]  start_secondary+0xf8/0x100
[   75.101424]  common_startup_64+0x12c/0x138
[   75.101435]  </TASK>
[   75.102036] CPU: 0 UID: 0 PID: 1758 Comm: sh Not tainted 7.1.0-rc2+ #160=
 PREEMPT_{RT,(lazy)}=20
[   75.102040] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   75.102042] RIP: 0033:0x556458604e3f
[   75.102049] Code: 3c 18 4e 8d 04 3f 42 c6 04 21 00 0f b6 01 4c 89 7d b0 =
4c 89 c3 e9 bf ed ff ff 90 41 0f b6 c1 48 8d 15 c5 3f 11 00 80 3c 02 00 <0f=
> 84 a9 f0 ff ff 48 8b 45 80 f6 40 08 50 0f 85 9b f0 ff ff e9 78
[   75.102051] RSP: 002b:00007ffc7ac46e30 EFLAGS: 00000246
[   75.102054] RAX: 0000000000000074 RBX: 0000000000000074 RCX: 000055646ad=
b8a60
[   75.102056] RDX: 0000556458718e00 RSI: 0000000000000018 RDI: 00000000000=
00000
[   75.102057] RBP: 00007ffc7ac46f20 R08: 000055646adc3100 R09: 00000000000=
00074
[   75.102058] R10: 0000000000000021 R11: 0000000000000001 R12: 00000000000=
00000
[   75.102059] R13: 0000000000000070 R14: 000055646adb9cf0 R15: 00000000000=
00000
[   75.102061] FS:  00007f832822b740 GS:  0000000000000000


Did you see that? Am I doing something wrong?

Thanks,
Gabriele

>=20
> Tested on x86_64 with vng (virtme-ng):
>=20
> =C2=A0 TAP version 13
> =C2=A0 1..12
> =C2=A0 ok 1 Test monitor enable/disable
> =C2=A0 ok 2 Test monitor reactor setting
> =C2=A0 ok 3 Check available monitors
> =C2=A0 ok 4 Test wwnr monitor with printk reactor
> =C2=A0 ok 5 Test tlob ioctl self-instrumentation (within/over-budget, err=
or paths)
> =C2=A0 ok 6 Test tlob monitor tracefs interface (enable/disable and files=
)
> =C2=A0 ok 7 uprobe binding: visible in monitor file, removable, duplicate=
 offset
> rejected
> =C2=A0 ok 8 uprobe detail sleeping: sleeping_ns dominates when task block=
s between
> probes
> =C2=A0 ok 9 uprobe detail waiting: waiting_ns dominates when task is pree=
mpted
> between probes
> =C2=A0 ok 10 Two bindings on same binary with different offsets and budge=
ts fire
> independently
> =C2=A0 ok 11 Verify no spurious error_env_tlob events without an active u=
probe
> binding
> =C2=A0 ok 12 uprobe violation: error_env_tlob and detail_env_tlob fire wi=
th correct
> fields
> =C2=A0 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0tools/testing/selftests/verification/Makefile |=C2=A0 21 +-
> =C2=A0.../verification/test.d/tlob/ioctl.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 36 +
> =C2=A0.../verification/test.d/tlob/tracefs.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 17 +
> =C2=A0.../verification/test.d/tlob/uprobe_bind.tc=C2=A0=C2=A0 |=C2=A0 34 =
+
> =C2=A0.../test.d/tlob/uprobe_detail_sleeping.tc=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 47 ++
> =C2=A0.../test.d/tlob/uprobe_detail_waiting.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 60 ++
> =C2=A0.../verification/test.d/tlob/uprobe_multi.tc=C2=A0 |=C2=A0 60 ++
> =C2=A0.../test.d/tlob/uprobe_no_event.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +
> =C2=A0.../test.d/tlob/uprobe_violation.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 60 ++
> =C2=A0.../selftests/verification/tlob/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 21 +
> =C2=A0.../selftests/verification/tlob/tlob_ioctl.c=C2=A0 | 626 ++++++++++=
++++++++
> =C2=A0.../selftests/verification/tlob/tlob_target.c | 138 ++++
> =C2=A012 files changed, 1138 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 tools/testing/selftests/verification/test.d/tlob=
/ioctl.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/tracefs.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.t=
c
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
> =C2=A0create mode 100644 tools/testing/selftests/verification/tlob/Makefi=
le
> =C2=A0create mode 100644 tools/testing/selftests/verification/tlob/tlob_i=
octl.c
> =C2=A0create mode 100644 tools/testing/selftests/verification/tlob/tlob_t=
arget.c
>=20
> diff --git a/tools/testing/selftests/verification/Makefile
> b/tools/testing/selftests/verification/Makefile
> index aa8790c22a71..b5584fd3762d 100644
> --- a/tools/testing/selftests/verification/Makefile
> +++ b/tools/testing/selftests/verification/Makefile
> @@ -1,8 +1,27 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> -all:
> =C2=A0
> =C2=A0TEST_PROGS :=3D verificationtest-ktap
> =C2=A0TEST_FILES :=3D test.d settings
> =C2=A0EXTRA_CLEAN :=3D $(OUTPUT)/logs/*
> =C2=A0
> +# Subdirectories that provide helper binaries for the test runner.
> +# Each entry must contain a Makefile that accepts OUTDIR=3D and deposits
> +# its binaries there; verificationtest-ktap adds OUTDIR to PATH so
> +# the ftracetest require-checks resolve the binaries by name.
> +MONITOR_SUBDIRS :=3D tlob
> +
> =C2=A0include ../lib.mk
> +
> +# Build and clean each monitor subdirectory.
> +all: $(patsubst %,_build_%,$(MONITOR_SUBDIRS))
> +
> +clean: $(patsubst %,_clean_%,$(MONITOR_SUBDIRS))
> +
> +.PHONY: $(patsubst %,_build_%,$(MONITOR_SUBDIRS)) \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(patsubst %,_clean_%,$(MONIT=
OR_SUBDIRS))
> +
> +$(patsubst %,_build_%,$(MONITOR_SUBDIRS)): _build_%:
> +=09$(MAKE) -C $* OUTDIR=3D"$(OUTPUT)" TOOLS_INCLUDES=3D"$(TOOLS_INCLUDES=
)"
> +
> +$(patsubst %,_clean_%,$(MONITOR_SUBDIRS)): _clean_%:
> +=09$(MAKE) -C $* OUTDIR=3D"$(OUTPUT)" clean
> diff --git a/tools/testing/selftests/verification/test.d/tlob/ioctl.tc
> b/tools/testing/selftests/verification/test.d/tlob/ioctl.tc
> new file mode 100644
> index 000000000000..54ae249af9a6
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/ioctl.tc
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test tlob ioctl self-instrumentation (within/over-budget,
> error paths)
> +# requires: tlob:monitor tlob_ioctl:program
> +
> +TLOB_HELPER=3D$(command -v tlob_ioctl)
> +
> +[ -c /dev/rv ] || exit_unsupported
> +
> +echo 1 > monitors/tlob/enable
> +
> +# within budget: 50 ms threshold, 10 ms workload
> +"$TLOB_HELPER" within_budget
> +
> +# over budget in running state: 1 ms threshold, 100 ms busy-spin
> +"$TLOB_HELPER" over_budget_running
> +
> +# over budget in sleeping state: 3 ms threshold, 50 ms sleep
> +"$TLOB_HELPER" over_budget_sleeping
> +
> +# over budget in waiting state: 1 us threshold, sched_yield
> +"$TLOB_HELPER" over_budget_waiting
> +
> +# error paths
> +"$TLOB_HELPER" double_start
> +"$TLOB_HELPER" stop_no_start
> +
> +# per-thread isolation
> +"$TLOB_HELPER" multi_thread
> +
> +# bind against disabled monitor must return ENODEV, not crash
> +echo 0 > monitors/tlob/enable
> +"$TLOB_HELPER" not_enabled
> +echo 1 > monitors/tlob/enable
> +
> +echo 0 > monitors/tlob/enable
> diff --git a/tools/testing/selftests/verification/test.d/tlob/tracefs.tc
> b/tools/testing/selftests/verification/test.d/tlob/tracefs.tc
> new file mode 100644
> index 000000000000..5d1e7cc02498
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/tracefs.tc
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test tlob monitor tracefs interface (enable/disable and f=
iles)
> +# requires: tlob:monitor
> +
> +check_requires monitors/tlob/enable monitors/tlob/desc monitors/tlob/mon=
itor
> +
> +# enable / disable via the enable file
> +echo 1 > monitors/tlob/enable
> +grep -q 1 monitors/tlob/enable
> +echo "tlob" >> enabled_monitors
> +grep -q tlob enabled_monitors
> +
> +echo 0 > monitors/tlob/enable
> +grep -q 0 monitors/tlob/enable
> +echo "!tlob" >> enabled_monitors
> +! grep -q "^tlob$" enabled_monitors
> diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind=
.tc
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> new file mode 100644
> index 000000000000..41e20d593855
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test uprobe binding (visible in monitor file, removable,
> duplicate rejected)
> +# requires: tlob:monitor tlob_ioctl:program tlob_target:program
> +
> +TLOB_HELPER=3D$(command -v tlob_ioctl)
> +UPROBE_TARGET=3D$(command -v tlob_target)
> +TLOB_MONITOR=3Dmonitors/tlob/monitor
> +
> +busy_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_wor=
k
> 2>/dev/null)
> +stop_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_wor=
k_done
> 2>/dev/null)
> +[ -n "$busy_offset" ] || exit_unsupported
> +[ -n "$stop_offset" ] || exit_unsupported
> +
> +"$UPROBE_TARGET" 30000 &
> +busy_pid=3D$!
> +sleep 0.05
> +
> +echo 1 > monitors/tlob/enable
> +echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=3D50000=
00" >
> "$TLOB_MONITOR"
> +
> +# Binding must appear in monitor file with canonical hex-offset format.
> +grep -qE "^p ${UPROBE_TARGET}:0x[0-9a-f]+ 0x[0-9a-f]+ threshold=3D[0-9]+=
$"
> "$TLOB_MONITOR"
> +grep -q "threshold=3D5000000" "$TLOB_MONITOR"
> +
> +# Duplicate offset_start must be rejected.
> +! echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=3D999=
9" >
> "$TLOB_MONITOR" 2>/dev/null
> +
> +# Remove the binding; it must no longer appear.
> +echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR"
> +! grep -q "^p .*:0x${busy_offset#0x} " "$TLOB_MONITOR"
> +
> +kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
> +echo 0 > monitors/tlob/enable
> diff --git
> a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping=
.tc
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping=
.tc
> new file mode 100644
> index 000000000000..2b8656e0fef1
> --- /dev/null
> +++
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping=
.tc
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test uprobe detail sleeping (sleeping_ns dominates when t=
ask
> blocks between probes)
> +# requires: tlob:monitor tlob_ioctl:program tlob_target:program
> +
> +TLOB_HELPER=3D$(command -v tlob_ioctl)
> +UPROBE_TARGET=3D$(command -v tlob_target)
> +TLOB_MONITOR=3Dmonitors/tlob/monitor
> +
> +start_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_sleep_w=
ork
> 2>/dev/null)
> +stop_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_sleep_wo=
rk_done
> 2>/dev/null)
> +[ -n "$start_offset" ] || exit_unsupported
> +[ -n "$stop_offset" ] || exit_unsupported
> +
> +"$UPROBE_TARGET" 5000 sleep &
> +busy_pid=3D$!
> +sleep 0.05
> +
> +echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/tracing_on
> +echo 1 > monitors/tlob/enable
> +echo > /sys/kernel/tracing/trace
> +
> +# 50 ms budget; task sleeps 200 ms per iteration -> sleeping_ns dominate=
s.
> +echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=3D5000=
0" >
> "$TLOB_MONITOR"
> +
> +found=3D0; i=3D0
> +while [ "$i" -lt 30 ]; do
> +=09sleep 0.1
> +=09grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=3D1;
> break; }
> +=09i=3D$((i+1))
> +done
> +
> +echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
> +kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
> +echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 0 > monitors/tlob/enable
> +
> +[ "$found" =3D "1" ]
> +
> +line=3D$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
> +running=3D$(echo "$line" | sed 's/.*running_ns=3D\([0-9]*\).*/\1/')
> +waiting=3D$(echo "$line" | sed 's/.*waiting_ns=3D\([0-9]*\).*/\1/')
> +sleeping=3D$(echo "$line" | sed 's/.*sleeping_ns=3D\([0-9]*\).*/\1/')
> +[ "$sleeping" -gt "$((running + waiting))" ]
> +
> +echo > /sys/kernel/tracing/trace
> diff --git
> a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.=
tc
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.=
tc
> new file mode 100644
> index 000000000000..0705854f24df
> --- /dev/null
> +++
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.=
tc
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test uprobe detail waiting (waiting_ns dominates when tas=
k is
> preempted between probes)
> +# requires: tlob:monitor tlob_ioctl:program tlob_target:program
> +
> +TLOB_HELPER=3D$(command -v tlob_ioctl)
> +UPROBE_TARGET=3D$(command -v tlob_target)
> +TLOB_MONITOR=3Dmonitors/tlob/monitor
> +
> +command -v chrt=C2=A0=C2=A0=C2=A0 > /dev/null || exit_unsupported
> +command -v taskset > /dev/null || exit_unsupported
> +
> +start_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_preempt=
_work
> 2>/dev/null)
> +stop_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET"
> tlob_preempt_work_done 2>/dev/null)
> +[ -n "$start_offset" ] || exit_unsupported
> +[ -n "$stop_offset" ]=C2=A0 || exit_unsupported
> +
> +cpu=3D0
> +
> +echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/tracing_on
> +echo 1 > monitors/tlob/enable
> +echo > /sys/kernel/tracing/trace
> +
> +# Register probe before the target starts so the start uprobe fires on t=
he
> +# first entry to tlob_preempt_work. Budget: 500 ms.
> +echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=3D5000=
00" >
> "$TLOB_MONITOR"
> +
> +# Target starts; start probe fires on tlob_preempt_work entry.
> +taskset -c "$cpu" "$UPROBE_TARGET" 5000 preempt &
> +busy_pid=3D$!
> +sleep 0.05
> +
> +# RT hog on the same CPU preempts the target; target stays in waiting st=
ate
> +# (runnable, off-CPU) until the budget expires -> waiting_ns dominates.
> +chrt -f 99 taskset -c "$cpu" sh -c 'while true; do :; done' 2>/dev/null =
&
> +hog_pid=3D$!
> +
> +found=3D0; i=3D0
> +while [ "$i" -lt 30 ]; do
> +=09sleep 0.1
> +=09grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=3D1;
> break; }
> +=09i=3D$((i+1))
> +done
> +
> +echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
> +kill "$hog_pid" 2>/dev/null; wait "$hog_pid" 2>/dev/null || true
> +kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
> +echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 0 > monitors/tlob/enable
> +
> +[ "$found" =3D "1" ]
> +
> +line=3D$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
> +running=3D$(echo "$line" | sed 's/.*running_ns=3D\([0-9]*\).*/\1/')
> +sleeping=3D$(echo "$line" | sed 's/.*sleeping_ns=3D\([0-9]*\).*/\1/')
> +waiting=3D$(echo "$line" | sed 's/.*waiting_ns=3D\([0-9]*\).*/\1/')
> +[ "$waiting" -gt "$((running + sleeping))" ]
> +
> +echo > /sys/kernel/tracing/trace
> diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_mult=
i.tc
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
> new file mode 100644
> index 000000000000..c4b8f7108ae9
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test two uprobe bindings on same binary (different offset=
s
> fire independently)
> +# requires: tlob:monitor tlob_ioctl:program tlob_target:program
> +
> +TLOB_HELPER=3D$(command -v tlob_ioctl)
> +UPROBE_TARGET=3D$(command -v tlob_target)
> +TLOB_MONITOR=3Dmonitors/tlob/monitor
> +
> +busy_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_wor=
k
> 2>/dev/null)
> +busy_stop=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_work_=
done
> 2>/dev/null)
> +sleep_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_sleep_w=
ork
> 2>/dev/null)
> +sleep_stop=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_sleep_wor=
k_done
> 2>/dev/null)
> +[ -n "$busy_offset" ]=C2=A0 || exit_unsupported
> +[ -n "$busy_stop" ]=C2=A0=C2=A0=C2=A0 || exit_unsupported
> +[ -n "$sleep_offset" ] || exit_unsupported
> +[ -n "$sleep_stop" ]=C2=A0=C2=A0 || exit_unsupported
> +
> +"$UPROBE_TARGET" 30000 &=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # busy mode=
: tlob_busy_work fires every 200 ms
> +busy_pid=3D$!
> +"$UPROBE_TARGET" 30000 sleep & # sleep mode: tlob_sleep_work fires every=
 200
> ms
> +sleep_pid=3D$!
> +sleep 0.05
> +
> +echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/tracing_on
> +echo 1 > monitors/tlob/enable
> +echo > /sys/kernel/tracing/trace
> +
> +# Binding A: 5 s budget on the busy probe - must not fire in 200 ms loop=
s.
> +echo "p ${UPROBE_TARGET}:${busy_offset} ${busy_stop} threshold=3D5000000=
" >
> "$TLOB_MONITOR"
> +# Binding B: 10 ns budget on the sleep probe - fires on first invocation=
.
> +echo "p ${UPROBE_TARGET}:${sleep_offset} ${sleep_stop} threshold=3D10" >
> "$TLOB_MONITOR"
> +
> +# Wait up to 2 s for error_env_tlob from binding B.
> +found=3D0; i=3D0
> +while [ "$i" -lt 20 ]; do
> +=09sleep 0.1
> +=09grep -q "error_env_tlob" /sys/kernel/tracing/trace && { found=3D1;
> break; }
> +=09i=3D$((i+1))
> +done
> +
> +echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR" 2>/dev/null
> +echo "-${UPROBE_TARGET}:${sleep_offset}" > "$TLOB_MONITOR" 2>/dev/null
> +kill "$sleep_pid" 2>/dev/null; wait "$sleep_pid" 2>/dev/null || true
> +kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
> +
> +echo 0 > monitors/tlob/enable
> +echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +
> +[ "$found" =3D "1" ]
> +# error_env_tlob payload: label and clock variable must be present.
> +grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -q
> "budget_exceeded"
> +grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -q
> "clk_elapsed=3D"
> +# detail_env_tlob must appear alongside the error.
> +grep -q "detail_env_tlob" /sys/kernel/tracing/trace
> +
> +echo > /sys/kernel/tracing/trace
> diff --git
> a/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> new file mode 100644
> index 000000000000..4a74853346e3
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test no spurious error_env_tlob events without an active
> uprobe binding
> +# requires: tlob:monitor tlob_ioctl:program
> +
> +TLOB_MONITOR=3Dmonitors/tlob/monitor
> +
> +echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/tracing_on
> +echo 1 > monitors/tlob/enable
> +echo > /sys/kernel/tracing/trace
> +
> +sleep 0.5
> +
> +! grep -q "error_env_tlob" /sys/kernel/tracing/trace
> +
> +echo 0 > monitors/tlob/enable
> +echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo > /sys/kernel/tracing/trace
> diff --git
> a/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
> new file mode 100644
> index 000000000000..624fdb950f6b
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.t=
c
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test uprobe violation (error_env_tlob and detail_env_tlob=
 fire
> with correct fields)
> +# requires: tlob:monitor tlob_ioctl:program tlob_target:program
> +
> +TLOB_HELPER=3D$(command -v tlob_ioctl)
> +UPROBE_TARGET=3D$(command -v tlob_target)
> +TLOB_MONITOR=3Dmonitors/tlob/monitor
> +
> +busy_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_wor=
k
> 2>/dev/null)
> +stop_offset=3D$("$TLOB_HELPER" sym_offset "$UPROBE_TARGET" tlob_busy_wor=
k_done
> 2>/dev/null)
> +[ -n "$busy_offset" ] || exit_unsupported
> +[ -n "$stop_offset" ] || exit_unsupported
> +
> +"$UPROBE_TARGET" 30000 &
> +busy_pid=3D$!
> +sleep 0.05
> +
> +echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/tracing_on
> +echo 1 > monitors/tlob/enable
> +echo > /sys/kernel/tracing/trace
> +
> +# 10 ns budget - fires almost immediately; task is busy-spinning on-CPU.
> +echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=3D10" >
> "$TLOB_MONITOR"
> +
> +# wait up to 2 s for detail_env_tlob
> +found=3D0; i=3D0
> +while [ "$i" -lt 20 ]; do
> +=09sleep 0.1
> +=09grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=3D1;
> break; }
> +=09i=3D$((i+1))
> +done
> +
> +echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR" 2>/dev/null
> +kill "$busy_pid" 2>/dev/null; wait "$busy_pid" 2>/dev/null || true
> +echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 0 > monitors/tlob/enable
> +
> +[ "$found" =3D "1" ]
> +
> +# error_env_tlob event label must be budget_exceeded
> +grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -q
> "budget_exceeded"
> +
> +# detail_env_tlob must have all five fields with the correct threshold
> +line=3D$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
> +echo "$line" | grep -q "pid=3D"
> +echo "$line" | grep -q "threshold_us=3D10"
> +echo "$line" | grep -q "running_ns=3D"
> +echo "$line" | grep -q "waiting_ns=3D"
> +echo "$line" | grep -q "sleeping_ns=3D"
> +
> +# Busy-spin keeps the task on-CPU: running_ns must exceed sleeping_ns.
> +running=3D$(echo "$line" | sed 's/.*running_ns=3D\([0-9]*\).*/\1/')
> +sleeping=3D$(echo "$line" | sed 's/.*sleeping_ns=3D\([0-9]*\).*/\1/')
> +[ "$running" -gt "$sleeping" ]
> +
> +echo > /sys/kernel/tracing/trace
> diff --git a/tools/testing/selftests/verification/tlob/Makefile
> b/tools/testing/selftests/verification/tlob/Makefile
> new file mode 100644
> index 000000000000..1bedf946cb34
> --- /dev/null
> +++ b/tools/testing/selftests/verification/tlob/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Builds tlob selftest helper binaries.
> +#
> +# Invoked by ../Makefile; pass OUTDIR to control the output directory
> +# and TOOLS_INCLUDES for the in-tree UAPI -isystem flag.
> +
> +OUTDIR ?=3D $(CURDIR)/..
> +CFLAGS +=3D $(TOOLS_INCLUDES)
> +
> +.PHONY: all
> +all: $(OUTDIR)/tlob_ioctl $(OUTDIR)/tlob_target
> +
> +$(OUTDIR)/tlob_ioctl: tlob_ioctl.c
> +=09$(CC) $(CFLAGS) -o $@ $< -lpthread
> +
> +$(OUTDIR)/tlob_target: tlob_target.c
> +=09$(CC) $(CFLAGS) -o $@ $<
> +
> +.PHONY: clean
> +clean:
> +=09$(RM) $(OUTDIR)/tlob_ioctl $(OUTDIR)/tlob_target
> diff --git a/tools/testing/selftests/verification/tlob/tlob_ioctl.c
> b/tools/testing/selftests/verification/tlob/tlob_ioctl.c
> new file mode 100644
> index 000000000000..abb4e2e80a2c
> --- /dev/null
> +++ b/tools/testing/selftests/verification/tlob/tlob_ioctl.c
> @@ -0,0 +1,626 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tlob_ioctl.c - ioctl test driver and ELF utility for tlob selftests
> + *
> + * Usage: tlob_ioctl <subcommand> [args...]
> + *
> + *=C2=A0=C2=A0 not_enabled=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - TRACE_START without monitor enabled -> ENODEV
> + *=C2=A0=C2=A0 within_budget=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 sleep within budget -> 0
> + *=C2=A0=C2=A0 over_budget_running=C2=A0 - busy-spin past budget -> EOVE=
RFLOW
> + *=C2=A0=C2=A0 over_budget_sleeping - sleep past budget -> EOVERFLOW
> + *=C2=A0=C2=A0 over_budget_waiting=C2=A0 - sched_yield into waiting stat=
e -> EOVERFLOW
> + *=C2=A0=C2=A0 double_start=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - two starts without stop -> EALREADY
> + *=C2=A0=C2=A0 stop_no_start=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 stop without start -> EINVAL
> + *=C2=A0=C2=A0 multi_thread=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - two fds: thread A within budget, thread B over
> + *=C2=A0=C2=A0 bench=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TRACE_START/STOP latency (TAP out=
put, always
> passes)
> + *=C2=A0=C2=A0 sym_offset <binary> <symbol> - print ELF file offset of s=
ymbol
> + *
> + * Exit: 0 =3D pass, 1 =3D fail, 2 =3D skip (device not available).
> + */
> +#define _GNU_SOURCE
> +#include <elf.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#include <linux/rv.h>
> +
> +static int rv_fd =3D -1;
> +
> +static int open_rv(void)
> +{
> +=09struct rv_bind_args bind =3D { .monitor_name =3D "tlob" };
> +
> +=09rv_fd =3D open("/dev/rv", O_RDWR);
> +=09if (rv_fd < 0) {
> +=09=09fprintf(stderr, "open /dev/rv: %s\n", strerror(errno));
> +=09=09return -1;
> +=09}
> +=09if (ioctl(rv_fd, RV_IOCTL_BIND_MONITOR, &bind) < 0) {
> +=09=09fprintf(stderr, "bind tlob: %s\n", strerror(errno));
> +=09=09close(rv_fd);
> +=09=09rv_fd =3D -1;
> +=09=09return -1;
> +=09}
> +=09return 0;
> +}
> +
> +static void busy_spin_us(unsigned long us)
> +{
> +=09struct timespec start, now;
> +=09unsigned long elapsed;
> +
> +=09clock_gettime(CLOCK_MONOTONIC, &start);
> +=09do {
> +=09=09clock_gettime(CLOCK_MONOTONIC, &now);
> +=09=09elapsed =3D (unsigned long)(now.tv_sec - start.tv_sec)
> +=09=09=09=C2=A0 * 1000000000UL
> +=09=09=09+ (unsigned long)(now.tv_nsec - start.tv_nsec);
> +=09} while (elapsed < us * 1000UL);
> +}
> +
> +static int trace_start(uint64_t threshold_us)
> +{
> +=09struct tlob_start_args args =3D {
> +=09=09.threshold_us =3D threshold_us,
> +=09};
> +
> +=09return ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
> +}
> +
> +static int trace_stop(void)
> +{
> +=09return ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +}
> +
> +/* Synchronous TRACE_START / TRACE_STOP tests */
> +
> +/* Bind to a disabled monitor must return ENODEV without crashing */
> +static int test_not_enabled(void)
> +{
> +=09struct rv_bind_args bind =3D { .monitor_name =3D "tlob" };
> +=09int fd;
> +=09int ret;
> +
> +=09fd =3D open("/dev/rv", O_RDWR);
> +=09if (fd < 0) {
> +=09=09fprintf(stderr, "open /dev/rv: %s\n", strerror(errno));
> +=09=09return 2; /* skip */
> +=09}
> +
> +=09ret =3D ioctl(fd, RV_IOCTL_BIND_MONITOR, &bind);
> +=09close(fd);
> +
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "RV_IOCTL_BIND_MONITOR: expected ENODEV, got
> success\n");
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D ENODEV) {
> +=09=09fprintf(stderr, "RV_IOCTL_BIND_MONITOR: expected ENODEV, got
> %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +static int test_within_budget(void)
> +{
> +=09int ret;
> +
> +=09/* 50 ms budget */
> +=09if (trace_start(50000) < 0) {
> +=09=09fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +=09usleep(10000); /* 10 ms */
> +=09ret =3D trace_stop();
> +=09if (ret !=3D 0) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected 0, got %d errno=3D%s\n",
> +=09=09=09ret, strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +static int test_over_budget_running(void)
> +{
> +=09int ret;
> +
> +=09/* 1 ms budget */
> +=09if (trace_start(1000) < 0) {
> +=09=09fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +=09busy_spin_us(100000); /* 100 ms */
> +=09ret =3D trace_stop();
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got 0\n");
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EOVERFLOW) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +static int test_over_budget_sleeping(void)
> +{
> +=09int ret;
> +
> +=09/* 3 ms budget */
> +=09if (trace_start(3000) < 0) {
> +=09=09fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +=09usleep(50000); /* 50 ms; sleeping time counts toward budget */
> +=09ret =3D trace_stop();
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got 0\n");
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EOVERFLOW) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +static int test_over_budget_waiting(void)
> +{
> +=09int ret;
> +
> +=09/* 1 us budget */
> +=09if (trace_start(1) < 0) {
> +=09=09fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +=09sched_yield(); /* running -> waiting -> running */
> +=09busy_spin_us(10); /* 10 us >> 1 us budget; hrtimer fires during spin
> */
> +=09ret =3D trace_stop();
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got 0\n");
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EOVERFLOW) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +/* Error-handling tests */
> +
> +static int test_double_start(void)
> +{
> +=09int ret;
> +
> +=09/* 10 s: large enough the hrtimer won't fire during the test */
> +=09if (trace_start(10000000ULL) < 0) {
> +=09=09fprintf(stderr, "first TRACE_START: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +=09ret =3D trace_start(10000000);
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "second TRACE_START: expected EALREADY, got
> 0\n");
> +=09=09trace_stop();
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EALREADY) {
> +=09=09fprintf(stderr, "second TRACE_START: expected EALREADY, got
> %s\n",
> +=09=09=09strerror(errno));
> +=09=09trace_stop();
> +=09=09return 1;
> +=09}
> +=09trace_stop();
> +=09return 0;
> +}
> +
> +static int test_stop_no_start(void)
> +{
> +=09int ret;
> +
> +=09/* Ensure clean state: ignore error from a stale entry */
> +=09trace_stop();
> +
> +=09ret =3D trace_stop();
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EINVAL, got 0\n");
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EINVAL) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EINVAL, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +/* Two threads, each with its own fd: A within budget, B over budget. */
> +
> +struct mt_thread_args {
> +=09uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 threshold_us;
> +=09unsigned long workload_us;
> +=09int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 busy;
> +=09int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expec=
t_eoverflow;
> +=09int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resul=
t;
> +};
> +
> +static void *mt_thread_fn(void *arg)
> +{
> +=09struct mt_thread_args *a =3D arg;
> +=09struct tlob_start_args args =3D { .threshold_us =3D a->threshold_us }=
;
> +=09struct rv_bind_args bind =3D { .monitor_name =3D "tlob" };
> +=09int fd;
> +=09int ret;
> +
> +=09fd =3D open("/dev/rv", O_RDWR);
> +=09if (fd < 0) {
> +=09=09fprintf(stderr, "thread open /dev/rv: %s\n",
> strerror(errno));
> +=09=09a->result =3D 1;
> +=09=09return NULL;
> +=09}
> +=09if (ioctl(fd, RV_IOCTL_BIND_MONITOR, &bind) < 0) {
> +=09=09fprintf(stderr, "thread bind tlob: %s\n", strerror(errno));
> +=09=09close(fd);
> +=09=09a->result =3D 1;
> +=09=09return NULL;
> +=09}
> +
> +=09ret =3D ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
> +=09if (ret < 0) {
> +=09=09fprintf(stderr, "thread TRACE_START: %s\n", strerror(errno));
> +=09=09close(fd);
> +=09=09a->result =3D 1;
> +=09=09return NULL;
> +=09}
> +
> +=09if (a->busy)
> +=09=09busy_spin_us(a->workload_us);
> +=09else
> +=09=09usleep(a->workload_us);
> +
> +=09ret =3D ioctl(fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=09if (a->expect_eoverflow) {
> +=09=09if (ret =3D=3D 0 || errno !=3D EOVERFLOW) {
> +=09=09=09fprintf(stderr, "thread: expected EOVERFLOW, got
> ret=3D%d errno=3D%s\n",
> +=09=09=09=09ret, strerror(errno));
> +=09=09=09close(fd);
> +=09=09=09a->result =3D 1;
> +=09=09=09return NULL;
> +=09=09}
> +=09} else {
> +=09=09if (ret !=3D 0) {
> +=09=09=09fprintf(stderr, "thread: expected 0, got ret=3D%d
> errno=3D%s\n",
> +=09=09=09=09ret, strerror(errno));
> +=09=09=09close(fd);
> +=09=09=09a->result =3D 1;
> +=09=09=09return NULL;
> +=09=09}
> +=09}
> +=09close(fd);
> +=09a->result =3D 0;
> +=09return NULL;
> +}
> +
> +static int test_multi_thread(void)
> +{
> +=09pthread_t ta, tb;
> +=09struct mt_thread_args a =3D {
> +=09=09.threshold_us=C2=A0=C2=A0=C2=A0=C2=A0 =3D 20000,=C2=A0=C2=A0 /* 20=
 ms */
> +=09=09.workload_us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 5000,=C2=A0=C2=A0=
=C2=A0 /* 5 ms sleep -> within budget
> */
> +=09=09.busy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D 0,
> +=09=09.expect_eoverflow =3D 0,
> +=09};
> +=09struct mt_thread_args b =3D {
> +=09=09.threshold_us=C2=A0=C2=A0=C2=A0=C2=A0 =3D 3000,=C2=A0=C2=A0=C2=A0 =
/* 3 ms */
> +=09=09.workload_us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 30000,=C2=A0=C2=A0 =
/* 30 ms spin -> over budget */
> +=09=09.busy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D 1,
> +=09=09.expect_eoverflow =3D 1,
> +=09};
> +
> +=09pthread_create(&ta, NULL, mt_thread_fn, &a);
> +=09pthread_create(&tb, NULL, mt_thread_fn, &b);
> +=09pthread_join(ta, NULL);
> +=09pthread_join(tb, NULL);
> +
> +=09return (a.result || b.result) ? 1 : 0;
> +}
> +
> +/*
> + * Benchmark TRACE_START, TRACE_STOP, and round-trip ioctls.
> + * Output uses TAP '#' prefix; always returns 0.
> + */
> +#define BENCH_WARMUP=C2=A0 32
> +#define BENCH_N=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1000
> +
> +static long long timespec_diff_ns(const struct timespec *a,
> +=09=09=09=09=C2=A0=C2=A0 const struct timespec *b)
> +{
> +=09return (long long)(b->tv_sec - a->tv_sec) * 1000000000LL
> +=09=09+ (b->tv_nsec - a->tv_nsec);
> +}
> +
> +static int test_bench(void)
> +{
> +=09struct tlob_start_args args =3D {
> +=09=09.threshold_us =3D 10000000ULL, /* 10 s */
> +=09};
> +=09struct timespec t0, t1;
> +=09long long total_start_ns =3D 0, total_stop_ns =3D 0, total_rt_ns =3D =
0;
> +=09int i;
> +
> +=09/* warm up */
> +=09for (i =3D 0; i < BENCH_WARMUP; i++) {
> +=09=09if (ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args) =3D=3D 0)
> +=09=09=09ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=09}
> +
> +=09/* start only */
> +=09for (i =3D 0; i < BENCH_N; i++) {
> +=09=09clock_gettime(CLOCK_MONOTONIC, &t0);
> +=09=09ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
> +=09=09clock_gettime(CLOCK_MONOTONIC, &t1);
> +=09=09total_start_ns +=3D timespec_diff_ns(&t0, &t1);
> +=09=09ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=09}
> +
> +=09/* stop only */
> +=09for (i =3D 0; i < BENCH_N; i++) {
> +=09=09ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
> +=09=09clock_gettime(CLOCK_MONOTONIC, &t0);
> +=09=09ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=09=09clock_gettime(CLOCK_MONOTONIC, &t1);
> +=09=09total_stop_ns +=3D timespec_diff_ns(&t0, &t1);
> +=09}
> +
> +=09/* round-trip */
> +=09clock_gettime(CLOCK_MONOTONIC, &t0);
> +=09for (i =3D 0; i < BENCH_N; i++) {
> +=09=09ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
> +=09=09ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=09}
> +=09clock_gettime(CLOCK_MONOTONIC, &t1);
> +=09total_rt_ns =3D timespec_diff_ns(&t0, &t1);
> +
> +=09printf("# start ioctl only:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %lld ns/ite=
r (N=3D%d, includes
> syscall)\n",
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_start_ns / BENCH_N, BENCH_=
N);
> +=09printf("# stop ioctl only:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %lld n=
s/iter (N=3D%d, includes
> syscall)\n",
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_stop_ns / BENCH_N, BENCH_N=
);
> +=09printf("# start+stop roundtrip:=C2=A0 %lld ns/iter (N=3D%d, includes =
2
> syscalls)\n",
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_rt_ns / BENCH_N, BENCH_N);
> +=09return 0;
> +}
> +
> +/*
> + * Print the ELF file offset of <symname> in <binary>.=C2=A0 Walks .symt=
ab
> + * (falling back to .dynsym) and converts vaddr to file offset via PT_LO=
AD.
> + * Supports 32- and 64-bit ELF.
> + */
> +static int sym_offset(const char *binary, const char *symname)
> +{
> +=09int fd;
> +=09struct stat st;
> +=09void *map;
> +=09Elf64_Ehdr *ehdr;
> +=09Elf32_Ehdr *ehdr32;
> +=09int is64;
> +=09uint64_t sym_vaddr =3D 0;
> +=09int found =3D 0;
> +=09uint64_t file_offset =3D 0;
> +
> +=09fd =3D open(binary, O_RDONLY);
> +=09if (fd < 0) {
> +=09=09fprintf(stderr, "open %s: %s\n", binary, strerror(errno));
> +=09=09return 1;
> +=09}
> +=09if (fstat(fd, &st) < 0) {
> +=09=09close(fd);
> +=09=09return 1;
> +=09}
> +=09map =3D mmap(NULL, (size_t)st.st_size, PROT_READ, MAP_PRIVATE, fd, 0)=
;
> +=09close(fd);
> +=09if (map =3D=3D MAP_FAILED) {
> +=09=09fprintf(stderr, "mmap: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +
> +=09ehdr =3D (Elf64_Ehdr *)map;
> +=09ehdr32 =3D (Elf32_Ehdr *)map;
> +=09if (st.st_size < 4 ||
> +=09=C2=A0=C2=A0=C2=A0 ehdr->e_ident[EI_MAG0] !=3D ELFMAG0 ||
> +=09=C2=A0=C2=A0=C2=A0 ehdr->e_ident[EI_MAG1] !=3D ELFMAG1 ||
> +=09=C2=A0=C2=A0=C2=A0 ehdr->e_ident[EI_MAG2] !=3D ELFMAG2 ||
> +=09=C2=A0=C2=A0=C2=A0 ehdr->e_ident[EI_MAG3] !=3D ELFMAG3) {
> +=09=09fprintf(stderr, "%s: not an ELF file\n", binary);
> +=09=09munmap(map, (size_t)st.st_size);
> +=09=09return 1;
> +=09}
> +=09is64 =3D (ehdr->e_ident[EI_CLASS] =3D=3D ELFCLASS64);
> +
> +=09if (is64) {
> +=09=09Elf64_Shdr *shdrs =3D (Elf64_Shdr *)((char *)map + ehdr-
> >e_shoff);
> +=09=09Elf64_Shdr *shstrtab_hdr =3D &shdrs[ehdr->e_shstrndx];
> +=09=09const char *shstrtab =3D (char *)map + shstrtab_hdr->sh_offset;
> +=09=09int si;
> +
> +=09=09/* prefer .symtab; fall back to .dynsym */
> +=09=09for (int pass =3D 0; pass < 2 && !found; pass++) {
> +=09=09=09const char *target =3D pass ? ".dynsym" : ".symtab";
> +
> +=09=09=09for (si =3D 0; si < ehdr->e_shnum && !found; si++) {
> +=09=09=09=09Elf64_Shdr *sh =3D &shdrs[si];
> +=09=09=09=09const char *name =3D shstrtab + sh->sh_name;
> +
> +=09=09=09=09if (strcmp(name, target) !=3D 0)
> +=09=09=09=09=09continue;
> +
> +=09=09=09=09Elf64_Shdr *strtab_sh =3D &shdrs[sh->sh_link];
> +=09=09=09=09const char *strtab =3D (char *)map + strtab_sh-
> >sh_offset;
> +=09=09=09=09Elf64_Sym *syms =3D (Elf64_Sym *)((char *)map +
> sh->sh_offset);
> +=09=09=09=09uint64_t nsyms =3D sh->sh_size /
> sizeof(Elf64_Sym);
> +=09=09=09=09uint64_t j;
> +
> +=09=09=09=09for (j =3D 0; j < nsyms; j++) {
> +=09=09=09=09=09if (strcmp(strtab + syms[j].st_name,
> symname) =3D=3D 0) {
> +=09=09=09=09=09=09sym_vaddr =3D syms[j].st_value;
> +=09=09=09=09=09=09found =3D 1;
> +=09=09=09=09=09=09break;
> +=09=09=09=09=09}
> +=09=09=09=09}
> +=09=09=09}
> +=09=09}
> +
> +=09=09if (!found) {
> +=09=09=09fprintf(stderr, "symbol '%s' not found in %s\n",
> symname, binary);
> +=09=09=09munmap(map, (size_t)st.st_size);
> +=09=09=09return 1;
> +=09=09}
> +
> +=09=09/* Convert vaddr to file offset via PT_LOAD segments */
> +=09=09Elf64_Phdr *phdrs =3D (Elf64_Phdr *)((char *)map + ehdr-
> >e_phoff);
> +=09=09int pi;
> +
> +=09=09for (pi =3D 0; pi < ehdr->e_phnum; pi++) {
> +=09=09=09Elf64_Phdr *ph =3D &phdrs[pi];
> +
> +=09=09=09if (ph->p_type !=3D PT_LOAD)
> +=09=09=09=09continue;
> +=09=09=09if (sym_vaddr >=3D ph->p_vaddr &&
> +=09=09=09=C2=A0=C2=A0=C2=A0 sym_vaddr < ph->p_vaddr + ph->p_filesz) {
> +=09=09=09=09file_offset =3D sym_vaddr - ph->p_vaddr + ph-
> >p_offset;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09}
> +=09} else {
> +=09=09/* 32-bit ELF */
> +=09=09Elf32_Shdr *shdrs =3D (Elf32_Shdr *)((char *)map + ehdr32-
> >e_shoff);
> +=09=09Elf32_Shdr *shstrtab_hdr =3D &shdrs[ehdr32->e_shstrndx];
> +=09=09const char *shstrtab =3D (char *)map + shstrtab_hdr->sh_offset;
> +=09=09int si;
> +=09=09uint32_t sym_vaddr32 =3D 0;
> +
> +=09=09for (int pass =3D 0; pass < 2 && !found; pass++) {
> +=09=09=09const char *target =3D pass ? ".dynsym" : ".symtab";
> +
> +=09=09=09for (si =3D 0; si < ehdr32->e_shnum && !found; si++) {
> +=09=09=09=09Elf32_Shdr *sh =3D &shdrs[si];
> +=09=09=09=09const char *name =3D shstrtab + sh->sh_name;
> +
> +=09=09=09=09if (strcmp(name, target) !=3D 0)
> +=09=09=09=09=09continue;
> +
> +=09=09=09=09Elf32_Shdr *strtab_sh =3D &shdrs[sh->sh_link];
> +=09=09=09=09const char *strtab =3D (char *)map + strtab_sh-
> >sh_offset;
> +=09=09=09=09Elf32_Sym *syms =3D (Elf32_Sym *)((char *)map +
> sh->sh_offset);
> +=09=09=09=09uint32_t nsyms =3D sh->sh_size /
> sizeof(Elf32_Sym);
> +=09=09=09=09uint32_t j;
> +
> +=09=09=09=09for (j =3D 0; j < nsyms; j++) {
> +=09=09=09=09=09if (strcmp(strtab + syms[j].st_name,
> symname) =3D=3D 0) {
> +=09=09=09=09=09=09sym_vaddr32 =3D
> syms[j].st_value;
> +=09=09=09=09=09=09found =3D 1;
> +=09=09=09=09=09=09break;
> +=09=09=09=09=09}
> +=09=09=09=09}
> +=09=09=09}
> +=09=09}
> +
> +=09=09if (!found) {
> +=09=09=09fprintf(stderr, "symbol '%s' not found in %s\n",
> symname, binary);
> +=09=09=09munmap(map, (size_t)st.st_size);
> +=09=09=09return 1;
> +=09=09}
> +
> +=09=09Elf32_Phdr *phdrs =3D (Elf32_Phdr *)((char *)map + ehdr32-
> >e_phoff);
> +=09=09int pi;
> +
> +=09=09for (pi =3D 0; pi < ehdr32->e_phnum; pi++) {
> +=09=09=09Elf32_Phdr *ph =3D &phdrs[pi];
> +
> +=09=09=09if (ph->p_type !=3D PT_LOAD)
> +=09=09=09=09continue;
> +=09=09=09if (sym_vaddr32 >=3D ph->p_vaddr &&
> +=09=09=09=C2=A0=C2=A0=C2=A0 sym_vaddr32 < ph->p_vaddr + ph->p_filesz) {
> +=09=09=09=09file_offset =3D sym_vaddr32 - ph->p_vaddr + ph-
> >p_offset;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09}
> +=09=09sym_vaddr =3D sym_vaddr32;
> +=09}
> +
> +=09munmap(map, (size_t)st.st_size);
> +
> +=09if (!file_offset && sym_vaddr) {
> +=09=09fprintf(stderr, "could not map vaddr 0x%lx to file offset\n",
> +=09=09=09(unsigned long)sym_vaddr);
> +=09=09return 1;
> +=09}
> +
> +=09printf("0x%lx\n", (unsigned long)file_offset);
> +=09return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +=09int rc;
> +
> +=09if (argc < 2) {
> +=09=09fprintf(stderr, "Usage: %s <subcommand> [args...]\n",
> argv[0]);
> +=09=09return 1;
> +=09}
> +
> +=09/* sym_offset does not need /dev/rv */
> +=09if (strcmp(argv[1], "sym_offset") =3D=3D 0) {
> +=09=09if (argc < 4) {
> +=09=09=09fprintf(stderr, "Usage: %s sym_offset <binary>
> <symbol>\n",
> +=09=09=09=09argv[0]);
> +=09=09=09return 1;
> +=09=09}
> +=09=09return sym_offset(argv[2], argv[3]);
> +=09}
> +
> +=09/* not_enabled: monitor is disabled; bind must return ENODEV without
> open_rv() */
> +=09if (strcmp(argv[1], "not_enabled") =3D=3D 0)
> +=09=09return test_not_enabled();
> +
> +=09if (open_rv() < 0)
> +=09=09return 2; /* skip */
> +
> +=09if (strcmp(argv[1], "bench") =3D=3D 0)
> +=09=09rc =3D test_bench();
> +=09else if (strcmp(argv[1], "within_budget") =3D=3D 0)
> +=09=09rc =3D test_within_budget();
> +=09else if (strcmp(argv[1], "over_budget_running") =3D=3D 0)
> +=09=09rc =3D test_over_budget_running();
> +=09else if (strcmp(argv[1], "over_budget_sleeping") =3D=3D 0)
> +=09=09rc =3D test_over_budget_sleeping();
> +=09else if (strcmp(argv[1], "over_budget_waiting") =3D=3D 0)
> +=09=09rc =3D test_over_budget_waiting();
> +=09else if (strcmp(argv[1], "double_start") =3D=3D 0)
> +=09=09rc =3D test_double_start();
> +=09else if (strcmp(argv[1], "stop_no_start") =3D=3D 0)
> +=09=09rc =3D test_stop_no_start();
> +=09else if (strcmp(argv[1], "multi_thread") =3D=3D 0)
> +=09=09rc =3D test_multi_thread();
> +=09else {
> +=09=09fprintf(stderr, "Unknown test: %s\n", argv[1]);
> +=09=09rc =3D 1;
> +=09}
> +
> +=09close(rv_fd);
> +=09return rc;
> +}
> diff --git a/tools/testing/selftests/verification/tlob/tlob_target.c
> b/tools/testing/selftests/verification/tlob/tlob_target.c
> new file mode 100644
> index 000000000000..0fdbc575d71d
> --- /dev/null
> +++ b/tools/testing/selftests/verification/tlob/tlob_target.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tlob_target.c - uprobe target binary for tlob selftests.
> + *
> + * Provides three start/stop probe pairs, each designed to exercise a
> + * different dominant component of the detail_env_tlob ns breakdown:
> + *
> + *=C2=A0=C2=A0 tlob_busy_work=C2=A0=C2=A0=C2=A0 / tlob_busy_work_done=C2=
=A0=C2=A0=C2=A0 - busy-spin: running_ns
> dominates
> + *=C2=A0=C2=A0 tlob_sleep_work=C2=A0=C2=A0 / tlob_sleep_work_done=C2=A0=
=C2=A0 - nanosleep: sleeping_ns
> dominates
> + *=C2=A0=C2=A0 tlob_preempt_work / tlob_preempt_work_done - busy-spin: w=
aiting_ns
> dominates
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (needs an R=
T competitor on
> the same CPU)
> + *
> + * Usage: tlob_target <duration_ms> [mode]
> + *
> + * mode is one of: busy (default), sleep, preempt.
> + * Loops in 200 ms iterations until <duration_ms> has elapsed
> + * (0 =3D run for ~24 hours).
> + */
> +#define _GNU_SOURCE
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +
> +#ifndef noinline
> +#define noinline __attribute__((noinline))
> +#endif
> +
> +static inline int timespec_before(const struct timespec *a,
> +=09=09=09=09=C2=A0=C2=A0 const struct timespec *b)
> +{
> +=09return a->tv_sec < b->tv_sec ||
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (a->tv_sec =3D=3D b->tv_sec && a=
->tv_nsec < b->tv_nsec);
> +}
> +
> +static void timespec_add_ms(struct timespec *ts, unsigned long ms)
> +{
> +=09ts->tv_sec=C2=A0 +=3D ms / 1000;
> +=09ts->tv_nsec +=3D (long)(ms % 1000) * 1000000L;
> +=09if (ts->tv_nsec >=3D 1000000000L) {
> +=09=09ts->tv_sec++;
> +=09=09ts->tv_nsec -=3D 1000000000L;
> +=09}
> +}
> +
> +/* stop probe; noinline keeps the entry point visible to uprobes */
> +noinline void tlob_busy_work_done(void)
> +{
> +=09/* empty: uprobe fires on entry */
> +}
> +
> +/* start probe; busy-spin so running_ns dominates */
> +noinline void tlob_busy_work(unsigned long duration_ns)
> +{
> +=09struct timespec start, now;
> +=09unsigned long elapsed;
> +
> +=09clock_gettime(CLOCK_MONOTONIC, &start);
> +=09do {
> +=09=09clock_gettime(CLOCK_MONOTONIC, &now);
> +=09=09elapsed =3D (unsigned long)(now.tv_sec - start.tv_sec)
> +=09=09=09=C2=A0 * 1000000000UL
> +=09=09=09+ (unsigned long)(now.tv_nsec - start.tv_nsec);
> +=09} while (elapsed < duration_ns);
> +
> +=09tlob_busy_work_done();
> +}
> +
> +/* stop probe; noinline keeps the entry point visible to uprobes */
> +noinline void tlob_sleep_work_done(void)
> +{
> +=09/* empty: uprobe fires on entry */
> +}
> +
> +/* start probe; nanosleep so sleeping_ns dominates */
> +noinline void tlob_sleep_work(unsigned long duration_ms)
> +{
> +=09struct timespec ts =3D {
> +=09=09.tv_sec=C2=A0 =3D duration_ms / 1000,
> +=09=09.tv_nsec =3D (long)(duration_ms % 1000) * 1000000L,
> +=09};
> +=09nanosleep(&ts, NULL);
> +=09tlob_sleep_work_done();
> +}
> +
> +/* stop probe; noinline keeps the entry point visible to uprobes */
> +noinline void tlob_preempt_work_done(void)
> +{
> +=09/* empty: uprobe fires on entry */
> +}
> +
> +/*
> + * start probe; busy-spin so an RT competitor on the same CPU drives
> + * waiting_ns (prev_state=3D=3D0 -> preempt event, task stays runnable o=
ff-CPU).
> + */
> +noinline void tlob_preempt_work(unsigned long duration_ms)
> +{
> +=09struct timespec start, now;
> +=09unsigned long elapsed;
> +
> +=09clock_gettime(CLOCK_MONOTONIC, &start);
> +=09do {
> +=09=09clock_gettime(CLOCK_MONOTONIC, &now);
> +=09=09elapsed =3D (unsigned long)(now.tv_sec - start.tv_sec)
> +=09=09=09=C2=A0 * 1000000000UL
> +=09=09=09+ (unsigned long)(now.tv_nsec - start.tv_nsec);
> +=09} while (elapsed < duration_ms * 1000000UL);
> +
> +=09tlob_preempt_work_done();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +=09unsigned long duration_ms =3D 0;
> +=09const char *mode =3D "busy";
> +=09struct timespec deadline, now;
> +
> +=09if (argc >=3D 2)
> +=09=09duration_ms =3D strtoul(argv[1], NULL, 10);
> +=09if (argc >=3D 3)
> +=09=09mode =3D argv[2];
> +
> +=09clock_gettime(CLOCK_MONOTONIC, &deadline);
> +=09timespec_add_ms(&deadline, duration_ms ? duration_ms : 86400000UL);
> +
> +=09do {
> +=09=09if (strcmp(mode, "sleep") =3D=3D 0)
> +=09=09=09tlob_sleep_work(200);
> +=09=09else if (strcmp(mode, "preempt") =3D=3D 0)
> +=09=09=09tlob_preempt_work(200);
> +=09=09else
> +=09=09=09tlob_busy_work(200 * 1000000UL);
> +=09=09clock_gettime(CLOCK_MONOTONIC, &now);
> +=09} while (timespec_before(&now, &deadline));
> +
> +=09return 0;
> +}

