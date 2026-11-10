Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289455;
	b=FQ/5Wf6t0DtlfI6w08uf4MsmIoNvXwTGqDywxgchW8QEJ1rAU3DOR49XSSVk/AEId0hy
	 tSkjE+4fg5voHKs3dF8FjlEiqf4PnRimTyCE+vFIi2/+wVdhedIB98r1Fw1gmCnl1A15C
	 8npHOH7RxseCDlq70SHr/liPYBlj5LelFR17Mt8mOsMgdP+fVIi8+EcRIWA+gN959UgRL
	 4FNNxh1CAPqG+dLBZO7BbOa6LiLY7CiuRFyGyk0DpnPNFH90ha5Hp5YHQiw7CuhZpLGL3
	 fee7drfZirE1y7TcU5Zrte1azhKOvH1FmYA05ZZK4WbE8NNFHeKZib5EwOViFAxw7PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9ljX0hqkFpVdDO4bWmsipvvF8GC2kb5FdkDBtLth2A8=;
	b=3qDOvAlCFR59tKeeH6Hw9bjKeiHGsXZf0/xHY+R7mKWAVUpDWnnKzMwo5fpV5IF25tW9
	 vKS6wqb2SQani7TR5fUU2FWd0bmgYw10ooHEeXYdci6YgbXegJeL8EeC+HAk1ZW1ykCBd
	 /ct8aVJjivAz8lRvCx89MzxghxO3HVdISLbOMQ873DYuFu/Mt5hwq0rfXl8QDCtJDbw1A
	 TDArFFKUVrRsZsBobM3gExdB3rwoZfJxqahJRmEgozsuCbd8n8hkUBHW9cazFxdWGy87K
	 HFHt+bFZwoBOq3DECI3Ni/3+IlM42po6bNJ6jj1pAxHFJ+BuWAhEbKsvYaCSzfqnG+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=RhJ++tfx;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF15606A321
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 05:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CF15606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=RhJ++tfx
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-85f39332862so681372a34.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Nov 2026 21:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794289453; x=1794894253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ljX0hqkFpVdDO4bWmsipvvF8GC2kb5FdkDBtLth2A8=;
        b=RhJ++tfxyGJGDpKIOJ8gZfcgR0zcVVMYBoUUA1kFSVONTcW6gFCeveaHqWVII/dTTU
         hexjA6eF414ePESlgAYZmU6NyQ8JgEaGpanTuQIWjPatc9XaMyWOtVa4mm3z/teCA97m
         GatEe5tRuO2YgD2i6GFxHINJ7pAlNrdpacZs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289453; x=1794894253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ljX0hqkFpVdDO4bWmsipvvF8GC2kb5FdkDBtLth2A8=;
        b=xT2cfQamAd/LQMspndrgCTzLh4HJnGyJ+ZgKu+NXRPTn/pgNW/wkUU/tDjWzuRdjza
         llFGLbaQF2bjVmwEsPlUp8sdq8XF/evVYmT5+GG3nQEOo0iW4ODPd27xcslmJ4h/zgjg
         x+dJ+cFqVUPSHTrXsh4EUZwLliHyQvhdQ9c8g05wD6NDIiWqCuMXONpq75eeMhaiamVi
         wwKOYHBcJw1Bbx9bqZWBeeL8pDnh7F2heUOdj+lODEFSskp/xMekwVcZyL2R+gs98rqS
         y0npK4QT4jzg/oATG/3xY+JlK2JDmeV8ew6qFs1/CJ/fCqhuqWmfPtvhtQOADpe6nU7U
         7+Zg==
X-Gm-Message-State: APuU4Z+HCYZd9e2DDdJcNAVkS8du/PvW7Fma4w/c1fwrkaO4QmzeoysM
	aNBY/bkz+UGaFTPMR9+2fkUZhcn6db5t/+0pDpMhiKVv1BVnWruBGFYSLDPzlL1cKA03zmFwnMS
	4dPbiHn0=
X-Gm-Gg: AYBFou0kxNADLVVAwn9Fp1susOxIFeh7IGVuUCsaOfkX9VF97t+s7ua/1a+GJeG0RnS
	Of30VT7rBy6SIxKKOkO5BRUOW6OTZ4NtNsXXT+Wv/7iv1PITxGoUSYBpqJ4/H5lKqN1NSg9i94D
	dOG4CDcmbHzMGjup7ru/6YWYBdGsSkfVFGPorAsyr/DR9O4AQ5hhLk9oP2kel508oC2VbRmIVWT
	vYHJTOZj16YJnNVUp1iUyB6ItjW2TcvEiWDfPm5ynshpVcLr3Tw1ZhCobCXnZLzmEkcr6YpUnmF
	vYmYGlNyOdnp9RXEdVMIX0PYKkJVzAeENWDD75t5BF0Q14mY8k1akp/wdjYDSGdBZpTQozaQVDu
	dxX66G/2Ut5QVtvQrQELvI2UyyPfDXOuKhCha41+RYE9BJ1zFd+PU5RGTx8lLSu2o4D4MH52Qd/
	4KZQpuXmNntS1slblQC5DDi2AcheNIvBr9Px1QFqfmP0C1F6L4NNNyJmbP2xDwshD85j3OZg66y
	7cVG2g2WhKqqWw6wmG0ziYBaj5ySBopjl3Vl2uVHtT1jY5QSepq0lVaRTFC9I8cHw1UQJR+Y9Y5
	dp9GBCiHWI1GW+JiiI5B5i6sFxj7UysUcoO+7uukUxRdC/mxOTmippRii7Wa3/6aFU3SuXfmbek
	1t0cfDPFU6OJa/rjd8ny9lUB9KNUUcA==
X-Received: by 2002:a05:6808:3209:b0:4a4:744:a4ff with SMTP id 5614622812f47-5683c99ce5bmr1527259b6e.4.1794289453346;
        Mon, 09 Nov 2026 21:44:13 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905735edasm1258958b6e.7.2026.11.09.21.44.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 21:44:13 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Validate user addresses in faultable buffer copies
Date: Mon,  9 Nov 2026 21:44:11 -0800
Message-ID: <20261110054411.75788-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

trace_user_fault_read() uses __copy_from_user() when no custom copy
function is supplied. That primitive assumes the source address has
already been validated, but the helper only checks the destination
buffer size. A caller that passes an unchecked kernel address can
therefore cause mapped kernel memory to be copied into the tracing
buffer. The original syscall-array tracing implementation exposed this
path to syscall arguments before the syscall validated them.

Use copy_from_user() for the default copy as documented. Non-user
addresses then fail the copy and follow the existing NULL-return path.
Successful user copies, buffer bounds, and preemption and migration
retry rules are unchanged.

Fixes: 64cf7d058a005 ("tracing: Have trace_marker use per-cpu data to read user space")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v1: https://lore.kernel.org/r/20261006225221.54513-1-kylebot@openai.com
v2:
- Drop the trace_syscalls.c change, already fixed by 097fd0050089d.
- Keep only the trace.c change requested by Steven Rostedt.
- Point Fixes at the commit that introduced the shared helper's copy.

 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4ccdefb5c3ef..e1127768c074 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6289,7 +6289,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		if (copy_func) {
 			ret = copy_func(buffer, ptr, size, data);
 		} else {
-			ret = __copy_from_user(buffer, ptr, size);
+			ret = copy_from_user(buffer, ptr, size);
 		}
 
 		preempt_disable_notrace();

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.55.0.openai.911.g06873a30d2f3

