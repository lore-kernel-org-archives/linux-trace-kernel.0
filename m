Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6C1DF99A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896385; cv=none; b=A8ACAcqZltfoxmYsGob1HezuQBahDqs4HgmCTO38f35TVZqETkd/D4S99RIRr3Vs8eAohzqIw4hBBorl6qDiOVdA+PJVJRvCdHC1In0dkMPDR3DjKAaasjOAL/pHxJse1u9OQYpj4THHwUqTnmubxkRQwh7fm1/UpV4kVR2sKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896385; c=relaxed/simple;
	bh=nhQYpQKQvF9t594zVgp1DUBzsbALzc7cY1ry3VzTcLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAhZI7XWg9cP53OU/Z0oxcBYuVCCaP2YiU7G7tgYiEPEQ/SpERFs0OXDTO+EN95O7op8gPyKELRTAc+a0vtkznM086QtB97K5E7bhOqNQKd6Fi8vx+4L9OdbtE6ChazaOScxKe6UyL6POIWApIq3M3Xl6AQNVixQdToSuuuPA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTDyyVVF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTDyyVVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758896382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qaeY1K40FUcP3M6UO0BgiCtjfbxsZL2X6HMHY914gM=;
	b=aTDyyVVFTI6HS90eFRQ4k4wahYnUKGsnkQ+FFPd4KM12TCp1HGOpH045Xa3+y9RHKYhiv9
	V4malxmAv/oZ/hoXBgzwiKvycy5Pjzj37oe6HUZjgKfRC+Mhk9WdBumFrEASqxPKkEcWgK
	BO8R+WUyIxkWb0AnknJ0Zpb0lXf19XM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-42_d2_p4O7m2OiWV2Azq9Q-1; Fri, 26 Sep 2025 10:19:41 -0400
X-MC-Unique: 42_d2_p4O7m2OiWV2Azq9Q-1
X-Mimecast-MFC-AGG-ID: 42_d2_p4O7m2OiWV2Azq9Q_1758896380
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afcb72a8816so198010066b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896380; x=1759501180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qaeY1K40FUcP3M6UO0BgiCtjfbxsZL2X6HMHY914gM=;
        b=Fh3n4Ji1qV4bb9i8OoLRAVYStLmjYpBQrOhSWtL4tzz8hzYpo50iNVQHNw/HiD1v6r
         He+v6Q4OVVuRwYoHl6JPN3X92lfS6UncOI928EP6SX6w4jPo+g5nSDCk1GpSAAXumXt2
         wldZ/aB3MAlMBHncS1Q5ov3i/bszaCgMRcowI2n63F/aYyWFHTSSTmZFLE91MoZp+Zrm
         lhp0yLlO6ArcAJ5q6V71IiZIBWkxkktsGl926JzykgfxM9ifFuri3Pnu2PKcranvRMcq
         SBE3OxjVEp8BzhxVYQ8YPOvfU/D+sd3brVMI2DPzAZ2p4yw1UHcAnROXGFSJxZ5NrHQx
         Tf/g==
X-Forwarded-Encrypted: i=1; AJvYcCU4HA1Jf7ZgI34RssV5vfYKhSN64nXr9Oo7XQMcAAkZim+PtTy0+9IPTZIiWzhWYvfV6RxQp8GMrKw9uaZAtm9olTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/NxuuvM7ZFNclq6J04QvLaGB4+mzehTnOPQe7wjXch9DcbEi
	ldOdHDpJBaSec1BnSZ/rMMtJOIjRkQ/Zy5ODmqfMXbUhYrMCSm9+7XFlpbAAWaw+F4R2TeMNc6C
	VPjcLDBBR5L6KyoWO3xt895CywbS8jX+0jsXHBrRVwmYMTchAka++fHCRcx3BRtUU+kWohmHhza
	KySYL10pLbqiwbUqqel0dZGvnoUm1Mm0N3UAM6yc1Jb7KZ29RV45u6Kw0q
X-Gm-Gg: ASbGncubchmZgIDh+ZnUtwA4WZG/Ep5lfVjhGjcLYfogvW1Hy64cvBlW6nfVFMrwsrh
	yEJTuYAgzLPsKU443EJd0fZHIU33u8EGdNPQLNhxAZdELxjny5QLCV6bUbaMGaeJOOTmAZilg8z
	cOGTzzZWATRZR8m2XoIPo=
X-Received: by 2002:a17:906:f599:b0:b0c:5929:4cff with SMTP id a640c23a62f3a-b34b8fa91ffmr799809066b.26.1758896379913;
        Fri, 26 Sep 2025 07:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTbui+bc/XmrltE36cnJvexmWMWG34JOyqVwnQhqSUEDFbjBFlZjM/ZRJmSR4CTi6OOlGdFpNmHGi3QhF7ig4=
