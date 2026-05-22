Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA63438B8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463289; cv=none; b=BJDxzWq6kUfrRLZs1SuA4MH+I/knrcSBqkYHgqG9X19YAMdSZhNs+wfwaSDE/joXfMRg/37KAPzxVKdoClXaP+KDfu+UY0UkoMN8D5v4EX1eG1+TArybVH1xYjE1u2tnI8WW6kXhHCqlzN5qPPP+NusF4k3nmK4/Sp/ykN1So/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463289; c=relaxed/simple;
	bh=z+KN1hokHi6Q/XNg3KAJNred3OrTqoLZzjD8EF+9/Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgCtVnmVVpjvBSlyk4KOHCLO1jPP+O7Er1RoabgTXgT+IUAxNfJxFrjKwJMkgSuG0iytYtHZOK7V0+r7yqdxx7i6EyyWjMkAlM9uHHOc8SFAUGMvzfBYiwzMNakAlzjWZHiwKJoALtE+eiGaMMuE192v0ncdU16k7rRvW2XVWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L0U28bH6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L0U28bH6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L0U28bH6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L0U28bH6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E4E66BA54;
	Fri, 22 May 2026 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779463278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DcTkyafxokIFyx7B8h9+YsS080oy1Spc+V4mEk4KkX8=;
	b=L0U28bH6eorjODrOXfO400tSigfB7RM6UK/gMxi7NDlPJF+I01yseTFkVqzgPp0k/JxLpI
	vSS4JEbMX5MfWkkWQazlEgoik7Pd0dmC3q1mAbLSx8k1viSY+wwjyyVdlKc+zKEib48ZJG
	Fpd3J8/HhlPRUQUfDxcVZ2HueVl1UPs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779463278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DcTkyafxokIFyx7B8h9+YsS080oy1Spc+V4mEk4KkX8=;
	b=L0U28bH6eorjODrOXfO400tSigfB7RM6UK/gMxi7NDlPJF+I01yseTFkVqzgPp0k/JxLpI
	vSS4JEbMX5MfWkkWQazlEgoik7Pd0dmC3q1mAbLSx8k1viSY+wwjyyVdlKc+zKEib48ZJG
	Fpd3J8/HhlPRUQUfDxcVZ2HueVl1UPs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9B40593A8;
	Fri, 22 May 2026 15:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ficyLG10EGp9HwAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 22 May 2026 15:21:17 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	xen-devel@lists.xenproject.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 0/3] x86/xen: Do some Xen-PV related cleanups
Date: Fri, 22 May 2026 17:21:11 +0200
Message-ID: <20260522152114.77319-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Cleanups related to Xen PV mode.

Note that patch 3 might be debatable.

Juergen Gross (3):
  x86/xen: Guard PV-only stuff in xen-ops.h with CONFIG_XEN_PV
  x86/xen: Cleanup Xen related trace points
  x86/xen: Remove Xen debugfs support

 arch/x86/xen/Kconfig       |   7 --
 arch/x86/xen/Makefile      |   2 -
 arch/x86/xen/debugfs.c     |  16 ---
 arch/x86/xen/mmu_pv.c      |   8 ++
 arch/x86/xen/p2m.c         |  45 -------
 arch/x86/xen/xen-ops.h     | 242 ++++++++++++++++++-------------------
 include/trace/events/xen.h |  62 +---------
 7 files changed, 126 insertions(+), 256 deletions(-)
 delete mode 100644 arch/x86/xen/debugfs.c

-- 
2.54.0

