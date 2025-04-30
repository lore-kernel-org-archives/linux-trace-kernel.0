Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326E25B1E8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Apr 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015461; cv=none; b=BnT+nKnSfushGHjPHA/yA+NLOEqUfByzPexeUX/ljeSJ5UamjI9ZJIZpgZIEdDGJRrKVZ5Y/vb6tKNUlPwYEb/hat91J8LsL1OaxXX36KIUyvoJ8f//ZNwsaiW4dlWw+YmagALeC1zCmfkHqJpHPHBBoCRsAVbBVBa79vvr1RcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015461; c=relaxed/simple;
	bh=lN3XXhvZkEzmXtYd28YKRe70tCct3jaUfGTuQGGD+g0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evJwF4/U0JfdI5PVK3uIQVR73nQG8e9o5PR9zmDkMaR33EApdroDNHWucN5GIuChLE6qjwXxQ9j6Tjao31SRAq+5pXTkccMgfl1AqxO6XHSE+9H//+RUyGCcSGnMJVX0m7G6EPknUPjd3WkRcVDMB8KAt84FMkMXy2nvxOE2By4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2CQVZ2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2CQVZ2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746015458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lN3XXhvZkEzmXtYd28YKRe70tCct3jaUfGTuQGGD+g0=;
	b=T2CQVZ2mL83JOSTcM2T77Emu6LfwR4F6fFN43OjjNXl5c/hfGg1DW1m8n1zqUMXszlQhiB
	x6d5cNHseyi0ySegpwj6Os9hsoSCSyBGmp+iuu8UEzRcQ3+wVt0qOhazyBN0TjfvqWfbek
	0wEFILA3ebPnuoAFlaLeGtq0x//IaIs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-p3-9ZubsNW6P_hQ0fO3lRg-1; Wed, 30 Apr 2025 08:17:35 -0400
X-MC-Unique: p3-9ZubsNW6P_hQ0fO3lRg-1
X-Mimecast-MFC-AGG-ID: p3-9ZubsNW6P_hQ0fO3lRg_1746015454
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43f251dc364so39189065e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Apr 2025 05:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746015454; x=1746620254;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN3XXhvZkEzmXtYd28YKRe70tCct3jaUfGTuQGGD+g0=;
        b=rCxc15HZEEsyj8bhPPzI8+EwbUn8bNgd+dFwKDfpGk7iH/SnsfSKXpvyv8kIa+3B8c
         RtLiP4jZ4ykbX4npmAiRZfYJ8ig2YDT6pxqzWRuIejA/SuavnAufTONnVhfwpPURGFtl
         T5eyDtzDCuEd//l0P8Etlbtm+5Ks5yUXhvmFKOHu0GXDAt2J6X2Ytn8D3mO02p7km7kD
         CrYurX8Oh5CT0OPSpYgUbkO2SBNOVbgAyfbJo+so1VxAD/aNn+GqxZlnmgdY5cCzmi8w
         Xzatb0BTpFp3HPwi8JFj51l4d1KAw2+hQralqfpS8pdI6yI2X59rs/T2Y0jtm2t5yYGR
         IK2g==
X-Forwarded-Encrypted: i=1; AJvYcCUitx34zbSpozMgZ3rRjyKp/uORDY5Y2Vtet9Ry4zXTSBsLO/c6KFYGchiEhKEmHCYMI5X6nV1ympDjvc9vFDtBd78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4me0zKs5O07bogZ1wHnfWMqmJgFndALsjd2jibd8+iNlcnDm8
	Gpxnix6a+1eYqpCy3XUKAtYvtk5Yxpx0dEtgqgtoowiII8p29ZjWqFPiP8Ud0uYHQCun1aR9IXn
	xSc3u56UIplSD9GGdYP+O9xYupCf3Du7gt++d0GCy/yiADNJHqEd2eS2bdQGBsoKdK9fivg==
