Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572378;
	b=AN4TEYzPQywF3gjs3+Ha3L4LmcbsKnFSDKk/31o42L+FjYGmuWFv74YN3NcUqdy0oOIW
	 SmLNe48ZhdcmZSo49emxGTI7EoDaEyadYIBkuZ+q/thosbVBNzAe4sdFu/ljYdLPoTsEm
	 FhUeoGvwTs5ew/3ZpOltx+Wl6jiHi5B4jYSPv6LEhQUvj31HLtHUQXtGSxjIS3r8Zn7tA
	 EpsqgtNlxM7TS+++tBaBdC8Btmazo3t9hOLQC4LWPTW4/+t133Td+Qao1Uf6Jc5e9z2A9
	 Ehni8XV2bVNEP4H+qk/xCESVLf7eBfSy97w4+fTBN/hgg9tvIFh+ak/ccdVaTzmXkDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572378;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=/yF0JL6Rd6tCEdOsvrC8K9rzM4lbnQgAsaM0D1hAFzE=;
	b=YfdfA4xeoAqx0yFimWab4lzj2Sq0oGL5d5yAWmX0ChCXoP4v/9yNlzTotxn12urnS6oN
	 XjQ8UAiHFjPBN24U0hdBLDFoGDYNi2DivyES3zlaZZc/wrtH7CmLDwC5GGF+Ty91WVEb7
	 SJfqU+gqcbYpLiOQ5uwMBXWbSbK6qVw07JvoTWFvDFyTiK7s7fCipsO82sft0p1Xqc+Ry
	 jk7zW3LgZQJnXg4tLdXju+5iRLdb857ipSIR92qPyoTTpmqQn9cm5V6NE7tnsVzZfds8d
	 ZCNJ/dCknNrub1lQCPUnlLQxcWmbh+n8Nt7qk27aKPsBnT5Pvnv5lRG+J+dmOLPRWqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYuxZlXv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78D606A326
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 08:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B78D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYuxZlXv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792572377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/yF0JL6Rd6tCEdOsvrC8K9rzM4lbnQgAsaM0D1hAFzE=;
	b=WYuxZlXvJ+rKt1yZ1R5jH89Cs6WSpZooooJKR3KMuju3Wvzr7DL6xYUcAXUSdVMLbhkavB
	CXXRYLIOj/K2PkAIfWHMtFzgN3F+q0p/VVEEMNz4VAcpYOSh/SsL93QplinPhW7DNokPjL
	kt+CsiaHPkdE3m0z4c2gGWk4bpm7eGA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Hwd9P6arNxel-pGt13Z3gg-1; Wed, 21 Oct 2026 08:46:15 +0000
X-MC-Unique: Hwd9P6arNxel-pGt13Z3gg-1
X-Mimecast-MFC-AGG-ID: Hwd9P6arNxel-pGt13Z3gg_1792572374
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0af48c18so381926f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 01:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572374; x=1793177174;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/yF0JL6Rd6tCEdOsvrC8K9rzM4lbnQgAsaM0D1hAFzE=;
        b=XKl9DYo61Hj/cLnh6sp53EUSpb4sSs9aanUfPO7tn43UujN5tLaGAxTFx/0PhjaC1y
         yfGaPTz9F7hRCdetD1yHbnEHvXqHCAQailY/4icINqPli/g7ikOVgwB87X4jjRb/JQMh
         6pvd27vtTOj4k+1y0/MhawPeZs4NFE7k8T6Flh/syf5NLdi2CbUKGon66+fZEwRJ5+79
         coNXl5qn45zkFpqw+StQ5+FPho/iouGFP6MhlJ/+DCtI2DpRWYkTW8sM7VTRLIFzod6m
         wLQ9DjkbRhPI5c12I3WdlZTW9isfGvvIb+pGAC/Pj02OaCqzl/0AiBhqBOnz4TP6o51x
         YGvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoYft6qFso3DWrKdh+cJGAVch1C1Wyhx+Rqn9HTr6Xgfc92llS15RuwUCKUvF/zJr1GfliMR5Tj6GpkK24rRDL6+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNuqKsW1lHAcyPLs2duv92BYbgSMd+bkx9CbpiBtN6hNC9PBkx
	E9EWXgl1EfL5hu9pIYyuhhOCApDlC2s39ITAMB/N8Cv1vSaWH1R+2eJ4IXcZpto0/HA8KGSUmep
	gXrR3/A2S0In/6nCO2nPBTmcUCpmRRAuAkZhHi70TVRXm7RR2EgbI2oGPseXiENQSboxFGbjtXA
	==
