Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA3239E6C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494757; cv=none; b=Ne56cOUpk/cL6hX+Pzux87K3bRxeLPHCLCU+CW0CeUbS9pQZuWGVVQqtJGtWE/kwTmRxc3nii0ZVY5ZMbTYWUVfqeFB7oSKJBI4uJ5qr3ZvMix79ljG7HCQOcA5oLXbmiu1c+xc6/ex847uYOJjEpl7JtsyNdF1To3Ey3I6Q+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494757; c=relaxed/simple;
	bh=DBjxgqzhLyqr+5jR4tR6G+Z7H9K/9xNqSbLsQcc66CQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1fLTtoPdZbcaoFBEM2qeXkbK36Kfr8DJ0LeMBfQKjI1ELttqgcPEYCN7kHE+e3TvTBY5VA+n3YZIdFXB7ugfLm0ypRUpuzq3G9U2gQjk0fts+qNmbZHQkm8PpQZ8ECInGa09W9DyFl4/ZHmHZ0izzEhGxuXY3sheGjI0zOzF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dypLoNCo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dypLoNCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756494754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3kgFQM8E193WuypFwYt3KeSqLfZ27yc2dsVCdV+lZs=;
	b=dypLoNCoywx7CapC0Y/Vd9VsLgDzF0CEMi6PXV90f2b7hXY0wFRudE+ijX0lCfj139nFOG
	T9lWdaUut3gzlkGxqnnQRh/CNuZ15gJwsmoL1bed83HgDB6+cD/AjB4fKcKUoGGQWPUqah
	vFe7HDF7Rd68PM6NckK2od2T6LqYd0k=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-2IX7lMIxMJ-dKccbyehzig-1; Fri, 29 Aug 2025 15:12:30 -0400
X-MC-Unique: 2IX7lMIxMJ-dKccbyehzig-1
X-Mimecast-MFC-AGG-ID: 2IX7lMIxMJ-dKccbyehzig_1756494750
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3eb14eebe86so49876505ab.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756494750; x=1757099550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZm2cWpIstR902xrNzB24xS3rX1N5ZEznfpie+G8xH8=;
        b=gDmrYFU4Loul+T4cOvBfvGhpteLK9l8pz6mw0gmJL85hDSB0PHp3JKRt7NINUZQW6v
         IcLyJRFea0tZjYkiJPt3pIbEVq5ZTY+sQqBfBzqW1lUwEmXuAuLEuUkgaYGDGvtO1VbU
         tDuBTBrpARV2677FSAqTIUt5uB7d6FTg8hEJzLLM/I+Kuca0bJ2fyevAszrm6bEs7RH0
         /pFrwZ96UCyvxSfu+YTRvf7HfqknuE3iKX1lDfylh+TdvQRZ/03Wz4gfJiErZcZ958Dp
         7yAM3p7iMdY4HiID+X18/wvIbibh2v4NeX8UXs1RA5GCrjBuCjGfPZxc+xaQp03m6+uE
         HrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Uoo5Nvx8Yhgvd41WSVG3Y5/Zn8cklx3Ls+HlT+MO7MLpMrWEQaLzG5/SwwgsewDR3V+xdhnmTyM7B9vUIZfT6Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmFzyFP2GjQuMM3ETSSlycvzrowa3QOIQneQ50o81SH/Tcvmr
	/BmyXQgFNm8Mm60fg/7h4LWucTiB9F1bjq2rgq16YskknJVEVu7N2MNT2yNZWG+FCJt47nCXF0Q
	ZgquF6baoeK1nLrUTFWXRmxAYL2K+/nXxIOipLCOcTojWP7sqWEbRuNMswkXBFnQNcg2M6Tz0iA
	==
X-Gm-Gg: ASbGncvISYLNhh3835FsPoPlVgAIA/Yn7EdnT5HrI7nfRWNuLYcj/iFWNyXTkowfpMN
	nzNKp4uXO4fXnGXcDOqwcv3K14u7TBhUHCVc0GJaxy5JYqXpmocWTD+Ghr6xIvofXVkIcW0q4c0
	GdwAAW6KLNhbkJ/5034dzVrA7Z7dLLtZnJVKz+2Sqey2QEF4gnhT0nsAA1I8zQw0stn59gk7ZGr
	uusSZ3vfxUOeW652/VBA1gR0pRp1tcB2G/3YJL8cXRUlipMeYcCfx3Gg1ZERzon8fvEq31CZn7H
	Rv9ZG7YE5dFRMSdGfQEG7OlYgQ/IDFDxrYdAONezzopJ6wK2yw+NnKxoNukmtQGPWsNL
