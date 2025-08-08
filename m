Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0B223DF5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638218; cv=none; b=K8QG5LdKodxzGw3zk04QRvdbyo38G7g9HhldwhCqtY2AdnTdUlaj4yvVHijLH9Lq3RgYVEgCvslLr6+5sVYfbBN7+FSx8hdAGR4BRSpdB5mYl/BH1j8mHG41ThWjl2FF3Ef9cN+hvXTzWID5/lNxiTo1M7OxxX3PYzRR13237/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638218; c=relaxed/simple;
	bh=EHywBHd1OxRIzOjuUYWD29M8banbtxBweMpbfCeimSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgCBg1Bt8QlzgHUw1hpY8jDoXYSnN8FBC9pJHN/az+YQ4WpUkYdqeTRsz8FRgB0nbSq6pvF52C7NL9MRcl5HD4d4yUx+AZu9NCiSiduhAdVuYtufoLjZ5rKo97OdfU1gMWEEYzuIxpJtZwLLuccInw2fLCd6HfQgF8DGcIwnrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=buRkCepJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buRkCepJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754638215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EHywBHd1OxRIzOjuUYWD29M8banbtxBweMpbfCeimSc=;
	b=buRkCepJhhdJWH1cFCracx8HOH1p+KWnjmtkUbfvk8h/sBWHDmy2AlCcHybSiuz8/LxgvE
	qIxTrFFB+RbR+ls4OOlZldBmRoDtAkn8aMH7nQ72asEo8Gv2owMmCtnkmkQzYeI1Yzh+NN
	XtkJrQBqeIoI431lcOE2bork3k+XnvA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-xI3BEGhlOVWHrL89j2VuZg-1; Fri, 08 Aug 2025 03:30:14 -0400
X-MC-Unique: xI3BEGhlOVWHrL89j2VuZg-1
X-Mimecast-MFC-AGG-ID: xI3BEGhlOVWHrL89j2VuZg_1754638214
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e6c4ae500bso207235885a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Aug 2025 00:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754638214; x=1755243014;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHywBHd1OxRIzOjuUYWD29M8banbtxBweMpbfCeimSc=;
        b=jRh8Z9XZ/f9yv1vzw4bSPexqSIDQVzAzFoGrLZ/R3TTKC3Hlt50ARnXK0s62ry38Xe
         Jm0xKu3MyI+0GXx/EXPox5Dsdv9kg1vkb1UdP+pwny1U8kcIj9HGEXZ4vJWAYhdF07R2
         49ZZFNdMIprHiIlkRKlvCVQDZcKCTKjlkNeExFZnzN0aY2bFW+Ii/dNc/u5J2VxzV1Qa
         FJ/VD4D2rLVZVOxGAxJa1JdPqfLGzkfjjgioEFFCn5kRbVuKoTsrbaKAn1a0o3UzkGqh
         c3sK2esy9AaACsUSD2xKxk4Fs27Vzq99+K5M4nQ+uWeeiXxq9RiUlooKfGHknnLmf8aq
         IpxA==
X-Forwarded-Encrypted: i=1; AJvYcCXhvPcCYaE5Z0J725zbaFCtHNOFHTX7O1D4q04aWinhjSb9mKj6feFK28zg5UhYC4Ho/75yX6La7NisaXEo/PqD+u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOW7TiLEVbEoSIUx8P52ypxkys0S4DXZbcNMVbAeUYO3zJvfF
	PC1KZHkQPjuLRZReUypHzlG6u7Q1kbVCFSzWw7rjZaGWXc98ysvfOh4wdZ3xc6ddRGCY8+Kojy8
	ES/DHnOrX7w/8l/Tg8NpGiocpgItynC0S2GTiFxxv8gq4FKneQamI8NsaWyHyQRADprWXDoIXnA
	==
X-Gm-Gg: ASbGncs0lY1ESAoAZziYWxGIHqbcHo697My4R1Bb5VElGhe72JsEU5wmWU0rxTVKfPm
	A9u0sWNFRDz/fmJURa3SLMpvB3K1tTLVcXnqHfBomRxQQyqP5oHTQGWKkmoJRh8EDQJm/Q49WtU
	l6Ra+K3323gglPJ21IzbNjSMenVIhm0+h8aImkcbhwjsH1EWzqeLHaCGrnPRMqHNnQA0RskJfZf
	c674uNgYG1IAxYvnkOhQT9J7TXAsmknk6HCwI3ZquVtxneIbdng5zypntTSxqyN87qzbIvBvA5O
	Cmlhi0eGGlZH2b4qWKMh8nSOL8YEmXWk1Tueb+z1GrMPHTygXVx7rShJNuDm4YlqaA==
X-Received: by 2002:a05:620a:880d:b0:7e6:7083:e2b3 with SMTP id af79cd13be357-7e82c63c8e2mr261237885a.9.1754638213844;
        Fri, 08 Aug 2025 00:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaEv0CLI3Nwa//Oy5W/et3N8C/QGGdQvh8aoP6RMedjZnqPNG2uAHc2P7KdnkPU1kElEOLcA==
X-Received: by 2002:a05:620a:880d:b0:7e6:7083:e2b3 with SMTP id af79cd13be357-7e82c63c8e2mr261235185a.9.1754638213434;
        Fri, 08 Aug 2025 00:30:13 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e698de2df7sm823957785a.80.2025.08.08.00.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:30:13 -0700 (PDT)
Message-ID: <c0ae826c9a3d828ac8ab2088495e671cd9384a86.camel@redhat.com>
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak	 <kprateek.nayak@amd.com>
Date: Fri, 08 Aug 2025 09:30:09 +0200
In-Reply-To: <87ikiypei8.fsf@yellow.woof>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
	 <ecd720a0b971658a915473f0f864668cd6e1ef1a.camel@redhat.com>
	 <87ikiypei8.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: mtCrCKDCOWShX3vT0B30Z_GIn3bP5ln8LuEurns2K3c_1754638214
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-08-08 at 07:29 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > The monitor shows a violation also in case of priority inversion
> > boosting, e.g.:
> >=20
> > =C2=A0stress-ng --prio-inv 2
>=20
> This looks like something that would trigger the fair deadline server
> or RT throttling. Can you please try disabling both of them:
>=20
> =C2=A0=C2=A0=C2=A0 echo 0 | tee /sys/kernel/debug/sched/fair_server/cpu*/=
runtime
> =C2=A0=C2=A0=C2=A0 sysctl -w kernel.sched_rt_runtime_us=3D-1
>=20
> and see if the problem persists?

My bad, that was the fair server's doing, ignore what I said.

>=20
> > It seems perfectly reasonable from the monitor description but it's
> > actually a behaviour meant to improve real time response.
> > Is the user seeing this type of violation supposed to make sure all
> > locks held by RT tasks are never shared by fair tasks? If that's
> > the case I'd mention it in the description.
>=20
> Boosted fair tasks are treated as RT tasks ;)
>=20
> > Also very rarely I see failures while cleaning up the monitor, not
> > sure exactly what caused it but I could reproduce it with something
> > like:
> >=20
> > =C2=A0 for i in $(seq 100); do timeout -s INT 2 rv mon rts -r printk;
> > done
> >=20
> > Running the monitor without stopping for the same amount of time
> > doesn't seem to show violations (until I terminate it).
>=20
> This one is strange, I cannot reproduce this issue. Did you run only
> that command, or did you have other things running as well?
>=20
> And does the problem still appears after disabling the fair deadline
> server and RT throttling?

Also here, I don't seem to reproduce it with both disabled..
Sorry for that, looks good for me then.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

