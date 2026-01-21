Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228042D5C74
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003956; cv=none; b=jFZp8IFVAaT7rlL0uwnLi4GjBw2N5tHaHmlaXq3CNtAUey8tx8wPAgjHq79/KGFrR13qABrfN7uCaEJFI1qeKErD9RGRLHSI31nsriB0tT+9XvL+1SKj5Fk8J6Sup9Pr3SdHNJNLItN6Sz8PeinK4Ui9tPqYCRqrdw8FwpM3qYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003956; c=relaxed/simple;
	bh=5VacMTYe6cp5/byRDguRcp4YLOf0wgJLoddNf3NdJOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUFe1eHAu34yAkgPrCveak4dZZqZmnzOXb6Fhfma1eUvEjE42CFnN+IOYrh6eJp4e31rra6XwMMvUv90t6kZIixgxv1XpuKXtzbZmEHB+NCETPIeHXGwQ/ECUCO5VuHxMJg8voJyKywkpQcZkTElFmYJ6u58HXAWkFRn86L1BkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IErEx/88; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IErEx/88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769003954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5VacMTYe6cp5/byRDguRcp4YLOf0wgJLoddNf3NdJOk=;
	b=IErEx/8869+1Vi5gr8aTw039z2Txceg7rTy5U7h0qNgccZDetFrI9cEBLFhrVAxpO5Syo6
	xUKYzDJPVRDbc2LQFoNfSXIbmSsNAU1+2tVQfjOiirsumd1O/rSqYP7MGhKPEJr71MYDT+
	rxH+7w8goqf8OLncqUlqtIfgwA726oE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-uTGfScpaO3Ch45I-Ozq0Ug-1; Wed, 21 Jan 2026 08:59:12 -0500
X-MC-Unique: uTGfScpaO3Ch45I-Ozq0Ug-1
X-Mimecast-MFC-AGG-ID: uTGfScpaO3Ch45I-Ozq0Ug_1769003952
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7cea4b3f15so832565366b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 05:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003952; x=1769608752;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VacMTYe6cp5/byRDguRcp4YLOf0wgJLoddNf3NdJOk=;
        b=Bf+wFvi9FtMp6WNTc/kHCMof+67LTVIajNwU/LntQgAiKoi0e6jfu8p4j/qM5T5A/E
         Dxe51y3tUVuJZYn7LKSBfAua1Tl/IjtFdVUXOZYOB4vOXkH9RcnCoNqilkhccoTCyCMe
         19HO53QG5LPxi0DgfWKWhS66+hygauq5Yng9TPqB0R/uvhnsAhJQN2Dd/oHH3iY2eZJC
         9oBRZs/TY6eTH2FUgZH7dL2Xa4uSuvumjuNPP7jF/52vNcyeeb2PbwZahXG5YYbsXNzk
         mVS07V+EIiyrV7Ip5DVJPLGhS2hxnFVBouSrtvWhEfB3X1g8HVCtmFv6+eOvRz6X9EUq
         oiUA==
X-Forwarded-Encrypted: i=1; AJvYcCUAcmvBjY7tPR2ID8iBvZ4RNXzrviCA4mIb4hVcwmzWKlEyzGTslww1/CZGw6GHeyLkmwYpr0dRe5/uAX0Y3GmifVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrHRtg2/6tO0FpXgOY1zK0NVgmTS2jS5PKR0m/hiJR0uAyeFV
	ysoDrEUGcOiGp9XxWNJcZ3I0axZgbxv8niiHXwuEFnwTTVNh1o9QJQuWGIKSJp4dQi/qSnMowla
	Jq5x0zB8vZNhOJpwsswcVRCR5YASak8x6GGXNQIcQvVkIngbsrlO5m222lt4/Fm0MEc2DFEMrVg
	==
