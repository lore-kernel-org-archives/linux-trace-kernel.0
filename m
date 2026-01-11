Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588112D5419
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Jan 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768171013; cv=none; b=mhRZaH53V6XbYosrN/U4fPfBmPyUbmxDqF1/ymtwp7COdxXNTqTtr1oI1+1pV3gLLQCUnVccxKL+1oh4X6UXqC9KrHAn8g1RoQZilDeSjYWSPytgnQQBLrmjFOFTGrIwhaiXhh1YlzXrV8+WGLOF4qy0Dzoj2YhZIT7esKiFFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768171013; c=relaxed/simple;
	bh=afYM+GVZZEA5LAVLP6Pc1kt0Y9sVNE6RMsDjdKMYv+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upPMM56kkiw/ohMX3O4y7yoxlY3R9W2orbn2EMitnA3mV69PwBA6BInyCql6rnP2k+SaIMwirjNyxaGuGabInCtNoMP3EwaMWpZrZ1tzQe9/env766jG5PltUly7iz6Xs8XBGFTL7oFch7CVSC3AZHDsU3dWT0l6YMMWHgRvPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMF5qyGY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xqpIEShM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMF5qyGY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xqpIEShM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMF5qyGY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xqpIEShM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMF5qyGY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xqpIEShM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EFA35BCFB;
	Sun, 11 Jan 2026 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768171010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zLOxGJfYIVp3nhJUFUVVGna2hCDOFk9XxC+CTR3iww=;
	b=nMF5qyGY47xjv3g9+xu8SnWy3PMGkTskWa2q/NktqC7W0Pq2B/qV76Is4f1vfvrczBxTCi
	mv2SkgB9I5ZkjP6CgC6fBysL/lfbMnc3Y/tOU6fX/R+MnrCvm9OxgKnUt6Zin7GiA2htiA
	YlCzXnadqk5IiiFfgo+MA7uyW97I0hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768171010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zLOxGJfYIVp3nhJUFUVVGna2hCDOFk9XxC+CTR3iww=;
	b=xqpIEShMSdd6DvB9iTHOQ5M2PPDIpNoKAd3cEmNwGl5ofqP6KzEwsgNMkqx1qC7+DtzSJX
	ZveCqySjPwokCXCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768171010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zLOxGJfYIVp3nhJUFUVVGna2hCDOFk9XxC+CTR3iww=;
	b=nMF5qyGY47xjv3g9+xu8SnWy3PMGkTskWa2q/NktqC7W0Pq2B/qV76Is4f1vfvrczBxTCi
	mv2SkgB9I5ZkjP6CgC6fBysL/lfbMnc3Y/tOU6fX/R+MnrCvm9OxgKnUt6Zin7GiA2htiA
	YlCzXnadqk5IiiFfgo+MA7uyW97I0hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768171010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zLOxGJfYIVp3nhJUFUVVGna2hCDOFk9XxC+CTR3iww=;
	b=xqpIEShMSdd6DvB9iTHOQ5M2PPDIpNoKAd3cEmNwGl5ofqP6KzEwsgNMkqx1qC7+DtzSJX
	ZveCqySjPwokCXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD7B03EA65;
	Sun, 11 Jan 2026 22:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CPz/MgEmZGnIYQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Sun, 11 Jan 2026 22:36:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-doc@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Documentation/trace: Fix links to other documents
Date: Sun, 11 Jan 2026 23:36:43 +0100
Message-ID: <20260111223643.174812-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260111223643.174812-1-pvorel@suse.cz>
References: <20260111223643.174812-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Link to another document does not require 'file:'. Removing it fixes
links in generated html docs.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Remove backticks (Jonathan Corbet)

Link to v1:
https://lore.kernel.org/linux-doc/20260109152336.84674-2-pvorel@suse.cz/

 Documentation/trace/fprobe.rst      | 2 +-
 Documentation/trace/ftrace-uses.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 06b0edad01796..95998b189ae33 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -79,7 +79,7 @@ The above is defined by including the header::
 
 Same as ftrace, the registered callbacks will start being called some time
 after the register_fprobe() is called and before it returns. See
-:file:`Documentation/trace/ftrace.rst`.
+Documentation/trace/ftrace.rst.
 
 Also, the unregister_fprobe() will guarantee that both enter and exit
 handlers are no longer being called by functions after unregister_fprobe()
diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index e225cc46b71eb..a9701add27c51 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -253,7 +253,7 @@ If @buf is NULL and reset is set, all functions will be enabled for tracing.
 The @buf can also be a glob expression to enable all functions that
 match a specific pattern.
 
-See Filter Commands in :file:`Documentation/trace/ftrace.rst`.
+See Filter Commands in Documentation/trace/ftrace.rst.
 
 To just trace the schedule function:
 
-- 
2.51.0

