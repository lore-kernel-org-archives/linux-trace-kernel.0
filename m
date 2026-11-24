Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795551307;
	b=iQvQ/qzRbK3OtNLswciTvnpCEXGRaPe3n8wKOjZGuJVijEx9aeeey1WUx0wqKTbWArFx
	 CxU/5A4DXbgSiyu1kAbPxTtvdUq/KDADxHaSVNWL8eft0jNRzJyYon+f/RcW44/dmRr2x
	 gGwD5Sb7p5iXSjYhIZVpR2w+58sV6Gc3xmRkbq4ziCN384Y58GWldqGb6mlGGBcVji1Nt
	 zoz8ydXiFj6r8Yau/Rll001FXrxiZmV4ytAPJq8s1/GgnHb6XiYk0qHe857D27+H6e4H2
	 n9npAS5/bqOmgcpxp/rcVauOKzoRIl74xopiduYc9MsNgimTtFqodQjNQtC2uaS5Wkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Pi553oKEuwJxtkzT1XB/uqe+x5Rc2UJPrmYbDOw3Bd8=;
	b=zLy7pFRN1r3y0nTVUh1ONlo2XTcUUKw3IfUuIvlENmjfGRiomfdGAdWXhPZ5y6S7y/+B
	 AEvIqaH8ZhRUABCdo4zljqOoszxhpknkIyLSebXeD43pgIY1gZAB8G/MtF5fnOFr7xqaC
	 Sp52eBK5zVW9Tx33stusfOeQEDuQn2saz+o8eLMppcOn/03SfHmII8tYLNY1J4yi4ojjf
	 n/g9I49194asPvOyhpR19rMUWWOHImGP+K6aJbpvYoOtbvE2X3C0sdZiQW2uYz1xXYOJd
	 Cx3gs8KWwOQPPhM2+ip0B63JW/IK3qPhdypI1MQHMlUR2ZWDGkTbPc9gGDjTNbWCd+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y2eb5/LZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F5606A33B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 20:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F20F5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y2eb5/LZ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so43194905e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 12:15:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795551305; cv=none;
        d=google.com; s=arc-20260327;
        b=PfclFllspLTYjo6V2EQLHNg5GcKevIFP0lZw5z7FGGXV5164EE0KDdtenyRvOJjfOS
         qGk6jN/l0L7v2dakacqYhYL1paVl51996wWTyKqby//k3tiuDvgV21qAdQ8O5ziLLAw+
         cHkmCwGqwwwzVEoGDB5S5pM2DogNbmotP8isJnBnIIiUaQGJpqjvrLtYxCNm549fyXIo
         TnZsrzShx1pdhOW/ORI+XFaIXaWDAOyWXoyltuT82e1Wpv08l4YD+6S6G4B8gvuNaU+/
         JXZ0JlZttLl91ehOVjTRNTuWuLkE7wJoVna7/SmW6WnsjUQFzAXUd7fIFhy6AXnljyP4
         rOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pi553oKEuwJxtkzT1XB/uqe+x5Rc2UJPrmYbDOw3Bd8=;
        fh=5Xp+JdsXb3aAYZA4JxiINaCt7ccAh0wBl7fQpd9sfKQ=;
        b=r+BkTbEhhzAVM+38cW17ZI1+RwaSuFcdMthHLik5urfUQSM4HnnFe3Y3Ju+K/30fVl
         ayUR3FIU1AZzK7s6PSSdbXLiP14PM4/Ek8Ly/lPnj1oQzBuONR0X6C8GhpqjFEdFJVwF
         C8Q/PRb8x5EHDC8dP/ifKc3ykdHg2i7X5Skm1LmbdYqRGxC1BQb69t6rBSxR+YwKG6SQ
         pAQuExVqTypHSpdXlnqrrdxQ4d4mlV8AETNB8HlFocBR9dTawpMWvrTdlQ5fytfNIYN8
         TN7xg+DLTGB4QEDiH8c3Fplu7j2z4oYrWg3/ZlrxW8mzcTJiLyNBXVrHIzdv5PM/vZDI
         qt3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795551305; x=1796156105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pi553oKEuwJxtkzT1XB/uqe+x5Rc2UJPrmYbDOw3Bd8=;
        b=y2eb5/LZeksmRnb/4Tc2gs3zEYVlgZK6T9qGufOag8Bei+G6Y7t18dJrdfcsvGlTj2
         6lA8CxMUbCuClMKZB5cGfk34by0jLI0jlg1ITdQuWWaeI9HqWFJM2e6Rfg0ZTvX5bQNz
         sjLTVmYDhHX7FjEy3iFjcH6ocEmZ8837BGVvoM9kmHUGDUOl2mRex509wcp+CrZiqNzJ
         4wL56UkWq4ohRa//hvlDtRSTqz1NEniqS2+TrZGYFdakFMsHHsAml5jN5QhVCS+IlyRL
         AZQCCkyozn8O5IF7E3DA218PR/ku9M+5dQeD6rmVKcdzTqGqk2hVspiW/CAq14t162hF
         fBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551305; x=1796156105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pi553oKEuwJxtkzT1XB/uqe+x5Rc2UJPrmYbDOw3Bd8=;
        b=Z9dO0OsWPbRayXo4KrhPBplOJnCNYemF0nck4jFx++29YhHTQsiTvJECkAHTR2kV1N
         U+6/17fuU7craLb8hvIwFjNbJ6dq5ng9SZj2qxUOliYURvGmSjxyUy1GHWkoFhbrrUXF
         dqHubfwDWDhoDCVPJpCyWWO0KZ+hDMU43AXn7bKmoTiaxrNf8L6BV4DRT56zQTi9Vaqy
         Ppdi3XXqwjwzuN1jJhGB9H6WUHmcadnBEUT1RHlfS1FlZc9VLoRfaGBCHg5e/LzcLyrO
         xT1hZ+yfDCtoyuuEMxF1cqrBb+3FWoUf1puO2DvuJ8oCNDwDdY2nzDvgeQyod1c/g0Zu
         rSNQ==
