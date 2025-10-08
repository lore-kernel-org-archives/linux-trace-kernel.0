Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F1266584
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960559; cv=none; b=Rb0dqI9yH661Ft3XkloGYtmz7a6Z/kWHyHLKKTgNcEDaWCDO2EWnR/JufJ1WsBfEqS9rXJOxp51bVv+e7l+zyeRz5N8n8MJFWOLSNx63Ljacwel/v6IqXEtgOTh3AQGoHtGAyx/2l9K/vBcXI4YNcnsrgPULMUCbankXsgb20m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960559; c=relaxed/simple;
	bh=Rbto6BRK4mLJmqKxulBUQ1oDnZaa5BvKYSIYYck51t8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEIiEPm4xm+WAS4wSCk3avE4ktY74tpj+CEXGyixFo76WE0h+B7EYI9c86po/Y0enz3Ghjgt0k7swslVjT7JPdtt8vBST+s3URsy25yN9U4JSSKUTjXB4tcenvtmnEhrF5Uf8ACtWESTNZgzcRKvLYHMd3OQ5oqHN3CFLv1gV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PacS8OCW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PacS8OCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759960555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KR5OMrHjJj//dXDuew69pvJTmxiyouN9guJmDwy6g4=;
	b=PacS8OCW8c4P47bugrdKj2OBxEwhQuQ2ztewEgNAaTHxW47HsFNBXYyXnEgzS5wd4Iuc73
	BCOIypNOEw6sMrP135D2Q5K2ISkmSrIOUZqXPNYCPUl+bKRtBajzF/iDI2gNQW/3morCnp
	Aqqvl2u23xUMaeMSYFwmMJLPbZpF6cc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-Wbwx_dZFMY-P9ryPKO-4lA-1; Wed, 08 Oct 2025 17:55:54 -0400
X-MC-Unique: Wbwx_dZFMY-P9ryPKO-4lA-1
X-Mimecast-MFC-AGG-ID: Wbwx_dZFMY-P9ryPKO-4lA_1759960554
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88375756116so144583185a.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759960554; x=1760565354;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Fb6inNO4ZYHk+tKoE55ZAUExgHgw8lZ1Jb7JHUHIP8=;
        b=lKXeSmsf3RpFKoxvxBJP7dK4qfpB8W9h8ZRqiqQccWG4CqilyrfmahYAAWWE3nHIgY
         1JmzKvTJJXMEpwDo7Ah0E/l6RCu3e09QAYl2mUoaBMYwAVKQCnUUiWgrw5RoP6ZsZckv
         cfGzXKunkagzdC7zDhQrh0yrFY1J5Narm299WOXQMxd2oRlmEmk03IxRK6ItBCkq7v2d
         0mo8a6gPpfYDEiZ/8+eUOXPX2qXGJm1ECDaj8ULKnDmGnso0lkV6J5fFBNTIXbOdALp3
         bc7tF26RczjStU96Y7ZQG9xEPa2noDLNs95Va2z2QqHpcxvWWihjYMH/45sVZqRspYQE
         hrLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvlaLFeQtBVs6/icIHSO5wjQ0uEHxO/MbAuATEFTYpjJjrVIzJYUeNSWyS4M2pmCQJEXGfAGvRbZxW0+Uzm3vIQxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Wrzm5KAHlbq5TgXQhDC7haK+gBsHlDfo+fFLXhZelbWf9/zj
	lca+jwsUHUGQZSdD8w7d4Iv71ULxIkLRdgNCxm2A2wRV1u3qxT/KGGHHuAS+4W3tUD8wx3gAzq8
	V2rxuqB4FONKItavbnCEPreBla7EB0jOxFGb5OinWo6jGqySIq54tghGpzGWSJIiqOW8ro+wUQQ
	==
X-Gm-Gg: ASbGncsyyamDP8HFPmGLdclZXDRp7Xij0nNt+88rKblNmLfU0SuVhE+5m63RQogDO71
	ewCU2OxT66wU9g/8EcS0aUiO13rmN+QMVeQACIq/O2y3fGuQ53rIO387G5LciTRP5oekcx5fum9
	CJXc/fJ3GxWN5G8LuUlcPNuCpn0s+XMm7uBGdZVpQFoczqdX+UR2CI5z9vIw7aomziJ4kBmTK5D
	TTnOckv4mQptTnTC2S4ejpKcZgt4gjkZHOeR1TAov4KDepaBvxqy6laQkmodShSeOxC2oHMYcyb
	nV8T65QIcCO5mU+I6nfQL+YGVYK79pzpGMdfJS5ZIu1I090fpgWK3yZzWJt8MhxkrJ5+iS289xo
	ruA==
