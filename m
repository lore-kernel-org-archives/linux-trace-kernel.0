Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596251;
	b=iAz6BsvvFORCTxqx1gpisg1iFuADyvewf9gdMdhlQKcdWwD+em23paCkteeSUV44b9qz
	 rqWQQNxubDJRaxH9bXPNjGn558nhfTg7IFzCnhvhkNc7zIQn48s2ER2xaE8I52loOUVcg
	 NXN1P8+1lsFauYEiZtzIQxAoQQpiBt+2/Sq9kW3zQb6lcJAkKtz/TKdX4PXgQQIEssymk
	 PW0FZAVzI6Lsj6yKkUeLjHd8tsJas+Ro9fPRgcc73C211H+b8unfTeL7fUAAZNmei6oto
	 69r2Jd+Ua0gFEk4c+1Eb142zKYTx6GuRJWiuLrY8A6bTWSddaG6r+d2QlylqdWAdEWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596251;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=FOdC1U/zHYhK2Lt5MZ1OH2V/qvZIRZuOE3CFRr+zeO4=;
	b=aZNBq3oY8UL+UAwDSJLRwdLGCMT11SCAAFEJSIHZm/p7eXthlLtw8gBzwxt8vUMYkhg8
	 eohtWbFXm0yZkK9LNmb5A+Z8mhB62CbnElYDfcPviB4elW6nfMCPQrrpCO+wspqz3X75P
	 eSTu8XSJmSR15Er6UrBdS878kf7Tr2hG5sLDHJJAjsSyGwqMkUaS1axxcyHv9hvkSd0Hh
	 mR5229wOnO86fshODbic68BmJ0A0PhhfKx4pNY1XNh2OhGdhN0USRJTmW7P/2iXaUZRX4
	 nPKnU51YQdNUL27spf/BWAGYCytqfYhYBf++QJl6jSvNjUxpnH/RB0lyJqejg0v3h3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T85XaMUa;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C675606A31D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 15:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C675606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T85XaMUa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792596249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FOdC1U/zHYhK2Lt5MZ1OH2V/qvZIRZuOE3CFRr+zeO4=;
	b=T85XaMUam37kFzZ2M/IgIIhvB4AaDlLZ8PW/1DCIqM7iaCzEeuCMPi69wO/QR/WOLGgSKy
	XMfyJGEp5sf0o8u01ju47jxnrN6hog94832dv5mCERizIs3AnLHqMiLizC5r7BwRiBLo/U
	1r0OMVCtztMNgQq8TkyMDq8+C1X0+Hc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-pGCWl3knOtSASS02nC9VuA-1; Wed, 21 Oct 2026 15:24:07 +0000
X-MC-Unique: pGCWl3knOtSASS02nC9VuA-1
X-Mimecast-MFC-AGG-ID: pGCWl3knOtSASS02nC9VuA_1792596246
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1bfd5516bso8357065e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 08:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596246; x=1793201046;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FOdC1U/zHYhK2Lt5MZ1OH2V/qvZIRZuOE3CFRr+zeO4=;
        b=sy8ea2GPBTXVnoDajcDYCA3daLR12Hu0gE4KneKAo1RHF/NpB9wA/7EBgA8Dhn5aPi
         LDK4j8XChfrZDkDzhbujnXlngWV6UxCkG2CqKdT+zV8b1o6n3/SDRQpdrW+GNIv1YmJ8
         MzBKq5mpE+ldtk+P7x0twhIxDNRpeOXWEIE4JjHRBAmO42jcglLi39LI4Vny3yabLYiI
         WXWrkIhjlwpQBDEwQHy4ys2IChRDMkdO0E6Km1P/a1PBAvsd5SoFDPbl6NHqkLsISXgH
         pCgDYzmKnKwYjMgsTLvUpoDyLjWgy6oTxQrz31mt7PHrpMPTbQ2/ObppjOsLpen/soGi
         kB9A==
X-Forwarded-Encrypted: i=1; AKwUvBwyPIWwHTHp67TyGBtbUfFQacdTdFPlzYStRxihD0/dDQ6+TtUhPyLaJ960I+cm7rv82+syzghGzhwZSrkTnukgRdI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIW6Kt6Yo6DBEskMEwtPlqHmiyG1h2CeH953Sc6ZCOdlir2wa2P
	Mu0jujUKyfYHgdUIN0ceugW+dEk9VSvQqC1MEvQuLyLvl18+N0WAETniS4oKj+e2qJaUmPWwVCJ
	F19+nG4mwfvY+QiUkhdPL9JhJlT7pPOTOJvYtrhPIkIK0A4Pz9Pz8PmcYsp1/Q88U215mhOWuUn
	d6ddlzfw==
