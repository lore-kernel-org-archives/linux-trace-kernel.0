Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4F195B3B;
	Thu,  6 Jun 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680388; cv=none; b=KhXIaR7J08R7sy98y6w/gbRKaIu29LXfcg78nBUdluBkQcsGaZZuthPMTUOgznoxg3+fNgkFzNvBd9F2C9NjZndVaa/xF7soYCDg3NFyBwqWKtDvdPnLvP6CNhNUnXuPAp2AXHP06YNAjufZ4MmgY437bbiSQ4PAGOiltymvoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680388; c=relaxed/simple;
	bh=T4gVqNeiQwLc9IY+uR1Fx3P7ODXlaBcg5nHWL2xEQ5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JBdpjzY1rkK2YOnD0kx4PSNvF4uqImSZ0NPlXBVO0kmh73tj35GgHGWQQ6jP4qEo3n6E4AmekdQvqyQOXnttfJLgIuYNN+elap0aSkulgK7sLwPneR7Hq/k5PxLeIF2pFejL0L0ydDzoq+jc+t6e7FxFLQosacZphCelTtl/dQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwhgUyyc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwhgUyyc"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-703fec25cc5so509632b3a.0;
        Thu, 06 Jun 2024 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717680386; x=1718285186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x07L2+MySqjTT/zwv5/pvgKJjPAjMRPDflzahQe9bjk=;
        b=DwhgUyyckbiZ06PZ1u/IessHOJn6q6Oql4bTghZAZiRHLCy+Q7k4rGm5WQcl4eJBug
         XEJORrCTcwyhNzY+XxYn8Qkk30nuaQIZrqfnq3y8FCEBSYClFnQAApNX3F7kqQJ7r25S
         /InbRY34XMH2hDlr79RQHeM01cAl3F3sQNOhHFaeyL4Zb+d8zf7na/G5dO/XeSDNL3Se
         Z+j7bITVWCgIzElx+quJUUDaebeYzvgZ7sfsVmoDb71K3Rf+NuIxkeOwquSubkAjRqIG
         3PrDeRXpKVvMPU2lAQHNkJuEYfksb+WwpgO/JD12ysmG9DPSoUjuqu59WnlH1PqwOVMc
         FSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680386; x=1718285186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x07L2+MySqjTT/zwv5/pvgKJjPAjMRPDflzahQe9bjk=;
        b=lqWEDH93BL5ds/elcweN7rSfhoe6Fqs2pclpfeN5j2sBd470prkOj1QbrEeoHyZM7U
         Vvl/0DPwn61ucIcY+MKxwFQ4SYvVhhLX6m4Oh1DU+NwH//3p97U/S4xqgfT7jG32vBDF
         33dUmpJcowkmMkcRW8beIEzZ9KwVbKOchb3jFirT9BD/qgWtDRYyM9iJ6XJ/KXzD/Ol4
         HuRhBIQgn7pAGR3pASTB8P2IK1PFangCY1nNLVp0GwFmMDPo5+4/RL6/tU3lOVdp5BDe
         UHlxwmx+S/sm/kOIG0UPjwMl4qd+pgNNVV/vwH8oSBfaI/TymrU+ztLtsHNUi3xk9X8d
         kOWA==
X-Forwarded-Encrypted: i=1; AJvYcCVC7zHctvPFknp8/JuJHNh+BcpS+3Fm/Ew60gNSTV5FcDGFC6/8AKz2nsxLe/B1iBT3qyR4RCurokS+PEqI9nrnae71/dXA/OL/5q7P3/gLka/+3RT3XuFQiq+WZIDCK29LthWXFJIoFDq8HB48W2TM
X-Gm-Message-State: AOJu0Yxx+UegJLhXlivkO5VgPoPooL3C2du1omRHc7NSmzJ9HqQ34jwH
	esU9D0C9vL7nHN8xv+Qd8uvJ6/2FSf57S5s/G4O8W64rYV6FjGOrHYzC5Vf1
X-Google-Smtp-Source: AGHT+IHqxlZxQe+HTbj7/MJEg8YdNiO0QXLtdoN1nyAkm21W4IxViTfvZtV64EInGb0ldJuqW/ib7A==
X-Received: by 2002:a05:6a21:622:b0:1a7:11bf:7b74 with SMTP id adf61e73a8af0-1b2b71adac8mr4742743637.62.1717680385745;
        Thu, 06 Jun 2024 06:26:25 -0700 (PDT)
Received: from mari.. ([2804:431:cfd3:42f5:bf70:5697:bacd:e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70408c58197sm65585b3a.129.2024.06.06.06.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:26:25 -0700 (PDT)
From: Marilene A Garcia <marilene.agarcia@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Marilene A Garcia <marilene.agarcia@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ftrace: Add missing kerneldoc parameters to unregister_ftrace_direct()
Date: Thu,  6 Jun 2024 10:25:20 -0300
Message-Id: <20240606132520.1397567-1-marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the description to the parameters addr and free_filters
of the function unregister_ftrace_direct().

Signed-off-by: Marilene A Garcia <marilene.agarcia@gmail.com>
---
Hello,
Thank you for the feedback.
The requested changes were applied in this new version.

 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da7e6abf48b4..1f79cf3c598e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5960,6 +5960,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
  * unregister_ftrace_direct - Remove calls to custom trampoline
  * previously registered by register_ftrace_direct for @ops object.
  * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the direct function that is called by the @ops functions
+ * @free_filters: Set to true to remove all filters for the ftrace_ops, false otherwise
  *
  * This is used to remove a direct calls to @addr from the nop locations
  * of the functions registered in @ops (with by ftrace_set_filter_ip
-- 
2.34.1

