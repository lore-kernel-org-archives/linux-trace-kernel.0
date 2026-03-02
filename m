Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC623FD13C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461391; cv=none; b=isD9poDkhbptfG1CGH1MscHHx7mxJ6bLwNs5JvdlIe1KlspmDVAjIBeUHFrQUj7edIksBHTLOlZfYQ7w8QSocNtoNSr0VXaOdEC+1ZqmoTtXYhdrVf2oOUwJiOFvAO2sewvNTdKoMYa/XRNF2Vbw/cu4hPWTbGeAUO+YIB7bELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461391; c=relaxed/simple;
	bh=QW9ypdWvYAykTWXHZVGjV3Z3yGnr8z5bcSPNh057HrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3K4ibaITyxK6+s1OrAxs93e81L+51T5fZeFifgLNHJRDw5vAirg8e/1W03udZkVgOrglLr1gm4RU/pm1zJ5J+xdGNwfwoffSPg+zwe39gHQJ6fobDXSi9iVDeDRifBTBBO//ZTUfHbaMLSJHbsRU+62yJfkRGT1V0bE+ELMoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlsEbztc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlsEbztc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772461389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QW9ypdWvYAykTWXHZVGjV3Z3yGnr8z5bcSPNh057HrA=;
	b=JlsEbztc9bDVoMXxIVQs6cwArhPZGA9ItQf4lnW8kbqX3BRJuOh1uoHq3byDe72dn8fg9B
	7veJrkx2fBlb4yJVgZ2+lzADl3uzLrDXd67Q4z/qcWlGniONYIIpQ/8Pf4+NS93gvaK55u
	dYspKeYo5bdrpUvl3OMGUm4W8vB/Nqs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-hf-cwRBUOzueGMlN1fZgIw-1; Mon, 02 Mar 2026 09:23:06 -0500
X-MC-Unique: hf-cwRBUOzueGMlN1fZgIw-1
X-Mimecast-MFC-AGG-ID: hf-cwRBUOzueGMlN1fZgIw_1772461385
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48379489438so42849385e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 06:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461385; x=1773066185;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QW9ypdWvYAykTWXHZVGjV3Z3yGnr8z5bcSPNh057HrA=;
        b=tBFLviXTT+xgdh1GCq5JAktOwvJbIW7mtco7vBpbDwH3WCXBqpEujDSGjdfAX9A2gO
         fgLT4ajKU8MKzvCvJEEelEqmKSLohUeujuZjOZEpIp8LGPYBy2njVedyxwQe6lZfJPW6
         XbAUNHSvWCpzDsq2STrlOhuFaSwcQpkPfS5Dh2YauTheDyZckCVuBr85OQZ7napShQh4
         rs3p/o3lXCMDNzfXkrEusSr48eNJ5j1RjdB4rccoHyO0l0qNuPkE+c9NL5pk/LQLfXiI
         7oTXVUmaCcBrnUtRmVB+BJLUhA8E6Yxgll+WoVNozXE0Ty2S5llkK8ScVjWtWYxzBZpv
         rwDg==
X-Forwarded-Encrypted: i=1; AJvYcCWa15qvmNdoG44eykgwGbepwpx7G2/Xlb0ppgFmGB/niz0eS/E9G/cXq0GsceKJo6g7CVFGnjkhZCA6c62VEmK/oF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNKr/dOEJT/RByi2yOeoIp0QKaNoDvqh6bJqoJ1ZNENWsNwWE
	w6sw9bQDybWxfMNb5jXEJ++dVfTvpvhMk+ydvvW7ykjgVC1VQZS/jg0+e3cFAjl3/rNgriUcP0G
	51nuQ3MA/kJovWdwsfAMP1iBhYRKlX6IrzTRTmg7zR6Sj1HoDfVYOH0izU/YjW7MAC2qCzGXzNA
	==
X-Gm-Gg: ATEYQzwwZUo26WX+wnEDXZWIxBUjD22GcLBWWLPiBuzUGju7Ud43iNzpsOEBXaCydgO
	jv9rRP7AdSmg6vM39H96bvKq8RH6H206zlGXeW3xGBdLm7gLfrUGUC1cEqmnxaiUpqWV1qiowma
	JDRphETQcTGGM/ZEs+VoBE1eW6ErzNh8Sp4fhFfGmVXuo4p8x3lFuJ6tpCiillky33nGBZVdWyN
	gzCRMIeRtg3r4QgC8/Dv9lH9kSz27571q2iB+PLSDANEFUl3ZMTpd9tW4rPOiVQRSzzGnvcP9to
	9YI/eSxRwJ1FU9HQIw+Sh/VDX+cqK+azoM+vFW6ZhvVNwss8/x/LlovqhCm2TZCztTbvCtlKkte
	snXEXKYEVdR5beMzcwaCZm5CtPW3qqmiwTeIqHMjmIHPOL53FvFe+3mPOSaK4AKBbXMOgBo3YZF
	M058MS88u3GtajCOY=
X-Received: by 2002:a05:600c:b86:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-483c9c196a5mr202664315e9.34.1772461384981;
        Mon, 02 Mar 2026 06:23:04 -0800 (PST)
X-Received: by 2002:a05:600c:b86:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-483c9c196a5mr202663525e9.34.1772461384505;
        Mon, 02 Mar 2026 06:23:04 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm664794975e9.0.2026.03.02.06.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:23:04 -0800 (PST)
Message-ID: <8e8010800fe403137c70a7627239243c0cbb0ada.camel@redhat.com>
Subject: Re: [PATCH v6 05/16] Documentation/rv: Add documentation about
 hybrid automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>, Jonathan
 Corbet	 <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  Tomas Glozar <tglozar@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 02 Mar 2026 15:23:02 +0100
In-Reply-To: <aaWXmBVIvTlVtiRp@jlelli-thinkpadt14gen4.remote.csb>
References: <20260225095122.80683-1-gmonaco@redhat.com>
	 <20260225095122.80683-6-gmonaco@redhat.com>
	 <aaWXmBVIvTlVtiRp@jlelli-thinkpadt14gen4.remote.csb>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mhl0jPd5CFnuF101GUO5jNmkwIDrN1l4b2Jmnlq5zk4_1772461385
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, 2026-03-02 at 14:58 +0100, Juri Lelli wrote:
> Considering the spec above, does the 'event' need to be 'enqueue'
> instead of 'sched_wakeup' (or the other way around)? Or maybe it's
> equivalent?

Good catch, in fact enqueue/dequeue don't work well for this model (the act=
ual
stall monitor uses wakeup), but for the sake of the, already simplified, ex=
ample
I should keep it consistent.

Thanks,
Gabriele

