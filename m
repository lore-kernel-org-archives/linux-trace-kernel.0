Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763115D5B6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361800; cv=none; b=grMDrRTIL+ksa+8DFpEMW/wcrf5pTt1kEE9pbS8Dn9iB9DEbfwjRMJIPOaBBU4FcWJ2GegtUSHM4al5iqh3d1BrEEd47kkEbNOCMrFd4U5JjQNDC5RSdvfTZ9Z0aBjalrk+dcJetKwqW4XJB7+0JZDbccN4HKDLgHrIfnDywTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361800; c=relaxed/simple;
	bh=ZMeLY9TMS6LoideelZk2anXsuwUmf3hd8R0bNlUbBEQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldYXJSC5mLMMVN/wGJddi+hcdxP8ki/JY4lLRdb6zeccpM6NELSV24jHM5bNURmouAaHGHm9QGr3pSbmlUCjlAbNiBTuBbP4nqAaS1pIf3RFHVoNU9txHm3wQXG7GkTlAth32e6XTTrxc7II5xQ+Mb40u/D+DWtbBUrXDdJN63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fa/wCQDD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa/wCQDD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744361798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZMeLY9TMS6LoideelZk2anXsuwUmf3hd8R0bNlUbBEQ=;
	b=fa/wCQDD8ZhFdpDjymFz+A5lJqrSS4UriOLo0FN5yqTQbpIEEzKItJtHOZBWjTCUbsH9Wq
	JllxNN3K6mnV/bqh5vE5MrGUv19DHToLNs3hpP7Uv4Ixjxo4Nh7uprBKtJa0DWqcnWpiLn
	HpQkm7EhgSCO/KI1t2BktFzWIlBPix8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-hrebZI6TMrKp6KTqLzaRPQ-1; Fri, 11 Apr 2025 04:56:36 -0400
X-MC-Unique: hrebZI6TMrKp6KTqLzaRPQ-1
X-Mimecast-MFC-AGG-ID: hrebZI6TMrKp6KTqLzaRPQ_1744361796
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d6c65dc52so14488955e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 01:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744361795; x=1744966595;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMeLY9TMS6LoideelZk2anXsuwUmf3hd8R0bNlUbBEQ=;
        b=Yw22U5SPGvQ/F9WHR/9V0oDfVAi15qBJIAllD7cfJSLgaTwF4JR7ydC14RwisfkNL6
         gW/v2sqLLfm7HcQmQHp3ucugca/Z/GOa0PFPe9+evB3cRGNwok3cvnCSv8noD6DEsSz7
         8K5h1cCqPam/E4wNYsbLVShVYI9GRpqdMnKOUWb2P8Px+ZVEP19USvSaiFbc3EifdVyf
         NxWfWc2lWhzusxFI8eXus6VJ6pe/4OhnWWMl+VfAV/mHFjIBrSvLXFdRfBilP1thrfEc
         IatC04YpYnKjO8nOZNhbF9ix0afS+sbg1wJmL/wrMov0e+RzQeTyp2ObHUk7/RBGZNPs
         cQEg==
X-Forwarded-Encrypted: i=1; AJvYcCUPqxkFH313K71ksasoY61WTalphnXUsgWXhJ0s65xC/adKICW7T09IWpRMzaZr1eIvgfrg0oXVE47RKSGiEkX6NPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKaZf8cDMZR4j1ieM7Mqtp9WBMB7qojlkxKxCmktCIpsX0MFF
	UH6nUYOvw7+dyd3vCTch3iY1AbEfEp/VpGNkGxmT/aHm0qgR0PtoyRdQkL0B3NQrak8hcexO/kz
	sAfYSAEBxSL51Mi0XEXE6Ij/wQBKJlNFl9sWjT/Rc6IuyVuxkz25SYzJ32L+PL8/lLDcdag==
