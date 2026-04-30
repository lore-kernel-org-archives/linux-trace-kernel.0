Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14FF402B82
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560126; cv=none; b=TBrWtdqf8V5PRR16Q4xNY69twzXKG+I0317BAdJWI8dutwcztXDSmfnKGKqWEG/xuVKZEZZSSLpTFvORbiNUol0FzhzHdKKU4AwyZkQcCrEf13TkVd3+0ydO6+j6qlJpDLMqT6xr/1ZEtdQ2oRhthnSRz3NjqChOUrFV0qdQmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560126; c=relaxed/simple;
	bh=VTg9pQ21A/M7oN0Q9FOF6H4e6thUrhmh44K67qTqYjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcLrsGueMFOXGLWtb5EB3x+PFhz7J+5tzifwJ151iOJ+ATZDrwU4x55kr7Sos4ZWDf5Dhi4WjdZUM4TmQdxXCb+FW1B0Yv/lPcsU9V3fZVq5AaHaIZTjvbHA7GTHshV5Kkn1Dwnfw7PEBwqIH+L0p3KXb+kdxEQlHxfXX8VD65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay6UOrYW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay6UOrYW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso21101015e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777560123; x=1778164923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRgXd8fDwM7hDkydv0/5o7xbaYUy7EeXbwemVcULL+8=;
        b=ay6UOrYWKkHtlwO3KQ4rOqMCQ2QUvDPKViiAK+Io4TN/qFyxi7ZoyEyYn8Rokgtu22
         R046Bav7cAfIJW7rQpuvxGcM+OGFo2NMWb3XZjOpz4Eii1BqyjT5IQFnkkRBOGiDee78
         ghFYlrMWv9G8PJgJT8sqtN+bnAf+BNzF3//WwvfI/6ldmpFXul0dar5L2qSPem5fhaBR
         jKAoer1jHmUz5dgie0fF3lndAN0RyNhFgqnyJD0YReOOgqL6YyxaM5Z5TsZ37NoEbj8L
         Ka7Nr0XEiMaFcsEGxtPACIl0IEcgi2n+FqkP4DLUBcui5HJFEuSZYEVzWDk59NxMGkTS
         c0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777560123; x=1778164923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cRgXd8fDwM7hDkydv0/5o7xbaYUy7EeXbwemVcULL+8=;
        b=HyS1CTzy/4ilI51Acayw+nfXr+ZheCoZF9CPOiP7HUSI2BcaBEI8q8YEwoFkT2DjhQ
         tR+qJzGNJHcHY92YS6xqWlUnGPgDVcx8Vhdwwsywg9qIVgMc88CIqdawCfyZXj+d2zj7
         nytW+viLf8wdMx/lxmRYOnKpK+rCqb8/06vH/8JE9V/HlXbEh7nbtR515QvuwTdTmrk3
         mS8B35c+OIboew8i/vAX0R3DtlHquuDrIc3S7mE9+fBM5EmCdLiQdB461KSToCALEakE
         3aZa72aXeymnIYatti/v3PXwjozBbqGxL0zmr1f8Dw40TxfPwvbtZ9IZjJCNCNFzTVv6
         vIkw==
X-Gm-Message-State: AOJu0YxtG/0E61KVybChf3Xq1lG70P8tEZj77FpdkkIEPTz4RD+y1f0V
	B7mRm8ZhsflBBzdtRLjg/bbaxUomcYliiRpmMabjjyP7Uc/ImlJhISdA9CGSbNE9syE=
X-Gm-Gg: AeBDievu9tQA16OPgGB5FBKnBGMiYkR19US/piyACclEqsKilAl2qUBjepnQslFiYgg
	aHsiby8SOK3mgKB7DnrZY3L1STf7KrwcvU7HcMmRqU9Z+7tt3NfAVKAufvfd5qh80fRXnjrpIEC
	4QXasf5eOYr/uvtssVhf+LilTfZXdvEE00PSnGgMPtPZUl/YyBbqiKxl8jr6Y3I9j3iQ7wizUwL
	UFrGuGOxpcGKRBnTbzuSZZH8X2XZ8R8STBY0xAhSgG0oFkYA8hs64+WN984dLgMwHVi3huB9UFL
	MSMMQjr+AvBGBS+j5/dn3NPWv1OlvEmCEzHZ02NVvj6iVVTOdH0xx1OIYXYjRLY5agkd5H0HIN9
	uVDwMiJ/gf8qeAk8zBY+Vc7snESKftoHUpd8SratRx3/vYd3Z4KjY1DzS0m5cu2/dUF7aSncmBT
	CRxkDrOroBukyZZBaix7UhVuYNuTxgdsyx+5MGbVVaajSzp1lxkApUYtmmU3q80DQLRpQWpIiyd
	QA1C1dFAwYToFjWlvXPBg==
X-Received: by 2002:a05:600c:3e8e:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a86069e04mr42051775e9.9.1777560122746;
        Thu, 30 Apr 2026 07:42:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c3161a6sm40960015e9.23.2026.04.30.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:42:02 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	peterz@infradead.org,
	vineeth@bitbyteword.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] tracepoint: add lockdep rcu_is_watching() check to trace_##name##_enabled()
Date: Thu, 30 Apr 2026 15:41:59 +0100
Message-ID: <20260430144159.10985-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430053511.8767-1-devnexen@gmail.com>
References: <20260430053511.8767-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_call__##name() was added by commit 677a3d82b640 ("tracepoint: Add
trace_call__##name() API") for callers that already gate on
trace_##name##_enabled(), letting them skip the redundant
static_branch_unlikely() re-evaluation. The LOCKDEP rcu_is_watching()
WARN_ONCE() that trace_##name() carries on the disabled path was not
mirrored, so the cold-path coverage added by commit c2679254b9c9
("tracing: Make tracepoint lockdep check actually test something") is
lost for trace_call__##name() callers when the tracepoint is disabled.

When the tracepoint is enabled, the rcu_dereference inside
__DO_TRACE_CALL() already trips under PROVE_RCU, so the warning is
only needed on the !enabled path. The natural place is the gate that
trace_call__##name() callers consult: trace_##name##_enabled().

Fixes: 677a3d82b640 ("tracepoint: Add trace_call__##name() API")
Cc: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/linux/tracepoint.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 578e520b6ee6..3b3ab19c2627 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -293,6 +293,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline bool						\
 	trace_##name##_enabled(void)					\
 	{								\
+		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
+			WARN_ONCE(!rcu_is_watching(),			\
+				  "RCU not watching for tracepoint");	\
+		}							\
 		return static_branch_unlikely(&__tracepoint_##name.key);\
 	}
 
-- 
2.53.0

