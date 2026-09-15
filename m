Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78460371056
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456547; cv=none; b=BUOarhPZpfV89MCME8QdBPL88th1+U6nChUc5G2DsIkJudlOzApByxhxWm862IVtWXs5/bj1tJkK/xzcKQBOyH5DEY5JLD3lzCHuvXSFl84wtanmn1GUfcZ29BZ3imqWqST7SG6gxjG7wC/RYJ9PulIdE8OMIueHaPcTLPhvnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456547; c=relaxed/simple;
	bh=XUdHHqHkpBDhjFo9exdJCuBeB0efNh+zdzWSlsOayRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZXVlbHjqo43S0NYEaNo9EO5ohqD4enHgLdKFtYoREtObLZF4TIlW1YENaQreuWVAyMvntEnvu96y6k6wUFlKLSXuReq07TEXzYNRfuYvMuh8dar6c81RsKpNyQdviuu9+xyq2N6s8Itf2T4pZK8X1C/ovq/vWEeKv5meQZ5X1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iimwb2lv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iimwb2lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789456544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XUdHHqHkpBDhjFo9exdJCuBeB0efNh+zdzWSlsOayRU=;
	b=iimwb2lvzANVgVPG7d53OtAAcQelkF4m8748nUraVOdem9Aul1TVrV6e64ignur6sMwYga
	Ui8ymaLeGPQg5fhkg8ZUt1SXjYLmbb/nh3YO8upSWltIDG/MdF5vep4cDwphjYE1rXurxm
	QieJqO2OKZz1VX+0KxWq+Qg6/V1GlQ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-IX8FwUMPMY6QTz8EtuFFLQ-1; Tue, 15 Sep 2026 03:15:43 -0400
X-MC-Unique: IX8FwUMPMY6QTz8EtuFFLQ-1
X-Mimecast-MFC-AGG-ID: IX8FwUMPMY6QTz8EtuFFLQ_1789456542
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-486e8fb7d75so1319354f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 00:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789456542; x=1790061342;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XUdHHqHkpBDhjFo9exdJCuBeB0efNh+zdzWSlsOayRU=;
        b=jb7Yctusnc+kgPjYZtCWRkSvWOMdV9onoxoRYY8IL6BEz9SEdPArogRYE1HftL/9fb
         P+XCrmKrluBh2VDxu53u0THR53znOOxiRi5s6Px8b+MLwSvgKMzkzbd5/KxTKhK2BPg+
         PVHQmgjFswXqM2ga3lKvZqFrkW3AvcnK4J1Qu2aZj/oh2wdgYXhl8BR4VTpjI2JfHntm
         YyUrpUzAJB8I/y0ofTrELqkWJqBqLxXojhA45kzEjKOa7X3nvuPvoar9O2xcFrPz5Thj
         Puu/BmDZ7l2ac4pTtFGVSwXOx3HHBsJ4uwU3j+68ZpeW+JDVGrjIPZQfxUCpd94OiVmK
         25qA==
X-Forwarded-Encrypted: i=1; AKwUvBzuPnNNMby7YY9CrUu/2bq+ofyKSCbnxLthc6gVWzkMCH6xYah1N0ha0koC3uSKcmUXO5FwcJOl9hGvisNGJiSrYfo=@vger.kernel.org
X-Gm-Message-State: AFuF++n1EmrwaG6Td9BOfHdtXLlAGorQpF0PvhQFHS2hvDiTCwjcGSER
	m7IeNOcxHLjyJBtp4Qk/KhSNJTTdskAXscQkTYaNUAaJ+SJaEpPSzb6uzx+hJYKRAqX3A3xHBkL
	82wP1J0YYDHpK3YkW++tyClKPVolu4xvC59luyRwwgWxZc6BFngGs36oZVo6GUlT2wYChbSXQfQ
	==
X-Gm-Gg: AYBFou3wL7ha0Z5WsnJ9sxohRkGlO3Fj09Z4n+cW9xz80ckAUmmRAyj0Zc6H2rJS8/K
	4WoCbBT6BtQGe1Ff6vcfsFaTA+G8kJ+r5RMoKzzpCpzYF8GbO+/t3N9QQBGAPZQMaqGETFaNB5/
	jmXzzoYdakoOByAbl0vAZdSRpzBuBvOITT1IbD+QnRBY2xo/CRb1IlcjZ3DI3ChmFKu4e3+WH9l
	1Mlq4/+qoR4e072cs0Oojv9H9TMvbvzcX2U+PVB5r2eIQkNyrrrqVS6T3Eb7Qy7Ui8NRFTgAQl7
	T4+ltZaFdAFbAZO7sLF8LhbmajszI7b6kJg43kfHO+nde7ZCrNWPRBcUw9vX+IYo/DcRxC5POVX
	pBBnaSYA2CjX6yq/z1Ziv1j91KHHt8w==
