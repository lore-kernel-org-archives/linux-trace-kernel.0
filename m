Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F53BA232
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390060; cv=none; b=SJVAn2VJyMSh30lYTLB/nmYrX8c7XU5Z3bCyf1KOqfg/K210EBQD55BYy1kkZJai3rgzuK9ciKggO2LU0ZTccTeMKWQ/YAuBoEwQHsdcu9pbV+IFDGS9uFJRfFZ06H6wjw1x6FY1Lci2XDmWANK/yEsA0dmC2zD+woyNQkIH5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390060; c=relaxed/simple;
	bh=KwSSE5GKTMrpHocLPFAxvpIQWBfHKoK01mc+Kfj7IG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USkBIcQjGyv0AG+uRnaRO7zkzFFsHR7zPnkdwAaoMtRnSvenNXhlaTgpr1mmAv3pI03tVvDJAweoOXButXlaJj5UDaInQp5y+3sUZ9jWAEtK83b30s0vz6VCyaKnvjqRTbQQ4OgIdWyxDlIn+gqD6Xve+zVvdmkqS8VFySX5B6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V65ISbpI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V65ISbpI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777390055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwSSE5GKTMrpHocLPFAxvpIQWBfHKoK01mc+Kfj7IG4=;
	b=V65ISbpI19EI6Vv1vvlm6HGUed3mXbn70XNQS3ob8HqEqVwJHuLIot0MbTYZLO/IgxyFfS
	31u6iSQ9oXSQ6OoUgsakb8HwIxUwc2KokJ1GgOD+yRKku98cZyxuiNmHqC+4uUgyjZTMX/
	gb9IIzfxzEg9ovsnH333JJ76DlYU9IE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-x3lJnOTPO9KB2fuMmebBkQ-1; Tue, 28 Apr 2026 11:27:34 -0400
X-MC-Unique: x3lJnOTPO9KB2fuMmebBkQ-1
X-Mimecast-MFC-AGG-ID: x3lJnOTPO9KB2fuMmebBkQ_1777390054
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8f4ef450191so459107385a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 08:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390054; x=1777994854;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwSSE5GKTMrpHocLPFAxvpIQWBfHKoK01mc+Kfj7IG4=;
        b=Kyk3j1aFfSt8RF7dQuZdZb4fd2HHYfamXa0CtmTqDqMkcjNISuP9np/CWogpqmfu0S
         xwd2/C/PgjLQ0JCZvTwH+v+TCzRajRsZ/0tZr/zRw25SpSTqs9JvaXsfceAflGQwZKJc
         L3dVrXufe5xNxQDm677mp6aKurh33QopUsEJPJ6KLZtxm2UkL5hXp5L6v4WhqmkBhFmq
         iAcicseR0+OLT6UMVhJOI+KJBUU9Kk0719qRnXVGRjVF8wQm1fVTo0maDBlz3AS0g8gC
         mPtBCurEMPWBLAU7AdE4letE2ymVLxn+sEFIDUfJw2pgrQXXG35buFtWBQKTyWqc4TKo
         egmw==
X-Forwarded-Encrypted: i=1; AFNElJ/3oCHzYC6QHEkQP+nLR4zzoqd9P8dSqozR57+5+iyaO9XkJ6bA8WEkB25T0tbiIOhsg/v46BKQqRutYJCDg/5yI+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqVEhgXh6lwKnCj2D0AOG8RtktXX5lzfnDL/7Bt1UcYK7Fw/GF
	FB93SlFv2HDJivq26sPOhGsXJKeR0YPiU9lodcrukqZBkZMwt5Qtw/XJUeRQFTWPdmaRoEak07u
	a0pxq7zkEMNJ1EtIisy7Knm9ECY201On/Dwnwf7bHwvZLL6jhC9tYoxsPGPPewAGAKil/345AD1
	2WiMA/XA==
X-Gm-Gg: AeBDiev6pzKHMJPX4P5j93IcbWv0gQufeb68zhcgrJq9wn+prVNM8f2FnM3G6AMIPNM
	f72g+IkJNlleRtjH2/3RSu2Mz0sg8MmFP7pfr5lEoFultaSZr9kw7+By83DGYG7ZStwx906mo9B
	gpHVbvAeGhOcizs7KgLkvKwQt1OQQpZYuMCD7s5k7uhS9PmmUpW629FysDS7fdgE7y11Bl+LmbT
	XGzfDLq63vhOe5sYHNGjilOL0SG1TxIT0AZnxtP//nDCxuHncm5OTR1s8EETzkmjJ29wFLpQimv
	0QmLYFbN34pAMcSakOKweNy3iDjojJuSaiXOqX9qLR0jL7BDO+o4zpkSzp6vtVhaskbwfMQuCrK
	r65vBJ79Nuya00ElXsX/BnLRBuE1dCp3ydHZ5