X-Forwarded-Encrypted: i=1; AL+hErFDvgxum0HmaR3XkcU/OyNb5oHKrds4JDEeEU6cWjx/XWIYypoZ/hwN4ewzaAB0UMP4HFXqWTLSoG1RCwQGiaaeYto=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GC1M9Wlg6ZrMghK3qaJJy8xA8K+y/3PV8kIAkSFnmi0LcLHLR
	Jcb6HGEbBrsEHZ7ApGtIXAEsP6uwRrSEwBDyxdt1moP1BnVnbfbWbh6q60OIPGV/MG3LTjN4x5y
	NLgHfjfypTVTb94JYsYBYdLbALH/ecb4=
X-Gm-Gg: AZFdTZdSJLuyal9zAjWZJm7HNM3a9eve+P8uFi7wP2b2jIGSX8sLFeNrCSk1QMqjUjx
	R39yyT+DCbDLdZQgrPTmwKngb45CaxSzQqBko6iiQKmk5hqrAMtlSK41lxwYUjhAosco/gufNko
	/8+xgN+mjHl5D5RG7P5Y6wtNEOXEdAAPVrTjXNE3QQgG52EMQbzz8zm2rasyfV2rlOnAdXPlPsK
	jMnLX6mya67Tc8+cON61SmNzcFgrNAI4JPANPfcSe1ka4a3fK7AozzIEcA05KCORwKcOR4+OyL7
	hYPS8iBFLMYydTiUvD3PElo7XTM3VbtXGrMrui3qa6+yWDleAMJonTrzl2BFBW7LE4nQjJ1pAET
	m5i2ROkEHjQGgXuFblHDlPU7AlFU6rYWNEGfs3KCu8wRVwvvJUqUkgmzHNF/ymiZXHd+SmkuQ90
	1uI88QeVbtatsXpw22WQ==
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id
 5b1f17b1804b1-4bb88922972mr332691925e9.34.1795551305115; Tue, 24 Nov 2026
 12:15:05 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260408100247.2065245-1-keenanat2000@gmail.com>
 <awRRgnRmeMDUvUWz@redhat.com> <awR4plQC_oIvoc2R@redhat.com>
In-Reply-To: <awR4plQC_oIvoc2R@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 12:14:53 -0800
X-Gm-Features: Aa3M54of-GC7sd-E-HO4C2skMXhoQ64d9-dKg68squRz4l7HKi30ussUDXcU57o
Message-ID: <CAEf4BzanZC0Zwf2FDVUjv7JxDvL3dQ3MKvJ=_Wz5k1aADD4y+g@mail.gmail.com>
Subject: Re: [PATCH] uprobes: clear extra_consumers before pooling return instances
To: Oleg Nesterov <oleg@redhat.com>
Cc: Keenan Dong <keenanat2000@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Keke Ming <ming.jvle@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:32=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 11/23, Oleg Nesterov wrote:
> >
> > Andrii, can you take a look? I never understood this code in details,
> > and today I forgot everything...
> >
> > On 04/08, Keenan Dong wrote:
> > >
> > > ri_pool_push() returns a return_instance to the per-task pool for
> > > later reuse. The pool reset clears cons_cnt, but it leaves
> > > extra_consumers behind.
> >
> > So at first glance this doesn't look right no matter what...
> >
> > > A reused return_instance can later grow a fresh extra_consumers
> > > array and then reach the cleanup path with a stale pointer from its
> > > previous lifetime, leading to a double free of the recycled object.
> >
> > Can you add more details to explain the possible double free?
> > This is not immediately obvious, at least not to me.
>
> May be this has something to do with dup_utask() -> dup_return_instance()=
 ?
>
> If cons_cnt =3D 0 but ri->extra_consumers !=3D NULL, then
> dup_return_instance() -> kmemdup() will copy old->extra_consumers, but
> but kmemdup(old->extra_consumers) won't be called?
>

I think all we need this just this:

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c47b1ee266d5..f265527e6897 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2118,6 +2118,9 @@ static struct return_instance
*dup_return_instance(struct return_instance *old)
                        kfree(ri);
                        return NULL;
                }
+       } else {
+               /* old->extra_consumers can be a leftover buffer from
ri reuse */
+               ri->extra_consumers =3D NULL;
        }

        return ri;

cc'ing Keke Ming who was going to send this as a stand-alone fix
earlier this summer.


> Damn this code is too complex for me ;) Anyway, I think the changelog
> should say more.
>
> Oleg.
>
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1945,6 +1945,8 @@ unsigned long uprobe_get_trap_addr(struct pt_re=
gs *regs)
> > >
> > >  static void ri_pool_push(struct uprobe_task *utask, struct return_in=
stance *ri)
> > >  {
> > > +   kfree(ri->extra_consumers);
> > > +   ri->extra_consumers =3D NULL;
> > >     ri->cons_cnt =3D 0;
> > >     ri->next =3D utask->ri_pool;
> > >     utask->ri_pool =3D ri;
> > > --
> > > 2.43.0
> > >
>
