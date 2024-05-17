Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD55812F;
	Fri, 17 May 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953231; cv=none; b=aBbGNbehIOLUWUC1WA6CPW7FIVm+DC7Th9hNo5cArtV6p7BiuiBiI/Z9k72zISP1atgCfIhnmCnwAMeZuQ3ZOnPbCzSJAe/yDRr0BsB7iSJzLxQ8e2555B4y2qh4P4kSOTjaBAaPndD2uWEuVFID0Ni4D0vZhIp/9NverhUbYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953231; c=relaxed/simple;
	bh=dWndnL2fcmjN6OLz/k5yycYyXhbbDCUqxD4dhl9EUxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lwp/USBC5kTmB0hz1FJt/4Rot7/inTV2oeZK+UDdbqyq0uIU9hkFuTJwU6HiB+fJP6tN7JfEiR+H4Y9MQd/Y3xtCuNxlmEckmuNdqtAuG8Ovuhb79jB3/dm4NgDjad5EC4dzO2Ha/ypF/RchYVTdzYcul9F3UrSbZD+U1c1ZIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IQGRpVxi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IQGRpVxi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IQGRpVxi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IQGRpVxi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 576C0374EA;
	Fri, 17 May 2024 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715953228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zG4qeZ4wXm0hhUEol81eqqpjCLMzzmjIMFnN0YK47ls=;
	b=IQGRpVxiYr0SkqYdxRblxdnj1xMPd93+UG2TUL9pn0rGGgz1YmI4amlpiNeNuSbcyLNF1S
	n4bHvAcsn9liD8wTtgSgG0D26yM2FS6uTbzIgCrWF05wDhqzMf88V6FkDkLGfeXf+bHsI+
	jzNv4byDymOe0/lxskzpva46epP9I9A=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715953228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zG4qeZ4wXm0hhUEol81eqqpjCLMzzmjIMFnN0YK47ls=;
	b=IQGRpVxiYr0SkqYdxRblxdnj1xMPd93+UG2TUL9pn0rGGgz1YmI4amlpiNeNuSbcyLNF1S
	n4bHvAcsn9liD8wTtgSgG0D26yM2FS6uTbzIgCrWF05wDhqzMf88V6FkDkLGfeXf+bHsI+
	jzNv4byDymOe0/lxskzpva46epP9I9A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F23413991;
	Fri, 17 May 2024 13:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 55PrDkxeR2Z/BQAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Fri, 17 May 2024 13:40:28 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 0/2] ring-buffer: Fix a race between readers and resize checks
Date: Fri, 17 May 2024 15:40:06 +0200
Message-Id: <20240517134008.24529-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.17
X-Spam-Level: 
X-Spamd-Result: default: False [-0.17 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.37)[77.01%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

Fix a race between a reader swapping a new reader page into the
ring-buffer from rb_get_reader_page() and the rb_check_pages() check
invoked at the end of the resize operation in ring_buffer_resize().

Note that a similar problem with rb_check_pages() being executed with
concurrent readers looks to exist for ring_buffer_subbuf_order_set()
too. I plan to tackle it in a separate series.

Petr Pavlu (2):
  ring-buffer: Correct stale comments related to non-consuming readers
  ring-buffer: Fix a race between readers and resize checks

 kernel/trace/ring_buffer.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)


base-commit: ea5f6ad9ad9645733b72ab53a98e719b460d36a6
-- 
2.35.3

