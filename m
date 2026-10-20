Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493239;
	b=d4W6ZZwskedLPNMKMuBS134wZQoy6ZsrRp3PVAhwPQYskky9otZ2plMV/LZTm84O/x20
	 Czoz/VE7LdFWEtwnY69LFO5xI6IsfBNYh9F9RaKQFKlfJzwp8ymQH4aAFgXwP6pvQZcIa
	 AKp6hAroE5+i0PykyjoYokcJEGzgjH/1JLByiYVPMbiMyYGWIMn5/uIG+vQMEwdRHtP6S
	 VeIcVoHlUp5O594ReaeW5sV14TMam3nFmSZlj8kDlKRL2YdZnf6WNWeW/DGmJ2m2KS6fF
	 nS3b5GRC49rdShTve5reAk57tL01HOOgZMC/E8DafzzN8ixEXl8P/MWYw+LavB4Keyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GAljeXhhGctTJAsFs5vdWd9WviVjL6ZokF4pF61nrrU=;
	b=rhD946/ZP9CDAAPt1YHur8sHwSFIvU5W21ZLLk0/6l1FTBzAIMPGx6xcI7HvOJGchVfn
	 JMEVpZc0+a/XKhjzu89y+5OGqOZPfiD3HUjddz5Jn1r6wHf5fRXfF64uzzYF4FYB1e8Gv
	 LCTT+zTkiCAC3HCI80kIAvnKhhVbCy1YAG5SQtMYnRKLn8Q+VavRyAXlRDG4Ua9gZJSLW
	 EI/f27y9LgFiaIerjsLiTikuZPZpnvOf6FSMQ9/gL7aYYxr+8PsF4Qo34RYIgu2E2EYSc
	 fiZxQHPzzm/A9H15OBYW36IMzFDwB1/rmGv6PSEn02ZGkYSJ18AlsH9QGRcLkqgtoVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lAsskpuq;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC07606A31A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 10:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC07606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lAsskpuq
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1827501a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 03:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792493237; x=1793098037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GAljeXhhGctTJAsFs5vdWd9WviVjL6ZokF4pF61nrrU=;
        b=lAsskpuqaqz4p3mu4UNdhV05SJ02C1JsO3EZTv/7Llu9pJV7WtYbKgeERpVdQNT89J
         iHTGf36IY0h6TTmEHu3bbaXRLsJdxVExiA1yHjUflZuGp8jf3IM5AjbYKBRgovKuF0HM
         UVc/JEXc6FCXtebLKnxJZC8mlZTWRSW2ppt3wg4HXZ0RtR6vwgDUtNPq5mu0Tu2PoTbr
         1QFTWM+5ZJTj/z6If7SeYzb0voeBrqy8/a4vHt7As2zFdXF8qxVwsrVzbhjlJdoQMsDc
         fmMWUw8U/F9y+PAOv/nJqlaZm3mF10tQxiiYaVXQsV9k3+UYJIrvQ8mapA4X7cconjji
         LBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493237; x=1793098037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAljeXhhGctTJAsFs5vdWd9WviVjL6ZokF4pF61nrrU=;
        b=xnOakWV3MH/00+qeSt3Sv3tm2rZMKmiNWa8+It7jyXkAQKk5GB8mU+mfFVdnrybPAV
         23rM4Y+TIlmw9OyXCdxekk82iTX5mllwXe5NqbsLAJ3BzSJYj3UvocuADWm3tAggd86H
         MrLm8wnDFZ6WwyECRl7Sb8PeaVbNS1CcQ+gdAMiJ2E6FjL5bPZdUhCbmfqIniIKUBiYU
         IcU3KEpx4lhiLnERxqWW68xDari1QNVqXL6russLFZu799qpwVLP7sbpCYLQyFMFAxZe
         jCc0bn9L1IxN/q6nms9CgtRXCwk4Vfpwi8z3Sw92uw27Tvu+x89jW6xppImHCPfBzyaD
         bE8w==
X-Forwarded-Encrypted: i=1; AKwUvByV9OW3Sg+qNRPbOjz2dnXeNVucEYAnIGmUQO7MBsYWay0DZEI2/hot7+x3JJGQrI9olE9mnM0t94OuvyvPX0bPpbk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIE1c+OWZDFFidTa6onZegpiLPLBo1E3mmnC3Adev2zyqQIvhYK
	JqEpF2csPHD2avn+gXy5Rn0vRfIsREJJjbclWWE4JEgOJd2Q4K1jfOmt
X-Gm-Gg: AYBFou2cNjn6ARJzWKzAN33sEoqXSd2JruX3s407ymosjs2GkiZzCrCY6AWRSDm70d8
	UasmCcFiBBWU1rRsZ8aattzmaT8JrHwmLbGgyAXv2zbN2A7McXFFWxLNzsvrR6RA3Wh5XY5VjaY
	AMqjS3fwJLqs7x2XiyhsMzyj3wiXXstBJu7YFD218D9AStdQhmuecYoYboWmtlLAk658vnaNb9k
	XKSl/t4pE/kToGVbN2v9aBl8Mx1ND/1fmBiSFVS/CzEC+CJSoBc62S5RFrFFtKmfcMbRKzuWEGS
	6nUvwJo8MdaC0YUAh5haEHc0T9dlHXO44xYbIZ4FCmkFMQticQ9RQ8O5IzxAIYi2YkFtjFm1ail
	6nNX/v4W05DrnQKi4qSsnChfPdINW57EdAKdX46L+tfU5xyfi9jEnVorxJqmfVnspRskzCaMX+P
	T3pk3JEFTkzbn9uDaPghPeXCtyMdIgvwl/LwZXK44DcqARzp4Ltb+ybkZSwb7CagjnYLyU718Dr
	+WgKZsNas9/Ov4=
X-Received: by 2002:a17:90a:d604:b0:3ab:1b19:78ed with SMTP id 98e67ed59e1d1-3aceefae04amr8089642a91.21.1792493237276;
        Tue, 20 Oct 2026 03:47:17 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d4004efsm3212903a91.5.2026.10.20.03.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:47:16 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH] fgraph: Format error pointers as signed errno values
Date: Tue, 20 Oct 2026 18:47:10 +0800
Message-Id: <20261020104710.2366146-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: pengdonglin <pengdonglin@xiaomi.com>

The BTF-aware funcgraph-retval formatter currently treats all pointer
returns as hexadecimal values. Error pointers returned with ERR_PTR()
therefore appear as high unsigned addresses in smart mode, obscuring the
underlying errno.

Recognize error-pointer values for pointer return types in
btf_trim_retval() and select signed decimal formatting.

Before:
  trim_retval_ptr_error(); /* ret=0xffffffffffffffea */

After:
  trim_retval_ptr_error(); /* ret=-22 */

Users who need to inspect the raw encoded value can enable
funcgraph-retval-hex, which produces:

  trim_retval_ptr_error(); /* ret=0xffffffffffffffea */

Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/trace/trace_btf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index bcf65fec7bb1..1201105aa48b 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/btf.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/kallsyms.h>
@@ -197,6 +198,12 @@ void btf_trim_retval(unsigned long func, unsigned long *retval, bool *print_retv
 		if (signed_type && !hex)
 			*retval = sign_extend64(*retval, msb);
 		break;
+	case BTF_KIND_PTR:
+		if (!hex && IS_ERR_VALUE(*retval))
+			*fmt = RETVAL_FMT_DEC;
+		else
+			*fmt = RETVAL_FMT_HEX;
+		break;
 	default:
 		*fmt = RETVAL_FMT_HEX;
 		break;
-- 
2.34.1

