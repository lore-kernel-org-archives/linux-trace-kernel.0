Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63CB13A868;
	Mon, 27 May 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803193; cv=none; b=Gqnb+bRg4HB+/0VgHgbVF6RkB58Pu/Xx6nT1DFWYcN4thS7NumNpB4AAzJIVsxIF6Yr2xEjjDAjLSh/VLn0eqP1vTWoP9PUCH9Ai19zuse2Xim0ccNm8N4NtKGoXNTrq9qiTcVtBPrj6Mq49r4yI4KMafIFzuS4Y5LtpuWjKUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803193; c=relaxed/simple;
	bh=0J7Goas7XfaqrjeDmO5xbFVdnXoNnA0rtt90fCBrbeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NQ8Boc2qv/2dW/3P8P05JAFa6I8GUoTRTCdgWdBjugFG4Xe6UVcjtkFv/ivhrhiEzKdRkx/gYWhHQxv8A48LHSC1XzJ2z4DmYMzZNdQ/1HLgLhnN4693M4j3yNogbqp470IrLtIY70m8rUaP/y+twf5Tp/08ouZG/XW3xC9cKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HeujMHhK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DdcUi/st; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HeujMHhK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DdcUi/st; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HeujMHhK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DdcUi/st";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HeujMHhK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DdcUi/st"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C498621DB1;
	Mon, 27 May 2024 09:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716803189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEUi4RnVMGp2yzXFYg94XEmXhdXc3uYod367qTqvHLo=;
	b=HeujMHhKEh9k7Wq0LmbWESKvLSF0TDTZ5zNjby8npHd/FTS5/G8/SITXFFZm+NxFtKFBbY
	CEGxz1TTMquajfB3TzkRBIjL0hn9l625MeziS7nm5XY6m+Rtf2g0X5wz7CsJegPeHhrKjA
	R3hpLjtvCQksAlaadSCZIKUCIrZpqlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716803189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEUi4RnVMGp2yzXFYg94XEmXhdXc3uYod367qTqvHLo=;
	b=DdcUi/stZ6t5oll9CD1/ztqfZB4JkNGXBp9c9bZ0jUrXjp8G4Q281stfFE5E3vwAqeNs6T
	XLw5HGCwodaepECQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HeujMHhK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="DdcUi/st"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716803189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEUi4RnVMGp2yzXFYg94XEmXhdXc3uYod367qTqvHLo=;
	b=HeujMHhKEh9k7Wq0LmbWESKvLSF0TDTZ5zNjby8npHd/FTS5/G8/SITXFFZm+NxFtKFBbY
	CEGxz1TTMquajfB3TzkRBIjL0hn9l625MeziS7nm5XY6m+Rtf2g0X5wz7CsJegPeHhrKjA
	R3hpLjtvCQksAlaadSCZIKUCIrZpqlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716803189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEUi4RnVMGp2yzXFYg94XEmXhdXc3uYod367qTqvHLo=;
	b=DdcUi/stZ6t5oll9CD1/ztqfZB4JkNGXBp9c9bZ0jUrXjp8G4Q281stfFE5E3vwAqeNs6T
	XLw5HGCwodaepECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4717E13A6B;
	Mon, 27 May 2024 09:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jC6MDXVWVGa7NQAAD6G6ig
	(envelope-from <clopez@suse.de>); Mon, 27 May 2024 09:46:29 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v2] tracing/probes: fix error check in parse_btf_field()
Date: Mon, 27 May 2024 11:43:52 +0200
Message-Id: <20240527094351.15687-1-clopez@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.58 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	BAYES_HAM(-1.07)[87.92%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C498621DB1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.58

btf_find_struct_member() might return NULL or an error via the
ERR_PTR() macro. However, its caller in parse_btf_field() only checks
for the NULL condition. Fix this by using IS_ERR() and returning the
error up the stack.

Fixes: c440adfbe3025 ("tracing/probes: Support BTF based data structure field access")
Signed-off-by: Carlos López <clopez@suse.de>
---
v2: added call to trace_probe_log_err()

 kernel/trace/trace_probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 5e263c141574..39877c80d6cb 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -554,6 +554,10 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			anon_offs = 0;
 			field = btf_find_struct_member(ctx->btf, type, fieldname,
 						       &anon_offs);
+			if (IS_ERR(field)) {
+				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+				return PTR_ERR(field);
+			}
 			if (!field) {
 				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
 				return -ENOENT;
-- 
2.35.3

