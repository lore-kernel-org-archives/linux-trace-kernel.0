Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E917E900;
	Wed,  8 Jan 2025 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302252; cv=none; b=Fxb35HRi0xanVHcjMyt3Jsxu8Vt1iNF1CU4ZBsQaalsgAtfi5N45GhN0vGMziq0DDBajQlnN9A1cFupxh/ia1bMOv4Gh7N+SxwmUawSY050Hu/Az2LQny2I/dmBk4B68LtWq+r06cxBYCmkt0SCMmp7wZt5kPnwb07Qr8X1TY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302252; c=relaxed/simple;
	bh=6QyVNa11BsehG9ROF+5/Jw9ETQ4uZvxVJBFzAmC3XNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6nGz2VG9Hu6nNeBQtbprr/CcS6jh5rfmiu0p+rFN3z8wT5EO/t7x9YKY1HZ3Hc+X8DDrBkZxVw4xEfcP4+QQDrLq6Zbl9iO13GuvdVIrgRWC+Uv9iAIf+lGAKwuRMA8raIOmpoB2uNWcteHrkSvXFg9cWXiCHuyBc/9n/lmEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah+VR8Ow; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah+VR8Ow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF20C4CED6;
	Wed,  8 Jan 2025 02:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302251;
	bh=6QyVNa11BsehG9ROF+5/Jw9ETQ4uZvxVJBFzAmC3XNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ah+VR8Ow1LQDNZa7TBu5x4eiel4tdPSnJTMvMzf+RrJYwUSDUh6FcpnmBdmgwKokF
	 Ca7vxBcP9gtxqyDFxiH2f77fRJm8uGcthKwrg9EtQ3D3sONwZbzJyZ5JSHVsQTDS5k
	 oz+BPoHTAwxgrGPmyPvSkU4pLiwnrPhW04QCM5N+HTPZCYLwrf1KP938uT2I7KXTcP
	 5d7Fa7p2hn+PLo/4HSnnkW+EIqmxd3KWI7Ipawr8FXPU0yPsrXf6aZXDt3gaJW1nfh
	 9taKwlYUA5PCgPJ9vuujmEP+PtpDJvY2ZQOQ6aEEkfd+XUSuDOgQRBOifY5dDrSSVE
	 x5bc7GGTxSqJw==
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
Subject: [PATCH v5 1/5] tracing/kprobes: Fix to free objects when failed to copy a symbol
Date: Wed,  8 Jan 2025 11:10:46 +0900
Message-ID: <173630224589.1453474.3336291076637629730.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173630223453.1453474.6442447279377996686.stgit@devnote2>
References: <173630223453.1453474.6442447279377996686.stgit@devnote2>
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

In __trace_kprobe_create(), if something fails it must goto error block
to free objects. But when strdup() a symbol, it returns without that.
Fix it to goto the error block to free objects correctly.

Fixes: 6212dd29683e ("tracing/kprobes: Use dyn_event framework for kprobe events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 263fac44d3ca..fb9d4dffa66e 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -940,8 +940,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 		/* a symbol specified */
 		symbol = kstrdup(argv[1], GFP_KERNEL);
-		if (!symbol)
-			return -ENOMEM;
+		if (!symbol) {
+			ret = -ENOMEM;
+			goto error;
+		}
 
 		tmp = strchr(symbol, '%');
 		if (tmp) {

