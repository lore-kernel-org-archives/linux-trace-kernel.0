Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FB33B6EA
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jan 2026 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972228; cv=none; b=CsMyxKsPp9nih5cIaImrumAeBiRG6fLETLp+B9fnBgrqyvAUlP+c4HeV/9qaAw3z7vXJUyvtCBEoGLzux16ZTg8ao3WuFxaWAarS2fp20R/pUGRFQgwCcXx6SE9FiEzM75kzOLHNuQfyUwJxd2XKtbwnMUx+j0KCp4ujkoaP/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972228; c=relaxed/simple;
	bh=QIvd1MKc6lq0zu107pFg6fKNOlzrcPbUphpZfU5JEuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4Se4B7fJ0HGf46cW4Jap8M09nF6sS2pMusp6tApdfDhDYQq7xneiMF05PXCDYDYpKFZQF9KmtJpfRunDM2cnOWxNMP+RHbS3FzaadovQFoxB6RUMg/8clZ/tNn5w8iF6x6/HS+JTQ05Uu7ejBDRQChnYKpfPEWiB9u5otoxf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KcXCt+3W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LPYObc20; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KcXCt+3W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LPYObc20; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KcXCt+3W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LPYObc20";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KcXCt+3W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LPYObc20"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 696875BE80;
	Fri,  9 Jan 2026 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767972225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzMIAqRka9gmKfGVSHN68HS6crHUULtTryPwU9xf3k8=;
	b=KcXCt+3WVY8tl+GrrCpMWrGh0wZmEvfGEkdnU3SGBRK8sADyZ/nbEHYRUb19poodhlf3hR
	3H1hIQF0edoOx4Bo7oUJJMkqky+Zrrn86yHJXhPz33r0rJo3V+T54mWPA3eXRNVPCBYLc9
	PVyMssCdsbM8+cMOveqG3G9TVrzEQ54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767972225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzMIAqRka9gmKfGVSHN68HS6crHUULtTryPwU9xf3k8=;
	b=LPYObc20L3ZEu9T2fJUfE2/LVhypb0sjRm9pBqmpakw/wqjHQaelrztx6Kq5pYlYL/ddzS
	bp9AItuMQCFfNfCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767972225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzMIAqRka9gmKfGVSHN68HS6crHUULtTryPwU9xf3k8=;
	b=KcXCt+3WVY8tl+GrrCpMWrGh0wZmEvfGEkdnU3SGBRK8sADyZ/nbEHYRUb19poodhlf3hR
	3H1hIQF0edoOx4Bo7oUJJMkqky+Zrrn86yHJXhPz33r0rJo3V+T54mWPA3eXRNVPCBYLc9
	PVyMssCdsbM8+cMOveqG3G9TVrzEQ54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767972225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzMIAqRka9gmKfGVSHN68HS6crHUULtTryPwU9xf3k8=;
	b=LPYObc20L3ZEu9T2fJUfE2/LVhypb0sjRm9pBqmpakw/wqjHQaelrztx6Kq5pYlYL/ddzS
	bp9AItuMQCFfNfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05C233EA65;
	Fri,  9 Jan 2026 15:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAwEO4AdYWkVZAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 09 Jan 2026 15:23:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-doc@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	linux-trace-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] Documentation/trace: Fix links to other documents
Date: Fri,  9 Jan 2026 16:23:36 +0100
Message-ID: <20260109152336.84674-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109152336.84674-1-pvorel@suse.cz>
References: <20260109152336.84674-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Link to another document does not require 'file:'. Removing it fixes
links in generated html docs.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Documentation/trace/fprobe.rst      | 2 +-
 Documentation/trace/ftrace-uses.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 06b0edad01796..1d9e0b1693494 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -79,7 +79,7 @@ The above is defined by including the header::
 
 Same as ftrace, the registered callbacks will start being called some time
 after the register_fprobe() is called and before it returns. See
-:file:`Documentation/trace/ftrace.rst`.
+`Documentation/trace/ftrace.rst`.
 
 Also, the unregister_fprobe() will guarantee that both enter and exit
 handlers are no longer being called by functions after unregister_fprobe()
diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index e225cc46b71eb..e7cea7b1a74d9 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -253,7 +253,7 @@ If @buf is NULL and reset is set, all functions will be enabled for tracing.
 The @buf can also be a glob expression to enable all functions that
 match a specific pattern.
 
-See Filter Commands in :file:`Documentation/trace/ftrace.rst`.
+See Filter Commands in `Documentation/trace/ftrace.rst`.
 
 To just trace the schedule function:
 
-- 
2.51.0

