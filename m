Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157B32FA2E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896108; cv=none; b=pL1r+CHOPWb6FjUDxebH7KvaJ05/UvAxCXkwxLiX+/r6edaEl7V8xjZzJ4Q6uvUwz+6VXiw+amkK7A7lOxprg5YYwQ2aJSMv2gH+G0Ok9IG7T66WaMkF39W/D1YlwZAiPEK4GWIKKyprDCRmoXo319zqSO/pe3S6TxQ+mXtf0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896108; c=relaxed/simple;
	bh=ccNmne059vkomLlOaOaSTd251RYUCLPlgzSGqQjCrgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVNcZqabYB5xYIByWZgIJzVb1ejx6KuKQFuZ1o3Y+kQYdJpKmcMSBDS5zVFXfdJMo5K2+Wf3moD5py6e9xc0Wsq5qBLK3e41R3jQ0WtgGz2K9snz/pqMyp3EiCqhYHUezjEJ8LmBss6p6bnwPsC1Rheaq6jOqj16lyAt/zCMA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqhAddT6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqhAddT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765896105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fkupt1S0B1BvCIMqxWnb3TuETYGWxl0IdwnizM8oMhE=;
	b=HqhAddT6LEssLl3xPEcmesetxzs5fD0bSpEuSU73q5n6kwK6rH7AhTqS/5Xtl7ztmPacNq
	GTZbl8zDOZSC8M8DbiwYT+HGmiAl6fDz98wzkE/TseVX1LpGiV8gkbex0bdeVEbSAC0BAD
	Sj8zTP7jOnunFGtnXnTiymVrQSBFgXc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-JQx9rz37Nqu9_NxKCnm-lw-1; Tue, 16 Dec 2025 09:41:43 -0500
X-MC-Unique: JQx9rz37Nqu9_NxKCnm-lw-1
X-Mimecast-MFC-AGG-ID: JQx9rz37Nqu9_NxKCnm-lw_1765896102
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-37a46c5d929so42356721fa.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 06:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765896102; x=1766500902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fkupt1S0B1BvCIMqxWnb3TuETYGWxl0IdwnizM8oMhE=;
        b=da+1TaK7V6wqwjDafqB39qVRQ+ca8ChYcJJPkEuVTbb6VswPhfBaxl7CIdWcHayYce
         VhyFVh2hqIwdCsRCCpPW6yXdffs6WQm7sh9Rjn3z/M+WmOenGT2UY+XfLk8+qmKIwbzm
         VR/ypvedvBqnNv27HELGxb5GtIEgoMjb2AaBNfillUIVVlIqGyTxMmFtQ/ivRa9VMrcF
         ntbVKxiBPzWLKkPOwUXLJZJwDejE2Q4n84NtaILYgjrskYAF6yMC0T1OcnsKyxkCV4NQ
         GLbffhfMeRAfq1unSxY3JUPX7j56CLplND0aQVevBgOI3v+IdDz8fyGBCgkeTklqdmGH
         sHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVHXMBR83OnaHdaq1DDBuYSDz6rjAFN7O1MhK/SpxXuHA47+FuefjruFzbwrkzZt7X1FhevWHv88LiH41LciSNCaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9BMVfthvP9FTajcYtJO1AFN0RX2+t7GUQ6prHujRVIHbHuRo
	mTasE0I0fBd4UGNP1JHLHsJ+NIiy6pxqYQ8acRv6j5pR6sLKZ5q25q6SoMykOEqNgiGjN+NydOS
	kX21OOrkTEcluf36jNv3Lygu3gt5Y61qi0krz2WK6j3NhijWrjtkkpkXuswdX23ViayaEr8U4y9
	Ge4Lr9s82Ws0pxRoCR7kgW+WEDs8CDE4SkrQh546S8aNZCCG3D
X-Gm-Gg: AY/fxX7nxK5i1azAb+d3yjkFoqsZ8ZYv+flOUnqXbKX+DTJ3ygnwEDLkga2d4M8pTMH
	T2ziC3XgILKvwtg5CZy+hHVQxSD0I96wDO2WA0sA+e4+nlQ+xwrxQZZPiryzGn58CxamV5NNDW+
	p6ymlb9ZhyUKJojhpmoQXOnUdm7eKbzSZRnWl9VzLwRPAwqFZrmurLvpNUVf6CzEOxvw==
X-Received: by 2002:a2e:be1d:0:b0:37a:2c7d:2d69 with SMTP id 38308e7fff4ca-37fd08d177cmr47513831fa.40.1765896102212;
        Tue, 16 Dec 2025 06:41:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkFeidhWoEUXLOmVzRaA5Q1vpR6sd1hl5H8AyG2YKcsJa5Z2DC+ZpSNMyIFB0VFZT2Q7ECX9btviSWdIun+M8=
X-Received: by 2002:a2e:be1d:0:b0:37a:2c7d:2d69 with SMTP id
 38308e7fff4ca-37fd08d177cmr47513691fa.40.1765896101740; Tue, 16 Dec 2025
 06:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205151924.2250142-1-costa.shul@redhat.com>
In-Reply-To: <20251205151924.2250142-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 16 Dec 2025 15:41:30 +0100
X-Gm-Features: AQt7F2pjpx9ZoHrOwX0LI8Y6w5xcnsUp4TnVRIgGM5mbKAkA2KI7TqHSvXARnbg
Message-ID: <CAP4=nvS9fTtNCtDCt254-ukTePD7hW3HoKExOPNPDOdppUig9g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] tools/rtla: Consolidate nr_cpus usage across all tools
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HjwO38aQtT482OsYVpYm-gRYBC_PiIDIByrze9CCA6A_1765896102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 5. 12. 2025 v 16:19 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
> diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src=
/timerlat_u.c
> index ce68e39d25fd..a569fe7f93aa 100644
> --- a/tools/tracing/rtla/src/timerlat_u.c
> +++ b/tools/tracing/rtla/src/timerlat_u.c
> @@ -16,7 +16,7 @@
>  #include <sys/wait.h>
>  #include <sys/prctl.h>
>
> -#include "utils.h"
> +#include "common.h"
>  #include "timerlat_u.h"
>

Since commit 2f3172f9dd58c ("tools/rtla: Consolidate code between
osnoise/timerlat and hist/top") that was merged into 6.18, common.h
includes timerlat_u.h. Your change thus causes a double include of
timerlat_u.h, leading to a build error:

In file included from src/timerlat_u.c:20:
src/timerlat_u.h:6:8: error: redefinition of =E2=80=98struct timerlat_u_par=
ams=E2=80=99
   6 | struct timerlat_u_params {
     |        ^~~~~~~~~~~~~~~~~
In file included from src/common.h:5,
                from src/timerlat_u.c:19:
src/timerlat_u.h:6:8: note: originally defined here
   6 | struct timerlat_u_params {
     |        ^~~~~~~~~~~~~~~~~

Please rebase your patchset and fix this so that timerlat_u.h is only
included once.

Tomas

