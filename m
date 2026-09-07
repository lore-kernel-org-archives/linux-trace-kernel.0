Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45D4AA3EC
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785072; cv=none; b=pA63i7ult2nFc7PeSkeo3z0NY/b/6Aue+SCVoOnYX4ns6NEl38TWM7OO6K42H8qJvGzktXgdfKi9Z6q/JjKX3ifVrj3nZU8Bt4/n4Pe9W+p9Ylazlpj0mj+/VwS9OPVrdHg3O6X7byqyoniWlG5GjvNOZ3Ef8B9tX68Otdq56rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785072; c=relaxed/simple;
	bh=cb82owCkyv9eTPiidRl7fi6WjoARbD7uipyHalof+Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/xU70PvqLACpaxu4QaI2I09XewJpKH7eRqt7SiappjmG//+jcFfyJxcPobwlItwNeWUYt7IRNjbUl8kKaDPHUF94foju9FypNkeyeogDQ0i8o5drxEecCTZVJDA931VzIDHzck14kRPTbR+mq53I5+CvFoGNgfIgSlU/ArCYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5MH1luQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5MH1luQ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6f9e2f681so38115595ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788785067; x=1789389867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zuer2L8ZOWoXDvEIlrCmYHiy2ZHwREenfR+tvGUOzvo=;
        b=G5MH1luQBuvpmQq98E+OXwWHLRy38tJUUbPs4gcqgt7E9h1PQotS+vnyTuTYogNliX
         SLP5MyHl5hzLkY2g5PV0jdl9HkIvK+RUNr3UeqXhIZefGJRYpaXQhGwalm3dQNNnpfUk
         1lDZYG0jY2Q4ErQdCO1ynXnFW9rQK8MW0kGTAaK+G/KOVO3DQ9v+Erlm+s+XfLH4LIC/
         d8HYgisxzbeKPxXJzFhByv474iyGgErbhsTAxFf/ucOstIbtRc4z8yrKvrQmf3/S/G+i
         KACK774JlxfQnOYmzvroFWN9kBbIiIFdqLg+zzUTf4dxlpusHi/0UjtNmMQUtbHKg4xN
         VTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785067; x=1789389867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zuer2L8ZOWoXDvEIlrCmYHiy2ZHwREenfR+tvGUOzvo=;
        b=qG5n5qu8Nz/g6/hq8xQQnYuQ5tvoZP0YNU84juXDy7lhHIshKc58HJtC/fkQEosas5
         dtMRZQ+IPQB73yd8NnFCljA2Agm4k8cXGYmMfHmF6ZG13o1ZR4OS5Rmm13hbNXOErAK3
         d0Qbo1sWQw/AJ3FHTTp+QmZT+R7MJe4YIaTI1cZMtYGH3gB/83iz+SX9chk/3hzSOUUs
         sp7gP2BwNYz2AE0TlOKhVxxxyRSUseBD9LY93HX6FhTwS56MTNtTcpGSJRjmfUuYfoWw
         4Fgdr8ArRw2SBQm5arJ6EUpT0rnWI+O3nZKAUmaQ9EdD1sLNh9Q8VVC1rpNqoM/nOTEr
         Rw+w==
X-Forwarded-Encrypted: i=1; AKwUvBzZI7raCESYnCUxOmpY23DkswmmM2PQAah7Nr77dUDRV4vrK8xQd1mqEBnxkVrJb5stdyR8x4Z2IC4DF0WxgI//tRI=@vger.kernel.org
X-Gm-Message-State: AFuF++nozPPgneUTrTWF9LGoPs8ptE5c31U/aJHBzo2Toyma70/enE0v
	0wiNHCmeuX1tshWsMTIEfRIHFzxfl9adYQtVwj43hF6+Jq7I4joqz00=
X-Gm-Gg: AYBFou2PonfNsCr9ndt1t2SUnjEazP4JMReVeIHr5hM28ZbGgeLKReHZVhdQVh68Qgr
	qZShculEcv8TZBkvlSM0Ht+i7lhFHxLON48tzhtklSDviSQ8PGn7XXbU3Pzu0nQ2sESM6ksK5lS
	J66Q/R+BQ0kdWhMvcAcLnbG8XvPcyQyc4Bc6fCSHTdxMq6XxCA3uTd5AyWL5zpYCQJTvKox5xea
	yAYGMXeFH9xPBhP/qFZ3Pf0PjveaMVM5AYhktiF/Rj9ObXrYxbuN5xdpyf/gPNpAB0PjOtvORJJ
	Lk8K4WQ0fLtVB8vOS2YiqeufYC6lJcKBJ20s9mRkrKOuuzweEYKM8ZD5R7TQWN2K4F6YM+Yj6uA
	+i2S94lu4whzjBadR/olZf8Hrzq+gYJl/Dc/cOmPDShDhbdWtuh+TIAEKqiXrvG50hmHnFHb/d1
	qaGZCRe0xB725t+zG0nMExuMI/T4dYXOii5uWQ5VGCeIorFudWn0znDwlIfK7P0o4RVyj+OhNFM
	xUayFlnQO6ZnHyU
X-Received: by 2002:a17:903:22d0:b0:2d8:d4ce:7e40 with SMTP id d9443c01a7336-2db12674f20mr322398945ad.21.1788785066605;
        Mon, 07 Sep 2026 05:44:26 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm45350955ad.63.2026.09.07.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:44:24 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH 0/2] tracing: hist: two named trigger error paths that free a published trigger
Date: Mon,  7 Sep 2026 21:44:18 +0900
Message-ID: <20260907124420.607097-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both of these were pointed out on the list against an unrelated hist
patch [1], and both are the same shape as commit 6f86bdeab633 ("tracing:
Fix bad hist from corrupting named_triggers list"): a trigger that is on
the global named_triggers list gets freed without being taken off it, and
the next lookup by name reads the freed object.

Link: https://lore.kernel.org/linux-trace-kernel/20260907092944.3950E1F00A3D@smtp.kernel.org/ [1]

Patch 1 is the init path. event_hist_trigger_named_init() saves the
trigger under the name before it takes the reference that can fail, and
does not undo the save.

Patch 2 is the enable path, the one case that fix did not reach.
hist_trigger_enable() removes the trigger from file->triggers on
failure, which is the only handle hist_unregister_trigger() has, so the
->free() that unlinks it never runs. Leaving it on the list lets the
existing unregister do the whole unwind, which also stops out_free from
touching a hist_data that hist_register_trigger() already destroyed.

The two are independent and can be taken separately.

Reproduced on x86_64 under KASAN_INLINE by making the two failures fire
from a debug knob, since neither is reachable without an allocation
failure or an event that refuses to register. Same kernel and initramfs
either way, one boot per case:

                                        v7.3-rc2        patched
  control, no injected failure          clean           clean
  1) nested init fails                  KASAN           clean
  2) enable fails, new named trigger    KASAN           clean
  3) enable fails, shared histogram     KASAN + panic   clean

Case 3 reports in remove_hist_vars() rather than find_named_trigger(),
from the out_free fall-through described in patch 2.

After each injected failure the same name is written again and is
accepted on the patched kernel, so the trigger really did leave the list;
on v7.3-rc2 case 2 rejects it.

selftests/ftrace test.d/trigger before and after: 45 results, identical
item by item (32 passed, 3 failed, 2 unresolved, 8 unsupported). The
failures and the unresolved results are there without the patches too.

Donggeun Yoo (2):
  tracing: hist: take the reference before publishing the named trigger
  tracing: hist: undo the registration when enabling the trigger fails

 kernel/trace/trace_events_hist.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.53.0