X-Gm-Gg: ASbGncuWaVVwnkF+0rXWk8HodBz7wrbe5XZNXZGLPNbHVdgMq6vwgVYkREfJkIp8oQy
	NEom2nfKd/6HagqbLoWSUeg9+SHAKOd8ZUXwF09UV8aITRkgVgBrz5nN5wzv13KiHKMnvpA/HOZ
	SJOTEk+qYPVARqlBfNvl1X7DKV5mgA+YKq3HakIkgmCGxH5wuVyLNA3LRKXoym+eKUw1nvFAG0O
	EEH/UDDTiond7WPTBZfU9xrblqfMyeGqAHwql0dnhfu0jY3dGK9e52puO16eMYSEoN8Own70+NY
	+5opnmf28uq/xBzHyfvG4SyOAotF3nG3+Ojo2A==
X-Received: by 2002:a05:600c:3b08:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-441b43a6849mr12659175e9.31.1746015454191;
        Wed, 30 Apr 2025 05:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeDRQpH85Tjf5lCeTC38YV5zFGOEEWEJ15Q43zpvFHsUBUREIV9t8rFVVspwP+av3krGaKQA==
X-Received: by 2002:a05:600c:3b08:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-441b43a6849mr12658865e9.31.1746015453815;
        Wed, 30 Apr 2025 05:17:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af2a9dsm23611265e9.19.2025.04.30.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:17:33 -0700 (PDT)
Message-ID: <cbcefdb80d5e10b8fed80de17bb97bf61df81386.camel@redhat.com>
Subject: Re: [PATCH v6 00/22] RV: Linear temporal logic monitors for RT
 application
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, john.ogness@linutronix.de, Petr Mladek	
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Ingo
 Molnar	 <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav
 Petkov	 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin"	 <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra	 <peterz@infradead.org>, Catalin Marinas
 <catalin.marinas@arm.com>, 	linux-arm-kernel@lists.infradead.org, Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 30 Apr 2025 14:17:30 +0200
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HGgdOnDOo60vyKB14_W5zfburpfm_WfoH_lvkOz7b60_1746015454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-04-30 at 13:02 +0200, Nam Cao wrote:
> Real-time applications may have design flaws causing them to have
> unexpected latency. For example, the applications may raise page
> faults, or
> may be blocked trying to take a mutex without priority inheritance.
>=20
> However, while attempting to implement DA monitors for these real-
> time
> rules, deterministic automaton is found to be inappropriate as the
> specification language. The automaton is complicated, hard to
> understand,
> and error-prone.
>=20
> For these cases, linear temporal logic is found to be more suitable.
> The
> LTL is more concise and intuitive.
>=20
> This series adds support for LTL RV monitor, and use it to implement
> two
> monitors for reporting problems with real-time tasks.
>=20

Steve,

From my point of view this series is ready for inclusion, what do you
think?

We may still need Acks from the x86 and arm64 maintainers regarding the
tracepoints changes, though.

Thanks,
Gabriele

> Patch 1-12 cleanup and prepare the RV code for the integration of LTL
> monitors.
>=20
> Patch 13 adds support for LTL monitors.
>=20
> Patch 14 adds the container monitor "rtapp". This encapsulates the
> sub-monitors for real-time.
>=20
> Patch 15-18 prepares the pagefault tracepoints, so that patch 19 can
> add
> the monitor which watches real-time tasks doing page faults.
>=20
> Patch 20 adds the "sleep" monitor: it detects potential undesirable
> latency
> with real-time threads.
>=20
> Patch 21 adds documentation on the new monitors.
>=20
> Patch 22 allows the number of per-task monitors to be configurable,
> so that
> the two new monitors can be enabled simultaneously.
>=20
> v5->v6
> https://lore.kernel.org/lkml/cover.1745926331.git.namcao@linutronix.de
> =C2=A0 - sleep monitor: Drop the block_on_rt_mutex tracepoints. The
> contention
> =C2=A0=C2=A0=C2=A0 tracepoints are sufficient.
>=20
> v4->v5
> https://lore.kernel.org/lkml/cover.1745390829.git.namcao@linutronix.de
> =C2=A0 - sleep monitor: Fix a false positive due to a race with waking an=
d
> =C2=A0=C2=A0=C2=A0 scheduling.
> =C2=A0 - sleep monitor: Add block_on_rt_mutex tracepoints and use them fo=
r
> =C2=A0=C2=A0=C2=A0 BLOCK_ON_RT_MUTEX, instead of trace_sched_pi_setprio
> =C2=A0 - sleep monitor: tighten the rule on nanosleep: only
> clock_nanosleep()
> =C2=A0=C2=A0=C2=A0 with TIMER_ABSTIME and CLOCK_MONOTONIC is allowed
> =C2=A0 - add comments explaining why it is correct to treat PI-boosted
> tasks as
> =C2=A0=C2=A0=C2=A0 real-time tasks.
>=20
> =C2=A0=C2=A0=C2=A0 It should be noted that due to the changes in v5, 'per=
f' does not
> work
> =C2=A0=C2=A0=C2=A0 as well as before, because sometimes the errors happen=
 out of the
