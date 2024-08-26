Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4114901B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677304; cv=none; b=WfdvjGwQyCKDEKgOxAPXSoVEJh4Xm9j438hY4gzt0vplwLYL4D7737IvLN+LYsUwHxQd1revPxd7LFgpCW71TOCwizVDasvTuLfHQ2e9t9eVdJJ3OI32oIzveN/gi7buPab+ynPwxpJ3loPg81YQRXFZWY5O6BYZ3SI+1KsUktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677304; c=relaxed/simple;
	bh=2Opw6vNFqtAowmYwHyECODo2kqem1ugNhw4ntDm8Jjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Opa+t2gLH4v9Shoc/yFZ0izAWeXvENFhaNDUElSbB7aAaCk825fDDoUNB8WMgv6xKJ5NfSsf13sclHiZ78GoRUEn9gU3EK7BghPeFANEmZ59+oxkYCeooHB/tEIOnTUcQ7+G2zG/Ap3EV669+RJ7vaZ2OWPljMaZudjnMZwwzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZsWqr5l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZsWqr5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724677301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtUuKStDI/TrqAejzoVfdWdlirHG5pbXKKxkB5GlHAY=;
	b=ZZsWqr5lXds1xQ9B6IToTaPPmctCTtGWrVWxAWS0i+P5cHaQQQOWex4lKLdp8VH5GT7e2b
	c3hw4bf+wnvX7Hm4YJ4LiCDQzDCBJuIynQblhnKqwUrUmKZbl2bXGeAQqkIM3SB6JD9aLl
	k4DIHCeXrN9rwS+ApaG9eYJH95jpXZA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-0mz49oPhOTOcBoj1IKzk5g-1; Mon, 26 Aug 2024 09:01:38 -0400
X-MC-Unique: 0mz49oPhOTOcBoj1IKzk5g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7a8281dba5so397012966b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724677297; x=1725282097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtUuKStDI/TrqAejzoVfdWdlirHG5pbXKKxkB5GlHAY=;
        b=ma9LtHgizuJXmyCCb7TOk5cOYLsEtzkYLl39bfcewzs1y10ig44uOnakVUf35me9Rv
         Ea1OccmcWYg/dgF9o5XT5E1M6+NdAIKLeLCorWpfWJuM4LYyGaKRjs4AVGwnaToVbmHu
         59oM8czVYebw0MXRtIAg1gcnDS7Zk6rSP44Lbvbica9eToSFyI7ZFtgjT7fKR3Z8wJp9
         dClHef5toUclU4yqZNi58+rtCzuNBqruKpi8Qcx+zR7EEuLNOGNe+LJCse/mktActVNS
         k5ht9TCGu5OU8tIjAnPK+BXL9dITkFlR9brj6bRm0e2XL48dtx74MwnloVeYjLHtEn5O
         mNEg==
X-Gm-Message-State: AOJu0YxX1RfHpPuITysC+q3A6d6MoEgtCh3KfCwD6GqTAJ+C7P3aaNv9
	riSIbZr5a38z+P268nVS0Evgbjtr2GU/Ti2DXG9M1m6MhiHzsGr9YwelIVzCa5MMWCKehFM1KiM
	V+v+1KKeBDJtfWKDmDzlKwkM4TeAtIbAEYE90TpPOZARSMuz+vgcTdaPcVS04vXMxbzOcXyBte2
	UNQyDSW40Fg8+TMl/GbU4HsXG3nef//vqMwjEq4BqVoXRp
X-Received: by 2002:a17:907:dac:b0:a86:b727:3f27 with SMTP id a640c23a62f3a-a86b727424dmr392975966b.52.1724677296760;
        Mon, 26 Aug 2024 06:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG53fvNxGfjMtYsvqkzmA0t0VlDbb1UXlcCb0hnV4Mk6ey39DNiK7UN5zFZsZLnqKxLsPGZy+PWs1LiyX/NUfc=
X-Received: by 2002:a17:907:dac:b0:a86:b727:3f27 with SMTP id
 a640c23a62f3a-a86b727424dmr392969866b.52.1724677295454; Mon, 26 Aug 2024
 06:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820130001.124768-1-tglozar@redhat.com> <20240823125426.404f2705@gandalf.local.home>
 <20240823145211.34ccda61@gandalf.local.home>
In-Reply-To: <20240823145211.34ccda61@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 26 Aug 2024 15:01:24 +0200
Message-ID: <CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in timerlat_fd_release
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 23. 8. 2024 v 20:51 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> Egad, I don't think this is even good enough. I noticed this in the trace
> (adding kthread to the memset trace_printk):
>
>            <...>-916     [003] .....   134.227044: osnoise_workload_start=
: memset ffff88823c435b28 for 0000000000000000
>            <...>-916     [003] .....   134.227046: osnoise_workload_start=
: memset ffff88823c4b5b28 for 0000000000000000
>            <...>-916     [003] .....   134.227048: osnoise_workload_start=
: memset ffff88823c535b28 for 0000000000000000
>            <...>-916     [003] .....   134.227049: osnoise_workload_start=
: memset ffff88823c5b5b28 for 0000000000000000
>            <...>-916     [003] .....   134.227051: osnoise_workload_start=
: memset ffff88823c635b28 for 0000000000000000
>            <...>-916     [003] .....   134.227052: osnoise_workload_start=
: memset ffff88823c6b5b28 for 0000000000000000
>            <...>-916     [003] .....   134.227054: osnoise_workload_start=
: memset ffff88823c735b28 for ffff888108205640
>            <...>-916     [003] .....   134.227055: osnoise_workload_start=
: memset ffff88823c7b5b28 for 0000000000000000
>
> Before the reset, all but one of the tlat->kthread is NULL. Then it dawne=
d
> on me that this is a global per CPU variable. It gets initialized when th=
e
> tracer starts. If another program is has the timerlat fd open when the
> tracer ends, the tracer starts again, and you close the fd, it will cance=
l
> the hrtimer for the new task.
>
> I think there needs to be some ref counting here, that keeps the tracer
> from starting again if there's still files opened.
>

The timerlat fd is not supposed to be open when the tracer ends/starts
again, since osnoise_workload_stop() calls stop_kthread(), which in
turn calls kill_pid() to SIGKILL the user workload, which will also
close the file descriptor. Only one PID per CPU should have the
timerlat fd open at one moment, since timerlat_fd_open() will refuse
to open if tlat->pid is set. It appears that this is somehow bypassed
and osnoise_workload_start() happens before closing the fd, not sure
why.

> This looks to be a bigger problem than I have time to work on it for now.
> I'll just apply the mutex patch for the kthreads, but this bug is going t=
o
> take a bit more work in solving.
>

Yeah, unfortunately the issue looks more complicated now after looking
at the traces you posted, I will probably have to do more tracing to
see what is actually happening here. Thank you again for helping us
with this and also for the patch for the mutex.

Tomas

