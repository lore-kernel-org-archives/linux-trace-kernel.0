Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBF392B95
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900037; cv=none; b=j0GObjuz+lqChWBQXkX4QyFJBpIrZkYKNQJ3zNlDp2DbQvRu1vQyVZFoZ//e4RQCAntmmD6JSV3R2fzIcwof61vWi8BHxNWQKmR5cTrdhLcAgZb3yqMD4JPmMgWE9koKUDcZ5t7onYFZBRMVonVkovigNKEtze2gT2I++7p6CKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900037; c=relaxed/simple;
	bh=oE5Nuk5dZdqc2wTwq+n3EtHlcxAmrXTIrEu9DdhxhhU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWc/lNMT/Hv3RXH0Zg163F4s/mJMRCowzMJJrRpDlUXY3prlkDOKQHzNxQI++J6iCtiJg7FZ786OyX+hNBXRuh1HuX5rdZRmlBZSvebSz3eIKK95VM6gg6v5rz/WiuUmpwA1k/T6q3EAaHuPmbuZDKyoy6KDQIEbkHsGddYN6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsyK3JWk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsyK3JWk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768900034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oE5Nuk5dZdqc2wTwq+n3EtHlcxAmrXTIrEu9DdhxhhU=;
	b=PsyK3JWk7ghrtqkvDYr2htVnyrIqm+BB07Pn15jFsMrT5MjpiUofpbscqAfvy7g+EyJ4UU
	uC+sL7KK1ss5CmyBcd3Rz8bMeTVn37AX3vfmMFxdIYNEK8F9ABOcijUocm/KT5Yti6qyjq
	AtaOCRQdcL2OS3zBMUzCzptZ1q4k9Tc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-hV1LAWxpMuGgcA5ypE0mLQ-1; Tue, 20 Jan 2026 04:07:13 -0500
X-MC-Unique: hV1LAWxpMuGgcA5ypE0mLQ-1
X-Mimecast-MFC-AGG-ID: hV1LAWxpMuGgcA5ypE0mLQ_1768900032
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47ee432070aso30109035e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 01:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900032; x=1769504832;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oE5Nuk5dZdqc2wTwq+n3EtHlcxAmrXTIrEu9DdhxhhU=;
        b=hsVaYD9mx5JroC+E0zh6YOXTPOV7u/fdi0Z/Kf2KNwgvxBtxuFFnH9PSdFw5+PZvnu
         YZ4jyj4Y+8M9UXZSMgwm0vP/E1r7PTc2Wkn6AfJ7P+Q3cPMOs4WRBpoHujdBC532DZL1
         mzFJWHiETqANSx59JtuG3WNdxhmgFeSrrj498MgTFqilFQEoPKFRlYt4nCW+NcJzQ8Kr
         0uCHiuK3vhUw/jT5SA9Fb9uF0J8ii4DkTkAq0gdKPicKqwbXklWuF+YrzYdDqMe8jxsO
         exqGq3msQrTXJiDEXzJBqNEv+N3jCapKz5rrH8PrrQQ7AiNtmMYR98YcMpCEdCyc0fNK
         4hRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/3Hxd7KuC5j61bhjPrEC96pWbW4klFrUoRfVR+QfGR1mAcGlhdSn1yOZB1mvCWI7p462UEM6TRvqreUCLkoPf1WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFjtPo5zem0mTyGDtUIhc1ONHSDy7VqXJbjnFE6TYnpnzbrLl
	GYseMpinPahsAjallVThCXWnfTe0Tbw5BgIUuOQe1R0AotiDOFh7e7GKlk4b/aAc/IxqdV63yNO
	SbEcWJG7MLVqBSNhMQLhEGleQnX9+BtUW9j6zHRXL6EI5L+aKtwWtSfPrYtL9IqXsKg4y4NGFyQ
	==
