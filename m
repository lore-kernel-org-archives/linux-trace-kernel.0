Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181C48BD41
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813360; cv=none; b=nabKKyZHENvXJHqdITz7uLCbYLWAnn440Zi+GBEPy4Ny/mCov8u7rQs+VCPsEZjQF4VglLy3KFeuBjDE2/zFzdc7ZnCQw0ZJjLg3b6SNK1gK2QqZpj27rBp/+kXrmvIqXGlb3AcKZRrG0HeZyCVOJnVIRjZyGnwR2Q5uU0QdRT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813360; c=relaxed/simple;
	bh=fIs8912wrbrNPEUBXwAwkKZCWWP5ZZMi52E3B+a1Vf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAXOtp1VdoHhNB+vERak5V/nX8+qVaq3czKNFCFZTWLZizf7+ynPY/eX8Y6dlNCIli8mGl0UneQqxUBqAHJjJj8pLyRwjPd9G9P5GfAavuAo/nH5wk3uv+Eb/Zuk40/98Q/G5iTt0yHo0Md2ZzUJR9lVYrywi76Kz4WxN0ocC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ag3o2BZH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ag3o2BZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784813358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VqqrcMAhQvH33jxbvdGlmUh4b3L+8XSt6T6ECsCQnM0=;
	b=Ag3o2BZHfbukZHTSeVKLzl9ljgoGog5vTjCwjpucV2L5BN9zXj4n/6jlnoBs1xZN3AFfW4
	nrXrCONi4Xh/o1QTFxwT/7A/IhZHM4HT++9TgPmlhPo5PAv/pojtni2vvdUdFsHiEONXp6
	ezBzWZrWyA6r8rt6NiQ9l5cFnKYcNkk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-9qaQW4vRMJ6EcrUrXoV-nA-1; Thu, 23 Jul 2026 09:29:17 -0400
X-MC-Unique: 9qaQW4vRMJ6EcrUrXoV-nA-1
X-Mimecast-MFC-AGG-ID: 9qaQW4vRMJ6EcrUrXoV-nA_1784813356
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1670dd0f5dso73515666b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 06:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813356; x=1785418156;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zzPBfPYGCbwesHqqD/7lZI5SmmXKKBgi7jk62yTjfQo=;
        b=JLqQEg92lDcpSsRvUH3YI147TqORjn/mo2mWWm+1BjCDWMjCQEMDYi1ut5wDFRHPFB
         FL8ihzDZ6hlumWIKl8AY64fN32+oGKmHwcPOO0YLPq+3UNAUyHOzu+lS+Wa5xXTgmGNT
         slhUlTHX+B7JlhCIpLJeHhtWnZnFNGxysrGLjSf9pH2rgJ6lAWXSLm6kjYcx6NO/LdaE
         YmWoEAubyD0NDqr58p14CaPJpkHc73sZOQ5Q07a+UYPIMc+snMkTg9MH5hsAS6CYxzss
         f3bp3j8+UKYPVMDbG0YX3WPQDQJPbCUdxGsG1caBVRTxX8oEUgIXW5lMar3urVhxxYil
         Jn6w==
X-Forwarded-Encrypted: i=1; AHgh+Rp6zpzKbh/logh8/DwX/7Wk7Vnhf9cRTiaMfUZVOVsh4/gZIMXhi0LHUbnB6TQW0xm67PU6joQmCFonwAGxZ2RXaU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4LoptGbiRBjKyAbvtZaTqD5NQSldNXVHHCdntx8Ean3uA12gi
	efprtfbkuc6Tl3tVooVNqlUGQkXS6JaGZmvKGE8L5RErWftFbsDqEYVR5QZtMkFXaDfvuZQhdLr
	XS2SHmcfTPitoNDUQWUOyO57mi/ifih+QSpCBiYndQI06W63yUFIz54oAxcDr5NQGKAC77+8A2g
	==
X-Gm-Gg: AR+sD13zFJVrVSzWLoXIxMkrM01rS80ar6tBC5sUhHKNYreRKagufzqHC2hwqK19ghF
	GO+B3YDrulu5qgySCsLnaQOhTAYaH0K+AtQx7nQePXk91ejSXFZlKCXENA2TTYUa0QFu2XEl+9X
	LBRpdhlcmdGYXIP/gjv2PB7q6EwAjVqU5cabKvvaFDXJCCmwRZ3B8jGVuTAh05jQaFwHLveT5tm
	Bh3O+K+ssN/Y4iDGk8qgXM+mp8HCjMHd3whAYAS0LniZ7iXrKXoWd+jpb/n8bywfbd52G6s6fE0
	gGBv6dd09aG/BBLeITBtC3fN2Zcla5zFZjmBQBSXg36bX3QN9yFTTd0ky4MwkucxpVImU1IBF1g
	SG3umLhTQq7cYbXn50mlTYtc3GzRirHhibfHG9pGZmKIWqvGB0SewrTNaEN0sNi8O4SJ4kw==