X-Received: by 2002:a05:620a:460e:b0:8ca:fe5c:ea6d with SMTP id af79cd13be357-8f7d9e0e399mr457671985a.59.1777390053629;
        Tue, 28 Apr 2026 08:27:33 -0700 (PDT)
X-Received: by 2002:a05:620a:460e:b0:8ca:fe5c:ea6d with SMTP id af79cd13be357-8f7d9e0e399mr457664185a.59.1777390052961;
        Tue, 28 Apr 2026 08:27:32 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c49bcb30sm210089585a.1.2026.04.28.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:27:32 -0700 (PDT)
Message-ID: <33f6eb21d7283fa6647bd9ff3b745fd5918c8f1a.camel@redhat.com>
Subject: Re: [RFC PATCH 00/12] rv: Add selftests to tools and KUnit tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 28 Apr 2026 17:27:28 +0200
In-Reply-To: <d0c1fe9d-8d51-4c4f-897b-45444de1286d@linux.dev>
References: <20260427151134.192971-1-gmonaco@redhat.com>
	 <d0c1fe9d-8d51-4c4f-897b-45444de1286d@linux.dev>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YGjw5wnC4lV-xIyPGHhay1iK1_2Iwjh7gV44lMB6cyk_1777390054
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wen,

thanks for the review!

On Tue, 2026-04-28 at 23:09 +0800, Wen Yang wrote:
> Hi Gabriele,
>=20
> Good direction overall. The approach of calling event handlers
> directly inside KUnit is clean and avoids the complexity of setting
> up real tracepoints. Patches 1-4 (bug fixes) look correct.
>=20
> We are planning to build the KUnit and selftest coverage for the tlob
> monitor on top of this infrastructure, so getting this merged would
> be useful for us as well.

Great, for the time being, feel free to either base your work on this
series or only focus on the test cases, whichever is more comfortable
for you.

The RV kernel-side selftests are already upstream so that won't be a
blocker anyway.

> - One issue found in the KUnit patches:
>=20
> =C2=A0=C2=A0 patch 10: nomiss test
> =C2=A0=C2=A0 kernel/trace/rv/monitors/nomiss/nomiss.c:
> =C2=A0=C2=A0=C2=A0=C2=A0 udelay(10 / 1000);
>=20
> =C2=A0=C2=A0 The compiler folds it silently as udelay(0).
> =C2=A0=C2=A0 Presumably intended as udelay(10)?
>=20

Yes, that was quite a dumb oversight..

> - minor: copyright year range
> =C2=A0=C2=A0 rv_monitors_test.c: Copyright (C) 2025-2028
> =C2=A0=C2=A0 kunit_stubs.h:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Copyright (C) 2=
026-2029
>=20
> =C2=A0=C2=A0 Kernel copyright entries conventionally use only the year(s)=
 the
> work
> was actually created=EF=BC=8Ceg:
> https://lkml.indiana.edu/2510.0/01897.html
>=20

Right, I didn't notice that! Will update for the next submission.

>=20
> Reviewed-by: Wen Yang <wen.yang@linux.dev>
>=20

Thanks,
Gabriele

