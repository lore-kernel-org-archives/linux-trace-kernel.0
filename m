Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A52E3CBE6F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818717; cv=none; b=JKvzKCATty3H2Ur9Upz6emw7B4KJf5Mt3OgvKTX7G1RDe2Tu8RdptQPkXR9VgtDmoIrS021uXPCWE/NIYh9laZJ7hr870j/MWZl9qgH0LwKDRm9veyNP9x3H2PL2oLPB6bs2IkLfXwwsPi/mTqrAl6BZ+xKfECZcSn3UHcRMgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818717; c=relaxed/simple;
	bh=+f0CNIxvIeYqfF1de6wzqTeVVwJY0SE8+kB5zidrYPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTZMTbGFPR+iNhH3rEnplKIk1Vlqp3Lx1wthq8J5JgaKuSZnQwIyoHjBixF05BUyMdrF5J69ph+X4enj5xeKzHBAaPmOZylT8Xb09djT5QYxKihhRJAQavPCLs+W0As7iRDuEylXqolWSFhw9tOZzc9WaF2lCDB416Vfol8MYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpNESQ4F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpNESQ4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787818714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+f0CNIxvIeYqfF1de6wzqTeVVwJY0SE8+kB5zidrYPs=;
	b=SpNESQ4FTm0EOCkcTScKpjgxHbINKZ1pXZZV44lgUh61g5nAKOSgoBr/RyjZk2E3sRNTjx
	1s5UeCKc+PH4lkXZYsq1BfGuNV/PHnsOjg05qZnD2xf4xri92Ci39heDRDgJR14Gj+l/O9
	1THOh23VDpltV14mfpNhJHntUtEYhBA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-zgYsRDTZM1u3BoZJCKBG3g-1; Thu, 27 Aug 2026 04:18:33 -0400
X-MC-Unique: zgYsRDTZM1u3BoZJCKBG3g-1
X-Mimecast-MFC-AGG-ID: zgYsRDTZM1u3BoZJCKBG3g_1787818712
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a5e9603d71so615826a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 01:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787818712; x=1788423512;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+f0CNIxvIeYqfF1de6wzqTeVVwJY0SE8+kB5zidrYPs=;
        b=VA9/RVpoaqPjwk4DVM0MgrbQMDAbEYuXCfO91RaLxCLLw1bInBuGA/o2T6XeMkq21p
         a6QXZ0f75I8qW4rOlUsJFm7x9ookEd4wKVjxOL8JaYO+koy87ov37AOYUGgnokbqgDlv
         jvEQTjW6EMsvnTzXfFa88AnPlzkSJWnfsYZt8f8K0WUFSohRWCrUlh8L7QyASv5458T4
         x2tjZQYGBW9riWDGmilPWwnkhmhytCQmGpgKYt/Qsv66CXZzurcLJrn+92tVp46Jsqe0
         WE5bHuHMyQ+zzY4XimLnUvRL0Ak7kXutOAhwLMwbWxY/tMGZnNXTSpyeRLgYuMn1PuCG
         yaOg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4KxczrhpzrCfa8UBITONRwaiB9zs6a3+NIqSmk3O6FZFXQptYHnfPbUE2kZiIg78z6ZZcVWhP6FtabL3cHKMpGQo=@vger.kernel.org
X-Gm-Message-State: AFuF++kqbAVqZq4kzGB2iSqp65FKc76l/8M9wUJj3JzEIc0Fg8IONjFB
	j2ewn4WEYWIwQtbznLBmVUaKMmPk2+cYIAP6Ua8fl8KvnvszbXhobjn0jVY8zbF5UeadIabBQJH
	G0wVRSjbHzCb1e+pODyP2H5AMciCnDQD2YeWBz1jyg/fqEU3I6NHhhBdXbbjnLn+05uN+0D9zDp
	wGE8Kwx+Qk