X-Received: by 2002:a05:6e02:1845:b0:3f2:102b:bb3f with SMTP id e9e14a558f8ab-3f2102bbe6emr94593435ab.16.1756494749708;
        Fri, 29 Aug 2025 12:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp17PYTjscfY9oa2sbWXEFfqHk/8rOHgt2sJktj1EO4noupiV57kW7xO47q2rgyKkjnPt3LA==
X-Received: by 2002:a05:6e02:1845:b0:3f2:102b:bb3f with SMTP id e9e14a558f8ab-3f2102bbe6emr94592895ab.16.1756494749273;
        Fri, 29 Aug 2025 12:12:29 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f3e6c3asm38211173.84.2025.08.29.12.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:12:28 -0700 (PDT)
Message-ID: <3b9bf6e435b2eb85b44557d474a003ec6d2c0c1c.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] rtla: fix -C/--cgroup interface
From: Crystal Wood <crwood@redhat.com>
To: Ivan Pravdin <ipravdin.official@gmail.com>, rostedt@goodmis.org, 
	corbet@lwn.net, tglozar@redhat.com, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 29 Aug 2025 14:12:28 -0500
In-Reply-To: <9394c039d5c957bd8417669148391e20fa1276ee.1755018581.git.ipravdin.official@gmail.com>
References: <cover.1755018581.git.ipravdin.official@gmail.com>
	 <9394c039d5c957bd8417669148391e20fa1276ee.1755018581.git.ipravdin.official@gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 51lvA4NDeul7hlMjU8zHb9OVMbpnxBJyThuYfIfxOdk_1756494750
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-08-12 at 13:21 -0400, Ivan Pravdin wrote:
> Currently, user can only specify cgroup to the tracer's thread the
> following ways:
>=20
>     `-C[cgroup]`
>     `-C[=3Dcgroup]`
>     `--cgroup[=3Dcgroup]`
>=20
> If user tries to specify cgroup as `-C [cgroup]` or `--cgroup [cgroup]`,
> the parser silently fails and rtla's cgroup is used for the tracer
> threads.
>=20
> To make interface more user-friendly, allow user to specify cgroup in
> the aforementioned way, i.e. `-C [cgroup]` and `--cgroup [cgroup]`
>=20
> Change documentation to reflect this user interface change.

I know these are the semantics that --trace implements, but they're
rather atypical... especially -C=3Dgroup.


> @@ -559,12 +559,17 @@ static struct osnoise_params
>  =09=09=09break;
>  =09=09case 'C':
>  =09=09=09params->cgroup =3D 1;
> -=09=09=09if (!optarg) {
> -=09=09=09=09/* will inherit this cgroup */
> +=09=09=09if (optarg) {
> +=09=09=09=09if (optarg[0] =3D=3D '=3D') {
> +=09=09=09=09=09/* skip the =3D */
> +=09=09=09=09=09params->cgroup_name =3D &optarg[1];
> +=09=09=09=09} else {
> +=09=09=09=09=09params->cgroup_name =3D optarg;
> +=09=09=09=09}
> +=09=09=09} else if (optind < argc && argv[optind][0] !=3D '-') {
> +=09=09=09=09params->cgroup_name =3D argv[optind];
> +=09=09=09} else {
>  =09=09=09=09params->cgroup_name =3D NULL;
> -=09=09=09} else if (*optarg =3D=3D '=3D') {
> -=09=09=09=09/* skip the =3D */
> -=09=09=09=09params->cgroup_name =3D ++optarg;

If we're going to be consistently using these semantics, we should move
this logic into a utility function rather than open-coding it
everywhere.

Also, theoretically, shouldn't we be advancing optind for the case where
that's consumed?  Not that it matters much if we don't have positional
arguments once the options begin, and if we did, then allowing
"--arg optional-thing" would be ambiguous...

-Crystal

