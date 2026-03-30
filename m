Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976139B497
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899823; cv=none; b=JBaXEmJGWYbyYlYxRQdRO4trQtQLE1U2DKe+/ccJtePMvBHLri7tCJD1YrruPg5pPBZPiRCtJLdwuW1E7gB6KSx0utt1fFIFoPWOMge8Jb1wSF0egixRN+ETt3yAqkafVQn0V9SkvOUYtCd22aqNPoyn3ZXktbwg9wzvBdkI5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899823; c=relaxed/simple;
	bh=u+e51JPK1ApSyg41ozmpJdiOBjK1j7xRSHnZwyv89yc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e39nAMpHflArfhjnI3l6qOS/FRjjhu8CAtBZeVSGOvl3EiqYnebaDCHyLmBjwwi5+9yatK0FLTi0twCqeZ473TQxzTBV1RUcySj+9+9Y7l7U0OnqHHOdjwRudO6/5b2mxHH4JwQwL6AwX/PTk6n95YlFFRRl+ler+SzHQ33SOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoOhn033; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoOhn033"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+e51JPK1ApSyg41ozmpJdiOBjK1j7xRSHnZwyv89yc=;
	b=QoOhn033yX4Eb0HHNxSr2FadEMFcf/BLE9xmqRyB5Boupc7zdURFreP0gCWR9qCGgx198q
	HUntc8l+hFO/Sc7TdbnNamcuZaBcQIz8/1JjNS1KDzLWAKOf+Uk4dDGYWklii0jYCghA8i
	Z/GayvWKosFKB8rsDRmid1iDqHuzqIk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-Vt3atgSTP4aocXM2xYeJoQ-1; Mon, 30 Mar 2026 15:43:38 -0400
X-MC-Unique: Vt3atgSTP4aocXM2xYeJoQ-1
X-Mimecast-MFC-AGG-ID: Vt3atgSTP4aocXM2xYeJoQ_1774899817
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cfbeca17b2so1531994885a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 12:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899817; x=1775504617;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aC/cFt2iQduSHQ8V1HFfbWtU0eGISoNoWwZWIDsjMfE=;
        b=LweEzj1vcGGDIaHCWMotdYXfxeS63cZiP96Eli+R1IhbzFymdIT47s2NcQ8cvifl2p
         +YpG5Pt/l7I4YyyZdlyILWZ4aC/YNDDq5WUcUWOS0iaYN0WIAzunCKl6e8lB+tZiLJ3q
         Tnpi5VBAlSFfKXY3n2ah99ChjON0U/guUFOHsgdz93H8Rf1asnjm9QZ4r53gAMMPeoYk
         RS9SA8Q39tkQbFgX76J++s8cguOYlJczNgqScqKSOrzArCdui2dWdIVQrYl44HU7LyCs
         rXElrTkldFFsc8EP6JVRqfmqx2zQbdbVZKDPnuqSS+akSn8wcW3H18Kuu8DOQX4wiEfC
         PtYA==
X-Forwarded-Encrypted: i=1; AJvYcCUPfEnOuEU6VbRHLjXeUmkhvzQrbyEcYMhJDw9jmCBCHpP3k8GLWp2Ak6XcUZtMJL0S5uevD3DPRf9MkEil4T2PeHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJ0Mf2JbVw91WpMCxrO1ncf0Fw7wQ1wgzmFEkjhnojS9c67v0
	nU5L+8HEmxsCYwucweMk7zNegeWoigVZjkfpFyY4B1faHffqbR0VgETKvyaDTUwsPC+fhxgWTrP
	Jj+3RVmoJf92Kpitp3GRfezZ/LOSZLNeiIBFmxudMMBF6guXexSRAffkBdJkiW9ykbNlHKCrR/K
	PNPd/0eQ==
