Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651607;
	b=RnkbTCKGkbywe9tESwMeg20npxQ+Dw/XEEZPId1NQE/yk3n9VbzB07qF9D+4y0h+g368
	 RaWdeka005VF05psPeP+BSswIiEqQlKQZ7WQaIbv5PLWc6eKdUua7dhEmW0g0EBfuNf9o
	 mDZ1SBljiW++ZBM0Yo8uHtRLTAJPvVm7L8MDZavtyuYna0u9Ztn0NFqXBFu96LfVZDNZ9
	 k1/BpLYoCyx3cgCGbDzLvyET5ZYI9KwW0eLCdrWAA1l9NN0QQ4C6YUf11ELBBhNDU2ruk
	 3F4AybgnRbxEOpp/j283fKxFj+sM9vMXC0/pHWQwnqZYZJKlTPnbRS+QR4CkdPs/m6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651607;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=TKtpG0ZG3GV7aCNX13qQJC+OLUZxo8z1O02EgwHPjyE=;
	b=ciC4YA0J/NvPkoLyutw/L3sRBOzPBUccqL+xirfHNpE/eC044m/dUT78B2fwvW4Zx9Mx
	 5VRjMgUKdsIL7aN99kVVeONSyGRy7wkkDrv8NYz7oLiMeU2C3fb88jkqb2JWszEJCAMZa
	 k0WX1Xo4rBVur7glf+wDxjnybkHXbPEh1CArxBiZzIiDrZqnJiqnXX7OoWe3RYtP1sYDs
	 ABi30krxgtAr4n2wdr7b3jbsNYbuHGJCu5u5tTnwgyC1kRKw/adNaF+/iqS/wa07bLxyy
	 reH1Qb4zwiEDKXc26RJ/ftx3A0DS7VC1aY7Ros/SwAi30TMSfzQtUonqwVxhdJblwJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERbK86kH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8A606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 06:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8C8A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERbK86kH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792651605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TKtpG0ZG3GV7aCNX13qQJC+OLUZxo8z1O02EgwHPjyE=;
	b=ERbK86kH7vE32/b6M8SED9xNn4Z5R+eil8IZjVzJDZ/Ucs2eaN5WImGWQb6WybJr0V2pqX
	94sxXX0TQB4E5FN6tJ0Nb5unh3bnZieSMNHs+xqcHCzbZIyoJoiacvs9ZfVhsTr9p6uB6W
	SmXTrWNHninI/StMlY8u/dx1Qq6YisQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-q3huPz-0Praa9aeR3pRv0w-1; Thu, 22 Oct 2026 06:46:44 +0000
X-MC-Unique: q3huPz-0Praa9aeR3pRv0w-1
X-Mimecast-MFC-AGG-ID: q3huPz-0Praa9aeR3pRv0w_1792651603
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dea677afcso397751f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 23:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651603; x=1793256403;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TKtpG0ZG3GV7aCNX13qQJC+OLUZxo8z1O02EgwHPjyE=;
        b=ryIW6U5NB7V9TABUrjHOgGVkEPhWgH7vLVACSPJEgcHF4rjTntOHAqk/b2A/HHK+Of
         8eaJWiG8JFQKOydtlnRmEvlzYLlzpapIw6bnhZxjfTIruZyP3Fym8cMNYY+aEQ/iC/lm
         BdVZ77LwJ8zWJIizG9Q7mg4YvZUaM+OzVk8TZ4uwvFFATt0/QikiGJo/hk9dqF4UCp9o
         Ic1cqeRje0ZrzP60qGhbTj8Xotz9d9eSQPn1vpLmfKFdHCsCWjTr9sT6ufa9/C/5GdU5
         ANWizk/mNV3bOHTe0SVtd05PLSfJZiQ4NZ3NWP6BgSt0xE2L7119an3ZhZHYepvPBejW
         8ncQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJxG3MliyC6YPWMG74ZfSlpkBmY4TWfcG/eunIDZz4fP1nApLpb+wi5ery6KcDeTNdbwVDq+hlTnL4A8Didsgpr0Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWbEvqRTFGDuOOb/WhSLOzW7+U9p6GY0nl8I9Tmb45paNgGxVB
	t3EOrtsRxOt3iMBAAHbjMk6KW4xjZkyCXEYZ+mdqMblf1Op5RtKuIVi+3xEx8FEAoRJEo+2G6BY
	SH1IT6fuj26sI0hQSrwfte/WNvuMpbr8vArCehR+x3XoXoUc2oXBtbnakOFEsf3cVeBxxfpdXig
	==
