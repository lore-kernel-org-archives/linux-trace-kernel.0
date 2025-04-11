Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA829344B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361684; cv=none; b=iTwoZDa/PIy+kNoqZLYMKTAiUAYkCuncyl0NSeTqV6EYJBAAvdLvB01RnYVsgQfRYNIopgkrIC+/PFwsf9awpy3ZyFP9zoub7bDWPpFk+1X/ncWw18r6oQUoaWiGE8VWdPhdI6AMAiJbX2E0yDonXIE1fKcOnd3Tx1jKBGblarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361684; c=relaxed/simple;
	bh=unJMaNy1cPu0jonr7kJjXTq6BmkyFkYiJiuqztzhH1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCuMJRnmrYUB3kaQWA2Kd+YewpDWTiAA5euUMWqunL4VB3YJgj9X71WTate1xPTucmisrDLnUsO+qXgZR1Tiy/+ahX4XP6R0cBMPCWV1K7LcVAW5TJjoAfHBEIy4x0OGnCZbzFMw4ClG6bntRJkTa2eHGS6W6/shwL5EJBSlnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8tLSpJ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8tLSpJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744361681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=unJMaNy1cPu0jonr7kJjXTq6BmkyFkYiJiuqztzhH1Q=;
	b=h8tLSpJ4aAgu26Ijb4FRJ5AlpjAYVSJ9FCDc4MAQilKGGCiogD3u19GKs+7X6cQ6iT7yQ5
	IuXn3jxsfGkcRyYXLepOo1HXNvuBrJU02SUpbRhZqt/u69tf2nrIlz6slLivlwuruGVMrt
	sP5mH7Ojv1Y7lHkJLxZseZii+XvKD0c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-MpgH_cJiOdieGRtRD2P9BQ-1; Fri, 11 Apr 2025 04:54:40 -0400
X-MC-Unique: MpgH_cJiOdieGRtRD2P9BQ-1
X-Mimecast-MFC-AGG-ID: MpgH_cJiOdieGRtRD2P9BQ_1744361679
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so15745015e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 01:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744361679; x=1744966479;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEk1279QwRzc7uUG0zLaPNPISbUS02DqA+kwAbF+xq8=;
        b=Fkbl7lvRM/cPez1sqgI8lpweiT2O9lxN8eUmRIUOd3BsGCue51Orf942xexoPsy+ay
         K+o8oZslEMtpd+qhVOfVWjmjsT4m41WFGdBEmLUEz3bBr4p5pz+XO9//ty6hxBducxew
         8kfdvPvxwgvcfVZqliw6tuJKzXkrp1+gNpW5RhFeHVHlP9KcQgNYk3tOWemxW8V1uaz5
         LiMJx7nnXcd63dh5wDuuYMC4XY5jY1uZ0ftz1cDZSX3AjEXejLDnw4ipybeZaY5zcEnO
         FI4ukN02zQaFViRXdCGC1G1sLIwRBDEVPlMFZ+/cykn02+UtgcjFs+MZOIzadpnOmq3+
         U5ig==
X-Forwarded-Encrypted: i=1; AJvYcCUOJf1iI2k0U4Fh65yznLZXM4ErVN0oE3hUhX5VW8Y4mEFiqeYYfSJrH0i1Q7imDAud2CjawpAo3VAQHkPg5XF6CTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylVCOn/9tssNPgvr2NCSMr46/CTEB7sHPNPtC4uh4rucUozH4x
	aJtNzNAOUdSLUJazD39z9x5JrmhOQvqx5FWalwH38zLVZ3Nf2E0Ci7UfAkxFYCHUf8NHi08FDoE
	9HXrPMTvPXC8/IH86R7jsvIg7JXLmIKpN9VqGW+JYrW9rvG+0q9bRYPA6nfPHl1c7Op8vRw==
X-Gm-Gg: ASbGnctnBrcUk5NYacWWpEhQvBl87oaVg2P32B0zYvpl5EKlWKJ9PknRP76WuFfB8Ya
	SBWdvHk2qZuaUD5ICvsM5aZvOmEcln9YWHlU9I6GUOmrYnPCVwYCF5IbkjDdg6nRJsrU7QhKx0O
	7A9E4lDkXadnj00RUaSnPn36VinbAGtRws++qZ15D6lRIcH7XxEqaTXbhSOvo/897gtmOwYrJl6
	lTjumx82gTa7rDms5BfEbyLJ8oTemDfzCVMMGlJ/Rc0WIqzxqkOMJXkn44ci57FkV/mP94J6iGK
	7Hv6DRNdnTOzXXYCHPNF3m8wwgwil10lTQmVbg==
