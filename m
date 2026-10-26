Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013408;
	b=XtanOP2EiPtWVkSdyLrevIdz45M0SpDEDBBLW6xCWmVKdyM0H7g3oA1GTUPiyAYqEQxo
	 +q5BsOc9lhn6KRd31+Bm1U6Tbzf1ADDWSL6AcIewDwFCrmrf03SozKQAiDCbUbnv7wz4n
	 IogZwm6isioCpNX/jfIrjuhks0/SisYNCMN78ZQyxLnM6ST1o8RdB1k5altYFho1V7SU7
	 9ubi1bhblfsD53cY6CC3v3kemsDe8M8OJV2NeEcf7EWY4s+s+cfwROAmEWvuvDU4axy0w
	 H8fEaOVtxPYYqJeUVmktvbasxyVJYWGo1iTT16+o+u3YAiA0ZrbBCExwBZVw2XE+vSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013408;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=jhog7HuhanCuWU8XopWnvdWx7qk3vZmEMa48xi/AecY=;
	b=NEGraJRgInzJfCVWGjsYntZ4I/IMrDHykh0HHNx4EZS7DbrjSYBpQVMHdGo0D5x901gk
	 WnAjVWYLVsi/5s2LMpyiTd7hm75SwoFHknU5VHK5U3JDoOv7g82DeebJKfgfzO+2q56AL
	 C2gIzBj/ApiXg2JxPx4LjxZiutQwL63klfTyhE5fLhAz4Vk2bfPr6i64fvVm0XkfOhSsE
	 1HW0MnSv6nEelr/aT9Wg67Byg1lBa2CIY8x2fjsrqctYUwGVr1OSOz3+QN9TkLKhMWplU
	 P7W6tUBvLiNFxYN8MkgSgEhgGe4hpWSN/r9J4x1MkiBbEe/9TZxFCzlXI+im6fepXgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=i3nX9dw5;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5AvKPGgy;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TlsKZQnl;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sh9MqH5W;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC64606A339;
	Mon, 26 Oct 2026 11:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FC64606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=i3nX9dw5;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5AvKPGgy;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TlsKZQnl;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sh9MqH5W
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0DBC22251;
	Mon, 26 Oct 2026 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793013400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhog7HuhanCuWU8XopWnvdWx7qk3vZmEMa48xi/AecY=;
	b=i3nX9dw5pjl4dAS/VewKo1gTPRDZ0DBQBMrNbPLbNfOxxUbV9/GUMYxkahZ8utYYDcRiJU
	ANxTV0WqAauPS0m1gRCt71AexbBhue/pmfgtc8CQO5GTx3ISONF/p8CAfn2sE/jthyZMPL
	XPMOHmh4u2aC5KuDsIrJEmVXDYJSS3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793013400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhog7HuhanCuWU8XopWnvdWx7qk3vZmEMa48xi/AecY=;
	b=5AvKPGgyOkyIc/hhXAoNU4nPxF1cU0Zm17NIgB+dr7HlK4qMnfdzvZnu4ZZeMMrfIcgvdp
	dTwh6lOQa7ITcKBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TlsKZQnl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sh9MqH5W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793013399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhog7HuhanCuWU8XopWnvdWx7qk3vZmEMa48xi/AecY=;
	b=TlsKZQnlp1Ai7QweQfDXFnlGsbWAU8uCEyZuJxAEgFfk5QNYqwYm6ap9lPkYBNyB+PM41F
	GLt1vh0ccG1tNeRHSL1TwEnVhrR45onPOrkxpjjlyBBaoow27h7IjZgq0W20JIdLG1BZ6a
	1F2RWdOb3/uso1/IAzQFuew6WeXQX2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793013399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhog7HuhanCuWU8XopWnvdWx7qk3vZmEMa48xi/AecY=;
	b=sh9MqH5W+mgCDsr1+e19Pt9+2ckthoaNhx4yGgRK5xyUq7FQkxZCHJ9Rur+aV/E21cCzd3
	V0GyjVGZiSwgjLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8FE813408;
	Mon, 26 Oct 2026 11:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bao2Kpc232qeaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 11:16:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5DDBDA1419; Mon, 26 Oct 2026 12:16:35 +0100 (CET)
