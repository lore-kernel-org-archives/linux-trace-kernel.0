Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993173176E4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632662; cv=none; b=MlsjIzCQzqHXP2vYyRpFZ4qy2GM0YjN8jVj+ryWBURohVCWHi7ix8nswtqsBy4Pl5S7kHjosj19qFUT/qQ39vAS8gFUW1wbx0Uv+r3D6iQyju4yrY+StnALJRvjjYVYZ9v6+yuaSAAQZNoBAbAbyCpWS2olxHwV/8W4qG5K30Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632662; c=relaxed/simple;
	bh=cYloBhpvurhtJuftD7mo7c+dIKZCjU4qg99tSf1La6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8/RD+QptjHjwsXA+cl+OQHv9u6YgYxJ87EYXLtnT3liN8BKHq9XG408Gl4GwTPDsPrdcTJvW0uabaxWJc37C6H8K1i2qCCn0afr/QX0z0LkR7AJ6hLQMgEhfAo2CFN8Htcas+W+ghvavs8qwrtDWTHtKga0Ketb17HsnuoZIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMDRqcqP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMDRqcqP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772632660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1W/srayQRvqMo/yxxutNDTdINw68flwZKgc3vV8bRQ=;
	b=VMDRqcqPwzjCHqx+R1OiVseZXv6E6pSkRZMEVIDsxaxPYcQ9CbIViQSdYEJHKKcPQVWocT
	FkpIBcvACTnNeIbTVZJwSS/ro5CxmnkuuNDoFXzS/vl9o5O1UqLizetJew9YrUTufYYoev
	+ExFgthoDqaKbE6eg1wSW+n+ApfjKUo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-k20Ws16AOamwTkD4_UorCQ-1; Wed, 04 Mar 2026 08:57:39 -0500
X-MC-Unique: k20Ws16AOamwTkD4_UorCQ-1
X-Mimecast-MFC-AGG-ID: k20Ws16AOamwTkD4_UorCQ_1772632659
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8f5bce308dso627363866b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 05:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772632658; x=1773237458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1W/srayQRvqMo/yxxutNDTdINw68flwZKgc3vV8bRQ=;
        b=izVdCfC2tvNNa98lz7Ktmpzt3tymlb4ALVZmZykRN1GkMyd/0zjHqkRqGHlVy5mXep
         diiLNtJiLKqhsyIoSqFeN49nHE6rG5adwoL+I7BxO0wjCD77HLC0JL4yxA7ZZXXGtisS
         RzCBCC69c1GNQMgeVxbSh7xgD+TQig+FBKNQU0COMijWGOFesluzcAxofuk9QE88/shB
         tADuR4NKPiFAG/AOLlmhYlgGp5E7XdBK8a8RqmjsdLOl51SyjUxWSs8YjPPAdOxpbcSu
         JKajbUi3sKTaQy48ceQtGdPVL4riSYmBoi5mzfgg/fm8nkhZOAA7m6o7AuuLAieVxsY+
         ElUg==
X-Forwarded-Encrypted: i=1; AJvYcCVlqYVD7UtqVcF4Vl4mKjoc0yz/9uD4RAuzsP7BrCYm+bfovGCteUNda7Q0ZxoZrcl5/s0NqpNT/3quRiPRmIB/I+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNujv3NsyPwcW8txt436FPso7qVsTZMym6WuZmgUrlfAOa+ld
	59FMh0vxd61elIjP+ILTTVoOYJ9LuBSiSFNuADbuno/MtPXpwkGxmyhJUJf3kump8jCK4YomgzL
	lq/DQ3xmgVpvj9FVy07N+UCG/UtX041ePW4B1KPoVSuthZzb2CHSzJ130mi/cwFrlogAR0lGgBH
	Zr905xV8bMynXKrSifqAFrY3cKKSrydNBI3pTIdPtUyPcK+EJ3CzzcFzxWURAvBg==
X-Gm-Gg: ATEYQzy/S1Xvdgv3jcoujwuhaYbEMPBfVex5/Kl9MOLE099hNqaLNLVyaAH/kriNjaM
	tzpNO2bNYHhRkaywMZywlPM33gcDyEa7mg0fcCeHbiS50Re58uv9kL3X9uZiLZK7wMDVjmp/ZeI
	huhBbGX/mVhaDnh42NBw9a8Q0EWZzxvwhM3jV/q9OavwvTduuaZ+7e8RT2YNmjALnwZjyfV2KH9
	LkPkQ==
X-Received: by 2002:a17:906:fe07:b0:b93:edc0:e2e8 with SMTP id a640c23a62f3a-b93f159439fmr145724166b.48.1772632658246;
        Wed, 04 Mar 2026 05:57:38 -0800 (PST)
X-Received: by 2002:a17:906:fe07:b0:b93:edc0:e2e8 with SMTP id
 a640c23a62f3a-b93f159439fmr145721766b.48.1772632657806; Wed, 04 Mar 2026
 05:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-13-wander@redhat.com>
In-Reply-To: <20260115163650.118910-13-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 14:57:26 +0100
X-Gm-Features: AaiRm51TaSP-CtGOs_BAIrz9wnpPv_k_RqmwkVJkfgloDvwaLNludi8u4LP6WhM
Message-ID: <CAP4=nvTZ-k0QGsr_oyGmsr+gy6vbjmKv6TDVnUzQw=Av8YkEUQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] rtla: Enforce exact match for time unit suffixes
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VCnoeb4UfrT-cAI3Ha6zDQLB1UBOfAqFlp_zPqO30RE_1772632659
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:28 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The parse_ns_duration() function currently uses prefix matching for
> detecting time units. This approach is problematic as it silently
> accepts malformed strings such as "100nsx" or "100us_invalid" by
> ignoring the trailing characters, leading to potential configuration
> errors.
>
> Switch to using strcmp() for suffix comparison to enforce exact matches.
> This ensures that the parser strictly validates the time unit and
> rejects any input containing invalid trailing characters, thereby
> improving the robustness of the configuration parsing.

This solution is incorrect. We need to be able to parse deadline
priority correctly, whose format includes two suffixes:

d:runtime[us|ms|s]:period[us|ms|s]
(see manpages)

and is parsed like this:

int parse_prio(char *arg, struct sched_attr *sched_param)
{
...
    switch (arg[0]) {
    case 'd':
    case 'D':
        /* d:runtime:period */
        if (strlen(arg) < 4)
            return -1;

        runtime =3D get_long_ns_after_colon(arg);
        if (runtime =3D=3D INVALID_VAL)
            return -1;

        period =3D get_long_ns_after_colon(&arg[2]);
        if (period =3D=3D INVALID_VAL)
            return -1;
...

Your commit breaks that:

$ rtla timerlat -P d:10ms:100ms
Invalid -P priority

Tomas

