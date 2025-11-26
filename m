Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA03128CA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182495; cv=none; b=uHxI8jzPNzyitDQNzxLYyKVLm0bw04XktRHmC9cyI4SkhTK9/C05PeRtzyJpO81Je1Ni0XXMQDI7jVLSDuybxNc8DDQ6EyGmJUOwryZX5ZubvJWpCmFKIECpI8WKHnGGrAUY3AB1OrJ/BUE8NnzY8lR3vcaz9RprdZM2RbJz5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182495; c=relaxed/simple;
	bh=dfSf90CX2fFuCBXs9FEXQJWwoweCuaJmCw5t3YHWiD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NocIZ0gtQFnsXCl+N94Bdr+Wlt9gOIcXR0uhPAFPfHtvnMxtN0KsWgCOWz7HFnXqj2f1LgNo51YnHx0ObMOcwXw0+rnEy7E8orBfi9bqzMpSbQaNCscP6aeQ7+8ZQQTUbS09sTmtfNPzu8aBZRXFXB5NYtCmWpT6JL/O8T595nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjfPpbkw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjfPpbkw"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2f2c5ec36so4775885a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 10:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764182491; x=1764787291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=gjfPpbkwOlrreZCEjmzJFa/R/wub4LdHPIMHP/DljKl/gh+tnk7nnaB71CB6MpaU0I
         WQhT89k71G8Ii2kHFy33z0IyZ/o8pNH0lzrIB5LwsrLLN/Ib5Sem/1wkkxRbHYqRIfkY
         Gmn3/lAqaV9UPMIJmLJSp3D7+bmrkls/by8LN/hYp4bVZy2vie66Jf9xaPzQtYwnTvgU
         EIWGbzPtvfmbbTXyB8UJhumiBvQm2tS03GZ2oqR6otnuKC75YWO7zRMp9Pth+UZvyBHj
         8sf3zW/t2NYUA3+8zL0ZFS4++Px4JvxoNYjtI5sZXuLiCzkBPXJ2x1lkjtuKanDygwCN
         28VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764182491; x=1764787291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=E3oieUuZ62K428bAAm6s/XbMggrJ5gSsrQRQzIdjkkxrxtiSVtc2i+clwjXbhbS2qX
         xTxZKnmI8yYpV7BqLAj+olbw10Ip3YeersYOAN4QtdsCbstzSwtVSzGXVIjmSOHHJmvv
         PdZt2sk7pvdx8T/8iBkKaYrMYbUA69BboRJJX5Q1keXhOWbsk2cg68sdmzPpBH5OFEne
         Oeth0cU0o6wnSoNTfQzWpf9mIp6f3PDSCgEi2LVhgBMumk4qM9vGnr2ycfgC9OgZW1ue
         nMIJuVP75xyrO644+kykBzurW77Mz1n/TPUIW87U3ncjzR6ZLq5D/1Cxsn8HOEuHVrx/
         Dgpw==
X-Forwarded-Encrypted: i=1; AJvYcCXuPbP7LaunKAr+YK9N+p7LuRWzKgo+/XqlXr8F7A2YNcOr3VgKxoaTEqAuJfnxP6dJtRDh6AeV/IIhzrxNJ0RHJGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+QJIOiBe6Z1Oj19LcycGsLdTnPlh1v3SLRzsMZwAyly5G9Fp
	5XooMtrtThN6/KYFS0JC7amYgQDEal53mXMciZCqdhSCgARMOOUsut59
X-Gm-Gg: ASbGncvfgs5WwOI52MQJk4FozzcwpKkCUCURsBYb5h/p/ggBPKELZ6Q8094n/VWFXNF
	d8Qc9skWXzQb4RQ4IwUORCjsvEDu1/c5mXgK6u8S7UF7MK/sQ0krYfb0oEyp1ptlzggZiYFUXyS
	ANU6DSYO0Zs6kksYMafPkj8K56RWfSgfeG/2uqghbdfhlPH+8XXgtJhxuBUg7jb1DaJVUJuuVQM
	7VtLtG2i4kueBm0iSpkptWMGSWrm5PTCJNoFFacgSCoduJ+bLLseoNSVCSS5dG8FjrXuJbSqz/V
	6UqxJanuv1jyyVt+SDa47wCT9yb2GGni/tmrvpiJXKsF89YoZbcBCZ5Ucv5u8VCpk96XLcbr51K
	Vtd8crfWNOS1cInskicI9nYzdvjHaOySy4A8+68L3+ksm62paELOJTIz+jNJg2qTyTV+ZekZ97n
	bVPFfNCfMCRFfVKQbYtAcO3dpkj5FKt6XrQc9ky7fSToncY4hDfi+eeADv7Bk6FM9BE453qf5s
X-Google-Smtp-Source: AGHT+IHqQ4vHalOGeJgi5wHcgOQIKhyE2K/ufYLvIbCrYdKKtu2YqgKcr53BfJEZTMvq2GMt0PmGbw==
X-Received: by 2002:a05:620a:1a9f:b0:890:62b7:5ae2 with SMTP id af79cd13be357-8b33d4cfacdmr2481832785a.46.1764182490954;
        Wed, 26 Nov 2025 10:41:30 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:9820:e89a:8e2a:90ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e445b1csm149919506d6.9.2025.11.26.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:41:30 -0800 (PST)
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
Subject: [PATCH v4 1/3] docs: tracing/fprobe: Document list filters and :entry/:exit
Date: Wed, 26 Nov 2025 13:41:08 -0500
Message-ID: <20251126184110.72241-2-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
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