X-Gm-Gg: AYBFou3TixgliAuya/afopQTTDkHvWW5xIkdUCkxt84o7VuxfAgPS8o2FF9r4ujBqR8
	8IGgN0eKGaajYX7onKJFFUU++8FVQW7gxWixS1hNWbt2mvc3vP7uMDrj2GxfRdcPt0Ayv07HoIr
	pDTmV9ohuKQkBW3tt3k1yKtGkA08EW0LrBeaYrT96uuXzE4Up3cGM1LX2ONtTXcMpdaeBISOR1w
	2ZXiqbEvaaDKsCFlvfuHWgmOC+GFpM3LX+cbriof2xbB/DypiXxBujWbLs3Acx1EksczGh7d6FM
	rRjs+jtA5HDM4csnhjdCvYz9beqJwKjkKD6WHhUwlVsPZhBjOv94fWbvVziCVXCZQrpit/YOD3O
	IXQa9WoaWDGII8R41EyJUerltmO8d
X-Received: by 2002:a05:6000:4b11:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48e2d24e4acmr3010780f8f.13.1792651603110;
        Wed, 21 Oct 2026 23:46:43 -0700 (PDT)
X-Received: by 2002:a05:6000:4b11:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48e2d24e4acmr3010732f8f.13.1792651602647;
        Wed, 21 Oct 2026 23:46:42 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25840115sm10061810f8f.48.2026.10.21.23.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:46:42 -0700 (PDT)
Message-ID: <f147fa9dfc553767ce92802b66723a85cf804e46.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner	
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Thu, 22 Oct 2026 08:46:40 +0200
In-Reply-To: <87h5ifvw3p.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
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
	 <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
	 <87h5ifvw3p.fsf@jogness.linutronix.de>
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
X-Mimecast-MFC-PROC-ID: vFagi0jfLmdQXdSI_FH_-irZNU4Pztg4XL0IP7aIRPQ_1792651603
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-21 at 18:53 +0206, John Ogness wrote:
> On 2026-10-21, Gabriele Monaco <gmonaco@redhat.com> wrote:
> > > BTW, I'm curious if it isn't possible to keep both in-kernel and BPF
> > > monitors? That is, for those cases that do not change often and has a
> > > well known model, to simply keep those as modules and hard coded.
> >=20
> > In my opinion it is possible and I'm designing every change with that
> > coexistence in mind.
> >=20
> > I would say we could only drop in-kernel if BPF does such a great job
> > to cover every single technical and non-technical requirement or
> > use-case, AND if it makes maintaining the whole thing easier.
>=20
> I am wondering if coexistence should be the goal. For example, the
> monitor classes (DA, LTL, HTA) are only implemented in the kernel and
> provide kfuncs for the state transition functions to be available to BPF
> monitors. I would expect that this would allow BPF monitors to have the
> full functionality as in-kernel monitors, since the events, errors, and
> reactors would all trigger from the monitor class code.

Well, this would be yet another hybrid requiring BPF monitors registration =
in
the kernel like I proposed in the RFC [1], which was the main point of
contention (that fully shared reactors and sysfs interface, by the way).

For this I would argue, though, that such monitors would be BPF just on pap=
er,
we wouldn't be able to use many advantages BPF provides (e.g. BPF maps).

The current implementation already shares the header with in-kernel monitor=
s, so
the actual logic is shared. What isn't shared is the storage type and some =
glue
around it.
I used BPF maps because they offer some nice flexibility especially around =
per-
task and per-obj monitors. On top of using more battle tested code.
I would like to keep that.

Besides, we'd need to be extra careful on controlling the callers. Right no=
w
handlers are static, so it's easier to make sure no rogue caller messes up =
with
monitoring.

What else definitely isn't shared, which is the main point of this whole
conversation, is trace events.
Those could be kfuncs. And no matter what you do, BPF monitors will need to
share the trace events (unlike in-kernel that have separate events per moni=
tor).

In short, I don't think this would be easy to achieve and wouldn't earn us =
that
much. (Plus I'd lose the hardly earned Alexei's blessing ;) )

What do you think?

Gabriele

[1] - https://lore.kernel.org/lkml/20260831090524.106845-1-gmonaco@redhat.c=
om

