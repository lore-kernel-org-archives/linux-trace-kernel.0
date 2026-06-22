Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A96364926
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120403; cv=none; b=cJ7dOqMZLgy7xiwS9LtF7VMuFTCnIjH2L8Sz4W/Ooe2i9auXjdfhCDoNcqHwKSlMpnovNIHre0P7v0Uokb+itVqIa4tc3I8Uv8FFoOJpza93KV5kyLlfMo1b+kiYmBSFeageKuZc8F3smVSLHFSjV/29M9chsRwUg6//XtvJa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120403; c=relaxed/simple;
	bh=XwiK4aT8lWDT1jeeawaWhLy7AtVJHNu9SxyjPBsiVec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3Vq0/9bSAWVEEelRoU54XpOnAqgmLy0U57N57Y8mUiDOq4Uou//kACZhRmvHIsEYetPwy76fv7bv9KAqCQ9+yozXodddP/CO2Mu0Eou3TBrMOdDkUrJ5q2R5eNEpWKumY2M+akhpt/p/YKA9f4UA28ROMHyjyhXXhu6wByUAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrNrgx+A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrNrgx+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782120401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPSpdYrFZMq0jaqI7D+GegMkXQWh8n4YYw9/3Dn/tQk=;
	b=PrNrgx+AR4cJVTwXut5MaAd42NbXz589hftetmaTPvktKU2iGhkmuhgr3BjoQdErpnYH/V
	1ugMEnhATSD8iLuXR9XwIvDaCOalegotf748g3xXi4vQGx8fORY7zH7ooayzyQqjYWX3EH
	nXKCo9vrTdB21+XoeoJSUuyXRE/jr20=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-N5SbXGfGOhmTzhV82zAptQ-1; Mon, 22 Jun 2026 05:26:40 -0400
X-MC-Unique: N5SbXGfGOhmTzhV82zAptQ-1
X-Mimecast-MFC-AGG-ID: N5SbXGfGOhmTzhV82zAptQ_1782120399
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4923d2f0dedso15981225e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 02:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782120399; x=1782725199;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lxJZaHJqq3JLhs8WTyThOEkpx9pQImBFkOjkr1hHfk=;
        b=MBUtj/LgE1g6QWNbbTH/dn/CiJr0QRZUdv9WR6uqqCXk3Ogti5qz7yxUr+6cQtAxgg
         9ntw6IvAo96u4gwCjE6JzVrTVQ+HpUZK3uQ71Kv2CdwSUaA+16PbAs0sdlSSIM5iZXDY
         /HoCs4Mf78c9vACG1uiQvdpSQlL0erzBt2V+jdmu7yHTiNd99m/r20c7+32qeB1lsTH5
         sdbgKvCI5XXkjCOUT6qy99AL3YtvoBYv2eFYmOufLr9ealHaZXvLEcJ6tdgbIn4AeXOv
         wf2ouEUeEWhPQ13JYnDxgtY7f+eKuAkr67J3heSbRgzjqLVlNiS58jLm0q/FLfymQS3d
         htUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QgEtA4RzWI2uPYgatAFH7Z8mXttjcGEdvgKvRfNSgLbm80OwjHTna5cTq1GbMmq/VHs3fbC/WOzT2LIjEGZTbz6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjrmCm0Ll9d2O0l27l+yof4a1Lap02MgeCyUAilw8qzhjCGXU
	O/ULYh1I1Ipdn4fq3A6DG3U/r7dkXBOd3cnr4Gs0AX9ukg9EfkiVEeX06UmIhBPvceaId4b9R3E
	egnLhTMUg3xPYb6vPHud1QCdaMduqCpJebmKRNEpNNm0m6Tk5QAdYpSB5ry9la7Fbyb69cHTxYA
	==
X-Gm-Gg: AfdE7ckirC7GhHDWlalNcWaUn5dmu8ETQRyChbLcYtdSG9ajn5WRLUljPZhHpm1tO1Z
	Vww+h5AI3G875mh9igIZxpZWPrsclZy4PB90EC+Ur5nkoUXeKqMzf89cpqXU9tO4zf6kv5CrhM7
	mwNNeyr7ns/vnhoA+jl5CwmOM05vbjtP+DVgWOI0DpmXl+6SG+Secge0+GXaUrI9lsTXSPmoGQd
	Zzsw1ajnmiA3rPEjbzeeFRxXSWVch9LNB08PDC6dn6UBDc3yJp7XzntjnBAKFViPpGakSVzHzNx
	jXW3dtb73XWx82Rr8spM1fMZdImPr+6IDrA3mn1AEyy0pebOVPocCl21ONL4dS2elnEwEfM+VqG
	YZX/Y2HijdN3Ncpo=
X-Received: by 2002:a05:600c:c3cc:20b0:492:4363:e7d6 with SMTP id 5b1f17b1804b1-4924363e904mr131158415e9.37.1782120399050;
        Mon, 22 Jun 2026 02:26:39 -0700 (PDT)
X-Received: by 2002:a05:600c:c3cc:20b0:492:4363:e7d6 with SMTP id 5b1f17b1804b1-4924363e904mr131158065e9.37.1782120398551;
        Mon, 22 Jun 2026 02:26:38 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm25162038f8f.29.2026.06.22.02.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:26:38 -0700 (PDT)