X-Gm-Gg: AY/fxX4mFcXVS9GXxiKundNlOe8VG1W3W1WW+fx27DaUD4dHZUrH/7LhssquI2gfmVW
	OViFBVHNbgRKZBZ+ZSOSUuH/Xb5ylFQHsmUnqo+DODr1PbTEMfNVdq7OSV91FVyZoSfusUivnyV
	hHAKoalvB0Fj69ota6ZemjlBaReNFKFJRK1T+wb6twaUHpFq3oZ0rX2ls5dMyH0p0qaetZkcLix
	tKNFPT9OGkVbja/cYsAtWS1GK+I144Wx4V3efu1tMSPcqu+FIKNQwv06xkROtujDIhXu8X5FAvh
	VLrcQrhnsme2GChf/Wq9k6m2P5bzcrqUSkbnZe1KKM33eyHQ3USLUbt8gCpV2JNYmvq7c/lVPbV
	sGvUzrnUOXEZ/tjLc2QjFfBqnMKSYVu8w7ONeFbp2Bx08l1NZkseTg8OmQHWa4yy11McONdiLTx
	szHzgIoKAw
X-Received: by 2002:a05:600c:4691:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4803b9d6ad6mr44169785e9.26.1768900032022;
        Tue, 20 Jan 2026 01:07:12 -0800 (PST)
X-Received: by 2002:a05:600c:4691:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4803b9d6ad6mr44169445e9.26.1768900031688;
        Tue, 20 Jan 2026 01:07:11 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071besm289368985e9.10.2026.01.20.01.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:07:11 -0800 (PST)
Message-ID: <6bbc5b118542b3c95bb9a46a49ce07337c34e6c0.camel@redhat.com>
Subject: Re: [PATCH 24/26] rv/rvgen: make monitor arguments required in rvgen
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 10:07:10 +0100
In-Reply-To: <20260119205601.105821-25-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-25-wander@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jxh555do1aet4wDwsz55kmiYsdAcxXRBAb6T3htj9iY_1768900032
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:46 -0300, Wander Lairson Costa wrote:
> Add required=3DTrue to the monitor subcommand arguments for class, spec,
> and monitor_type in rvgen. These arguments are essential for monitor
> generation and attempting to run without them would cause AttributeError
> exceptions later in the code when the script tries to access them.
>=20
> Making these arguments explicitly required provides clearer error
> messages to users at parse time rather than cryptic exceptions during
> execution. This improves the user experience by catching missing
> arguments early with helpful usage information.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Good catch, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/__main__.py | 7 ++++---
> =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/__main__.py
> b/tools/verification/rvgen/__main__.py
> index eeeccf81d4b90..f3e79b14c5d5d 100644
> --- a/tools/verification/rvgen/__main__.py
> +++ b/tools/verification/rvgen/__main__.py
> @@ -28,10 +28,11 @@ if __name__ =3D=3D '__main__':
> =C2=A0=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-n', "--model_name"=
, dest=3D"model_name")
> =C2=A0=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument("-p", "--parent", de=
st=3D"parent",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required=3DFalse, help=3D"Cre=
ate a monitor nested
> to parent")
> -=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-c', "--class", dest=3D"=
monitor_class",
> +=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-c', "--class", dest=3D"=
monitor_class",
> required=3DTrue,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help=3D"Monitor class, either=
 \"da\" or
> \"ltl\"")
> -=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-s', "--spec", dest=3D"s=
pec", help=3D"Monitor
> specification file")
> -=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-t', "--monitor_type", d=
est=3D"monitor_type",
> +=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-s', "--spec", dest=3D"s=
pec", required=3DTrue,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help=3D"Monitor specification file"=
)
> +=C2=A0=C2=A0=C2=A0 monitor_parser.add_argument('-t', "--monitor_type", d=
est=3D"monitor_type",
> required=3DTrue,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help=3Df"Available options: {=
',
> '.join(Monitor.monitor_types.keys())}")
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 container_parser =3D subparsers.add_parser("cont=
ainer")

