Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BF581728;
	Mon,  6 Jan 2025 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179402; cv=none; b=qMZ74+hyPpv+thGVm+gPBRHKWZKTmr060ZT94IYveE9Dhc5yVeWduL58IWq2dG5bxCZUOrDa7FMA+lO21uxgSJ5K32y9z/F7sZ9tc4gbVj70JG79XCA88U+n2f0xAUgPfAkpjZADjuqabZORBKzo4a8+JVN4bykc174JlrMYD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179402; c=relaxed/simple;
	bh=Xp283inUBUtGER/ONDEeVETi0jbYmdCMdfd13kiHaEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/M7hOs0HN7N1HEL52fbmf9P7uxiqGzQE/Z63xluh7lD6nfzg3v5m+Vh7VNWkGEkVULMdUgRtJb+ZgqV9ll9y9jjA2zFr4Bh9peZR/tX46RnhYa9ambRwx4Ial7lDY7nWNKYE9iUvZSuEaUbHtRb6vzJfiNSYYVvCmUi7/iuWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2aY8yev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2aY8yev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B10C4CED2;
	Mon,  6 Jan 2025 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736179401;
	bh=Xp283inUBUtGER/ONDEeVETi0jbYmdCMdfd13kiHaEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2aY8yev7gqbJDNzb3Nlq8Q6LhVG/5nRAZDvWsVqOUbQKan/fW5ypsbMhaBsNcVkb
	 miWht9zzh9g8ow4hhaHRR6OBNgqGo7Jv99TXF5RIoa/VdB6w+r76zAKUFWlkKRfd19
	 ckQ5wyTApqIXmaSIfBNQcSYjtcCg83fCkmL1f/c2XHx34q81pPDrlugIqIjjcKo8UA
	 zhBmyM/ACLOQrOO5kntbwaG8yaFJchJ5VzyhCfj1dostxbhhCzsGNvuaLCRUHLpsHM
	 991VoYrgJx3d1UxJoYPk0F/KTCk2+z6txk+0yAQ2oIR0m66kCofgX/Hy5fEHF179Po
	 bwy69ARQVYvdg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] Provide __free(argv_free) for argv_split() users
Date: Tue,  7 Jan 2025 01:03:16 +0900
Message-ID: <173617939641.1366315.14116274334551383402.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173617937395.1366315.17590944219163017504.stgit@devnote2>
References: <173617937395.1366315.17590944219163017504.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Provide __free(argv_free) macro for argv_split() users so that they can
avoid gotos.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Rename to __free(argv_free) so that making it clear to call argv_free().
 Changes in v2:
  - Fix to call argv_free() only if the argument is !IS_ERR_OR_NULL().
  - Add including cleanup.h.
---
 include/linux/string.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 493ac4862c77..86d5d352068b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -4,6 +4,7 @@
 
 #include <linux/args.h>
 #include <linux/array_size.h>
+#include <linux/cleanup.h>	/* for DEFINE_FREE() */
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
@@ -312,6 +313,8 @@ extern void *kmemdup_array(const void *src, size_t count, size_t element_size, g
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
+DEFINE_FREE(argv_free, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))
+
 /* lib/cmdline.c */
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);

