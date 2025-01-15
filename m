Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334328EC73
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929604; cv=none; b=THOsBNrkeuLKt1iWbAu7ChYRL45qU5n5PwFdK6dTzzVXLdBVNKbjAF5UvVaaeXLDmodivZsYO/Tox1l3ezBAaUnjmDJSi78yYzlpwqYySuiWKH7kGMF7f9nig447dHjpKA+vmkQ6kXq62WnxtnXcRGMmrfT3rRXqVT+ydufEgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929604; c=relaxed/simple;
	bh=0fnkuiZcLThQ7xxfx06KeUwb1ipRkNNan6FlC2wm84o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hZ32Vvo73RUmC1IflIXUNY484b7xBNsNDQ0Z8E2rDk0vpWkACE7s8og8XgU7cfUbXuAb1ru1r/ao/d+/bLFLxKOQ4dpHtTr2NI1dr8d3PdCnkDoJ6hknbn20aDXE+t2XQq86fQ8oeWvsetOesbAkGa2i475uROdv/0JdZsuR5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z3na06kl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Izg1DWDO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z3na06kl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Izg1DWDO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z3na06kl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Izg1DWDO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z3na06kl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Izg1DWDO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1E101F44E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736929601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=XRxO1DfGMA7Dy09LsCb7iaH3UpVOxD6l2PiG9MaPIvM=;
	b=Z3na06klQTbwTszHKehsTavFiw9+cM9groE0aupNu5pIdkewTH853hIQ4z2AZHisecc7Lf
	J+yAPvbF8k4pvrRscd3preEvP22eUW4FvZYb/jdJeOi8RmaT6C4R7R/aU2feKcXGvLBqGV
	jvC44fH0/r+QrXKJiazl3rWQci8pud8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736929601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=XRxO1DfGMA7Dy09LsCb7iaH3UpVOxD6l2PiG9MaPIvM=;
	b=Izg1DWDOwMuF1bIHejIYRjIbYCSTAV7X3sNpDbABSPTLgG7tMLlmOle+quJyY1nJIgGrdA
	ADnD8/2r89l84BCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736929601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=XRxO1DfGMA7Dy09LsCb7iaH3UpVOxD6l2PiG9MaPIvM=;
	b=Z3na06klQTbwTszHKehsTavFiw9+cM9groE0aupNu5pIdkewTH853hIQ4z2AZHisecc7Lf
	J+yAPvbF8k4pvrRscd3preEvP22eUW4FvZYb/jdJeOi8RmaT6C4R7R/aU2feKcXGvLBqGV
	jvC44fH0/r+QrXKJiazl3rWQci8pud8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736929601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=XRxO1DfGMA7Dy09LsCb7iaH3UpVOxD6l2PiG9MaPIvM=;
	b=Izg1DWDOwMuF1bIHejIYRjIbYCSTAV7X3sNpDbABSPTLgG7tMLlmOle+quJyY1nJIgGrdA
	ADnD8/2r89l84BCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90CAE139CB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 08:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p1x9IkFxh2f+eAAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 08:26:41 +0000
Date: Wed, 15 Jan 2025 09:26:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: linux-trace-kernel@vger.kernel.org
Subject: kprobe not always triggering
Message-ID: <f91a64bf-c5cb-4d36-b50b-67cdcdccdccc@flourine.local>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	PREVIOUSLY_DELIVERED(0.00)[linux-trace-kernel@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

it's likely a layer 8 problem but I can't figure out what I am doing
wrong.

I am debugging the nvme state machine with a nvme-tcp setup. I attached
a kprobe to nvme_change_ctrl_state to trace all the state changes, but
not all of them are logged. It's consistent behavior and I tried
different things with the same result.

The state transition I'd like to see is

  LIVE (1) -> RESETTING (2) -> CONNECTING (3) -> LIVE (1)

Though the 1 -> 2 transition is always missing, though a printk says it
is happening.

cd /sys/kernel/debug/tracing
echo "r:nvme_change_ctrl_state nvme_change_ctrl_state new_state=\$arg2:x32" > kprobe_events
echo 1 > events/kprobes/enable
echo 1 > tracing_on
cat trace_pipe

            nvme-570     [004] .....    97.559620: nvme_change_ctrl_state: (nvme_tcp_setup_ctrl+0x324/0x720 [nvme_tcp] <- nvme_change_ctrl_state) new_state=0x1
           <...>-65      [000] .....   143.540287: nvme_change_ctrl_state: (nvme_reset_ctrl_work+0x76/0xc0 [nvme_tcp] <- nvme_change_ctrl_state) new_state=0x3
   kworker/u34:3-76      [001] .....   170.236138: nvme_change_ctrl_state: (nvme_tcp_setup_ctrl+0x324/0x720 [nvme_tcp] <- nvme_change_ctrl_state) new_state=0x1


[   97.548827] nvme_change_ctrl_state:566 3 -> 1
[   97.550547] nvme nvme1: new ctrl: NQN "nqn.io-1", addr 192.168.154.25:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36
[  133.273552] nvme nvme1: I/O tag 1 (e001) type 4 opcode 0x18 (Keep Alive) QID 0 timeout
[  133.274359] nvme nvme1: long keepalive RTT (5056 ms)
[  133.274684] nvme nvme1: failed nvme_keep_alive_end_io error=10
[  143.514090] nvme_change_ctrl_state:566 1 -> 2
[  143.529185] nvme_change_ctrl_state:566 2 -> 3
[  146.584904] nvme nvme1: failed to connect socket: -110
[  146.585553] nvme nvme1: Reconnecting in 10 seconds...
[  159.897184] nvme nvme1: failed to connect socket: -110
[  159.897633] nvme nvme1: Failed reconnect attempt 2/60
[  159.898006] nvme nvme1: Reconnecting in 10 seconds...
[  170.153915] nvme nvme1: creating 8 I/O queues.

The system is idle, so I hope it's not just a dropped event. Any ideas
what I am doing wrong?

Linux 6.13.0-rc3+, clang compiler.

Thanks,
Daniel
