Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676ED560AD9
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886647; cv=none; b=WAq+M54okp+lNA3QFTtIMcuOfNyDvZ9bmfEb8HmT2d6iIxLwa8SJCq+oTlYyZFrdgYc2XszvuyAYdA61pJTDbMLgVhWPL1d5w7DaeUvsJAIOrY5L9rl3NfPQ92frItBZK7/g8q7EIKCSdlSvR6SipE6sCm9kYAxo0IdfMjXrp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886647; c=relaxed/simple;
	bh=45Nx6mdux72zOSA/lMdPUw+Nkjgqgdg/BTEFOpgcX+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IixQ04umfD/kFcLzD3IElnTMhI64Rglp/CBqOTwhwzKUnWy9pBqKKqbbtYApNyEpinX2bMGBBEU3261+yk1gPQ06sq+SKR0Ox9ZKQ+rxC9Ac2YgWtAHXp1CA6T0Qnfv6XrnE0Q854FYPDc4DnD/Ga3Ov6vfeQ8muTg/8tlo5PQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/l7w2gB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/l7w2gB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d9520b9155so39861225ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886646; x=1789491446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GwMrjK6wt6egFNTNZhNQCN0gjojB329iHqLUHLdxdR4=;
        b=n/l7w2gBHF8l15sdFDpfIWxo/tnczv3oioeyVi9j2sB7jnqdLsOuMdIqAt7dKGmXMO
         30H1I9DUc1J2oNM/tNM5vBOrD6fWxhBxs1W54W/88hfr6t3VL8SpM7FLoeUm3AjvUUcQ
         wnzqdzXla++TuDLR8HErAe6r3UGBAVgBUewMK8OeHXRPcpS20I01or3OmN7ShCPDrJYd
         8lOWitQwrmdodToecukTvEmzW0foqXRhv7Zrv3MmhcY/hbJCOnOmDY4dxtoCg8btyRpc
         RUEaPSFmnh3I4Q+bYtL/iFFhmdDooqB3C1R5sqYxvQzAv04gqu60nJkkF91+gEoTixGk
         ajcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886646; x=1789491446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GwMrjK6wt6egFNTNZhNQCN0gjojB329iHqLUHLdxdR4=;
        b=Jl/W4Kjegc4gn8rmtHwYqWbzPGqpPE0hIR9MrBx9wkTAAykjm0DAUn5WcR8wS+SIBC
         F4KQ3RiF/mYdb1Q2X8zrKJWq0KvuWaRPbb9G8JuTM7cUu+siXWWLoD59u1jikiEOCzA1
         n3irG8V4lO23GZgz0nyBsHAU9CkRyZMuUv/7Xhcy05yV2MYGcSn+wCR2anvvHWTfXcMe
         sVYca6HSA61qgwClJtekFySE/n/cT/qk/jtoq52Vnwx8yEFRTkWp0tDVsrUVa0ypekLY
         TpzZ8fK1cBMT7yUkeKb+Qsswze0T7mT7fqILNOCyaVem1IVKLqegUevKMi0vm9xI5Pz6
         pXOA==
X-Gm-Message-State: AFuF++mBrqy5kgC+qJkH9oPD7AB8RNcEt1UpHzJ6uTQoPhItcd7elzDI
	p8i65LkzgvSMuiNiaFKFEK3ZEIe6Tt51iRoZE7pLnj5Jp8vldps5vTt2
X-Gm-Gg: AYBFou34HKvHQpLE7mU7mtsDROScdy0pU8yC84/BnkmMPtqYnoiimDOnGwzBB5bR6NY
	sz4ZuXYrPgBdyH+DU1HqFG20Lhtuiv8feAwgLkAMPhQ/4n+tU9vXOyTR/ocMGzXLLtjciQM+O+N
	55cRL5OmrZbTrXgvQGuluT2X8YFHFRHE1BrQqCi6j+rf6xiBO1EBdFdgPiP/VH/Ti9zAR1VVZx6
	KFDtHgFma2w1ZbLcvvAn2ebdAYadckS6x2FUxNQR7kJkj8Lho6tBJ3BaBXsP4yH09+6de25wBdS
	1HWXZaB3td+ZFe2XjQx3RodnqDR9i6y61g06UgDGE/NlYI3nagaKruuFQ2yhRZSNJy/5L89ZRxb
	4Zb4a2MFpg0rR63nRF7eX7hZWTd08h68VXE7y7sCmL2IC9YQsvwuFZLG8L8iNMPbG7TM5Ikqq1i
	DNAbIXXAHcb0UqlJKfigJrCvC2H5SJvtWFC/I9Xl1fBrPx4WzjITKUBE92
