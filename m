Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972873FD12A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461475; cv=none; b=I6Iu98HR6WxOhrSDt1kB08wdNnKgJt0ymXDMMb5a2xxlyeg0oej6mbzPPAj6aLo/CU/ZqQXQvwV/Xv8Tap0NmD0ocp4avx+YQzGsgLOH6zGwhpC/8rkGq7N385p7R5bi26ohPZGS4CiGBgjO0ILeP/0eNtRm7aWUxfedxyHgsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461475; c=relaxed/simple;
	bh=Si65iSJNQ19/QjmtroK6yUr+kM4FSgD255NPYaeKILc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFBnHbD9UYmPin7juRaw4SwtUdKqYWxJ2ilaXUy9DrN0Ezins+4IaRIHS1qNlJqxvuYNxm02DUC6wsYZMRVSexB1+THcJsxy+1LvOIhZ15ZPSzXE5QAL3oU0M+tfJSdNT+pfzE5pt3Pr43ud1rPS1kQQYaQv9VKeZrMhRQNb5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjET0qTj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjET0qTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772461473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Si65iSJNQ19/QjmtroK6yUr+kM4FSgD255NPYaeKILc=;
	b=LjET0qTjDl5VsLi60IoxmiHmEhlpEBTQDakmVQGN7XO2hapdUbbQ9TJr3zuwUbSOm3gmn4
	uL/HSjmFeeqGarVSaQw/adKjj5uRjKuou7uOg9Q5loLTQKFFVF+Q0aNOnKN6kNmGQS24fX
	FmSemkTdr1TD4/shgQnF5jfVdeN3EFY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-AeD_JRQwPaiBXzoVOdDlTw-1; Mon, 02 Mar 2026 09:24:30 -0500
X-MC-Unique: AeD_JRQwPaiBXzoVOdDlTw-1
X-Mimecast-MFC-AGG-ID: AeD_JRQwPaiBXzoVOdDlTw_1772461469
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-65f75964cd2so6363467a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 06:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461469; x=1773066269;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQruE7WU4QBS3d73QAD/6P/J4+XNtGXD0BMgqs54uZk=;
        b=f8lfAtuGd2cjwBJko/Q0mVGwNOCkuarouuwzWIDZMNToBwRUSE8/nZ6m+b9XwNKMVd
         WP9uu3I5Rx7JJfL7WrW98LeD1XxJkU6kozE7f50gT/snKJXgogfUCeuJY2jvffvsM0aC
         /UR8Jvvp2/wwaXCEfmHm1KzOy0ukdJieXHakaobqzJ6iQLVHvYpGz5GTVaVwTrFhuaXQ
         NZ3aoQuURNxSz3WZGtJtUaszzm7vHnzPkiciscAF9+xqeAsMyHKbclPKT0HD6t8RUgN6
         lwToRdiuIOAlfsqcwp3KcD/QOYnyzvYgt3lWNBLitwQxq3mg8Y4SFQF/h7cI8SoUSrCP
         JInw==
X-Forwarded-Encrypted: i=1; AJvYcCXVatUmNrsKa1lfV1Bo7w6ww0rI16j0OT7+iwrCp9PV2QKlVrfU1Y+SSiSWHDqxHz57hnXEurg0ZkoQR17czQSZUGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5k+YPcyMplyld5kT8tFB1xdMJdJJTXYtqQxrSYLOEtRBkbZq
	yY2JaUV5mZoj12/h7whwt+fVNDj9EUALCsOmIy1XAJajsUE3CnDwQ3s9CLN0B6kul2tzWTEucVM
	78gpTAfMgxiV514nR30jpWMgcbxtl2GA5wR6xrtpFSsEFh0UydmtD6lURX6Ej8Ns30Qxei4tjbg
	==
X-Gm-Gg: ATEYQzzxrGJEmC+HZkoLzx+drxawvPpuK+Y46n4jcd5AL0vY8d3ur7b+pPNCJrOD6Ks
	HE8Vek2v51yLWOU57jTHS9eTro0bZGCku4OGAx6hr5ClnzxD6TmaSvfnsuG4WvnvS8rxArXgJi7
	fkPKfkogANx2oYKfch3xuoDqMt0DsexEWg7w6EqLa0XWmWjkZXLbGxa/O5CJijVTam6NXujWyPb
	gY2VdURddgymRQtcN4V+wwCR8gxiSYpUKD8mAbmxz6jB/zY5sYKty264dY7g0rGMDdI07MSOrgF
	ur8qvsjvgw+349JL8vc4ndsfGbtGaBOoNw/SnCLT8tQC2e/2Tuf+S79YDfXRijlCUA2EeL1wqjn
	oTpIYSPVRfMhkEbc/qiV0fmKbfwkl2K0CKcds3rXDbrAN56Ss88nOEFGVSreV/PsgRfs1rcvmUo
	u60oxPrJ20FgP/9mU=
X-Received: by 2002:a05:6402:354d:b0:658:bf9f:75be with SMTP id 4fb4d7f45d1cf-65fe2d730bbmr7219432a12.16.1772461469197;
        Mon, 02 Mar 2026 06:24:29 -0800 (PST)
X-Received: by 2002:a05:6402:354d:b0:658:bf9f:75be with SMTP id 4fb4d7f45d1cf-65fe2d730bbmr7219409a12.16.1772461468767;
        Mon, 02 Mar 2026 06:24:28 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fac07b7c2sm3427619a12.31.2026.03.02.06.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:24:28 -0800 (PST)
Message-ID: <567f7f5528643c3ee7e77cc49b7154edc424df72.camel@redhat.com>
Subject: Re: [PATCH v6 12/16] sched: Add deadline tracepoints
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra	 <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org, Phil
 Auld	 <pauld@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 02 Mar 2026 15:24:26 +0100
In-Reply-To: <aaWblsXCWP-L0WbB@jlelli-thinkpadt14gen4.remote.csb>
References: <20260225095122.80683-1-gmonaco@redhat.com>
	 <20260225095122.80683-13-gmonaco@redhat.com>
	 <aaWblsXCWP-L0WbB@jlelli-thinkpadt14gen4.remote.csb>
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
X-Mimecast-MFC-PROC-ID: 122rBGj5Z9_eTncAIFt_oIPenyxAqY4xqhYVrDpsJEM_1772461469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, 2026-03-02 at 15:15 +0100, Juri Lelli wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 4ca79ff58fca..b5bb2eb112bf 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -124,6 +124,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
> > =C2=A0EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
> > =C2=A0EXPORT_TRACEPOINT_SYMBOL_GPL(sched_enqueue_tp);
> > =C2=A0EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dequeue_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_start_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_stop_tp);
>=20
> Don't we need to export sched_dl_update_tp as well?

Right, we do.

>=20
> > =C2=A0DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > =C2=A0DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
>=20
> ...
>=20
> > @@ -1532,7 +1551,8 @@ static void update_curr_dl_se(struct rq *rq, stru=
ct
> > sched_dl_entity *dl_se, s64
> > =C2=A0
> > =C2=A0=09=09if (!is_leftmost(dl_se, &rq->dl))
> > =C2=A0=09=09=09resched_curr(rq);
> > -=09}
> > +=09} else
> > +=09=09trace_sched_dl_update_tp(dl_se, cpu_of(rq),
> > dl_get_type(dl_se, rq));
>=20
> This wants braces even if it's a single statement.

Alright, will fix.

Thanks,
Gabriele

