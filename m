Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993B47F2E5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853593; cv=none; b=TUGhS/PBWdTYLJsJN/fdqGgAbnaqhoIrK/ABBBnvLLwZ62DkZZOICf1qummlU01Y4QBdoU0uXcSxN4zmwgulNH+gKjUjBS/9IXxbdj1wY9vwTKoX8MXvifxrKRShLsbePEdjOvWeAAYFvJpvWys9VfndlbxdO0mlKgZw6l8gCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853593; c=relaxed/simple;
	bh=sYY7OW7wGR8JvWeAaeVWHuE+lAvepGIPk46p7xEPeuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlxcY8lBHuBt8V6Wr/a8MFA/zAk2rD1HsivugpirYu5xifTEVhoto9xmwK8QI7ESnluM5gCYlBWe+GRdGaW5dZcyikny8sgxX1HfUEkitcNHCWTw5fcRx/578wtACSTRVH1aZCvP3iQ5msyBTpYMBcIuJyjVYv+1X0g49U+OqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=uIXocQZS; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="uIXocQZS"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e97863425so91172721cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853586; x=1779458386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T/1EYMrQvVHAnnWAjKGI5T7/zDsk5kW5iHbfCrzqRi8=;
        b=uIXocQZSqjeXU3Yhg4dgzYk0G53PYXbwSbXugcs0wjhpZVeuN5Ky+EvoKvUJu9SCcv
         2HAcgdvXBdLgXX4/GxZXDp4KRME6rOUuMMEd8UsV/FwAe7Wmyx+Ombcxa42HaxTMIYZv
         L/lXL+o9CYlcWbceKbeuAAKXDGdie8BOCqJccW0Pod1rHCLhCNxjm25VCuVClCmU7N46
         h+HpL354ySNaXa4iN9d7NtzIUJ62AMNWwkisLneDEPg9TK80MEPEveDCs0jK4r0QP6v8
         RMEZcj/VCywPALCo4lYs89Dgp2bnO6XyftfyQBm3XKkg9x8zIScngFcg0614+ksshFrZ
         bArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853586; x=1779458386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/1EYMrQvVHAnnWAjKGI5T7/zDsk5kW5iHbfCrzqRi8=;
        b=FvOwrW9jAMyRekNQxsNX1jFxDjeSlAooWKSB2jSUYR3xjoTaIaShz/2dMQ+k/ZnfMw
         QN1KJN5cVftdsbp62zN57m4poiNF0Qa0u5TB+KzpIFhiAug8j4qyoM5vgJVt6XT4abQd
         leh+etzFUVInBxgQMfeq/SsOFJDJjDsNEahDhjTivgAZFlSIa1zDfywD1d1wjtvlNVE7
         7s2oh4U8FzRA++nsNqci+jKjuxVs9WiryAVdU8oEzjvc76MAui2Hvkp4tDqdHzhgrj1B
         d4rHKbisL8AFBJXiNwAvbCJDx8y/QpHVgDrIlOzDM4AKhKHukZq7VOthmvJabLMvOnHa
         D0cw==
X-Forwarded-Encrypted: i=1; AFNElJ9zwK77psNC8K0+/Xr3QVX56VEXSosFGvTpgaP7JSXBwVNJys6r6uxfsSXDinYhSeP0q4/ikyIVyNUmnV+ik93S4wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9s2VkPO633GoWWuVqXObHgNfiMeBWoaekhvl9yx/7fhL2/k31
	qYI/4yWs3G6qxUjtAXyH8WsfSyEvOmAIYySr1jSgISntdA5OzRSRsT8B4NOGuEx/8KY=
X-Gm-Gg: Acq92OEa0S4Co15KxnGvM9Qz2SV3taYvBOS82EdQlGK+JNuB2t6evnHKKUVRXRHm80t
	Ge3a5sFAP8SyWtaQ8lAjKITrtw9kIsMuXJkE5kzEfXBbVnvv6tu4hKol+hPpyEcIivQFe6HTq7r
	9LXNJPUZ4U1tvtuj2Tpf2SyNmOnveSvAsllnoBDUqxzD4DQg74bl7aLZHrP/wVZrk2eFkfNgOfB
	ws3OuOzDtu+842i3cwv/Qdza4WVtHfNXq8roed9OREVAx5TmPsuHHCUwePmTZTIisee+/A1taQY
	1QIqCJRm2niCiVv0dFvr4tXYQJbaNj+y+kr6e8lXTFVyeBl864HJgWsJLMgc096M/ZlmluJdvK7
	OqGM0KWZPEuYvjchWA2rwdK55HtUpAEIqWQ+JbRftQDn4fJzxhUrQeMWemsifMK74fDq/uLJyVB
	+afAsEoJ486qaZPUKxmhkzgp55bBhv
X-Received: by 2002:a05:622a:17c7:b0:516:508b:bf55 with SMTP id d75a77b69052e-5165a276f8cmr53859591cf.55.1778853586541;
        Fri, 15 May 2026 06:59:46 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm45678421cf.18.2026.05.15.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:46 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 07/11] HID: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:41 -0400
Message-ID: <20260515135941.2238861-1-vineeth@bitbyteword.org>
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
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index ed3405c05e73..8d36ae96a3ee 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -110,7 +110,7 @@ void ish_event_tracer(struct ishtp_device *dev, const char *format, ...)
 		vsnprintf(tmp_buf, sizeof(tmp_buf), format, args);
 		va_end(args);
 
-		trace_ishtp_dump(tmp_buf);
+		trace_call__ishtp_dump(tmp_buf);
 	}
 }
 
-- 
2.54.0

