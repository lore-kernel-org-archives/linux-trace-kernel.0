Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803D1C4A02;
	Fri,  3 Jan 2025 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945313; cv=none; b=E5w9uapzWuO5w5dmnv3hQxgyxTgyifcg7A22f4QVbrThDPEsXl01/IeQdFKNhjVvXj98frBwolOHzhHA9jUN9cXHJ/o97Jl9/+X4OvSOoVJVLLXA0C5wbtR8wwVGvWwrNDCmi7WXUckIUbX+Kq2kdl6C1FGH5IbN0Eg4aQ/pHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945313; c=relaxed/simple;
	bh=nBsW1PeI3OP/lLYs9nJsYVbukmOo0tvnLZw5SKjKRpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekReR2hAHPv6AsOrYy0EaCI+6GYyzILA8x4eAvFPPk/cGVkywcrbtyypSJDyLLGmiZ0ddjcApRnfq6FwqpE036Mwvfjhs+0OFNnyIh3k4TQPEualD/L1L/wr5QFyR9kfLOuTDRSe1MSOWb4QP6V+gPttD7RIZNhKQsW5KqCm8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCEj83PU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCEj83PU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7665C4CEDD;
	Fri,  3 Jan 2025 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735945313;
	bh=nBsW1PeI3OP/lLYs9nJsYVbukmOo0tvnLZw5SKjKRpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCEj83PUxzk+UhLcMHOo9UdYXbVI1/nVh4/fLY7eU+CkSbldg/5U4xtD11q2CS9hD
	 PJOlZIfFuZhvWvqFH9HPhX4aetViPxBSn8zrb0tZrAGMFVBASb/N1CJhV3ktLV3078
	 aE4TjcjH6FPop63Z7SgcetddaG7vGmjqdJQr+Ta+sR0ekQ5lnuP6i07OzMoyNEgYQ2
	 skYaYzWHhxJVtekv9NFc0VrIo42kJXxTDAsfyVYk0f+Bt5bQyhj4mn4TTNgVpTNMzH
	 UmIRTNZyHqdLQhcdXxnQXHZtlCB86V2r7XDARYr2cxtPVx5e3uKGDf7GZZ3laGlqaO
	 1iSiCAYcXClMA==
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
Subject: [PATCH 2/6] Provide __free(argv) for argv_split() users
Date: Sat,  4 Jan 2025 08:01:47 +0900
Message-ID: <173594530753.1055889.17844868397124331132.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173594528527.1055889.2175884987203674189.stgit@devnote2>
References: <173594528527.1055889.2175884987203674189.stgit@devnote2>
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
 include/linux/string.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 493ac4862c77..7035a70e30be 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -312,6 +312,8 @@ extern void *kmemdup_array(const void *src, size_t count, size_t element_size, g
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
+DEFINE_FREE(argv, char **, argv_free(_T))
+
 /* lib/cmdline.c */
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);

