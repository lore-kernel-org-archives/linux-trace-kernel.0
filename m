Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140218A6A8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959844; cv=none; b=f5ms+BLbGC5F6OJzTeTmcF9eRrxTPcituHlRUumPuVJHFoQTgwZyHzYZOoSR57cDp4hEE0ApehtSr9HNYKqzyu9r7/elkBY0AOLLJkQl7MlzUvAaAPZYhQGOygn2GIO7LODNnWGwpxLPwRd1KVHIMwtl0sujCopvIBK87Fu0edY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959844; c=relaxed/simple;
	bh=shjMScH+3Yvc1z9ZOMJHysptbcLKAnzHiHI4k6fCJuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atbjgXWoul9EFQgQ2za86OF5WVjYQf9cP1sumgLUyak6CSwxQKctpdXFdgDT2G3nHSjNy0i6bWKrnhQ/uTO+IXYpMOkiHon7A4/xOPzD1e3reT53+af03bI2pMW2nRzksyVBQZE1gBQfHQ9CDXfHO94X1K4wg4Tmhuz+D0uetuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o/Jv2QE/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/3vJiS/f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o/Jv2QE/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/3vJiS/f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o/Jv2QE/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/3vJiS/f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o/Jv2QE/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/3vJiS/f"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40C241F7D9;
	Wed, 15 Jan 2025 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736959841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shjMScH+3Yvc1z9ZOMJHysptbcLKAnzHiHI4k6fCJuo=;
	b=o/Jv2QE/XJuayqNUTSX/FtkLBTRPL7fXzIHiNPYrAgOe3RsM+8KVJQ7JkarvNzy1gxQAtA
	62uLyov2qB8D9jYpWvNs4v3kuj+tBgSFqisQOx/QQaEPp1KVMVEsmx8ckh5gjLOb+Ol66v
	AiFGO8u7PF4kKYY1tviYGNH6Gbcqa10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736959841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shjMScH+3Yvc1z9ZOMJHysptbcLKAnzHiHI4k6fCJuo=;
	b=/3vJiS/f9uTlpHzKuGET8ddPrfWhmhTjK7FFel7DtsTW7S6HKN0b70woTvtu4TdZ5h3dXV
	WdV7HG2naUS2+gCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736959841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shjMScH+3Yvc1z9ZOMJHysptbcLKAnzHiHI4k6fCJuo=;
	b=o/Jv2QE/XJuayqNUTSX/FtkLBTRPL7fXzIHiNPYrAgOe3RsM+8KVJQ7JkarvNzy1gxQAtA
	62uLyov2qB8D9jYpWvNs4v3kuj+tBgSFqisQOx/QQaEPp1KVMVEsmx8ckh5gjLOb+Ol66v
	AiFGO8u7PF4kKYY1tviYGNH6Gbcqa10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736959841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shjMScH+3Yvc1z9ZOMJHysptbcLKAnzHiHI4k6fCJuo=;
	b=/3vJiS/f9uTlpHzKuGET8ddPrfWhmhTjK7FFel7DtsTW7S6HKN0b70woTvtu4TdZ5h3dXV
	WdV7HG2naUS2+gCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32E0D13A6F;
	Wed, 15 Jan 2025 16:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rXyLC2Hnh2fAIwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 15 Jan 2025 16:50:41 +0000
Date: Wed, 15 Jan 2025 17:50:40 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: kprobe not always triggering
Message-ID: <03179c0c-5133-440c-8072-945601d39e5b@flourine.local>
References: <f91a64bf-c5cb-4d36-b50b-67cdcdccdccc@flourine.local>
 <20250115101715.12c6cce3@gandalf.local.home>
 <e5d64ac8-5a30-4196-a5e5-b3d2743356b1@flourine.local>
 <20250115113733.650db5c0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115113733.650db5c0@gandalf.local.home>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 15, 2025 at 11:37:33AM -0500, Steven Rostedt wrote:
> Grumble. I expect this issue to come up more often. We need a way to detect
> this. Come to think of it, I believe this is more of a clang "feature". As
> I do recall some of the other reports were from the clang compiler as well.

clang doesn't seem to offer a more fine grained way to control the
inline decisions. There is no '--inline-all-or-nothing' option.

clang version 19.1.5 (Fedora 19.1.5-1.fc41)
Target: x86_64-redhat-linux-gnu
