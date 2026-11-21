Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260734;
	b=ZbZkcwHFrZfhTuspdzr5hgFLJL5zOD/ZEJ3+maUX0/NP8eQkiCQPwNgKEBGQT8OGeWQ1
	 zJmBdgeE9PgC8SmKp8uMDSh6DShgHmG5nNQgLcD8usAcff7txEeRutQcYB1yqK/2N8BAR
	 dvmlGDwoxM6F5Ka5M1a3eVpQ85b1MOq0plKTl0X87vD+y9sykBeQ9ziR9QLzUX6d84B0G
	 LHRrSzPI89CnN7rUOzDlNapcObTDuQFrR0/ouyE8WcQMKKU7U4lNGxufy2RShqnl4XWnE
	 ruTdpSecat/mYedSmG2cJkN85MBXJHVVabA2mnJTS+GbayTK7fzN05lRFWa0qO0Fzsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eReobK1M/4MSKVVNxfhKdJx4Lmw1aJcPP01j44uODU0=;
	b=CXEFzRBl1fR7JJMmmhfzsj7OKDc12TrcCfcphAmlvFSgOA6rYPFrMt5Vz4UIxUv2kHCR
	 yoniIXgpCnNRGrG/2KJ8vu1GY2jYo2O6nsrSQWSDz5EnA9aKonc3JHy7Lg0tGPuxKDlBl
	 BPlWv850itZxMVlzX/KeWDtH59T4owQRP9HWEbuBeR3ipOaEUn8VeF59F90fHhOCf1mHP
	 4gF7YornFtBtDztQprC2qqlUjRqCRQ9xFpaLvkLIR05z4/zaoWbZSOMc88oAj/klz1vki
	 iAP0hAKnSVC7yzhiC11z0UInjkDChm02+LRgkOrcb6DDxx0WMusA6PgBSbzlAg18/cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Hk85h/gy";
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8644606A325
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 11:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8644606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hk85h/gy
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so1786076a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 03:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260733; x=1795865533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eReobK1M/4MSKVVNxfhKdJx4Lmw1aJcPP01j44uODU0=;
        b=Hk85h/gywmD+mYbWlOQCBAKntNEl7TzJiiWWSQOQdan3JY4s5yzfxEryCNe9/rg/Lu
         zMr+0BjRrnEwfhRrpEZhBu87WBgbFLEuse9gLwhJoixUx1Bz+KqBia4xOTCkUZgL0L+g
         SW0cBAUS1xcf53dHN5FVs2r7QT0aqVYFfLrdahxefIQY8jz49alISdi/EY227XsSpQ8d
         tfjydyOEo3Bq3i2zicGZyTKSSaaDU+VRpJJJ2YLW0ntFXCwBhDFumGSbtFH/b4Cm480F
         bdWgLMHVpU75FG2mXCzV0tn23Svc/uUd0FnovbSAi+5y4qIH0lGaZ9P1K/kHVU3ndl0T
         u5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260733; x=1795865533;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eReobK1M/4MSKVVNxfhKdJx4Lmw1aJcPP01j44uODU0=;
        b=VPkeyUsh25s+3X6mfIf70EL1shfCIzv7RtO3diaYlJ8deq05O8i6KMUutoyROWD2ty
         icA+e2NLtzVRx0VEvw1XSEBHlHy/f2Rcn6nEplsbMFAagcLvSdd8HCMBDAevpvCfSQPQ
         tvAD5ByAo8ys0mB4oROVf2t0ZEhQYYgzsTz3q7mAau2+6LLh0sa5OQA0KPO2QXdwQzX0
         P9dcZX7E4Wwg/976RJXv4oRHID8owvWbhZaXWjaGGaC3mP88CZOJwBwuSS0SG11Jodtk
         JlLuMc85BkJUlQibl1wMwq0ZoaR1cGPuMHSjiIMBBENwQoT8n0vOmfLwEndSbPEC5lqK
         LxdQ==
