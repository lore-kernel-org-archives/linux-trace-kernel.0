Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5324A7C2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029066; cv=none; b=QiGY6GyzSE+mh2oDxQtL95T1soIfNvloP9n7xCIoZjPFFq7DueS8KvN0h9/6h1NH2JgPuNglaX8Z8JYM81ZjAeIxvHbLDGU++u5DyJGFryTnKsEJOpT2IMKgxY6u/pMMJZiZK+UpauwnOL0Rm4AlcRkSWq9lGwH76K1Dho+lNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029066; c=relaxed/simple;
	bh=7O7EvLuq/pJkk1cZRSrpAzVVVNONcdN3dan42PjaX80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR1B5Y3+8p9DgJrhRREG8TPpbe7LPK1Lb+nFSqPUIMGx+l/tFqQi91e5nHQ5hyVoTauzQC1rJxD9dLiYwCikBTlZU5km7y87oNDI4VjOoOa27ftkEdMgIELwCOirCyr6Bf5k4I1nNtzZadLzBgyvkh1uhnmt7mdUOgsSqqVGxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D8SuBkjG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k6N8G9Kl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D8SuBkjG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k6N8G9Kl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D8SuBkjG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k6N8G9Kl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D8SuBkjG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k6N8G9Kl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA136211D2;
	Thu, 16 Jan 2025 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737029062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0t4udIO8JO9z9mdAn2hdq7xBoArr6PtSevIBdRTk1M=;
	b=D8SuBkjG5x3d3h1ugtpN9sIKWLrmrRvDD1fcDrnOw+FDKe7H3NEo8QOpoA3Tk4rsdKP6m8
	qOOwZqaoGfU2uxWO/eV3GxZpaGhwangNauoPfSUyB6Rjug/gBUXxFwDPce/ZhgM9iB11AE
	jQWp3N5pFKz0VMgSFoGKU/vZCWZbQqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737029062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0t4udIO8JO9z9mdAn2hdq7xBoArr6PtSevIBdRTk1M=;
	b=k6N8G9KlH8XhZblYUWOdogakK8wZoFrmQmqDhmBcJgT0YMkhT+hR/rGPplOasmu1cejC33
	z6ivNhV3iR2uPJCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D8SuBkjG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k6N8G9Kl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737029062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0t4udIO8JO9z9mdAn2hdq7xBoArr6PtSevIBdRTk1M=;
	b=D8SuBkjG5x3d3h1ugtpN9sIKWLrmrRvDD1fcDrnOw+FDKe7H3NEo8QOpoA3Tk4rsdKP6m8
	qOOwZqaoGfU2uxWO/eV3GxZpaGhwangNauoPfSUyB6Rjug/gBUXxFwDPce/ZhgM9iB11AE
	jQWp3N5pFKz0VMgSFoGKU/vZCWZbQqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737029062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0t4udIO8JO9z9mdAn2hdq7xBoArr6PtSevIBdRTk1M=;
	b=k6N8G9KlH8XhZblYUWOdogakK8wZoFrmQmqDhmBcJgT0YMkhT+hR/rGPplOasmu1cejC33
	z6ivNhV3iR2uPJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 984BD13332;
	Thu, 16 Jan 2025 12:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CYuRJMb1iGd7UgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 16 Jan 2025 12:04:22 +0000
Date: Thu, 16 Jan 2025 13:04:18 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: kprobe not always triggering
Message-ID: <35dbe779-e7c1-48ef-8e76-86092d77a199@flourine.local>
References: <f91a64bf-c5cb-4d36-b50b-67cdcdccdccc@flourine.local>
 <20250115101715.12c6cce3@gandalf.local.home>
 <e5d64ac8-5a30-4196-a5e5-b3d2743356b1@flourine.local>
 <20250116084818.2160d4faf29cf34c9b6e612f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116084818.2160d4faf29cf34c9b6e612f@kernel.org>
X-Rspamd-Queue-Id: AA136211D2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Thu, Jan 16, 2025 at 08:48:18AM +0900, Masami Hiramatsu wrote:
> Have you tried to use `perf probe`? Even if it is inlined, you can find them
> by
> 
>  perf probe -a nvme_change_ctrl_state new_state

I had to build my own perf, as the version from the distro didn't like
my kernel and just crashed. Thus I added a bunch libraries to my build
system. The resulting perf installed the probe and the missing events
show up:

          <idle>-0       [000] ..s1.   245.406139: nvme_complete_rq: nvme1: qid=0, cmdid=36865, res=0x0, retries=0, flags=0x0, status=0x371
          <idle>-0       [000] .Ns1.   245.407192: nvme_change_ctrl_state: (nvme_change_ctrl_state+0x0/0x180 [nvme_core]) new_state=0x2
   kworker/u33:0-65      [000] .N...   245.407258: nvme_change_ctrl_state: (nvme_change_ctrl_state+0x0/0x180 [nvme_core]) new_state=0x2
   kworker/u33:1-78      [000] .....   245.421290: nvme_change_ctrl_state: (nvme_change_ctrl_state+0x0/0x180 [nvme_core]) new_state=0x3

I double checked my previous setup with kprobes and now the missing
events show up as well. It looks like my setup changes makes clang to
not inline this function anymore, or there is no additional debug info
available?

> But perhaps, some of them are inlined with constant numbers (maybe you can
> find them as nvme_change_ctrl_state.constprop.XXX in kallsyms)

# cat /proc/kallsyms | grep nvme_change_ctrl_state
ffffffffc03dc04d r __kstrtab_nvme_change_ctrl_state     [nvme_core]
ffffffffc03dc064 r __kstrtabns_nvme_change_ctrl_state   [nvme_core]
ffffffffc03ca130 r __ksymtab_nvme_change_ctrl_state     [nvme_core]
ffffffffc0405de0 t __pfx_nvme_change_ctrl_state [nvme_core]
ffffffffc0405df0 t nvme_change_ctrl_state       [nvme_core]

This is with the new kernel, so after installing the libraries for the
perf build.

> If my guess is correct, it is not inlined but the constant propagation
> optimization[1] has been done by the compiler.
> 
> [1] https://en.wikipedia.org/wiki/Constant_folding#Constant_propagation
> 
> IIRC, commit 66f69b219716 ("perf probe: Support DW_AT_const_value constant value")
> should support this case.

Okay, this commit is already in (v5.4), so it was always in.

Anyway, I can't reproduce anymore.

Daniel
