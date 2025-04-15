Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA62741B8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707947; cv=none; b=LXTid/yfuDvjr0M4ipVfrVc8tcmVfPP6W4WKE5lqLWlunz4tJW3oHg3krivTURg6hBjZhz3AF2tCGjL1al+QiFcm/o5bZlR9tcLzzE85HwurCbTqdMhgtNrIIEgHcILTRgPfb/BrscMXfnwtODHtaBF6jlRinU/WXNrrWpKj88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707947; c=relaxed/simple;
	bh=xbAWn0WSfoitO1KDMc0+QCcVSYyO/mBipbxolJ9HPJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QElxGaMulr6vTVzsUZlh3Frm1r4RW+sVAZ3BqpYCiok3D5QNYbRIvS+HV3KILqj4cOR9f918lggbL6Wzt/EaRJqcN4WyiosFGqgnHVzhj3GykGEACyvpJ5iEt57i9p+vYgoFjmodwtKabZf6+/P1ba+uyI1mnQVEDa+A8H33CHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MpwAHHON; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8dMuj+Hj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MpwAHHON; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8dMuj+Hj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MpwAHHON";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8dMuj+Hj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MpwAHHON";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8dMuj+Hj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A3C921164;
	Tue, 15 Apr 2025 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744707942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVoKDLF5pncIUIiH8TIsHzaAW0W0nHN55ljr4oVTt4M=;
	b=MpwAHHONHUVv1EjrR5f1v0LcABnG+WymlxxV4WfboUKtUaGnsvvwrdoKUifhtrQHnk9f0I
	FplYkA0tnTTh9RWo1zEC9UQAvcyhwNPRJXkY2a1RxtXYtL38fTwR5hpYfim0/08BBXtnCl
	HQ3EB70JF/j3SiUlx6I/vSkTy7wGrL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744707942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVoKDLF5pncIUIiH8TIsHzaAW0W0nHN55ljr4oVTt4M=;
	b=8dMuj+Hj1w7VX41un+Yx+MhN+P7E3bTubd35YA7IxAdxq7/WcyUw7u52hL9G7CW9ej2SB2
	pc7ENqs+LZUHWfDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MpwAHHON;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8dMuj+Hj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744707942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVoKDLF5pncIUIiH8TIsHzaAW0W0nHN55ljr4oVTt4M=;
	b=MpwAHHONHUVv1EjrR5f1v0LcABnG+WymlxxV4WfboUKtUaGnsvvwrdoKUifhtrQHnk9f0I
	FplYkA0tnTTh9RWo1zEC9UQAvcyhwNPRJXkY2a1RxtXYtL38fTwR5hpYfim0/08BBXtnCl
	HQ3EB70JF/j3SiUlx6I/vSkTy7wGrL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744707942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVoKDLF5pncIUIiH8TIsHzaAW0W0nHN55ljr4oVTt4M=;
	b=8dMuj+Hj1w7VX41un+Yx+MhN+P7E3bTubd35YA7IxAdxq7/WcyUw7u52hL9G7CW9ej2SB2
	pc7ENqs+LZUHWfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6569A13A89;
	Tue, 15 Apr 2025 09:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MJZrGGYh/mexUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 15 Apr 2025 09:05:42 +0000
Message-ID: <cbf5b354-48b4-4f25-97c3-7b76fd332c41@suse.cz>
Date: Tue, 15 Apr 2025 11:05:42 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add mmap trace events to MEMORY MAPPING
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20250411173328.8172-1-Liam.Howlett@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250411173328.8172-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7A3C921164
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/11/25 19:33, Liam R. Howlett wrote:
> MEMORY MAPPING does not list the mmap.h trace point file, but does list
> the mmap.c file.  Couple the trace points with the users and authors of
> the trace points for notifications of updates.
> 
> Cc:Andrew Morton <akpm@linux-foundation.org>
> Cc:Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc:Vlastimil Babka <vbabka@suse.cz>
> Cc:Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c7fdc41a6bfb..d8e9a10adc81d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15571,6 +15571,7 @@ L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	include/trace/events/mmap.h
>  F:	mm/mlock.c
>  F:	mm/mmap.c
>  F:	mm/mprotect.c

