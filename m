Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55C331A63
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115521; cv=none; b=ujT9mLbEHnlbz3FIkH8Hn6TGIhEIF/a9j4yuFIItenzwfSl8RHY3rqVF2wZaGPLLW/fUNhhmhjeLXq5W+6dMtjKfqRU5qnVkRyB5IYXnuOTal0/XqFghTkwZY7U/FTvHSv/cJw/P3BBWIg7Eg+ASw2gscBgT17/Jn1qPkzmN9aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115521; c=relaxed/simple;
	bh=Ux2HHQMFcVqJq8rKtBPzMrS7d1EVvrfUzXLKIPUIhOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfnHZRJYpnVBjgVIH48uW0DVbLl93e6XJaEHfjhg0ELg7i5tJ9pmXVY3A+EGmHvsqxDL75CRXaVOHseurCHNC6Yb83/TFJzv7Th4h3BPog/3lD/lLxbcHDBWGY+6yztUSrC9Bv0pPValWhDvChGgV7K7Ic3VczTzkWLPR/+3bZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlM+hTFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlM+hTFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784115512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ux2HHQMFcVqJq8rKtBPzMrS7d1EVvrfUzXLKIPUIhOs=;
	b=UlM+hTFiuR2p8WfSvLTmvGQnWabt+/kUPPL1gq5jEn0rFi0ONZ4R18FFhKJ33Lrs82wNAF
	sraHeqDjpC8okXqvYy9XDp6c81P9VGx3SwlLbpE4uT2DSPH85FlLhKTcVUfgDwJRlvi82D
	aimxwQHFfjuq9oxKET0T+pn8KunA97I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-lriEhgSgO6GjMKqDnJxRJw-1; Wed, 15 Jul 2026 07:38:31 -0400
X-MC-Unique: lriEhgSgO6GjMKqDnJxRJw-1
X-Mimecast-MFC-AGG-ID: lriEhgSgO6GjMKqDnJxRJw_1784115510
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c16711b9473so146384866b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 04:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784115510; x=1784720310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ux2HHQMFcVqJq8rKtBPzMrS7d1EVvrfUzXLKIPUIhOs=;
        b=C/PSVLSRBuRUMBrNRezOETplhGf5p/fO3k73hHvHunnT01pHqsZ8QWkYBBO5JUx7Rb
         Niu7CSffxNjo4ngblKPJVwWWIX7TkIQ3TOTI632QNmx9z04ON9Q8mk5B/80l+I+/MEf/
         0u6hK4vHCTriLXxKvUw0sEUwamvUBisxUUnz6b4a1Uft/oq+9ToUKKHy9pxFma2MQAJ3
         F4DaxSG4DIF283lZG0tNWbL/QYXf7BaZErut/bDXmZZS1aTdHVIy+bLW6JidWRSzluKJ
         j21UA5rt5mdfqQxdw4mg1vnn5cIsbhz6atn+fQAZbLFWSbcLO52GUu2kUw31bYomW0og
         d39w==
X-Forwarded-Encrypted: i=1; AHgh+Roal6oIjqpBiHsSRPukqjUVsbt4G2Bg31vtbz14dkvWTpGrvfHN6pbk82JkzY5kHjQPJkIP1OtT6wdgJYKA3uyL2pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0fCNl/tq1KzRN3drD2ToPYEgWzeTG3Y6KQoc5AlJrz8c6KcQ
	9G2eXDZgtBayVXYlzbJsaA8ar2Pm+cz42S+h9GhGkJRbIy25ICJntwplgzb0H8ZHG2Q3Inbw3Jm
	CHA7LZhJHN/fuIYnQbXOlTfVnXuG9kmyC4AB/NXOpa1ZKB7dwpgjBducyotIY3iWrawo9Cv62Fw
	==
X-Gm-Gg: AfdE7ck6l2zq1nndyWuMdVwl7oXj/lG+OY6T4aQj4RWtwfUm0AijOt/UMV9xRoJk3Ma
	e7gy3Km9i1D8DlRofN3ApPDqyquSFczlmpe9XcEmHqiy1+vncA3Lo0tIenvXNjL2JNM4FO+W8hR
	b+Fv9HEQIo/bqzVCn/MOW3nUcxgZ4eJqmeQ2npmU9ZTv0gHVdHvHOs+f9yU99dIl02CIr63Db/e
	GFoPdyhl9MLMUx1bnG5vJHLrVpJ0gLkMMc/im87NV0Q+MpZgL7hfgOQBmO91XYBAgw+8rKSdJhy
	5ieK0wYzdlEF/M4hijE+ULIf+SdnSAQRjOcMG653Jk0LhLFn6KnWedu5e4i1zE2lQUJbn+E4znw
	stY24lSFMT+FQqfKCi047ObO2NlwTSnP8xeTNXeg7kaFLOqyp+ZQmsPUkPdR/Gb7lDY1ivJmZzz
	mlHhQj
X-Received: by 2002:a17:907:7b9a:b0:c15:c2d0:ffc with SMTP id a640c23a62f3a-c161e90b539mr887415866b.8.1784115510356;
        Wed, 15 Jul 2026 04:38:30 -0700 (PDT)
X-Received: by 2002:a17:907:7b9a:b0:c15:c2d0:ffc with SMTP id a640c23a62f3a-c161e90b539mr887413966b.8.1784115509960;
        Wed, 15 Jul 2026 04:38:29 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16874515basm8418766b.53.2026.07.15.04.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:38:29 -0700 (PDT)
Message-ID: <46c2d4ec0c9328741ead1ad6b050e815dd22c082.camel@redhat.com>
Subject: Re: [PATCH v3 4/5] sched: Add task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Juri
 Lelli	 <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dietmar Eggemann	
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak	 <kprateek.nayak@amd.com>
Date: Wed, 15 Jul 2026 13:38:27 +0200
In-Reply-To: <87qzl4lc9g.fsf@yellow.woof>
References: <cover.1754900299.git.namcao@linutronix.de>
	 <918fe0f29a94e49db05c4f63a8a210dda9b90925.1754900299.git.namcao@linutronix.de>
	 <61d904e5dc673d398c20bc4359e0f9b16ef4fde4.camel@redhat.com>
	 <20260714121145.1e73c05e@gandalf.local.home>
	 <cac78b0340121da7691ba8ffab8b7ed8350977a9.camel@redhat.com>
	 <87qzl4lc9g.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: -uEMD6g54OhrcxlYgEOCS-ur5dcXS_PB4k-kplO8vpk_1784115510
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-15 at 13:31 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Yes, but since I'm planning to rebase the patches requiring it on other
> > changes
> > I held this back. I will likely send everything for the next developmen=
t
> > cycle
> > after merging those new dependencies.
> >=20
> > An Ack is surely welcome also now but not urgent.
>=20
> I forgot that this exists.
>=20
> Searching my mail box again, Peter had some comments, but in the v2
> thread and not this one.
>=20
> So let me revise and send v4.

Uh I just realised this was your version. I had one along with the dl monit=
ors.
I applied Peter's comments and also Prateek chipped in, if you're sending t=
he
per-CPU LTL series again, please use [1].

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20260310105627.332044-9-gmonaco@redhat.c=
om/

