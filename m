Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C23DEADE;
	Fri,  8 May 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248517; cv=none; b=lQdL+IxZxT9wrrEATGUwN0LjLuHbFnjs7gdubo4hxRAh9kxUe6drB/TnU5ZzYfziGwfVYkEqjlbHK3G56vD7KBllgMEILDYS/rlYtsGqLdd99dcb4iRny1UTD+8DMgfNlRtGO/zSBM6Z2FuwPghbqn78yn3PKz3fuj9eb2thoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248517; c=relaxed/simple;
	bh=f222Em/3i+qAi7/0qYSge4czNDjNG6mwwW2LVFH8Ox8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0GPpZHdI2ff6FE1ubFjOsONIs5CeaWkItEYJQuxLsFq5T1oLeAEnqeyjL4tb+YQXszysCmlGmKhOPdUyWA6zjzpc3mKMrW24lD4qmwDwA5ke0BjwqhtDWxsXRaPVEhq0dfhcRjaJUXUmWLQS/i3WkhaLLjKpma3RgGaFjv1Wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=K6sAgfbW; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="K6sAgfbW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=UPM3zmXLW3EKgqA4eiYR7WduPpfETtjolSsLgElu958=; b=K6sAgfbWXewh5tqPQ3xX8Ffgjx
	FJPqbAL8u4XD5YAOVPUCGBsudzSrjm9oxO45/Uoo+3RRRH4Gry0qc3D1PCaB0VNzZtkINooalWwON
	KBH08WCR/SAfzMEOGj2o4jsz96Ireu4uaPGxsFf9nnetQCw9uUk521EVocbZXAnAx8MMwOjir5d5M
	LKDyZx5IMYfnrHEJIZJLKYcpuK0pZ686Vs3QlNd39gLqpAIHfcR5sZWOJAlnqi4opV3h/Y6512P2a
	Og0Jz/zNLjnGzbv9sC7S9y+g9YSO/1yB5aJHdPAO0L5G9sa9yWdKVndzC0TtBelgLrOEv1xL6RfN9
	kETDAQLw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLfe-005Bwp-14;
	Fri, 08 May 2026 13:55:14 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:55:03 -0700
Subject: [PATCH 1/2] bootconfig: move xbc_snprint_cmdline() to
 lib/bootconfig.c
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-bootconfig_using_tools-v1-1-1132219aa773@debian.org>
References: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
In-Reply-To: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 paulmck@kernel.org, oss@malat.biz, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=5015; i=leitao@debian.org;
 h=from:subject:message-id; bh=f222Em/3i+qAi7/0qYSge4czNDjNG6mwwW2LVFH8Ox8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/es6Gnz9YMTq9Bg1o8NypksKSgdD+aRWJTsbQ
 w+hYs4CcYqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3rOgAKCRA1o5Of/Hh3
 bYAAD/9dyK1eSFVLlqUfYEOhJtH7vEyRUIbBcJRkXh4h7dy0LrRabFQmptQV4wJrMmSMrRfDAMS
 Ub/K1xCvQIi/HpDTBGggKL0q6JFGVP8WZoa000kXKg0r4V9yHRF7IEkJe7IwMe73YBAkVLco4OO
 y/xKlb9IFN2k3kZAJkUfYdN7kFQjOZaWHUaUL+A4mHfFdndF4I7BJhs+q/bpgYjt/cjXGqx/h+w
 CFghr6FYoQsKtEXku+aBKoOr48bUBWWsCqBvGeIXNr7MtUxB0qtezBb8A3/u+Elr1kygRK1qPMh
 USBRWYfQBQ9/+8SrVd1I9D7ZIRANj3YBfcD+mlYsjAbFS29ICbvjGD3NMoYp2ZxoL5VSmMsh5Ty
 9sFnsxIfgOyOH3RLbNZvjtFXfVV8PlEetOoNGBJOl8BG6YveaXHf8N7sRNLIYgzp7IQkOmIoiqA
 r+WO0tP5UAQEEJjrZHq/iut1HHKJxjdsFen4+Q60oUrHsfdwiXRbZb4QwQEOq2ZHbZXyDqDToKk
 HdVFiMKNr1eDd8w8i4EBPqLXPQOU+isWYLel9pRku3VBe9m8kb6idI03O/V8LJ4cCStplf1RYG+
 tve0G/kJLdN1rNlvFGWtfgyrzRU700fCT5YPMdlymzFUIile8y05DaRnLAWCtEMBPydqW5EHbKp
 WI1cLZI/O80Jc6A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Move xbc_snprint_cmdline() from init/main.c to lib/bootconfig.c so the