X-Gm-Gg: ATEYQzzEjaty+dzMulHim65GVCqc5tpx3BJICuKXGJYg9054Nv0O3qAuAknd7JqC6nZ
	Y2Mhyv9nshKxoxjZn9youhwRy3TOiF32Xh03gLx4DbbEwcsUdeXI1DczQb8VmiWbbbgWS+yT6T7
	COLvqiAkBjqYzErg2KK7ZGDEpfNX22IXqLf1eu5hBc62HQrtJjV6AtKiOjhHqDzsa1VQtJhTh7F
	L1nTodwt0tkII+v8/K7p0orT2bkQurhnLZO+5Si2QQakfZZY8kp579h8ibMQJBDpp/09CktnFSr
	UaIGeyB+Q8Xp8ECrPEdS6Dn/HadyTHvuZzJakgDgh/AsBKj7C8NDENqQD8zm8CyNdxTUZsAsOnK
	conUJabsz3g5dGTJ8NRXfuUJTA4So9PRnxjTJ8F/uawx0veUzPMg=
X-Received: by 2002:a05:620a:4807:b0:8cf:c58e:f056 with SMTP id af79cd13be357-8d1aa67bedemr115414685a.24.1774899817068;
        Mon, 30 Mar 2026 12:43:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4807:b0:8cf:c58e:f056 with SMTP id af79cd13be357-8d1aa67bedemr115412185a.24.1774899816620;
        Mon, 30 Mar 2026 12:43:36 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027f29135sm677016785a.20.2026.03.30.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:43:36 -0700 (PDT)
Message-ID: <829e7da72cf2b3b9bdc766786d1d5eea88b61f3c.camel@redhat.com>
Subject: Re: [PATCH v2] tracing/osnoise: Add option to align tlat threads
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
  Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, John Kacur
	 <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin
	 <costa.shul@redhat.com>, Wander Lairson Costa <wander@redhat.com>, LKML
	 <linux-kernel@vger.kernel.org>, linux-trace-kernel
	 <linux-trace-kernel@vger.kernel.org>
Date: Mon, 30 Mar 2026 14:43:35 -0500
In-Reply-To: <20260302131316.385987-1-tglozar@redhat.com>
References: <20260302131316.385987-1-tglozar@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WHgB26mlHC9spLOa2mYLVXKx_ZOmXRW90TYAI0drotE_1774899817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-03-02 at 14:13 +0100, Tomas Glozar wrote:
> Add an option called TIMERLAT_ALIGN to osnoise/options, together with a
> corresponding setting osnoise/timerlat_align_us.
>=20
> This option sets the alignment of wakeup times between different
> timerlat threads, similarly to cyclictest's -A/--aligned option. If
> TIMERLAT_ALIGN is set, the first thread that reaches the first cycle
> records its first wake-up time. Each following thread sets its first
> wake-up time to a fixed offset from the recorded time, and increments
> it by the same offset.
>=20
> Example:
>=20
> osnoise/timerlat_period is set to 1000, osnoise/timerlat_align_us is
> set to 20. There are four threads, on CPUs 1 to 4.
>=20
> - CPU 4 enters first cycle first. The current time is 20000us, so
> the wake-up of the first cycle is set to 21000us. This time is recorded.
> - CPU 2 enter first cycle next. It reads the recorded time, increments
> it to 21020us, and uses this value as its own wake-up time for the first
> cycle.
> - CPU 3 enters first cycle next. It reads the recorded time, increments
> it to 21040 us, and uses the value as its own wake-up time.
> - CPU 1 proceeds analogically.
>=20
> In each next cycle, the wake-up time (called "absolute period" in
> timerlat code) is incremented by the (relative) period of 1000us. Thus,
> the wake-ups in the following cycles (provided the times are reached and
> not in the past) will be as follows:
>=20
> CPU 1=09=09CPU 2=09=09CPU 3=09 =09CPU 4
> 21080us=09=0921020us=09=0921040us=09=0921000us
> 22080us=09=0922020us=09=0922040us=09=0922000us
> ...=09=09...=09=09...=09=09...
>=20
> Even if any cycle is skipped due to e.g. the first cycle calculation
> happening later, the alignment stays in place.
>=20
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

Reviewed-by: Crystal Wood <crwood@redhat.com>

-Crystal

