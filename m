Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425561;
	b=4QpYcEqk887/h7a0x4diS0SsLcyweaSTfyXcyORlvFoS/E3ztdVMdge4+MhQNoZ/Spsg
	 XogxIJKAjHLeLdkiy0Lg/lpkdOgIKtpBHGgSoBbu6rNfxkbybnTr9edOqrU7/zEmUrm+T
	 ztxyiQLpPuds3XeuvfxrNVisTfRSfCHmhWhqtl8ifgDfRkJz9gWVd8fqaC3EG0ovVfkYw
	 eIhlml7DEDqHxp6+EBHAc+mtzYkcflmNXoOYVyJzWlZTFVrlO+33P6nXLyJI03OjA/Cfn
	 Ge82kjT9SLDTWjl/3ty7XqEWeUFIS2d5xOsqSZOsfwQwDgYscQJXd1JIrQD65TQbBng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425561;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:User-Agent:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=LYIir9UbeEi2CT2gDPhDzZBEiArUOUKkyz2EAXQH95Q=;
	b=u9lHqQlE77CNX4ewStN/ANmILq02+95HqN9ddk0vRh9AfsluBNsAVffkcs9+qmkoOJUR
	 JgY2WcwMJ3v57F6KDHT/CrjBDOGWKx3cevfRjkzQUWFO2JEYiWL1Sns2VoADTK7RcaOyz
	 iFFeVVGQvB3dK2WxVrlR01QfwWbrZ8TS3bB0z/z/VnLrIWWUhJt909aOCqHQqBIuycgB5
	 FRrYm6Q/mWP0vk5aEfBSmM03Z1IrRxCqZ13vA2KB+Lc3dojCUVwvZKpCUZqFjhGqAjiW6
	 o/Lv5RK4uFls4ijdqRsEs9oxf4+hD37neOEyvU5IjAYQ2YC657Dkr+cNBguZ33PpVHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="MT6Kc3/K";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E62606A321
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 09:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E62606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MT6Kc3/K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795425559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LYIir9UbeEi2CT2gDPhDzZBEiArUOUKkyz2EAXQH95Q=;
	b=MT6Kc3/K4+jZUKko057P+AVb+j8CAn/NIYowTP01ipWKBedAWKSZIvWJMvmV5FO1nDG00T
	S5nhgypU8RSeTH2T9ERFVevP0J98iZsfNrk/Q9Lt8oCM9LjP2xoWcLDWHCGeP+WI3zwPOu
	qI+nbBYoekR6AnX7dNkRgebRVSYhTgw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-_tQodSPBPROQ7BI4lPRDzQ-1; Mon, 23 Nov 2026 09:19:17 +0000
X-MC-Unique: _tQodSPBPROQ7BI4lPRDzQ-1
X-Mimecast-MFC-AGG-ID: _tQodSPBPROQ7BI4lPRDzQ_1795425556
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so29576315e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 01:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425556; x=1796030356;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LYIir9UbeEi2CT2gDPhDzZBEiArUOUKkyz2EAXQH95Q=;
        b=mTcKJZaGGzFYMStXIHuP82J/CPzBJhLe8Iyd4bBVVDsA37pISDCdthieTfJl/7t1dP
         UCMQuzK9PI3PJ7YUSWJ29yCBjbDljVuVVNci7YarnqyrvC0pBBFVI0Gfdl/DBvEhkXEZ
         W8eCPqEtpFiw4KXJZTY1DeNbDyfkdF34HGxtZpPQ1AINPExAmja0BsItMA5IyvRjQIN7
         ZGir1rYR31d1N2zTIHYswjO/Amej12N5Cc8S9bCtc0FVHbtTy196MUXIEKCVeS2jd3+D
         qd04+0tU9WKjCkwwAob6zBwA0RXwWURIhhOjpTN1ZfuX6HFA+2o4weBfD8/XPk90WsXx
         7o9g==
X-Gm-Message-State: APuU4Z/GCuGBhjdKhGgz/W0K7rO7fUL26brZWbRbFcDsf4YGavTHtfqB
	4VfW4hLwZYF/36qDRfbzjrIfb3C6+zYPaR60ZUj5HKbDrzgOzPBs1W0Bvuit1VxDxuDjQYDQXxe
	bK9gNvacUwkawoPVHlQQlg+yI1TIZkw6h7J4GCBtfNsZtcBgViynCVsRm4JB1zjSSi7zayDsJoA
	==
X-Gm-Gg: AZFdTZdvOLqBSVUrIxaTNgL7qBSobChvciLKQGtBImhSg6aRMZaITsWEYJCipcxoi7A
	P7tLwY5DixVGdpqCZgpC3gdufHb8DYXe5hbCfIItWbqQzTilok5izbNFbWQNCklx0xXeQX2r5Dp
	5uu1zayIgqUTfp76ks4TXABy3YsVwmP4gN3tjIzI+Oi1NT6t+F+ejovm5VKP8YTvj7T8DFDu8wR
	jPlU5udQ1Bn862nvmFqYIQi2ZGlxpP/65FLs+6/pQPkd6v4+sGG9nSVAjTcKxbbgeX/9abuBMPt
	Ey5NLsnG33DXeSNw8PLJY4zHU0UDWrd9SX/uLRfP7V7NOxoNomZ17jKJOtAsfDQEE4ySWMVgoOc
	XH/PKgXM7MH42cRnA/BI2ZBguJDQJriiuQSavvVidSSx4K2J4cuprUNKUVFHe5nMvzyeEZp63BF
	M3
X-Received: by 2002:a05:600c:828e:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4bb88785898mr234333165e9.0.1795425556197;
        Mon, 23 Nov 2026 01:19:16 -0800 (PST)
X-Received: by 2002:a05:600c:828e:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4bb88785898mr234332685e9.0.1795425555832;
        Mon, 23 Nov 2026 01:19:15 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906635c7sm166276135e9.2.2026.11.23.01.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:19:15 -0800 (PST)
Message-ID: <58930dc60d410ae8dac5a5bbe5e9048501b5b1db.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] verification/rvgen: Validate the monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 23 Nov 2026 10:19:14 +0100
In-Reply-To: <cf05914335850f6835ae79b34d6b4ad891128948.1795252297.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795252297.git.chaosheng.qu.linux@gmail.com>
	 <cf05914335850f6835ae79b34d6b4ad891128948.1795252297.git.chaosheng.qu.linux@gmail.com>
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
X-Mimecast-MFC-PROC-ID: P_P6dWBemqvABxZgvCpdOYwzqvdW1t1ABFjKFVbny_8_1795425556
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-11-21 at 19:31 +0800, Chaosheng Qu wrote:
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
> ---

Looks good now, thanks. I'm taking both.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

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