X-Gm-Gg: AR+sD12DrvZwCZEnKyD7lAbGd3QUgkBa9YjMGsDsGQDJmg7RfUhz+uMsdkK0Y1Gs6b7
	NIBQgPOBCMyiUf8FK2FPm3NkUbYkWQp2iVlz4J9j0BkRI77lhQXZ4wG2IScLnSjgrSAHSoozKwr
	zahxHaiN6TxDAEOSwh6MG6zhlCT9X5IbKzxc+d7KpWoCpWLF2W5AInPQrk2JxUaFkJ5ouxrIxBg
	eJLd5C71hdDEXoQ0ecG94U7AFwX98X2Gq+zPsP6uAhGkvJmNDvunFxZgtTbtWs5Jin9mbEOpwMM
	VE1M6P25UpO6F42uh1xPwJnaeoufKQtIhwGtbyZsdMabQOHqtJKR/UQpBp/dMQG6DwqmIyrjIfF
	C0qwTEsRPji0Xg4kxbXsIW5ka1mJUxQzA4FK0MnomCEhcRqO+gJD1r7DTnmaPFC/Sog4diQ==
X-Received: by 2002:a17:907:c084:b0:c24:6382:2648 with SMTP id a640c23a62f3a-c2535f4bc77mr425514766b.5.1787818711794;
        Thu, 27 Aug 2026 01:18:31 -0700 (PDT)
X-Received: by 2002:a17:907:c084:b0:c24:6382:2648 with SMTP id a640c23a62f3a-c2535f4bc77mr425510966b.5.1787818711265;
        Thu, 27 Aug 2026 01:18:31 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c254ab6e16csm4939666b.11.2026.08.27.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:18:30 -0700 (PDT)
Message-ID: <40084ae4b7139fc20543a8989cdc349cf9b6bcdb.camel@redhat.com>
Subject: Re: [RFC 0/3] rv: per-edge dwell-time statistics for per-cpu
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jan Kiszka	
 <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 27 Aug 2026 10:18:29 +0200
In-Reply-To: <20260827072400.45734-1-tobias.schaffner@siemens.com>
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YbCk3zG2b5glbfL2QULRc4qgiV95PhCTFK2H6yEmEPY_1787818712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-27 at 09:23 +0200, Tobias Schaffner wrote:
> Hi Steven, Gabriele,
>=20
> I am using the RV system for a downstream project called EVL (aka Xenomai=
4).
> It is a small co-kernel system, small enough that I can model the whole
> co-kernel with RV instead of just a fragment of it.

Hi Tobias,

Haven't heard about Xenomai in a while.. That sounds very interesting.

Since it's something out-of-tree you likely don't want to submit monitors
upstream, but if you can trigger BPF events from your co-kernel you may wan=
t to
have a look at RV BPF monitors, which I'm likely going to submit in a coupl=
e of
days.

Otherwise we can always get out-of-tree monitors as modules, currently not
supported just out of a missing use-case.

> The patches in this series add a per-monitor "stats" file that exposes ho=
w
> often an edge has been visited and the dwell time in the prior state for
> per-cpu monitors.

The idea crossed my mind a few times, good you came up with an implementati=
on!

> This allows me to not only check if the model is correct but also to see =
if
> all paths are exercised by my stress tooling and to decompose the latency=
 of
> the co-kernel's wakeup path.

Your first need (see if all paths are exercised) doesn't really require the=
 stat
to be per-monitor-instance (i.e. per-cpu) right?
You could have a global accumulator matrix, at least for count and sum wher=
e you
can be atomic. This could extend the feature to other types of monitors.

Just brainstorming here though.

