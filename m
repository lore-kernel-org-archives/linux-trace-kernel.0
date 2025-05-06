Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DED28A1E0
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 May 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550146; cv=none; b=lE+iH6qkncXeOAjSv88toCzUIQ4pnkMJyuxOlCB99+9gNn0vCQ9p5GHMYme99yFPLMPdmhchWNrnOxa/e9lnCCmomPHPmSkUJscre6uNu101pmTnAsiyDTTDEXkhdsSjS+65XYX3fNWBslYwxSyYRrrxZwPt8IJwP+uqdb9qjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550146; c=relaxed/simple;
	bh=PgCe5Ig4Hz5VA3Et4j2ZYh+G8htR5m2rXa4V0St1e+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=caC3X62rXiHNodZUVmhDQ/E2CBeKOGpOJSZjeqI6JWQjeS0hPAE7zwfRZx7mqOQS40M9+tfKYu8oLR9UH/6yTmxTok1cuDgQhj4t5PyJgfvKT8uYPs6+PZDYhka9xoQM+unIbH08W4O1PTW6ph4zwkp5aaxHoTX3Z4d1Vw1YtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LM8Hb4uU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LM8Hb4uU"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-441c122fa56so13740225e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 May 2025 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550143; x=1747154943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=njQ3TmZpiHbN0W0T2NSyLt6EnFI9+R+BtiPGKvCoesw=;
        b=LM8Hb4uURESSM4OGvSD+GBhMfl1CIrdzpU3rNWSN6xMzj583v+pGf1udRFmVOsDBTr
         RAWpdWvCYamC20pUSfAXtwcrba81ZLnsoM0Z47w0BUOtbngOC15UapWHaheVfIQxGZRc
         nqG0Z6dJBC94sB8U99SQtrnriqOgArYTHjH9eOOoSAzYM6ee08tj0qj/TYMKjtEDStr6
         OVeHdwRSALxbJTxWPRHExz3ivBoVdFCfmdam/0LNIAQtlBfh1/mAXVbSG6eFEVNVk/sh
         nspP86MKyvxA8tDQSqbQ7n8gUZ5FCNm1/Yd1wJkqHHHiTYbQHPxViXquhb69qy/qIGo3
         CIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550143; x=1747154943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njQ3TmZpiHbN0W0T2NSyLt6EnFI9+R+BtiPGKvCoesw=;
        b=rYN3S2K7gLu165rBG6nDW3U2W/OzvnWsHgIJFZFbGZrbcZ5gbdLFntQFaxlir6Orv1
         AmNCjAqfBho0tbjbP4A40nUXPY0KMuca+G+PF72Ot5zZ2lMapd81I4PU6k0HBjGg6Nl2
         hc/A6bqBzzOZvBU/eNKHj3WI+boCknesXXTzeZjPC7sHvMTShXDUSzRnUer1R/JySSs8
         2fVeeIEaO1uRUtMPSB+oCVYnj/ERVILnuFh88RMo5p0uaw3El1toNQvi+wbCtY8WxP/0
         WfDI9oPcXwDCeS068lC3gP/08snlb4DB2Afz7JpJ18S3/VhANdCDSvI3JkFNW0jJ/GQm
         RAFA==
X-Forwarded-Encrypted: i=1; AJvYcCWP9xw+ZiiPWSKMNAxmqL4VzZr6mxv1neaXquvrTOySj94NVpCX+7QAGXfqn49JaNwyDY/+2fXg+H74s0rblvXYPQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJuqQXe8p+Bbi/7ASpN45dmH9X3vgq5zxH2CbutmRWpy8D8fs
	7Dd6alK6Hwc0g58PMKGu7QIAfq7SKuyjhY3J08zvLlCDhWvYLM5UT9CE+bLTLAVbon3d61i1IQc
	WpdmIwOGP75mFCeg6eQ==
X-Google-Smtp-Source: AGHT+IHF02PKPiIhJbOE1ndD3uShLpPGP1nAp1HVPAQRz98xV5Rm4WeCONHAOCoe603i2rkE7H3ckkLeK9deDeKS
X-Received: from wmbay12.prod.google.com ([2002:a05:600c:1e0c:b0:43d:1dd4:37f2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154a:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-441d0fcc750mr28382805e9.8.1746550143106;
 Tue, 06 May 2025 09:49:03 -0700 (PDT)
Date: Tue,  6 May 2025 17:48:09 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-14-vdonnefort@google.com>
Subject: [PATCH v4 13/24] tracing: Check for undefined symbols in simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The simple_ring_buffer implementation must remain simple enough to be
used by the pKVM hypervisor. Prevent the object build if unresolved
symbols are found.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 8f5e194eba71..a2f1489e11af 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -114,4 +114,19 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
 obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
 obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 
+#
+# simple_ring_buffer is used by the pKVM hypervisor which does not have access
+# to all kernel symbols. Fail the build if forbidden symbols are found.
+#
+UNDEFINED_ALLOWLIST := alt_cb_patch_nops
+UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
+
+quiet_cmd_check_undefined = NM      $<
+      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
+
+$(obj)/%.o.checked: $(obj)/%.o FORCE
+	$(call if_changed,check_undefined)
+
+always-$(CONFIG_SIMPLE_RING_BUFFER) +=  simple_ring_buffer.o.checked
+
 libftrace-y := ftrace.o
-- 
2.49.0.967.g6a0df3ecc3-goog

