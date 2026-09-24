Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01C393DE6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234321; cv=none; b=KTNcHPscfY1w4RZDFKH8QY2RZICatMxodvcngtQxCX3bypLsxf/03fT+YuvkEVj+iG+tiWOd1sjVNNMjczXmaQRzRg23hLj+nes241NL6aU2s0uaYbcYlTr1S3B4pK1Vnulp7iNd1e113IH59GFDel45WOiw5RgxRIvJwG9CSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234321; c=relaxed/simple;
	bh=9aEmt/nSGcmCcSLZBr3cnYr++00USytg2iRrc6YT9lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYsSn1PHCpz5pqd5e7brZy8w3lFsG0ZnnJIttLF9SD9rvVW4WPrgjSGAI68CZPNcO/26ljxqUe74Xi29l+eqXw9hU6gpvlOqG4MNxx6kxcD5YohvHA2Kdj80dzvaGdYvXIH6jnKunIUB+6AGejqji0eUHcooUaCs82fEM4ygr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4QKIwyT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4QKIwyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790234313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9aEmt/nSGcmCcSLZBr3cnYr++00USytg2iRrc6YT9lw=;
	b=C4QKIwyThW9uxpBqpN7HtJKSvekBK6GRmi4sS4SkFZJ9gK1exdaQTY6tmX9k20S3fzf5CW
	vYU+riCAaJ5DVUNeq2J0WbPuiJC4ga8jQCot/g0mNRqlTCTVo2DdZ4e69Q5olx7yhZe38u
	5llaaFe3Pp5uYs5gceSy/E89BPyWG7I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-nySB0UjtMH69pb3MxgWAXg-1; Thu, 24 Sep 2026 03:18:30 -0400
X-MC-Unique: nySB0UjtMH69pb3MxgWAXg-1
X-Mimecast-MFC-AGG-ID: nySB0UjtMH69pb3MxgWAXg_1790234307
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870142fd5cso755292f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 00:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234307; x=1790839107;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O/BKFWAq09c/drTlywLMZ5/iT4zh8IsXGlRsLaDd0Bg=;
        b=xuPyR7oQbwkW6XxKFMj2fkJZpKppEkuyUFGI9GUhtO9mvFYO6zjnLMOIhBJIUNG+24
         +49cR7wT5DeO1qkQMz6SBg/lz5KNEX278gDZq1yd+69EuWywjyCfhwt3yDz/xyrWkxeY
         yiGLDtk3fTdK741qXwNgoSsydHP8p6DZ7dRpvdRsSm20yqylu+cxJStwiuT/YIxZabkF
         U4jtKKy/ABSGxLJn20sQoJsXD79tQrk8EwACRedW1yD+6D7cY6tw7CSQ1NN96m+6tyJo
         T051FYNGa3dWatmtTSsNWdqFoCy1QYIdiCGXtnITZYVThHTrXvbxnsdym49BFW+xDUCu
         hDcw==
X-Forwarded-Encrypted: i=1; AKwUvBxTdbxFX9MC+DqmuZEsGcoX/xJfL/F4mjNyArcwqg+HW6FecXnpljtWZWslZWmUHT53BZmiLPO9ROVYbvGQFhCzyJE=@vger.kernel.org
X-Gm-Message-State: AFuF++mASHhyUjPymct8saeBMYWAm7FGGR/Q8Hr5gFsTDQXbeOoqguq9
	nPj6zX+fT5zGdTyyD6MluPiIOrGWTVBpnsT2TIz2RzoPaw7H9V4wrWqPa9FPQfly4BSY3ygtqAz
	IyN+5SDlPx85eLzs19bFnkOm2t139JWk/Ra6/oOTyb1N845cMPePsVH+nlFkXcGPSRVGi+aht9A
	==
X-Gm-Gg: AYBFou3PoJubHsMuY/eqqeRlavHDf0aybSdLSrfjPbg/PJuy/SqnaDdwokzb+ry2XHX
	Uk4JalfFgMP/oorhc/jM40vgqytru1KoVqN2/k4e/UqI5AR+73owQJBUPwOLL/rid2k0+PzxPjo
	huVTi/EHoJZK2abJcJ0lfacmktLCVIQ4s/EvB/m4MEq0PBXyaTYGmMeP0EFSxynxrs4z4txurub
	JdV/kixktBUYx+oEVq3Q39clISRUybe94sqNybiBHWu59m1a6zl8ArX3zGDTHl+lI6x9LMJASP7
	J+RN4ACo/xAvRryMCWEOR+Ygfv7UdqZy5/92w4vOlXYNX+YdBq9SXlorvdBY/TQy6N5EVJTAitH
	FHtYqs7J70OEBDpM6ytXCVthA7Ct9XcLDCDRGBqw=
X-Received: by 2002:a5d:5849:0:b0:488:5535:415e with SMTP id ffacd0b85a97d-48871728c76mr2575381f8f.25.1790234306887;
        Thu, 24 Sep 2026 00:18:26 -0700 (PDT)
X-Received: by 2002:a5d:5849:0:b0:488:5535:415e with SMTP id ffacd0b85a97d-48871728c76mr2575344f8f.25.1790234306488;
        Thu, 24 Sep 2026 00:18:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684862a3sm11499823f8f.7.2026.09.24.00.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:18:26 -0700 (PDT)
Message-ID: <c8bf231a39b5303bb283b12648a9e23b5c4bd07e.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] rv: collect per-edge dwell time for per-cpu
 DA/HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, 	jan.kiszka@siemens.com
Date: Thu, 24 Sep 2026 09:18:24 +0200
In-Reply-To: <20260911123439.463052-4-tobias.schaffner@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
	 <20260911123439.463052-4-tobias.schaffner@siemens.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nj8w1ek-LxGWN1Z7DE-wPJCuSxGwJ3i0naE4BWifrXM_1790234307
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-09-11 at 14:34 +0200, Tobias Schaffner wrote:
> With the core facility in place, hook it into the DA/HA layer so that any
> per-CPU automaton monitor also reports how long it lingers in each state.
>=20
> Pack the automaton state and its entry timestamp into one word so the
> transition cmpxchg updates both atomically. This prevents nested events
> from attributing dwell time to the wrong edge and requires a native
> 64-bit cmpxchg.
>=20
> Account a transition as soon as its state change is committed. An HA
> constraint that rejects the transition can therefore reset the monitor
> without leaving an accounting window for nested events.
>=20
> Add a selftest that enables a per-CPU monitor, checks the stats file
> appears and is populated under load, and skips cleanly otherwise.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---

Sorry for taking that long, I could just have a quick look at your patches,=
 the
approach looks fine but I'm going to need more time to check them carefully=
,
likely after the LPC conference.

I'm not too fond of how you split into patches. What's the reason for split=
ting
1/3 and 2/3 ? It seems they both add the new functionality, one step at a t=
ime.

...
> +/* Edge statistics pack the state and its entry timestamp into one word.=
 */
> +#ifdef CONFIG_RV_EDGE_STAT
> +#define da_state_t=09unsigned long
> +#else
> +#define da_state_t=09unsigned int
> +#endif

Also try to define things in order, da_state_t is used in 2/3 but not defin=
ed
until 3/3. This doesn't break builds (the header is unused until 3/3) but i=
s
just harder to review.

I find it more natural to split it into 1 add new functionality, 2 wire it,=
 3
test it. What do you think?

Thanks,
Gabriele

