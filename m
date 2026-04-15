Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F1346A1C;
	Wed, 15 Apr 2026 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250287; cv=none; b=QY9Tm62KqgW4WoOSeIw4qTkthDEQqfvc9heaG3bjYSvLpJVYVfWMeaFJz/Hanxv+BNAbjJzLv9YhT/RylzrB/S5GSyPysbO/sK7HU8HSdo0HlUDe9RNmOYi+8g9JWsTU5zE3PrqQDDqm25xoUzP4QNqJv0SMcZkDNBmSMY/IgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250287; c=relaxed/simple;
	bh=D+JK71Dn+lRILKBdWtEaIvJsNkD8TO2j7urH1sFvhdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQyg68HQBIv7AK4/9wG3cIMBlD7UBt8MaYEz5OC+UnaIWpnFktHad4VKquQlnL6ie7RIeh/D4VoPRtkr8GySNDk80hbhIn+A0MPqpjDf16GNxe9hxaHQKvvnv7hxxQEHkRtFzSPPtADBxDVF+t7azSO/ntlEYUc2VfMuXDyfJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=W2L65QSV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="W2L65QSV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=+15wd/77R1WY2fKUlSl7uq+s5kLFa6U/bFrsG3puXDQ=; b=W2L65QSVuKZpQPrG3tdaGfK7eT
	xMAYkr91q5G9ORzdSFA+f+uZVF4lz2aRLR5VidTkycOzF/rM5GhGjAbwCaIBa5AA3BKIoFI6pBhoy
	12O9QtLIzEeysHMlVAO+W+zLu2P25If3B0D4L317KPVO+xvuIo3qkMkdtDnel37e9kjRwWI7otto7
	K4cYEtd6v3R2PLvjn3WTU00TbLMf5jUEOBWxsnGXPPxiUj8sBSkSM9oDHEC4AwefpTZ3gMtateZf4
	/au7I7Fk9EPxdYzvP3WTHIPofPkvhw9f7Qqg3bDSqXB1O9c8MqrkZLxc3LWIf3KqPFGsdlI+9LQYV
	cOI7xq1A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCxq5-00DmiK-0b;
	Wed, 15 Apr 2026 10:51:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 15 Apr 2026 03:51:10 -0700
Subject: [PATCH 1/3] bootconfig: use static buffers instead of memblock
 allocation
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-bootconfig_earlier-v1-1-cf160175de5e@debian.org>
References: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
In-Reply-To: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: oss@malat.biz, paulmck@kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3487; i=leitao@debian.org;
 h=from:subject:message-id; bh=D+JK71Dn+lRILKBdWtEaIvJsNkD8TO2j7urH1sFvhdg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp322hVN/fArh78LiS22R93QZ1KA6LQMcERZATX
 X5382rGfpuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCad9toQAKCRA1o5Of/Hh3
 bQ1AD/9SzsxsgmABDeWNGE8a4G3K7n9rMMxa4AzHGbWc2qoLR8sK7bA+Y1DqvXOyBu4cPazjcH0
 t1kO+434Vhsr9PVmEu8k7m4ScnsJrMB4RsrPv8IsotxTJp4mOZljdtVI16cTAPXb9YUqYL+lzea
 erdoJsErR7PTD6i1BpytGCrIGEUO+630JrELpVf3XFqPIvSrGLtI9f4vgpOMUb0j5pech6FjiOe
 qyf0N29GnYTtYvHA5Fcgth+1yC44vDf4NeGUESgWC1s+5RIVe4S0FKUumYKyBEi5JqLpsh13VgQ
 +ADLfiAz44l8Z8ZG8Sb7xwR+iel38+zBwFJZF56dDSSHGRAHt+3Vzl2sNogl/dlXw+mnSkYfT4g
 FllgHTsIjusyLS/p1Gzn3puDTo91uQPtYJtlNqPEPHX2l+DLkIlAQ4+kZmTt53MdJu3BMLvSqgU
 uthcanEKE5ambq5mx5GPJPeLPdf36vzB8GFNuUZiH6y+rJ6ToP/LmsosdCrd0RpCa7XwCumUGA2
 lPf7ouNY9iZpfYrYkXsVtPKQMNUBsOd8yS5GITFbreiH/zLqsavrqQB11nkdDwBV001qVXV7vFw
 zN4MB3Aa9yfptFAzeW+h3lMVT3dtZ0nXGlc9wORCZzWTxnl1NCdcUJBvlO7QDsnB307+svEHxS2
 I4QNXLNTxXktofg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Replace dynamic allocations in the bootconfig parser with static