> --
> Best wishes,
> Wen
>=20
>=20
> > To: linux-trace-kernel@vger.kernel.org
> > To: linux-kernel@vger.kernel.org
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Nam Cao <namcao@linutronix.de>
> > Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
> > Cc: Tomas Glozar <tglozar@redhat.com>
> > Cc: John Kacur <jkacur@redhat.com>
> > Cc: Wen Yang <wen.yang@linux.dev>
> >=20
> > Gabriele Monaco (12):
> > =C2=A0=C2=A0 tools/rv: Fix substring match bug in monitor name search
> > =C2=A0=C2=A0 tools/rv: Fix substring match when listing container monit=
ors
> > =C2=A0=C2=A0 tools/rv: Fix exit status when monitor execution fails
> > =C2=A0=C2=A0 tools/rv: Fix cleanup after failed trace setup
> > =C2=A0=C2=A0 tools/rv: Add selftests
> > =C2=A0=C2=A0 verification/rvgen: Fix options shared among commands
> > =C2=A0=C2=A0 verification/rvgen: Add golden and spec folders for tests
> > =C2=A0=C2=A0 verification/rvgen: Add selftests
> > =C2=A0=C2=A0 rv: Add KUnit stub to rv_react() and rv_*_task_monitor_slo=
t()
> > =C2=A0=C2=A0 rv: Add KUnit tests for some DA/HA monitors
> > =C2=A0=C2=A0 rv: Add KUnit stubs for current and smp_processor_id()
> > =C2=A0=C2=A0 rv: Add KUnit tests for some LTL monitors
> >=20
> > =C2=A0 include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 32 +++
> > =C2=A0 include/rv/kunit_stubs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 17 ++
> > =C2=A0 include/rv/ltl_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 32 +++
> > =C2=A0 kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +
> > =C2=A0 kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A0 kernel/trace/rv/monitors/nomiss/nomiss.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 30 +++
> > =C2=A0 kernel/trace/rv/monitors/opid/opid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 ++
> > =C2=A0 .../trace/rv/monitors/pagefault/pagefault.c=C2=A0=C2=A0 |=C2=A0 =
26 +-
> > =C2=A0 kernel/trace/rv/monitors/sco/sco.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 ++
> > =C2=A0 kernel/trace/rv/monitors/sleep/sleep.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 64 ++++-
> > =C2=A0 kernel/trace/rv/monitors/sssw/sssw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 ++
> > =C2=A0 kernel/trace/rv/monitors/sts/sts.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 35 +++
> > =C2=A0 kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> > =C2=A0 kernel/trace/rv/rv_monitors_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 99 +++++++
> > =C2=A0 kernel/trace/rv/rv_monitors_test.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 90 +++++++
> > =C2=A0 kernel/trace/rv/rv_reactors.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 3 +
> > =C2=A0 tools/verification/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +=
-
> > =C2=A0 tools/verification/rv/src/in_kernel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 58 ++--
> > =C2=A0 tools/verification/rv/src/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +=
-
> > =C2=A0 tools/verification/rv/tests/rv_list.t=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 48 ++++
> > =C2=A0 tools/verification/rv/tests/rv_mon.t=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 95 +++++++
> > =C2=A0 tools/verification/rvgen/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > =C2=A0 tools/verification/rvgen/__main__.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +-
> > =C2=A0 .../rvgen/tests/golden/da_global/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 9 +
> > =C2=A0 .../rvgen/tests/golden/da_global/da_global.c=C2=A0 |=C2=A0 95 ++=
+++++
> > =C2=A0 .../rvgen/tests/golden/da_global/da_global.h=C2=A0 |=C2=A0 47 ++=
++
> > =C2=A0 .../tests/golden/da_global/da_global_trace.h=C2=A0 |=C2=A0 15 ++
> > =C2=A0 .../tests/golden/da_perobj_parent/Kconfig=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 11 +
> > =C2=A0 .../da_perobj_parent/da_perobj_parent.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 110 ++++++++
> > =C2=A0 .../da_perobj_parent/da_perobj_parent.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 64 +++++
> > =C2=A0 .../da_perobj_parent/da_perobj_parent_trace.h |=C2=A0 15 ++
> > =C2=A0 .../tests/golden/da_pertask_desc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 9 +
> > =C2=A0 .../golden/da_pertask_desc/da_pertask_desc.c=C2=A0 | 105 +++++++=
+
> > =C2=A0 .../golden/da_pertask_desc/da_pertask_desc.h=C2=A0 |=C2=A0 64 ++=
+++
> > =C2=A0 .../da_pertask_desc/da_pertask_desc_trace.h=C2=A0=C2=A0 |=C2=A0 =
15 ++
> > =C2=A0 .../rvgen/tests/golden/ha_percpu/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 9 +
> > =C2=A0 .../rvgen/tests/golden/ha_percpu/ha_percpu.c=C2=A0 | 244
> > +++++++++++++++++
> > =C2=A0 .../rvgen/tests/golden/ha_percpu/ha_percpu.h=C2=A0 |=C2=A0 72 ++=
+++
> > =C2=A0 .../tests/golden/ha_percpu/ha_percpu_trace.h=C2=A0 |=C2=A0 19 ++
> > =C2=A0 .../rvgen/tests/golden/ltl_pertask/Kconfig=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 9 +
> > =C2=A0 .../tests/golden/ltl_pertask/ltl_pertask.c=C2=A0=C2=A0=C2=A0 | 1=
07 ++++++++
> > =C2=A0 .../tests/golden/ltl_pertask/ltl_pertask.h=C2=A0=C2=A0=C2=A0 | 1=
08 ++++++++
> > =C2=A0 .../golden/ltl_pertask/ltl_pertask_trace.h=C2=A0=C2=A0=C2=A0 |=
=C2=A0 14 +
> > =C2=A0 .../rvgen/tests/golden/test_container/Kconfig |=C2=A0=C2=A0 5 +
> > =C2=A0 .../golden/test_container/test_container.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 35 +++
> > =C2=A0 .../golden/test_container/test_container.h=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +
> > =C2=A0 .../rvgen/tests/golden/test_da/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> > =C2=A0 .../rvgen/tests/golden/test_da/test_da.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 95 +++++++
> > =C2=A0 .../rvgen/tests/golden/test_da/test_da.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 47 ++++
> > =C2=A0 .../tests/golden/test_da/test_da_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 15 ++
> > =C2=A0 .../rvgen/tests/golden/test_ha/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> > =C2=A0 .../rvgen/tests/golden/test_ha/test_ha.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 247
> > ++++++++++++++++++
> > =C2=A0 .../rvgen/tests/golden/test_ha/test_ha.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 72 +++++
> > =C2=A0 .../tests/golden/test_ha/test_ha_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 19 ++
> > =C2=A0 .../rvgen/tests/golden/test_ltl/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 11 +
> > =C2=A0 .../rvgen/tests/golden/test_ltl/test_ltl.c=C2=A0=C2=A0=C2=A0 | 1=
08 ++++++++
> > =C2=A0 .../rvgen/tests/golden/test_ltl/test_ltl.h=C2=A0=C2=A0=C2=A0 | 1=
08 ++++++++
> > =C2=A0 .../tests/golden/test_ltl/test_ltl_trace.h=C2=A0=C2=A0=C2=A0 |=
=C2=A0 14 +
> > =C2=A0 .../rvgen/tests/rvgen_container.t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++
> > =C2=A0 .../verification/rvgen/tests/rvgen_monitor.t=C2=A0 |=C2=A0 87 ++=
++++
> > =C2=A0 .../rvgen/tests/specs/test_da.dot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++
> > =C2=A0 .../rvgen/tests/specs/test_da2.dot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 ++
> > =C2=A0 .../rvgen/tests/specs/test_ha.dot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 ++
> > =C2=A0 .../rvgen/tests/specs/test_invalid.dot=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> > =C2=A0 .../rvgen/tests/specs/test_invalid.ltl=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0 .../rvgen/tests/specs/test_invalid_ha.dot=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 16 ++
> > =C2=A0 .../rvgen/tests/specs/test_ltl.ltl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0 tools/verification/tests/engine.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 156 +++++++++++
> > =C2=A0 68 files changed, 2993 insertions(+), 44 deletions(-)
> > =C2=A0 create mode 100644 include/rv/kunit_stubs.h
> > =C2=A0 create mode 100644 kernel/trace/rv/rv_monitors_test.c
> > =C2=A0 create mode 100644 kernel/trace/rv/rv_monitors_test.h
> > =C2=A0 create mode 100644 tools/verification/rv/tests/rv_list.t
> > =C2=A0 create mode 100644 tools/verification/rv/tests/rv_mon.t
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_global/Kconfig
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_global/da_global.c
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_global/da_global.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_global/da_global_trace.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_perobj_parent/Kconfig
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_pa
> > rent.c
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_pa
> > rent.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_pa
> > rent_trace.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_pertask_desc/Kconfig
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_de
> > sc.c
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_de
> > sc.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_de
> > sc_trace.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/ha_percpu/Kconfig
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu_trace.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/ltl_pertask/Kconfig
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.c
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask_trace
> > .h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_container/Kconfig
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_container/test_container
> > .c
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_container/test_container
> > .h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_da/Kconfig
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_da/test_da.c
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_da/test_da.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_da/test_da_trace.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_ha/Kconfig
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_ha/test_ha.c
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_ha/test_ha.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_ha/test_ha_trace.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_ltl/Kconfig
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_ltl/test_ltl.c
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_ltl/test_ltl.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/golden/test_ltl/test_ltl_trace.h
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/rvgen_container.t
> > =C2=A0 create mode 100644 tools/verification/rvgen/tests/rvgen_monitor.=
t
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/specs/test_da.dot
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/specs/test_da2.dot
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/specs/test_ha.dot
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/specs/test_invalid.dot
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/specs/test_invalid.ltl
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/specs/test_invalid_ha.dot
> > =C2=A0 create mode 100644
> > tools/verification/rvgen/tests/specs/test_ltl.ltl
> > =C2=A0 create mode 100644 tools/verification/tests/engine.sh
> >=20
> >=20
> > base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

