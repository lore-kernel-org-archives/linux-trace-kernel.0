Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A03C2772
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636372; cv=none; b=VF1MDn8bU8cSwH5MSjOJ8SZzifaC6fYdSYJ95GqA3KsA8O5lQWfGzwKfgNQ+9VBkUJMMEVm5ZAOc0DRwTC9oVxIYExu/ZIHHzEs+HdNqYEUVRDPyeI5btYcRFvhb7RewE/8wtal1lB3PE+NW3a2NIhaPYNEiGgzmMI37lC7Fa+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636372; c=relaxed/simple;
	bh=uSoEjVTtH2yRYHNI1qWfneOd15mGjWsNd1Rs+aqDNf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zdtj2vhz60FxJBaws9nTHxgWieM+BSbz8W7q9qtUZWCzImjgv5CveYkxajpvFRRlWWuVnG/FhCaDKALH4S/M2c3mPLVLT4NuO/zVOwO2xls05uIP5V7Ao3O1z+L77iRGslRBDRSYiyxA1ghAAOCsxat4j08mpoWIPpowF7osc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6tbJiUl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6tbJiUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772636370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj/5yMdBDWJkOXTC2Px92RyAUlsr+FjJIWAonYXQ57U=;
	b=D6tbJiUlu9UyHcBRgOUsf5R8LrUjnFnWleodWcUo2iVohrtX6Lt2FJXGkEHYNXCVflY5W1
	9Xpaf44MCvnF5xKwJbb4kJ+dTUDtY9C9rFxlk/D91zJV4y8Fq+LN73F8QXMTKEW4iFKKFY
	Yn1wUn5qLfwVsiIhqnnPAHdyIV1p5SY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-3y8nfMypMie_pzSY-EeisA-1; Wed, 04 Mar 2026 09:59:29 -0500
X-MC-Unique: 3y8nfMypMie_pzSY-EeisA-1
X-Mimecast-MFC-AGG-ID: 3y8nfMypMie_pzSY-EeisA_1772636368
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b934e96af9dso802911366b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 06:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636368; x=1773241168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bj/5yMdBDWJkOXTC2Px92RyAUlsr+FjJIWAonYXQ57U=;
        b=tJ9I2pLRigP7iowVAV8g8ZSeYOdTbGgCZfaplS8AWGGTy4GBOOLn3Z53VWeThR+ptV
         CUO5ky7CoqaH3OUb2BZ1+1V1zwdLvDZ9OTBdZCEuv9p/c6icLaDcc6EykBeq+eFviHGr
         AtMLWhTDUdznYXRRb2+24IZt3M0fbGBCqTqxTm+PBLzg2GLH3ufQIpxnyL5q/hDN86s4
         s/AoEuqnkFED/Gmwl+xY2xu49zPO2ThQthmwTYngng8hon815V0sfFes0DfLX0nsMXj/
         l/UpguUN3/+nJjML/5KLHz/rbImznA2MkBpUIhgScq3vorVXUoNONG0i0T5HDM4cvf99
         7MZw==
X-Forwarded-Encrypted: i=1; AJvYcCX8AaJm1jKqZu62F6tf/cI8Po84T0cctzR0MvhLZpQBr/Qq0/UtnVncTUuB5CwXXOUUJ4f4uhhl1DLD8CWv5K+ehfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwctrE1uY28XZhLHLirn/eUCL68UDH7C1os7IN8IOiCHl1mAW5j
	WXwqpCxULm9z0b+eae4Rdva2+dBrmgNn0CFHaZwXkCxfQy7iXuIo2s+Za9CzmnDDO5R1GGMgVCH
	uq5VEHMnw5/CudNkeBCJy+oFZSlSpeenM4WcsmK+E0QpYAa8hK8gZB584xQsdqvUfE4YSVOjYzx
	mUXJ/7fCjb4M/s+LAZkMxOgr696QaENlkjJmkFlQk2O4dqx7W8
X-Gm-Gg: ATEYQzy0OldbhVWCvc+RFMEOiTmnhQZquEqf60LXDFbrnTel31E8fGYvK6FB2POpmfC
	EeWMrmchXV4iUnNq5t+g5tis6K5gqe+x6efFRfDaLNQ46w19rZ04uXRsGfbs05xnMwqzElmETmX
	xhWiM54IysuGDPXvICeTSxGrC7Wk9M1JILgSnzoIBKiOSYB53kRsD1NUXduD+yie5dAiLZVNwWs
	XdWUg==
X-Received: by 2002:a17:907:3f9d:b0:b73:1634:6d71 with SMTP id a640c23a62f3a-b93f139a117mr151528466b.26.1772636367752;
        Wed, 04 Mar 2026 06:59:27 -0800 (PST)
X-Received: by 2002:a17:907:3f9d:b0:b73:1634:6d71 with SMTP id
 a640c23a62f3a-b93f139a117mr151526466b.26.1772636367284; Wed, 04 Mar 2026
 06:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213115234.430232-1-costa.shul@redhat.com> <20260213115234.430232-2-costa.shul@redhat.com>
In-Reply-To: <20260213115234.430232-2-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 15:59:15 +0100
X-Gm-Features: AaiRm50W5XgcVaRxDrrDhMzIx6wWJ0AwKH3P27IrG89izS8ysvSoNwR-P3e5lK4
Message-ID: <CAP4=nvQ8xFr2mD4z01e656hfE9btiFRu8xrqHiR0zGkDYsiVSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tools/rtla: Consolidate nr_cpus usage across all tools
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SxUfUDqG50XcEqOe0UaNQQQASxmmyIXFCCctX4uC5DA_1772636368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 13. 2. 2026 v 12:53 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -5,12 +5,14 @@
>  #include <signal.h>
>  #include <stdlib.h>
>  #include <string.h>
> -#include <unistd.h>
>  #include <getopt.h>
> +#include <sys/sysinfo.h>
> +
>  #include "common.h"
>
>  struct trace_instance *trace_inst;
>  volatile int stop_tracing;
> +int nr_cpus;
>

This should be updated on top of the unit tests patchset [1] to also
include and initialize this global variable in tests, right? Without
that, unit tests fail to compile with undefined reference.

[1] https://lore.kernel.org/linux-trace-kernel/20260119105857.797498-1-cost=
a.shul@redhat.com/

Tomas

