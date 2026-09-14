Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B68340406
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 05:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364091; cv=none; b=WlSal/tMB6cRs86Ic+/1MZzYwR+pizrS/uhGbHTvN/6GOOdzkZ6OJzQBwSntt8GXyUIS6J0ml7aRKdUVCj6s1Xr1E7zEP0DaUehqu6jQKM/F2KhjjquVdswMrHKhLbNuWErRU2e7ZmvSgn5YQ8FbJAHJfnyNxthxD4MMKMeQkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364091; c=relaxed/simple;
	bh=FvMeJcmBq/R7Uy846ybStaYRlnVQJ8ZO9c4JhmyCb0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGd96DJnh4Xc8PZQRsujZ57Um3irAk4faGrS6GoYEzuTkxNNkqi9MsE8V0JXpC0sIjrzJ2VU78OBKAyNYAqxt4snE3n+KkCntLjJ1xSv3VWqG+Oe0QuUQFaEVEUsyYODlvOVdKDuC6f+vroktPLAEbn6dZMjyQ20ZJoiLDwrOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbPm/TEg; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbPm/TEg"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304833so1176727a12.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 22:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364089; x=1789968889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5GnWfqWZgBiK8079dLN80U4da/Fpan5HG30rEA7OC1E=;
        b=JbPm/TEg7FCyo8YfU6RqqWgZd4dHMQRzyOFAXOUSRGYjg4feRSJx4BWn/LDz2/hhgV
         VokSRRm9Fiqcq5f6tdwKpzlyAcDx+L01j9KIhuSjfdtr+6YbQTwzTVLnQdgL+RNBY3eY
         j+gv0A2yv9u/ASkMYIzYIasCIiymo2z52jpVGLLrrF2c0K6WQOCgL0MoyqYi9bj5u7ZG
         KTVj1iJEZZJIPWcGHoMsKPrcHdQP8Z3B52szRcvNc0xoW+0E6SkLK9T+qMFibCp7gu8O
         7WqhwAjKxSQwDDpfB0CWBXFZ5tAOkVLCjCwVksu+MPjvbvDXDx1RLNPwtD+Ii4SWNHkv
         yWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364089; x=1789968889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5GnWfqWZgBiK8079dLN80U4da/Fpan5HG30rEA7OC1E=;
        b=oBM5ViphUopLKWc3KmSkJLx7/mCg7bDBz/mL1x7r9isF432+vIWuhiQmud1Visurj+
         lstZYCKccN7Zobp+Nx/1WI4msIbHICZPByM6G/t3JqlIh7yt7QXgeOXtbaBov4RU0W/O
         H6WOuR2ZrARNcCx8wQt0H1Lnggj3sntn7ksFdqkMohDQ5djzmjC8UcDSmJGs5l5NqB0R
         kL16SwXpeh8nutEtQsjhgjkogz9rl558y4UQ+L7ETQTrEUcTE5z51fGSsSgsuUuATEDG
         dGMJKo7U08NsenK4yYBe1cyk5IBlGkdPbNFKLvM4RLsu66lZ4vVaLa2eSZ3HV2QmTj/5
         bmOA==
X-Forwarded-Encrypted: i=1; AKwUvBy/EDEx9pu3umWzRzXz1y9L1hKirSMxB3uw+GfIyYTFVONLWfg5mMbbsk8vwf/cti7CbCE0lNTQ4Ceiwhl42sbaz3k=@vger.kernel.org
X-Gm-Message-State: AFuF++ktHbkyDFIrVDtE+mY1XJxIhYol1MON5zgCBv/CLVCepqDFZ6mZ
	mvlsnylc/5JAGTgEM2MDJEfZzZnWuxuvDRp970c/pt2ztxk+1U4QGns=