X-Received: by 2002:a17:90b:5148:b0:39b:ac66:bbc with SMTP id 98e67ed59e1d1-39bac660f43mr806888a91.7.1788886645382;
        Tue, 08 Sep 2026 09:57:25 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm27410639a91.9.2026.09.08.09.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:57:25 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: merge _xbc_exit() into xbc_exit()
Date: Wed,  9 Sep 2026 01:57:11 +0900
Message-ID: <20260908165712.1703439-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 87ce9e83ab8b ("memblock, treewide: make memblock_free()
handle late freeing"), both branches of xbc_free_mem() call
memblock_free(), and the early argument has no effect.

memblock_free() also does nothing if addr is NULL, so the check
before the call is redundant.

So remove the argument and the NULL check, and merge _xbc_exit() into
xbc_exit().

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 include/linux/bootconfig.h |  7 +------
 lib/bootconfig.c           | 22 +++++++++-------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index deda507500da..fdc15b6f4d1b 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -291,12 +291,7 @@ int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
 int __init xbc_get_info(int *node_size, size_t *data_size);
 
 /* XBC cleanup data structures */
-void __init _xbc_exit(bool early);
-
-static __always_inline void xbc_exit(void)
-{
-	_xbc_exit(false);
-}
+void __init xbc_exit(void);
 
 /* XBC embedded bootconfig data in kernel */
 #ifdef CONFIG_BOOT_CONFIG_EMBED
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 89c88e359179..aba11caf6903 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -187,12 +187,9 @@ static inline void * __init xbc_alloc_mem(size_t size)
 	return memblock_alloc(size, SMP_CACHE_BYTES);
 }
 
-static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
+static inline void __init xbc_free_mem(void *addr, size_t size)
 {
-	if (early)
-		memblock_free(addr, size);
-	else if (addr)
-		memblock_free(addr, size);
+	memblock_free(addr, size);
 }
 
 #else /* !__KERNEL__ */
@@ -202,7 +199,7 @@ static inline void *xbc_alloc_mem(size_t size)
 	return calloc(1, size);
 }
 
-static inline void xbc_free_mem(void *addr, size_t size, bool early)
+static inline void xbc_free_mem(void *addr, size_t size)
 {
 	free(addr);
 }
@@ -1123,20 +1120,19 @@ static int __init xbc_parse_tree(void)
 }
 
 /**
- * _xbc_exit() - Clean up all parsed bootconfig
- * @early: Set true if this is called before budy system is initialized.
+ * xbc_exit() - Clean up all parsed bootconfig
  *
  * This clears all data structures of parsed bootconfig on memory.
  * If you need to reuse xbc_init() with new boot config, you can
  * use this.
  */
-void __init _xbc_exit(bool early)
+void __init xbc_exit(void)
 {
-	xbc_free_mem(xbc_data, xbc_data_size, early);
+	xbc_free_mem(xbc_data, xbc_data_size);
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX, early);
+	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
@@ -1189,7 +1185,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
-		_xbc_exit(true);
+		xbc_exit();
 		return -ENOMEM;
 	}
 
@@ -1202,7 +1198,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 			*epos = xbc_err_pos;
 		if (emsg)
 			*emsg = xbc_err_msg;
-		_xbc_exit(true);
+		xbc_exit();
 	} else {
 		ret = xbc_node_num;
 	}

base-commit: 85595d3f964825c833fd2597521fcef67c3071de
-- 
2.43.0

