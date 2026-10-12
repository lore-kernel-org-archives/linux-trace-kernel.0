Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094C475354
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805639; cv=none; b=EQoGzC6pISh1okFuZuqGjUtYfyo5ulD0EdXUsR4icZqqe8T9hXTawfkIOqWBIGe1ofqU5AlXQjtNKwRJDINgSxRxMODZlEEP0Rj5ZbtVA3Sp+xKtzjzez3ZPq+e3wM9kpv6B/+8nUQCyLiLqO78e2fa+/8YtPmhlGlBCv5EDH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805639; c=relaxed/simple;
	bh=tTAuW5YXvrWgMERGBm9kuawMACX/4fAn9/TDnPNtVXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVNCRKNJwKfIIF5ywGnknTNZPQdZblqPMtNWGk/v0rO+YqRDl/TdyXbhbsMGiHIO8GLOwVWgwF3m2/BexoTn1J4suj8aw42NpNR6sT7AH+zCunOHQyJa06WuHXAzs69/YjhvFT3u++HyB2oQAhxO2tCOdBBWUjW8mfbQDLCpRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hd6rVcEt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hd6rVcEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791805635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tTAuW5YXvrWgMERGBm9kuawMACX/4fAn9/TDnPNtVXc=;
	b=hd6rVcEtaRUmu5RK8CPCAGYginbIJyeuKbzcYz7iaNqy0LoeIbzTKz+06qcYiupGxhB2Fq
	KjQ3Mva3tYPHG8oTwyr9hqIES2ZUZQJXejdEL2uPRnj2UQEnIXMdqyk0V37WoXXoa//pLx
	E91BEK1Y01L4d88v0miPrS9q7KuyRUQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-RiFvwb-hPeqpWr61g7WoZA-1; Mon, 12 Oct 2026 11:47:13 +0000
X-MC-Unique: RiFvwb-hPeqpWr61g7WoZA-1
X-Mimecast-MFC-AGG-ID: RiFvwb-hPeqpWr61g7WoZA_1791805633
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b028d93c5so1274125f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 04:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805632; x=1792410432;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tTAuW5YXvrWgMERGBm9kuawMACX/4fAn9/TDnPNtVXc=;
        b=dxikSc5KhI1NlAj33+CtNZDELEJchku9JcA7VjAHcQwgcuotaeHYLTODxJEkmom9ya
         HM+QmcR8YC6+8YkaB37bE7tDV4g1p0aITdc8w5o8qJ0gjAoHKFDbpR4DJ7qvw7ucidIe
         i6EnE3XE+PESScbIycJiEk0Tn4RX7BAxi5DNbVTvdSLkw0tZIpdkxCMX+7jsJBlJzvti
         /EpnvDfnmefcdiK7njziuV8x3dCrU0gDx4dtQ8IiEZSbJhNGC59ppScBwlEXuI04iUtN
         2rbdLRmzQWhDJ9sZ2KqETYvH7gqeJF5fyxSDVwN/sXinShYzxWqEhKc/oSt9I+bAR0V1
         t6IA==
X-Forwarded-Encrypted: i=1; AKwUvByYSAq9P05lhoacfgPDDofSJg5le8mjk/MjSvXMaF95FgkguD8rP/azy4idyAuD7spRMuODhIcrF2lUoi48XRCPKIk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZp1XJygxHAls8IqKpXrKPFKD1XQHpPzQ0ajOlauISnD5bnGBn
	EfFNFP+7ZPJx5XswgE9ZL3ObZgSawSdKKz59mPz4j0kSbB1PUbe/wcBNQv+XDl4yqlcoBuXoG8h
	2CWOGnp1d9oaVPcSwXdvRg3UNGbgIqQJDVDq6YOjUU7/SyF6uP5GWwiCMFeciTcbmhsZ/9PHrIQ
	==
X-Gm-Gg: AYBFou2bLPA/4sv5xOT1zQE38D8h0qN8qOqNq2F938naGu1aeaWzYnBzxSgF7p4OVh6
	P9FZ6F4fschE7oN1Suf+HQfG6RyUCvxuhTtjAy0DtfrH0aae4y+m4Bt9IN7vy0yMo3cfc1tA1D0
	cMIwnt+IH2fB+QBwrMjgqYjAsmpn6Ife8+wd18S7wdMfsbNWYiJ/WEYfu/u+PrjIi9CIhsJcWiK
	j7c9zJOkRaz5TRCGoyBj0jRslsoXWeUOOcYotvl87pwaP7XC0EBYEJf4E5HYUNl9cl4cJg7Ixyb
	EMfv4GmU5NvkrFs+WLhgtJdjQIXo5ctDUN1JVhQodpV/fOnKdrCPoPRM+gRkwFXtZMKP4FBeaQM
	G8jkZYLsyxZ3TIIyHe567Bx2WYsdY
X-Received: by 2002:a05:6000:2f82:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-48dba78459bmr21037788f8f.7.1791805632449;
        Mon, 12 Oct 2026 04:47:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2f82:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-48dba78459bmr21037732f8f.7.1791805632034;
        Mon, 12 Oct 2026 04:47:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abd57fsm18489239f8f.37.2026.10.12.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:47:11 -0700 (PDT)
Message-ID: <4759c9b0dacdf1f9c0cf47158895860dbd0ec401.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] rv: per-edge dwell-time statistics for per-cpu
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, 	jan.kiszka@siemens.com
Date: Mon, 12 Oct 2026 13:47:09 +0200
In-Reply-To: <20260911123439.463052-1-tobias.schaffner@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
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
X-Mimecast-MFC-PROC-ID: iKX4-4lRdyeEa0QqP90a2woB5RM6Z3LL4UXYOu393tE_1791805633
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-09-11 at 14:34 +0200, Tobias Schaffner wrote:
> Hi Steven, Gabriele,
>=20
> I am using the RV system for a downstream project called EVL (aka Xenomai=
4).
> It is a small co-kernel system, small enough that I can model the whole
> co-kernel with RV instead of just a fragment of it.
>=20
> The patches in this series add a per-monitor "stats" file that exposes ho=
w
> often an edge has been visited and the dwell time in the prior state for
> per-cpu monitors.
>=20
> This allows me to not only check if the model is correct but also to see =
if
> all paths are exercised by my stress tooling and to decompose the latency=
 of
> the co-kernel's wakeup path.
>=20
> I think that some of the upstream monitors like e.g. the sts monitor coul=
d
> also profit from this.

Hi Tobias,

there's been a conversation at LPC about completely migrating RV to BPF.
While we aren't sure of its feasibility yet, and it will take time, it's
something to keep in mind for new contributions.

First of all, would dropping RV in-kernel support negatively affect your cu=
rrent
workflow?

About this series, I believe we could implement the same using BPF maps wit=
hout
too much effort, then the rv userspace tool could display them nicely.

What do you think?

Thanks,
Gabriele

