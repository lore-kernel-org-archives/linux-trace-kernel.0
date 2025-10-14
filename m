Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0E2FE587
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453424; cv=none; b=NheVZ04DsFBgoiaSPOCM2ngqNoizAHbfVS5YVYL5cq6jqi1VaTGj9alF1lZob0Z1QL/XXL1ca2vKNxR2Q3yx1Xg52oXcwuDoNlLQGKb2jO2RkFQBoffsM7Tue+gjVRlnE6EtRUfhqRBRE2z4dkPM9uhkRTIfspnbX8bv/aHYaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453424; c=relaxed/simple;
	bh=fVcMhfwaRjdAcBAcAaGiUIuafT9v6J+i1zbK+jCrO9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hb1vzf3bbNn7L1ijDHmixzesns3Zwj2dBwjF7aQ3arHSJxc+Ea+KzrVcW0vXyGA4H8UOlWOSgg35ri7RgJffPMLQ1JF+RJGJ0JBeiKarAu4fSQG44WSWOmBL1iQ0R3BwjO9nVOlaCPjSmza4g/CfAUDDPvggZ4+6/u9TU2D9AD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLwzzgGj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLwzzgGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760453422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fVcMhfwaRjdAcBAcAaGiUIuafT9v6J+i1zbK+jCrO9E=;
	b=gLwzzgGj5Kz4MpuahYHA4RMwOVZ+UgNiQ+6OE/j/Nady4f90SVPRVw+Wo4AfMXSig4xC4+
	9WNXN9f7KjuYdOuYLy0Kx7w+eRgUBmgrjkAO44ekr4xISEka+XeE9k/lsjXgCSLylgxzn+
	Vkye7FWWQ3P68PjN4I1nt740B+3cMTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-yrRZVeq6Nj-UAYJ4Q-tVhg-1; Tue, 14 Oct 2025 10:50:21 -0400
X-MC-Unique: yrRZVeq6Nj-UAYJ4Q-tVhg-1
X-Mimecast-MFC-AGG-ID: yrRZVeq6Nj-UAYJ4Q-tVhg_1760453420
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3d43bbc7so32046345e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453420; x=1761058220;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVcMhfwaRjdAcBAcAaGiUIuafT9v6J+i1zbK+jCrO9E=;
        b=lTHE35IoTJDjlyMlh0y+k1g8BdgDk6rTqINSlISmKVH4NZuX+ElF31oCeCjOe1INdC
         +vsnWL0BEjVtN/iJ9JwdTWFAgwLWK20+EvQ8hSx15TjN7tyh10sMGQlY+Y1dp9Ey3ndZ
         RAx9A/NflNMufFzRUIoFBfFXEPjYuiStNgvWH60LMub8H1vVg6g5n/NJjunWh584xWAz
         Xak7Gg8a1FwIpsqPpl8/WxNvLLQwRqjiv6foY2eUwFKfmXe3qhrdUd+33/unl9/MKPNG
         wpvcPMo5VUNKZdZs9xpA6BOEYHtwzGM8sUh8esjsZtFrHsc7yoXVigxfu0F14KDxB05S
         KBvw==
X-Forwarded-Encrypted: i=1; AJvYcCWnQAE6IZlPnsStV4YOD0C2cPtXYRtKGesSFYNayl1swhxpSq95qoeckSwoubijbAcoLhf0x0NxIHf/+LQhy2HgjXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYy0/iNX3FqIPfhSk0Khe8yvNzCuZAnv5YYz5yTA3r8gsip4e
	29kN4rpgXBF+lk9mgOkxtO4Kt9dkuzwehaLxU0Sd/vxmMnyFLj2XKpBIQD4wYroAbPsziPUhvVE
	oQvUktk4+HAX6cvNiBffYHO54NLaA6Tkwr7CuuscntufbX2a+cL6EMstS77yJwECSWlG6oLvlww
	==