X-Received: by 2002:a05:600c:a4b:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-43f3a9aa6c9mr13610735e9.22.1744361679064;
        Fri, 11 Apr 2025 01:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2cyMks8qOD992VBRAPRGFfHOnKsXUuTT/bpdJZD9OZqw4EWf4mUKHmqEFEEoNwjkrfPC9lw==
X-Received: by 2002:a05:600c:a4b:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-43f3a9aa6c9mr13610405e9.22.1744361678519;
        Fri, 11 Apr 2025 01:54:38 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23572b5bsm76585995e9.28.2025.04.11.01.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 01:54:38 -0700 (PDT)
Message-ID: <615e60dfd21c48d6300f46729a98ad4dc25a3cd1.camel@redhat.com>
Subject: Re: [PATCH v2 05/22] verification/dot2k: Make a separate
 dot2k_templates/Kconfig_container
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Fri, 11 Apr 2025 10:54:36 +0200
In-Reply-To: <45b0fd8fc129cab7bac784fc1eeab9826ee7e241.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <45b0fd8fc129cab7bac784fc1eeab9826ee7e241.1744355018.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4ffUfXl4f-r0jssR19urbONczwdpvtadDKmCwyQpyfs_1744361679
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> A generated container's Kconfig has an incorrect line:
>=20
> =C2=A0=C2=A0=C2=A0 select DA_MON_EVENTS_IMPLICIT
>=20
> This is due to container generation uses the same template Kconfig
> file as
> deterministic automaton monitor.
>=20
> Therefore, make a separate Kconfig template for container which has
> only
> the necessaries for container.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Alternatively, we could also modify the Python scripts. I tried both
> and
> this solution seems cleaner.
> ---
> =C2=A0tools/verification/dot2/dot2/dot2k.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A0tools/verification/dot2/dot2k_templates/Kconfig_container | 5 +++++
> =C2=A02 files changed, 7 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644
> tools/verification/dot2/dot2k_templates/Kconfig_container
>=20
> diff --git a/tools/verification/dot2/dot2/dot2k.py
> b/tools/verification/dot2/dot2/dot2k.py
> index 745d35a4a379..dd4b5528a4f2 100644
> --- a/tools/verification/dot2/dot2/dot2k.py
> +++ b/tools/verification/dot2/dot2/dot2k.py
> @@ -35,6 +35,7 @@ class dot2k(Dot2c):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.states =3D []
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.main_c =3D
> self.__read_file(self.monitor_templates_dir + "main_container.c")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.main_h =3D
> self.__read_file(self.monitor_templates_dir + "main_container.h")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.=
kconfig =3D
> self.__read_file(self.monitor_templates_dir + "Kconfig_container")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
super().__init__(file_path,
> extra_params.get("model_name"))
> =C2=A0
> @@ -44,7 +45,7 @@ class dot2k(Dot2c):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.monitor_type =3D MonitorType
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.main_c =3D
> self.__read_file(self.monitor_templates_dir + "main.c")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.trace_h =3D
> self.__read_file(self.monitor_templates_dir + "trace.h")
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.kconfig =3D self.__read_=
file(self.monitor_templates_dir +
> "Kconfig")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.=
kconfig =3D
> self.__read_file(self.monitor_templates_dir + "Kconfig")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.enum_suffix =3D "_%=
s" % self.name
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.description =3D ext=
ra_params.get("description",
> self.name) or "auto-generated"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.auto_patch =3D extr=
a_params.get("auto_patch")
> diff --git
> a/tools/verification/dot2/dot2k_templates/Kconfig_container
> b/tools/verification/dot2/dot2k_templates/Kconfig_container
> new file mode 100644
> index 000000000000..a606111949c2
> --- /dev/null
> +++ b/tools/verification/dot2/dot2k_templates/Kconfig_container
> @@ -0,0 +1,5 @@
> +config RV_MON_%%MODEL_NAME_UP%%
> +=09depends on RV
> +=09bool "%%MODEL_NAME%% monitor"
> +=09help
> +=09=C2=A0 %%DESCRIPTION%%

Good catch

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

