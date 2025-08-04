Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7591F4617
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305483; cv=none; b=dOvrYr58NKXgEF3tkjXfdzikXlpV+wZfpAGLhcZHJ92T0vWQZ8VI/KAYRqPa/j8q9nBJVo1fRWn0Z27801wohKBqW/fApnnAoTmeAt9kNUNrkx7WSpR6vFNyqLPwi3/NxSrkaKoD0nia776f4/yvpSJcxTwLKpyfZ2eh1pOBJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305483; c=relaxed/simple;
	bh=AlMaGkAWIp33XVD6gYnhzdujTiQCBHSv7RY66Elv5fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjkSM4RwJd4CpyUUTajwk4mfXYoUgGiSS79hM4WQ27BmRyc6Gb2cnNbpjXkOBAYCIzzharJYTUIlIyMWjMTpZR2BMb50CsJjd0XvNW6K19qNoXXMpjuNFjvm4vHOiAfZRnDT5U/uhrP4Kjk+6V+yKfvioWa1H6w6S2+hkBkTf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyE6WMyd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyE6WMyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754305480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlMaGkAWIp33XVD6gYnhzdujTiQCBHSv7RY66Elv5fs=;
	b=UyE6WMydZkKWGDa8YOxvZBBUyN8ZV9vwetyXyBgGVIDdbXUpKGMHmXiLEg1NcmfAJ/qWQF
	yQDryGtGt43EXw0nqr1uEtd6Jt7/GybgytYNGoUesoOrzWQBo+aIR5voHL0IksHzA+n4HP
	t7tx9ZaJyT+oEuOn1QYQPW8cQ5iUKTc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-cEdKM-RONnaI7ZyizUVUkg-1; Mon, 04 Aug 2025 07:04:39 -0400
X-MC-Unique: cEdKM-RONnaI7ZyizUVUkg-1
X-Mimecast-MFC-AGG-ID: cEdKM-RONnaI7ZyizUVUkg_1754305479
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-af92f13d2abso197394966b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754305478; x=1754910278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlMaGkAWIp33XVD6gYnhzdujTiQCBHSv7RY66Elv5fs=;
        b=vQm/O9Sa9HSHP7UAhSlT541yJ8jXp2R1yOvjG1lqYBK9Y55UZULCPR5g7sV1bjiM0H
         iBhb5h5HPEGCQzaKfJX7z4D0pzaU+uZ8d2oABLIoyCNQDJbOc6BsT6FsUjtUn7K9wDOm
         bugPg7U6DkOPgtFSr73LJyG+ArCP+ligInqN7L9MvRFvomkBvE8mcYn11+SCqMXoF6yz
         lS9OnQSF54roQqOjXF/1lCokeZaSvuxwxsUaIOzk/9xhGQDOIjOULCtLDhtmbgMAYGdq
         CLdpR31VGHRKuEEET3wkL0EMCHPaPHSnGEEd2yDNEuOwPJDZe41xukU39UFBshB/vbLA
         zvSg==
X-Forwarded-Encrypted: i=1; AJvYcCWyPji6mNafbRtl+BrYWSZtq7aH7UQX1rbnSTAoQLtcspoipXgvWKGhVmnWnRgYAM8sKxuiMa47oC5gJp37wMxVmyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/dVJUq7bZi9109CaNsrJJDlRYOcSCxi6Ko4AhfnDYSZ3BL4hE
	HxD/yAKqppxBCR5rMmw+OawqXgtd1M6aB0GzBlcGMAvGDD3PlBV4WN0Vy03QEk/7vkTdlfEYshC
	CUyeBqlpqCW6ODt1IZGT8qxHWb0M1w1mpVY82iuH4AoeFjsHTaI8PogmGFg8zfuso1RqCI1X4fm
	lCuwxhydSXET3MUnhIc1yYYCwgdUHFONkxyg9etwKIjK4td8uj
X-Gm-Gg: ASbGncsNnAZIvWqj+XYwPVs54sX6eGU0vXRjb+yL/muV3HsztEKpbSCpnmlyw+/FmR3
	Kml0EnzI76NHGlu1xadKTnlRqtkFKfxtYDtAuCWRlxnW8q7reyMvhW5Eg59vQOynLLMOJGeKHJV
	oHtlz40tsnEuhJUC3PsG3gZdFdQQ5H2ELrjgpjZCxBj7dsvcMAq3Y=
X-Received: by 2002:a17:907:6e8f:b0:ae3:bb0a:1ccd with SMTP id a640c23a62f3a-af94006657emr999150066b.26.1754305478468;
        Mon, 04 Aug 2025 04:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYv6saSy1ylfhTj/Jz/JQpBZyAQZBk9EeSPyhAKJXHG+//8QADIyR4pm7NN5d3EM6/5VqHVVyekcVuIXPvf/Q=
X-Received: by 2002:a17:907:6e8f:b0:ae3:bb0a:1ccd with SMTP id
 a640c23a62f3a-af94006657emr999146466b.26.1754305477941; Mon, 04 Aug 2025
 04:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611135644.219127-1-tglozar@redhat.com> <20250611135644.219127-3-tglozar@redhat.com>
 <CADDUTFzG4mvTyN4cBLzqkGBWkPkDP1-jzOZKxosxP+X8rKLBew@mail.gmail.com>
In-Reply-To: <CADDUTFzG4mvTyN4cBLzqkGBWkPkDP1-jzOZKxosxP+X8rKLBew@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 4 Aug 2025 13:04:27 +0200
X-Gm-Features: Ac12FXxijqs_f0jwCTFb5h27rcz3weL_6C4DRAy_TX7Ih5MQ7W204gk5XYVwzPE
Message-ID: <CAP4=nvQ6mcka9GAKOYY=M3LWo7qGoXy7GuMB8c2M92si+yMFcw@mail.gmail.com>
Subject: Re: [PATCH 2/8] rtla/timerlat: Add action on threshold feature
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aADS7AspR8IbRjhdj0wuHISyTJ3qkudwMS0veX3JUTQ_1754305479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ne 3. 8. 2025 v 13:08 odes=C3=ADlatel Costa Shulyupin <costa.shul@redhat.co=
m> napsal:
>
> The term "threshold" is ambiguous. The use of the term is inconsistent
> across the tools. In osnoise top and hist, it means "the minimum delta
> to be considered noise," which conflicts with the semantics of the
> `--on-threshold <action>` option. To avoid confusion, I propose
> introducing "low" and "high" thresholds and updating the sources and
> documentation accordingly.
>

There is already existing naming for that: "minimum delta to be
considered noise" is called "sample threshold" while the timerlat one
is called "stop tracing threshold" (well, the source simply calls the
latter "stop tracing" or "stop"); timerlat also has another threshold,
the stack threshold (specified with -s).

The patchset (well, the v2 of it) has been already merged upstream, so
I'd prefer keeping the naming for rtla-timerlat, and if this is
implemented in rtla-osnoise in the future, a different name can be
used (--on-stop/--on-stop-threshold maybe?). The documentation clearly
says the threshold is the one specified by either -i or -T [1]. What
do you think?

Tomas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/tools/rtla/common_timerlat_options.rst#n62

