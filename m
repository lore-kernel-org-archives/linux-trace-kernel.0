Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817F3128D7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182475; cv=none; b=BA3zwlz6uWmx8YJ8MBd1HEvalhVPx9fsm3z94EIqyw8eQvUbAzmQJ3uJ2ClpfBEWBTTuVRXozuznsvGof0YVkmu/CH0IxXKbRcyL2Jow4ewq7+U1d/pcHBdK83qz88Mx+I4smX4F9uH9XjTvBNZd+CylClqaaegmLIodT01GCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182475; c=relaxed/simple;
	bh=i23uuyAGDdzSRsmj/cUkhrMZq9aQGUA4+8iGZcYIbXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tM7vs3kbIn8/XENRLQuj6zwtHLsa+cStRPlIfyIeMIWwfpB3kFUWdTZk0AGMf88zHJP4KlMYyp4Olf9G/YlUFCZEzI/tYQ3S9QfB2ubNorN1rFxTD0rNKXOhABDGxmY9C5tsW1423NmOgbXslE6vaZDg90mx7i/TarDb3yTcLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUxRBjs5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUxRBjs5"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88244d1559eso12205346d6.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 10:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764182473; x=1764787273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pL+BNJLCWGjhg/T7ReR52wEfwLq1p/DJmaJjs1qnoVo=;
        b=HUxRBjs5rM+E31gjKodm3rhQRKKQo0DdpjMIHp+p2mOQ06SY4lcTfqll5pAtqHmh+s
         qg8pQAFRZm/ujPq2H4/3kZLHdLucGNoATTLXm6S+QIdmWeUkRTBBFExAL0wQAnD3DS9e
         Y8ErfPSAHgakOrUwFSp1djTVDjB23N18HawYqZyS2eQCBvEMBHCLlnkb6TnFr82zSix2
         WWvavkoBpIcyomylTBuu0stNsjI1ExasBBOD/CP/j7a3MQ3Zweh4bRi25CkGdlTNoFfA
         urFhIMlck47NtpL0CPX5QXO8gQHxf9EKnOefk6uCJ2+I62GhoXa2t2V8O1bdvLdXXur7
         CyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764182473; x=1764787273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL+BNJLCWGjhg/T7ReR52wEfwLq1p/DJmaJjs1qnoVo=;
        b=LqIYEihsRY2U7wLkVNBzHICVfxe3mTXjpjgfJ27cQ1qs1YStcXVXyT+/xpcfvm3WL2
         nb/0Xw0AaGo1zAs6uL4f2oPLlikncMQsMvlFEtkmMWCuj8HGVhCfwdDiLUChsIqH4/87
         wa7T0lJxm5lPTLmvklam9gJSRa3AqF+MWC3xYlSa1XxGz1+oFciVPF5RgBiA9EVMSO0y
         h8MIo/wJKqcjMW3SiWNcrPDjPv2rFJQpIyXrXSoykCRDxJ/5mEXy7DCJRvPK65O4jdfD
         /NwCQg2qyVsfgACAwgjpm0S+a8fKnLwt122zitP9zVgsJwspjn1/sy7qHCprLFG9LD5d
         RlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF5ed2eJlDMjShKPZJ7b86/BDHOF4EKHFINnizqM30mi9NTExRVih8IktZxsanO2JpszaoCr79R+wJIZRrBlnN5kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMAyxa4u1h3nUGw5a+5u+ACtYboOruldU5MEpoE4+Uo+7OC8S
	BVEJ15lvgdew96n8LZwXETqgRr2fgqf8aJb4vYJgQFflWe8AuYP6SUJT
X-Gm-Gg: ASbGncvd3U2lp7SflvWHvT2Kw3Qviz4w34a3bcFpU4Lhb6kWxI2V+SP+Ne5F03kjMoT
	fnrzCuWKu3hCiQb2JtVIzn5mDdzHUmIaYc24X97wQUFO/L/rfJJLgYCqgM2VQbSLvkE/5fdPgh1
	X7lwZmFL2R+VcTe7rcKgHZjWCJswMRKI8iwRDwqTg2K1L712DyhLJTYEGkbr9859OgmV4L5CjIF
	i0MAaNOyYmASpv16jGRyL9ysfndOxMag7wzoxGaIXWE5gCgLmAV0ELVfsJr1FJ7fWLpl8B7xGCY
	j5vWzP7piEJS8SxGn3UcVk5nqqaP+tWBZh31y7eakqsWI4mOtrEEvyLeXvjXrY9i4J6DOJmrbM1
	f//SKQdAHmxScNF0qLnvr/MppfWGwGYhoAok2tUY8/QCmcc4JB311Fxsul/bPSER9ZGGfLYk4+/
	r8lYzM663hkWydQ0SR5mhQfH/b1rUZXJK0r1nK5o65C3YkiHF9zIYLoavVlsaU3kXSNrIvOFTr
X-Google-Smtp-Source: AGHT+IEHMh2eH6r4vuI+wSTnrrZC7V0tb2D683WfXr+VMa3P9wT14HS3nFOcOhfoANcpVL7LdtkX3Q==
X-Received: by 2002:a05:6214:20cc:b0:880:3eb3:3b0a with SMTP id 6a1803df08f44-88470080384mr407156846d6.4.1764182472895;
        Wed, 26 Nov 2025 10:41:12 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:9820:e89a:8e2a:90ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e445b1csm149919506d6.9.2025.11.26.10.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:41:12 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v4 0/3] Support comma-separated symbols and :entry/:exit
Date: Wed, 26 Nov 2025 13:41:07 -0500
Message-ID: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend fprobe to support list-style filters and explicit entry/exit suffixes.
Currentyl, fprobe only supports a single symbol (or wildcard) per event.
This patch allows users to specify a comma-separated list of symbols.

New Syntax:
- f:[GRP/][EVENT] func1,func2,func3:entry
- f:[GRP/][EVENT] func1,func2,func3:exit

Logic changes:
- Refactor parsing logic into 'parse_fprobe_spec'
- Support '!' prefix for exclusion
- Disable BTF lookup ('ctx->funcname = NULL') when a list or wildcard is used,
  as a single function signature cannot apply to multiple functions.
- Reject legacy '%return' suffix when used with lists or wildcards
- Update tracefs/README

Testing:
Verified on x86_64 via QEMU. Checked registration of lists, exclusions, and
explicit suffixes. Verified rejection of invalid syntax including trailing
commas and mixed legacy/new syntax.

Seokwoo Chung (Ryan) (3):
  docs: tracing/fprobe: Document list filters and :entry/:exit
  tracing/fprobe: Support comma-separated symbols and :entry/:exit
  selftests/ftrace: Add accept cases for fprobe list syntax

Changes in v4:
- Added validation to reject trailing commas (empty tokens) in symbol lists
- Added vaildation to reject mixed of list syntax with %return suffix
- Refactored parse_fprobe_spec to user __free(kfree) for automatic memory
  cleanup
- Removed the now-unused parse_symbol_and_return function to avoid compiler
  warnings.
- Tigtened %return detection to ensure it only matches as a strict suffix, not a
  substring
- Link to v3: https://lore.kernel.org/lkml/20250904103219.f4937968362bfff1ecd3f004@kernel.org/

 Documentation/trace/fprobetrace.rst           |  17 +-
 kernel/trace/trace.c                          |   3 +-
 kernel/trace/trace_fprobe.c                   | 209 ++++++++++++++----
 .../ftrace/test.d/dynevent/fprobe_list.tc     |  92 ++++++++
 4 files changed, 269 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc

-- 
2.43.0

