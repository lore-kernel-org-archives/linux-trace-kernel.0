Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D582D47EE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535036; cv=none; b=B5KWoh0kvYLYCOJubop9/wDz/6ghMh8/fBGwVFn0glngZtbiRDWm9FdEypgxkspv3hRw0zmqbz55SH+RI3F1eEQoV0goKpAg9igyXjLjooAEDx9QY31YtdcNuTJXmvpr+vE4annsgsPP9yF0WUN1Fxo9IzndQP8cvTW6q5ZOAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535036; c=relaxed/simple;
	bh=aGGkftEpxyeRpjslshbiTPf2LwpPozzlIOEJ76hTs5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jnp/MAq53bec6hZ1O+o1nIIQ3a7ej9sU+XS3+88EdmO1fa/GQaphut86X7zWc9dQCQGVSMVjnNU3AdVUAStazALtCs8UyQppIOEyME+ZHXcb2XVi4yZjlhEbztR4EajjU2MkIjLyd8/aX+2uDiqWXAmf13PLNlHtyeR59iSQUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIH08oIx; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIH08oIx"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-77f198bd8eeso1033610b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535034; x=1759139834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lu1DRFWIn6g/S08K2Xn4LJu9FjWj8PhXp8/3RimhhlY=;
        b=NIH08oIx5QU/YpCFVzvoQOfbkH8ypV7yqnZ+s9BQluF8x9XlyeskalBoU226H4nXM+
         F7/YjI5Bjpf6UcwQ9dvJ0XP/uFO2fKCTKUsBB3tkgbZmQKuz4ewqIdUswxl3cvXNfbj5
         hfGu673P0RK5F7XHEOn5IllFhMmvWWS6xFHNu8wecvHpjiUvaoNgtUX+NRNfFnjdQswe
         LIrRxeI58cQVbPLje/BEdxvVvO0iB8jTgWTPq2TfW8N4wnMVE4niKoTZyUcSwIwK8L/R
         ovq1xETzBO5GL8C6wqwXBUTOBivnpeoacmLm9LjCCiDm1ZMDnRzC9fca3d7wJ5PoWx1h
         0ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535034; x=1759139834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu1DRFWIn6g/S08K2Xn4LJu9FjWj8PhXp8/3RimhhlY=;
        b=weAh9zzksIy0sj7HtGv5UyyijwOsRzsLeZ3VG0pXAWwhTxYTW80P4crvOjQRYxJ7zf
         GyVmTiMvjK9pRhCWLddpAwXp/HesNpLP8zbAqIzU26dUuv57MmqE5rahT68iZnMWh5oU
         z6rCkYWUdSA4fGE1SdRgESadpVGPhRBHluusGDmLXmY34NN4fBeswU9f66sNp4jBCIPQ
         4kG7vi3urRfPi3HkqWHlZCpGePQDZF5r6/kRe3ZW/VXaXYoeJWEngOTHTVvcMeMqtyRE
         Sjlmfy9jCjmwsjH9W+210MbbfsPl3NoutQIod5IRLmGq5RDGFpAU8BonMaL3ZuAYpuak
         jVlw==
X-Forwarded-Encrypted: i=1; AJvYcCUogkxWGMsTyPUODr/gBYVqyqkIAAIqdJcygRliz11mX9774uguKbwLjgvQQvrraR49g7qR/MtQRSZzYbF5nNMqd0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdAXfW/57RZkjlGTsEfr/6rpR3qlA3ttwBZYOBKJbcjsrdcRqG
	3Ylz0iGGgkEbAuuGm3foMMZIYIXz31JohwpxBc7WKueUtCYEr5dAs635
X-Gm-Gg: ASbGncu8PvGNIdTsp9vdv92zztezevkvCa0W+PF4ZSqrv8FuDxn7qB2vvkJ1vsmSfSE
	v2ndFvChe5R25sxmASZqbv2t/oaiC4axbnFceanI6elEHPJ09HcuQg2dV41iCLqnMKv6SQV3RNF
	CL61J+HhlSMn3PeKqmm3HWni3HFYJcCyWWi4uUpYX87O1C+t2ouPirLi1YfqZI2UDXaORSGKE7F
	UNJgMRsj79Y2l5pm6sR3rKiP6SG3xUFCQjpVVWz8Rij6WRHmffpxljmT8/tTEHveiDns2MVihbu
	OxHtdFDxjGkDAqcSIqNWCNYWV12Cibj/RQnKRKDBmvjVWI59hB54c54jX4ZByFy+Vz1ilsPaOfy
	uqA1/o4Iw/UVCwL1Y1t4=
X-Google-Smtp-Source: AGHT+IG6aUD2BXk367svr6qPDDtyFsE6lFVvuUPRjFT+LwrXe9OqmErDCeuBdEpr9uAx55UpJqgzdw==
X-Received: by 2002:a05:6a21:3283:b0:262:b539:b889 with SMTP id adf61e73a8af0-2927182fe2bmr18289538637.40.1758535033614;
        Mon, 22 Sep 2025 02:57:13 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55283ea850sm7286870a12.13.2025.09.22.02.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:57:13 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: jolsa@kernel.org
Cc: kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
Date: Mon, 22 Sep 2025 17:57:05 +0800
Message-ID: <20250922095705.252519-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "data" in struct bpf_session_run_ctx is always 8-bytes aligned.
Therefore, we can store the "is_return" to the last bit of the "data",
which can make bpf_session_run_ctx 8-bytes aligned and save memory.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/bpf_trace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f2360579658e..b6a34aa039f6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2269,7 +2269,6 @@ fs_initcall(bpf_event_init);
 
 struct bpf_session_run_ctx {
 	struct bpf_run_ctx run_ctx;
-	bool is_return;
 	void *data;
 };
 
@@ -2535,8 +2534,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
 		.session_ctx = {
-			.is_return = is_return,
-			.data = data,
+			.data = (void *)((unsigned long)data | !!is_return),
 		},
 		.link = link,
 		.entry_ip = entry_ip,
@@ -3058,8 +3056,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_uprobe_multi_link *link = uprobe->link;
 	struct bpf_uprobe_multi_run_ctx run_ctx = {
 		.session_ctx = {
-			.is_return = is_return,
-			.data = data,
+			.data = (void *)((unsigned long)data | !!is_return),
 		},
 		.entry_ip = entry_ip,
 		.uprobe = uprobe,
@@ -3316,7 +3313,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	struct bpf_session_run_ctx *session_ctx;
 
 	session_ctx = container_of(current->bpf_ctx, struct bpf_session_run_ctx, run_ctx);
-	return session_ctx->is_return;
+	return (unsigned long)session_ctx->data & 1;
 }
 
 __bpf_kfunc __u64 *bpf_session_cookie(void)
@@ -3324,7 +3321,7 @@ __bpf_kfunc __u64 *bpf_session_cookie(void)
 	struct bpf_session_run_ctx *session_ctx;
 
 	session_ctx = container_of(current->bpf_ctx, struct bpf_session_run_ctx, run_ctx);
-	return session_ctx->data;
+	return (__u64 *)((unsigned long)session_ctx->data & ~1);
 }
 
 __bpf_kfunc_end_defs();
-- 
2.51.0