X-Gm-Message-State: APuU4Z9BZ/TrerGfXELL7GOMU9QqGihz41jqE0tQkjVx8GgrDYPthYqx
	JeV6UjJV4q+oYijeQGngaVWSbFfnJR9qAj4e8ESCKzr8oZP3l15XFqqJ
X-Gm-Gg: AZFdTZcw+mFuupD6mH7qWfOzHyU82l2VNP9YeIYO47/MZTiq+IZ/9xfa2hu/Mnaurem
	vgxl5hJz3B56eukCvAph3Fsb7nbb+DzwRp4bLTnMkOr+h1kDXwWEdnf9aBFfWA6WlXyZjVBdDjF
	ER+PaH/Qv1Sp9lkJoza5KOsE0i7Q/K4Eo3z/GKn1dXRhbl5bk17owIW2nNSIL/FLhGtD3IR2Gn0
	Y0RPcCWl0tJ8cq7gWR5iOgt1ls4z80JZRQCXkOBEnnUy22YeoqrVPOSN8ejJG8Qb/Ch/C2uPR90
	qUvOIOfLvzGuMLWuG/BPwp4P0ar7FZXQzLzhmhDeYeGK1bsCRByaR5daxzUbVReEfsfkEkxUfPn
	GS+75O5BuYC1XeqoegrjcIkntX9J7OB81ScV406U+1kMw+dmSe/FdhKAqHv90mP3VYW4SLlJfoK
	Dex30+3nYi0vJPkfsuuLym6Tbm3vkMZzoWeFCNDgS4YRmcEqJgrFQWmxxtqlh/b3q4V2EbRq2gs
	hfORaMWsnb6vouUgPc/l0dmrYwlOO7Ecph9guGdIjR3SwaKQXexkglEZqsytAPdo5NVepOXKIRV
	jAwv7wGD8YYvfi6+cqcSsctEPFC5j8Zm45ZFdZMHUQ==
X-Received: by 2002:a17:90b:4a48:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3b41c7b5fb3mr5850701a91.1.1795260733085;
        Sat, 21 Nov 2026 03:32:13 -0800 (PST)
Received: from [127.0.1.1] ([220.196.193.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm8322610a91.2.2026.11.21.03.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:32:12 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] verification/rvgen: Cover an invalid monitor type
Date: Sat, 21 Nov 2026 19:31:27 +0800
Message-ID: <0d9350979dc4cf67e8aed1171b74b9f6e56f6b52.1795252297.git.chaosheng.qu.linux@gmail.com>
In-Reply-To: <cover.1795252297.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795252297.git.chaosheng.qu.linux@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add a rejection test next to the other ones, so the new check is
exercised.  Without the check the command exits 0 and leaves a generated
tree behind, so the test fails on both the exit code and the message.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 tools/verification/rvgen/tests/rvgen_monitor.t | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/verification/rvgen/tests/rvgen_monitor.t b/tools/verification/rvgen/tests/rvgen_monitor.t
index 5f2562600..2a48a7b54 100644
--- a/tools/verification/rvgen/tests/rvgen_monitor.t
+++ b/tools/verification/rvgen/tests/rvgen_monitor.t
@@ -64,6 +64,10 @@ check "invalid monitor class" \
 	"$RVGEN monitor -c invalid -s tests/specs/test_da.dot -t per_cpu" 1 \
 	"Unknown monitor class" "Traceback (most recent call last)"
 
+check "invalid monitor type" \
+	"$RVGEN monitor -c da -s tests/specs/test_da.dot -t invalid" 2 \
+	"invalid choice: 'invalid'" "Traceback (most recent call last)"
+
 check "missing dot file" \
 	"$RVGEN monitor -c da -s tests/specs/nonexistent.dot -t per_cpu" 1 \
 	"No such file or directory" "Traceback (most recent call last)"
-- 
2.43.0