X-Gm-Gg: AZuq6aIuk4Bg/o6qKIJoUEAnCPMXDr0MCup5ZlGE9w3F8HW2A+lNnYMYSG2ATmFOvQM
	7ab/zQBxc75cWkPnca+z38vDNrCmBiF/UGoY2rpF/V1Z82qovv3lWOYOnRdOBPtDPa4rSA6WznW
	9aNWWW1j1MSw6/WCn47YdEt0tumBasJabKbU6eR320Me3R4pkQjztmAHvVqKapM21zb/g4Kw79W
	MIKdrXQzrdIFgMpEtzGl726SqlOMyF1VBqbELssSObSUR0a2hhMMdp5L3ouDghdAMlPB9B5co2+
	vGMa6bmW5eoeX33TTxpqO04HGtKKDc1pcYukENs+PcWo3zq2++/Mtr835ebR43S1tWFTkn0+1pd
	PUxuWow6cFslVUy+ajSuvkSqUhkSDPY53N2WPamerdhAvEMedIjgN77+d99tpi8WU52C1/6gBoS
	hr+jdooqt+
X-Received: by 2002:a17:907:930a:b0:b80:3846:d46 with SMTP id a640c23a62f3a-b8792d5a7a8mr1728874866b.20.1769003951695;
        Wed, 21 Jan 2026 05:59:11 -0800 (PST)
X-Received: by 2002:a17:907:930a:b0:b80:3846:d46 with SMTP id a640c23a62f3a-b8792d5a7a8mr1728872666b.20.1769003951168;
        Wed, 21 Jan 2026 05:59:11 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795168b9bsm1592365666b.16.2026.01.21.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:59:10 -0800 (PST)
Message-ID: <69298b5dcfda02051c5c1fe995efc333f980664f.camel@redhat.com>
Subject: Re: [PATCH 19/26] rv/rvgen: add abstract method stubs to Container
 class
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Wed, 21 Jan 2026 14:59:09 +0100
In-Reply-To: <20260119205601.105821-20-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-20-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: EIX8Ho1wtzGPRRmr6vBafbvnucY9NHAt0IrnZz9oPnM_1769003952
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> The Container class extends RVGenerator but was missing implementations
> for several abstract methods decorated with @not_implemented in the base
> class. This could lead to NotImplementedError exceptions if code paths
> attempt to call these methods on Container instances.
>=20
> Add empty-string returning stub implementations for
> fill_tracepoint_handlers_skel,
> fill_tracepoint_attach_probe, fill_tracepoint_detach_helper, and
> fill_monitor_class_type. These empty returns are semantically correct
> since Container is a grouping mechanism for organizing monitors, not an
> actual monitor that generates tracepoint-specific C code.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---

Just like the previous patch, the NotImplementedError here highlights a wea=
kness
in the design we should improve instead of cover.
If all those fillers don't make sense for containers, we should instead mov=
e
them to Monitor and leave RVGenerator alone.

Thanks,
Gabriele

> =C2=A0tools/verification/rvgen/rvgen/container.py | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/tools/verification/rvgen/rvgen/container.py
> b/tools/verification/rvgen/rvgen/container.py
> index 51f188530b4dd..65df21dfd17b2 100644
> --- a/tools/verification/rvgen/rvgen/container.py
> +++ b/tools/verification/rvgen/rvgen/container.py
> @@ -30,3 +30,15 @@ class Container(generator.RVGenerator):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._kconfig_marker(), container_marker)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return result
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result + containe=
r_marker
> +
> +=C2=A0=C2=A0=C2=A0 def fill_tracepoint_handlers_skel(self) -> str:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ""
> +
> +=C2=A0=C2=A0=C2=A0 def fill_tracepoint_attach_probe(self) -> str:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ""
> +
> +=C2=A0=C2=A0=C2=A0 def fill_tracepoint_detach_helper(self) -> str:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ""
> +
> +=C2=A0=C2=A0=C2=A0 def fill_monitor_class_type(self) -> str:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ""