X-Received: by 2002:a17:907:960b:b0:c15:ce72:9347 with SMTP id a640c23a62f3a-c1c50718d0fmr141353966b.19.1784813355892;
        Thu, 23 Jul 2026 06:29:15 -0700 (PDT)
X-Received: by 2002:a17:907:960b:b0:c15:ce72:9347 with SMTP id a640c23a62f3a-c1c50718d0fmr141352166b.19.1784813355471;
        Thu, 23 Jul 2026 06:29:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f35024922sm2198730a12.22.2026.07.23.06.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 06:29:15 -0700 (PDT)
Message-ID: <bb071e05b50d060dd7876160825b118d9723854e.camel@redhat.com>
Subject: Re: [PATCH v4 8/8] selftests/verification: add tlob selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 15:29:13 +0200
In-Reply-To: <4eb9a676efe90de8dfc1a9188d6ea81336e65e63.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
	 <4eb9a676efe90de8dfc1a9188d6ea81336e65e63.1783524627.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3U5LBCdj_OPF9T8P0MHif45pmO7rQ0zIULeTB3b_-Ko_1784813356
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add seven ftrace-style test scripts for the tlob RV monitor under
> tools/testing/selftests/verification/test.d/tlob/.=C2=A0 The tests cover
> uprobe binding management, budget violation detection, and per-state
> time accounting.
>=20
> Helper binaries tlob_target and tlob_sym are included in the same
> directory so the suite is self-contained.=C2=A0 tlob_sym resolves ELF
> symbol offsets for uprobe registration; tlob_target provides busy-spin,
> sleep, and preempt workloads.
>=20
> ftracetest is updated to walk up the directory tree when searching for
> test.d/functions, so monitor subdirectories can be passed as the test
> directory without placing a dummy functions shim in each new directory.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

...

> +"$UPROBE_TARGET" 30000 &=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # busy mode=
: tlob_busy_work fires every 200 ms
> +busy_pid=3D$!
> +"$UPROBE_TARGET" 30000 sleep & # sleep mode: tlob_sleep_work fires every=
 200
> ms
> +sleep_pid=3D$!
> +sleep 0.05
> +
> +echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/tracing_on
> +echo 1 > monitors/tlob/enable
> +echo > /sys/kernel/tracing/trace
> +
> +# Binding A: 5 s budget on the busy probe - must not fire in 200 ms loop=
s.
> +echo "p ${UPROBE_TARGET}:${busy_offset} ${busy_stop} threshold=3D5000000=
000" >
> "$TLOB_MONITOR"
> +# Binding B: 10 us budget on the sleep probe - fires on first invocation=
.
> +echo "p ${UPROBE_TARGET}:${sleep_offset} ${sleep_stop} threshold=3D10000=
" >
> "$TLOB_MONITOR"
> +
> +# Wait up to 2 s for error_env_tlob from binding B.
> +found=3D0; i=3D0
> +while [ "$i" -lt 20 ]; do
> +=09sleep 0.1
> +=09grep -q "error_env_tlob" /sys/kernel/tracing/trace && { found=3D1;
> break; }
> +=09i=3D$((i+1))
> +done

Be careful when starting tasks and making assertions (e.g. grep) before
killing them, in case those assertions fail, set -e would exit
immediately and we'll skip stopping the tasks.

I'd say whenever you start tlob_target (or anything else) you can do:

  teardown() {
  =09kill "$sleep_pid" 2>/dev/null || true; wait "$sleep_pid" 2>/dev/null |=
| true
  =09kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || =
true
  }
  trap teardown EXIT

just to be safe. This will kill and wait again if you need teardown
before the end of the test, but that isn't an issue.

> +
> +echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR" 2>/dev/null
> +echo "-${UPROBE_TARGET}:${sleep_offset}" > "$TLOB_MONITOR" 2>/dev/null
> +kill "$sleep_pid" 2>/dev/null || true; wait "$sleep_pid" 2>/dev/null || =
true
> +kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || tr=
ue
> +
> +echo 0 > monitors/tlob/enable
> +echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +
> +[ "$found" =3D "1" ]
> +# error_env_tlob payload: clock variable must be present.
> +# The event field can be "budget_exceeded" (hrtimer path) or the DA even=
t
> +# name ("sleep", "preempt") depending on which fires first; don't constr=
ain
> it.
> +grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -q
> "clk_elapsed=3D"
> +# detail_env_tlob must appear alongside the error.
> +grep -q "detail_env_tlob" /sys/kernel/tracing/trace
> +
> +echo > /sys/kernel/tracing/trace
> diff --git
> a/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> new file mode 100644
> index 000000000000..bb2eeef17019
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test tlob monitor no spurious events without active uprob=
e
> binding
> +# requires: tlob:monitor
> +
> +TLOB_MONITOR=3Dmonitors/tlob/monitor

This appears unused here.

Thanks,
Gabriele

