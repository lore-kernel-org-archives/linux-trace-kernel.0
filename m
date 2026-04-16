Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B828CF4A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340837; cv=none; b=SdKbb2cgfyc+oIIlB6m0Gl2XQa8iVfWUsV4bPPm0sSJc8c4WVtHW/g5yUme2QkGb4SP0UPEgcySWfzVk/eLbD8C4tPlAPw50fhR025/imoSEJ/QTeYnL+tZ54j3wRI1I5g+dUs0oIlN+cEht4dhA/83/aQjipIDChwiLKbvdu8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340837; c=relaxed/simple;
	bh=JynIXmpTPmkvc3PoNGA4E+VrIFMqHMQLavMokV4+FYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auWbKJcWB7sCZHt2McigYiPNav2Mp6h4bwZZ710jDLMKdxvLAZ/f9JSc4elTu6BAGbbqYmJ1FkfN2wwGQEoCIGug3GJuVWZN/GRS2N3mXbpWGwVHJs39yNx026IglZR/hbqnCPFwyGXDJ5BQ1DEpVyXqb6F4n9KxqFCs7NerHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZ0QM0FJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZ0QM0FJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776340832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JynIXmpTPmkvc3PoNGA4E+VrIFMqHMQLavMokV4+FYE=;
	b=dZ0QM0FJ3Ta/PalvNhgGpGel7WdqIm3udCh606WhTqpQCy+zBkBMA07Cj2jWmTaZwcOoKq
	R6Lj5aKD04Bm9/t5E1/xOJtmGqHv5HlEeoaLVjZC8H93EoGhuR2tTNLMlVc8Y3zk4ri7Zq
	13N0Ym22qmr4jURRSk6RkZ3/eOGYLPY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-aFFXRyYVPTu3Trhdxwo6WQ-1; Thu, 16 Apr 2026 08:00:30 -0400
X-MC-Unique: aFFXRyYVPTu3Trhdxwo6WQ-1
X-Mimecast-MFC-AGG-ID: aFFXRyYVPTu3Trhdxwo6WQ_1776340830
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so8570778f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 05:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776340830; x=1776945630;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iddxLY9XhnCcM5CUn7Ti8EdGeGCr2iy+lA8qquuunA=;
        b=GweKt2mGGCtFQ3PCGPZzoaYNODchqdvYN9AgLwGpeKByTY+S0lllP7HfYmgtMUwYOQ
         is5UW26FE+x0UCivVCYqYBjGV5BlNDhJu0wyHDRTZYi8CmRMEOCcYyz3SUmUmf1qeXCL
         1zOaYarnlMgDejYmbbDQMKsGSD1MTXAhgrGJso8kDRLn8/C8BmR9+mNTmGwFrtbYLR5a
         xaXq9MPXzCnuHUkyhljgJlOyk/GhnRXlSmNfr5nO+A53qHgQDai/rKVwcAru3inHWeuY
         R3A/49+D69y7xkPf5AbED94atRa0kIxqUvbhsHGaa2rHdQ3ojaVF+O1cbr0xJOxV165d
         v4bg==
X-Gm-Message-State: AOJu0YylhOv8UHqXX426PakEzlANJn9l8CnCkAjh8wL2wbs5+NYx8e9J
	9fW7ZvVIS33aOoGzdnn3wQRM/CBiJvAvpAbxRqBZyq85GSeMYZa0iAbHaxFFRxaKTZhA8+vCi+s
	jcsGRMFsrds2ikzx4/veKWgPcoeMJWK61L9m45Ghtf+hkh8AlM6LQqdvKHcuqDXuWxosStPc+gg
	==
X-Gm-Gg: AeBDieuq9pueSHacM6cAL/eDnFg3eC7wHZDxxUQYgISGk/XB5HjVJRi55WwjpCuWEx+
	CkYR2Q4oQOKu9RAIRStOBkySwxjSSngg03r+nTwZtGBloYfrTJstjywTJ6jPlEWAGqbV4OCbYyJ
	pouaxUe+S8cazrveqo8aI9Aw40xmw1JVzezv6IPQUcdqt6fJ5INynoYaUHS5ctaCXNdigjrxczm
	ncnvTeG69Okl3En7mDaybpCs/HlE0Df+MAW7Dh705jfi+eQGDUdZQmcATiN8huv7BgqsIu7cpuu
	2qPmO3u7LuQkGKQ/bZV7qat4+a2H2C0aTMgq0/BJ6JhWcklVsIHx5BWFugcNvRtmV0JT2PzCZVL
	kgRVyMsx/9jOZmN+FWshk22Xqz8dIGWwiamUSDztdQpimpWvTDto2PgvOmmfUjqsb/BnWkKasDd
	RJSm6G7VrXEFIGdtOXozWgdOUAnQ==
X-Received: by 2002:a05:600c:5308:b0:488:8d44:bf98 with SMTP id 5b1f17b1804b1-488d67f088amr364156235e9.7.1776340828854;
        Thu, 16 Apr 2026 05:00:28 -0700 (PDT)
X-Received: by 2002:a05:600c:5308:b0:488:8d44:bf98 with SMTP id 5b1f17b1804b1-488d67f088amr364152365e9.7.1776340826003;
        Thu, 16 Apr 2026 05:00:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f584e306sm57002935e9.11.2026.04.16.05.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:00:25 -0700 (PDT)
Message-ID: <3606de6182988ef9ebb9bdd3c8bbfa04c7f59ebb.camel@redhat.com>
Subject: Re: [RFC PATCH 4/4] selftests/rv: Add selftest for the tlob monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>
Date: Thu, 16 Apr 2026 14:00:22 +0200
In-Reply-To: <5bdd82dd8aeb1d3f955b727ae1fce9819b35c170.1776020428.git.wen.yang@linux.dev>
References: <cover.1776020428.git.wen.yang@linux.dev>
	 <5bdd82dd8aeb1d3f955b727ae1fce9819b35c170.1776020428.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1MvSk7FZ0mX8RPnr9bQRnewupz6XdiGuForJ_AmFlxk_1776340830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-13 at 03:27 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add a kselftest suite (TAP output, 19 test points) for the tlob RV
> monitor under tools/testing/selftests/rv/.
>=20
> test_tlob.sh drives a compiled C helper (tlob_helper) and, for uprobe
> tests, a target binary (tlob_uprobe_target). Coverage spans the
> tracefs enable/disable path, uprobe-triggered violations, and the
> ioctl interface (within-budget stop, CPU-bound and sleep violations,
> duplicate start, ring buffer mmap and consumption).
>=20
> Requires CONFIG_RV_MON_TLOB=3Dy and CONFIG_RV_CHARDEV=3Dy; must be run
> as root.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

Those are some extensive selftests!
Could you integrate them with the existing test suite under
tools/testing/selftests/verification ?

You would probably just get your tlob_helper built and call it from some sh=
ell
script under test.d, the harness should work without the need for extra hel=
pers.

Thanks,
Gabriele

