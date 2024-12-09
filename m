Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75970802;
	Mon,  9 Dec 2024 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712119; cv=none; b=U69P0+nwKFYbx+IR2P5V2QFytfsEjhK0lPNYbePE401klNpjV37xhvAw5hqQdFm3/m9XItJB9JlBEotUrrp4waIHWuzZU5sR+I+ARUhLb4O3CpAQdfLbM/HyqewmeeP3HH0T5L7hQvkxgwQC7O0WRNCwzniEfE7aMdk0zQZUjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712119; c=relaxed/simple;
	bh=/l67opR2BkVN0689/PXyBVzSNMlXdLM5Dtq0u70RTd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Thxe9L6HrCQNJ+7X0+qq0GSlmOLVPjog4o7hgY9dU3kmoOS7d1/U7bFa20QWprdz2giGP1dFdxnQB094Aqu+O3BD9wFqEkpZgulzPbgOAx0rtMVSRSjNkVtbm8+cJgUClnOj3tKrTppCOKvinBZSBjwoIepvueqHs8yXbJVrNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP6tQ+br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP6tQ+br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6222C4CED2;
	Mon,  9 Dec 2024 02:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733712119;
	bh=/l67opR2BkVN0689/PXyBVzSNMlXdLM5Dtq0u70RTd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PP6tQ+brmzfR5Ioop/FGGQs5znx5rCa9Aen+TbRGFx94H2hLQRYVcbQ9OsLCL6RA2
	 8cf2MEb2c8H+8N6a6K3Cv4Mz1qBENeHaEtRw2YGH9ZdjDN20jLM/ADyKLAFpgqPhWI
	 Ld75HmWU0r3QPeynhgoxRrYiauziOrbLRQDj2kgz7F5mSu9OiaDA/IYBgXpQc0jqY2
	 gQk8Q3Qmsx2DGcqFAB129kym6yAD6h5MOZTOsgGgiXFDpLmhF8G1XvpAODgRCA2pzX
	 qePnutfNyes2GYp51GO9sy3jSycB3SVVzvfkOenBmU8d8henLVR7bSAB9Nuz7G2XGH
	 3FaVr/b+X/5bg==
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
Subject: [PATCH 4/5] kprobes: Remove unneeded goto
Date: Mon,  9 Dec 2024 11:41:52 +0900
Message-ID: <173371211203.480397.13988907319659165160.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173371205755.480397.7893311565254712194.stgit@devnote2>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
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

Remove unneeded gotos. Since the labels referred by these gotos have
only one reference for each, we can replace those gotos with the
referred code.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a24587e8f91a..34cbbb2206f4 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1071,20 +1071,18 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 
 	if (*cnt == 0) {
 		ret = register_ftrace_function(ops);
-		if (WARN(ret < 0, "Failed to register kprobe-ftrace (error %d)\n", ret))
-			goto err_ftrace;
+		if (WARN(ret < 0, "Failed to register kprobe-ftrace (error %d)\n", ret)) {
+			/*
+			 * At this point, sinec ops is not registered, we should be sefe from
+			 * registering empty filter.
+			 */
+			ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
+			return ret;
+		}
 	}
 
 	(*cnt)++;
 	return ret;
-
-err_ftrace:
-	/*
-	 * At this point, sinec ops is not registered, we should be sefe from
-	 * registering empty filter.
-	 */
-	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
-	return ret;
 }
 
 static int arm_kprobe_ftrace(struct kprobe *p)
@@ -1428,7 +1426,7 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 	     unsigned long offset, bool *on_func_entry)
 {
 	if ((symbol_name && addr) || (!symbol_name && !addr))
-		goto invalid;
+		return ERR_PTR(-EINVAL);
 
 	if (symbol_name) {
 		/*
@@ -1458,11 +1456,10 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 	 * at the start of the function.
 	 */
 	addr = arch_adjust_kprobe_addr((unsigned long)addr, offset, on_func_entry);
-	if (addr)
-		return addr;
+	if (!addr)
+		return ERR_PTR(-EINVAL);
 
-invalid:
-	return ERR_PTR(-EINVAL);
+	return addr;
 }
 
 static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
@@ -1486,15 +1483,15 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
 	if (unlikely(!ap))
 		return NULL;
 
-	if (p != ap) {
-		list_for_each_entry(list_p, &ap->list, list)
-			if (list_p == p)
-			/* kprobe p is a valid probe */
-				goto valid;
-		return NULL;
-	}
-valid:
-	return ap;
+	if (p == ap)
+		return ap;
+
+	list_for_each_entry(list_p, &ap->list, list)
+		if (list_p == p)
+		/* kprobe p is a valid probe */
+			return ap;
+
+	return NULL;
 }
 
 /*

