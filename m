Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE33218BA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098310; cv=none; b=rAK47vRtWQQHIU1ziQODSUk0b6huxVWnfRp7OM2RYc0RLk/JaL53YvTvq2owOQeoPjcpiwafxmzqn48NTOUj8HitTpPIPDbseP6zRoQ8oxguXP2yW6LFTGQdBetPUKjJtARsH/deWiBcq9uzx+3aEOh6U1aTT12Ug/Wax7Bx2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098310; c=relaxed/simple;
	bh=qcvEydXrNttKsUZoJZLCzLvIvmiya45/0amhD6TTrnk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4YrUz81mSnO24cljYLOAtut4T9pYltUpbMO+yhQ+67pYR8Fy1ghUF7P0cH1lR0on9Aa3AX7rc4Vs+6rwTaPtuLFSvWUqbTybR74JsyYMu79YPVndrk8Gb2yajs2A8OIrjIAPFiegVvmya1l4aEKSIaaiqeqUSa1jrAtw103vHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvULVzEM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvULVzEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784098306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qcvEydXrNttKsUZoJZLCzLvIvmiya45/0amhD6TTrnk=;
	b=CvULVzEMaF+zZgyL1DGEsHRPBnXwqhzGl2rLrB0Up4EE8pNGVccS1cNyfVRl3gtFA+Zu3n
	oXwEuH/CgNvsmp+9PpvScDF0W1jo4QEH/qaCDcajb52SWTElxbF3yfIbrdcoKCq31BzZKf
	xg3f33atpAzVe4AyrF4VUkFU/Dj2B7Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-Y46d_37dPvCotth-agdorQ-1; Wed, 15 Jul 2026 02:51:45 -0400
X-MC-Unique: Y46d_37dPvCotth-agdorQ-1
X-Mimecast-MFC-AGG-ID: Y46d_37dPvCotth-agdorQ_1784098304
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c162ff98c4fso414097066b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 23:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784098304; x=1784703104;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qcvEydXrNttKsUZoJZLCzLvIvmiya45/0amhD6TTrnk=;
        b=j39g1IYQICywtP8Mm9RJJ85dxgpz2Og4hvbezvtNBSLf0R8U7htYsyokBsw9ZKb3m2
         D/mJ46QgYyaUePahNsphHxjRMRssQB8PJZihT5UToqhIZOJYEW/rX/5blIhh2GJfltbs
         Utgj9kwqObz27saWD+Lgh/KSB2s4BnX5OGAOfRLKLpFXJSdOv2zQM2/LdFXfKo1MoSo6
         6bXx08ipW789Zb5KLGzE/pxv3rbBWUycs1Ln62ts7hBj1eWA6dqZJDkxBs61rtXqgYTh
         2dnVetUq7vSfHD/A19y3Mj9T7gusyIYzYQLR+TT+2oi0T/seAgv51byvOYQYjdAqC/Py
         KRAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9WF0fJcwi3SrUn4MXRTDM9zWEOjqctLZskbT3OKB+KBtNUs+I12H/nZ65Hx1euxd2Jr0x4v7oCUIeaAXgxm7cwno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRr94Fwk4A7Z+A7y2YOegFVL6mCc8EuuPNdoCLhFDx6yd0lZ/A
	Cd8A+7/K6gkPxejOVjWMw1UR/fFR2Mfx+/+nhETeQ5QQN8cgDeJv3KSIs4r0JYrLCjh9juVYTol
	1D/ne+FkFpICfeni2NTp9spVRYqJRBRPFCK9VLTA1j+VQW5K0T3YaDuKaaOk8S1385WdBUNv6rg
	==
X-Gm-Gg: AfdE7cnQ8jy2nOxVGK7C8mXvFeLhnj0xrhQqREA+/WPrObyy1V8MsoP8FbGhOx0RmiL
	87NHZYfwSEAoaI8rYvN62AhtUkU4VbQQWiF+pP1o+N8eA2+PyOdZGeJ47fm0tP4+gsn9l5oJO+d
	lrGZOyv2H9XzhtVlmyyvUA+hOzpsWeOysJCfyAcjvirwyGrffIGIIRN2ofKUsQwtduJjf2PVMOM
	enI7WU3u/6fdGUCHZFP9724yVxF/xNSeN33ciZMfDi3Z775hTlrLVTn4EIvPl35H+YRKqKV1Luy
	w+Ojtl7sJwEvwjy04hjbHOZhvFsRimH/eFlDTR9GRA5/yCuU8RvVh6i071xCe8cQG7TLY+3rB/J
	ahRatCsN5fSTLzotmLUDt9ZkD7XlpMSjYSsqtxqcJYrtn0jli+QJH2yUjGSXXexGrhRazjTBVVV
	69kgkl
X-Received: by 2002:a17:907:a4b:b0:c15:e6a4:c71 with SMTP id a640c23a62f3a-c1661671413mr359158966b.19.1784098303924;
        Tue, 14 Jul 2026 23:51:43 -0700 (PDT)
X-Received: by 2002:a17:907:a4b:b0:c15:e6a4:c71 with SMTP id a640c23a62f3a-c1661671413mr359157866b.19.1784098303589;
        Tue, 14 Jul 2026 23:51:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15fd50d411sm769502766b.37.2026.07.14.23.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:51:43 -0700 (PDT)
Message-ID: <cac78b0340121da7691ba8ffab8b7ed8350977a9.camel@redhat.com>
Subject: Re: [PATCH v3 4/5] sched: Add task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Masami Hiramatsu	
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,  Valentin Schneider	
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Date: Wed, 15 Jul 2026 08:51:41 +0200
In-Reply-To: <20260714121145.1e73c05e@gandalf.local.home>
References: <cover.1754900299.git.namcao@linutronix.de>
		<918fe0f29a94e49db05c4f63a8a210dda9b90925.1754900299.git.namcao@linutronix.de>
		<61d904e5dc673d398c20bc4359e0f9b16ef4fde4.camel@redhat.com>
	 <20260714121145.1e73c05e@gandalf.local.home>
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
X-Mimecast-MFC-PROC-ID: 8bsWZ9kYLulAu0Et3uZBVji9RX0kMFZr1vDbdUdC6g8_1784098304
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-07-14 at 12:11 -0400, Steven Rostedt wrote:
> On Wed, 13 Aug 2025 08:50:39 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>=20
> > On Mon, 2025-08-11 at 10:40 +0200, Nam Cao wrote:
> > > Add trace points into enqueue_task() and dequeue_task(). They are
> > > useful to implement RV monitor which validates RT scheduling.
> > >=20
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > ---=C2=A0=20
> >=20
> > Peter, Ingo, this patch adds new tracepoints in the scheduler do agree
> > with the change, can we get an Ack?
>=20
> Are we still waiting on an Ack for this?

Yes, but since I'm planning to rebase the patches requiring it on other cha=
nges
I held this back. I will likely send everything for the next development cy=
cle
after merging those new dependencies.

An Ack is surely welcome also now but not urgent.

Thanks,
Gabriele

>=20
> I see it in the archive of Patchwork:
>=20
> =C2=A0
> https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=3D98=
9907&state=3D%2A&archive=3Dboth
>=20
> -- Steve

