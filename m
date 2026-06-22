Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD80B640
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141799; cv=none; b=m1eXoVYVO6r/m2YvoO71tMNHvDO9enkE9AW1mVhlqfMlPXsxlSfvl6pO4r4WKOMhja/tYcaKQCNBsifvL+ST+O278NypZFNApaZe2fdI4Q5/UdN3xLBmRNDLMG2zuGynit6OMASU6kVEnSwLu5leC2dEewWPEWgtuKqwdVRBiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141799; c=relaxed/simple;
	bh=4uPvGrJ5SwiuArBAY36RWEnUJlBEsMd87DMnG2iavig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCUMpgMRcwWJoM8tIUxraNOpLWbS6UN/Pw7gBpi+FSaUH4cH0FTr8kh8q4Ocs9pnfCH7tu9YEr00NXmHRq8jlDcUx3RgXbOglG3gjK5PSmAKHhT/KY7uIzVH56JTogq4eWTNSsPCZdHFPoj2VseI+BanAYfJRvS0czmG1OrSSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnNoJMwM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnNoJMwM"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8454ea42069so604933b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782141798; x=1782746598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nP+UcPbz/qtFCf46MS+kmGEKHU/MWSP5OhkjU7x31sk=;
        b=SnNoJMwMiUHNMinO0BgB+I6YP1PO4pPpnWv7HUZo2zt1t0Mck5kPjbAR0wyA7OUyOw
         2j67lW8/M/tXei/xR1hrmoCvIT9IGPV2e/8UBfpjk8MgYsdXuDBEK5sezqhHSu+TxjVm
         8+OrbQadM9JNtEfusJt8Yoc9hG54GMbNCWJQLb0KgtbcJqkT/reK5J9CPChnP5yFrrqS
         +oi4mgWPa6unod3Kf9Y4AnvGI2jsZEQLhwGBxw5Az/l79jGlb2u3d2EiqZocRn6jk4SI
         Z385v/VilKKmGvPq/gqswIoYTBqaxGA4LerJDRn5mN2dIcTsexsxR+loYijGv3Gpah5V
         nBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782141798; x=1782746598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP+UcPbz/qtFCf46MS+kmGEKHU/MWSP5OhkjU7x31sk=;
        b=dxwezetGtsoL/P1qssQobYiKiJ2TEESOJzke2C5C3PXOlzkZXSHk0gMy9LsyTWCpKo
         8a9jUUF7IM7bbCOJoWlljvHdfRnpabieNdgda8wQjnY/4SqoZ2Vau/qhcgaOf/JGGLQo
         cz+zjX/Q21Aws8wK3Tc/k4b1a5J4itFcVlTzEgD52PCo1h3nzztdGw13mhaB/B0c68ZY
         7LqxMmzJeDHiYb09uBrL7SRsBuL1Ckmm/W5prgiAi0vbT/Oq7lm33HzdTcLHMj5OHI4M
         ITNa2Tjgh0YY6sjjBvpNtl1OBxeWS42c3iPuws8kNO2wyLhyyDbEPHVy0NTQ2DdORTHx
         bm3A==
X-Forwarded-Encrypted: i=1; AFNElJ81cQdOHPOrddYeaTmb26Fn4Y3RFEyoSWRUoAZ4FC7xJyfl+Lif8brfMxlcoWAzUU6AupwQBTFoxSwR4b2UqUk+w2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvRaTkmU9UamCvNZVr82mQxKKz0xmfNIocyDhyMd/5V5bGue9
	UIuJfbgvpLRUakr4AicYTDtKb8C6zXWrGa+4onwXvmefTtTmfCS/LVHG
X-Gm-Gg: AfdE7cnHtpP+0QodlC9Ci2Tv4S9iZKiIMk5U5ICC3v1qPc9BkfauZCL8VOwvSnpyPcc
	LDXwR0lnGbcIXJ20yrAzgbpijwccW2qBW10E0UIS9FpD7E9Q85PMCdea7fY9XKOcPddu8vGQhKe
	d9rr+XmuvnEKgFzOfcDn+rit0tlabfOU8XsRoXPan7f3HQFj0NPU1pGUgz4DwqjiA4IvS1pA3Gy
	Yn/+0+qmb8k/tauiyzzUgbIrVHjcs15IU7yUG/UAe81L36CoWIJkeH4yBv4421q7WtNhGkZvE7J
	8IU8k/s0KmSdjcobVPiW+XgwINUl/+ZsN0MNOqgDo+DbsNb2uYPZmhbURXztWC6qC9RjKE4x8E2
	yDXY5EeY/PsRCjAuCrl0pgA4fSf7Tbq4CdoAexnNj9Dyo+8tYA154NgyUZhx3n5i8RU4xqWDVvb
	NhUpyi7Hmw/+vi
X-Received: by 2002:a05:6a20:938f:b0:3b4:b258:cdb6 with SMTP id adf61e73a8af0-3bd0ad1f745mr541879637.6.1782141797725;
        Mon, 22 Jun 2026 08:23:17 -0700 (PDT)
Received: from pop-os.. ([114.4.214.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc2c8e92asm6883194a12.2.2026.06.22.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:23:17 -0700 (PDT)
From: Yudistira Putra <pyudistira519@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yudistira Putra <pyudistira519@gmail.com>
Subject: [PATCH] tracing/probes: fix typo in invalid variable error message
Date: Mon, 22 Jun 2026 11:23:04 -0400
Message-ID: <20260622152304.88345-1-pyudistira519@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the BAD_VAR diagnostic emitted for invalid $-variables
in probe event arguments.

Signed-off-by: Yudistira Putra <pyudistira519@gmail.com>
---
 kernel/trace/trace_probe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 15758cc11fc6..0f09f7aaf93f 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -511,7 +511,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_RETVAL,		"This function returns 'void' type"),	\
 	C(BAD_STACK_NUM,	"Invalid stack number"),		\
 	C(BAD_ARG_NUM,		"Invalid argument number"),		\
-	C(BAD_VAR,		"Invalid $-valiable specified"),	\
+	C(BAD_VAR,		"Invalid $-variable specified"),	\
 	C(BAD_REG_NAME,		"Invalid register name"),		\
 	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
 	C(BAD_IMM,		"Invalid immediate value"),		\
-- 
2.43.0

