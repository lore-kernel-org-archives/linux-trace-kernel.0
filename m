Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDC485CC1
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Oct 2026 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942155; cv=none; b=X91XsJ5YKSfjE2uoyIxhNszgZUax1nfJDCSs4KiZnvEHYX7HGfv0X6laqibAkSLh4BjjmU+NdBGy5U2uO1LWpqR/aildu7uIT2vpeduvmAswC0m9zf5tczOgkaPpmkptjCDNtjHGUzRlEThq8cQw1m9bPkLOGfYHi1WMBXtVUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942155; c=relaxed/simple;
	bh=pXKyCSM9FZhLXmXKCC5/hagyDn8EQ5lF9xqVMMSFVIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjHloYhHPD+6y4FFKpAzUFscbp7UlZ16JbjgvhJDybMzNOYzPS/4XcDCHr2w8kGdPRzSbfFZhAlu4OBDhUe4AGZSs+ybvNOnEECrIp4OxM1Cng4z5j000Oa5HhreuvtxMn2ZMGxIIf38sDOuQVph7lVPY/nJS/vF4v4D5dlwH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDEdslbd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDEdslbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790942152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pXKyCSM9FZhLXmXKCC5/hagyDn8EQ5lF9xqVMMSFVIc=;
	b=GDEdslbdqLTWxgeYrJx+CpbNg/hQhgxjfD/CdXdnSwPeJLFWTbZmmSe374XH1exFPbYFNG
	ttcrNRLxiBA/xwr6Otso42NtQsfWJhyL0fG62q6Cc9/gs0gbFfkHnjyKQoeG3HU67Q57AJ
	vwOFRxDjF+pVXlZdKjgv8AKcisa6PRU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-iUtomDDXOeq2DjHF8c1vgw-1; Fri, 02 Oct 2026 07:55:51 -0400
X-MC-Unique: iUtomDDXOeq2DjHF8c1vgw-1
X-Mimecast-MFC-AGG-ID: iUtomDDXOeq2DjHF8c1vgw_1790942150
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a0101292baso36409635e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 Oct 2026 04:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790942150; x=1791546950;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pXKyCSM9FZhLXmXKCC5/hagyDn8EQ5lF9xqVMMSFVIc=;
        b=G6j16LAkrLFnMwHJJosMWVVh4P72fFEqfIxleasz9+qskbiT9fRyIqK5PmIBfWlFLO
         6Sp89ZvtUyRO7SzitLkr8wnbX7iwRjOo3bn3sHkYHp/74xzfbMYN6UZchKvq4RpTL60B
         rA5o2Z9JVvQslg6SUReAfMrA1NvyYX8bEod9D8YVxx/CHBjUpJeLgRzXolyHb+QDJv+5
         Uj2yRbdLVKOKlObZrx7m1YAcUJqzcTlyAJfpXAtMUvaQASruWLI/bgzhQ2SJE2xIMrCo
         oQqTgGAj0tTGfCgJVGK9r/xGXlvJtjwLdKVuTVPIYgGnQ06ehzuqvJmuS7Q0J7yGCH+9
         Dgdg==
X-Forwarded-Encrypted: i=1; AKwUvBxvY+rbBeLJln+YpIH2/QJiMiLe+B4h6P66pbIlq+n0Q4M5jYxFuKbepInYMgsid0tbxFlxUiKGVJm5fmLdFY3x/00=@vger.kernel.org
X-Gm-Message-State: AFuF++mjJU4DT663ewt8bO6TwZD4uq1JJfv9SODqr4iTUprUl6mlDj3U
	kZKCm9FvStCSbv27wvFx8VrXQx7g4ZtzJaZcK1ozn2vsmIfW4S6rrlNk8Lb6x9CzLqzAXgyj8YJ
	dljcqPk3So4tMPByv8/sKDntr+oWARg1n1IeOV3aovIceMojm55bvlKZAXSQFdiRoC5NdGpPTxQ
	==
X-Gm-Gg: AYBFou1uxHNFg4K1WJaKOKfJAiTA/rU1c/MSeMdQQTlojcMJjahxoHI+2tqp50MbSrA
	G8AP6IG8M6jwcBLbF8tna2oihcdlONa8aPtPiGWpz4MfYur+IBsEFz8bf8c4xRST3Lb3gHBa9Pg
	5kniwN3XDckraRvOv09buLDln2+YkB383Exgy9pbCJGaWTDD0dYQ0iOsSZRFqHsWF5abQBwiwkp
	JA71oKFsXPFIvLrvH8VHlZIpzKyLMRk6OKCVose44draYKh4ItLi2dUkGQzxtndtReND2pf7YBZ
	xYdamY1T2rn45yx4RF1+qgZRvfgFz+aUs0Wla337Qq1aHJdIGurrghwjMuoCxHtG8XvvUi4dkv+
	Q9+A+VDL6VWfQkQrNslzV3X1YE2U=
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a02757999cmr45042645e9.16.1790942150046;
        Fri, 02 Oct 2026 04:55:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a02757999cmr45042315e9.16.1790942149646;
        Fri, 02 Oct 2026 04:55:49 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff2280csm44473765e9.4.2026.10.02.04.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:55:49 -0700 (PDT)
Message-ID: <56972260b9221128d7aaf5bb60f90611ec9d7235.camel@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Nam Cao	
 <namcao@linutronix.de>, K Prateek Nayak <kprateek.nayak@amd.com>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner	 <tobias.schaffner@siemens.com>, Viktor Malik
 <vmalik@redhat.com>
Date: Fri, 02 Oct 2026 13:55:48 +0200
In-Reply-To: <20261002102939.GB2823843@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-2-gmonaco@redhat.com>
	 <20261001154934.GT88198@noisy.programming.kicks-ass.net>
	 <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>
	 <20261002102939.GB2823843@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VQyejAGTnKIVm6L9Oy0FTxQq9U50pZ769YVcKnACao8_1790942150
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-10-02 at 12:29 +0200, Peter Zijlstra wrote:
> So mostly I flat out out ignore partial series. It means I have to go
> dig around to figure out the whole picture, and anything that requires
> extra effort goes on the 'later' pile, and you know where that lives.

Alright, I guess I'm going to have to fix my to_cmd script.

> Now, as to 3,4; I'm confused. If I search 'enqueue' I see there is a
> tracepoint attach thingy in the .c file, but I don't see the
> corresponding bits in the .dot file. And per my understanding the .c
> thing is an artifact of the .dot file.

Yes but only partially. There isn't always a 1-1 mapping with model events =
and
tracepoints.

Throttle uses handle_sched_enqueue() for one case of dl_defer_arm, represen=
ting
a fair task running not boosted, in the enqueue case, because it was runnin=
g
with another scheduler.
Boost uses handle_sched_dequeue() in a similar fashion to describe fair tas=
ks
that stop running on the fair runqueue (but may continue on another runqueu=
e).

In both cases I'm reusing an event that can be triggered from other tracepo=
ints
too, ideally to keep the model simpler.

Then it uses handle_sched_enqueue() for dl_server_resume[_throttled]. They =
are
both plain enqueues, in fact, so I could rename them to show what they are.

> Also, IMO it would be *much* preferred if the .rst file would not exist.
> Just have the graph-easy and the description as a comment in the .dot
> file. Then you have the whole thing in one *readable* place.

Well, you make a fair point, I like to have it appear in the html docs, but
obviously no one is going to build the docs to review a patch.
I may look into ways to get both birds with a stone.

Thanks,
Gabriele

