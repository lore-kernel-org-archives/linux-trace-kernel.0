Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED62868D;
	Sat, 27 Jul 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722120375; cv=none; b=KhZTPsJhP3sv7mOuxxQbosH47OwEDEoIo7q73AZfwX5XrrHTQgwuqJDxoE+EtWdqYBZTkxqPiuNy4BgGY1hAz3JdmwrCMs89DRkkSwILqS18wQO7dncjhBoeIje9EiTopY9OHGMnccqMzkKH50e9xu0NSb3QLXEuL7oQ80F1Vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722120375; c=relaxed/simple;
	bh=aDJjbXwnFvbp/meaBLelsG01dGldMgZcb4pOsgF+lnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mt4P7YpeoBB9xGQIOryJsGVXOG9nzDZmlzpeW/CojJwQRWEc7Vh4Fx2mVk9r8Uu7zh93WzJROiUe/HieAvQPyvmBr/kaVTfqF3dV3+J+tTInmoNHdjjpzJESrqKjMCAaFgyGLKOfGaYO1TxkUX/t9cQmsJKu9I1Q0jjeLbdQaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LyTDtUhF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LyTDtUhF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LyTDtUhF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LyTDtUhF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1D3B219E3;
	Sat, 27 Jul 2024 22:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722120369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b7DMp1KqPlaViwj4csucqd4HpUGMBGXA2KLNDAroxf8=;
	b=LyTDtUhFvv1zQWB+DQ6YWVz0Q8ApsEw5Gt+8EenXfjLk5YV8vGE69zGGwb672e3AO/V56+
	NqhaL1N4vBXeCiES4DK/0oQtqmY+fzwMGTHwVsyDzub1K9lo56e0OfmZPdIovcWLnkKOpP
	1CNMhGPwgmZoUr7SZoe6sutGTtNI8Uc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LyTDtUhF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722120369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b7DMp1KqPlaViwj4csucqd4HpUGMBGXA2KLNDAroxf8=;
	b=LyTDtUhFvv1zQWB+DQ6YWVz0Q8ApsEw5Gt+8EenXfjLk5YV8vGE69zGGwb672e3AO/V56+
	NqhaL1N4vBXeCiES4DK/0oQtqmY+fzwMGTHwVsyDzub1K9lo56e0OfmZPdIovcWLnkKOpP
	1CNMhGPwgmZoUr7SZoe6sutGTtNI8Uc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54751138A7;
	Sat, 27 Jul 2024 22:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rxrMCLF4pWaUQQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Sat, 27 Jul 2024 22:46:09 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Jul 2024 19:45:54 -0300
Subject: [PATCH] Documentation: ftrace-uses: Change pt_regs to ftrace_regs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-ftrace-docs-cb-args-v1-1-e37141235c8e@suse.com>
X-B4-Tracking: v=1; b=H4sIAKF4pWYC/x3MQQ5AMBBA0avIrE1C0eIqYlE1ZTbIjIhE3F1j+
 Rb/P6AkTAp99oDQxcr7llDmGYTVbwshz8lgClMXzjiMp/hAOO9BMUzoZVHsbEWxsc76toRUHkK
 R7/86jO/7AW/0c9RlAAAA
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722120367; l=2850;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=aDJjbXwnFvbp/meaBLelsG01dGldMgZcb4pOsgF+lnc=;
 b=SZW9yFlt2aySCPEv5CGUzHss1PAcs/4uh2iV0ysgWj//03l/d4OStuAX0G1/ZriWzk2on2xfY
 rI1NCY4C4mcCjlurNzdQRlO0UDWPj3sx2OZkD4mVlZ8sRXtlJ0er/A5
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C1D3B219E3
X-Spam-Score: -6.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	DKIM_TRACE(0.00)[suse.com:+]

Since commit d19ad0775dcd ("ftrace: Have the callbacks receive a struct
ftrace_regs instead of pt_regs") the callback function receives a
ftrace_regs argument, and not a pt_regs anymore. Change the
documentation to reflect the reality.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/trace/ftrace-uses.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index e198854ace79..05620714d99f 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -87,7 +87,7 @@ The prototype of the callback function is as follows (as of v4.14):
 .. code-block:: c
 
    void callback_func(unsigned long ip, unsigned long parent_ip,
-                      struct ftrace_ops *op, struct pt_regs *regs);
+                      struct ftrace_ops *op, struct ftrace_regs *regs);
 
 @ip
 	 This is the instruction pointer of the function that is being traced.
@@ -104,7 +104,7 @@ The prototype of the callback function is as follows (as of v4.14):
 @regs
 	If the FTRACE_OPS_FL_SAVE_REGS or FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED
 	flags are set in the ftrace_ops structure, then this will be pointing
-	to the pt_regs structure like it would be if an breakpoint was placed
+	to the ftrace_regs structure like it would be if an breakpoint was placed
 	at the start of the function where ftrace was tracing. Otherwise it
 	either contains garbage, or NULL.
 
@@ -169,10 +169,10 @@ Some of the flags are used for internal infrastructure of ftrace, but the
 ones that users should be aware of are the following:
 
 FTRACE_OPS_FL_SAVE_REGS
-	If the callback requires reading or modifying the pt_regs
+	If the callback requires reading or modifying the ftrace_regs
 	passed to the callback, then it must set this flag. Registering
 	a ftrace_ops with this flag set on an architecture that does not
-	support passing of pt_regs to the callback will fail.
+	support passing of ftrace_regs to the callback will fail.
 
 FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED
 	Similar to SAVE_REGS but the registering of a
@@ -199,7 +199,7 @@ FTRACE_OPS_FL_IPMODIFY
 	Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
 	the traced function (have another function called instead of the
 	traced function), it requires setting this flag. This is what live
-	kernel patches uses. Without this flag the pt_regs->ip can not be
+	kernel patches uses. Without this flag the ftrace_regs->ip can not be
 	modified.
 
 	Note, only one ftrace_ops with FTRACE_OPS_FL_IPMODIFY set may be

---
base-commit: 256abd8e550ce977b728be79a74e1729438b4948
change-id: 20240727-ftrace-docs-cb-args-963ef5676a81

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>

