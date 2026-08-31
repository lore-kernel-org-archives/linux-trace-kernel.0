Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9CB331ECE;
	Mon, 31 Aug 2026 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173526; cv=none; b=SvT5vMVB7l3aPgv2jZj9bnCiOWvDkYYSezJsoWQnbaJbmo7SbFqAwYhfsuyZUrqxCwn82f7AMIa1sBpscbJgLtjccux7DOBuiHaDWN+N4YLXE8CbMA71fmVzJxYFKbPDFQth+mvs2y32c0SeiHzurKsRDEwVES5RPiXuc5iVLBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173526; c=relaxed/simple;
	bh=PiKeVg8e8UKHYDNUXZfYgiFePiJotrVC4CVa/1bm/hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mN3FV0K7JrZwelBSgPhoXoGevAYuy+9BV6zgjFNaJxSBjPW1RGawKTb85L04T8TxNf+g+NMs+P0eU1Nd3IUMjMPtsNyEdZliBSJ2k0dNO1jFrsEC7rUWC2a7jRquv32BYmvlriNnCO/5MPUE2pppbFDZDvlUBa2FW3UyLnHpQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDo4j8F/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDo4j8F/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177701F00A3D;
	Mon, 31 Aug 2026 10:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788173524;
	bh=PzPJqYV2Z3jWTTT76OFLc6aimjwQcEYnVGSdt63AIRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gDo4j8F/vCM46WNGX/1FkeZv7Q7bfZnnqRxcKmPBkoqWAjKsZZEiK83HZQBPS4ZDw
	 FpITnoh0ocyjHWkPyETe+lWRPNlYXF/6XoNJg0vc/Mhp3PZzT0mC4/GIRRdwCcYcNk
	 mgivsE0xwb3uTgCQJi0+iFSY072J4ikBh0LhowEQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 12:51:46 +0200
Subject: [PATCH v2 1/2] module: pull out add_taint_module() to be public
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-bind_taint-v2-1-1082d631213b@linuxfoundation.org>
References: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org>
In-Reply-To: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Bradley Morgan <brads@mainlining.org>, 
 Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2631;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=PiKeVg8e8UKHYDNUXZfYgiFePiJotrVC4CVa/1bm/hQ=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFlTY86KMrOeb+KccWNdYiu/Y9b1JE6xrP7f2q6uPzW3R
 666tq6oI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbydw3D/PqJJ8PPWQqdZDl2
 pZo5w+ahoMryKob5Eams5Xze9332vtonzH7hTf6fVNFOAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Other kernel code might want to call add_taint_module() so pull it out
and make it global.  If modules are not enabled, this defaults to a call
to add_taint(), so all is fine.

Reviewed-by: Johan Hovold <johan@kernel.org>
Tested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/module.h | 10 ++++++++++
 kernel/module/main.c   | 16 +++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..0636e0f2728c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -29,6 +29,7 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
+#include <linux/panic.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -770,6 +771,9 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
 
+void add_taint_module(struct module *mod, unsigned flag,
+		      enum lockdep_ok lockdep_ok);
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -877,6 +881,12 @@ static inline bool module_is_coming(struct module *mod)
 static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
 {
 }
+
+static inline void add_taint_module(struct module *mod, unsigned flag,
+				    enum lockdep_ok, lockdep_ok)
+{
+	add_taint(flag, lockdep_ok);
+}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..444d990c9983 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -191,11 +191,21 @@ static inline int strong_try_module_get(struct module *mod)
 		return -ENOENT;
 }
 
-static inline void add_taint_module(struct module *mod, unsigned flag,
-				    enum lockdep_ok lockdep_ok)
+/**
+ * add_taint_module: add a taint flag if not already set for a specific module
+ * @mod: pointer to the module that caused the problem
+ * @flag: one of the TAINT_* constants.
+ * @lockdep_ok: whether lock debugging is still OK.
+ *
+ * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
+ * some noteworthy-but-not-corrupting cases, it can be set to true.
+ */
+void add_taint_module(struct module *mod, unsigned flag,
+		      enum lockdep_ok lockdep_ok)
 {
 	add_taint(flag, lockdep_ok);
-	set_bit(flag, &mod->taints);
+	if (mod)
+		set_bit(flag, &mod->taints);
 }
 
 /*

-- 
2.55.0