X-Gm-Gg: AYBFou3AxtlhJy1OhbhgzY+VgoYF9jx8rzQ9eFsekgLekuJqL6gq5A2bw+cgQhZw2WM
	gtW6Q8oazBl6paquf8a2JwmHCMxR23Ny3KrMKekQYyqi6ARotuJT7x3Vo4/3dEdfI8bh5ASwQYY
	CKMmBg8p4bdOt5GwrIgvPxx/MEqE9+5hSn3LjWwG9/qAjZo4r7K64+gkcN4QQRpJnEh0T+Az8Bs
	AgdBKO4tV55LP8hWCwDlKCrxIhnct6JES8sQBcxxItLmOAVUVDmkn5mqV80+536mfxZ0WiPkY81
	mzrYx94nu0RSwO+Xyg5cWUaapwooP31e1y2rM8K60qzEBEeXh1dsd2i5EITv6MaiPuqsehkBqzx
	oEvriLgN8nwvO7eKDkKbKxK/mp89Mbm6UCx8yHbfxDdTA9JbsjHH7FHsuPO1wf/a01/trBf1eYx
	mvDpLrV/CXMgR3jFL23AEWbZqKAHoC1WmuLP7MXlFWZXFFKk41bLhMI1/nCAxLLGDaOCPNTHwDG
	VIKNOzYa/Zs4NqMmB0hqsTsubpH
X-Received: by 2002:a17:90b:510f:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-39debf6f2cfmr2349092a91.5.1789364089328;
        Sun, 13 Sep 2026 22:34:49 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3b80:bc61:4619:5346])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm19009261a91.8.2026.09.13.22.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 22:34:48 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH v3 0/4] tracing: Fix NULL dereference when copying keys for a field variable
Date: Mon, 14 Sep 2026 14:34:39 +0900
Message-ID: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
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
key.  4/4 renders the key with expr_field_str() instead.  The three before
it make that renderer produce something parse_field() accepts.

Link: https://lore.kernel.org/linux-trace-kernel/20260913203129.941270-1-donggeunyoo.kernel@gmail.com/

Changes since v2:
 - Rebased onto v7.3-rc4.  v2 was built on 2f0c1cf72f46, before the tracing
   fixes merged, and that turns out to matter -- see the next entry.
 - Reinstated the stacktrace patch, now 3/4.  v2 dropped it after measuring
   that common_stacktrace.stacktrace parsed fine.  That was true of
   2f0c1cf72f46 and is no longer true: a5e70ba87ca8 now refuses the
   modifier unless the field is a real one with FILTER_STACKTRACE, so
   without 3/4 a common_stacktrace key renders into a command that is
   rejected.
 - 1/4 is new: hist_field_print() prints the bucket size with %ld, so a
   size above LONG_MAX reads back negative.  Reported by sashiko-bot.
 - 2/4 uses %lu for the same reason.

Patches 1/4 through 3/4 have no effect on their own -- nothing reaches
expr_field_str() with a bucketed or stacktrace field until 4/4 renders keys
with it -- but each is needed before 4/4, and in this order no bisection
point regresses.

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
  common_stacktrace       oops        keys=common_stacktrace
  hitcount                oops        keys=hitcount

Unpatched, the .log2 and .buckets rows drop their modifier, so the
generated histogram does not bucket the way the one it mirrors does.  Each
oops is a null-ptr-deref at create_field_var_hist+0x771, taken in its own
boot; the three real-field rows run the same loop to completion without
faulting, so the six are the loop reaching the faulting line rather than a
boot failure.

And the bucket size a key can carry, read back from the trigger:

  .buckets=                     unpatched                patched
  0                             rejected                 rejected
  -5                            rejected                 rejected
  18446744073709551616          rejected                 rejected
  9223372036854775807           9223372036854775807      9223372036854775807
  9223372036854775808           -9223372036854775808     9223372036854775808
  18446744073709551615          -1                       18446744073709551615

x86_64 under QEMU, CONFIG_KASAN=y, 4 CPUs, base 704340f1cd0d.  A compatible
histogram on sched_waking keyed on WK, an onmatch() target on sched_switch
keyed on SK, my_synth($wakeup_lat,prio) forcing a field variable.

Donggeun Yoo (4):
  tracing: Print the bucket size as unsigned
  tracing: Add the bucket size to expr_field_str()
  tracing: Only report the stacktrace modifier on a real field
  tracing: Fix NULL dereference when copying keys for a field variable

 kernel/trace/trace_events_hist.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.53.0

