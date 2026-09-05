Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCE22A80D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Sep 2026 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585443; cv=none; b=Awavh5VIrw8V1rWcMvFvsktanl9PYTcL/SDuHktET/bg3CyJhQk3/hrpoxCciTWzfDO/kZ2mcAQpb53ywYC/22zsKMxHQPKju/NeMBws4sUxQDuv9UWyLGHNqTGSoyhEORMqVvmbBwl5NZ8moLZSqKgwsRxaAuBql/9XAzmAK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585443; c=relaxed/simple;
	bh=xCw3BKMnnnpcM6cHV4oiS+dkkkFjk9pf8nZpwMCYcTY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Df2qXyMq9bBI9zRAxDTbLwysKcqyfaVsADLPuAUOyhyCw1HoeyhImJcHHoJQdz+fPojItduUq1PsiEdj/3matwi6etJ/ubc8bu89MpmEe+fpIIHJojJH1cS68IEAVbrt4ZzZORqLrBVUnzmpCwhy8Xv/XmBqxsTWH5gS9K2huo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpGqlvLZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpGqlvLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788585440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCw3BKMnnnpcM6cHV4oiS+dkkkFjk9pf8nZpwMCYcTY=;
	b=JpGqlvLZUehpZcnwEOkGECjjGLh+wpzw5Tzrn2XIzXKG7jCbMCOfXytXBNdHddtUrAzV+x
	LFA7BdPJD8qWLocmNZFo2wJ3PSvBG3UB7BUcENvcu/Wcttdn6Dc9cPJBnw+O59+FXjrQ6T
	NeJbuyo3ulvJFFVn3Vga2on3KULyP2U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-rsYegfaPPEWoSrTH-_NW0g-1; Sat, 05 Sep 2026 01:17:16 -0400
X-MC-Unique: rsYegfaPPEWoSrTH-_NW0g-1
X-Mimecast-MFC-AGG-ID: rsYegfaPPEWoSrTH-_NW0g_1788585436
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49545071724so12350915e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 22:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788585435; x=1789190235;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2N7N3DFQuE+aWAvgayOoeK9Kdsr9ItgNWqqp2QW4O6Q=;
        b=MPwO8Bira+MnCLTG2+meuXyJgBoX/aR8NIRK4npBhLQnomhf6wYc1yTWRm6PiAIcv0
         yMkrjvaS7IP1VTSsNBIz4IPTQsmkDmVXa4viidIVJCzlsqruDM9b4nq8zDmyk/U67Fu5
         UaAlTTiITE5ZkW7sA0FtUofYArvX0kEGqWjR/Kb2pFZ2lE611ExaYpr11dQ8IcvPlezW
         H9LAubLJUtVv1bHG6rujKLi+WKNebqDna3akLEQj/YA0aBR2NaVg3sekg2N/sAuHAqYb
         7MT5AeEt3mDNbDkjsrKBwuFeyvXVKCIt2zSOEMw7IjONbdiEwy8fShzu32uyDcCEsd4C
         IKXQ==
X-Forwarded-Encrypted: i=1; AKwUvByuhNt6Eplzi9dJeTscCX90lleMWf8zqjol5XiQ5II4yPuLx5l0vghRujTogzt6hKXMLmZ4WX66F0E58K5n0VNZfbI=@vger.kernel.org
X-Gm-Message-State: AFuF++kiqrsefhk9O3ShBfciDUuZ1Jr/g+zShI7MHgOFuUZS1f3NrHfe
	WX9SrGLhRtLLOw/3VhbWh9jqUfLCaRoy1rvbqDQ8G0bTqzbD/LnZ+zaMgL6W5skR1dC10y4aLtH
	6LlwDpdVQMleIthS509ffNem4Jn5YywLZ7lchpbn1cV7US53A5FdHOcU8q4tBRYKjSHoKuCkEEA
	==
