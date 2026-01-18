Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08361DE8AF
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768699107; cv=none; b=nMXIBvD17u65GtzaILzc4CNdFRrL3UIatJUvxKdtIi+n/m6C7e20vhR/7GLrRZmAwHWJNLjelSzNM3MwENn5rTlc5xxtbH0jAmA0ugJs0mW2M2PdMXASsXRNuOwHto72cU+zurTqTQoZ2teLOPw4yBKWFO/czwK6LCB253Qymec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768699107; c=relaxed/simple;
	bh=dfSf90CX2fFuCBXs9FEXQJWwoweCuaJmCw5t3YHWiD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyOYes6xyhHGmrwDqhC36Rc9kpA56l3V9I+e+OF+Sv5zv+8uubxOS/dD8MCioPLgA0+oyl8cVczv7H1OJqmIJA2QcnmMDzJNZx3xUbyOt6SwUJ0OQg+AblFIUqI124he7b6zgH0FkrOIwR8spRFdJ280NSzS5XW0GWc8hIEBGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2a/e9nS; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2a/e9nS"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c59bce68a1so210257185a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Jan 2026 17:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768699104; x=1769303904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=h2a/e9nSut3T9bIWO0kthXjxhHwLDoDsmipbNksu8DHVIoxaPmx9oofgNhIjBqenQl
         dN+zDz603mq1S5dRHk8TMWrQ58Yymi9I5Qg8XpYN8DQhJCGc+4P9J5Sbt4CxAZnnKmEe
         PALtArlPAxHrQl0EUIwpENv82N3XHuxSvHzwTq5oohi45dVQuzG5Ssd1MQGru4i/MNUH
         /xMYDjglX8ayPeTRkQQbw19LvdrfYAPcS23LTrgCIoyjxJEXOaYljMyhm/tFBk1aLTky
         lPw/raTGziaDUJuoP7aaxzrGXlXrabwPCTcKO71qMMPY2Q09+RrmxFkP6J4V3AYfuc7G
         4AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768699104; x=1769303904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=g0iBG/K2R8M+Waf6HXVRpaB6N8KwBQfnTxOdG8+Ip3q/XHUz4YP90sOFh7PLEFk1WJ
         u8eB/f3iSBfYOnqPZX657Au9uaA8qkn07pgb/T79FiGB27isowmdTHeLx5JqDmhaNZnZ
         tlFLJGpMTrQkZ49YqSvY7CNk7xYRxVhwLzTQT0K2kC6G3GofxlwsFNffB2w+fLuhiPkC
         a7F13CjAsckd7i8hqWJR2hK3O2444oJ5uUMmNnL2X6kpB6m5iHUFLP+hcqb4lix7y1ZV
         AOZ2cL93dF0mDHbgW731LHtzf8xxdRfkiLEzeJ3NaK2PR2ek5fHARAm5mGaIOLbK6FhM
         VuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7U09HTafyVeP1EF2r7G3Xm5tdQoMk6v8x5+1qecfE4Wv0wwpHzgaOQag02jatljR2tVwGk4fWzbHoKhl6PUkVkaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehEBVJIweL4p6Onv5tWg9bso+x5LMTEY/Na6SfCwkEDjb+CiD
	4wnn6I2an018CwMiv9MPW1ZTUl76asZso6boTww6VeZtdExdGuNEJPgG
X-Gm-Gg: AY/fxX4BK5a17VyPO1B/TJyklx3DUWolE2bchgSsi2IGD0oIIWTm0SO0V79l+P5VDEz
	5jVIHMj7lLx4QvFiSNmB8ms8GmKf+Ej3ua6B7i6dKkhSt5EjDizHh9okSXeye5USa2FVJh/mN1I
	UKiz7779cSc1j8syGs59r8xcaluQXf6Js0fDNDBW7/wadZ/tR0WlMpaPTpaYVIt4R3EGM0z3kN0
	ptHzNVSboKp1igI4py1EONuawUAF4POQ0ZepCPlnlvfYsTE2BZfazbwWNDUm0XTrmTBQg79R4np
	JuuOgK0Ia5m05EsyRLwrdRsI1XaOFnq/mKE1OzI3VNnMpWHKn9uyiLCEKk0S+S3aPN3Q1VGxJED
	Iv1x1Q0fbTfMEUJ1t16AYRrH3dL9YE+PX6wIuUf6Kccva3Jbz7QSkIOu2BFConWO2PgsKefY91X
	JqduY4q6VmuRsv431sa+rX01Zs8qyGxoTWrVmq1ByNfX4PiJYu1t/XTpEigFrDRqsNKMCa1ns=
X-Received: by 2002:a05:620a:7082:b0:8c5:3881:da8e with SMTP id af79cd13be357-8c6a67b0933mr1054464285a.65.1768699103670;
        Sat, 17 Jan 2026 17:18:23 -0800 (PST)
Received: from pc.tail882856.ts.net ([2600:4041:4491:2000:8a64:ec6b:4:f1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72642fdsm512290285a.46.2026.01.17.17.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:18:22 -0800 (PST)
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
Subject: [PATCH v5 v5 1/3] docs: tracing/fprobe: Document list filters and :entry/:exit
Date: Sat, 17 Jan 2026 20:18:13 -0500
Message-ID: <20260118011815.56516-2-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
References: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update fprobe event documentation to describe comma-separated symbol lists,
exclusions, and explicit suffixes.

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 Documentation/trace/fprobetrace.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index b4c2ca3d02c1..bbcfd57f0005 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -25,14 +25,18 @@ Synopsis of fprobe-events
 -------------------------
 ::
 
-  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
-  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
+  f[:[GRP1/][EVENT1]] SYM[%return] [FETCHARGS]		    : Single function
+  f[:[GRP1/][EVENT1]] SYM[,[!]SYM[,...]][:entry|:exit] [FETCHARGS] :Multiple
+  function
   t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
 
  GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
  GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
  EVENT1         : Event name for fprobe. If omitted, the event name is
-                  "SYM__entry" or "SYM__exit".
+		  - For a single literal symbol, the event name is
+		    "SYM__entry" or "SYM__exit".
+		  - For a *list or any wildcard*, an explicit [GRP1/][EVENT1] is
+		    required; otherwise the parser rejects it.
  EVENT2         : Event name for tprobe. If omitted, the event name is
                   the same as "TRACEPOINT", but if the "TRACEPOINT" starts
                   with a digit character, "_TRACEPOINT" is used.
@@ -40,6 +44,13 @@ Synopsis of fprobe-events
                   can be probed simultaneously, or 0 for the default value
                   as defined in Documentation/trace/fprobe.rst
 
+ SYM		: Function name or comma-separated list of symbols.
+		  - SYM prefixed with "!" are exclusions.
+		  - ":entry" suffix means it probes entry of given symbols
+		    (default)
+		  - ":exit" suffix means it probes exit of given symbols.
+		  - "%return" suffix means it probes exit of SYM (single
+		    symbol).
  FETCHARGS      : Arguments. Each probe can have up to 128 args.
   ARG           : Fetch "ARG" function argument using BTF (only for function
                   entry or tracepoint.) (\*1)
-- 
2.43.0