> ---
> =C2=A0tools/include/uapi/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 54 +
> =C2=A0tools/testing/selftests/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +
> =C2=A0tools/testing/selftests/rv/test_tlob.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 563 ++++++++++
> =C2=A0tools/testing/selftests/rv/tlob_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 994 ++++++++++++++++++
> =C2=A0.../testing/selftests/rv/tlob_uprobe_target.c | 108 ++
> =C2=A05 files changed, 1737 insertions(+)
> =C2=A0create mode 100644 tools/include/uapi/linux/rv.h
> =C2=A0create mode 100644 tools/testing/selftests/rv/Makefile
> =C2=A0create mode 100755 tools/testing/selftests/rv/test_tlob.sh
> =C2=A0create mode 100644 tools/testing/selftests/rv/tlob_helper.c
> =C2=A0create mode 100644 tools/testing/selftests/rv/tlob_uprobe_target.c
>=20
> diff --git a/tools/include/uapi/linux/rv.h b/tools/include/uapi/linux/rv.=
h
> new file mode 100644
> index 000000000..bef07aded
> --- /dev/null
> +++ b/tools/include/uapi/linux/rv.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * UAPI definitions for Runtime Verification (RV) monitors.
> + *
> + * This is a tools-friendly copy of include/uapi/linux/rv.h.
> + * Keep in sync with the kernel header.
> + */
> +
> +#ifndef _UAPI_LINUX_RV_H
> +#define _UAPI_LINUX_RV_H
> +
> +#include <linux/types.h>
> +#include <sys/ioctl.h>
> +
> +/* Magic byte shared by all RV monitor ioctls. */
> +#define RV_IOC_MAGIC=090xB9
> +
> +/* ---------------------------------------------------------------------=
--
> + * tlob: task latency over budget monitor=C2=A0 (nr 0x01 - 0x1F)
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +struct tlob_start_args {
> +=09__u64 threshold_us;
> +=09__u64 tag;
> +=09__s32 notify_fd;
> +=09__u32 flags;
> +};
> +
> +struct tlob_event {
> +=09__u32 tid;
> +=09__u32 pad;
> +=09__u64 threshold_us;
> +=09__u64 on_cpu_us;
> +=09__u64 off_cpu_us;
> +=09__u32 switches;
> +=09__u32 state;=C2=A0=C2=A0 /* 1 =3D on_cpu, 0 =3D off_cpu */
> +=09__u64 tag;
> +};
> +
> +struct tlob_mmap_page {
> +=09__u32=C2=A0 data_head;
> +=09__u32=C2=A0 data_tail;
> +=09__u32=C2=A0 capacity;
> +=09__u32=C2=A0 version;
> +=09__u32=C2=A0 data_offset;
> +=09__u32=C2=A0 record_size;
> +=09__u64=C2=A0 dropped;
> +};
> +
> +#define TLOB_IOCTL_TRACE_START=09_IOW(RV_IOC_MAGIC, 0x01, struct
> tlob_start_args)
> +#define TLOB_IOCTL_TRACE_STOP=09_IO(RV_IOC_MAGIC,=C2=A0 0x02)
> +
> +#endif /* _UAPI_LINUX_RV_H */
> diff --git a/tools/testing/selftests/rv/Makefile
> b/tools/testing/selftests/rv/Makefile
> new file mode 100644
> index 000000000..14e94a1ab
> --- /dev/null
> +++ b/tools/testing/selftests/rv/Makefile
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for rv selftests
> +
> +TEST_GEN_PROGS :=3D tlob_helper tlob_uprobe_target
> +
> +TEST_PROGS :=3D \
> +=09test_tlob.sh \
> +
> +# TOOLS_INCLUDES is defined by ../lib.mk; provides -isystem to
> +# tools/include/uapi so that #include <linux/rv.h> resolves to the
> +# in-tree UAPI header without requiring make headers_install.
> +# Note: both must be added to the global variables, not as target-specif=
ic
> +# overrides, because lib.mk rewrites TEST_GEN_PROGS to $(OUTPUT)/name
> +# before per-target rules would be evaluated.
> +CFLAGS +=3D $(TOOLS_INCLUDES)
> +LDLIBS +=3D -lpthread
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/rv/test_tlob.sh
> b/tools/testing/selftests/rv/test_tlob.sh
> new file mode 100755
> index 000000000..3ba2125eb
> --- /dev/null
> +++ b/tools/testing/selftests/rv/test_tlob.sh
> @@ -0,0 +1,563 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Selftest for the tlob (task latency over budget) RV monitor.
> +#
> +# Two interfaces are tested:
> +#
> +#=C2=A0=C2=A0 1. tracefs interface:
> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable/disable, presence of =
tracefs files,
> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uprobe binding (threshold_us=
:offset_start:offset_stop:binary_path)
> and
> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 violation detection via the =
ftrace ring buffer.
> +#
> +#=C2=A0=C2=A0 2. /dev/rv ioctl self-instrumentation (via tlob_helper):
> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 within-budget, over-budget o=
n-CPU, over-budget off-CPU (sleep),
> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 double-start, stop-without-s=
tart.
> +#
> +# Written to be POSIX sh compatible (no bash-specific extensions).
> +
> +ksft_skip=3D4
> +t_pass=3D0; t_fail=3D0; t_skip=3D0; t_total=3D0
> +
> +tap_header() { echo "TAP version 13"; }
> +tap_plan()=C2=A0=C2=A0 { echo "1..$1"; }
> +tap_pass()=C2=A0=C2=A0 { t_pass=3D$((t_pass+1)); echo "ok $t_total - $1"=
; }
> +tap_fail()=C2=A0=C2=A0 { t_fail=3D$((t_fail+1)); echo "not ok $t_total -=
 $1"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 [ -n "$2" ] && echo "=C2=A0 # $2"; }
> +tap_skip()=C2=A0=C2=A0 { t_skip=3D$((t_skip+1)); echo "ok $t_total - $1 =
# SKIP $2"; }
> +next_test()=C2=A0 { t_total=3D$((t_total+1)); }
> +
> +TRACEFS=3D$(grep -m1 tracefs /proc/mounts 2>/dev/null | awk '{print $2}'=
)
> +[ -z "$TRACEFS" ] && TRACEFS=3D/sys/kernel/tracing
> +
> +RV_DIR=3D"${TRACEFS}/rv"
> +TLOB_DIR=3D"${RV_DIR}/monitors/tlob"
> +TRACE_FILE=3D"${TRACEFS}/trace"
> +TRACING_ON=3D"${TRACEFS}/tracing_on"
> +TLOB_MONITOR=3D"${TLOB_DIR}/monitor"
> +BUDGET_EXCEEDED_ENABLE=3D"${TRACEFS}/events/rv/tlob_budget_exceeded/enab=
le"
> +RV_DEV=3D"/dev/rv"
> +
> +# tlob_helper and tlob_uprobe_target must be in the same directory as
> +# this script or on PATH.
> +SCRIPT_DIR=3D$(dirname "$0")
> +IOCTL_HELPER=3D"${SCRIPT_DIR}/tlob_helper"
> +UPROBE_TARGET=3D"${SCRIPT_DIR}/tlob_uprobe_target"
> +
> +check_root()=C2=A0=C2=A0=C2=A0=C2=A0 { [ "$(id -u)" =3D "0" ] || { echo =
"# Need root" >&2; exit
> $ksft_skip; }; }
> +check_tracefs()=C2=A0 { [ -d "${TRACEFS}" ]=C2=A0=C2=A0 || { echo "# No =
tracefs" >&2; exit
> $ksft_skip; }; }
> +check_rv_dir()=C2=A0=C2=A0 { [ -d "${RV_DIR}" ]=C2=A0=C2=A0=C2=A0 || { e=
cho "# No RV infra" >&2; exit
> $ksft_skip; }; }
> +check_tlob()=C2=A0=C2=A0=C2=A0=C2=A0 { [ -d "${TLOB_DIR}" ]=C2=A0 || { e=
cho "# No tlob monitor" >&2;
> exit $ksft_skip; }; }
> +
> +tlob_enable()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { echo 1 >=
 "${TLOB_DIR}/enable"; }
> +tlob_disable()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { echo 0 > "${T=
LOB_DIR}/enable" 2>/dev/null; }
> +tlob_is_enabled()=C2=A0=C2=A0=C2=A0=C2=A0 { [ "$(cat "${TLOB_DIR}/enable=
" 2>/dev/null)" =3D "1" ];
> }
> +trace_event_enable()=C2=A0 { echo 1 > "${BUDGET_EXCEEDED_ENABLE}" 2>/dev=
/null; }
> +trace_event_disable() { echo 0 > "${BUDGET_EXCEEDED_ENABLE}" 2>/dev/null=
; }
> +trace_on()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { echo 1 > "${TRACING_ON}" 2>/dev/null; }
> +trace_clear()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { echo > "=
${TRACE_FILE}"; }
> +trace_grep()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { gre=
p -q "$1" "${TRACE_FILE}" 2>/dev/null; }
> +
> +cleanup() {
> +=09tlob_disable
> +=09trace_event_disable
> +=09trace_clear
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# Test 1: enable / disable
> +# ----------------------------------------------------------------------=
-----
> +run_test_enable_disable() {
> +=09next_test; cleanup
> +=09tlob_enable
> +=09if ! tlob_is_enabled; then
> +=09=09tap_fail "enable_disable" "not enabled after echo 1";
> cleanup; return
> +=09fi
> +=09tlob_disable
> +=09if tlob_is_enabled; then
> +=09=09tap_fail "enable_disable" "still enabled after echo 0";
> cleanup; return
> +=09fi
> +=09tap_pass "enable_disable"; cleanup
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# Test 2: tracefs files present
> +# ----------------------------------------------------------------------=
-----
> +run_test_tracefs_files() {
> +=09next_test; cleanup
> +=09missing=3D""
> +=09for f in enable desc monitor; do
> +=09=09[ ! -e "${TLOB_DIR}/${f}" ] && missing=3D"${missing} ${f}"
> +=09done
> +=09[ -n "${missing}" ] \
> +=09=09&& tap_fail "tracefs_files" "missing:${missing}" \
> +=09=09|| tap_pass "tracefs_files"
> +=09cleanup
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# Helper: resolve file offset of a function inside a binary.
> +#
> +# Usage: resolve_offset <binary> <vaddr_hex>
> +# Prints the hex file offset, or empty string on failure.
> +# ----------------------------------------------------------------------=
-----
> +resolve_offset() {
> +=09bin=3D$1; vaddr=3D$2
> +=09# Parse /proc/self/maps to find the mapping that contains vaddr.
> +=09# Each line: start-end perms offset dev inode [path]
> +=09while IFS=3D read -r line; do
> +=09=09set -- $line
> +=09=09range=3D$1; off=3D$4; path=3D$7
> +=09=09[ -z "$path" ] && continue
> +=09=09# Only consider the mapping for our binary
> +=09=09[ "$path" !=3D "$bin" ] && continue
> +=09=09# Split range into start and end
> +=09=09start=3D$(echo "$range" | cut -d- -f1)
> +=09=09end=3D$(echo "$range" | cut -d- -f2)
> +=09=09# Convert hex to decimal for comparison (use printf)
> +=09=09s=3D$(printf "%d" "0x${start}" 2>/dev/null) || continue
> +=09=09e=3D$(printf "%d" "0x${end}"=C2=A0=C2=A0 2>/dev/null) || continue
> +=09=09v=3D$(printf "%d" "${vaddr}"=C2=A0=C2=A0 2>/dev/null) || continue
> +=09=09o=3D$(printf "%d" "0x${off}"=C2=A0=C2=A0 2>/dev/null) || continue
> +=09=09if [ "$v" -ge "$s" ] && [ "$v" -lt "$e" ]; then
> +=09=09=09file_off=3D$(printf "0x%x" $(( (v - s) + o )))
> +=09=09=09echo "$file_off"
> +=09=09=09return
> +=09=09fi
> +=09done < /proc/self/maps
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# Test 3: uprobe binding - no false positive
> +#
> +# Bind this process with a 10 s budget.=C2=A0 Do nothing for 0.5 s.
> +# No budget_exceeded event should appear in the trace.
> +# ----------------------------------------------------------------------=
-----
> +run_test_uprobe_no_false_positive() {
> +=09next_test; cleanup
> +=09if [ ! -e "${TLOB_MONITOR}" ]; then
> +=09=09tap_skip "uprobe_no_false_positive" "monitor file not
> available"
> +=09=09cleanup; return
> +=09fi
> +=09# We probe the "sleep" command that we will run as a subprocess.
> +=09# Use /bin/sleep as the binary; find a valid function offset (0x0
> +=09# resolves to the ELF entry point, which is sufficient for a
> +=09# no-false-positive test since we just need the binding to exist).
> +=09sleep_bin=3D$(command -v sleep 2>/dev/null)
> +=09if [ -z "$sleep_bin" ]; then
> +=09=09tap_skip "uprobe_no_false_positive" "sleep not found";
> cleanup; return
> +=09fi
> +=09pid=3D$$
> +=09# offset 0x0 probes the entry point of /bin/sleep - this is a
> +=09# deliberate probe that will not fire during a simple 'sleep 10'
> +=09# invoked in a subshell, but registers the pid in tlob.
> +=09#
> +=09# Instead, bind our own pid with a generous 10 s threshold and
> +=09# verify that 0.5 s of idle time does NOT fire the timer.
> +=09#
> +=09# Since we cannot easily get a valid uprobe offset in pure shell,
> +=09# we skip this sub-test if we cannot form a valid binding.
> +=09exe=3D$(readlink /proc/self/exe 2>/dev/null)
> +=09if [ -z "$exe" ]; then
> +=09=09tap_skip "uprobe_no_false_positive" "cannot read
> /proc/self/exe"
> +=09=09cleanup; return
> +=09fi
> +=09trace_event_enable
> +=09trace_on
> +=09tlob_enable
> +=09trace_clear
> +=09# Sleep without any binding - just verify no spurious events
> +=09sleep 0.5
> +=09trace_grep "budget_exceeded" \
> +=09=09&& tap_fail "uprobe_no_false_positive" \
> +=09=09=09"spurious budget_exceeded without any binding" \
> +=09=09|| tap_pass "uprobe_no_false_positive"
> +=09cleanup
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# Helper: get_uprobe_offset <binary> <symbol>
> +#
> +# Use tlob_helper sym_offset to get the ELF file offset of <symbol>
> +# in <binary>.=C2=A0 Prints the hex offset (e.g. "0x11d0") or empty stri=
ng on
> +# failure.
> +# ----------------------------------------------------------------------=
-----
> +get_uprobe_offset() {
> +=09bin=3D$1; sym=3D$2
> +=09if [ ! -x "${IOCTL_HELPER}" ]; then
> +=09=09return
> +=09fi
> +=09"${IOCTL_HELPER}" sym_offset "${bin}" "${sym}" 2>/dev/null
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# Test 4: uprobe binding - violation detected
> +#
> +# Start tlob_uprobe_target (a busy-spin binary with a well-known symbol)=
,
> +# attach a uprobe on tlob_busy_work with a 10 ms threshold, and verify
> +# that a budget_expired event appears.
> +# ----------------------------------------------------------------------=
-----
> +run_test_uprobe_violation() {
> +=09next_test; cleanup
> +=09if [ ! -e "${TLOB_MONITOR}" ]; then
> +=09=09tap_skip "uprobe_violation" "monitor file not available"
> +=09=09cleanup; return
> +=09fi
> +=09if [ ! -x "${UPROBE_TARGET}" ]; then
> +=09=09tap_skip "uprobe_violation" \
> +=09=09=09"tlob_uprobe_target not found or not executable"
> +=09=09cleanup; return
> +=09fi
> +
> +=09# Get the file offsets of the start and stop probe symbols
> +=09busy_offset=3D$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work"=
)
> +=09if [ -z "${busy_offset}" ]; then
> +=09=09tap_skip "uprobe_violation" \
> +=09=09=09"cannot resolve tlob_busy_work offset in
> ${UPROBE_TARGET}"
> +=09=09cleanup; return
> +=09fi
> +=09stop_offset=3D$(get_uprobe_offset "${UPROBE_TARGET}"
> "tlob_busy_work_done")
> +=09if [ -z "${stop_offset}" ]; then
> +=09=09tap_skip "uprobe_violation" \
> +=09=09=09"cannot resolve tlob_busy_work_done offset in
> ${UPROBE_TARGET}"
> +=09=09cleanup; return
> +=09fi
> +
> +=09# Start the busy-spin target (run for 30 s so the test can observe
> it)
> +=09"${UPROBE_TARGET}" 30000 &
> +=09busy_pid=3D$!
> +=09sleep 0.05
> +
> +=09trace_event_enable
> +=09trace_on
> +=09tlob_enable
> +=09trace_clear
> +
> +=09# Bind the target: 10 us budget; start=3Dtlob_busy_work,
> stop=3Dtlob_busy_work_done
> +=09binding=3D"10:${busy_offset}:${stop_offset}:${UPROBE_TARGET}"
> +=09if ! echo "${binding}" > "${TLOB_MONITOR}" 2>/dev/null; then
> +=09=09kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}"
> 2>/dev/null
> +=09=09tap_skip "uprobe_violation" \
> +=09=09=09"uprobe binding rejected (CONFIG_UPROBES=3Dy needed)"
> +=09=09cleanup; return
> +=09fi
> +
> +=09# Wait up to 2 s for a budget_exceeded event
> +=09found=3D0; i=3D0
> +=09while [ "$i" -lt 20 ]; do
> +=09=09sleep 0.1
> +=09=09trace_grep "budget_exceeded" && { found=3D1; break; }
> +=09=09i=3D$((i+1))
> +=09done
> +
> +=09echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}"
> 2>/dev/null
> +=09kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
> +
> +=09if [ "${found}" !=3D "1" ]; then
> +=09=09tap_fail "uprobe_violation" "no budget_exceeded within 2 s"
> +=09=09cleanup; return
> +=09fi
> +
> +=09# Validate the event fields: threshold must match, on_cpu must be
> non-zero
> +=09# (CPU-bound violation), and state must be on_cpu.
> +=09ev=3D$(grep "budget_exceeded" "${TRACE_FILE}" | head -n 1)
> +=09if ! echo "${ev}" | grep -q "threshold=3D10 "; then
> +=09=09tap_fail "uprobe_violation" "threshold field mismatch: ${ev}"
> +=09=09cleanup; return
> +=09fi
> +=09on_cpu=3D$(echo "${ev}" | grep -o "on_cpu=3D[0-9]*" | cut -d=3D -f2)
> +=09if [ "${on_cpu:-0}" -eq 0 ]; then
> +=09=09tap_fail "uprobe_violation" "on_cpu=3D0 for a CPU-bound spin:
> ${ev}"
> +=09=09cleanup; return
> +=09fi
> +=09if ! echo "${ev}" | grep -q "state=3Don_cpu"; then
> +=09=09tap_fail "uprobe_violation" "state is not on_cpu: ${ev}"
> +=09=09cleanup; return
> +=09fi
> +=09tap_pass "uprobe_violation"
> +=09cleanup
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# Test 5: uprobe binding - remove binding stops monitoring
> +#
> +# Bind a pid via tlob_uprobe_target, then immediately remove it.
> +# Verify that after removal the monitor file no longer lists the pid.
> +# ----------------------------------------------------------------------=
-----
> +run_test_uprobe_unbind() {
> +=09next_test; cleanup
> +=09if [ ! -e "${TLOB_MONITOR}" ]; then
> +=09=09tap_skip "uprobe_unbind" "monitor file not available"
> +=09=09cleanup; return
> +=09fi
> +=09if [ ! -x "${UPROBE_TARGET}" ]; then
> +=09=09tap_skip "uprobe_unbind" \
> +=09=09=09"tlob_uprobe_target not found or not executable"
> +=09=09cleanup; return
> +=09fi
> +
> +=09busy_offset=3D$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work"=
)
> +=09stop_offset=3D$(get_uprobe_offset "${UPROBE_TARGET}"
> "tlob_busy_work_done")
> +=09if [ -z "${busy_offset}" ] || [ -z "${stop_offset}" ]; then
> +=09=09tap_skip "uprobe_unbind" \
> +=09=09=09"cannot resolve tlob_busy_work/tlob_busy_work_done
> offset"
> +=09=09cleanup; return
> +=09fi
> +
> +=09"${UPROBE_TARGET}" 30000 &
> +=09busy_pid=3D$!
> +=09sleep 0.05
> +
> +=09tlob_enable
> +=09# 5 s budget - should not fire during this quick test
> +=09binding=3D"5000000:${busy_offset}:${stop_offset}:${UPROBE_TARGET}"
> +=09if ! echo "${binding}" > "${TLOB_MONITOR}" 2>/dev/null; then
> +=09=09kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}"
> 2>/dev/null
> +=09=09tap_skip "uprobe_unbind" \
> +=09=09=09"uprobe binding rejected (CONFIG_UPROBES=3Dy needed)"
> +=09=09cleanup; return
> +=09fi
> +
> +=09# Remove the binding
> +=09echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}"
> 2>/dev/null
> +
> +=09# The monitor file should no longer list the binding for this offset
> +=09if grep -q "^[0-9]*:0x${busy_offset#0x}:" "${TLOB_MONITOR}"
> 2>/dev/null; then
> +=09=09kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}"
> 2>/dev/null
> +=09=09tap_fail "uprobe_unbind" "pid still listed after removal"
> +=09=09cleanup; return
> +=09fi
> +
> +=09kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
> +=09tap_pass "uprobe_unbind"
> +=09cleanup
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# Test 6: uprobe - duplicate offset_start rejected
> +#
> +# Registering a second binding with the same offset_start in the same bi=
nary
> +# must be rejected with an error, since two entry uprobes at the same ad=
dress
> +# would cause double tlob_start_task() calls and undefined behaviour.
> +# ----------------------------------------------------------------------=
-----
> +run_test_uprobe_duplicate_offset() {
> +=09next_test; cleanup
> +=09if [ ! -e "${TLOB_MONITOR}" ]; then
> +=09=09tap_skip "uprobe_duplicate_offset" "monitor file not
> available"
> +=09=09cleanup; return
> +=09fi
> +=09if [ ! -x "${UPROBE_TARGET}" ]; then
> +=09=09tap_skip "uprobe_duplicate_offset" \
> +=09=09=09"tlob_uprobe_target not found or not executable"
> +=09=09cleanup; return
> +=09fi
> +
> +=09busy_offset=3D$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work"=
)
> +=09stop_offset=3D$(get_uprobe_offset "${UPROBE_TARGET}"
> "tlob_busy_work_done")
> +=09if [ -z "${busy_offset}" ] || [ -z "${stop_offset}" ]; then
> +=09=09tap_skip "uprobe_duplicate_offset" \
> +=09=09=09"cannot resolve tlob_busy_work/tlob_busy_work_done
> offset"
> +=09=09cleanup; return
> +=09fi
> +
> +=09tlob_enable
> +
> +=09# First binding: should succeed
> +=09if ! echo "5000000:${busy_offset}:${stop_offset}:${UPROBE_TARGET}" \
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > "${TLOB_MONITOR}" 2>/dev=
/null; then
> +=09=09tap_skip "uprobe_duplicate_offset" \
> +=09=09=09"uprobe binding rejected (CONFIG_UPROBES=3Dy needed)"
> +=09=09cleanup; return
> +=09fi
> +
> +=09# Second binding with same offset_start: must be rejected
> +=09if echo "9999:${busy_offset}:${stop_offset}:${UPROBE_TARGET}" \
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > "${TLOB_MONITOR}" 2>/dev=
/null; then
> +=09=09echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}"
> 2>/dev/null
> +=09=09tap_fail "uprobe_duplicate_offset" \
> +=09=09=09"duplicate offset_start was accepted (expected
> error)"
> +=09=09cleanup; return
> +=09fi
> +
> +=09echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}"
> 2>/dev/null
> +=09tap_pass "uprobe_duplicate_offset"
> +=09cleanup
> +}
> +
> +
> +#
> +# Region A: tlob_busy_work with a 5 s budget - should NOT fire during th=
e
> test.
> +# Region B: tlob_busy_work_done with a 10 us budget - SHOULD fire quickl=
y
> since
> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlob_uprob=
e_target calls tlob_busy_work_done after a busy spin.
> +#
> +# Verifies that independent bindings for different offsets in the same b=
inary
> +# are tracked separately and that only the tight-budget binding triggers=
 a