X-Gm-Gg: AYBFou0gsrQSOqCAgjSVZUc5YQ/M+6FCbflbMBgsBynpoP6Fd/L/q6aK8hKIEsmcTdI
	Nwd2zyWOKlTA+UiFme3HNb6Ya1Ntva17sQF/gXqpAFPX5Uq0KnvFm/xqRpf8aH0+jqxjZp6LymC
	bOXIzZBzCgZ4DovQrTnvmQtwLPyT0TQ/zY3UbXrcMMuxTxSQUf+FXqs7iccjuGiR+41pBiUrkXe
	dz2+oWtnc2fgYfTYMIX0GB9Vvazuwm12ZwcQW3mSZAUIHTYjGhduOF5QCWtFy8/ufSjAkfGKCDO
	xW2nowsgutGx92lAVRp6IjVIGHYgbzRSeyDq1vM6zNvqcrB5UTWemOJAZEyl/bJbpHKksy+L8Un
	OahWQn6DiGU9F9dnK/nuXeRWkuOY=
X-Received: by 2002:a05:600c:46d3:b0:4a1:97c6:d2e8 with SMTP id 5b1f17b1804b1-4a1fdd234a6mr52767775e9.32.1792596246445;
        Wed, 21 Oct 2026 08:24:06 -0700 (PDT)
X-Received: by 2002:a05:600c:46d3:b0:4a1:97c6:d2e8 with SMTP id 5b1f17b1804b1-4a1fdd234a6mr52767205e9.32.1792596246041;
        Wed, 21 Oct 2026 08:24:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.34.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcdd3856sm7018605e9.1.2026.10.21.08.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:24:05 -0700 (PDT)
Message-ID: <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Tomas Glozar <tglozar@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, 	linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	bpf@vger.kernel.org, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner	 <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Date: Wed, 21 Oct 2026 17:24:03 +0200
In-Reply-To: <20261021094853.29b9f7be@gandalf.local.home>
References: <20261001152042.124445-1-gmonaco@redhat.com>
		<20261001152042.124445-11-gmonaco@redhat.com>
		<DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
		<b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
		<DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
		<878q3xtptq.fsf@jogness.linutronix.de>
		<8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
		<87bj8s8ih9.fsf@jogness.linutronix.de>
		<DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
		<87v770uuyr.fsf@jogness.linutronix.de>
		<DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
		<87ik2zryzo.fsf@jogness.linutronix.de>
		<0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
		<CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
		<8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
		<CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
		<87pkx5q1w4.fsf@jogness.linutronix.de>
		<0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
		<87h5ifqy6w.fsf@yellow.woof>
		<a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
	 <20261021094853.29b9f7be@gandalf.local.home>
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
X-Mimecast-MFC-PROC-ID: wf8Fg8NoKjfiV3UGCQItEtk8d4zm5cRGqRnhvQzFHNw_1792596246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-21 at 09:48 -0400, Steven Rostedt wrote:
> BTW, I'm curious if it isn't possible to keep both in-kernel and BPF
> monitors? That is, for those cases that do not change often and has a wel=
l
> known model, to simply keep those as modules and hard coded.

In my opinion it is possible and I'm designing every change with that
coexistence in mind.

I would say we could only drop in-kernel if BPF does such a great job to co=
ver
every single technical and non-technical requirement or use-case, AND if it
makes maintaining the whole thing easier.

But I'd like both to be fully ready upstream before taking that decision, t=
hough
I'm getting more and more sceptical.

> But this entire thread started with people that wanted BPF type of
> monitors for more flexibility. I would argue that is an entirely separate
> use case. For them, it should be a fully BPF solution, with a few hooks
> into the RV infrastructure.
>=20
> It currently is a big unknown if the BPF solution can handle all the use
> cases of the current module method. My suggestion is to not try to do so.
> Keep the module method for the more static use cases that do not need
> dynamic changes. And create a purely BPF method for those that need BPF.
>=20
> This thread is sounding like there's different requirements between the B=
PF
> and module methods. If that's the case, let's keep them separate.
>=20
> I agree with Alexei's first comment about not adding BPF to the module
> method. But that doesn't mean we need to eliminate the module method
> completely in order to use BPF. Instead, just create a new BPF pure metho=
d.
>=20
> Perhaps in the future the BPF method may make the module method obsolete,
> but I don't want users of the module method having to do all these
> workarounds just to satisfy the BPF method while it is in development.

Agree, from the initial survey I had it seems some folks still prefer in-ke=
rnel
monitors with current infrastructure and cannot migrate (e.g. cannot build =
BPF
in their kernels).

Right now we're trying to understand what are the non-negotiables also BPF =
must
have and it seems we need some sort of tracepoints (via bpf_printk or somet=
hing
more convoluted).
That makes it converge even closer to the in-kernel monitors usage, althoug=
h it
still isn't a drop in replacement.

Reactors will stay, just probably not in BPF for now.

But thanks for chipping in, I fully agree.

Gabriele