Date: Mon, 26 Oct 2026 12:16:35 +0100
From: Jan Kara <jack@suse.cz>
To: Chaosheng Qu <quchaosheng000406@163.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: don't reference jiffies from writeback
 TP_printk()
Message-ID: <3p3dj5yjoqdchz5u4mlfp2qckz6cib5yahbwhsfqf33nrzdyof@6msi6afd6wys>
References: <179299543891.294518.18224691820856958686@163.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179299543891.294518.18224691820856958686@163.com>
X-Rspamd-Queue-Id: F0DBC22251
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.01

On Mon 26-10-26 14:17:18, Chaosheng Qu wrote:
> From: Chaosheng Qu <quchaosheng000406@163.com>
> Subject: [PATCH] tracing: don't reference jiffies from writeback TP_printk()
> To: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>,
>     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
>     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
>     Jan Kara <jack@suse.cz>,
>     linux-trace-kernel@vger.kernel.org,
>     linux-kernel@vger.kernel.org
> 
> writeback_sb_inodes_requeue and writeback_single_inode_start/() compute
> the inode age with:
> 
> 	(jiffies - __entry->dirtied_when) / HZ
> 
> inside TP_printk().  TP_printk() is not part of the recorded event: it
> runs when the trace is read back, so the expression is evaluated at
> formatter time, not at the time the event was recorded.  The formatted
> output therefore reports the interval between recording and reading,
> not the age of the inode when it was traced.
> 
> It is also evaluated outside of the kernel: tracefs renders the format
> string once and userspace re-evaluates it.  A tool that has to resolve
> every symbol in the expression (trace-cmd and the parser in LISA both
> do) resolves the bare "jiffies" to its address, so the printed age
> becomes ((unsigned long)&jiffies - dirtied_when) / HZ, which is
> nonsense.  This was reported as a wrong "age" value in trace-cmd
> output:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=219839
> 
> Nothing in TP_printk() may depend on the state of the machine at read
> time, which is the same rule that keeps ktime_get() and friends out of
> it.  writeback_queue_io already does the right thing and stores the age
> in TP_fast_assign(); make these two events do that as well.
> 
> The new __entry->age field is appended after the existing fields, so
> no existing field changes offset and trace consumers that index the
> event by offset keep working.  The "age=%lu" placeholder keeps its
> position in the output text.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219839
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/trace/events/writeback.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 13ee076..23d107c 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -745,6 +745,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		__field(u64, cgroup_ino)
>  		__field(unsigned long, state)
>  		__field(unsigned long, dirtied_when)
> +		__field(unsigned long, age)
>  	),
>  
>  	TP_fast_assign(
> @@ -753,6 +754,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		__entry->ino		= inode->i_ino;
>  		__entry->state		= inode_state_read_once(inode);
>  		__entry->dirtied_when	= inode->dirtied_when;
> +		__entry->age		= (jiffies - __entry->dirtied_when) / HZ;
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
>  	),
>  
> @@ -761,7 +763,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		  __entry->ino,
>  		  show_inode_state(__entry->state),
>  		  __entry->dirtied_when,
> -		  (jiffies - __entry->dirtied_when) / HZ,
> +		  __entry->age,
>  		  __entry->cgroup_ino
>  	)
>  );
> @@ -784,6 +786,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>  		__field(unsigned long, writeback_index)
>  		__field(unsigned long, wrote)
>  		__field(long, nr_to_write)
> +		__field(unsigned long, age)
>  	),
>  
>  	TP_fast_assign(
> @@ -795,6 +798,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>  		__entry->writeback_index = inode->i_mapping->writeback_index;
>  		__entry->nr_to_write	= nr_to_write;
>  		__entry->wrote		= nr_to_write - wbc->nr_to_write;
> +		__entry->age		= (jiffies - __entry->dirtied_when) / HZ;
>  		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
>  	),
>  
> @@ -804,7 +808,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>  		  __entry->ino,
>  		  show_inode_state(__entry->state),
>  		  __entry->dirtied_when,
> -		  (jiffies - __entry->dirtied_when) / HZ,
> +		  __entry->age,
>  		  __entry->writeback_index,
>  		  __entry->nr_to_write,
>  		  __entry->wrote,
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
