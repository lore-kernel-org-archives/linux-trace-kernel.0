Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F81C54A9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674845; cv=none; b=unWb4eZInIX6wCWVQ4iaVdpuSLuCwemYayBJzAW/eKCGuPHl2+XnTw0Qqa68a/xtaMRk0x5G2py/MYGug65ejRhL4WRVsRxqJE1WIgu5GjcE3kDqA+izPVgddNihQBJNrUVZ20H0IFqiw+E6FlYkwK7/JLM10cbVMNVsY7koqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674845; c=relaxed/simple;
	bh=tB2hd0yWjPoO6MlhQbxYZc4V8AzKcbCfWKCdItp3044=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbM2XVCDGA8fM9n8YeLA2uNBnVTZy9TRQlFGc9F2gaFMibRX/6xELzMMfbK9LQr6EMNoodxVRlHg0Nh1+x1XyhprSx12QJzugLdqwG4/2/mQqfNgl99DhU8zfOUkkCPufJPR7iinL5L6n1Vb5yggkfDUFOGMvf0JxIV0Djr07iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/WKEvl6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/WKEvl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tB2hd0yWjPoO6MlhQbxYZc4V8AzKcbCfWKCdItp3044=;
	b=B/WKEvl6dlixv0+7Bl1L74gcb/qyuKnKfOi4MeyHO0uq7PJ4elRjuqAkZNfoMUw/OTgoiy
	I4w+pROZMv4HWYDooGPg8krdyPLEVL+Dn9AQ+uQUrLXTM7xO3mchLuuEGYOqI24zgrhg8d
	j/WaV+okorS/FTpozyLOz3eOzHOt/0w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-nAgD1FqBMRS85vETEj1trA-1; Wed, 16 Jul 2025 10:07:20 -0400
X-MC-Unique: nAgD1FqBMRS85vETEj1trA-1
X-Mimecast-MFC-AGG-ID: nAgD1FqBMRS85vETEj1trA_1752674839
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456106b7c4aso4565275e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674839; x=1753279639;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB2hd0yWjPoO6MlhQbxYZc4V8AzKcbCfWKCdItp3044=;
        b=i2de+pwqvTyQgtTegjp5HlLDohebmkmElUBOePjbfJvkztVCTr7tXJxJzQCXzzE5eA
         UMVbIRCE3VbjrSpDXrKUhIFSYPtFK2DmldGxrIaujTDFVOWuCNCPoAb0b6HhZf4jxsZQ
         nM8XFPtkLlMFkoik1S05SCeFWOjL3DXSXX4yG1ogsdJpx4WnjImVNkXTcOxGswAHjc0o
         NRJc9qBE5e72IJU04/UMkkJsokF/yoBcNmSJuKRbaTTw2vwXESff8X7cpGpQZ0aVBNWe
         M2Bb039ah8HIKBa+QOgFKRECoE55Wm+6YcPSuMyPsZisyBtEl/O8NIXK6iEw1R7LnypB
         ZdDA==
X-Forwarded-Encrypted: i=1; AJvYcCVb5RE5hEXufjkE7wfi66HBNefO9TX7w81AGzBk21shDNfimntySxPysYIqa9T6ybyXHna5wmdYKfWWrWeSquOwyng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1UG+7/boMqal+NgNQ1encU+0wUrBa6Qx19K5uxbs4M033VAuj
	CZI0bQQba2X0SWKWthwTizqBWULJUts6VpXIVATtfSdP+NSbzsURLgUVVB6Ad1IA8q+GbgdMbZE
	iWkcq0DJphOLk1Nd+x1d8qvytpHAzVuGZWz5ehm6NsMp+nmr1QmE/06fL5/OStpOPeN5aD8oEZw
	==
X-Gm-Gg: ASbGncujZs8pgpBuNXuZHndq26lsfBAsWDacKqd0dnV0lx7SmHVcLPK7j93X9p0qsso
	9ZEh/OA49suCyUHl5GcE/2q3/oT2GyiQ6FlXu+E4rlJQZu9eJfM+uNERcG+6/+KPXbl+FbdIABo
	SQcKsGdB0AaVPmUxhPmzE33OWZ0NU0fICv2OH/1ws2RWRi+qN4KxUNfstvmSq26GOYI4u+R1ejs
	WcH51zkWNK9CgLiaAh5uwL0n1ofErAcB1ijqJkIVkRkFF+Lxi1vsCMZqYefrHb7PMSbGI+AZLQa
	329b4dZ8kXi6IeKW+ZPN+rbeKtJ0Y0z5n8Mdl/gRGv5ZqjS+iXNk1rgu6GenZRgFAQ==
X-Received: by 2002:a05:6000:2b0c:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b609524369mr4320859f8f.12.1752674839396;
        Wed, 16 Jul 2025 07:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMGLnEBjMAuOVnncL9pST+yEzGrrXmlW5O5822Ksx735cKfIpDH13N4slQf+5+QbAygFGD/Q==
X-Received: by 2002:a05:6000:2b0c:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b609524369mr4320828f8f.12.1752674838921;
        Wed, 16 Jul 2025 07:07:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e83e1d6sm21934665e9.35.2025.07.16.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:07:18 -0700 (PDT)
Message-ID: <fe38ba0b9da0209bcc97c2f348f5a6b266991073.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 16:07:16 +0200
In-Reply-To: <20250716134513.GB905792@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-13-gmonaco@redhat.com>
	 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
	 <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
	 <20250716134513.GB905792@noisy.programming.kicks-ass.net>
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
X-Mimecast-MFC-PROC-ID: 8BqI8RZf7UfbIa6mfSQUKcdtj9ws79lWUt9yFt3c-l0_1752674839
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-16 at 15:45 +0200, Peter Zijlstra wrote:
>=20
> I'm not sure I understand the importance of IRQ state when describing
> task transitions.
>=20
> You know both:
>=20
> =C2=A0- schedule() invocations for any one task are in-order;
> =C2=A0- schedule() invocations for any one CPU are in-order.
>=20

It's to describe latencies, which is the original purpose of the
scheduler model: if the event supposed to wake up an RT task occurs
with interrupts disabled while scheduling, we'd need to wait for that
run to complete.
Now to be fair, it doesn't really matter whether that call to
__schedule switches or not, but always having a switch event simplifies
things while modelling.
I can rearrange models like sts (added in this series) not to expect
that.

Thanks,
Gabriele