> +# budget_exceeded event.
> +# ----------------------------------------------------------------------=
-----
> +run_test_uprobe_independent_thresholds() {
> +=09next_test; cleanup
> +=09if [ ! -e "${TLOB_MONITOR}" ]; then
> +=09=09tap_skip "uprobe_independent_thresholds" \
> +=09=09=09"monitor file not available"; cleanup; return
> +=09fi
> +=09if [ ! -x "${UPROBE_TARGET}" ]; then
> +=09=09tap_skip "uprobe_independent_thresholds" \
> +=09=09=09"tlob_uprobe_target not found or not executable"
> +=09=09cleanup; return
> +=09fi
> +
> +=09busy_offset=3D$(get_uprobe_offset "${UPROBE_TARGET}" "tlob_busy_work"=
)
> +=09busy_stop_offset=3D$(get_uprobe_offset "${UPROBE_TARGET}"
> "tlob_busy_work_done")
> +=09if [ -z "${busy_offset}" ] || [ -z "${busy_stop_offset}" ]; then
> +=09=09tap_skip "uprobe_independent_thresholds" \
> +=09=09=09"cannot resolve tlob_busy_work/tlob_busy_work_done
> offset"
> +=09=09cleanup; return
> +=09fi
> +
> +=09"${UPROBE_TARGET}" 30000 &
> +=09busy_pid=3D$!
> +=09sleep 0.05
> +
> +=09trace_event_enable
> +=09trace_on
> +=09tlob_enable
> +=09trace_clear
> +
> +=09# Region A: generous 5 s budget on tlob_busy_work entry (should not
> fire)
> +=09if ! echo
> "5000000:${busy_offset}:${busy_stop_offset}:${UPROBE_TARGET}" \
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > "${TLOB_MONITOR}" 2>/dev=
/null; then
> +=09=09kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}"
> 2>/dev/null
> +=09=09tap_skip "uprobe_independent_thresholds" \
> +=09=09=09"uprobe binding rejected (CONFIG_UPROBES=3Dy needed)"
> +=09=09cleanup; return
> +=09fi
> +=09# Region B: tight 10 us budget on tlob_busy_work_done (fires quickly)
> +=09echo "10:${busy_stop_offset}:${busy_stop_offset}:${UPROBE_TARGET}" \
> +=09=09> "${TLOB_MONITOR}" 2>/dev/null
> +
> +=09found=3D0; i=3D0
> +=09while [ "$i" -lt 20 ]; do
> +=09=09sleep 0.1
> +=09=09trace_grep "budget_exceeded" && { found=3D1; break; }
> +=09=09i=3D$((i+1))
> +=09done
> +
> +=09echo "-${busy_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}"
> 2>/dev/null
> +=09echo "-${busy_stop_offset}:${UPROBE_TARGET}" > "${TLOB_MONITOR}"
> 2>/dev/null
> +=09kill "${busy_pid}" 2>/dev/null; wait "${busy_pid}" 2>/dev/null
> +
> +=09if [ "${found}" !=3D "1" ]; then
> +=09=09tap_fail "uprobe_independent_thresholds" \
> +=09=09=09"budget_exceeded not raised for tight-budget region
> within 2 s"
> +=09=09cleanup; return
> +=09fi
> +
> +=09# The violation must carry threshold=3D10 (Region B's budget).
> +=09ev=3D$(grep "budget_exceeded" "${TRACE_FILE}" | head -n 1)
> +=09if ! echo "${ev}" | grep -q "threshold=3D10 "; then
> +=09=09tap_fail "uprobe_independent_thresholds" \
> +=09=09=09"violation threshold is not Region B's 10 us: ${ev}"
> +=09=09cleanup; return
> +=09fi
> +=09tap_pass "uprobe_independent_thresholds"
> +=09cleanup
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# ioctl tests via tlob_helper
> +#
> +# Each test invokes the helper with a sub-test name.
> +# Exit code: 0=3Dpass, 1=3Dfail, 2=3Dskip.
> +# ----------------------------------------------------------------------=
-----
> +run_ioctl_test() {
> +=09testname=3D$1
> +=09next_test
> +
> +=09if [ ! -x "${IOCTL_HELPER}" ]; then
> +=09=09tap_skip "ioctl_${testname}" \
> +=09=09=09"tlob_helper not found or not executable"
> +=09=09return
> +=09fi
> +=09if [ ! -c "${RV_DEV}" ]; then
> +=09=09tap_skip "ioctl_${testname}" \
> +=09=09=09"${RV_DEV} not present (CONFIG_RV_CHARDEV=3Dy needed)"
> +=09=09return
> +=09fi
> +
> +=09tlob_enable
> +=09"${IOCTL_HELPER}" "${testname}"
> +=09rc=3D$?
> +=09tlob_disable
> +
> +=09case "${rc}" in
> +=090) tap_pass "ioctl_${testname}" ;;
> +=092) tap_skip "ioctl_${testname}" "helper returned skip" ;;
> +=09*) tap_fail "ioctl_${testname}" "helper exited with code ${rc}" ;;
> +=09esac
> +}
> +
> +# run_ioctl_test_not_enabled - like run_ioctl_test but deliberately does=
 NOT
