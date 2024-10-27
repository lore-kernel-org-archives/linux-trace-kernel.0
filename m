Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259716EB54;
	Sun, 27 Oct 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730063981; cv=none; b=hDEC1dHV/IgGnCMTkr2/I5vHnu/eAcTDE9B+1c1c37GRaO6AB14wYDl/ORVas1TUiTfJETt6I985wn4jFesIhyhQWK0JLMNGsWo3d1tUYjh2TtmZ8kTooJGx/n/XT7e5T77zsT5l1zMAHGPV0rzkP/PDD14H9Q7j702aAB2mePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730063981; c=relaxed/simple;
	bh=KdJh3u3ZP0U2JiSBziw64zZvKITJSsDF5v402M9mu6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJZoOtLX8k4BTgp4IZaKGNVUiy9NghtOaE9jqHAgIgH8lhjHGXLDoDXX7ue07LyDKQWnIrGMhWabxeBRCO82/wS7xWrZwWyIUGyHBlaG+QyGY9KrlTyeClzYcO1Dt10I4YBbiZkVMUOU10MvVTYpmWUuSRZqsPq1DzVKD1VQ1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhnbE+cJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhnbE+cJ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so570944a91.2;
        Sun, 27 Oct 2024 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730063979; x=1730668779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEQW5MOWjW7KV/lqVtyNAJeFCNbHriW6AQc/1TGHzzM=;
        b=jhnbE+cJWpLpZzGJ04kihbeBSSIEFNnr7SujugP4qnG2io500mtz+Za5MOaK09SlZd
         hDv/QQXsPmQzGDyecfHAzJnsPUtepW+D1Ornz914Ky4wNmCeKQGLc4kaa8cbe4ChjquV
         7F/1MsQzw4cA9BaTMgQJ600vPaFrdpeki/IbzBT8tt7pgvUOn7eaPLlfVZxNE/jCse+O
         YaIWmcWZUsG+6SO+NkmWb3stTYXaXblUNGbgdnko01durhs3NyjM5okyehw9FhhpdbCB
         G5hKteW15w4cPLIhnTM1U4p1d7SPpoXEJ/m1aHsAEIzOtyVdSqhydhM1/vupY3aUjiBu
         V5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730063979; x=1730668779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEQW5MOWjW7KV/lqVtyNAJeFCNbHriW6AQc/1TGHzzM=;
        b=AiTTUBYfbWIVvOfGtoEb2sD7IuKTOviMALizgfbmFbEGZq3fTuf+j4c8BB2lKjE186
         fE1C3KdWNkZ0pCWV+3hA65ASfbV7LNfriMn9AbpkLAvhpJClkI7ELUgmixW156b8fh/b
         GzRivvuw6td5GVGJ74elE99sOav8Qw+jv0ZTCABvGo9CYDBufK1Q8FrVMNtfwJNrCGcj
         aA6Vr/XN6i7aJobEJlSGpaTWXp2vxqMbfS2aspE55FNc4jp+0zkdLcUdXj8QUMIpcU05
         dkpbN5JASTu1j9JuWSQinsOor2BORiEnW7HLuHDUMfowTO+KtitKAt5gPsc2BCVg3OfM
         Vj3g==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4MXJBq1AOxNpSisoyLdHLdmYKCEXwdmtI811dzMaKx4lmSgl0EZZtY9zYXN8SJGj41nabCJ2UkWePPH5UbCev9+H@vger.kernel.org, AJvYcCX+nBxOTGgLCtOs5xID+dFgYMDAZeG3SOHgVaiKx9gj/YE6DtWNFk/iS3lLpJ9mNL/QgWAy1GDQWY8zC3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiDc7lEQIO4niZD+PIMbkzcPKn5mE/QWT/IL+nM+M7QYfRDEB
	6of5l3fSOYEVG/I4xXQLC6zlvreM1OGaVkdfZad7sqD2jwOGgMkg
X-Google-Smtp-Source: AGHT+IEOQnQ3OFqJ1bnyeZSnpt9CJgoKqnnMYnDe0BvRc7amn7cMEMJ+P4mQ2xX1emxWf5yAVIR3Ag==
X-Received: by 2002:a05:6a21:9997:b0:1d9:1894:cdc4 with SMTP id adf61e73a8af0-1d9a8534ed8mr3959762637.11.1730063979023;
        Sun, 27 Oct 2024 14:19:39 -0700 (PDT)
Received: from motti-test.. ([2409:40f4:300a:9618:92ca:3f55:718b:1cab])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2d19sm4383887a12.67.2024.10.27.14.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 14:19:38 -0700 (PDT)
From: MottiKumar Babu <mottikumarbabu@gmail.com>
To: 
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	anupnewsmail@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] Removed unnecessary initialization of "ret"
Date: Mon, 28 Oct 2024 02:48:18 +0530
Message-ID: <20241027211913.26718-2-mottikumarbabu@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initialization of ret to 0 was redundant since ret is set to meaningful values later in the function. This change simplifies the code and avoids confusion about its initial state.

The issue was reported by Coverity Scan.

Report:
CID 1633338 Unused value - An assigned value that is never used may represent unnecessary computation, an incorrect algorithm, or possibly the need for cleanup or refactoring.
In register_ftrace_graph: A value assigned to a variable is never used. (CWE-563)


Signed-off-by: MottiKumar Babu <mottikumarbabu@gmail.com>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 69e226a48daa..b13ab2ad0e88 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1249,7 +1249,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	static bool fgraph_initialized;
 	int command = 0;
-	int ret = 0;
+	int ret;
 	int i = -1;
 
 	guard(mutex)(&ftrace_lock);
-- 
2.43.0

