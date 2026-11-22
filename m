Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307729;
	b=YsXtEkmfRMv8Lgas/AoyK6ePE8udnJ/qtD8GQSudNNOmeAw4yJj+xOiADnJnGqtdSLr3
	 AUeZ7mHMFRxTYsmvhUJdD6J8jvBbMPaOytYNwSaT7XYG9DttrNzGKrihBJt6NjHTU5mLV
	 Y9qlYEHNLnKX9noi/jPeUqyUgJvk/5Kr0Ln0xlZaTcvUKEdUqKNPEr0lR+9khx521546s
	 sPjIGfnKafGhiCGA9PERs9WafUPdoJ5LlitmiKL+kdqGMT4l8ik51YBhzsIHL6KlqBpRG
	 d45/KHbD5+BhengHBkeJDxNFPKnpvQHgoqms8qc6xDuOdJqqqtQxttz6mLZ45BZOmAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vM/cLB4eCrMAsNuNkWJWKaL5gaOt79aLQHiWti0evIY=;
	b=YM3DhpLg/OWMfzQhzUvWKVEGFcjzcQZQvvzs1Utk0OSqgeHpOknOzmJITMbC4Nn3/QRh
	 m+mOGI+CcgXg6EMMVdMFwGtMhxexbZCEeh/mKiNZBGoUzAE4kCnn6IqwT0uKeJvLusdpn
	 GzTj2SaqegHvmX3dncoV10cT9jTKN317DNALcrJRBCAnVGDxQh2QDDx6Evy5D9tpi3Q1/
	 BxZ+08wtDbi4trCKCOzdKEG26nrqaDx2SXqdWGXEHHrc3Y+uVLaj/+ZuUQCP7Dqu329H/
	 NftwQvDWcbIKX48W8fIpGAip3d6yc1KHDVX1n1lpzhetw6RiHefMavI6oaYzTsHzmzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k5CYNhra;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FF606A32C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 00:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C60FF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k5CYNhra
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so16051765e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 16:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795307727; x=1795912527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vM/cLB4eCrMAsNuNkWJWKaL5gaOt79aLQHiWti0evIY=;
        b=k5CYNhraKUKLi9HWXDqHXgnEKwTBsZF7ULkOhIDcmGfXN/XCVOku1674JOdezQgrDA
         xvaV/PxPTCI7aNeZ3YzsECnXeAaENvpFXJwE+NOQYWh6MKnlRFIEoQXL2TLRYFkQFeUv
         P5wji9OxeGSIoWBV5BU/7ZJYjnsjqB1DgnA9F82/JqJJrcczXJE62IlaSgI6lgaR7q/Y
         LSInneN0MHl+2vVg0MxAfgJI2qX8q1MIIlyvWNqrJyL71/b5AX5ogzPM7aDcmTbqNzAo
         KmAF7hJK/q5+tgNtUb8AoQmXhNW2OjbuZFwxZHZFEBcKIatSQkgRye1yFvd4d5LZPpIj
         aBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795307727; x=1795912527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vM/cLB4eCrMAsNuNkWJWKaL5gaOt79aLQHiWti0evIY=;
        b=QbyV1jnvjGKAdO/NHayfwZH2A1/6OJa3ZUToxCJmq4tWbGFuYgF8v2W7BsLGaxVCOG
         j54EXc4NkKBfFF9WoO6wArgWRvnFONEqK3BHTE3tzgZxLTV5DUy9jns+/5jskQvNwunP
         it/mqaOMiEI635S/IFYheKTw6nDTFoqoeHe1c1evoXMxWdzi1rv+R8mPKa8WKOtaPklE
         bA+8x9uw3gJkb1IZJ81wCfPud8ggdBBf93gx6FURpnHGlvXjbLnoYCxiFT5w6TKJO5Pj
         drxNmv69Eqo8a0o0a49HTpXML/9iM5Vt4XMc2sRT58pnVI/Jfm0t1/Pi9ehvhfwnY08s
         JYvA==
