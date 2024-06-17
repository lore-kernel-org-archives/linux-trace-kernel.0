Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65CDDD7;
	Mon, 17 Jun 2024 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649506; cv=none; b=PYf/IcUtREGfjUIftTtU4lWmcJakJ03q28GUaA3qKS7HIW9sXRPzR7Ord1TmM92L+kn6DhDhWP9mW90QGYAuOqpOeJrjuCKRXpFoTneEfgcPnzyWzeyefE2y8Xg9QmZT2e26PscjYB0fPzteNW1EjBJwrkvvHtZKSDB1Tf4L8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649506; c=relaxed/simple;
	bh=FOB17oFouDgBVDfGthNlUyZopRj+WFqI2vR+CJXhUv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IxgPnlIPaEd9odNhfgRUnf8evheGiYiIBii5WCMDMnUTopqF6/cu/GEqKY1HpBvAPstEZyEgmcJszsswQY8OX5jgQ6TZJO7TOLs5aAIaHNpGbCEw6i88AG+bLzjB3i42kT2UyHulkoiuReg8OUYHzVFqHGrcx+rOPes7S2DBh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=0lrzpbb1; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="0lrzpbb1"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3766DDACC8;
	Mon, 17 Jun 2024 20:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1718649493; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fkX8p9YHUlga3ceEGkfVb9C99KqLrEWgX258cj34lg8=;
	b=0lrzpbb1f4Jm6Vk6Bf1xlB9CfOEZgsePvSjjIucMWaWLpUD6P8D3c8z8L3l5qblJ3UMS1v
	ahvu1KbgBZVV+PS0KWNoXpZzbuB7OiYsW5XEjYuepQ9xMuhdl0SWHzqwHHX9diwJi7Y2Ix
	H/eQxIYjku0zHDQvHIbaqGWUiSlsAcpKNECcDmAxOwIJf6C40zC5Wzsdi9DmwmrF9yGM+0
	iLGnjWCDdQfQ06F84KV1UvVbSyy885TywQUogsiudAHvqYf1CmP1X18zh2QB/33pEK1UY0
	lxiTMZKZMvoUniOjws13gLkiFy1qoz2jcUaJ66Squ/RiGC/QZeb78RKA2NSGuw==
From: Daniel Wagner <dwagner@suse.de>
Date: Mon, 17 Jun 2024 20:38:04 +0200
Subject: [PATCH] tools: build: use correct lib name for libtracefs feature
 detection
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rtla-build-v1-1-6882c34678e8@suse.de>
X-B4-Tracking: v=1; b=H4sIAIuCcGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nz3aKSnETdpNLMnBRdC2MDI4OkxDRLI3NzJaCGgqLUtMwKsGHRsbW
 1AL/40SNcAAAA
To: Daniel Bristot de Oliveira <bristot@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.13.0
X-Last-TLS-Session-Version: TLSv1.3

Use libtracefs as package name to lookup the CFLAGS for libtracefs. This
makes it possible to use the distro specific path as include path for
the header file.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Our downstream packaging stop working. After a bit of didding I found out that
the libtracefs feature detection is not completely right.

https://build.opensuse.org/build/benchmark/SLE_15_SP5/x86_64/rtla/_log
---
 tools/build/feature/Makefile          | 2 +-
 tools/build/feature/test-libtracefs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ed54cef450f5..489cbed7e82a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -213,7 +213,7 @@ endif
 	$(BUILD) -ltraceevent
 
 $(OUTPUT)test-libtracefs.bin:
-	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtraceevent 2>/dev/null) -ltracefs
+	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
 
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
diff --git a/tools/build/feature/test-libtracefs.c b/tools/build/feature/test-libtracefs.c
index 8eff16c0c10b..29a757a7d848 100644
--- a/tools/build/feature/test-libtracefs.c
+++ b/tools/build/feature/test-libtracefs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <tracefs/tracefs.h>
+#include <tracefs.h>
 
 int main(void)
 {

---
base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
change-id: 20240617-rtla-build-83020baf9277

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

