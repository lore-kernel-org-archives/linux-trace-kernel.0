Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74CC304BBD
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927022; cv=none; b=bbGsLRdNlIbt8nFUzy5s9kwHMp9fiFpp15VxVWgAfcxNdIrUBDKlr89c72O2ycO3hJOg159RWAsG2xhPZU41a6K2sYF0/61pe7sp6ZpH0h7S+cqKYPTFNo9cKdCHx6AobIxN+9eZP0CxM5DVzLky1ObPw7nIdzER6AXmY426hXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927022; c=relaxed/simple;
	bh=+WQjC0+RB1KLkzbox2DQePGoJ2XYaWmSvFcM3Ow2Wc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3mqw4ZdRDzAhvW5UJYum9124ViOpTaZdq5bvVjXvbEhZDLsR+Cb7PA+tixTOaavwiW4+agNvTaP8eATByKTaizFIRtvFKN4i25Msh/yGPdnya730q1rMPmBsupO7b0ZvqrN+RE1668/r42eRr9ruBmDCCz91LLXSulOPO4VaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WN9KxOug; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WN9KxOug"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343514c7854so1057822a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 01:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1764927010; x=1765531810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfSfHhhRxhuHB1Gi2FXvT3kyeAYb2F2W42PBtzI8LGA=;
        b=WN9KxOugb8wW3WcWGtylDdevIXLOfzTbZ982QVEJLGCly3DH6kyQYXMH57LgndZd+w
         4Zbg+PPfJPOIV9w0ySj/f/UNk4SJvYUJTPBmKBaPi2Fp2xuJ9SgnyV4GT6PeJS8WrwR8
         Y1YU629YEH11aJMCpSg3wn+O2nDsheabeSLKCeAF+Rk3t4l7dh5pdtPzQUsw+cOyMwvN
         d4ojfE4gpJN1c1pSLgTryVjigUGK0VT/0ohLrYrIQYMPHr8D+mznRj4zRoZkjvdyNeeJ
         nsEO0OhzPVNK8O1x5P36BWhqLYWITT+zmPmGRGJ6PdRifYDsQKxfSOnFo6Sx+l7tpTH/
         25Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764927010; x=1765531810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfSfHhhRxhuHB1Gi2FXvT3kyeAYb2F2W42PBtzI8LGA=;
        b=XfTJqWcNLtC0rOCpv817lgSV+ngCcFKJabzw+oiPbuqQl4R9X9v/GBtAFLr5QAJQF0
         Ubf8lvjDpgBca868IcHATOxrFiiYhb5xKbu1P6kVB3c4N/B9N1z0oNaftdcDEdGgdhEl
         lAT4cS3FXtmsxTxx/gdBbuH6h8pdHf8vNxEPZXLcIp+qNCCK7tgGBlMDhzlVZeSflfzo
         bTIw5ayE2altYVnOeL48PGINu45CcLjsq+ALu/FLlU1N3r7hcnQFK3akjnN93FVe1Xq/
         hePODGkwBZkOAlYUaol+XXoVhwvyxL6fnmzZtoIx390AE2SJdfk3VWdyQ05oY3J3qbsH
         XHxw==
X-Forwarded-Encrypted: i=1; AJvYcCVA6Mt3EW2ehkjRVo2NhyF/LDSweC8pINgLVcvrApj1PXMrCdD2u2HVZms7w0Fbb059K3RwLZzVBorXFa69BRckmlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jS1HHTgaoaR4uP9T74NrPt+eGiF5heGZ6F8RDSfzu3m83cn2
	36IJ/F4iGsFuz2H/OYHL4ILwVKbWMEhk9l4Sg7g1W0PpXm5iggxNAsO7WkwRrYCiwO0=