X-Gm-Gg: ASbGncv2wWoqdmvG+TU62pBzFbceUSFFxzsu1e17EgaNS6qnGcKIIpKf5+SugOLsoDQ
	Ca9qeL+4FbRLBYr6tu8Dpp8xRyQ0pz625qPvb0dhhzljeM3zUp71dJwSiwqu/jT931g7Zc4KC0Q
	wacFuBD+bE67fSeKE2xGvCnmoKdhD4SwDI4CHn4NCK4X0ZbC5aB2gB0WjzDB4TPkHVTzrzUmbRB
	TyECqiGfW+tJFsrIuK+Lv2vXgPgO+BlVfUAiCDf0g4jU1xR/BAJsnUV/IGJ4WIxUfhzCAnfZsYd
	12o6JieRsnZ0o34uNt8oDVIMTMtkWD/0/X8a5A==
X-Received: by 2002:a05:6000:22c4:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-39ea520702emr1348182f8f.25.1744361795532;
        Fri, 11 Apr 2025 01:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgWE01/s/69VbwckOORglh3fKMNqgEgRa/lnQj4myqjDBez6hDKqGKm35iy1mSbxBUcHFdxw==
X-Received: by 2002:a05:6000:22c4:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-39ea520702emr1348161f8f.25.1744361795169;
        Fri, 11 Apr 2025 01:56:35 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f204c500bsm83499365e9.0.2025.04.11.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 01:56:34 -0700 (PDT)
Message-ID: <03f2bf17986dd2811e02bace17fadf6f36c7080a.camel@redhat.com>
Subject: Re: [PATCH v2 07/22] verification/dot2k: Replace is_container()
 hack with subparsers
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Fri, 11 Apr 2025 10:56:32 +0200
In-Reply-To: <76c013727c81db5979f8f22c41794371bbaa5ba5.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <76c013727c81db5979f8f22c41794371bbaa5ba5.1744355018.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5RlpE7d2u2iebTUz9JJ5BTDe6bYfXXIy9v86sG768yY_1744361796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> dot2k is used for both generating deterministic automaton (DA)
> monitor and
> generating container monitor.
>=20
> Generating DA monitor and generating container requires different
> parameters. This is implemented by peeking at sys.argv and check
> whether
> "--container" is specified, and use that information to make some
> parameters optional or required.
>=20
> This works, but is quite hacky and ugly.
>=20
> Replace this hack with Python's built-in subparsers.
>=20

