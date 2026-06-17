Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787847D93A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708962; cv=none; b=uFf47h5B5KGpn36vUOir2fK2dfyJOf1MPDbQFqNo8PUHVKK0U1NgMcaUvUC89jB8csU64m0BF5lAELode7RwfczpV/Pn4BohkE8+Wnq8KS6hfi5amQbDdnT9Kmo54YDpFtfU2HNjOLVvK/t5lLF08jZXU1g2+f8j4nfp6HK19Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708962; c=relaxed/simple;
	bh=NBvy7JmBX77mDXUyp5BPBIHYwoneaiJlAhb2YaGZcNE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psUiBOYjN6w9iEPAtiOLCUJnV3r22FQHc4kHwViugt6fJ7ODZu0YVRFSUf3IAp69v5FkHNx9G/VWligV1NuT04pbJurEzQYanLZPt2tEbh+aHVSWoj8CASCk/dalMFyc+lk8SJ+ukHP+yAAMgV+7GMBHOnJeM/a+I8so5Yvywg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNhXH5q9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNhXH5q9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=je15aDqCe9030A27QH9xfg+/P37jNs4Z2/YtjPiSBzY=;
	b=GNhXH5q9KwV7J2ZgInetJOlC9pIdDuZv0iyPAjJlzvQdGv/tbbeTUMvbflf48EHISc/Iox
	mBLfP43svWTIZ9XyyJR+2asxo28uSDd4lz6MZwflyqZsxfuMyuPamQha0RMvTLoT33wy2n
	bKS3hw2fAWC3eUk13gi6RlRyK/yK0F4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-2XWiAl2VOxqK8ipEam6-Cw-1; Wed, 17 Jun 2026 11:09:18 -0400
X-MC-Unique: 2XWiAl2VOxqK8ipEam6-Cw-1
X-Mimecast-MFC-AGG-ID: 2XWiAl2VOxqK8ipEam6-Cw_1781708957
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efa2f7009so4082039f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 08:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708957; x=1782313757;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANjNnpra5aS+d58YG+e3BMxI1QsylXKLCiU+yz4SsfE=;
        b=O0fT1C2qeIxQzJ4V/nnb2N5GmxuZ/aDo6JzkQHyr4HVyxx7htUKWT2StMDvqaozInq
         vFtgE+IEXLOZb+QVbUV0h8BBfoMe5c1ID38Y7Mz9v6jlmqydUWnE+Kv/lxBbMr9cx6IA
         x4Jioan4CvHntMvw2ZCVnGQMJlkgXvUf6StoDBAxHDB3JMgLiPnYjr1HBR1xCapjKOaF
         2IFFPgMbbZREdATeRUCQiNp26hbz/gc3PyjN0DdIoZDjwDHzK3x9riL+gFMGF17FZOdW
         bRW5KBju4Z+Ea6YaYtJfE7A+CYgzj+oOQsh46lU2Ekvrkg/4YYb6O3Pql7QqYO/3IOeE
         V2yw==
X-Forwarded-Encrypted: i=1; AFNElJ90r9UpH5qH9N6QPSEjZxz6qqxPjbl3MdUcgw+PSeuYzE4BnNdB+AUeoOTDgzTZb74coEf7MYMfPz9cPrReHuDf2oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXc6FCvKYzV0K46oz9l5moYTmJDft+lHeNu4ssrUvjtCCCIp/
	8Mo2JCGO7KCgLLR11r4AcvptA40ieSB1eWr1Z4kFRhsxjXNo2S4uD5HWO77mopnif2zmCHIsVLl
	wK+RQmXl+oDxDt3XgN4A7adhsnw7e3uOzxVjV4uB/vtTMVBlTiYh7WlhIRN0dGIxexKjnJzX2PQ
	==