> =C2=A0=C2=A0=C2=A0 real-time tasks' contexts. Fixing this is left for fut=
ure work.
>=20
> =C2=A0=C2=A0=C2=A0 stress-ng is also far noisier in v5, because the rule =
on
> nanosleep is
> =C2=A0=C2=A0=C2=A0 tightened.
>=20
> v3->v4
> https://lore.kernel.org/lkml/cover.1744785335.git.namcao@linutronix.de
> =C2=A0 - support deadline tasks
> =C2=A0 - rtapp_sleep: use sched_pi_setprio tracepoint instead of
> contention
> =C2=A0=C2=A0=C2=A0 tracepoints for BLOCK_ON_RT_MUTEX, so that proxy lock =
is covered.
> =C2=A0 - fix the scripts generating an "slightly" incorrect verification
> automaton
> =C2=A0 - makes rtapp monitor depends on RV_PER_TASK_MONITORS >=3D 2
> =C2=A0 - make the event tracepoint output a bit more readable
> =C2=A0 - some documentation's format fixes
>=20
> v2->v3
> https://lore.kernel.org/lkml/cover.1744355018.git.namcao@linutronix.de/
> =C2=A0 - fix a problem with sleep monitor's specification (around
> =C2=A0=C2=A0=C2=A0 KTHREAD_SHOULD_STOP)
> =C2=A0 - merge the patches that move the dot2k/rvgen scripts around
> =C2=A0 - pull panic/printk changes into separate patches
> =C2=A0 - fixup some build errors
> =C2=A0 - fixup monitor's init function return code
> =C2=A0 - fix some flake8 warnings with the scripts
> =C2=A0 - add some references to LTL documentation
> =C2=A0 - fixup some mistakes with rtapp documentation
> =C2=A0 - fixup capitalization mistake with monitor_synthesis.rst
> =C2=A0 - remove the now-redundant macro RV_PER_TASK_MONITORS
>=20
> v1->v2
> https://lore.kernel.org/lkml/cover.1741708239.git.namcao@linutronix.de/
> =C2=A0 - Integrate the LTL scripts into the existing dot2k tool, taking
> =C2=A0=C2=A0=C2=A0 advantage of the existing monitor generation scripts.
> =C2=A0 - Switch the struct ltl_monitor to use bitmap instead of an array,
> to
> =C2=A0=C2=A0=C2=A0 optimize memory usage.
> =C2=A0 - Correct the generated code to be non-deterministic state machine=
,
> =C2=A0=C2=A0=C2=A0 instead of deterministic state machine
> =C2=A0 - Put common code for all LTL monitors into a single file
> =C2=A0=C2=A0=C2=A0 (include/rv/ltl_monitor.h), reducing code duplication
> =C2=A0 - Change the LTL monitors to make user of container. Add a bug fix
> to
> =C2=A0=C2=A0=C2=A0 container while at it.
> =C2=A0 - Make the number of per-task monitor configurable

