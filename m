Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF7F41A51B
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Oct 2026 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924950; cv=none; b=kL9FptCPSz5WiJZ8oxtgWSmnvrYtzwuyJrptqt4cNfEwgKGMFOV7ZWagZYsJfceGji54XgRDGh4i2vkZpv2Non0uWr6buVVhP5Sxb36Fn/sfwwPrkDLvuAmFdGuS441VdT1glBXRq9mT0KLNclofxvUPEnBYinM+D7mFtOZKm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924950; c=relaxed/simple;
	bh=/nvbCGBY5PKoEyzJ8jEa/LFu254NWvw+9KPlYK+oxWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0mXYEc3n/xc5GBQrMCuPlAsrTghXVE4zbeMlAwQ+yOH0HZZ2IXRp91TKDl4H/MXOjGsoGS804W8s6aEEtQ6vvfJvjvcrBUdq4R14noppN4W+Tvmv3HaZpvTNm2k/dWvbNjl+l3XuUNSgH+uGKBHWRFt8PJ70PCrv5tJazwqDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KN/Z7hwp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KN/Z7hwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790924948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/nvbCGBY5PKoEyzJ8jEa/LFu254NWvw+9KPlYK+oxWk=;
	b=KN/Z7hwp2nhJdxksYyoAgrgM7bJPxpxbgCKyCSm63Tn/O0Z6NVl7/fbmmVtzusQXpiulSC
	GCojuX9OQ2SEi6lVvx74BmWOr+Vu8APjIZZP7iktOW1quxKkyvZ7EnvjMg9jprjVpNb4p4
	JMxZz9EH3xAgaBMC/8qefLiSeWSTaio=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-AlRW12GWOA2fckna-G6w0Q-1; Fri, 02 Oct 2026 03:09:04 -0400
X-MC-Unique: AlRW12GWOA2fckna-G6w0Q-1
X-Mimecast-MFC-AGG-ID: AlRW12GWOA2fckna-G6w0Q_1790924944
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4887f71b1baso6093194f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 Oct 2026 00:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924943; x=1791529743;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/nvbCGBY5PKoEyzJ8jEa/LFu254NWvw+9KPlYK+oxWk=;
        b=jpz93uNFqSeL+YaRqZ7YufcEA4rRzcpY97D1LHuiexLMT3UidSlgWiPK1YaUlr2STq
         jf7VvE/3UP6B5moaSxUpBtH0aul8yusPmMc16n0qlYuR+Cm73ugyUe2IdgnXpJW3XzC/
         INK74Mlgnh56WIgYI0+jGKVo1dKk1/kYTQNAcKsr4HJ8EiWWrQ6M08GAVmHFKEDVXLNP
         mIUkYVusJKD2Q//TMl9hqIXsnY9oyDoWKnT42LsQy43qptPrK7IPNwg2HjYXtn4cRUxd
         pmWFyK7NK/JISV/y1hmgCFK3RX2HYMlCNdcwqtEeHjmXOhah27MI+bzJsw91bVz5f4Ty
         2jqw==
X-Forwarded-Encrypted: i=1; AKwUvBxlgLDds6bBJ60AW94VGbgKvqG3zQqLAlbxLcyYK7ar17Bdnjzls1X9DhNe1xBCSvuVzgHqt0aCB6WJS/bVSjfxPgA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKW+e6d8JY2MHi8brK0Zqq/hWyoLkO1t6J5W227EN1gvLks34dV
	ZOivood2lmPnMTZXZRje8BuHPlnHVY313AjK3yvB2D4bY5gWZgOw1ZA8xv5rTLYlgjuJipinqAi
	H91rcikEYpnknTYV3ryhgxoGg2bCqYrJMxoUcLlPBfwWEFnlrlPJLIEr6XMST4OhcTRo8V2323w
	==
X-Gm-Gg: AYBFou1Jl8BC/qEonEQuABaPXABLxO4dzAzmSMzbw0G6iuckrIvo3fLYzCC+f3a+ZeY
	tGtkR8eMdA6nwNEqYtYmbCdo4IvlfCEaSRMmFSv5dxmDcXERz+4y27YEItljqewXjWjVG3k9Zrj
	Xw6ZxI3M5f+fGGDzbt02WJteosZQOA6u2f99sCQSDvX2mj7ZFdrR62wpG5T0+tHMAEiz+x+H3hI
	pgZG4hlzb8okpkKG4wkjTrKxIcF0/4FbPtsneGGvADqPOZNh8RaMgNHOacOW/dqbT3LIDG4JvXO
	ipTl/omB73bZllhbe2GLDc5Nx1W/zfJ7mN4nCOF7oIJoDIFoTMtGcQ5D4XYC60isNGwCLL0MV9i
	C7Xg6lqlmvByPlJSCYs5J6b6/wdA=
X-Received: by 2002:a05:6000:491d:b0:48b:123e:2f60 with SMTP id ffacd0b85a97d-48b127616c4mr3419649f8f.39.1790924943707;
        Fri, 02 Oct 2026 00:09:03 -0700 (PDT)
X-Received: by 2002:a05:6000:491d:b0:48b:123e:2f60 with SMTP id ffacd0b85a97d-48b127616c4mr3419612f8f.39.1790924943286;
        Fri, 02 Oct 2026 00:09:03 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38103856sm3849229f8f.25.2026.10.02.00.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:09:02 -0700 (PDT)
Message-ID: <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>
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
Date: Fri, 02 Oct 2026 09:09:01 +0200
In-Reply-To: <20261001154934.GT88198@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-2-gmonaco@redhat.com>
	 <20261001154934.GT88198@noisy.programming.kicks-ass.net>
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
X-Mimecast-MFC-PROC-ID: KRkd8GxiW3wqkJrFeucSTfB7QBK3dnTNAAYky0SNtRI_1790924944
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-01 at 17:49 +0200, Peter Zijlstra wrote:
> On Thu, Oct 01, 2026 at 05:20:28PM +0200, Gabriele Monaco wrote:
> > From: Nam Cao <namcao@linutronix.de>
> >=20
> > Add trace points into enqueue_task() and dequeue_task().
> >=20
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
>=20
> Obviously I don't remember anything at all. But also, you 'forgot' to
> send me the rest of the patches which might hold a clue. As is I'm
> clueless as to why we want this, since the Changelog also offers none.

Right..

This commit is part of [1], but borrowed from [2], which is actually more
interesting to understand why I need those tracepoints.

[2] contains 3 other RV deadline monitors, I should have at least CC'd you =
in
[3] and [4].. Essentially the enqueue and dequeue tracepoints are used to:

 * model the event from dl_server idle to ready (a new fair task is availab=
le)
 * understand when a task is moved to and from another scheduler runqueue

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20261001152042.124445-1-gmonaco@redhat.c=
om
[2] - https://lore.kernel.org/lkml/20260929124908.177676-1-gmonaco@redhat.c=
om
[3] - https://lore.kernel.org/lkml/20260929124908.177676-8-gmonaco@redhat.c=
om
[4] - https://lore.kernel.org/lkml/20260929124908.177676-9-gmonaco@redhat.c=
om