Yeah, that's much neater, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> The old commands:
>=20
> =C2=A0 python3 dot2/dot2k -d wip.dot -t per_cpu
> =C2=A0 python3 dot2/dot2k -n sched --container
>=20
> are equivalent to the new commands:
>=20
> =C2=A0 python3 dot2/dot2k monitor -d wip.dot -t per_cpu
> =C2=A0 python3 dot2/dot2k container -n sched
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0tools/verification/dot2/dot2/dot2k.py |=C2=A0 2 +-
> =C2=A0tools/verification/dot2/dot2k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 37 +++++++++++++++----------
> --
> =C2=A02 files changed, 21 insertions(+), 18 deletions(-)
>=20
> diff --git a/tools/verification/dot2/dot2/dot2k.py
> b/tools/verification/dot2/dot2/dot2k.py
> index 0922754454b9..9ec99e297012 100644
> --- a/tools/verification/dot2/dot2/dot2k.py
> +++ b/tools/verification/dot2/dot2/dot2k.py
> @@ -19,7 +19,7 @@ class dot2k(Dot2c):
> =C2=A0=C2=A0=C2=A0=C2=A0 monitor_type =3D "per_cpu"
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, file_path, MonitorType, extra=
_params=3D{}):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.container =3D extra_para=
ms.get("container")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.container =3D extra_para=
ms.get("subcmd") =3D=3D "container"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.parent =3D extra_pa=
rams.get("parent")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.__fill_rv_templates=
_dir()
> =C2=A0
> diff --git a/tools/verification/dot2/dot2k
> b/tools/verification/dot2/dot2k
> index 767064f415e7..133fb17d9d47 100644
> --- a/tools/verification/dot2/dot2k
> +++ b/tools/verification/dot2/dot2k
> @@ -13,30 +13,33 @@ if __name__ =3D=3D '__main__':
> =C2=A0=C2=A0=C2=A0=C2=A0 import argparse
> =C2=A0=C2=A0=C2=A0=C2=A0 import sys
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def is_container():
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """Should work even before pa=
rsing the arguments"""
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "-c" in sys.argv or "-=
-container" in sys.argv
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 parser =3D argparse.ArgumentParser(description=
=3D'transform .dot
> file into kernel rv monitor')
> -=C2=A0=C2=A0=C2=A0 parser.add_argument('-d', "--dot", dest=3D"dot_file",=
 required=3Dnot
> is_container())
> -=C2=A0=C2=A0=C2=A0 parser.add_argument('-t', "--monitor_type", dest=3D"m=
onitor_type",
> required=3Dnot is_container(),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help=3Df=
"Available options: {',
> '.join(dot2k.monitor_types.keys())}")
> -=C2=A0=C2=A0=C2=A0 parser.add_argument('-n', "--model_name", dest=3D"mod=
el_name",
> required=3Dis_container())
> =C2=A0=C2=A0=C2=A0=C2=A0 parser.add_argument("-D", "--description", dest=
=3D"description",
> required=3DFalse)
> =C2=A0=C2=A0=C2=A0=C2=A0 parser.add_argument("-a", "--auto_patch", dest=
=3D"auto_patch",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ac=
tion=3D"store_true", required=3DFalse,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 he=
lp=3D"Patch the kernel in place")
> -=C2=A0=C2=A0=C2=A0 parser.add_argument("-p", "--parent", dest=3D"parent"=
,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required=
=3DFalse, help=3D"Create a monitor
> nested to parent")
> -=C2=A0=C2=A0=C2=A0 parser.add_argument("-c", "--container", dest=3D"cont=
ainer",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 action=
=3D"store_true", required=3DFalse,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help=3D"=
Create an empty monitor to be used as
> a container")
> +
> +=C2=A0=C2=A0=C2=A0 subparsers =3D parser.add_subparsers(dest=3D"subcmd",=
 required=3DTrue)
> +
> +=C2=A0=C2=A0=C2=A0 monitor_parser =3D subparsers.add_parser("monitor")
> +=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-n', "--model_name",
> dest=3D"model_name")
> +=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument("-p", "--parent", dest=3D=
"parent",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required=3DFalse, help=3D"Create a
> monitor nested to parent")
> +=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-d', "--dot", dest=3D"do=
t_file")
> +=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-t', "--monitor_type",
> dest=3D"monitor_type",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help=3Df"Available options: {',
> '.join(dot2k.monitor_types.keys())}")
> +
> +=C2=A0=C2=A0=C2=A0 container_parser =3D subparsers.add_parser("container=
")
> +=C2=A0=C2=A0=C2=A0 container_parser.add_argument('-n', "--model_name",
> dest=3D"model_name", required=3DTrue)
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 params =3D parser.parse_args()
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 if not is_container():
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print("Opening and parsing th=
e dot file %s" %
> params.dot_file)
> =C2=A0=C2=A0=C2=A0=C2=A0 try:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor=3Ddot2k(params.dot_fi=
le, params.monitor_type,
> vars(params))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if params.subcmd =3D=3D "moni=
tor":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
("Opening and parsing the dot file %s" %
> params.dot_file)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monit=
or =3D dot2k(params.dot_file, params.monitor_type,
> vars(params))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monit=
or =3D dot2k(None, None, vars(params))
> =C2=A0=C2=A0=C2=A0=C2=A0 except Exception as e:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print('Error: '+ str(e))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print("Sorry : :-(")
> @@ -45,7 +48,7 @@ if __name__ =3D=3D '__main__':
> =C2=A0=C2=A0=C2=A0=C2=A0 print("Writing the monitor into the directory %s=
" %
> monitor.name)
> =C2=A0=C2=A0=C2=A0=C2=A0 monitor.print_files()
> =C2=A0=C2=A0=C2=A0=C2=A0 print("Almost done, checklist")
> -=C2=A0=C2=A0=C2=A0 if not is_container():
> +=C2=A0=C2=A0=C2=A0 if params.subcmd =3D=3D "monitor":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print("=C2=A0 - Edit the=
 %s/%s.c to add the instrumentation" %
> (monitor.name, monitor.name))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print(monitor.fill_trace=
point_tooltip())
> =C2=A0=C2=A0=C2=A0=C2=A0 print(monitor.fill_makefile_tooltip())