X-Gm-Gg: AYBFou3xoYQ24iHUmQUTdZ+VthNO0pRw9kwjOmjifKk7YBCqz0HC2Ln5BV9xMZPHglx
	HyKJqmUcuA6CKUGUuORImeHytedhGRwFwcEDVNExwuczqFxfwKYWpId7oUgOVsLkw5/dZsv7QMa
	q0j8ALOWwoHzD1vXuYfRzc0j9CZ0CZNGi1ttXLfzlLHlOJ0YGHWmCACTMRxQ3bDaKz9/xSGF4VS
	DAVWZQkfMK2oHmhaWZ/1eiiqkqMRiUcy1mpunPzcKjyE08VBlWKzut02KSRGBdwBCWE23F4EWrX
	HRMPEynZy9X+Eomsc/5pOuwdoX8PwaicxISY25RwJ8EexjLcacbXQ1hdWoaJDE9GVCCJZvPTO+c
	ohmovit5AIxaFmWa8X09lhIjFQN4=
X-Received: by 2002:a05:6000:2001:b0:48b:1c:d6e1 with SMTP id ffacd0b85a97d-48e264dd0e4mr2661920f8f.43.1792572374362;
        Wed, 21 Oct 2026 01:46:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2001:b0:48b:1c:d6e1 with SMTP id ffacd0b85a97d-48e264dd0e4mr2661878f8f.43.1792572374010;
        Wed, 21 Oct 2026 01:46:14 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.34.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583ffa8sm4205103f8f.51.2026.10.21.01.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:46:13 -0700 (PDT)
Message-ID: <631896ae8e44ed6356c3b79598a2facee8af9770.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Wed, 21 Oct 2026 10:46:11 +0200
In-Reply-To: <87ecdjqxnr.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
	 <871p9mqcn2.fsf@jogness.linutronix.de> <87ld7trgzg.fsf@yellow.woof>
	 <87mrs9q1d3.fsf@jogness.linutronix.de> <87ecdjqxnr.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NaBAqXttA3_G99mHBM0l5RKndPy-5-fSA96737TLI6g_1792572374
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-21 at 10:13 +0200, Nam Cao wrote:
> John Ogness <john.ogness@linutronix.de> writes:
> > On 2026-10-19, Nam Cao <namcao@linutronix.de> wrote:
> > > John Ogness <john.ogness@linutronix.de> writes:
> > > > @namcao: Maybe you could chime in if you want the transitions as ev=
ents.
> > >=20
> > > No. Those are only useful for debugging RV itself and do not need to =
be
> > > upstream.
> >=20
> > Sure, but debugging RV itself _is_ a use case. Especially when RV moves
> > to eBPF and lots of people will start writing their own RV monitors.
>=20
> Right.
>=20
> I wouldn't enable those by default though, it's way too much noises. As
> it's for debugging the model, we can have some sort of compile-time
> switch to turn it on.

That's almost what's happening already, in-kernel use tracepoints, gated by
static branches. Those are the closest thing you can get to a dynamic compi=
le-
time switch (assuming such a thing can exist), it's patching the code.

BPF gets even closer to the concept, we use a volatile const flag, which is
constant for the JIT runtime but volatile for the compiler (not compiled ou=
t
when generating byte code). Before loading we set the value we want in the
object and the JIT compiler wipes away the unused branches.

But technicalities aside, we probably want tracepoints for events too, so
bpf_printk or whatever else.

Gabriele