X-Gm-Gg: Acq92OFWOsOy3VtImXqWqEpJ6qr5E6GheGrMcIGo5tVJWEM+NY0itYNBhyhQTo2sbmE
	or3/K7o4MFvpLr+XWfd2QkQC81OmQXa4bLGTmVYQz35s5dEoMELpFvQV32VtG0cl3n12X8Q3iQs
	/dDyJbGR3M/QDF5oWIL+RH+ZNdpcqo/4/WZCHqUq7om6Kg6c/mm2hMK9r7Sio6js18hkOuYzCQN
	R8BRouke67sOXIaFGqTgGR8O/VzppKwwc0iFSlxGDasSyiTMEsyK3wI6j1d6+oEA6HIBQ/0cnjE
	t2PgNJRzkDv+nNfUWibOzgP6OjMj8rCvFX+7iD3k6UhQ4y3ynByzdStJDYAg9m0BVp2dfQmEHAu
	9kzHo0Eqgixxq/K0=
X-Received: by 2002:a05:600c:e557:20b0:492:1e36:85dc with SMTP id 5b1f17b1804b1-492333e2b9dmr55603575e9.36.1781708957148;
        Wed, 17 Jun 2026 08:09:17 -0700 (PDT)
X-Received: by 2002:a05:600c:e557:20b0:492:1e36:85dc with SMTP id 5b1f17b1804b1-492333e2b9dmr55602935e9.36.1781708956476;
        Wed, 17 Jun 2026 08:09:16 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ebe3sm135692145e9.11.2026.06.17.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:09:16 -0700 (PDT)
Message-ID: <8c95a2665af5224f5eeb28d029aad5656529c7d4.camel@redhat.com>
Subject: Re: [PATCH v3 9/9] selftests/verification: add tlob selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 17 Jun 2026 17:09:15 +0200
In-Reply-To: <4aeb668c8446a9f6366d92e218df386bef7bc965.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <4aeb668c8446a9f6366d92e218df386bef7bc965.1780847473.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PVfc-hVZCbYydy9poXX4t1xwRxsPdcJ1SKU-Kj_xrNw_1781708957
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add selftest coverage for the tlob uprobe monitoring interface under
> tools/testing/selftests/verification/.
>=20
> test.d/tlob/ contains both the helper sources (tlob_target, tlob_sym)
> and the seven test scripts so the test suite is self-contained.
> tlob_target provides busy-spin, sleep, and preempt workloads;
> tlob_sym
> resolves ELF symbol offsets for uprobe registration.
>=20
> Seven test scripts exercise uprobe binding management, budget
> violation
> detection, and per-state time accounting (running_ns, waiting_ns,
> sleeping_ns).
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

Tests look fine and coverage is good, thanks!

Minor comments follow.

> ---
> =C2=A0.../testing/selftests/verification/.gitignore |=C2=A0=C2=A0 2 +
> =C2=A0tools/testing/selftests/verification/Makefile |=C2=A0 19 +-
> =C2=A0.../verification/test.d/tlob/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++
> =C2=A0.../verification/test.d/tlob/test.d/functions |=C2=A0=C2=A0 1 +
> =C2=A0.../verification/test.d/tlob/tlob_sym.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 189
> ++++++++++++++++++
> =C2=A0.../verification/test.d/tlob/tlob_target.c=C2=A0=C2=A0=C2=A0 | 138 =
+++++++++++++
> =C2=A0.../verification/test.d/tlob/uprobe_bind.tc=C2=A0=C2=A0 |=C2=A0 37 =
++++

> =C2=A0.../test.d/tlob/uprobe_detail_running.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 51 +++++
> =C2=A0.../test.d/tlob/uprobe_detail_sleeping.tc=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 50 +++++
> =C2=A0.../test.d/tlob/uprobe_detail_waiting.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 66 ++++++

Not sure if this would work, but just to lower the maintenance burden,
couldn't we put these 3 in the same test case? You could define a bash
function and pass "running", "sleeping" or "waiting" and whether to launch =
the
hog to that.

Only waiting uses a taskset and a slightly different ordering, but wouldn't
they all work fine like that?

...

> a/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
> b/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
> new file mode 100644
> index 000000000000..1b7ba1c6d95b
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tlob_sym.c - ELF symbol-to-file-offset utility for tlob selftests
> + *
> + * Usage: tlob_sym sym_offset <binary> <symbol>
> + *
> + *=C2=A0=C2=A0 Prints the ELF file offset of <symbol> in <binary> to std=
out.
> + *
> + * Exit: 0 =3D found, 1 =3D error / not found.
> + */

