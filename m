Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC209341051
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962387; cv=none; b=oULpUEKOxP6sODKCgk3PNL5npDs039F8ZVJ3dAgNYILmCUAM5MYePbYvOLL4jXq92uLu1wJHvkMW2CnqXD6nn9fgaI2r7bcwt35euCQMK/FwIYuG0dQ1z9FT5PzCnbTss0LVWDWf/4HEZNAHe64q1GxLQIsBKl4rsRJB4eI9I9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962387; c=relaxed/simple;
	bh=zB4Khd2aXHMvEa3b2ZlwEmnhYWZWycMfvFWM2EBC7dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOAoj2i39JY8OKLeCuMhoPPKxikOoG+1pmxcXPy5mv4TOO8DkT3AYYhIhT7k1pC/zxXaWocmDKxSEhm1tUz44Xdk+GFZmokxShKxflXjjhRjt0/vHs6kyAW8nviFzwPeup0NugYGBEPQPuRu3CB/UbACdcFoSc4RiVFqazIjXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HslsqgPc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HslsqgPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765962384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNo3PeGOIc795Xgqks3aWmTd7gntV8jB3/Ue+Ch92/8=;
	b=HslsqgPcJijk4cFVQAOcY6dRcFLBOHMe/tuV+AycxufjjSOrk7o95PKjwwkClTPxG9eCOO
	Q8bkZVV/DklG1g0QFVSbQzpZjueD1NydZeXQn2esun+l1bsipaqnYcdXyF4eg/xrI2NIp/
	Efk3OAVwLriuB6t8LP6IysVpCrbhAo4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-bg99VvgjM9y2gOexuctZmA-1; Wed, 17 Dec 2025 04:06:20 -0500
X-MC-Unique: bg99VvgjM9y2gOexuctZmA-1
X-Mimecast-MFC-AGG-ID: bg99VvgjM9y2gOexuctZmA_1765962380
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7d282ac8aaso497086366b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 01:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765962379; x=1766567179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNo3PeGOIc795Xgqks3aWmTd7gntV8jB3/Ue+Ch92/8=;
        b=Zd0imL1AF1t9iW+R00BknZ70ORdScg4uXC8ryWW+VqUM4pwOEfo3eMN/FlM5X3UCCl
         psLnPyzrXAtHlH9gGlsDpXC/cthKxGRiixFUKhvLs252v+2U0UklypCG3jS/odzQ9F9L
         7WoUXlwis+Q5Nms3bqsv2uLeCHZq+mtkmsCk7xUpGtaVN+R3PehcKyJVfR5iYqSnZB06
         Ls/UiGs1o1XyXdiXjgzcNT7jERDOjbsaQgYCh4OM+35WLID4YuWpy3AGqxXgOO0AKF0g
         yPgIaGbInlvm7ZUN+rIjY4Q7XE26x49T1/rXe/uKYxw3w/LOSRr8qCBiHxTA7rrDR6Cg
         9YxA==
X-Forwarded-Encrypted: i=1; AJvYcCVUnHeYJVxIIqim9zu/DRhZxwx592o2t/RSRdYqFr4P+ud1H/pwhsg7pxABR0BUCEx3yUaqTg42hPDx3RYRAHEHJnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKR1XI5ddA3k51JAeujXvkNe++bupDWvFes/CWitEtHEOglho
	htCGwYD49ITdG+EvVnbqtHF0ZWIc/o15zGvRslFpvYXDI6jH5RvAocr/ZoflbRsAPuNK5eeilj+
	nXVkI/CyiSdQ0ycZrACSiX+nNaNID1OQAaaK1QrJfpwXt86LjeGmiv1Pa5YBYBomvSpXjINvcMD
	hdZaZTvJSupwAn9SnH4GhUSVkydyvc/bi6BbFXRKNeetf55Hyz
X-Gm-Gg: AY/fxX6OCgn3YRfK+adwATSd/oP009Eqip3xYV2T+txBPdY2AbBfjeLX24VZVtkQ0ru
	PXrZOQF6RT892ceJNt984wIllmPSkBXvCHoPGdIHnIJRVkY7alVQ0wtsN7f/WtsPEUL4hCbwZbB
	tRFrr23ZvP/Rn4VsnEyAbbjpwaSEZG395LjUfXX68qloD9WJmIshYwAM1biw9bjHbHhVL1ZRG8H
	WmSLiz9++WiNnOCD/EOcCPR
X-Received: by 2002:a17:907:3da9:b0:b73:70c9:1780 with SMTP id a640c23a62f3a-b7d238fc47emr1818045066b.41.1765962379557;
        Wed, 17 Dec 2025 01:06:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1LSEEKpBYh6O9P/AUFxyQWlBNTsE8aOBeRhZYA0nGC2VZiZGpm5olomtpzLD48HUlBnMAJ0kqaOvvLxG1KVQ=
X-Received: by 2002:a17:907:3da9:b0:b73:70c9:1780 with SMTP id
 a640c23a62f3a-b7d238fc47emr1818041566b.41.1765962379001; Wed, 17 Dec 2025
 01:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205151924.2250142-1-costa.shul@redhat.com> <CAP4=nvS9fTtNCtDCt254-ukTePD7hW3HoKExOPNPDOdppUig9g@mail.gmail.com>
In-Reply-To: <CAP4=nvS9fTtNCtDCt254-ukTePD7hW3HoKExOPNPDOdppUig9g@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 17 Dec 2025 10:06:06 +0100
X-Gm-Features: AQt7F2qu0SC3trufCZAEhvaKAiHGi5JdAQ61YXyTseyd-qR6bcg0ZeyoPNsZKrE
Message-ID: <CAP4=nvSr=Wz--CJgJ9kmXfB3r3uNYnt9bJt-_bCigH--rbbx2A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] tools/rtla: Consolidate nr_cpus usage across all tools
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KNT5K0cTSfQStrBLrpyJpcx7hyayqCkkGdpRz8zdhGA_1765962380
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 16. 12. 2025 v 15:41 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.c=
om> napsal:
> Since commit 2f3172f9dd58c ("tools/rtla: Consolidate code between
> osnoise/timerlat and hist/top") that was merged into 6.18, common.h
> includes timerlat_u.h. Your change thus causes a double include of
> timerlat_u.h, leading to a build error:
>
> In file included from src/timerlat_u.c:20:
> src/timerlat_u.h:6:8: error: redefinition of =E2=80=98struct timerlat_u_p=
arams=E2=80=99
>    6 | struct timerlat_u_params {
>      |        ^~~~~~~~~~~~~~~~~
> In file included from src/common.h:5,
>                 from src/timerlat_u.c:19:
> src/timerlat_u.h:6:8: note: originally defined here
>    6 | struct timerlat_u_params {
>      |        ^~~~~~~~~~~~~~~~~
>
> Please rebase your patchset and fix this so that timerlat_u.h is only
> included once.
>

Correction: the base of the patchset has nothing to do with this. It
is the C standard, from C23 (default in GCC 15), redefinition of
structs is allowed [1], so this error doesn't exist. In earlier
standards, this is not allowed.

[1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2863.pdf

Tomas

