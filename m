Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914AC23643E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654636; cv=none; b=aYC15ahFhCNb7qfm3QdWZkPx2gUwpK7yMBEn8p0w1XOurGaG65VORU+m1WHyBLAYGxQO8eWTAtmDA1h2XlkNPvbvpMIpUUcwPS5koMd1+UB6AzWrZhDGSUzrB9MI6QivDjbubpMCkvYtMI++JtvU78g7sg5tqzLMXUK9SXHyMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654636; c=relaxed/simple;
	bh=9LzaigoLl4b2p/ALb/kqMnj7SvMdKnIsLF2Wd7Z3hNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAXPLxoEYwW7oeBPuR2fmU3gVQHUiFGsJMA67BNdKZoZg5ZHXBOnqjPsfQu84fUbMcUue0FHB0RP9/AgSJvtABNNSCuOa6o0NoiTOQRg0lz+6svIZrPAZZpiqqRl9An8WyPlUm6qlV6sugInP/KSVoSH0f511hR72fnUelAAlug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNja/b0H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNja/b0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752654633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9LzaigoLl4b2p/ALb/kqMnj7SvMdKnIsLF2Wd7Z3hNc=;
	b=BNja/b0HbYX1gna8Oqys1Ns7/sEAkFn1VxZJoxpbcCYM38BPQPDbCUmgc7fr2I1DFfXEFZ
	2eQ5kMAVcDGvQma5XPIgA4zeZBNXJ0mYGnhxOL3EqeFIEF2l+eMoXeXYlrGP6IIR1Xtgqm
	uQc+WADJ+RIgjyC7y5xDiNXq7l86QNs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-vkR8aFFkOeeqfm6UXChJ2w-1; Wed, 16 Jul 2025 04:30:32 -0400
X-MC-Unique: vkR8aFFkOeeqfm6UXChJ2w-1
X-Mimecast-MFC-AGG-ID: vkR8aFFkOeeqfm6UXChJ2w_1752654631
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso24973265e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654631; x=1753259431;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LzaigoLl4b2p/ALb/kqMnj7SvMdKnIsLF2Wd7Z3hNc=;
        b=bg/BYHJFZzRWOKi0KQOsw5elyQSdmvYMtiXZyrBWplNblHo/IIFzjOV0oiICB4XVs5
         O+iPQ2PO8gN7BcUjCbt4lIqMdwXnfdSk0ejP2rMKRXSrLA9CIiInHLtcg9cVoA0XA+Yp
         l3Om/EK0OiZcbr2r7sxn2VpicT5kFT/kP5N0qJuubgz9ixeOmaT50K7PEZKPualbfzBk
         REVSf06d+AVCYwKWWj2ZU3aeasvcsjBmfJH/WSILjPzWvOIxw615sSj9x6dw2fAj1mX3
         BxeH265fRiJBmAoBhY0HitljlLOrY95E7RhDjn5U0FJG4wpccekbxaa9VAgkchmEKGS0
         DJGw==
X-Forwarded-Encrypted: i=1; AJvYcCWSQHpopwkAmdPMUpOifN+HXqOaxsq3tv3sErcSXqpoyhXDqwWfxXQwuqeW5Mt/kIQf5Uy+mPZRVlI9aEfNOMAK/ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QoIeobrtEWfwgX/owM7f48a0Yd+bGuKAJKUeqfHMZrEFdZvJ
	NH9UtcieMirDx8Q1h2wgMh5JlUMcLW+aRXfmxiFiF6lQuWaWZL6tCYJsf7jIDuuYKV0hlrsC5M6
	QgwKegzPCSK2MjlSIZBsgbmR/ToRqyNzdMZdIKR+H+2CtjCInmCx218Vu2JAgAVzUtsVXagNJLw
	==
X-Gm-Gg: ASbGncsinjjT9DKkWCZd31hOr/72oyIeWnsRdKzUZyVNw+OK9Cqboj3FwOGLdaXeszn
	di9QWktZhuqgBnOhxCd3OD/TwhqRxaVWXdmSLEUOl/osVkALKO88cDVe0F+YMj+fuCyosbp0CJ2
	l1HTJct68FNTBkbKEcrU3pK7XI4hnipziNqmteQxXLh/FtJsQr8AVJm3z720HdMn+25xMoPX2aK
	TtMIJFUq0uivRYleM4Rdq0huEnWHMVEBAvU9qjArjXF1iAKF6LD00J5vxGeD4Eu5GNfFMOQ5efR
	UsS46TFLPBH2t9BCPabDk69OiN//vHkS0SvCelcjjbwCHPTgprbRrZ3TirkqmMhFFA==
X-Received: by 2002:a05:600c:6745:b0:456:1514:5b04 with SMTP id 5b1f17b1804b1-4562e02c811mr16898265e9.21.1752654630731;
        Wed, 16 Jul 2025 01:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUIwx7H1nxEf1vHGpk4PDRMhHAle6zi/pzxcdnKbjne9zRXLYDRUQxx4T3mN/pgqucWdBIZw==
X-Received: by 2002:a05:600c:6745:b0:456:1514:5b04 with SMTP id 5b1f17b1804b1-4562e02c811mr16897925e9.21.1752654630361;
        Wed, 16 Jul 2025 01:30:30 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm13651125e9.23.2025.07.16.01.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:30:30 -0700 (PDT)
Message-ID: <41906b93f031015729d969f03987ca87f22c3cf0.camel@redhat.com>
Subject: Re: [PATCH v3 07/17] rv: Adjust monitor dependencies
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 10:30:28 +0200
In-Reply-To: <20250716081948.gpIAM97C@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-8-gmonaco@redhat.com>
	 <20250716081948.gpIAM97C@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: f2QRgyz5rxUNonEVlv3IgsIDnD2r1WhRkFhGS7STGz8_1752654631
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2025-07-16 at 10:19 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:24AM +0200, Gabriele Monaco wrote:
> > RV monitors relying on the preemptirqs tracepoints are set as
> > dependent
> > on PREEMPT_TRACER and IRQSOFF_TRACER. In fact, those configurations
> > do
> > enable the tracepoints but are not the minimal configurations
> > enabling
> > them, which are TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS (not
> > selectable
> > manually).
> >=20
> > Set TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS as dependencies for
> > monitors.
> >=20
> > Fixes: fbe6c09b7eb4 ("rv: Add scpd, snep and sncid per-cpu
> > monitors")
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> I still dislike this. TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS are not
> selectable manually, making it hard to enable the monitors. You would
> need
> to manually enable PREEMPT_TRACER and IRQSOFF_TRACER.
>=20

Right, they cannot but they are sufficient. For instance the debug
version of several distribution kernels has PROVE_LOCKING enabled but
not TRACE_PREEMPT_TOGGLE. Both of them set TRACE_IRQFLAGS, so the
monitor should be available on those builds.

> I prefer "select" instead.
>=20
> But well, if you insist on doing it this way. It is not broken, it is
> just
> inconvenient to configure.

We had an internal discussion and my approach seems still better from a
distro maintainer/reviewer perspective.
Anyway, let's agree to disagree :)

>=20
> Acked-by: Nam Cao <namcao@linutronix.de>

Thanks,
Gabriele

