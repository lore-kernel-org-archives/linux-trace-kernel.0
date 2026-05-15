Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920948B37F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853756; cv=none; b=lKnhgVzXB/hZPDnj8UIcfYJuDrpIyQ+VoIGn0UIL6lJhOKKCNKfMWaoeZBrw7OXAQnNO8k070Ev4mBL+abZ3zH7CMf3ZA4oLZLVJnMHpAON30qp0oKJ0+nF38ny/k32bjgV9bj8QdVNwfJrzs/6HT1ONaW+hTqe3LID4QgJFXfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853756; c=relaxed/simple;
	bh=ALpKt7OWHpMRF0UwuPrJY5tk2m6gNcfh+2gHLBFvREQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqX1zj5vaey209BXQ5Q2XsctLiFQ31ctpiss1Wzspteo7WzMC3UfUe4sWaHPiOCe1/vs4iD/hkpISipHApZKHD97BJo+zLli6NSPISOKZj0wsKrcVUuGZCvblzRLTRN1u2Mt4mppc5rVtauQNW43QtpbgcmUoxliIxmKH+2KKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=E/FfTUgw; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="E/FfTUgw"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d87c138e1so87209851cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853751; x=1779458551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8GCYT+w3Aho95/C+fNjFi1Z+weTfOUHld92VJE85ntg=;
        b=E/FfTUgwIkNGlkzNQ+x12aWj6WvhjFrKqe5yeQ9A+F+Y3OcS/uxipFTVDMp7TWrfPE
         Hf92CSu5MKkBRuOaGz2uV0X8lkGv3F9p3tOXrO1TNzAvBcV7HlXiODDxOG+wxiY2QQo+
         lAOzYjImV+RCk0VGBrpLWmMhxvVa/NOdJHUS8Obp3nmz1x1GQKOB6vHXUluTd1loGB0g
         7EmRqF/JCoLYLfbMkVx80FvYLy7B4s1PBOy47/qx0Z2yoTp070Jw/d6bo3Hj/yXhxkle
         QAGoAVp1Pum0QwbkVfp2wXKMicJylWxcPdHJ7fXpM1ByJcot+YA/WhliIcYwzw/dFbPq
         MtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853751; x=1779458551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GCYT+w3Aho95/C+fNjFi1Z+weTfOUHld92VJE85ntg=;
        b=WGaK+i/u/PTKB7siLVStm9cAo2UykR3JMS4yCxLWJLdwmED01Nfyfe5iY8+4i7FmqO
         VMtSiC0ugrYqPL9XKvWPNXvWpE1kN1dVD88qAt4doo9HarvXo0KKUpp8V+zwrD1nCM+d
         TGoVqUEem1MF32i8v72udyAiselGFVIalT1FD3TcLas+3sLFCXk8PEgvqp3ckInE787M
         0rYe9Nm2fkCCW14NvZYUW7Dv9x7Is8oM2xAFdC1H1R7fAVgkzhnVuyiVJ1g1ReahDAks
         ntMxag0qUPHW1yezhtj+FZh+R/awLlxub9iBf3h05t5SdL97LH0HFEh4hiFMzi3gJn5S
         52ow==
X-Forwarded-Encrypted: i=1; AFNElJ/7Ivqxa4CxRqkM3XqlujsYEeY+4XM4xwFw5zdhVXRY4HXGeIlfODoc1SE4iruN/3LsFdjAIt0iT/whJVrnBAd0SbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqestNyEZV5Bsz4+YAOv0SWIuYSQ+xqs51ebgm4vWkGX9w53gf
	rPQNL93jqkuHBfhO+KgjI4lOCFhbuE81A+DGWWleFrLSzY/Y3dhsqPoue5+arRzVlY8=
X-Gm-Gg: Acq92OEclrh/ca7kWe8yMWhiUR9O9lL+m96CNlGg6QYJ/R1wipOnv4qR6Be4xgYQX7U
	m0DOMVavUqHdsc+JVhxQp5gjTs/k0oDiFFJP2qG0l6pLoyS5Z66uxuwwT5lo4QyFGV2BTAhiTeB
	uKnv7Pkbu+5Rld4yb/nOKdhXb3KZuTwt2J42iOE3jVT3ineQSZfAeKc9xFxS46Tlxb9GUzOhHBo
	SPgTyFexg+pxOlycVFMRWJWZYIffnaSGEMjYUyqsHB9YQF1CkOLxEd8pROCJ2fQzQjV2VmS4rEu
	V/AGqSdN3BRt/LDnlQFnaXT4onyvhK9lP0KRgITmtVA4kYWoyJgCFqKIeUxwrnEZWs7vW1J1Rmp
	GYabzqFYvgAuCHSmR/SzNTbOYdq7KfI6V0tY0wSk7L0b2WYGYygESjDOj67yxnytethtPiTUe0P
	uxWbfaacRt18onTmzZSoQ57d6d0sXo
X-Received: by 2002:a05:622a:5a9b:b0:50f:d5c0:7f38 with SMTP id d75a77b69052e-5165a0ccb68mr52159981cf.34.1778853748236;
        Fri, 15 May 2026 07:02:28 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516457d630csm43545051cf.14.2026.05.15.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:02:27 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/3] drm/panthor: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 10:02:14 -0400
Message-ID: <20260515140214.2239486-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/gpu/drm/panthor/panthor_fw.c  | 4 ++--
 drivers/gpu/drm/panthor/panthor_gpu.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 8886002e1d31..601d464b312c 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1080,10 +1080,10 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
 
 	panthor_sched_report_fw_events(ptdev, status);
 
-	if (tracepoint_enabled(gpu_job_irq) && start) {
+	if (start) {
 		if (check_sub_overflow(ktime_get_ns(), start, &duration))
 			duration = U32_MAX;
-		trace_gpu_job_irq(ptdev->base.dev, status, duration);
+		trace_call__gpu_job_irq(ptdev->base.dev, status, duration);
 	}
 }
 PANTHOR_IRQ_HANDLER(job, JOB, panthor_job_irq_handler);
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 2ab444ee8c71..b19754d7093c 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -87,10 +87,10 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 	gpu_write(ptdev, GPU_INT_CLEAR, status);
 
 	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
-		trace_gpu_power_status(ptdev->base.dev,
-				       gpu_read64(ptdev, SHADER_READY),
-				       gpu_read64(ptdev, TILER_READY),
-				       gpu_read64(ptdev, L2_READY));
+		trace_call__gpu_power_status(ptdev->base.dev,
+					     gpu_read64(ptdev, SHADER_READY),
+					     gpu_read64(ptdev, TILER_READY),
+					     gpu_read64(ptdev, L2_READY));
 
 	if (status & GPU_IRQ_FAULT) {
 		u32 fault_status = gpu_read(ptdev, GPU_FAULT_STATUS);
-- 
2.54.0

