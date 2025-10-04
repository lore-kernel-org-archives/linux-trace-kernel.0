Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C42550A3
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621836; cv=none; b=sr447H7aKhhR9ayh8W5ZZ8XhVg72wW+y94+ItykRTjBdJ3Y7QCD0LMTRVAaUEzN3k27P5JImH4PxaQLcmGYwe/oskauZYfZa0NTEolegpjdHezZHDUi3z0w39d/P0v+dkbPk5dPw8qUyQibuIpggA7RM5zcnlzibpBUZj6U5N+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621836; c=relaxed/simple;
	bh=z2ogZjxuTKMpoCR+MQb93w82gXJuW+Rka1YSqoLx4LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvYmesS04L5IVuUGF+y/j0GEcMb6aoGIz3wys/aAljd77yqwIXen8KGNnm5N68Z40fq7FfECk/gqGT08bG0vnVZwNz9zTRukv/EOsHNttUY3gE8CpTvbL5mW3zGeeKiTanMH1Vzjm4a5UaVYVDGrriR1nNnXtPmG3CdFDTv/rTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPemoOJA; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPemoOJA"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-80ff41475cdso49680586d6.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 04 Oct 2025 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621833; x=1760226633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZrEnyLevXoIcXltBXj1n0pXN58lCz/lcC/iI5a2jGg=;
        b=FPemoOJAyHihAj7y/qFgGq20d3xX6mgGMln21Jd3Qp0yV+wgtHI4M2DR1/2AsAPLbm
         hFMsBpLNXg01/z5srVi2CFWrhu3lNOLPI54yGb0yUMqP10IqjFFPIMYfx4EX5suLrcRs
         YkUQpOWmrn9toPbYvwuIavPJVuXtXpMAAgjwtEAtivi3sS/xdLMZb9XBFxQ4pxEHtfhZ
         eU2tptPMhKoSg/G6UiZaM17FuKKd9VWisXtUHfqoVScn09R4hGqUIEw4RErCNV/x+4MT
         1QG72udVg+yUC27R2D+weDAE1tbSXbQigXpVOCHH1jIyUwoDTMb7S9TfAGaYiVk/SFhS
         uiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621833; x=1760226633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZrEnyLevXoIcXltBXj1n0pXN58lCz/lcC/iI5a2jGg=;
        b=lE+gK1FDer4MH07qWCdWLhoCOh35UGlxalV7z80Ju87Dx0RtGuVBOraqP6+em6kKC/
         k2OKedNPkiainBZQy8H7rwBySxY/n2OH3HKu+pJlInZ0ddpuS97aMKObQxsA6xlHNFpR
         peFweBXsH2QT07DgVyxuMUSNVtGZ/AA5XpfyacmzlMpYIdxDQIbviLAR0u0IoHKbowp3
         pJpOTxV/wou3DvoBzqEeMrwy+y5ZANHyGsRgk/ywqk+VC+1FlAbWaXZZAdAlHojLNiM+
         aSnyV1Jd9M8SjKp/kzYP19DdSCLRpsJktPgPzUR66v7xCMiG+84eTm/aaCm9amLZJDoq
         2Jow==
X-Forwarded-Encrypted: i=1; AJvYcCWivS0ORt76gBZQIMr1m15FNR4V2PXKRKWUAWQmmgAziFPtmBPpYEco/6GF+uVSHP/gfqhFkM5r7MtNw7PYBw6OFFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzCnnNt8IDFJJPhHSzn/zPOt6AYonQh9DEIFNbxdE5JzSDHgUx
	AKARFakliOVgg9L0+SyC3F51cok+e0L4yYPd+YJLrXDuC9OUnfZ8Kshq
X-Gm-Gg: ASbGncs3rXRwEmmnlW7xRy1je77m/OPopO9+zOW1rs3QqiJ/dzwUqJBMTk6kh8iDfQ1
	NsEEdZ5BKbyN93yq19E89I5PVdzSRtspKQrS2vIs0diHX/oMBTfS76Pvu2CjfJ3QVkqxfLuphgw
	JHywtc5jqNATOwaozopLBq9gIBkQFK9Gj6v8sXB/cmsi927GZ0gMxEs0VAtHE7fZar4OBo8S4E8
	C96DS6Bl+f0Qms1XRbYqPt204Fzki2r1jVbBf3SJO9EzmQF1jwAeGGOfej6AO4QrUrDNrDqzvoT
	ODNr994av5hx74bMFLDQQIVhY4k819TmDkP9uPKTN0SzGiPOhyvPyqyVNEM+QCp3v3lkno5/xNc
	eZ0y3kSMGvfLhAPAnD+/Tu7OTgayBQd0GqFRblJv3dOZw/oKySqSmpKw9H10RI8he8n28K25E+C
	K9aZSyuOXt6s8UXeOvB2Yo//0waA==
X-Google-Smtp-Source: AGHT+IEfRMsUaYJ/XAJjWbILMrV1deJg/SxAXLDq4HjDEvGxveOHDphSf6WABh59w/bzNL05Mif4ew==
X-Received: by 2002:ad4:5d69:0:b0:818:54be:2381 with SMTP id 6a1803df08f44-879dc8303d8mr89763246d6.42.1759621833194;
        Sat, 04 Oct 2025 16:50:33 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:32 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 2/5] tracing: fprobe: require explicit [GROUP/]EVENT for list/wildcard
Date: Sun,  5 Oct 2025 08:46:56 +0900
Message-ID: <20251004235001.133111-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b3c94fbaf002..ac0d3acc337e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5524,7 +5524,8 @@ static const char readme_msg[] =
 	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
 #endif
 #ifdef CONFIG_FPROBE_EVENTS
-	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
+	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
+	"\t                (single symbols still accept %return)\n"
 	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
 #endif
 #ifdef CONFIG_HIST_TRIGGERS
-- 
2.43.0

