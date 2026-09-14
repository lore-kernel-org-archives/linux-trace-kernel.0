Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223B47F791;
	Mon, 14 Sep 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396260; cv=none; b=MRmijD9BqaS3U7mXnBhzB8IaN3UEYeFcI7Me49ekVo4eBYhlz8aBnbwkkmRT4LVqIQjxO9Y6Z5BFyFREubyGFm3V5UxZ3ZbnNc9l5lJMubDwP6cC7BFLKuSF2x1n18O80AXhD0y0Pz+8pCOubo13H+LINQGNNvznsE52BgHaWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396260; c=relaxed/simple;
	bh=rB0gS0/7VR217VT3T628b9RwU4hsVyXcwKPN7D+kptY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPPP5zYDRu2iOEihrLp7fSrIp6TOh1ysHAPO/hTVzfmO8EMtQIly9WWUM4l0SMVkmT500RBFWPDJzijigeRClNbHjfvsg26s4a5PA6rXJYmZsOQp5SZJ0Bhb49f9fFpnNIGYuOc3dZysmNp4h96S0/qqypGlvxBRY5oRl6LzKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ye/cwf8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ye/cwf8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F82C1F00893;
	Mon, 14 Sep 2026 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789396258;
	bh=Ts4nmcnRuTobgxxVWZKuuAu6DjtIQRF+o73GWydBbk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ye/cwf8jGIOQEZuP+QmxA9EevHaCQZlEWundsTWXDVE50FBN3bSMUoM9JYDqWtqG2
	 iC9GjDHAXRxrtyc//EXzyuyjdNPkvMwqb09auZApdiGCkUqe2/bPfLic9eCrTG6bDx
	 jXmlx9HXgA7W5lwAMVmu+Api3g2QP7DrWxQdNvFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 14 Sep 2026 16:30:32 +0200
Subject: [PATCH v4 2/3] module: fix up documentation for add_taint() and
 add_taint_module()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-bind_taint-v4-2-eadf8a090903@linuxfoundation.org>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
In-Reply-To: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=rB0gS0/7VR217VT3T628b9RwU4hsVyXcwKPN7D+kptY=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkrWIVEV5gt3Wdulyb3YpOmXeG6py9ZDhyvjljpvnSm9
 Apn5hDtjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIzSmGBUsurtg94d/m1V2+
 HV3xi69/nxnGuoZhQffkqzVHbnq86J0cqXg7ZdIVq50huwE=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

When add_taint_module() was added, the documentation for it was copied
directly from add_taint().  But that documentation was a bit wrong
(wrong variable name, and misleading boolean reference.)  Fix up both
functions to have the correct documentation for how to use the
lockdep_ok parameter to these functions.

Reported-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/module/main.c | 5 +++--
 kernel/panic.c       | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 444d990c9983..369794876c3e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -197,8 +197,9 @@ static inline int strong_try_module_get(struct module *mod)
  * @flag: one of the TAINT_* constants.
  * @lockdep_ok: whether lock debugging is still OK.
  *
- * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
- * some noteworthy-but-not-corrupting cases, it can be set to true.
+ * If something bad has gone wrong, you'll want
+ * @lockdep_ok = LOCKDEP_NOW_UNRELIABLE, but for some
+ * noteworthy-but-not-corrupting cases, it can be set to LOCKDEP_STILL_OK.
  */
 void add_taint_module(struct module *mod, unsigned flag,
 		      enum lockdep_ok lockdep_ok)
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..892045d8409e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -948,8 +948,9 @@ unsigned long get_taint(void)
  * @flag: one of the TAINT_* constants.
  * @lockdep_ok: whether lock debugging is still OK.
  *
- * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
- * some notewortht-but-not-corrupting cases, it can be set to true.
+ * If something bad has gone wrong, you'll want
+ * @lockdep_ok = LOCKDEP_NOW_UNRELIABLE, but for some
+ * noteworthy-but-not-corrupting cases, it can be set to LOCKDEP_STILL_OK.
  */
 void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
 {

-- 
2.55.0

