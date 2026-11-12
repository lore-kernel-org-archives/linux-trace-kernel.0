Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482640;
	b=Wi5f2x+FlbHvgEBySrM7lqUeFEEL2AIu/xTj7RXFlDEiwTgd5L1j3p8GQnWYnBsvp9Oe
	 nJg9Yz3M9iSkgpGBbQy3kpzCqbNQOAwNwT6DQCnAMERhWp1EsY2P9qEGYA9YcnjQSsjuD
	 OQ+zIBllk4/bzYgGHf8Pll83MPHY08MNZEs0rRqcXSJHUUh8aUiDxTQPdP8ME104Y7SRg
	 djyRf03tw/E9WXYQ4y1qvC/Op0U9S0mS53JIExGNhSQhhH3i1rcjGYBRVHTPHW+/2MuXI
	 b2d7hW9my7m+lD6g4TrQiGzL3bgCXCLjWnsNFwJemN04OP2nwc9VGMf6sJJgfTYB6nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482640;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:User-Agent:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=eL00FFNkl8ARbho6ymbLoUfkpUup+XSnywEPwkoXmUQ=;
	b=l9zRG8kaFDxtAZgSljT1OFqRggFaVfTt0BAX8TVHlLGcFLyd1nesrdVNvKFcfba4kT4k
	 d0DTa8wpvKb6Fs6L7T4oA0UwN4/iYw1aIBlaCUMuYCRiRZR7VCqLwDdEPXm5p8a0rMtXL
	 1kMZWiODWExWIBJ8UdJa+SM5beP/ytZHTRAqnypkZ74FSGgjfQPHFqo3WdyZYevqOHjeh
	 5VyEA7D+UibSMcAao+KbNl/x8DS3QirDoDuvC0kCkW9cBph1wYU8NKBOI6CRfA3FUVqA4
	 16uhKf3Xis71ATf9DgNHHqZupzVAaNZQuA5Q2BUSRUUcBirrMKEEv1r4kdruS6zkH0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="X6V2ExG/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F4606A333
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 11:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC1F4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X6V2ExG/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794482638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eL00FFNkl8ARbho6ymbLoUfkpUup+XSnywEPwkoXmUQ=;
	b=X6V2ExG/G5kNWwUSC7ZhJFEcs3qhrFzbjFMlqAdNZ8GOE4B+6hD6T1FmywIbyDIkeh0qr/
	RM+MTsuyZIYR6VmdBOslg22qowb2S3Kj56gXZWRYnehkhxAA2l5i6N/2KdIItMJOjMeUlv
	et1+l42nvPM+GIbUC6HX51rH4TOXRfE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-YaZJ9_gDMBCzBjZhTjp6og-1; Thu, 12 Nov 2026 06:23:57 -0500
X-MC-Unique: YaZJ9_gDMBCzBjZhTjp6og-1
X-Mimecast-MFC-AGG-ID: YaZJ9_gDMBCzBjZhTjp6og_1794482636
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so3149239f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 03:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482636; x=1795087436;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eL00FFNkl8ARbho6ymbLoUfkpUup+XSnywEPwkoXmUQ=;
        b=GmfBggF14b9+3y1BrK9LkJXvXLnrU4fD28y7bqunAH5GDrgVEsfP1S52GZW6SSbPrE
         uHg7JUTlPCHoy/bErn+5K9ZIisv51V31/9YL6pXnXzpLVUhKA1n2LfzJYTmlapYmIAtF
         HC2PwkDT1z8e7RfOCKR8fQG4Dzp2BRvl2BUxJqqJKmddVlaKwojm4k6u4Q10a7KaoF2v
         T5aENLHQmk9Dx2nwBquN6NTMONL4KPGOMLMMPGZ4PWfWd7s9jjJAgsp0mgnkgPq42Uie
         +zOqPkOWPchjW6bopb50I4ybHHHmxiinr4YgCxWs8pNvve+sYguRn7ICcFHRdqy5SCh+
         t4eg==
X-Gm-Message-State: APuU4Z/BMtWq0fvPMiifPGLGck+5yI6M37ky7yzcTrpn0/TPuKmPCeVG
	AoLxD3MWloSL2l8CBCXSnWXlL1EqZrnj6yd+FjYPSOffL8ozyfLOT0zKn8vyV5o1y3QRncBRjim
	w45u8v93HYlo6jmQFUM0TKN+iRz/pIPbczA/xNTGO6dBf+WoSROgWqPI1rii1LMLTCL3OgrcfoQ
	==
