Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068129B793
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417199; cv=none; b=o4DR+JqrYU18wZV2wf3hXPHVt12QW4uMQgr+4hWaZozNLpu7le1ZO4HguPe2h4zIOBBWa69PqG+kmpvL9rJIc361dl3zTRq42n+omNc1Kse/N0tg/YQaPyNVSUGmx6O4hIJ4tVjzYgDOiC8+IzVhE+ePcCJQOFEoZRzK1yjTM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417199; c=relaxed/simple;
	bh=av2khwzhx/fd3uBcoxJxEX2OI6BShbA6HolwNz3gHpY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ag01KFOK2oOaNvPans5qI6ahtw5ZSgal1q8SvfZg7b/tNvfbsWCQuTIpw2cLKbPMPHwR/80Mcp00mf17v5Bx0UWIrK4qR3DWIsQR1NoLHBaBJn4DcZaA8j38xfZAjQgvGgR9+aZIvwxo2OBxJZpFlovEv3a3RAdX3XzP99mBF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ld/rD8md; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld/rD8md"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766417197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=av2khwzhx/fd3uBcoxJxEX2OI6BShbA6HolwNz3gHpY=;
	b=Ld/rD8mdMMWGeyerYK3OmYKwKQpqo2lOh53nnrb9Zh9ikmMaYqngMYhI09I+TLXBcFhzz4
	1/HfAI47mJDb+ZE9WOMngPLcknerzDv9Ny3zSI88e5TuQzsd0FNQUjWSJuNdfBFXyv/wgu
	1f/rwPUP5bAgMyqU4CycqffUqtBg5x8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-lIxVd720PSCHHMnE2Y47MQ-1; Mon, 22 Dec 2025 10:26:36 -0500
X-MC-Unique: lIxVd720PSCHHMnE2Y47MQ-1
X-Mimecast-MFC-AGG-ID: lIxVd720PSCHHMnE2Y47MQ_1766417195
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430ffc4dc83so4290699f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 07:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766417195; x=1767021995;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhK/BZ52bTZ5S9PsrmmSG9r64dXYBxuciN4xfBSZQtE=;
        b=QTdMLr+6VzOAfGshKwBshA+ZHBTeKCFjXetNP61mrm60jt0IBges2WJzslYPgcQ2Q/
         EiFC7rRANofsUSe+XNJ8xqKSObaOZEtqBulhoy/kiFraWgRkc5R+C9QyqK5rjbGTJPuD
         HIsx5p5+wVEXUulk071Rf8STXYVdpk97FrcABqeMsIuncUon3fY6qzXgCWsOG68lhpud
         XYptwpOAiSMBcB7W8HJL0GLnkrApwLUsABkNPbr0mwN1acBNRQyaOzaVF59qyE4DvsE6
         Hx0Ek4pYWj7NJs8/ieFbN2v/EBi+JK6mKwcS122HtyO811pA+TQHpQWI0Eii4P/6OCMZ
         DrJg==
X-Forwarded-Encrypted: i=1; AJvYcCUTPKDUo2k6YwKOcDxZulhNtOUqv2RgWTNnuZj2MvBSfHC6BMHHBFyhMCk/+7nWuQc6ZlGFDYKEQpG3ujGHtHfkgmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPA0tiQGSq3pWglPibeZQD34O0eseagelpKjLihDtPFfePxwO
	HeIaoCFH2g24vWXgBMyL756DN8qITsyerxVBdJ4QeQazYHS8ik3igkmeJ39N1V1ysqv4/oipbjv
	3XfsTzKjwR3MPUI4xi2bXcoDfQ1iEnYHjhkCj+B4OrBUIvj5czGGo529pzhMWLdZ7n6zoqdxsQw
	==
X-Gm-Gg: AY/fxX6C3b3/MJx7zA2/irc68LTn0Ow/hVOtZN0tb5AgEjvadMkJy5gEzOovPutdWBY
	FA2DOWrqGBI+iuri6gWUr/71AhOoY7XcU/1vpc5eW1ljsM60YHccY6RYa72iBYtXD3IPrZX89tr
	pguglGDwz1n9b9iDMmDGFRnlccFmrKxkHPvCvBSzogL1Tsa26ii01dbLS6AmfPW0DozgVN1Tf/l
	asXkLvqZg3eex/USA4BKSIwqwdgC6QI7KyaXLXf5JMsBOn3Nu+2/9XpkdliezRkchLqYQxaibbH
	FULJ/Jc6MlufqnMa6rfU+H4IpuT5oy4cLwIzNBybAIVqGr/ByJ/VBJFB1g0veHPYXnfNMqR5evk
	ZD7j6bEExt3jjGSIAETZQRxPxqUfoKNj+BwlavMd63lSGXNMhno4gpNjlGnt5fZGOE7g9kvq06v
	jxJ/XTKfAD
X-Received: by 2002:a05:6000:402a:b0:430:f41f:bd5d with SMTP id ffacd0b85a97d-4324e708e9amr10261558f8f.55.1766417194762;
        Mon, 22 Dec 2025 07:26:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ+D6GZElhtNNudeGmAYKy3oDoOMLYDdQ1cS5nvDLNddsAUKI1ehqKgzPYCClwlnDLNqZr0g==
X-Received: by 2002:a05:6000:402a:b0:430:f41f:bd5d with SMTP id ffacd0b85a97d-4324e708e9amr10261537f8f.55.1766417194349;
        Mon, 22 Dec 2025 07:26:34 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2278dsm22897649f8f.18.2025.12.22.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:26:34 -0800 (PST)
Message-ID: <0c3d6c2c2273eebcc207ce5010ed90ee80460bed.camel@redhat.com>
Subject: Re: [PATCH v3 02/13] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 22 Dec 2025 16:26:32 +0100
In-Reply-To: <87y0n0ib6k.fsf@yellow.woof>
References: <20251205131621.135513-1-gmonaco@redhat.com>
	 <20251205131621.135513-3-gmonaco@redhat.com> <87y0n0ib6k.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jMUpeUJ-vdTBnUZOLp4Vwm7mTcvCuGU6Bw83Rlv93X0_1766417195
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Thu, 2025-12-18 at 12:57 +0700, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum e=
nvs
> > env,
> > +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire, u64 time_ns)
> > +{
> > +=09u64 passed =3D ha_invariant_passed_ns(ha_mon, env, expire, time_ns)=
;
> > +
> > +=09ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
> > +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 nsecs_to_jiffies(expire - passed) + =
1,
> > time_ns);
>=20
> What is the +1 for? I guess to prevent it being rounded down to zero? If
> so, maybe we should do
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 nsecs_to_jiffies(expire - passed + TICK_NSEC - 1=
)
>=20
> instead.

Yeah that was the reason and your suggestion is actually cleaner.

Thanks,
Gabriele

>=20
> Anyway, no big deal:
> Reviewed-by: Nam Cao <namcao@linutronix.de>