X-Received: by 2002:a17:906:f599:b0:b0c:5929:4cff with SMTP id
 a640c23a62f3a-b34b8fa91ffmr799805866b.26.1758896379473; Fri, 26 Sep 2025
 07:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907022325.243930-1-crwood@redhat.com>
In-Reply-To: <20250907022325.243930-1-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 26 Sep 2025 16:19:28 +0200
X-Gm-Features: AS18NWBHEJmlaTzKy2Og8aB6GpwMPFNcrbtb2j3cylFflwQUnWaTVar6tpVHGnY
Message-ID: <CAP4=nvQR3YDNVhka9QCNQVB=QEytxLPdFrx_nNJbNm7-r9ujDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] tools/rtla: Code consolidation and osnoise actions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Crystal Wood <crwood@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: INo43GmbbIZkYYcTjbanxxKYkIqYPJ5rNyKi8J4EWKg_1758896380
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

ne 7. 9. 2025 v 4:23 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> napsa=
l:
>
> Consolidate code between osnoise/timerlat and top/hist for easier
> maintenance and less future divergence.
>
> As a consequence, actions work on osnoise as well as timerlat, so
> expose it to the user, document it, and test it.
>
> v2: minor changes from Tomas's feedback
>
> v1: https://lore.kernel.org/linux-trace-kernel/20250821035719.137161-1-cr=
wood@redhat.com/T/#t
>
> Costa Shulyupin (1):
>   tools/rtla: Consolidate common parameters into shared structure
>
> Crystal Wood (6):
>   tools/rtla: Move top/hist params into common struct
>   tools/rtla: Create common_apply_config()
>   tools/rtla: Consolidate code between osnoise/timerlat and hist/top
>   tools/rtla: Fix -A option name in test comment
>   tools/rtla: Add test engine support for unexpected output
>   tools/rtla: Add remaining support for osnoise actions
>
>  Documentation/tools/rtla/common_options.rst   |  61 ++
>  .../tools/rtla/common_osnoise_options.rst     |   8 +
>  .../tools/rtla/common_timerlat_options.rst    |  74 +-
>  Documentation/tools/rtla/rtla-hwnoise.rst     |   2 +
>  .../tools/rtla/rtla-osnoise-hist.rst          |   2 +
>  Documentation/tools/rtla/rtla-osnoise-top.rst |   2 +
>  .../tools/rtla/rtla-timerlat-hist.rst         |   2 +
>  .../tools/rtla/rtla-timerlat-top.rst          |   2 +
>  tools/tracing/rtla/src/Build                  |   1 +
>  tools/tracing/rtla/src/actions.c              |   8 +-
>  tools/tracing/rtla/src/actions.h              |   2 +-
>  tools/tracing/rtla/src/common.c               | 344 ++++++++++
>  tools/tracing/rtla/src/common.h               | 154 +++++
>  tools/tracing/rtla/src/osnoise.c              | 101 ++-
>  tools/tracing/rtla/src/osnoise.h              | 114 +---
>  tools/tracing/rtla/src/osnoise_hist.c         | 369 ++++------
>  tools/tracing/rtla/src/osnoise_top.c          | 303 +++------
>  tools/tracing/rtla/src/timerlat.c             | 210 ++++--
>  tools/tracing/rtla/src/timerlat.h             |  55 +-
>  tools/tracing/rtla/src/timerlat_bpf.c         |  22 +-
>  tools/tracing/rtla/src/timerlat_hist.c        | 642 +++++-------------
>  tools/tracing/rtla/src/timerlat_top.c         | 568 ++++------------
>  tools/tracing/rtla/src/trace.h                |   3 -
>  tools/tracing/rtla/tests/engine.sh            |  26 +-
>  tools/tracing/rtla/tests/osnoise.t            |  27 +-
>  tools/tracing/rtla/tests/timerlat.t           |   4 +-
>  26 files changed, 1395 insertions(+), 1711 deletions(-)
>  create mode 100644 tools/tracing/rtla/src/common.c
>  create mode 100644 tools/tracing/rtla/src/common.h
>
> --
> 2.48.1
>

Can you take this patchset? (As a major change, this should go to
linux-next first I guess, not sure if the timing is right for that, my
knowledge on upstream kernel workflow is still a bit flaky).

I reviewed it already, but it seems that patchwork doesn't understand
Reviewed-by on a cover letter (even though b4 understands it). I did
Reviewed-by on the original patches where I didn't request any
changes, but v2 did not preserve that, so I put it on the cover
letter.

Tomas