X-Received: by 2002:a05:620a:444d:b0:81b:dd0:5877 with SMTP id af79cd13be357-88351de74demr750710185a.15.1759960554152;
        Wed, 08 Oct 2025 14:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyXJIObkdvCZoIJoDQaDDons28azkjFba719CWRdD+uDKH5oAPdKHT7+yBu+QOkrA2yszOgQ==
X-Received: by 2002:a05:620a:444d:b0:81b:dd0:5877 with SMTP id af79cd13be357-88351de74demr750706985a.15.1759960553688;
        Wed, 08 Oct 2025 14:55:53 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a1ca2f1bsm74263685a.33.2025.10.08.14.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:55:53 -0700 (PDT)
Message-ID: <34afd8ffbb1c889e91fa536cf60369a697d86575.camel@redhat.com>
Subject: Re: [PATCH v1 1/5] tools/rtla: Add fatal() and replace error
 handling pattern
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, John Kacur
	 <jkacur@redhat.com>, Jan Stancek <jstancek@redhat.com>, Tiezhu Yang
	 <yangtiezhu@loongson.cn>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 08 Oct 2025 16:55:52 -0500
In-Reply-To: <20251008195905.333514-2-costa.shul@redhat.com>
References: <20251008195905.333514-1-costa.shul@redhat.com>
	 <20251008195905.333514-2-costa.shul@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OhACbV0nb75scQ8MNnm0ttBx0W0RJpxUT21o_ehBiXQ_1759960554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-10-08 at 22:59 +0300, Costa Shulyupin wrote:
> The code contains some technical debt in error handling,
> which complicates the consolidation of duplicated code.
>=20
> Introduce an fatal() function to replace the common pattern of
> err_msg() followed by exit(EXIT_FAILURE), reducing the length of an
> already long function.
>=20
> Further patches using fatal() follow.
>=20
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_hist.c  | 42 ++++++++--------------
>  tools/tracing/rtla/src/osnoise_top.c   | 42 ++++++++--------------
>  tools/tracing/rtla/src/timerlat_hist.c | 50 +++++++++-----------------
>  tools/tracing/rtla/src/timerlat_top.c  | 48 +++++++++----------------
>  tools/tracing/rtla/src/timerlat_u.c    | 12 +++----
>  tools/tracing/rtla/src/utils.c         | 14 ++++++++
>  tools/tracing/rtla/src/utils.h         |  1 +
>  7 files changed, 80 insertions(+), 129 deletions(-)
>=20
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/s=
rc/osnoise_hist.c
> index dffb6d0a98d7..43c323521f55 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -592,10 +592,8 @@ static struct common_params
>  =09=09=09break;
>  =09=09case 'e':
>  =09=09=09tevent =3D trace_event_alloc(optarg);
> -=09=09=09if (!tevent) {
> -=09=09=09=09err_msg("Error alloc trace event");
> -=09=09=09=09exit(EXIT_FAILURE);
> -=09=09=09}
> +=09=09=09if (!tevent)
> +=09=09=09=09fatal("Error alloc trace event");
> =20
>  =09=09=09if (params->common.events)
>  =09=09=09=09tevent->next =3D params->common.events;
> @@ -615,10 +613,8 @@ static struct common_params
>  =09=09case 'H':
>  =09=09=09params->common.hk_cpus =3D 1;
>  =09=09=09retval =3D parse_cpu_set(optarg, &params->common.hk_cpu_set);
> -=09=09=09if (retval) {
> -=09=09=09=09err_msg("Error parsing house keeping CPUs\n");
> -=09=09=09=09exit(EXIT_FAILURE);
> -=09=09=09}
> +=09=09=09if (retval)
> +=09=09=09=09fatal("Error parsing house keeping CPUs\n");

Looks like there was existing inconsistency with newlines... maybe have
fatal() include the newline automatically to simplify callers slightly?
We're not going to print a continuation if we're exiting.

Otherwise, for the whole series:
Reviewed-by: Crystal Wood <crwood@redhat.com>

-Crystal