Message-ID: <d80e2960a63bc12e51b0359092d6f6e78ac8d872.camel@redhat.com>
Subject: Re: [PATCH v3 9/9] selftests/verification: add tlob selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Jun 2026 11:26:37 +0200
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
X-Mimecast-MFC-PROC-ID: g6bwyuUjQGusx3pecTTJ7-2cjbNrRBB94qQoAmjEsiA_1782120399
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> +grep -qE "^p ${UPROBE_TARGET}:0x[0-9a-f]+ 0x[0-9a-f]+ threshold=3D[0-
> 9]+$" "$TLOB_MONITOR"
> +grep -q "threshold=3D5000000000" "$TLOB_MONITOR"
> +
> +! echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset}
> threshold=3D9999000" > "$TLOB_MONITOR" 2>/dev/null
> +
> +echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR"
> +! grep -q "^p .*:0x${busy_offset#0x} " "$TLOB_MONITOR"
...
> +! grep -q "error_env_tlob" /sys/kernel/tracing/trace

There is a widespread misconception under selftests that ! cmd with set -e
fails if the command succeeds, so you can use it to expect a program failur=
e.

That isn't the case though [1], errexit (what set -e does), skips commands =
starting
with ! where the result isn't checked.
Essentially if you want to say exit if the command succeeds, you can do:

  cmd && exit 1 # explicit
  ! cmd || exit 1 # explicit

or still exploiting errexit

  cmd && false
  ! cmd || false

I'm going to fix it in existing selftests using the last variant, but keep
this in mind in your selftests as well. (Variants with ! are preferred beca=
use
they also return 0 if cmd fails, as you'd expect, I personally prefer to us=
e
false instead of explicit exit, but that's up to you).

Thanks,
Gabriele

[1] - https://www.shellcheck.net/wiki/SC2251

> +echo 0 > monitors/tlob/enable
> +echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo > /sys/kernel/tracing/trace
> diff --git
> a/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.t
> c
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.t
> c
> new file mode 100644
> index 000000000000..d210d9c3a92d
> --- /dev/null
> +++
> b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.t
> c
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test tlob monitor budget violation (error_env_tlob
> and detail_env_tlob fire with correct fields)
> +# requires: tlob:monitor
> +
> +RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
> +UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
> +TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
> +[ -x "$UPROBE_TARGET" ] || exit_unsupported
> +[ -x "$TLOB_SYM" ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || exit_unsupported
> +TLOB_MONITOR=3Dmonitors/tlob/monitor
> +
> +busy_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work
> 2>/dev/null)
> +stop_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET"
> tlob_busy_work_done 2>/dev/null)
> +[ -n "$busy_offset" ] || exit_unsupported
> +[ -n "$stop_offset" ] || exit_unsupported
> +
> +"$UPROBE_TARGET" 30000 &
> +busy_pid=3D$!
> +sleep 0.05
> +
> +echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 1 > /sys/kernel/tracing/tracing_on
> +echo 1 > monitors/tlob/enable
> +echo > /sys/kernel/tracing/trace
> +
> +# 10 =C2=B5s budget - fires almost immediately; task is busy-spinning on=
-
> CPU.
> +echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset}
> threshold=3D10000" > "$TLOB_MONITOR"
> +
> +# wait up to 2 s for detail_env_tlob
> +found=3D0; i=3D0
> +while [ "$i" -lt 20 ]; do
> +=09sleep 0.1
> +=09grep -q "detail_env_tlob" /sys/kernel/tracing/trace && {
> found=3D1; break; }
> +=09i=3D$((i+1))
> +done
> +
> +echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR"
> 2>/dev/null
> +kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null
> || true
> +echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
> +echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
> +echo 0 > monitors/tlob/enable
> +
> +[ "$found" =3D "1" ]
> +
> +# error_env_tlob must carry the clk_elapsed environment field.
> +# The event label is "budget_exceeded" when detected by the hrtimer
> callback,
> +# or the triggering sched event name when detected by the constraint
> path on a
> +# preemption that races with the timer (common on PREEMPT_RT / VM).=C2=
=A0
> Both are
> +# valid detections; check the env field instead of the label.
> +grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -
> q "clk_elapsed=3D"
> +
> +# detail_env_tlob must have all five fields with the correct
> threshold
> +line=3D$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
> +echo "$line" | grep -q "pid=3D"
> +echo "$line" | grep -q "threshold_ns=3D10000"
> +echo "$line" | grep -q "running_ns=3D"
> +echo "$line" | grep -q "waiting_ns=3D"
> +echo "$line" | grep -q "sleeping_ns=3D"
> +
> +# Busy-spin keeps the task on-CPU: running_ns must exceed
> sleeping_ns.
> +running=3D$(echo "$line" | sed 's/.*running_ns=3D\([0-9]*\).*/\1/')
> +sleeping=3D$(echo "$line" | sed 's/.*sleeping_ns=3D\([0-9]*\).*/\1/')
> +[ "$running" -gt "$sleeping" ]
> +
> +echo > /sys/kernel/tracing/trace

