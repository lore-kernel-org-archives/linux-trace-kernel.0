Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6572F0661
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331498; cv=none; b=UPjOHiUdOPgANHyQ4COHQdgLZq/hwA7velbS8FVUpgzmRdhq7LMfzZZCkihMI1rALBnxmHAyJUCrGxYG09PRFYpHcm7cjpkO75VtmB1Cqz/iJq7F5GTKnAyl3OJ4Rtqwf02U3JDVOF0zbKD9nEqUMLKFV+7KGtWsnpKhqMyq2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331498; c=relaxed/simple;
	bh=yDn7QK/ba+3RLVHPMTBb8o7wMnI8vkCF4rNDGAc/jgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNF1CajSCuG6LWlojRt+wV/gMECKK6ez/5GcJTlBbuiiekBibGzuD2v+Y2cqXUL3xe1Rqv8IF+YJUU82xtvXHu2Ivx4tgg4YoWOlyZgYVBgl3bSCYIwFKHi32fTVXlVKEj5ocVKIeDDSW+aCvi/NvPF8epW1RwnklOMTLx07R2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg1MKUOP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg1MKUOP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso2099397a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331497; x=1789936297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6LszAmsFoGsrZf03eXVx9RZkN93lj99VFwvSyBMy7+c=;
        b=dg1MKUOPm/Jf/HEBRknTTsIHbkbEzm8H3MerCbHX9gG88ZTZ4d5Bp0y1/SAyGnUYzJ
         sdnIHukSRgxQSoqHcRLpN7dV9+AmKFIaXk/D3dEPVTDWfuQTFHQqK+XhPvDA4zv41SAL
         yMqlr44N7s99jWBrv7+5Gv7t8qz8BaebtCutfZex5BDWpT60EbibbfpYW3+hqsAxY6SQ
         iJmxvqBcTEsGicSREc1L5mL1yIm+FJYviyod36tyrSy3Yiuy+Tt0dU3QirCFQAhrEaFL
         8tqCC1f/gCQmUEzRBV/ZC7wd6C3HgZJMwda0PmRtD4uDMXp/kLbDEchaE+sRaU0WFE/o
         4VFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331497; x=1789936297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6LszAmsFoGsrZf03eXVx9RZkN93lj99VFwvSyBMy7+c=;
        b=k9mJuv+GMG4ilADWiqCp3yu2kjyC0Sf2H7z6AV4VopcPfGP2n/T38P4BCx/pjk8sb7
         z676yYNK6fc2oyLgeqLojVaCwzm7dDx4AOsSh/cCKZw5yJPMhyVXAKumlRxIFxtB77Oi
         G0cxaHPmbZGRL/YZCvrBf9b3Rp7qjlFz9fjBlJr1fptUtfL7wSsbQ1uaE5X6HUcVf1Us
         7RJ86yS2MIeaazDu+kv627Cl+b6tuFXUe1vV1clqQSbLQqgSqxJgqf7qFe2/yc/alfTd
         OiQHavhT6h+UqNd0NTcN2NY7wgWhsR1OdyVRGcoYksArse4OvwYDMP77XFOaRCxg4oaE
         Re2Q==
X-Forwarded-Encrypted: i=1; AKwUvByX2jHhmuO9ow+4zx+xejHIBCADFGOJ0iQXg186ARRAiNqXj5nC7Z9idOalkypFRMg1TcKTPhHt1a3mXvv5cmKrJe4=@vger.kernel.org
X-Gm-Message-State: AFuF++kPDZ30V/4nVG2oy7H0DCiST2w75mE8bgKnGyD9NNccQx3fopTk
	dNmwjBA0sw7ZglVg9SoNygEH209V+U4Po3xxSDBAsvhrjyPEZoeCpM4=
X-Gm-Gg: AYBFou20MsN9D0AHkUzdQ10Dxp4zaFDfa20GjoTXZs6SiG3J/yLg72lXDJ61AhJPi4u
	gwz0/ykjlf8Zpp78sa50rYvPIonZuVCAumusFyuZEimYHhS3J6SpppDRcCYIDOTDMeeVOteDTKm
	1tbsQHbyVOg1OUWRkdumCE30iBMX7d0X78OlKrK4KGxo1j0drep4o7t7yNstM4pXbYEC5ky9Zfm
	L9w8LaSChC2WgjXm+BsS1sAQYhn0BIbs52+TSvh7xzeFSow9foMqOVKiV8CyHSMewGMJCHgtBFx
	wp1Z35IFibFP9SUC0kZPImfm6X5fSpHpcmbN3nNBysP6E9lwASo9kbMrVGxO22v9g13Z1U5ZIXp
	tC6xLCKm5l3+l/47fcJI/MjsXlTXuLqhYJYfCIYhzwZSj4HePilg1f+5hHimQ9Ud4k/LREf+43V
	IX2glhr+rCrzaeXhKyLF3NrAv9Is8VJrKBsuxs/OIk7P2ZKkPuUbXWazA6XGDMTtwbYooAvMx+U
	A2pjRwMsSmr0oP5uir7o0tkx2yKU/5Yf8kE
X-Received: by 2002:a17:90b:51c8:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-39d9bbc802bmr24389520a91.3.1789331496799;
        Sun, 13 Sep 2026 13:31:36 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm17530220a91.0.2026.09.13.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:31:36 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH v2 0/2] tracing: Fix NULL dereference when copying keys for a field variable
Date: Mon, 14 Sep 2026 05:31:27 +0900
Message-ID: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A hist trigger with an onmatch() action copies the key list of the
compatible histogram it finds on the matched event.  Reading each key's
name straight out of key_field->field->name faults on any pseudo-field
key.  2/2 renders the key with expr_field_str() instead; 1/2 teaches that
renderer to emit a bucket count, which 2/2 needs before it can use it.

Link: https://lore.kernel.org/linux-trace-kernel/20260912094722.3271147-1-donggeunyoo.kernel@gmail.com/

Changes since v1:
 - Split the single patch in two.
 - Dropped the third change, which gated the ".stacktrace" arm of
   get_hist_field_flags() on hist_field->field.  It fixes nothing:
   hist_field_print() excludes FL_STACKTRACE before it ever calls
   get_hist_field_flags(), and parse_field() takes the "stacktrace"
   modifier on any field.  Measured with and without it: identical
   generated command on all nine key kinds below.
 - 1/2 is not separable from 2/2.  .buckets is refused on a value, so no
   expression can reach expr_field_str() with a bucketed field, and 2/2
   alone turns a working .buckets key into a refused one.  In this order
   no bisection point regresses.

The command create_field_var_hist() generates, for each kind of key the
copied histogram can carry:

  WK key                  unpatched   patched
  pid                     keys=pid    keys=pid
  pid.log2                keys=pid    keys=pid.log2
  pid.buckets=10          keys=pid    keys=pid.buckets=10
  common_cpu              oops        keys=common_cpu
  common_comm             oops        keys=common_comm
  common_timestamp        oops        keys=common_timestamp
  common_timestamp.usecs  oops        keys=common_timestamp.usecs
  common_stacktrace       oops        keys=common_stacktrace.stacktrace
  hitcount                oops        keys=hitcount

x86_64 under QEMU, CONFIG_KASAN=y, 4 CPUs, base 2f0c1cf72f46.  A compatible
histogram on sched_waking keyed on WK, an onmatch() target on sched_switch
keyed on SK, my_synth($wakeup_lat,prio) forcing a field variable.

Donggeun Yoo (2):
  tracing: Add the bucket size to expr_field_str()
  tracing: Fix NULL dereference when copying keys for a field variable

 kernel/trace/trace_events_hist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.53.0