> +# enable the tlob monitor before invoking the helper.=C2=A0 Used to veri=
fy that
> +# ioctls issued against a disabled monitor return ENODEV rather than cra=
shing
> +# the kernel with a NULL pointer dereference.
> +run_ioctl_test_not_enabled()
> +{
> +=09next_test
> +
> +=09if [ ! -x "${IOCTL_HELPER}" ]; then
> +=09=09tap_skip "ioctl_not_enabled" \
> +=09=09=09"tlob_helper not found or not executable"
> +=09=09return
> +=09fi
> +=09if [ ! -c "${RV_DEV}" ]; then
> +=09=09tap_skip "ioctl_not_enabled" \
> +=09=09=09"${RV_DEV} not present (CONFIG_RV_CHARDEV=3Dy needed)"
> +=09=09return
> +=09fi
> +
> +=09# Monitor intentionally left disabled.
> +=09tlob_disable
> +=09"${IOCTL_HELPER}" not_enabled
> +=09rc=3D$?
> +
> +=09case "${rc}" in
> +=090) tap_pass "ioctl_not_enabled" ;;
> +=092) tap_skip "ioctl_not_enabled" "helper returned skip" ;;
> +=09*) tap_fail "ioctl_not_enabled" "helper exited with code ${rc}" ;;
> +=09esac
> +}
> +
> +# ----------------------------------------------------------------------=
-----
> +# Main
> +# ----------------------------------------------------------------------=
-----
> +check_root; check_tracefs; check_rv_dir; check_tlob
> +tap_header; tap_plan 20
> +
> +# tracefs interface tests
> +run_test_enable_disable
> +run_test_tracefs_files
> +
> +# uprobe external monitoring tests
> +run_test_uprobe_no_false_positive
> +run_test_uprobe_violation
> +run_test_uprobe_unbind
> +run_test_uprobe_duplicate_offset
> +run_test_uprobe_independent_thresholds
> +
> +# /dev/rv ioctl self-instrumentation tests
> +run_ioctl_test_not_enabled
> +run_ioctl_test within_budget
> +run_ioctl_test over_budget_cpu
> +run_ioctl_test over_budget_sleep
> +run_ioctl_test double_start
> +run_ioctl_test stop_no_start
> +run_ioctl_test multi_thread
> +run_ioctl_test self_watch
> +run_ioctl_test invalid_flags
> +run_ioctl_test notify_fd_bad
> +run_ioctl_test mmap_basic
> +run_ioctl_test mmap_errors
> +run_ioctl_test mmap_consume
> +
> +echo "# Passed: ${t_pass} Failed: ${t_fail} Skipped: ${t_skip}"
> +[ "${t_fail}" -gt 0 ] && exit 1 || exit 0
> diff --git a/tools/testing/selftests/rv/tlob_helper.c
> b/tools/testing/selftests/rv/tlob_helper.c
> new file mode 100644
> index 000000000..cd76b56d1
> --- /dev/null
> +++ b/tools/testing/selftests/rv/tlob_helper.c
> @@ -0,0 +1,994 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tlob_helper.c - test helper and ELF utility for tlob selftests
> + *
> + * Called by test_tlob.sh to exercise the /dev/rv ioctl interface and to
> + * resolve ELF symbol offsets for uprobe bindings.=C2=A0 One subcommand =
per
> + * invocation so the shell script can report each as an independent TAP
> + * test case.
> + *
> + * Usage: tlob_helper <subcommand> [args...]
> + *
> + * Synchronous TRACE_START / TRACE_STOP tests:
> + *=C2=A0=C2=A0 not_enabled=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - T=
RACE_START without tlob enabled -> ENODEV (no
> kernel crash)
> + *=C2=A0=C2=A0 within_budget=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - start(50000=
 us), sleep 10 ms, stop -> expect 0
> + *=C2=A0=C2=A0 over_budget_cpu=C2=A0=C2=A0=C2=A0 - start(5000 us), busys=
pin 100 ms, stop -> EOVERFLOW
> + *=C2=A0=C2=A0 over_budget_sleep=C2=A0 - start(3000 us), sleep 50 ms, st=
op -> EOVERFLOW
> + *
> + * Error-handling tests:
> + *=C2=A0=C2=A0 double_start=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - two st=
arts without stop -> EEXIST on second
> + *=C2=A0=C2=A0 stop_no_start=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - stop withou=
t start -> ESRCH
> + *
> + * Per-thread isolation test:
> + *=C2=A0=C2=A0 multi_thread=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - two th=
reads share one fd; one within budget, one
> over
> + *
> + * Asynchronous notification test (notify_fd + read()):
> + *=C2=A0=C2=A0 self_watch=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - one worker exceeds budget; monitor fd receives one
> ntf via read()
> + *
> + * Input-validation tests (TRACE_START error paths):
> + *=C2=A0=C2=A0 invalid_flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TRACE_START=
 with flags !=3D 0 -> EINVAL
> + *=C2=A0=C2=A0 notify_fd_bad=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TRACE_START=
 with notify_fd =3D stdout (non-rv fd) ->
> EINVAL
> + *
> + * mmap ring buffer tests (Scenario D):
> + *=C2=A0=C2=A0 mmap_basic=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - mmap succeeds; verify tlob_mmap_page fields
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (vers=
ion, capacity, data_offset, record_size)
> + *=C2=A0=C2=A0 mmap_errors=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - M=
AP_PRIVATE, wrong size, and non-zero pgoff all
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n EINVAL
> + *=C2=A0=C2=A0 mmap_consume=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - trigge=
r a real violation via self-notification and
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 consu=
me the event through the mmap'd ring
> + *
> + * ELF utility (does not require /dev/rv):
> + *=C2=A0=C2=A0 sym_offset <binary> <symbol>
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - print the ELF f=
ile offset of <symbol> in <binary>
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (used=
 by the shell script to build uprobe bindings)