> I think that some of the upstream monitors like e.g. the sts monitor coul=
d
> also
> profit from this.
>=20
> As an example, here is the sts monitor on a StarFive VisionFive2 running =
an rt
> kernel (isolcpus=3D2-3), after enabling it and generating some scheduler =
load.
> Only the edges the automaton actually takes are non-zero:
>=20
> =C2=A0 # cat monitors/sched/sts/stats
> =C2=A0 # cpu edge label count max_ns sum_ns
> =C2=A0 0 0 can_sched:irq_disable 367732 3998500 14773091250
> =C2=A0 0 4 can_sched:schedule_entry 40282 398750 45510750
> =C2=A0 0 7 cant_sched:irq_enable 367732 32500 532791750
> =C2=A0 0 8 cant_sched:irq_entry 26188 6250 38357250
> =C2=A0 0 13 disable_to_switch:irq_enable 4933 12500 12275000
> =C2=A0 0 14 disable_to_switch:irq_entry 31 2250 35250
> =C2=A0 0 15 disable_to_switch:sched_switch 35373 26750 111615750
> =C2=A0 0 18 enable_to_exit:irq_disable 373 3250 649750
> =C2=A0 0 19 enable_to_exit:irq_enable 373 20000 1676250
> =C2=A0 0 20 enable_to_exit:irq_entry 309 4750 420000
> =C2=A0 0 23 enable_to_exit:schedule_exit 40298 3000 37335000
> =C2=A0 0 25 in_irq:irq_enable 31 12250 140750
> =C2=A0 0 30 scheduling:irq_disable 40337 18000 45449500
> =C2=A0 0 37 switching:irq_enable 35373 9250 72471000
> =C2=A0 [ cpus 1-2 omitted ]
> =C2=A0 3 0 can_sched:irq_disable 567 3983750 300860250
> =C2=A0 3 4 can_sched:schedule_entry 150 1500 171000
> =C2=A0 3 7 cant_sched:irq_enable 567 21500 1777500
> =C2=A0 3 8 cant_sched:irq_entry 76 6500 164750
> =C2=A0 3 15 disable_to_switch:sched_switch 150 4250 413750
> =C2=A0 3 23 enable_to_exit:schedule_exit 150 1500 147750
> =C2=A0 3 30 scheduling:irq_disable 150 1500 166000
> =C2=A0 3 37 switching:irq_enable 150 3750 277000
>=20
> The sts model splits the schedule->switch path into separate states, so t=
he
> per-edge dwell decomposes the scheduler's interrupts-off window: on cpu0 =
the
> prep phase (disable_to_switch, irqs off until the switch) tops out at 26.=
8us
> and the switch itself (switching:irq_enable) at 9.3us, over 35k switches.=
 The
> counts also line up with the model, e.g. every irq_disable in can_sched h=
as a
> matching irq_enable in cant_sched (367732 =3D=3D 367732). The isolated cp=
us 2-3
> take almost no switches (150 on cpu3, versus 35k on cpu0) and their worst=
 case
> is tighter still (~4us), so the same file also makes the effect of cpu
> isolation visible per cpu.
>=20
> The changes are gated by CONFIG_RV_EDGE_STAT and dormant until a monitor =
is
> enabled, so existing setups are unaffected. When enabled, each accepted
> transition adds one local_clock() and a few lock-free local64_t updates. =
With
> the config off there is no code on the hot path at all.
>=20
> I focused on per-cpu monitors as a first step. Per-task and per-object
> monitors would have to aggregate entities that share a cpu, which is hard=
er
> to get right, so I left them out for now.

As said before, I haven't really played with an implementation but I think
atomic types may help here.

> What is your opinion on this? Do you think this is worth getting upstream=
ed?

I will have a look at your patches but it's definitely something I'd want.

Thanks,
Gabriele

>=20
> Thanks for taking a look,
> Tobias
>=20
> Tobias Schaffner (3):
> =C2=A0 rv: add per-edge dwell-time statistics primitive
> =C2=A0 rv: add per-monitor edge-stat facility and stats file
> =C2=A0 rv: collect per-edge dwell time for per-cpu DA/HA monitors
>=20
> =C2=A0.../trace/rv/runtime-verification.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 24 ++++
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +++
> =C2=A0include/linux/rv_edge_stat.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 60 =
+++++++++
> =C2=A0include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 53 ++++++++
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 11 ++
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 116 +++++++++++++++++-
> =C2=A0tools/testing/selftests/verification/config=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0.../verification/test.d/rv_edge_stats.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 32 +++++
> =C2=A09 files changed, 315 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 include/linux/rv_edge_stat.h
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_edge_stats.tc

