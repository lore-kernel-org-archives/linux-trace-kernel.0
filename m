Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB732C8B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746306; cv=none; b=iTUzfSkQkGe35fkA6ELnS1oTYI1y5AOwaGCHoFgtEygbwUbXxyZg6LigaRPrdmNSqgbzap6ZOp/C/2J7cvFU96qdYS31XZQgsjQXN0LUcG/NIgYHEtAQcejAP1c8IF0IjmG9lRl1KeOTwhRRCRAv3OFHBPRKRaOdD66cn/bSAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746306; c=relaxed/simple;
	bh=eb/lecgSj7pZ4dVPEsUUj8TIQ+srrjC8ULRf0Jm2+SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gu5xHIinpNPq1ZZqk/f0ocA+kgWU/NOUnlwbZNEurDbgpEI6uGf/+Or1V6ise2060Y+huh42dnZ0nMNX9NCDRpL+GjpUYNAM6NwT1QGfel+sf4YkPg5uKS7J+6MK8D5kvZlCAAznGQHnnOrEiR6+1CxSV/1dPjCgHjNrzJ0EylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAFHdm8g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAFHdm8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761746300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzNMOzms2O5d2a24CLqvGn9BwifdwOkeEqcANjalJ2g=;
	b=DAFHdm8gXd3EQrmZiNtBnh6bVl2+Y7OQzxOpb2NUVlxJYAHIcq57kPA94+Hy3ezAxnD5ij
	GX+k1dPkNdDEF8AvDIzvptgtnTLDMJ6NRh0Ef9zWoeZ5o9tq9WxCA6g93/TiPjr4x5F7jA
	j0Vpf4gGzJTb4ylSddCxyE2UTrPF8UI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-sKXrvDZYMWqo-oXPQR2v-Q-1; Wed, 29 Oct 2025 09:58:18 -0400
X-MC-Unique: sKXrvDZYMWqo-oXPQR2v-Q-1
X-Mimecast-MFC-AGG-ID: sKXrvDZYMWqo-oXPQR2v-Q_1761746297
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-592bd7da031so3711804e87.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746297; x=1762351097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzNMOzms2O5d2a24CLqvGn9BwifdwOkeEqcANjalJ2g=;
        b=ljtdJRb8DlTt20R/rS0zr0VUy102Zl4KoIk2CkpwBhBQH9mTmhXU1R3nu2MMZLGMnm
         nfbNnH6QCtI41xKsndc69gBfRftxSIV0LjgbPQPCmjGlcEAT4oV2IfqOb+33VL2SHfh2
         D1RxhZcxqGEISsFicldgsAlBvxv6o4VsJfkkEvMPk152sPGAZ39ptqX6NFURROgqAHyX
         no74jm6SaDYDq8X7HGu8GKAP56msFkIN/kQ2OHp8PkSkbtHgIJDkZRHACPPwfkTBoPGh
         hj7C2jhBy/2wkfCKvAzOL9XyY83C4vkAinVu5oR+Cyxrpv7RCICuTDICXgzxqUmmas6Q
         UDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsvKMGqOQCZbx8fA+5RTrW/3vRNari11Gv5wAocDj1FKhScUiBJovNK2erttzeXkVHEXdNgr7v51QHnHrnwpebfAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxchWuYeWL0LYH3wi+F34V+u7IhuqfDHAJVTHRoA1beBNueQc3c
	BtWewSuUUj3F61I5Lfn5JFo8W9OdMRiEK7QjZRjENCrpd1yXXgPR/s5Agt/XR6CDFVoZaUW0uyR
	+QHVrN3yNcdFtVLdxUBiGkfnKWxxkBWJ0PdT67a2Omqrch64erTT5M4nu4JBKAPnwpbVQ1pRwA2
	Agi5y2HIIEragV4sLfFm1skly8D//9sF4VuNKfGv5iSys9MySC
X-Gm-Gg: ASbGncvovzqzvIrjYReMUhv+nZd0A7TeKT2YNzZkVHZli/pwLe7Euh/W+nZgQsrp1fD
	sllYQkCjNid2TCpiuoOTfMfLpFrBSmypK2AChvVfcP0PKlvKQllFKCFbZj60p/69r6RTWJ5TaSb
	tHRsGppFTn4nST6x2Vx937XzWBbRVeNA1G1MnAvbdcFt/jzs3b+yy4hA+1EDT72VJqIfFgEy5Lh
	+/mxeZmJpMLPA==
X-Received: by 2002:a05:6512:238f:b0:591:ec59:2d4e with SMTP id 2adb3069b0e04-594128bfbc2mr948410e87.33.1761746296962;
        Wed, 29 Oct 2025 06:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHENcild87oyJavKrMajfFtJmvIPZWqbmuIDtqlYAc21RXT91r25XmwlhMpaWQmY1koiPE7JQjfkX6UdmNgtqU=
X-Received: by 2002:a05:6512:238f:b0:591:ec59:2d4e with SMTP id
 2adb3069b0e04-594128bfbc2mr948391e87.33.1761746296236; Wed, 29 Oct 2025
 06:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002170846.437888-1-costa.shul@redhat.com>
In-Reply-To: <20251002170846.437888-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 29 Oct 2025 14:58:04 +0100
X-Gm-Features: AWmQ_bk_Pa7PjTlfBu4mI5xpRQYogtwTJ-LtD_tM-yThYPQIs4QykeGaTsRutv0
Message-ID: <CAP4=nvT5WTKBfeihWy-FAc4hKFuJj45Be=P4U2Acs-jVnRv9oA@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Fix unassigned nr_cpus
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v0Fk0RCsflHh_4pXwZ3QkgeXI_zut-stgQoeFxGRWUA_1761746297
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 2. 10. 2025 v 19:09 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> In recently introduced timerlat_free(),
> the variable 'nr_cpus' is not assigned.
>
> Assign it with sysconf(_SC_NPROCESSORS_CONF) as done elsewhere.
> Remove the culprit: -Wno-maybe-uninitialized. The rest of the
> code is clean.

I suspected that the warning was disabled because of issues with an
old version of GCC, but that is not the case: I tried building RTLA on
RHEL 7 with GCC 4.8, and got no warnings, beside the real bug that you
fix here.

Therefore, it can be removed, so that such bugs are caught in the future.

>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/Makefile.rtla  | 2 +-
>  tools/tracing/rtla/src/timerlat.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

