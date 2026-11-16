Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869243;
	b=1N2X0+hAuQFR+ALJytRrXm4+3bwpGxeE3iDd91IhcXalpKvsaeUYA9w1eV49PMtnhHlM
	 VsywtJrGj/a48PffrPAbGwYJRgr8Ejgkh19CeV0RUY2u0g+34CBd3IF4HNixehUAVrG7m
	 E0SbvF69h5h8h2AhgDnyRB5GN7VcZUujRM6p50lkz7Y35LF0qIUQkv0q4ea5ATX/NhIoy
	 FXzY0Y48MTY5bahfR5p8Zgq0KS5OFfSZ6GWykEjxn1t0ypRlmMccz3a6k8cqVb8K/RE1a
	 KidDJeKriOBQuZgypkAbV2e2jDQwW9CXAq6gCac66iix2DfQUxfYw1f5Z6z4A9BBY7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IwLfmncwgXXOir7e5WceUGBJ6iLMIduxAy587eWfRD0=;
	b=G43gYcaVAY1z/j8cJVAW0kQTLb3aibkSpMvV92N3YmKGXXmosZrY85VGZQQiPC7zuh0/
	 tsTpI17CFBmH+S4EwsSeyrHQx2GGuSWg/Sp83osoBr6dJtAqnT3D+h4UQL6WpZBzY4ROe
	 cpRS5Lb9UOMKFdRNkFeort2LeU+531XPNjY2HcXK9o1uDSqlhavynASp/C4aWzGDiqlL5
	 1H+DsUzxUJC94ElaGMfoMBPFQVADSpcDSArkhpkVm1ZQrJfKqXuHP0frZYquOicFe5B9s
	 HbwX+fW19rBUIiTGhicjwo0+saLBD7YLzxSoMIxB9r69QOFH/+5TMf2fzLtqv/88rzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OWHz60La;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B7606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 22:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 478B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OWHz60La
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3acec6677so5828023c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 14:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794869241; x=1795474041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IwLfmncwgXXOir7e5WceUGBJ6iLMIduxAy587eWfRD0=;
        b=OWHz60La9AXudh80xsZOCT6AunWRd1WCtzxOdsNHIT4WpdWqrXILNkKbnDAS/GcSEG
         D7iC3nZplK+nxTIw1qEDnKjPi5Y/l1uXHxYvesGPF03F8tvfYgjdTdqdlWqed1bak9VC
         R1DkXTTY4kO+hJsX0QDhysucXhbgm3oKYaEfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869241; x=1795474041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IwLfmncwgXXOir7e5WceUGBJ6iLMIduxAy587eWfRD0=;
        b=xagEVHk9ZWmAkD2Tr+GmtjyIgBYrpDHTIObcOax2E53rNjusozPpcQwoTXJuEvof5i
         hS96/OVOnt9sdQ5ultqNFNdM3ykjoCLb5p23ZnUNr3E5sJ9IxQYsO0GVkcm26y0DI/S0
         0cTkknY9GzMeKf2k3mVYt9svfoS1axeWXy5k/4W+zDfUe71ls+oVE6Y+QkXycCvpG03t
         ZkZ8RvMzy/8gN6NymGFCH+QCPyBKId/1G1CXlRQQUe6ZbFdlWZHoRq4TH9OAkezPOJNJ
         2oYH2rX6aGshlV4NG+qQ4OSlPSE7RGUJLv2YFPCIhzTXhEAG1OFowGlTJvozUyEBEHgp
         Ew+A==
X-Forwarded-Encrypted: i=1; AL+hErGe0pzs1gNO1POFLSNLFc8x3fU53iFuDwFJwjvyO0P5lGLyKMBylsWF4Mla+suOltV3DQFfMOiqgW8LwJGD5VnN6Us=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kYZpTz66MytI5IMaoRfMMwq7ee9kF+fQdpqYUkW2jIl2AHP4K
	QLZYsBwBugdAgku0JKbZUu2H8sWalN7x8yc8vIQhys3Pxze+typ1ZjsC7/dqHXkfeQ==
X-Gm-Gg: AYBFou2ftT2ta9UKZXiCArgXt/0qTTvoEArMnzLZ3rCBVOUVAvohex5pk+1wNM0zxtq
	hX0TkIxSQF2ZBt1T+nzzDC4eT8FeS76iOeyy/CKB4aLNlowFvmilrLpLeu0XJk+K3I+kdGfO91h
	QE2PqqeP7YnxkUGvwA41rux2WLcUSIDfQ0EbJLmlGTI5hSX+Z6/Elvctdbnp3pgkOZa9lx3kWjH
	GxHuuCaMeTpJ/8l8GlNVb2NiMmbpA9mhVU1/MIPwp7CRY2vikSPt2DeewYqHUNetHsKY7wYKMNM
	f76pn7ny9fb2tAd5K4GI/SzanMesOX5gBAHDgLb2S2k0LgU0T+VKCXRWOb6RYC2ghXbRAJ2qAH8
	V0W9Qwrp2ImoznbWFK+8FcjdCcBmvWDPMQEroHQ0w0a5oKRZCeRQA9D9ct/kPLJdx6SiMg0tP5O
	RIMQyntrqVSKpPFGOqBmxeM+NVll+E6Tonrz1B4Mpy3VmT36cSuBSuJgnBSsf/iThVK6E8Df95L
	y/op4N4KXVYgjd9JZdhvrosdXVCqA69m+yqbbENBuJvaLAKEx25rRwmK4yuXmYDzHXl7npPzTSH
	TwwL/TAzHVei/9Yf5oVuzR49qj+iYwdvoFWi1zcyA155KSCcZ5isB6QjiWRtW3o4/2g=
X-Received: by 2002:a05:7022:b0c4:b0:176:2095:1ac4 with SMTP id a92af1059eb24-1b5030f291fmr9804741c88.18.1794869241395;
        Mon, 16 Nov 2026 14:47:21 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:264:3904:fc3a:a69a])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b5329ec87bsm8470305c88.0.2026.11.16.14.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 14:47:20 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Date: Mon, 16 Nov 2026 14:46:53 -0800
Message-ID: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
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

GENERIC_TRACER is not a user-selectable symbol, so it's impossible to
enable FTRACE_STARTUP_TEST unless one also enables some other symbol
that 'selects' GENERIC_TRACER for us.

This very file also suggests:

  All tracer options should select GENERIC_TRACER

So, use 'select', not 'depends on'.

Fixes: 60a11774b38f ("ftrace: add self-tests")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 35d043b19332..8084d46ef2a0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1135,7 +1135,7 @@ config FTRACE_SELFTEST
 
 config FTRACE_STARTUP_TEST
 	bool "Perform a startup test on ftrace"
-	depends on GENERIC_TRACER
+	select GENERIC_TRACER
 	select FTRACE_SELFTEST
 	help
 	  This option performs a series of startup tests on ftrace. On bootup
-- 
2.56.1.703.gf848ed807c-goog