X-Forwarded-Encrypted: i=1; AL+hErGt9rFc7Z2RRIlWPtkGLtoaRUDxrkFUK/vDEBGmmMY2hIwbDiOw/DfayehCkHT+FgT7xDO1ewNY14g2c+emU14Wb2Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FjACpM85hk27WRQjZZnR2s3VO5D46pCNrxwInk5xDew5bUH51
	m/brG2/wGUSSMqdx+HG44KCPoBjAVTOttAQYNQid9QU8Q71YkFQc44jl
X-Gm-Gg: AZFdTZeiMCdaST192BTiMispl5k6Yioi9TPalTRzDQOsLEs5aeUZO2USASu9logvNAF
	ZI9uKJPYsonSK3yyi+FkpJx7vG1fAf2pyckszyiCFEYuW5DNbvXHbzPCKS/Jq7xrXn6rGHhYBTT
	3K8WZEty2GZ7E6YYQtQhd+NqCvKUpWoO4n8yANpRWEq+xwVifY5ItSpyU8R8s2uPUWugYgjLFNk
	FdASVFksZVsbpBk4H5cSKnbQJRs6u0g89AjKZDpqefxEFcPBQBjA/VcgHhM4hir2xGrSDH9nnLH
	hOIYv4sZ3gO7T0FooStVHxKzisedhK18+eu/5a89BlCx5yjkq4+jq2AzRsahrHGwpzMjkuBDxHg
	nLoYAHoNIBIsUgHXW82kbkexV0fuUEOuBE7n+02ftAXnwVrgjDZ/e56ee2xYn/wBktuDmQ1K/oo
	tf6UknIol5K4AaTEdsqZS/qAJaSqrPkq9r1v19SpCvD/Ar/a/qu0tG+sjND/Bfyr3zl7oc3Eann
	yxaEeiDgQ/pEl2BUU6Thu/fo8MPVa7xPNJPJvoX/ia7F2blkUPReOO127p2OakLP+7x3WxNnRKP
	QS2BFuwoI63MFLkTRenm2fUqPUEimxDcpjuknZ97b+w8PpghQ45hIVFTD/haDy0ZaeCNaB01tX6
	UvAgrC4ydp/h1t1PwtqZJqPLfIgcT8C81x23vBx1t9/ldi3uQE9ACRKHc77RE3hYk3Nb/gZUc1b
	A6KJLpQDE5K3VtXEcA6Pz6AnBv5UOvq02WfRzjt7cnNYa6QR/EdrWov4oHs3KGdSBS2AqC4vldM
	b7D/AWO5UGdF9ypuBzTUQjggFrjCVMO9TvQCb8=
X-Received: by 2002:a05:600c:468c:b0:4bb:6d61:af7c with SMTP id 5b1f17b1804b1-4bb88944bf5mr153159635e9.35.1795307727094;
        Sat, 21 Nov 2026 16:35:27 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-2025-a95f-1d53-595d.rev.sfr.net. [2a02:8434:fda5:4201:2025:a95f:1d53:595d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm74017825e9.5.2026.11.21.16.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:35:26 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/bootconfig: Preserve all-f tracing CPU masks on export
Date: Sun, 22 Nov 2026 01:34:59 +0100
Message-ID: <80d300fad70b4168e2355e8aef73baaef68e49a5.1795307698.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795307698.git.edumucelli@gmail.com>
References: <cover.1795307698.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ftrace2bconf.sh skips tracing_cpumask values consisting only of f
digits. For example, on a four-CPU system this drops the mask f. If the
mask is subsequently narrowed to 3, replaying the export cannot restore
tracing on all four CPUs because the configuration has no cpumask entry.

Always emit the observed mask as one quoted bootconfig value so a replay
can restore it.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
 tools/bootconfig/scripts/ftrace2bconf.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index c23e7cc8a..6d7a1bd68 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -278,9 +278,7 @@ instance_options() { # [instance-name]
 		emit_kv $PREFIX.alloc_snapshot
 	fi
 	val=`cat $INSTANCE/tracing_cpumask`
-	if [ `echo $val | sed -e s/f//g`x != x ]; then
-		emit_kv $PREFIX.cpumask = "\"$val\""
-	fi
+	emit_kv $PREFIX.cpumask = "\"$val\""
 	val=`cat $INSTANCE/tracing_on`
 	if [ "$val" = "0" ]; then
 		emit_kv $PREFIX.tracing_on = 0
-- 
2.53.0