X-Gm-Gg: AYBFou3bNA+imDpeqBoE2aNogfNAQYgkIcury9yDFnqh5CjepDfP605vNCN4CRWx0vr
	2XsdngXLt6lb52tGhzMbYLvAS/MdstJ/Dnm+YOvvYQhnm43FepP88SoRRu/6G3kTAHteKK/VQ3I
	zGm+hFXkIOrVWcLFd5D/tIOg+rhhyzAcL0hvmYPydoH2grDubP3yA37UnJts3OwACKO6SLg7aQk
	h7bqah8SaKprmJesFX5+VEZBl3ceXDCas/x/KcXPQxWM3dSKjlVltwul5YIHdClEH9KKbLy3Kdo
	f6dBnuqyc24ur2KyM5Vb+Q5jpbzX3xHaivxJtnMQRZYauPobAu05ExL+TLwllGbM3GlaIzSxsQl
	U7yuu+fycAw==
X-Received: by 2002:a05:600c:4585:b0:49c:fc6c:be16 with SMTP id 5b1f17b1804b1-49cfea09f08mr58738645e9.28.1788585435736;
        Fri, 04 Sep 2026 22:17:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4585:b0:49c:fc6c:be16 with SMTP id 5b1f17b1804b1-49cfea09f08mr58738395e9.28.1788585435425;
        Fri, 04 Sep 2026 22:17:15 -0700 (PDT)
Received: from ehlo.thunderbird.net ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm200070045e9.15.2026.09.04.22.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 22:17:15 -0700 (PDT)
Date: Sat, 05 Sep 2026 04:53:35 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
CC: Nam Cao <namcao@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
In-Reply-To: <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
References: <20260831090524.106845-1-gmonaco@redhat.com> <87se3sakgi.fsf@yellow.woof> <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com> <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com> <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com> <20260903090211.50d15220@gandalf.local.home> <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com> <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com> <20260904123108.1fa1d815@gandalf.local.home> <20260904132421.111c0279@gandalf.local.home> <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com> <20260904194620.0c7a8363@gandalf.local.home> <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com> <20260904201741.2986efca@gandalf.local.home> <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
Message-ID: <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2qfuBEDqpwGcKBV5FvNta9UyUJBFs6H2KwNQpQucclM_1788585436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 5 settembre 2026 00:22:01 UTC, Alexei Starovoitov <alexei.starovoitov@gm=
ail.com> ha scritto:
>On Fri, Sep 4, 2026 at 5:16=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>>
>> On Fri, 4 Sep 2026 16:48:55 -0700
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>
>> > On Fri, Sep 4, 2026 at 4:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
.org> wrote:
>> > >
>> > > On Fri, 04 Sep 2026 16:34:00 -0700
>> > > "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
>> > >
>> > > > bpf in 2022 was surely less capable then it is today.
>> > > > It took us 2 years of bpf core development to statisfy sched-ext d=
emands
>> > > > and we're still adding new features for sched-ext needs.
>> > > > If you're trully willing to remove 90% of kernel/trace/rv/ and ref=
actor
>> > > > it into tiny shim where all of the core pieces are bpf driven we c=
an
>> > > > certainly work together (like we did with sched-ext) and add whate=
ver
>> > > > is missing on bpf side. Then all existing monitors will become bpf=
 programs.
>> > > > But adding bpf as another 'monitor', sorry but hard NO.
>> > > > If hardcoded monitors was a mistake then admit it and fix it by de=
leting it,
>> > > > if it's not a mistake then keep adding hardcoded monitors.

Alexei, what I read from your opinion is: if you really want to do this RV =
thing, then you should just implement it all in BPF.

Please correct me if I'm wrong, but I don't see how this series isn't a ste=
p towards it. I am obviously open to all sorts of criticism on /how/ I'm do=
ing it.
We are adding the possibility to write (existing or new) monitors in BPF, n=
ot adding another fat "bpf monitor".

And if you believe my attempt to have in-kernel and BPF monitors coexist is=
 a waste of time, I get that too and I'm open to discuss.

As you mentioned, when the project started, BPF was just not ready. My inte=
ntion with this series is to reassess this today.

RV was initially built with the functional safety use-case in mind. For var=
ious technical reasons this didn't take off, but that scenario drove toward=
s implementing RV reactors like the panic() one. Something BPF just shouldn=
't do, as I get it.

The interoperability with other tools (via RV-generated tracepoints) was al=
so a driving factor, together with Daniel probably being more proficient wi=
th those back then.

That's just from the top of my head: there are historical and technical rea=
sons for why RV looks like it is today, whether those are valid or just "mi=
stakes" is simply not for us to say.

I'd rather discuss on what is the best approach /today/. And that's precise=
ly why I submitted the talk for LPC.

Gabriele