X-Received: by 2002:a05:6000:2685:b0:484:4880:449d with SMTP id ffacd0b85a97d-48702aceed7mr9043993f8f.3.1789456541882;
        Tue, 15 Sep 2026 00:15:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2685:b0:484:4880:449d with SMTP id ffacd0b85a97d-48702aceed7mr9043948f8f.3.1789456541483;
        Tue, 15 Sep 2026 00:15:41 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48707e00133sm2607417f8f.11.2026.09.15.00.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:15:41 -0700 (PDT)
Message-ID: <1f8caa71b79e70f554245bccaa29b66268452dbe.camel@redhat.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Wen Yang <wen.yang@linux.dev>,  Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>, Linus
 Torvalds	 <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:15:39 +0200
In-Reply-To: <DLDSQDSVXFHF.18X2UQUL5Y42D@gmail.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	 <87se3sakgi.fsf@yellow.woof>
	 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
	 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
	 <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
	 <20260903090211.50d15220@gandalf.local.home>
	 <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
	 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
	 <20260904123108.1fa1d815@gandalf.local.home>
	 <20260904132421.111c0279@gandalf.local.home>
	 <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com>
	 <20260904194620.0c7a8363@gandalf.local.home>
	 <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
	 <20260904201741.2986efca@gandalf.local.home>
	 <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
	 <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>
	 <DLDSQDSVXFHF.18X2UQUL5Y42D@gmail.com>
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
X-Mimecast-MFC-PROC-ID: 5MVB4wxz99CLmFcf6ECTiFs5dqfPCZpTbn3qoSF2nw4_1789456542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-09-12 at 18:26 -0700, Alexei Starovoitov wrote:
> On Fri Sep 4, 2026 at 9:53 PM PDT, Gabriele Monaco wrote:
>=20
> > Alexei, what I read from your opinion is: if you really want to do this=
 RV
> > thing, then you should just implement it all in BPF.
>=20
> yes.
>=20
> > like the panic() one. Something BPF just shouldn't do, as I get it.
>=20
> There is a disconnect here.
> we have one KF_DESTRUCTIVE kfunc already. bpf_panic() can be another one.
> It will require CAP_SYS_BOOT.

Great, I have also been pointed to crash_kexec() [1] which seems to be doin=
g
already the same thing.
Anyway this doesn't seem a blocker.

> > I'd rather discuss on what is the best approach /today/. And that's
> > precisely why I submitted the talk for LPC.
>=20
> Excellent. We can start this discussion over email and continue at LPC.
> My understanding of RV is primitive, but from reading kernel/trace/rv/*.c
> it seems to me that it's a thin glue between tracepoints and monitors,
> a bit of boiler plate code via tracefs to enable monitors and seq file fo=
r
> visibility.
> What you're proposing is "yet another monitor" that is reusing this glue =
code,
> and that's my main objection. I don't see the value in kernel/trace/rv/*.=
c.
> (kernel/trace/rv/monitors/* are useful, of course)

I get it, essentially the point of contention here is that, besides loading
tracing BPF programs (the event handlers), I'm /also/ loading a BPF struct_=
ops
program to register the monitor to the existing in-kernel infrastructure.

It is indeed not fully necessary to have BPF monitors share the same sysfs =
API,
as they still need the userspace component to do useful monitoring.

> What stops you from attaching tracing bpf progs to all tracepoints that y=
ou
> need, pinning few "bpf iterator" progs in bpffs that will provide text or
> binary output via seq files, run a state machine inside the prog,
> and do whatever "verification" logic inside them ?
> You don't need the rv/*.c glue. I see no need to introduce new bpf struct=
-ops
> api just to look-like-a-monitor from RV glue perspective.
> "runtime verification" as a concept makes sense, so focus on that.

I actually started my POC without struct_ops, activation happened by just
triggering a dummy BPF program from userspace, but I'll look into these bpf
iterators.

Essentially sharing the API simplified how the userspace component handles =
some
things and allowed to share reactors.
But again, that's not necessarily the way.

Thanks,
Gabriele

[1] - https://docs.ebpf.io/linux/kfuncs/crash_kexec