function (and its xbc_namebuf scratch buffer) becomes part of the shared
parser library. tools/bootconfig already compiles lib/bootconfig.c
directly, which lets a follow-up patch reuse the same renderer in the
userspace tool to convert a bootconfig file into a flat cmdline string
at build time.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/bootconfig.h |  3 +++
 init/main.c                | 45 -------------------------------------
 lib/bootconfig.c           | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 692a5acc2ffc4..1c7f3b74ffcf3 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -265,6 +265,9 @@ static inline struct xbc_node * __init xbc_node_get_subkey(struct xbc_node *node
 int __init xbc_node_compose_key_after(struct xbc_node *root,
 			struct xbc_node *node, char *buf, size_t size);
 
+/* Render key/value pairs under @root as a flat cmdline string */
+int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root);
+
 /**
  * xbc_node_compose_key() - Compose full key string of the XBC node
  * @node: An XBC node.
diff --git a/init/main.c b/init/main.c
index 96f93bb06c490..e363232b428b4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -324,51 +324,6 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
 #ifdef CONFIG_BOOT_CONFIG
 
-static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
-
-#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
-
-static int __init xbc_snprint_cmdline(char *buf, size_t size,
-				      struct xbc_node *root)
-{
-	struct xbc_node *knode, *vnode;
-	char *end = buf + size;
-	const char *val, *q;
-	int ret;
-
-	xbc_node_for_each_key_value(root, knode, val) {
-		ret = xbc_node_compose_key_after(root, knode,
-					xbc_namebuf, XBC_KEYLEN_MAX);
-		if (ret < 0)
-			return ret;
-
-		vnode = xbc_node_get_child(knode);
-		if (!vnode) {
-			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
-			if (ret < 0)
-				return ret;
-			buf += ret;
-			continue;
-		}
-		xbc_array_for_each_value(vnode, val) {
-			/*
-			 * For prettier and more readable /proc/cmdline, only
-			 * quote the value when necessary, i.e. when it contains
-			 * whitespace.
-			 */
-			q = strpbrk(val, " \t\r\n") ? "\"" : "";
-			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
-				       xbc_namebuf, q, val, q);
-			if (ret < 0)
-				return ret;
-			buf += ret;
-		}
-	}
-
-	return buf - (end - size);
-}
-#undef rest
-
 /* Make an extra command line under given key word */
 static char * __init xbc_make_cmdline(const char *key)
 {
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index c470b93d5dbc2..f445b7703fdd9 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -408,6 +408,62 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 		return "";	/* No value key */
 }
 
+static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+
+#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
+
+/**
+ * xbc_snprint_cmdline() - Render bootconfig keys under @root as a cmdline string
+ * @buf: Destination buffer (may be NULL when @size is 0 to query the length)
+ * @size: Size of @buf in bytes
+ * @root: Subtree root whose key=value pairs should be rendered
+ *
+ * Walk all key/value pairs under @root and emit them as a space-separated
+ * cmdline string into @buf. Values containing whitespace are quoted with
+ * double quotes. Returns the number of bytes that would be written if @buf
+ * were large enough (matching snprintf semantics), or a negative errno on
+ * failure.
+ */
+int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
+{
+	struct xbc_node *knode, *vnode;
+	char *end = buf + size;
+	const char *val, *q;
+	int ret;
+
+	xbc_node_for_each_key_value(root, knode, val) {
+		ret = xbc_node_compose_key_after(root, knode,
+					xbc_namebuf, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			return ret;
+
+		vnode = xbc_node_get_child(knode);
+		if (!vnode) {
+			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
+			if (ret < 0)
+				return ret;
+			buf += ret;
+			continue;
+		}
+		xbc_array_for_each_value(vnode, val) {
+			/*
+			 * For prettier and more readable /proc/cmdline, only
+			 * quote the value when necessary, i.e. when it contains
+			 * whitespace.
+			 */
+			q = strpbrk(val, " \t\r\n") ? "\"" : "";
+			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
+				       xbc_namebuf, q, val, q);
+			if (ret < 0)
+				return ret;
+			buf += ret;
+		}
+	}
+
+	return buf - (end - size);
+}
+#undef rest
+
 /* XBC parse and tree build */
 
 static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)

-- 
2.53.0-Meta

