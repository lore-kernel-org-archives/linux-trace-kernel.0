Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDF3BBA11
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896068; cv=none; b=bgrqPmkdsWhYDTIioLP9JZt4DKeGQ6y8ecROUzeVFimcTKw20VW0ZepSjZWMKCT1efJ1uYPiL5hEdnB6EWSzBcP5a5IF2fshy3ecTFtlOk+XdTCNpmhqB8+wgR2eimP6GPLcM3iH+BfK4zPS+upnKy7Ct+sGktexR3A2bpJD52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896068; c=relaxed/simple;
	bh=xTRa0o3xOsfjH2gIPBCSvZ2S1Pumgzmfp//GVvSXTIQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpTlJsoXJsBs0s6PJOljowv/N5oHDP2aco9AuLpslngzsDUEhpnx+4kfm6MzNK0E0rB0kSXJKmLYTuZJWyNuMPCC1yGU2a1QtAVAiBpHMeUn4nxnXdOo5jQrUbWjaT3YCdKQXkXYqWgXQGFxm6zE1vEaUFAER9KT2K8JsnZoIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=en22/rg1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="en22/rg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768896065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xTRa0o3xOsfjH2gIPBCSvZ2S1Pumgzmfp//GVvSXTIQ=;
	b=en22/rg1ky3Lo3E3Cw6AsuOia/lvkhQCqYGFqzKd271hE5QLa1nnfyEBLOZltVkLasmop+
	8y5Tu//MaZg4ex1SEN45OLPaHgZ3ooTiwGm1ogvhvanIjKeJtyRrDwsZ97D3Sq0ec9ZHv8
	4JYXPS7IRFdlHrlgRIeOZ+WdH/NFDS0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-QV_yDgsYPVmFXH6Tc-hbUw-1; Tue, 20 Jan 2026 03:01:04 -0500
X-MC-Unique: QV_yDgsYPVmFXH6Tc-hbUw-1
X-Mimecast-MFC-AGG-ID: QV_yDgsYPVmFXH6Tc-hbUw_1768896063
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801e2e3532so20055925e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 00:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768896063; x=1769500863;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTRa0o3xOsfjH2gIPBCSvZ2S1Pumgzmfp//GVvSXTIQ=;
        b=iVSyAx/pIplEGe/xa2GvHvQFBQIUF+AB2ShTz3L4j3Jw/K5vTpgh+fWJAMN2BhOy4J
         4yipxpFAhVHRs/MPGZn5UIAHFehG0pAkLoe7nCFBREqYh2ZgT+Cp6p1oguw1qHuZA5nd
         QIDnf6LuF2liqBuLPAkFRivbDE6Zl5lHFdnCUSyWfFP47TfyXPkSgwD8j0cNrBFwnOHs
         BNC1qYld3qo4HePiMShd2oHYng6sU/HWIpT+uiLZBaGUMvUgjinnHA6znF5SVGJWygNA
         9rnqVbGmmNfolR52knc9hXrRt6BiT7VSKftauf8TIkxJ3h2S9e8vPj5Yx/Lvj17CY1qn
         qCRw==
X-Forwarded-Encrypted: i=1; AJvYcCWL+vRAIEwBXdGgDqJA+rVuINjna8Kt8A/KIvkO+1tjUGOseKK0p7+IPucspDsKdm2RZHZC1Ww4pe+4j/uXWAMmH8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqdeqbX/6oPYYEKuW9O2ppXRbMaK0UqIflktHWum+vL80klV9q
	ECqynxZ8faybMGDCXIrhMkTnafLNASuFJvDyd43+rpWocWq4wFR0Mkc9mPYRYlvwlkOS7lpdIUs
	HLBCJuo3wlPBLYEovtAGbrS+6JNa12QuZFYPIi5VqXsaSMchYSAQMQKg9qE6EO3IpHAi8yLSqZw
	==
X-Gm-Gg: AY/fxX59QmqCFkWKAFLBusWnWQ5Rue+f+IesigLPjFwFQFcju+8hFfyVAmffPggzB95
	HkbMP2Ld4HOADMwypvMxuZaFFsVrqbWD9uSPSYAHVILNhLBqSYXgv2iZWHkb4s9Sbryrrk+tjr7
	63wIv2GnNCD/gQHDOt+A3hErV/WyGkGCCBewnzC88WFe/q7z6eylu1H+3b6BJP/YRLob4LSaevI
	mRkiayrqBUr5qRr8m2+MxHJQrt4nm/As7rQC/ByEoKphb9NhO9EtFblJffKH4YaYVb2ZdP90CMD
	jPIJf8W/iSWuOJsfLaI0jmTZvj2syrKHvJKFAoaeZefk/A0plEXQYdE4AG0otMhtjiX96IZOh3Q
	uyF06aVgJar2ae0DF1ZL3B7dNSxIwMnvBqNvjIvGVoDgSIsMLw0JXzDg1FpkgAZn8pnP9DtP3Rq
	QK85ZIr9eI
X-Received: by 2002:a05:600c:8b64:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-4801eac0f22mr163463285e9.14.1768896062835;
        Tue, 20 Jan 2026 00:01:02 -0800 (PST)
X-Received: by 2002:a05:600c:8b64:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-4801eac0f22mr163462915e9.14.1768896062437;
        Tue, 20 Jan 2026 00:01:02 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2672d6sm295520805e9.14.2026.01.20.00.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:01:02 -0800 (PST)
Message-ID: <63e032341807f9ece73937d5e20eee9e3162fb61.camel@redhat.com>
Subject: Re: [PATCH 14/26] rv/rvgen: remove redundant initial_state removal
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 09:01:01 +0100
In-Reply-To: <20260119205601.105821-15-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-15-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: t1SpqwfWCpyjOfgdFpBgy961lgmAVds1tO6lMlUAG7w_1768896063
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Remove an unnecessary and incorrect list removal operation in the
> automata state variable processing. The code attempted to remove
> initial_state from the states list, but this element was never
> added to the list in the first place. States with the __init_
> prefix are explicitly excluded from the states list during the
> parsing loop, with only the initial_state variable being set
> from them.

The initial state is not the state with __init_, but the state pointed to b=
y
that, the purpose of removing it after sorting and putting it back is for i=
t to
be the first (we may argue there are better ways to do that, but it works).

After this change, the initial state is duplicated..
I think we should just drop this.

Thanks,
Gabriele

>=20
> Calling remove() on an element that does not exist in a list
> raises a ValueError. This code would have failed during execution
> when processing any DOT file containing an initial state marker.
> The subsequent insert operation at index 0 correctly adds the
> initial_state to the beginning of the states list, making the
> removal operation both incorrect and redundant.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
> =C2=A0tools/verification/rvgen/rvgen/automata.py | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/automata.py
> b/tools/verification/rvgen/rvgen/automata.py
> index 7841a6e70bad2..b302af3e5133e 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -111,7 +111,6 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
cursor +=3D 1
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states =3D sorted(set(st=
ates))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states.remove(initial_state)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Insert the initial sta=
te at the beginning of the states
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states.insert(0, initial=
_state)