X-Gm-Gg: ASbGncvmOGMNNEUpqwf71HIBCxYuETMD5rZgusl7dCpt+rRo4Ryh3T+jHDrbJhJ87HT
	wBCyJZ/qznnvxEQkEnKUac9J0IWpRaUy407Bqj+xQo+mCdJTghKFU4c7FYL2SSScV993QzwDf2u
	uyVuCLPLWaPUG5to789ijvPRwmVGAINWwzDD1IghsyJw8pEwHLipfM2vzqrYKU/LIDMFXQvndwo
	t8z9+IHmLJSdJCPZY0XdtxWUHAscd9jSQiXINjL9lAoug82x1OFFgdIsLQi2Ekwp2zWii3pOYcN
	Nve+i4FYeYKXuaUU7oDej44C/Ne+QUtK4wx70zt4KKeuFPQzrof6cXiPv+yrhqtXu0BQHjOsKUW
	fJv9NmIH+JvvMZw4iFPhzYvBlMAfbKx1OK7cF3ZOAxp0XFe8D+ZtAGlbCCchXpARDuObTesewZy
	bw5ta65cbnqFPK2xlZjF/EBEVl0VHTCw==
X-Google-Smtp-Source: AGHT+IFEFED5ms0xzbwmgo/bYPVrz1E2ohbcd/UJJoUGT5C4HOXec3jJihUgwnpZE5vhb3Phq3BGGQ==
X-Received: by 2002:a17:90b:4b8e:b0:32e:3592:581a with SMTP id 98e67ed59e1d1-349438bdb29mr6465600a91.17.1764927010463;
        Fri, 05 Dec 2025 01:30:10 -0800 (PST)
Received: from n37-012-226.byted.org ([115.190.40.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a14f3fa0sm4093051a12.22.2025.12.05.01.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 01:30:10 -0800 (PST)
From: "qingwei.hu" <qingwei.hu@bytedance.com>
To: naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Qingwei Hu <qingwei.hu@bytedance.com>
Subject: [PATCH] kprobes: Call check_ftrace_location() on CONFIG_KPROBES_ON_FTRACE
Date: Fri,  5 Dec 2025 17:29:33 +0800
Message-Id: <20251205092933.3889547-1-qingwei.hu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingwei Hu <qingwei.hu@bytedance.com>

There is a possible configuration dependency:

  KPROBES_ON_FTRACE [=n]
       ^----- KPROBES [=y]
         |--- HAVE_KPROBES_ON_FTRACE [=n]
         |--- DYNAMIC_FTRACE_WITH_REGS [=n]
                ^----- FTRACE [=y]
                  |--- DYNAMIC_FTRACE [=y]
                  |--- HAVE_DYNAMIC_FTRACE_WITH_REGS [=n]

With DYNAMIC_FTRACE=y, ftrace_location() is meaningful and may
return the same address as the probe target.

However, when KPROBES_ON_FTRACE=n, the current implementation
returns -EINVAL after calling check_ftrace_location(), causing
the validation to fail.

Adjust the logic so that ftrace-based checks are performed only
when CONFIG_KPROBES_ON_FTRACE is enabled, ensuring correct
kprobe behavior even when KPROBES_ON_FTRACE=n.

Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
---
 kernel/kprobes.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab8f9fc1f0d1..f4aa4ba1ca9c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1512,19 +1512,15 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
 	return 0;
 }
 
-static int check_ftrace_location(struct kprobe *p)
+#ifdef CONFIG_KPROBES_ON_FTRACE
+static void check_ftrace_location(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long)p->addr;
 
-	if (ftrace_location(addr) == addr) {
-#ifdef CONFIG_KPROBES_ON_FTRACE
+	if (ftrace_location(addr) == addr)
 		p->flags |= KPROBE_FLAG_FTRACE;
-#else
-		return -EINVAL;
-#endif
-	}
-	return 0;
 }
+#endif
 
 static bool is_cfi_preamble_symbol(unsigned long addr)
 {
@@ -1540,11 +1536,9 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
 static int check_kprobe_address_safe(struct kprobe *p,
 				     struct module **probed_mod)
 {
-	int ret;
-
-	ret = check_ftrace_location(p);
-	if (ret)
-		return ret;
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	check_ftrace_location(p);
+#endif
 
 	guard(jump_label_lock)();
 
-- 
2.39.5