X-Gm-Gg: AYBFou1B0sZe5Ep0xaHhnFizdeXU20kS6XZco9dXEsSB/TAJpLlWk0yYyB1cdtm0FYo
	nD/z8Az06zXhK50EaYvCyVLCG52juNNz0my8Vm3veZe+4Jk0V/9LNYS4l1i/j3J8mH57o1r38Z4
	TbJV6X2x8KywazMqxVahjwqPcdJDYD/CfS5f3Icdme9TndfHZooiiTnezA+0MTaCrUR0rDCQpyP
	t85kgiRX7hPxTbxXfzIMvuUc704ewHCwsnJx7kAOABoS5jQma/tVxr9JjgbZel8TMzpl2W/dD/k
	UnYeguwGD8ztRpt0XuSmShb2dPe9rYsRSgrzNYMgwq5mE1OUtCRjWbfL94d+yGDXm80ongmF82p
	B2HhHgF5lkIqNikrf4otfaO6PLl/8UmPXE9BqDEiNEhNUe7hKE+/mj/mGNc/4vuXn5BpJ6xds3o
	hpug==
X-Received: by 2002:a05:6000:490f:b0:48e:43a:1d84 with SMTP id ffacd0b85a97d-499c6f8d887mr8640195f8f.23.1794482635982;
        Thu, 12 Nov 2026 03:23:55 -0800 (PST)
X-Received: by 2002:a05:6000:490f:b0:48e:43a:1d84 with SMTP id ffacd0b85a97d-499c6f8d887mr8640154f8f.23.1794482635530;
        Thu, 12 Nov 2026 03:23:55 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498363e0019sm17112948f8f.38.2026.11.12.03.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:23:55 -0800 (PST)
Message-ID: <811fd37b6e87ada820dd59c676e2ef23a999d07a.camel@redhat.com>
Subject: Re: [PATCH 1/2] rvgen: validate the monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 12:23:54 +0100
In-Reply-To: <179447882046.254241.15114935256138596418@gmail.com>
References: <179447882046.254241.15114935256138596418@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
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
X-Mimecast-MFC-PROC-ID: gUle_Yg3cPOcQJnFSYVVflJcO1Jsu4i9ZuA927FX4Ik_1794482636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-11-12 at 18:20 +0800, Chaosheng Qu wrote:
> From ef3ed8fae481c0ed3dd16c881aae455be9e92f2e Mon Sep 17 00:00:00 2001
> From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
> Date: Thu, 12 Nov 2026 14:26:10 +0800
> Subject: [PATCH 1/2] rvgen: validate the monitor type
>=20
> The monitor type is pasted into the generated monitor as RV_MON_<TYPE>.
> Nothing checks it, so a typo yields a monitor that cannot build and the
> tool still exits 0:
>=20
> =C2=A0=C2=A0=C2=A0 $ rvgen monitor -c da -s test_da.dot -t bogus_type -n =
bm
> =C2=A0=C2=A0=C2=A0 $ grep RV_MON_TYPE bm/bm.c
> =C2=A0=C2=A0=C2=A0 #define RV_MON_TYPE RV_MON_BOGUS_TYPE
>=20
> include/linux/rv.h defines only RV_MON_GLOBAL, RV_MON_PER_CPU,
> RV_MON_PER_TASK and RV_MON_PER_OBJ, so that macro never resolves.
>=20
> The accepted set is already in Monitor.monitor_types, which the help text
> prints.=C2=A0 Pass it to argparse as choices.
>=20
> Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
> Assisted-by: LLM

Looks neat, thanks!

Some minor issues on the submission itself. Whenever you send a multi-patch
series make sure the patches are part of the same mail thread, this happens
automatically if you use git workflow (format-patch, send-email) [1].

All tools expect that so it's much easier for everyone to see and apply the
entire series.

You'd normally also add a cover letter, but for a simple series like yours =
where
1 adds the feature and 2 tests it, I'd say, you can skip it.

Essentially if you want to do it manually, the In-Reply-To of your 2/2 shou=
ld be
the Message-ID of 1/2 (or of 0/2, the cover letter), but I strongly advise =
you
to use git tools.

Also, please use consistent commit tags, so both your patches should have
verification/rvgen: instead of whatever you put. If in doubt, use git log -=
-
oneline <modified files> to see.

Finally capitalise after the tag (e.g. uppercase Validate).

TL;DR please send a V2 where both patches are in the same thread and the co=
mmit
messages are:
verification/rvgen: Validate the monitor type
verification/rvgen: Cover an invalid monitor type

Thanks,
Gabriele

[1] - https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l

> ---
> =C2=A0tools/verification/rvgen/__main__.py | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/tools/verification/rvgen/__main__.py
> b/tools/verification/rvgen/__main__.py
> index 246b43fa2..6053db5e5 100644
> --- a/tools/verification/rvgen/__main__.py
> +++ b/tools/verification/rvgen/__main__.py
> @@ -38,6 +38,7 @@ if __name__ =3D=3D '__main__':
> =C2=A0=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-s', "--spec", dest=
=3D"spec", required=3DTrue,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help=3D"Monitor specification=
 file")
> =C2=A0=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-t', "--monitor_typ=
e", dest=3D"monitor_type",
> required=3DTrue,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices=3Dlist(Monitor.monitor_type=
s.keys()),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help=3Df"Available options: {=
',
> '.join(Monitor.monitor_types.keys())}")
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 container_parser =3D subparsers.add_parser("cont=
ainer",
> parents=3D[parent_parser])