X-Gm-Gg: ASbGnctdg4bM4RsWMSK2oaHdvsAs+iW72pJOvGDgWP6NVQMfxYnHMxEq/nGeYxBxZN6
	I51bccftf9EU3P0b5IRGJCUoIh/4Qof7WG41uNw/zlJIzR+05JKVZx6R5MuS18iPQKECKWTNlR1
	s6uHaqWSgncbRHmAQUCuNhsE2+tbwBXKYdKVshbCzdTVRgG18+POoEnnohuhAFfdB/PengvVRkc
	nGATU+gORGMCTHPqd5qQQhusktrjYkFTW0aHkAj8QiPbp5keWpTFpia4qPlBvQlRQTrihn+dLVb
	+hweNd6X5ke+yh0XTHPeuSsMdJBbzcWsFvEV9cUynIICHgIu5LEinwudvPjFfPxWQI1N
X-Received: by 2002:a05:600c:1d11:b0:46e:3d50:360e with SMTP id 5b1f17b1804b1-46fa9aeff01mr183085595e9.18.1760453419707;
        Tue, 14 Oct 2025 07:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlq9Rm8u6vlO/er2whrOgRGrlMCaR+wVXWhesQuVdZWlwOKvWLJBdCOyRtJ2yhfX6qVIv0uQ==
X-Received: by 2002:a05:600c:1d11:b0:46e:3d50:360e with SMTP id 5b1f17b1804b1-46fa9aeff01mr183085345e9.18.1760453419304;
        Tue, 14 Oct 2025 07:50:19 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm24542899f8f.32.2025.10.14.07.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:50:18 -0700 (PDT)
Message-ID: <1014118845296ead20fc1f8ae64c4fa610d06bc0.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 16:50:18 +0200
In-Reply-To: <20251014160719-f5a075fa-7cdf-4367-8551-05cf7715a3e7@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
	 <87qzv6szku.fsf@yellow.woof>
	 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
	 <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
	 <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
	 <ef1503b097e6113cec24f2c20684635fe1337260.camel@redhat.com>
	 <20251014160719-f5a075fa-7cdf-4367-8551-05cf7715a3e7@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FjExwu0lL5siGaPDeCEz5abUJRFKxSZp8F1vDEeUFGo_1760453420
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-14 at 16:18 +0200, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Oct 14, 2025 at 03:45:39PM +0200, Gabriele Monaco wrote:
> > On Tue, 2025-10-14 at 14:51 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > I can't follow here. lockdep can indicate problems, but it should not
> > > introduce
> > > problems on its own. So preventing the usage together with lockdep wo=
uld
> > > be
> > > the
> > > proverbial head in the sand. If the tracepoints called by lockdep are=
 an
> > > issue
> > > then we would just not call into lockdep in the first place. lockdep
> > > triggering
> > > these tracepoints should not be an issue in practice. I don't see a
> > > bulletproof
> > > way to prevent a tracepoint handler from calling another tracepoint,
> > > except
> > > maybe extending lockdep to also track that.
> >=20
> > Forget about it, you're right. This leads to not using lockdep inside
> > reactors
> > in the first place. We could even have notrace versions of the lockdep =
calls
> > (I'm not sure lockdep itself needs them), but that's getting horrid.
>=20
> I still don't understand why the tracepoints called from lockdep are wors=
e
> then
> the ones called from the reactors themselves? Any solution should also ap=
ply
> to
> those. Especially as even the simplest printk reactor runs into the same
> issue.

They aren't in fact, so yes, we already had this problem without knowing ab=
out
it.

> > Leaving for a moment concurrency quirks aside, a monitor that is reacti=
ng
> > should be done for a while and can be marked as not monitoring before
> > reacting, instead of after.
> > Trace handlers triggered in the same tracepoints should, in principle, =
be
> > able to tell they are not supposed to run. This at least stands for DA
> > monitors, but the same idea could work on LTL as well.
> >=20
> > Of course this gets more complicated in practice, but perhaps suspendin=
g
> > monitors during reaction can be enough to allow these lockdep calls wit=
hout
> > risking infinite loops.
>=20
> What would it mean to suspend a monitor? In my opinion we shouldn't sacri=
fice
> the accuracy of the monitors or the reliability of the reactors while try=
ing
> to mitigate a theoretical problem.

I don't mean to really sacrifice accuracy, DA monitors are disabled after a
reaction. This comes from the assumption that the model becomes invalid, so
whatever comes after might be meaningless. Monitors restart as soon as we a=
re
sure we reached the initial state.
In this case, it already doesn't make sense to monitor events triggered by
reactors.

LTL is a bit more complex, so it might make sense to continue monitoring ju=
st
after a reaction, but I'm not sure how useful that is.

