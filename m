Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632011CF8F;
	Sat, 25 May 2024 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716661334; cv=none; b=guWHh5+ehCMNPZmgU42qfrsrGSuczCri/LQ/E86s9Q2U54+AZXw7h8+/9NCrkgZI11jBdT/PK34ufYHnSkXLdLjibW+crRtDzH89jiiqRUOiOA/vnsI3K5JzeaREDWTcygdbWLpLqeeN/MAqcTMa9B8BAXdJ+MuBGBkdGeNWYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716661334; c=relaxed/simple;
	bh=k/iX0RaIP3m97XishbvBAFhhUj0SK/I4pjIxMOIgjEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j7jKvhbcLdtjqDnvnX4h4kDh1yXbgRgcRkh7xPazWY/lJpT0/ssJTx20fmKpOXnODaEg7J8DUwm4p/hCtNDYOLI3+OPbBCKHmsg9RLTLcymMbkZv+6OVknzGMQZBcWCvwrGc/IKsEwV50IH505+snv+UV1qSrmYSifx20qaG87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B4BkDQGf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=10UCqdOY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B4BkDQGf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=10UCqdOY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B4BkDQGf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="10UCqdOY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B4BkDQGf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="10UCqdOY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94B235C277;
	Sat, 25 May 2024 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716661331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m8k3YJ6Pa5+fRRrELod8+uIM03/stiCjVD21MeOxwQs=;
	b=B4BkDQGf0rCTeARCz0UkQTcGjf3OPQjySDDjBszbhFlo37z7KB8cze6xp3xez0fVf1vlFx
	BERhWCTXF5H8Ju23n80kQsQLyxsyDVy7TdSpRDpFaQ0qrFOjC9dN8a2XBdJ7AqqCjhWqGl
	wHRRSuRcRTDCazbstSmXbitD61SG0uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716661331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m8k3YJ6Pa5+fRRrELod8+uIM03/stiCjVD21MeOxwQs=;
	b=10UCqdOY0AAmOSPKOXTYmNHS7ZqvWkxg2MB5s1+a0XQHQyiyHvwpqwca+YwIush5VvlhZd
	Edq3wmjBkGKz/CAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B4BkDQGf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=10UCqdOY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716661331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m8k3YJ6Pa5+fRRrELod8+uIM03/stiCjVD21MeOxwQs=;
	b=B4BkDQGf0rCTeARCz0UkQTcGjf3OPQjySDDjBszbhFlo37z7KB8cze6xp3xez0fVf1vlFx
	BERhWCTXF5H8Ju23n80kQsQLyxsyDVy7TdSpRDpFaQ0qrFOjC9dN8a2XBdJ7AqqCjhWqGl
	wHRRSuRcRTDCazbstSmXbitD61SG0uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716661331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m8k3YJ6Pa5+fRRrELod8+uIM03/stiCjVD21MeOxwQs=;
	b=10UCqdOY0AAmOSPKOXTYmNHS7ZqvWkxg2MB5s1+a0XQHQyiyHvwpqwca+YwIush5VvlhZd
	Edq3wmjBkGKz/CAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2BD813A6C;
	Sat, 25 May 2024 18:22:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V7oMOFIsUmYhTQAAD6G6ig
	(envelope-from <clopez@suse.de>); Sat, 25 May 2024 18:22:10 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] tracing/probes: fix error check in parse_btf_field()
Date: Sat, 25 May 2024 20:21:32 +0200
Message-Id: <20240525182131.15740-1-clopez@suse.de>
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
X-Spamd-Result: default: False [-1.13 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.62)[82.14%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 94B235C277
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.13

btf_find_struct_member() might return NULL or an error via the
ERR_PTR() macro. However, its caller in parse_btf_field() only checks
for the NULL condition. Fix this by using IS_ERR() and returning the
error up the stack.

Fixes: c440adfbe3025 ("tracing/probes: Support BTF based data structure field access")
Signed-off-by: Carlos López <clopez@suse.de>
---
 kernel/trace/trace_probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 5e263c141574..5417e9712157 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -554,6 +554,8 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			anon_offs = 0;
 			field = btf_find_struct_member(ctx->btf, type, fieldname,
 						       &anon_offs);
+			if (IS_ERR(field))
+				return PTR_ERR(field);
 			if (!field) {
 				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
 				return -ENOENT;
-- 
2.35.3