I wonder if instead of maintaining a pure C solution we couldn't live
with something like:

  sym_offset() { # target symbol
    readelf -W -S -s $1 | awk -v symbol=3D"$2" '
      { gsub(/\[ /, "[") }  # normalise section markers
      $1 ~ /^\[[0-9]+\]$/ { sections[$1]=3D"0x"$4; offsets[$1]=3D"0x"$5 }
      $1 ~ /^[0-9]+:$/ && $NF =3D=3D symbol { addr=3D"0x"$2; sec=3D"["$7"]"=
 }
      END { printf "printf \"0x%%x\\n\" $((%s - %s + %s))\n", addr, section=
s[sec], offsets[sec] }
    ' | sh
  }

...

> diff --git
> a/tools/testing/selftests/verification/test.d/tlob/tlob_target.c
> b/tools/testing/selftests/verification/test.d/tlob/tlob_target.c
> new file mode 100644
> index 000000000000..0fdbc575d71d
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/tlob_target.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tlob_target.c - uprobe target binary for tlob selftests.
> + *
> + * Provides three start/stop probe pairs, each designed to exercise
> a
> + * different dominant component of the detail_env_tlob ns breakdown:
> + *
> + *=C2=A0=C2=A0 tlob_busy_work=C2=A0=C2=A0=C2=A0 / tlob_busy_work_done=C2=
=A0=C2=A0=C2=A0 - busy-spin:
> running_ns dominates
> + *=C2=A0=C2=A0 tlob_sleep_work=C2=A0=C2=A0 / tlob_sleep_work_done=C2=A0=
=C2=A0 - nanosleep:
> sleeping_ns dominates
> + *=C2=A0=C2=A0 tlob_preempt_work / tlob_preempt_work_done - busy-spin:
> waiting_ns dominates
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (needs an R=
T

In short tlob_preempt_work is the same as tlob_busy_work, isn't it? Do we n=
eed
them both? Cannot you just have a hog in the test and keep using the same
function?

...

> +
> +=09do {
> +=09=09if (strcmp(mode, "sleep") =3D=3D 0)
> +=09=09=09tlob_sleep_work(200);
> +=09=09else if (strcmp(mode, "preempt") =3D=3D 0)
> +=09=09=09tlob_preempt_work(200);
> +=09=09else
> +=09=09=09tlob_busy_work(200 * 1000000UL);

The only difference I see is that you multiply by 1000000UL here for busy a=
nd
in the function for preempt.
Cannot we make them all consistent (call with 200 and do the math inside)?


> diff --git
> a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> new file mode 100644
> index 000000000000..1ac3db6ca7bb
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test tlob monitor uprobe binding (visible in monitor
> file, removable, duplicate rejected)
> +# requires: tlob:monitor
> +
> +RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
> +UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
> +TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
> +[ -x "$UPROBE_TARGET" ] || exit_unsupported
> +[ -x "$TLOB_SYM" ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || exit_unsupported

If those aren't ready, the build system didn't work, I don't think we need =
to
check here, it's just a clear error.

> +TLOB_MONITOR=3Dmonitors/tlob/monitor
> +
> +busy_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work
> 2>/dev/null)
> +stop_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET"
> tlob_busy_work_done 2>/dev/null)
> +[ -n "$busy_offset" ] || exit_unsupported
> +[ -n "$stop_offset" ] || exit_unsupported

Kind of the same here, the rest of the test should probably fail (EINVAL in=
 the
monitor or whatever). The script will print everything with set -x and it
should be clear what was missing.

> +command -v chrt=C2=A0=C2=A0=C2=A0 > /dev/null || exit_unsupported
> +command -v taskset > /dev/null || exit_unsupported

Not sure how common it is not to have those, but this is exactly what the
:program under requires: is for (see rv_wwnr_printk with stress-ng).

Thanks,
Gabriele

