Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC64C6D;
	Sun,  5 Jan 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081282; cv=none; b=D40wmJhntaGZxYJ0/LQh5sJGEN693/3JMKXEpQcVoCL08nvgM+ld32gV8YtT76heZt9fVycot11aiaqi7WgZKaUDR7uO11kuFGp/qkCEQVnh0O1H+tKaTYozjlHBufvv5D0ZDghCdpz9OdIZJZ5c9cHn+E+IAlOWg0ZFMvuYy8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081282; c=relaxed/simple;
	bh=Ygf+iCbx7dZy/D639P/x2vHGiaFTI7wGxpffxyQB5zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnAj54/CjysYOLMQUj8feuK473+0DT7BwZ5lqNKCw+RrQBQXG4mClkaYhMLAFlYSlQaSRJmHCaxUSOK/2HlDZmK8RDpZ0VC1/NQVFv9QB9jrnPSHR6Q1rEsb5CX7Gj4DG+raxyJm6a9w/Du0f2QmJ749GGUrB3z5F/QSiiSuQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOEYRM+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOEYRM+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8289C4CED0;
	Sun,  5 Jan 2025 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736081282;
	bh=Ygf+iCbx7dZy/D639P/x2vHGiaFTI7wGxpffxyQB5zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOEYRM+iM9kN2pRmgjurk3VFjj8I3iRxuq90TT3fWbIYDQ/zDOQZtsZ4BL5ChQAk8
	 CtNE0QxGRN31W77kngnsgDKWK09rxJre8EbZbsHZ2Q2V/VAzD+wddAGzPBxUnmmQZ6
	 4ZEoklm8+Png2Q/hN1qmkGkqBfutsyTFqIj0pMqsb9IdCsWStEyIRTFMkwa0PyB2Zp
	 /1LDBt0WFgKOEXA/5wtgKhkiT23wFNohEWcYAgaG2Yb6mzZsJ5i6EGJnTASFrPaMCp
	 b/7LFmb2YnNbVHOYMqbhuUBiivU2DqkV69zOPUKzL2rQaU03jMHEU2uLg56QxE0j/F
	 VMw1gkSG/5K4Q==
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
Subject: [PATCH v2 2/6] Provide __free(argv) for argv_split() users
Date: Sun,  5 Jan 2025 21:47:56 +0900
Message-ID: <173608127627.1253657.12054758575695672674.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173608125422.1253657.3732758016133408588.stgit@devnote2>
References: <173608125422.1253657.3732758016133408588.stgit@devnote2>
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

Provide __free(argv) macro for argv_split() users so that they can
avoid gotos.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix to call argv_free() only if the argument is !IS_ERR_OR_NULL().
  - Add including cleanup.h.
---
 include/linux/string.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 493ac4862c77..07f2a90d5d9c 100644
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
 
+DEFINE_FREE(argv, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))
+
 /* lib/cmdline.c */
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);

