Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883C212B31
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504177; cv=none; b=iPm3dWKxkOLOYD3iBXfUWnP3N5jTtRp6BrHZ4rtmFvXPe3bpkS8x3hQkgcrUZuCEdjqN1s0wUGbB3oAfawFsJI/4bjDK6C/uol1shkAOpQO4zqUN6GVMgaHwXL5HUshyrvS5HcaaIy32wQQfW0OSbs4pUrbmLRjZOk6vY/ohq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504177; c=relaxed/simple;
	bh=BTDvtIT10/Y7dpj6Bwu/egzP7OKMQ3oLE5KC8jPsBrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vw3DhxDR/B4tFDA5lwrtSlc+7NiEIbzyRa7B6gkE0XkDsADLuhhk1wR+RbYZK3o46TeXwBA4S2mpa/jfsAEcFTek8Wy9i8KCskfUK90FmYg8SAHxPEllc4AI/gl4VFfiGBS3OUvM4s5KtGscVBXyx9XGFm499JXpP1X3Fu5HRwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmKpTFJZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmKpTFJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755504175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BTDvtIT10/Y7dpj6Bwu/egzP7OKMQ3oLE5KC8jPsBrs=;
	b=UmKpTFJZgVRbvB3GOQlsq08+4K9d+F4jRERJSGY/NYDEaCgNfL7wOM7UFjK/DlER9AEyfj
	uru4qI3v9Jav8z/L6uOtqUk4M8HmHPwSxzpLxJevdWxBJiSFziND90+OLHZIdrT5L0zOW5
	MuHu8ReIm0troJRnP2K6LyQZAcmNSjE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-cUAx9zNHOJKNKtQO-09UIg-1; Mon, 18 Aug 2025 04:02:53 -0400
X-MC-Unique: cUAx9zNHOJKNKtQO-09UIg-1
X-Mimecast-MFC-AGG-ID: cUAx9zNHOJKNKtQO-09UIg_1755504173
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9f5b078bso41333496d6.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504173; x=1756108973;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTDvtIT10/Y7dpj6Bwu/egzP7OKMQ3oLE5KC8jPsBrs=;
        b=qCCYl4KS0jeg0grV7/OOZcyBxUd588uI6qePx7+wxIMw5WiOrszMXcppLP7YlIsnbY
         5CtVLNtBZkaPd6pczi3oSkgAaFr3pFYNyMrV8LO4j2O6WnZtLlz6K62azESsD/yynCU0
         8k+HvnC0nWw0Qkgl4eewQFN/ZRXQNBuF1sIhj9Ssfqea1iENa1dyZH4NguCbQ7TGXDAH
         VrT0KEImcK18TUxqD51oWgX4InjOgXeCfDg57M1bqPUfGwmgT1icDogrxjoXD/Db5yKL
         aFEvETnJX64hXjtJNXJjblmf15L/PcgpGzJezqVsxAi5b763VlS4rn3lMFt+pdti22t+
         dbWA==
X-Forwarded-Encrypted: i=1; AJvYcCXD4zu5MZz1becTH/ENKQ1/ella1R3HCkg+fM/lkdhkjJevpXcJapRiC6w/dlgsCinwSn0ncMaBACX11tt/5hDS378=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfrAZCobkzB+1XRF9SMCVkfbaY5Ixi51cMo6iNdk0mpl4e9VmL
	41xkI+U9+6y/eDJbzPZIsE4Kcncge9RI02Ca744p+lNbNiaHoOpuGInoOIXTEJLoE526DakovHW
	wJL4rQHg+AEN7wdCIO6fNKZt2X82QPbkVac3Gpf2GrTf8pmHSCLu/TvZirTBRPNUVIUiuFXW1da
	+io0bKdsEl
X-Gm-Gg: ASbGncsh4LxajTa+FM/T01Q0gjn/wgpPjJRy7ioxpRS/tw91jGphmM15zAOg/ip+YV8
	Hzc2bO9mG5/oYQpoQn/8rhiCxRyQwd0k+TCxBUmcJ2pCcg31fldbDIg4XR/h8J+z4ACGCh2cLzk
	VGa11+/hWMFqIl9D608c2hOkiBTm6/RUv+YHuUxbrR0Z4/dkwQd8ZhJQU9GcvgCxpk3cFnAJ2OS
	wmIWfHndHS3V4+t+c7iKZYsbFZ1FC8MI14aNmZ+L4V+x4Y72HXoByEWXxp8OBQvIz3bIzdddnrR
	d62yz/9E6vh7WMRmtUJzG0HDctPNBWsV2shTmg8cStFrM0Wvy3shWmFw429x70LEyA==
X-Received: by 2002:a05:6214:21e2:b0:707:5e7e:20f with SMTP id 6a1803df08f44-70ba7a8e0c9mr127652406d6.5.1755504173088;
        Mon, 18 Aug 2025 01:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHbS9oN+bmVLXNWkCtLoe4KkJAUB/SBpAzOahmwwKpbcS5hEqU1zFKZK8VNdKmOFa0tdBVBA==
X-Received: by 2002:a05:6214:21e2:b0:707:5e7e:20f with SMTP id 6a1803df08f44-70ba7a8e0c9mr127652076d6.5.1755504172501;
        Mon, 18 Aug 2025 01:02:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba959f401sm48756146d6.69.2025.08.18.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:02:52 -0700 (PDT)
Message-ID: <93e01a77105007dff602ab9a2a9af5b4cff86522.camel@redhat.com>
Subject: Re: [PATCH] Documentation/rv: Fix minor typo in monitor_synthesis
 page
From: Gabriele Monaco <gmonaco@redhat.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Date: Mon, 18 Aug 2025 10:02:49 +0200
In-Reply-To: <20250810111249.93181-1-krishnagopi487@gmail.com>
References: <20250810111249.93181-1-krishnagopi487@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hi8XkJdfhtRonJQShJS3VxrygTm4i07Ta10fUkjycmY_1755504173
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-08-10 at 16:42 +0530, Gopi Krishna Menon wrote:
> Specifically, fix spelling of "practice"
>=20
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>

Thanks for finding this!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0Documentation/trace/rv/monitor_synthesis.rst | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/trace/rv/monitor_synthesis.rst
> b/Documentation/trace/rv/monitor_synthesis.rst
> index ac808a7554f5..3a7d7b2f6cb6 100644
> --- a/Documentation/trace/rv/monitor_synthesis.rst
> +++ b/Documentation/trace/rv/monitor_synthesis.rst
> @@ -181,7 +181,7 @@ which is the list of atomic propositions present
> in the LTL specification
> =C2=A0functions interacting with the Buchi automaton.
> =C2=A0
> =C2=A0While generating code, `rvgen` cannot understand the meaning of the
> atomic
> -propositions. Thus, that task is left for manual work. The
> recommended pratice
> +propositions. Thus, that task is left for manual work. The
> recommended practice
> =C2=A0is adding tracepoints to places where the atomic propositions
> change; and in the
> =C2=A0tracepoints' handlers: the Buchi automaton is executed using::
> =C2=A0

