Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853343CAE99
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327960; cv=none; b=EzQdwxk5sckg3dV0W5Xe/i+J3QflQEWgkQlypT69fX0wRq4n5gnpa6GjWM8c7tpljUBIHaziGLZ+U1Jqs3k3PCf92DJIHUgsS+xcvHX4xzpw4VJ0yc9wQTo66JiCjlnrotF2DDCouFfgwP7TdsmSnjADiDjyHsEHJh7BYcG+vuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327960; c=relaxed/simple;
	bh=W3gr5/VsY/4OAEkH/adZ5VW7hrmjIoPqi/KQbmsINLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouhGz2bAuS98vEx/5m0FVOPuEdQUI422H7qJmTf2V8owqJIFiFZL27K4HQg2sFnpz5I1XiMFBJPZ/Nyc74pzChPEh7ZzAJYkvsQCMF/avhnrqFGOUP3MH3Av8dejUGdPX0xKIkO8RoOOoeImDRY6gxck85RdKAnF4QlxFVTqD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=di5N75jw; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="di5N75jw"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d756f2a06dso1060515a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327958; x=1773932758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/dvLEb0C2jsyffhRQXnxhbz012D3R783nTzwCwYAxU=;
        b=di5N75jwRM5sy0i/2LXWuHvtDwSI9l4xjxPVUcBhbBtuBYGEXXndcNYjQyXwYpLU/t
         276w0ey69IExfRxIc8fxj33qPvABvAYtRHTeBLw5EyA+zw0JNMqJzT7dt37F7XIzRduR
         TfaY7r7m2JmVIPTMrvwPtASyKCWAMFIkGA4yZqnmkldLhO+Vs0MHGsvyQSGXVLaGXvcp
         pHtgp073XhZfVTXwBUCAminZLrbKEV8LokCKOMVA2hmjT0nMkPrV4VMjUP/paQDJXl6O
         kcBJND1dpwFwiCjU5FLyIi7VApj1PntgQBHHV+KgpSXVTwQ+JvpcDwgZ8dYJ4sAqdRJA
         whNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327958; x=1773932758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/dvLEb0C2jsyffhRQXnxhbz012D3R783nTzwCwYAxU=;
        b=TeT/tt55hId/YnxlbhKNqadgfHSsrhHQZ7Y7es/q1O9KmsRgRICYZ/Bj3NgZ005mEZ
         I9guky0EIzCcPzMmYbevaOaN5u+oVJLOxGdVBQ3Xn29TIcB1V0WZWCPLkKpMm6ReXXIy
         C6GSjQinoW+fEpsY5+ncRul03unkFp+GnZ6+sIxB9xZsEvq4l6tGB+2TdKPpdSKzhlAv
         E1+j5AHhtrBcQmdweqO2YSdczAu26YVmVo3qmTDyyO4z/M6Aj3Qk0Uhk0xJADYOmGN4T
         R6BKJSvSHGNsU2LgYYNRIW3zgvkR9+QUGw3mBbxVu/tB7IZ4oiAfX0v4OmbCxEvGlKvr
         pNQg==
X-Forwarded-Encrypted: i=1; AJvYcCXXhVEZOdvV89OTvKBSRnsodOp4WYe/u1gCaXc8LUoeYEaFKZ1Nb9ChjrVS+FikWldSArmUVXLqTWJVpPdCRqjq8CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGBJitL4k8ziN3Mcc3xmrF7cLVZn0Jm+5lxBsLbfB69s1ilwxj
	YP1tbjxXktJ+4Z/A2CRtV35DxAiKTcgJPHL2ywOS9yygJcb4EddGFLUWPJrgGAut15o=
X-Gm-Gg: ATEYQzx9Q0Y2BHvwD8WFsVF/KiuIa56Vv03gbBcWHjr/LPESwXVFWg67XFtvd8siZn5
	okfKsD4zfCq8kUmdJsgVX8VYHmgoxQzyGRG9pmmeN7lTSizyb+PbtDELVq0rKhSduC7al3+SaUp
	feacWTKYGJ14Em5NJYQLvfQybyfB5+ZI1rYmeOmBEOiA34MztDeDs/4JAjomNd9IcinU6tOf9Aw
	Kk/mG4AWVpCY9dKDCk97L89TulQV5hP3zkJ1A6KeIaciwdaKROlju8btYN/5BAVcd+aBgSLSAqS
	m7ttT8IwLYChTpt1wP4ab55RO3Fz89IM4UlYdXWuNboEXaWekK2z2LddMOiSRtV6QzYvM3jAIZ4
	/h7RXKdEWfljlgmGJWk+7VBfVOcBEaIWMcQLP9J9ooebPdH9Zb5+4RC37vnTby9myZUladktGYM
	XoZJoVHVbGzIXGGWFyHctPNo7fiXiFyRSYa5ZeFPUX2GETjl9rn6QHWZRV1+E3PXlscgSKHRqKH
	Yk6
X-Received: by 2002:a05:6830:7308:b0:7d5:96e7:bed with SMTP id 46e09a7af769-7d781c0977fmr32729a34.2.1773327958628;
        Thu, 12 Mar 2026 08:05:58 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:58 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 09/15] fsi: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:04 -0400
Message-ID: <20260312150523.2054552-10-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff338..07b88ef49cc47 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -229,7 +229,7 @@ static int check_errors(struct fsi_master_aspeed *aspeed, int err)
 		opb_readl(aspeed, ctrl_base + FSI_MSTAP0, &mstap0);
 		opb_readl(aspeed, ctrl_base + FSI_MESRB0, &mesrb0);
 
-		trace_fsi_master_aspeed_opb_error(
+		trace_invoke_fsi_master_aspeed_opb_error(
 				be32_to_cpu(mresp0),
 				be32_to_cpu(mstap0),
 				be32_to_cpu(mesrb0));
-- 
2.53.0