__initdata buffers. This removes the dependency on memblock being
available when bootconfig is parsed, which is a prerequisite for
moving embedded bootconfig parsing earlier in the boot sequence.

The static buffers are:
- xbc_data_buf[XBC_DATA_MAX + 1] (~32KB) for bootconfig text data
- xbc_nodes_buf[XBC_NODE_MAX] (64KB) for the parse tree nodes

Both are __initdata and freed after init in the kernel. The userspace
tools path (tools/bootconfig) also uses the same static buffers,
which simplifies the code by removing all #ifdef __KERNEL__ blocks
from the parser.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 lib/bootconfig.c | 56 ++++++++++----------------------------------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index c470b93d5dbc2..3e529325c90ac 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -15,12 +15,11 @@
 
 #ifdef __KERNEL__
 #include <linux/bug.h>
-#include <linux/ctype.h>
-#include <linux/errno.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
+#include <linux/ctype.h>
+#include <linux/errno.h>
 #include <linux/sprintf.h>
-#include <linux/memblock.h>
 #include <linux/string.h>
 
 #ifdef CONFIG_BOOT_CONFIG_EMBED
@@ -54,33 +53,12 @@ static const char *xbc_err_msg __initdata;
 static int xbc_err_pos __initdata;
 static int open_brace[XBC_DEPTH_MAX] __initdata;
 static int brace_index __initdata;
-
-#ifdef __KERNEL__
-static inline void * __init xbc_alloc_mem(size_t size)
-{
-	return memblock_alloc(size, SMP_CACHE_BYTES);
-}
-
-static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
-{
-	if (early)
-		memblock_free(addr, size);
-	else if (addr)
-		memblock_free(addr, size);
-}
-
-#else /* !__KERNEL__ */
-
-static inline void *xbc_alloc_mem(size_t size)
-{
-	return calloc(1, size);
-}
-
-static inline void xbc_free_mem(void *addr, size_t size, bool early)
-{
-	free(addr);
-}
-#endif
+/*
+ * Static buffers for bootconfig data and nodes. Avoids dynamic allocation
+ * so bootconfig can be parsed before memblock is available in the kernel.
+ */
+static char xbc_data_buf[XBC_DATA_MAX + 1] __initdata;
+static struct xbc_node xbc_nodes_buf[XBC_NODE_MAX] __initdata;
 
 /**
  * xbc_get_info() - Get the information of loaded boot config
@@ -930,11 +908,9 @@ static int __init xbc_parse_tree(void)
  */
 void __init _xbc_exit(bool early)
 {
-	xbc_free_mem(xbc_data, xbc_data_size, early);
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX, early);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
@@ -973,24 +949,12 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 		return -ERANGE;
 	}
 
-	xbc_data = xbc_alloc_mem(size + 1);
-	if (!xbc_data) {
-		if (emsg)
-			*emsg = "Failed to allocate bootconfig data";
-		return -ENOMEM;
-	}
+	xbc_data = xbc_data_buf;
+	xbc_nodes = xbc_nodes_buf;
 	memcpy(xbc_data, data, size);
 	xbc_data[size] = '\0';
 	xbc_data_size = size + 1;
 
-	xbc_nodes = xbc_alloc_mem(sizeof(struct xbc_node) * XBC_NODE_MAX);
-	if (!xbc_nodes) {
-		if (emsg)
-			*emsg = "Failed to allocate bootconfig nodes";
-		_xbc_exit(true);
-		return -ENOMEM;
-	}
-
 	ret = xbc_parse_tree();
 	if (!ret)
 		ret = xbc_verify_tree();

-- 
2.52.0