> + *
> + * Exit code: 0 =3D pass, 1 =3D fail, 2 =3D skip (device not available).
> + */
> +#define _GNU_SOURCE
> +#include <elf.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <poll.h>
> +#include <pthread.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#include <linux/rv.h>
> +
> +/* Default ring capacity allocated at open(); matches TLOB_RING_DEFAULT_=
CAP.
> */
> +#define TLOB_RING_DEFAULT_CAP=0964U
> +
> +static int rv_fd =3D -1;
> +
> +static int open_rv(void)
> +{
> +=09rv_fd =3D open("/dev/rv", O_RDWR);
> +=09if (rv_fd < 0) {
> +=09=09fprintf(stderr, "open /dev/rv: %s\n", strerror(errno));
> +=09=09return -1;
> +=09}
> +=09return 0;
> +}
> +
> +static void busy_spin_us(unsigned long us)
> +{
> +=09struct timespec start, now;
> +=09unsigned long elapsed;
> +
> +=09clock_gettime(CLOCK_MONOTONIC, &start);
> +=09do {
> +=09=09clock_gettime(CLOCK_MONOTONIC, &now);
> +=09=09elapsed =3D (unsigned long)(now.tv_sec - start.tv_sec)
> +=09=09=09=C2=A0 * 1000000000UL
> +=09=09=09+ (unsigned long)(now.tv_nsec - start.tv_nsec);
> +=09} while (elapsed < us * 1000UL);
> +}
> +
> +static int do_start(uint64_t threshold_us)
> +{
> +=09struct tlob_start_args args =3D {
> +=09=09.threshold_us =3D threshold_us,
> +=09=09.notify_fd=C2=A0=C2=A0=C2=A0 =3D -1,
> +=09};
> +
> +=09return ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
> +}
> +
> +static int do_stop(void)
> +{
> +=09return ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * Synchronous TRACE_START / TRACE_STOP tests
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +/*
> + * test_not_enabled - TRACE_START must return ENODEV when the tlob monit=
or
> + * has not been enabled (tlob_state_cache is NULL).
> + *
> + * The shell wrapper deliberately does NOT call tlob_enable before invok=
ing
> + * this subcommand, so the ioctl is expected to fail with ENODEV rather =
than
> + * crashing the kernel with a NULL pointer dereference in kmem_cache_all=
oc.
> + */
> +static int test_not_enabled(void)
> +{
> +=09int ret;
> +
> +=09ret =3D do_start(1000);
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "TRACE_START: expected ENODEV, got
> success\n");
> +=09=09do_stop();
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D ENODEV) {
> +=09=09fprintf(stderr, "TRACE_START: expected ENODEV, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +static int test_within_budget(void)
> +{
> +=09int ret;
> +
> +=09if (do_start(50000) < 0) {
> +=09=09fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +=09usleep(10000); /* 10 ms < 50 ms budget */
> +=09ret =3D do_stop();
> +=09if (ret !=3D 0) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected 0, got %d errno=3D%s\n",
> +=09=09=09ret, strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +static int test_over_budget_cpu(void)
> +{
> +=09int ret;
> +
> +=09if (do_start(5000) < 0) {
> +=09=09fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +=09busy_spin_us(100000); /* 100 ms >> 5 ms budget */
> +=09ret =3D do_stop();
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got 0\n");
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EOVERFLOW) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +static int test_over_budget_sleep(void)
> +{
> +=09int ret;
> +
> +=09if (do_start(3000) < 0) {
> +=09=09fprintf(stderr, "TRACE_START: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +=09usleep(50000); /* 50 ms >> 3 ms budget, off-CPU time counts */
> +=09ret =3D do_stop();
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got 0\n");
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EOVERFLOW) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected EOVERFLOW, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * Error-handling tests
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +static int test_double_start(void)
> +{
> +=09int ret;
> +
> +=09if (do_start(10000000) < 0) {
> +=09=09fprintf(stderr, "first TRACE_START: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +=09ret =3D do_start(10000000);
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "second TRACE_START: expected EEXIST, got
> 0\n");
> +=09=09do_stop();
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EEXIST) {
> +=09=09fprintf(stderr, "second TRACE_START: expected EEXIST, got
> %s\n",
> +=09=09=09strerror(errno));
> +=09=09do_stop();
> +=09=09return 1;
> +=09}
> +=09do_stop(); /* clean up */
> +=09return 0;
> +}
> +
> +static int test_stop_no_start(void)
> +{
> +=09int ret;
> +
> +=09/* Ensure clean state: ignore error from a stale entry */
> +=09do_stop();
> +
> +=09ret =3D do_stop();
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected ESRCH, got 0\n");
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D ESRCH) {
> +=09=09fprintf(stderr, "TRACE_STOP: expected ESRCH, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * Per-thread isolation test
> + *
> + * Two threads share a single /dev/rv fd.=C2=A0 The monitor uses task_st=
ruct *
> + * as the key, so each thread gets an independent slot regardless of the
> + * shared fd.
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +struct mt_thread_args {
> +=09uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 threshold_us;
> +=09unsigned long workload_us;
> +=09int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 busy;
> +=09int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expec=
t_eoverflow;
> +=09int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resul=
t;
> +};
> +
> +static void *mt_thread_fn(void *arg)
> +{
> +=09struct mt_thread_args *a =3D arg;
> +=09int ret;
> +
> +=09if (do_start(a->threshold_us) < 0) {
> +=09=09fprintf(stderr, "thread TRACE_START: %s\n", strerror(errno));
> +=09=09a->result =3D 1;
> +=09=09return NULL;
> +=09}
> +
> +=09if (a->busy)
> +=09=09busy_spin_us(a->workload_us);
> +=09else
> +=09=09usleep(a->workload_us);
> +
> +=09ret =3D do_stop();
> +=09if (a->expect_eoverflow) {
> +=09=09if (ret =3D=3D 0 || errno !=3D EOVERFLOW) {
> +=09=09=09fprintf(stderr, "thread: expected EOVERFLOW, got
> ret=3D%d errno=3D%s\n",
> +=09=09=09=09ret, strerror(errno));
> +=09=09=09a->result =3D 1;
> +=09=09=09return NULL;
> +=09=09}
> +=09} else {
> +=09=09if (ret !=3D 0) {
> +=09=09=09fprintf(stderr, "thread: expected 0, got ret=3D%d
> errno=3D%s\n",
> +=09=09=09=09ret, strerror(errno));
> +=09=09=09a->result =3D 1;
> +=09=09=09return NULL;
> +=09=09}
> +=09}
> +=09a->result =3D 0;
> +=09return NULL;
> +}
> +
> +static int test_multi_thread(void)
> +{
> +=09pthread_t ta, tb;
> +=09struct mt_thread_args a =3D {
> +=09=09.threshold_us=C2=A0=C2=A0=C2=A0=C2=A0 =3D 20000,=C2=A0 /* 20 ms */
> +=09=09.workload_us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 5000,=C2=A0=C2=A0 /=
* 5 ms sleep -> within budget */
> +=09=09.busy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D 0,
> +=09=09.expect_eoverflow =3D 0,
> +=09};
> +=09struct mt_thread_args b =3D {
> +=09=09.threshold_us=C2=A0=C2=A0=C2=A0=C2=A0 =3D 3000,=C2=A0=C2=A0 /* 3 m=
s */
> +=09=09.workload_us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 30000,=C2=A0 /* 30 =
ms spin -> over budget */
> +=09=09.busy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D 1,
> +=09=09.expect_eoverflow =3D 1,
> +=09};
> +
> +=09pthread_create(&ta, NULL, mt_thread_fn, &a);
> +=09pthread_create(&tb, NULL, mt_thread_fn, &b);
> +=09pthread_join(ta, NULL);
> +=09pthread_join(tb, NULL);
> +
> +=09return (a.result || b.result) ? 1 : 0;
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * Asynchronous notification test (notify_fd + read())
> + *
> + * A dedicated monitor_fd is opened by the main thread.=C2=A0 Two worker=
 threads
> + * each open their own work_fd and call TLOB_IOCTL_TRACE_START with
> + * notify_fd =3D monitor_fd, nominating it as the violation target.=C2=
=A0 Worker A
> + * stays within budget; worker B exceeds it.=C2=A0 The main thread reads=
 from
> + * monitor_fd and expects exactly one tlob_event record.
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +struct sw_worker_args {
> +=09int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monit=
or_fd;
> +=09uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 threshold_us;
> +=09unsigned long workload_us;
> +=09int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 busy;
> +=09int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resul=
t;
> +};
> +
> +static void *sw_worker_fn(void *arg)
> +{
> +=09struct sw_worker_args *a =3D arg;
> +=09struct tlob_start_args args =3D {
> +=09=09.threshold_us =3D a->threshold_us,
> +=09=09.notify_fd=C2=A0=C2=A0=C2=A0 =3D a->monitor_fd,
> +=09};
> +=09int work_fd;
> +=09int ret;
> +
> +=09work_fd =3D open("/dev/rv", O_RDWR);
> +=09if (work_fd < 0) {
> +=09=09fprintf(stderr, "worker open /dev/rv: %s\n",
> strerror(errno));
> +=09=09a->result =3D 1;
> +=09=09return NULL;
> +=09}
> +
> +=09ret =3D ioctl(work_fd, TLOB_IOCTL_TRACE_START, &args);
> +=09if (ret < 0) {
> +=09=09fprintf(stderr, "TRACE_START (notify): %s\n",
> strerror(errno));
> +=09=09close(work_fd);
> +=09=09a->result =3D 1;
> +=09=09return NULL;
> +=09}
> +
> +=09if (a->busy)
> +=09=09busy_spin_us(a->workload_us);
> +=09else
> +=09=09usleep(a->workload_us);
> +
> +=09ioctl(work_fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=09close(work_fd);
> +=09a->result =3D 0;
> +=09return NULL;
> +}
> +
> +static int test_self_watch(void)
> +{
> +=09int monitor_fd;
> +=09pthread_t ta, tb;
> +=09struct sw_worker_args a =3D {
> +=09=09.threshold_us =3D 50000,=C2=A0 /* 50 ms */
> +=09=09.workload_us=C2=A0 =3D 5000,=C2=A0=C2=A0 /* 5 ms sleep -> no viola=
tion */
> +=09=09.busy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
> +=09};
> +=09struct sw_worker_args b =3D {
> +=09=09.threshold_us =3D 3000,=C2=A0=C2=A0 /* 3 ms */
> +=09=09.workload_us=C2=A0 =3D 30000,=C2=A0 /* 30 ms spin -> violation */
> +=09=09.busy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 1,
> +=09};
> +=09struct tlob_event ntfs[8];
> +=09int violations =3D 0;
> +=09ssize_t n;
> +
> +=09/*
> +=09 * Open monitor_fd with O_NONBLOCK so read() after the workers finish
> +=09 * returns immediately rather than blocking forever.
> +=09 */
> +=09monitor_fd =3D open("/dev/rv", O_RDWR | O_NONBLOCK);
> +=09if (monitor_fd < 0) {
> +=09=09fprintf(stderr, "open /dev/rv (monitor_fd): %s\n",
> strerror(errno));
> +=09=09return 1;
> +=09}
> +=09a.monitor_fd =3D monitor_fd;
> +=09b.monitor_fd =3D monitor_fd;
> +
> +=09pthread_create(&ta, NULL, sw_worker_fn, &a);
> +=09pthread_create(&tb, NULL, sw_worker_fn, &b);
> +=09pthread_join(ta, NULL);
> +=09pthread_join(tb, NULL);
> +
> +=09if (a.result || b.result) {
> +=09=09close(monitor_fd);
> +=09=09return 1;
> +=09}
> +
> +=09/*
> +=09 * Drain all available tlob_event records.=C2=A0 With O_NONBLOCK the =
final
> +=09 * read() returns -EAGAIN when the buffer is empty.
> +=09 */
> +=09while ((n =3D read(monitor_fd, ntfs, sizeof(ntfs))) > 0)
> +=09=09violations +=3D (int)(n / sizeof(struct tlob_event));
> +
> +=09close(monitor_fd);
> +
> +=09if (violations !=3D 1) {
> +=09=09fprintf(stderr, "self_watch: expected 1 violation, got %d\n",
> +=09=09=09violations);
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * Input-validation tests (TRACE_START error paths)
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +/*
> + * test_invalid_flags - TRACE_START with flags !=3D 0 must return EINVAL=
.
> + *
> + * The flags field is reserved for future extensions and must be zero.
> + * Callers that set it to a non-zero value are rejected early so that a
> + * future kernel can assign meaning to those bits without silently
> + * ignoring them.
> + */
> +static int test_invalid_flags(void)
> +{
> +=09struct tlob_start_args args =3D {
> +=09=09.threshold_us =3D 1000,
> +=09=09.notify_fd=C2=A0=C2=A0=C2=A0 =3D -1,
> +=09=09.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 1,=C2=A0=C2=
=A0 /* non-zero: must be rejected */
> +=09};
> +=09int ret;
> +
> +=09ret =3D ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr, "TRACE_START(flags=3D1): expected EINVAL, got
> success\n");
> +=09=09do_stop();
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EINVAL) {
> +=09=09fprintf(stderr, "TRACE_START(flags=3D1): expected EINVAL, got
> %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +/*
> + * test_notify_fd_bad - TRACE_START with a non-/dev/rv notify_fd must re=
turn
> + * EINVAL.
> + *
> + * When notify_fd >=3D 0, the kernel resolves it to a struct file and ch=
ecks
> + * that its private_data is non-NULL (i.e. it is a /dev/rv file descript=
or).
> + * Passing stdout (fd 1) supplies a real, open fd whose private_data is =
NULL,
> + * so the kernel must reject it with EINVAL.
> + */
> +static int test_notify_fd_bad(void)
> +{
> +=09struct tlob_start_args args =3D {
> +=09=09.threshold_us =3D 1000,
> +=09=09.notify_fd=C2=A0=C2=A0=C2=A0 =3D STDOUT_FILENO,=C2=A0=C2=A0 /* ope=
n but not a /dev/rv fd
> */
> +=09=09.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
> +=09};
> +=09int ret;
> +
> +=09ret =3D ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args);
> +=09if (ret =3D=3D 0) {
> +=09=09fprintf(stderr,
> +=09=09=09"TRACE_START(notify_fd=3Dstdout): expected EINVAL, got
> success\n");
> +=09=09do_stop();
> +=09=09return 1;
> +=09}
> +=09if (errno !=3D EINVAL) {
> +=09=09fprintf(stderr,
> +=09=09=09"TRACE_START(notify_fd=3Dstdout): expected EINVAL, got
> %s\n",
> +=09=09=09strerror(errno));
> +=09=09return 1;
> +=09}
> +=09return 0;
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * mmap ring buffer tests (Scenario D)
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +/*
> + * test_mmap_basic - mmap the ring buffer and verify the control page fi=
elds.
> + *
> + * The kernel allocates TLOB_RING_DEFAULT_CAP records at open().=C2=A0 A=
 shared
> + * mmap of PAGE_SIZE + cap * record_size must succeed and the tlob_mmap_=
page
> + * header must contain consistent values.
> + */
> +static int test_mmap_basic(void)
> +{
> +=09long pagesize =3D sysconf(_SC_PAGESIZE);
> +=09size_t mmap_len =3D (size_t)pagesize +
> +=09=09=09=C2=A0 TLOB_RING_DEFAULT_CAP * sizeof(struct tlob_event);
> +=09/* rv_mmap requires a page-aligned length */
> +=09mmap_len =3D (mmap_len + (size_t)(pagesize - 1)) & ~(size_t)(pagesize=
 -
> 1);
> +=09struct tlob_mmap_page *page;
> +=09struct tlob_event *data;
> +=09void *map;
> +=09int ret =3D 0;
> +
> +=09map =3D mmap(NULL, mmap_len, PROT_READ | PROT_WRITE, MAP_SHARED, rv_f=
d,
> 0);
> +=09if (map =3D=3D MAP_FAILED) {
> +=09=09fprintf(stderr, "mmap_basic: mmap: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +
> +=09page =3D (struct tlob_mmap_page *)map;
> +=09data =3D (struct tlob_event *)((char *)map + page->data_offset);
> +
> +=09if (page->version !=3D 1) {
> +=09=09fprintf(stderr, "mmap_basic: expected version=3D1, got %u\n",
> +=09=09=09page->version);
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +=09if (page->capacity !=3D TLOB_RING_DEFAULT_CAP) {
> +=09=09fprintf(stderr, "mmap_basic: expected capacity=3D%u, got %u\n",
> +=09=09=09TLOB_RING_DEFAULT_CAP, page->capacity);
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +=09if (page->data_offset !=3D (uint32_t)pagesize) {
> +=09=09fprintf(stderr, "mmap_basic: expected data_offset=3D%ld, got
> %u\n",
> +=09=09=09pagesize, page->data_offset);
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +=09if (page->record_size !=3D sizeof(struct tlob_event)) {
> +=09=09fprintf(stderr, "mmap_basic: expected record_size=3D%zu, got
> %u\n",
> +=09=09=09sizeof(struct tlob_event), page->record_size);
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +=09if (page->data_head !=3D 0 || page->data_tail !=3D 0) {
> +=09=09fprintf(stderr, "mmap_basic: ring not empty at open: head=3D%u
> tail=3D%u\n",
> +=09=09=09page->data_head, page->data_tail);
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +=09/* Touch the data array to confirm it is accessible. */
> +=09(void)data[0].tid;
> +out:
> +=09munmap(map, mmap_len);
> +=09return ret;
> +}
> +
> +/*
> + * test_mmap_errors - verify that rv_mmap() rejects invalid mmap paramet=
ers.
> + *
> + * Four cases are tested, each must return MAP_FAILED with errno =3D=3D =
EINVAL:
> + *=C2=A0=C2=A0 1. size one page short of the correct ring length
> + *=C2=A0=C2=A0 2. size one page larger than the correct ring length
> + *=C2=A0=C2=A0 3. MAP_PRIVATE (only MAP_SHARED is permitted)
> + *=C2=A0=C2=A0 4. non-zero vm_pgoff (offset must be 0)
> + */
> +static int test_mmap_errors(void)
> +{
> +=09long pagesize =3D sysconf(_SC_PAGESIZE);
> +=09size_t correct_len =3D (size_t)pagesize +
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 TLOB_RING_DEFAULT_CAP * sizeof(struct
> tlob_event);
> +=09/* rv_mmap requires a page-aligned length */
> +=09correct_len =3D (correct_len + (size_t)(pagesize - 1)) &
> ~(size_t)(pagesize - 1);
> +=09void *map;
> +=09int ret =3D 0;
> +
> +=09/* Case 1: size one page short (correct_len - 1 still rounds up to
> correct_len) */
> +=09map =3D mmap(NULL, correct_len - (size_t)pagesize, PROT_READ |
> PROT_WRITE,
> +=09=09=C2=A0=C2=A0 MAP_SHARED, rv_fd, 0);
> +=09if (map !=3D MAP_FAILED) {
> +=09=09fprintf(stderr, "mmap_errors: short-size mmap succeeded
> (expected EINVAL)\n");
> +=09=09munmap(map, correct_len - (size_t)pagesize);
> +=09=09ret =3D 1;
> +=09} else if (errno !=3D EINVAL) {
> +=09=09fprintf(stderr, "mmap_errors: short-size: expected EINVAL,
> got %s\n",
> +=09=09=09strerror(errno));
> +=09=09ret =3D 1;
> +=09}
> +
> +=09/* Case 2: size one page too large */
> +=09map =3D mmap(NULL, correct_len + (size_t)pagesize, PROT_READ |
> PROT_WRITE,
> +=09=09=C2=A0=C2=A0 MAP_SHARED, rv_fd, 0);
> +=09if (map !=3D MAP_FAILED) {
> +=09=09fprintf(stderr, "mmap_errors: oversized mmap succeeded
> (expected EINVAL)\n");
> +=09=09munmap(map, correct_len + (size_t)pagesize);
> +=09=09ret =3D 1;
> +=09} else if (errno !=3D EINVAL) {
> +=09=09fprintf(stderr, "mmap_errors: oversized: expected EINVAL, got
> %s\n",
> +=09=09=09strerror(errno));
> +=09=09ret =3D 1;
> +=09}
> +
> +=09/* Case 3: MAP_PRIVATE instead of MAP_SHARED */
> +=09map =3D mmap(NULL, correct_len, PROT_READ | PROT_WRITE,
> +=09=09=C2=A0=C2=A0 MAP_PRIVATE, rv_fd, 0);
> +=09if (map !=3D MAP_FAILED) {
> +=09=09fprintf(stderr, "mmap_errors: MAP_PRIVATE succeeded (expected
> EINVAL)\n");
> +=09=09munmap(map, correct_len);
> +=09=09ret =3D 1;
> +=09} else if (errno !=3D EINVAL) {
> +=09=09fprintf(stderr, "mmap_errors: MAP_PRIVATE: expected EINVAL,
> got %s\n",
> +=09=09=09strerror(errno));
> +=09=09ret =3D 1;
> +=09}
> +
> +=09/* Case 4: non-zero file offset (pgoff =3D 1) */
> +=09map =3D mmap(NULL, correct_len, PROT_READ | PROT_WRITE,
> +=09=09=C2=A0=C2=A0 MAP_SHARED, rv_fd, (off_t)pagesize);
> +=09if (map !=3D MAP_FAILED) {
> +=09=09fprintf(stderr, "mmap_errors: non-zero pgoff mmap succeeded
> (expected EINVAL)\n");
> +=09=09munmap(map, correct_len);
> +=09=09ret =3D 1;
> +=09} else if (errno !=3D EINVAL) {
> +=09=09fprintf(stderr, "mmap_errors: non-zero pgoff: expected
> EINVAL, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09ret =3D 1;
> +=09}
> +
> +=09return ret;
> +}
> +
> +/*
> + * test_mmap_consume - zero-copy consumption of a real violation event.
> + *
> + * Arms a 5 ms budget with self-notification (notify_fd =3D rv_fd), slee=
ps
> + * 50 ms (off-CPU violation), then reads the pushed event through the mm=
ap'd
> + * ring without calling read().=C2=A0 Verifies:
> + *=C2=A0=C2=A0 - TRACE_STOP returns EOVERFLOW (budget was exceeded)
> + *=C2=A0=C2=A0 - data_head =3D=3D 1 after the violation
> + *=C2=A0=C2=A0 - the event fields (threshold_us, tag, tid) are correct
> + *=C2=A0=C2=A0 - data_tail can be advanced to consume the record (ring e=
mpties)
> + */
> +static int test_mmap_consume(void)
> +{
> +=09long pagesize =3D sysconf(_SC_PAGESIZE);
> +=09size_t mmap_len =3D (size_t)pagesize +
> +=09=09=09=C2=A0 TLOB_RING_DEFAULT_CAP * sizeof(struct tlob_event);
> +=09/* rv_mmap requires a page-aligned length */
> +=09mmap_len =3D (mmap_len + (size_t)(pagesize - 1)) & ~(size_t)(pagesize=
 -
> 1);
> +=09struct tlob_start_args args =3D {
> +=09=09.threshold_us =3D 5000,=09=09/* 5 ms */
> +=09=09.notify_fd=C2=A0=C2=A0=C2=A0 =3D rv_fd,=09=09/* self-notification =
*/
> +=09=09.tag=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0xd=
eadbeefULL,
> +=09=09.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
> +=09};
> +=09struct tlob_mmap_page *page;
> +=09struct tlob_event *data;
> +=09void *map;
> +=09int stop_ret;
> +=09int ret =3D 0;
> +
> +=09map =3D mmap(NULL, mmap_len, PROT_READ | PROT_WRITE, MAP_SHARED, rv_f=
d,
> 0);
> +=09if (map =3D=3D MAP_FAILED) {
> +=09=09fprintf(stderr, "mmap_consume: mmap: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +
> +=09page =3D (struct tlob_mmap_page *)map;
> +=09data =3D (struct tlob_event *)((char *)map + page->data_offset);
> +
> +=09if (ioctl(rv_fd, TLOB_IOCTL_TRACE_START, &args) < 0) {
> +=09=09fprintf(stderr, "mmap_consume: TRACE_START: %s\n",
> strerror(errno));
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +
> +=09usleep(50000); /* 50 ms >> 5 ms budget -> off-CPU violation */
> +
> +=09stop_ret =3D ioctl(rv_fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=09if (stop_ret =3D=3D 0) {
> +=09=09fprintf(stderr, "mmap_consume: TRACE_STOP returned 0,
> expected EOVERFLOW\n");
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +=09if (errno !=3D EOVERFLOW) {
> +=09=09fprintf(stderr, "mmap_consume: TRACE_STOP: expected
> EOVERFLOW, got %s\n",
> +=09=09=09strerror(errno));
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +
> +=09/* Pairs with smp_store_release in tlob_event_push. */
> +=09if (__atomic_load_n(&page->data_head, __ATOMIC_ACQUIRE) !=3D 1) {
> +=09=09fprintf(stderr, "mmap_consume: expected data_head=3D1, got
> %u\n",
> +=09=09=09page->data_head);
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +=09if (page->data_tail !=3D 0) {
> +=09=09fprintf(stderr, "mmap_consume: expected data_tail=3D0, got
> %u\n",
> +=09=09=09page->data_tail);
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +
> +=09/* Verify record content */
> +=09if (data[0].threshold_us !=3D 5000) {
> +=09=09fprintf(stderr, "mmap_consume: expected threshold_us=3D5000,
> got %llu\n",
> +=09=09=09(unsigned long long)data[0].threshold_us);
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +=09if (data[0].tag !=3D 0xdeadbeefULL) {
> +=09=09fprintf(stderr, "mmap_consume: expected tag=3D0xdeadbeef, got
> %llx\n",
> +=09=09=09(unsigned long long)data[0].tag);
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +=09if (data[0].tid =3D=3D 0) {
> +=09=09fprintf(stderr, "mmap_consume: tid is 0\n");
> +=09=09ret =3D 1;
> +=09=09goto out;
> +=09}
> +
> +=09/* Consume: advance data_tail and confirm ring is empty */
> +=09__atomic_store_n(&page->data_tail, 1U, __ATOMIC_RELEASE);
> +=09if (__atomic_load_n(&page->data_head, __ATOMIC_ACQUIRE) !=3D
> +=09=C2=A0=C2=A0=C2=A0 __atomic_load_n(&page->data_tail, __ATOMIC_ACQUIRE=
)) {
> +=09=09fprintf(stderr, "mmap_consume: ring not empty after
> consume\n");
> +=09=09ret =3D 1;
> +=09}
> +
> +out:
> +=09munmap(map, mmap_len);
> +=09return ret;
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * ELF utility: sym_offset
> + *
> + * Print the ELF file offset of a symbol in a binary.=C2=A0 Supports 32-=
 and
> + * 64-bit ELF.=C2=A0 Walks the section headers to find .symtab (falling =
back to
> + * .dynsym), then converts the symbol's virtual address to a file offset
> + * via the PT_LOAD program headers.
> + *
> + * Does not require /dev/rv; used by the shell script to build uprobe
> + * bindings of the form
> pid:threshold_us:offset_start:offset_stop:binary_path.
> + *
> + * Returns 0 on success (offset printed to stdout), 1 on failure.
> + * ---------------------------------------------------------------------=
--
> + */
> +static int sym_offset(const char *binary, const char *symname)
> +{
> +=09int fd;
> +=09struct stat st;
> +=09void *map;
> +=09Elf64_Ehdr *ehdr;
> +=09Elf32_Ehdr *ehdr32;
> +=09int is64;
> +=09uint64_t sym_vaddr =3D 0;
> +=09int found =3D 0;
> +=09uint64_t file_offset =3D 0;
> +
> +=09fd =3D open(binary, O_RDONLY);
> +=09if (fd < 0) {
> +=09=09fprintf(stderr, "open %s: %s\n", binary, strerror(errno));
> +=09=09return 1;
> +=09}
> +=09if (fstat(fd, &st) < 0) {
> +=09=09close(fd);
> +=09=09return 1;
> +=09}
> +=09map =3D mmap(NULL, (size_t)st.st_size, PROT_READ, MAP_PRIVATE, fd, 0)=
;
> +=09close(fd);
> +=09if (map =3D=3D MAP_FAILED) {
> +=09=09fprintf(stderr, "mmap: %s\n", strerror(errno));
> +=09=09return 1;
> +=09}
> +
> +=09/* Identify ELF class */
> +=09ehdr =3D (Elf64_Ehdr *)map;
> +=09ehdr32 =3D (Elf32_Ehdr *)map;
> +=09if (st.st_size < 4 ||
> +=09=C2=A0=C2=A0=C2=A0 ehdr->e_ident[EI_MAG0] !=3D ELFMAG0 ||
> +=09=C2=A0=C2=A0=C2=A0 ehdr->e_ident[EI_MAG1] !=3D ELFMAG1 ||
> +=09=C2=A0=C2=A0=C2=A0 ehdr->e_ident[EI_MAG2] !=3D ELFMAG2 ||
> +=09=C2=A0=C2=A0=C2=A0 ehdr->e_ident[EI_MAG3] !=3D ELFMAG3) {
> +=09=09fprintf(stderr, "%s: not an ELF file\n", binary);
> +=09=09munmap(map, (size_t)st.st_size);
> +=09=09return 1;
> +=09}
> +=09is64 =3D (ehdr->e_ident[EI_CLASS] =3D=3D ELFCLASS64);
> +
> +=09if (is64) {
> +=09=09/* Walk section headers to find .symtab or .dynsym */
> +=09=09Elf64_Shdr *shdrs =3D (Elf64_Shdr *)((char *)map + ehdr-
> >e_shoff);
> +=09=09Elf64_Shdr *shstrtab_hdr =3D &shdrs[ehdr->e_shstrndx];
> +=09=09const char *shstrtab =3D (char *)map + shstrtab_hdr->sh_offset;
> +=09=09int si;
> +
> +=09=09/* Prefer .symtab; fall back to .dynsym */
> +=09=09for (int pass =3D 0; pass < 2 && !found; pass++) {
> +=09=09=09const char *target =3D pass ? ".dynsym" : ".symtab";
> +
> +=09=09=09for (si =3D 0; si < ehdr->e_shnum && !found; si++) {
> +=09=09=09=09Elf64_Shdr *sh =3D &shdrs[si];
> +=09=09=09=09const char *name =3D shstrtab + sh->sh_name;
> +
> +=09=09=09=09if (strcmp(name, target) !=3D 0)
> +=09=09=09=09=09continue;
> +
> +=09=09=09=09Elf64_Shdr *strtab_sh =3D &shdrs[sh->sh_link];
> +=09=09=09=09const char *strtab =3D (char *)map + strtab_sh-
> >sh_offset;
> +=09=09=09=09Elf64_Sym *syms =3D (Elf64_Sym *)((char *)map +
> sh->sh_offset);
> +=09=09=09=09uint64_t nsyms =3D sh->sh_size /
> sizeof(Elf64_Sym);
> +=09=09=09=09uint64_t j;
> +
> +=09=09=09=09for (j =3D 0; j < nsyms; j++) {
> +=09=09=09=09=09if (strcmp(strtab + syms[j].st_name,
> symname) =3D=3D 0) {
> +=09=09=09=09=09=09sym_vaddr =3D syms[j].st_value;
> +=09=09=09=09=09=09found =3D 1;
> +=09=09=09=09=09=09break;
> +=09=09=09=09=09}
> +=09=09=09=09}
> +=09=09=09}
> +=09=09}
> +
> +=09=09if (!found) {
> +=09=09=09fprintf(stderr, "symbol '%s' not found in %s\n",
> symname, binary);
> +=09=09=09munmap(map, (size_t)st.st_size);
> +=09=09=09return 1;
> +=09=09}
> +
> +=09=09/* Convert vaddr to file offset via PT_LOAD segments */
> +=09=09Elf64_Phdr *phdrs =3D (Elf64_Phdr *)((char *)map + ehdr-
> >e_phoff);
> +=09=09int pi;
> +
> +=09=09for (pi =3D 0; pi < ehdr->e_phnum; pi++) {
> +=09=09=09Elf64_Phdr *ph =3D &phdrs[pi];
> +
> +=09=09=09if (ph->p_type !=3D PT_LOAD)
> +=09=09=09=09continue;
> +=09=09=09if (sym_vaddr >=3D ph->p_vaddr &&
> +=09=09=09=C2=A0=C2=A0=C2=A0 sym_vaddr < ph->p_vaddr + ph->p_filesz) {
> +=09=09=09=09file_offset =3D sym_vaddr - ph->p_vaddr + ph-
> >p_offset;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09}
> +=09} else {
> +=09=09/* 32-bit ELF */
> +=09=09Elf32_Shdr *shdrs =3D (Elf32_Shdr *)((char *)map + ehdr32-
> >e_shoff);
> +=09=09Elf32_Shdr *shstrtab_hdr =3D &shdrs[ehdr32->e_shstrndx];
> +=09=09const char *shstrtab =3D (char *)map + shstrtab_hdr->sh_offset;
> +=09=09int si;
> +=09=09uint32_t sym_vaddr32 =3D 0;
> +
> +=09=09for (int pass =3D 0; pass < 2 && !found; pass++) {
> +=09=09=09const char *target =3D pass ? ".dynsym" : ".symtab";
> +
> +=09=09=09for (si =3D 0; si < ehdr32->e_shnum && !found; si++) {
> +=09=09=09=09Elf32_Shdr *sh =3D &shdrs[si];
> +=09=09=09=09const char *name =3D shstrtab + sh->sh_name;
> +
> +=09=09=09=09if (strcmp(name, target) !=3D 0)
> +=09=09=09=09=09continue;
> +
> +=09=09=09=09Elf32_Shdr *strtab_sh =3D &shdrs[sh->sh_link];
> +=09=09=09=09const char *strtab =3D (char *)map + strtab_sh-
> >sh_offset;
> +=09=09=09=09Elf32_Sym *syms =3D (Elf32_Sym *)((char *)map +
> sh->sh_offset);
> +=09=09=09=09uint32_t nsyms =3D sh->sh_size /
> sizeof(Elf32_Sym);
> +=09=09=09=09uint32_t j;
> +
> +=09=09=09=09for (j =3D 0; j < nsyms; j++) {
> +=09=09=09=09=09if (strcmp(strtab + syms[j].st_name,
> symname) =3D=3D 0) {
> +=09=09=09=09=09=09sym_vaddr32 =3D
> syms[j].st_value;
> +=09=09=09=09=09=09found =3D 1;
> +=09=09=09=09=09=09break;
> +=09=09=09=09=09}
> +=09=09=09=09}
> +=09=09=09}
> +=09=09}
> +
> +=09=09if (!found) {
> +=09=09=09fprintf(stderr, "symbol '%s' not found in %s\n",
> symname, binary);
> +=09=09=09munmap(map, (size_t)st.st_size);
> +=09=09=09return 1;
> +=09=09}
> +
> +=09=09Elf32_Phdr *phdrs =3D (Elf32_Phdr *)((char *)map + ehdr32-
> >e_phoff);
> +=09=09int pi;
> +
> +=09=09for (pi =3D 0; pi < ehdr32->e_phnum; pi++) {
> +=09=09=09Elf32_Phdr *ph =3D &phdrs[pi];
> +
> +=09=09=09if (ph->p_type !=3D PT_LOAD)
> +=09=09=09=09continue;
> +=09=09=09if (sym_vaddr32 >=3D ph->p_vaddr &&
> +=09=09=09=C2=A0=C2=A0=C2=A0 sym_vaddr32 < ph->p_vaddr + ph->p_filesz) {
> +=09=09=09=09file_offset =3D sym_vaddr32 - ph->p_vaddr + ph-
> >p_offset;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09}
> +=09=09sym_vaddr =3D sym_vaddr32;
> +=09}
> +
> +=09munmap(map, (size_t)st.st_size);
> +
> +=09if (!file_offset && sym_vaddr) {
> +=09=09fprintf(stderr, "could not map vaddr 0x%lx to file offset\n",
> +=09=09=09(unsigned long)sym_vaddr);
> +=09=09return 1;
> +=09}
> +
> +=09printf("0x%lx\n", (unsigned long)file_offset);
> +=09return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +=09int rc;
> +
> +=09if (argc < 2) {
> +=09=09fprintf(stderr, "Usage: %s <subcommand> [args...]\n",
> argv[0]);
> +=09=09return 1;
> +=09}
> +
> +=09/* sym_offset does not need /dev/rv */
> +=09if (strcmp(argv[1], "sym_offset") =3D=3D 0) {
> +=09=09if (argc < 4) {
> +=09=09=09fprintf(stderr, "Usage: %s sym_offset <binary>
> <symbol>\n",
> +=09=09=09=09argv[0]);
> +=09=09=09return 1;
> +=09=09}
> +=09=09return sym_offset(argv[2], argv[3]);
> +=09}
> +
> +=09if (open_rv() < 0)
> +=09=09return 2; /* skip */
> +
> +=09if (strcmp(argv[1], "not_enabled") =3D=3D 0)
> +=09=09rc =3D test_not_enabled();
> +=09else if (strcmp(argv[1], "within_budget") =3D=3D 0)
> +=09=09rc =3D test_within_budget();
> +=09else if (strcmp(argv[1], "over_budget_cpu") =3D=3D 0)
> +=09=09rc =3D test_over_budget_cpu();
> +=09else if (strcmp(argv[1], "over_budget_sleep") =3D=3D 0)
> +=09=09rc =3D test_over_budget_sleep();
> +=09else if (strcmp(argv[1], "double_start") =3D=3D 0)
> +=09=09rc =3D test_double_start();
> +=09else if (strcmp(argv[1], "stop_no_start") =3D=3D 0)
> +=09=09rc =3D test_stop_no_start();
> +=09else if (strcmp(argv[1], "multi_thread") =3D=3D 0)
> +=09=09rc =3D test_multi_thread();
> +=09else if (strcmp(argv[1], "self_watch") =3D=3D 0)
> +=09=09rc =3D test_self_watch();
> +=09else if (strcmp(argv[1], "invalid_flags") =3D=3D 0)
> +=09=09rc =3D test_invalid_flags();
> +=09else if (strcmp(argv[1], "notify_fd_bad") =3D=3D 0)
> +=09=09rc =3D test_notify_fd_bad();
> +=09else if (strcmp(argv[1], "mmap_basic") =3D=3D 0)
> +=09=09rc =3D test_mmap_basic();
> +=09else if (strcmp(argv[1], "mmap_errors") =3D=3D 0)
> +=09=09rc =3D test_mmap_errors();
> +=09else if (strcmp(argv[1], "mmap_consume") =3D=3D 0)
> +=09=09rc =3D test_mmap_consume();
> +=09else {
> +=09=09fprintf(stderr, "Unknown test: %s\n", argv[1]);
> +=09=09rc =3D 1;
> +=09}
> +
> +=09close(rv_fd);
> +=09return rc;
> +}
> diff --git a/tools/testing/selftests/rv/tlob_uprobe_target.c
> b/tools/testing/selftests/rv/tlob_uprobe_target.c
> new file mode 100644
> index 000000000..6c895cb40
> --- /dev/null
> +++ b/tools/testing/selftests/rv/tlob_uprobe_target.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tlob_uprobe_target.c - uprobe target binary for tlob selftests.
> + *
> + * Provides two well-known probe points:
> + *=C2=A0=C2=A0 tlob_busy_work()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - start pr=
obe: arms the tlob budget timer
> + *=C2=A0=C2=A0 tlob_busy_work_done() - stop=C2=A0 probe: cancels the tim=
er on completion
> + *
> + * The tlob selftest writes a five-field uprobe binding:
> + *=C2=A0=C2=A0 pid:threshold_us:binary:offset_start:offset_stop
> + * where offset_start is the file offset of tlob_busy_work and offset_st=
op
> + * is the file offset of tlob_busy_work_done (resolved via tlob_helper
> + * sym_offset).
> + *
> + * Both probe points are plain entry uprobes (no uretprobe).=C2=A0 The b=
usy loop
> + * keeps the task on-CPU so that either the stop probe fires cleanly (wi=
thin
> + * budget) or the hrtimer fires first and emits tlob_budget_exceeded (ov=
er
> + * budget).
> + *
> + * Usage: tlob_uprobe_target <duration_ms>
> + *
> + * Loops calling tlob_busy_work() in 200 ms iterations until <duration_m=
s>
> + * has elapsed (0 =3D run for ~24 hours).=C2=A0 Short iterations ensure =
the uprobe
> + * entry fires on every call even if the uprobe is installed after the
> + * program has started.
> + */
> +#define _GNU_SOURCE
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +
> +#ifndef noinline
> +#define noinline __attribute__((noinline))
> +#endif
> +
> +static inline int timespec_before(const struct timespec *a,
> +=09=09=09=09=C2=A0=C2=A0 const struct timespec *b)
> +{
> +=09return a->tv_sec < b->tv_sec ||
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (a->tv_sec =3D=3D b->tv_sec && a=
->tv_nsec < b->tv_nsec);
> +}
> +
> +static void timespec_add_ms(struct timespec *ts, unsigned long ms)
> +{
> +=09ts->tv_sec=C2=A0 +=3D ms / 1000;
> +=09ts->tv_nsec +=3D (long)(ms % 1000) * 1000000L;
> +=09if (ts->tv_nsec >=3D 1000000000L) {
> +=09=09ts->tv_sec++;
> +=09=09ts->tv_nsec -=3D 1000000000L;
> +=09}
> +}
> +
> +/*
> + * tlob_busy_work_done - stop-probe target.
> + *
> + * Called by tlob_busy_work() after the busy loop.=C2=A0 The uprobe on t=
his
> + * function's entry fires tlob_stop_task(), cancelling the budget timer.
> + * noinline ensures the compiler never merges this function with its cal=
ler,
> + * guaranteeing the entry uprobe always fires.
> + */
> +noinline void tlob_busy_work_done(void)
> +{
> +=09/* empty: the uprobe fires on entry */
> +}
> +
> +/*
> + * tlob_busy_work - start-probe target.
> + *
> + * The uprobe on this function's entry fires tlob_start_task(), arming t=
he
> + * budget timer.=C2=A0 noinline prevents the compiler and linker (includ=
ing LTO)
> + * from inlining this function into its callers, ensuring the entry upro=
be
> + * fires on every call.
> + */
> +noinline void tlob_busy_work(unsigned long duration_ns)
> +{
> +=09struct timespec start, now;
> +=09unsigned long elapsed;
> +
> +=09clock_gettime(CLOCK_MONOTONIC, &start);
> +=09do {
> +=09=09clock_gettime(CLOCK_MONOTONIC, &now);
> +=09=09elapsed =3D (unsigned long)(now.tv_sec - start.tv_sec)
> +=09=09=09=C2=A0 * 1000000000UL
> +=09=09=09+ (unsigned long)(now.tv_nsec - start.tv_nsec);
> +=09} while (elapsed < duration_ns);
> +
> +=09tlob_busy_work_done();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +=09unsigned long duration_ms =3D 0;
> +=09struct timespec deadline, now;
> +
> +=09if (argc >=3D 2)
> +=09=09duration_ms =3D strtoul(argv[1], NULL, 10);
> +
> +=09clock_gettime(CLOCK_MONOTONIC, &deadline);
> +=09timespec_add_ms(&deadline, duration_ms ? duration_ms : 86400000UL);
> +
> +=09do {
> +=09=09tlob_busy_work(200 * 1000000UL); /* 200 ms per iteration */
> +=09=09clock_gettime(CLOCK_MONOTONIC, &now);
> +=09} while (timespec_before(&now, &deadline));
> +
> +=09return 0;
> +}

