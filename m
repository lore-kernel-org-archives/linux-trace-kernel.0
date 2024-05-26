Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B08DDB2;
	Sun, 26 May 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716726490; cv=none; b=gInPFwOu+4ywBgTOmtg+/YYE7I1inLTTWFoEX84WykT/pScFu88knIv2Mfi0jfY8AbKf6fiNoaEC+x4cm3Bqb6dvGEa8cpDS/pFDoNTldpYsKmgptEGgzYvvmDRUqvuovX2pR/ulGACgb9fHbV+gJdjINyMa85KQsTVT5iU6Z5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716726490; c=relaxed/simple;
	bh=MWqUz7rWEmBBdrWJN03toXtll0HjkA34ta1+UWNFHSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZvTsH3MpSg1kl0E/E2xE/4LsX15JOch3bgnkttC0t9mIinN0BDRT6TmXyGFTorVRNUVyMkLlhQNyqnTOeY6RJ//+cCZPCGxAS5Y8P7Veu4iSb4NP5+Bl6Tcbi11TpMgQsCnlRCBDkLl46eu8VvxFkA2tE28LL6DNTnildv/rKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k5f+VuYG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/IXDWCXI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k5f+VuYG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/IXDWCXI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k5f+VuYG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/IXDWCXI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k5f+VuYG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/IXDWCXI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 211C25C952;
	Sun, 26 May 2024 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716726486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=007P97xnnv7oBYszNcxVkI2wzsJ2BBCkDzAZkBu4GKA=;
	b=k5f+VuYGthO+etVnIlQEqHjZoY5jRdKY+r0Fw6Q4V9X7kKGtn9A9gfJfX649b8mTXQVckp
	jwo2vXq1KJaFxPArOpgt0ty7JGDDbMpj3C3nGflhMiW7neDT+35jSbhY5VXK4Toj0+1dMd
	xppy2bonFhPALL+NLCDOHVeFZ78mT3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716726486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=007P97xnnv7oBYszNcxVkI2wzsJ2BBCkDzAZkBu4GKA=;
	b=/IXDWCXIdxGKpDYJoOoDLpe86g2+haz+BndJibsJHr0w8r7u4fl4e7mhbC4TlDW2AuE1KX
	uLZs0ez/D9jUbABg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k5f+VuYG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/IXDWCXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716726486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=007P97xnnv7oBYszNcxVkI2wzsJ2BBCkDzAZkBu4GKA=;
	b=k5f+VuYGthO+etVnIlQEqHjZoY5jRdKY+r0Fw6Q4V9X7kKGtn9A9gfJfX649b8mTXQVckp
	jwo2vXq1KJaFxPArOpgt0ty7JGDDbMpj3C3nGflhMiW7neDT+35jSbhY5VXK4Toj0+1dMd
	xppy2bonFhPALL+NLCDOHVeFZ78mT3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716726486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=007P97xnnv7oBYszNcxVkI2wzsJ2BBCkDzAZkBu4GKA=;
	b=/IXDWCXIdxGKpDYJoOoDLpe86g2+haz+BndJibsJHr0w8r7u4fl4e7mhbC4TlDW2AuE1KX
	uLZs0ez/D9jUbABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE10F13A6B;
	Sun, 26 May 2024 12:28:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cBPEJtUqU2bkbQAAD6G6ig
	(envelope-from <clopez@suse.de>); Sun, 26 May 2024 12:28:05 +0000
Message-ID: <ff240b23-4143-4171-8dcc-1fdbf1802e8c@suse.de>
Date: Sun, 26 May 2024 14:27:56 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/probes: fix error check in parse_btf_field()
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 "open list:TRACING" <linux-kernel@vger.kernel.org>
References: <20240525182131.15740-1-clopez@suse.de>
 <20240526191708.860651c915600a535cc2e579@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
In-Reply-To: <20240526191708.860651c915600a535cc2e579@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 211C25C952
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]


Hi,

On 26/5/24 12:17, Masami Hiramatsu (Google) wrote:
> On Sat, 25 May 2024 20:21:32 +0200
> Carlos López <clopez@suse.de> wrote:
> 
>> btf_find_struct_member() might return NULL or an error via the
>> ERR_PTR() macro. However, its caller in parse_btf_field() only checks
>> for the NULL condition. Fix this by using IS_ERR() and returning the
>> error up the stack.
>>
> 
> Thanks for finding it!
> I think this requires new error message for error_log file.
> Can you add the log as
> 
> trace_probe_log_err(ctx->offset, BTF_ERROR);
> 
> And define BTF_ERROR in ERRORS@kernel/trace/trace_probe.h ?

Sounds good, but should we perhaps reuse BAD_BTF_TID?

```
C(BAD_BTF_TID,		"Failed to get BTF type info."),\
```

`btf_find_struct_member()` fails if `type` is not a struct or if it runs
OOM while allocating the anon stack, so it seems appropriate.

Best,
Carlos

> Thank you,
> 
>> Fixes: c440adfbe3025 ("tracing/probes: Support BTF based data structure field access")
>> Signed-off-by: Carlos López <clopez@suse.de>
>> ---
>>   kernel/trace/trace_probe.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
>> index 5e263c141574..5417e9712157 100644
>> --- a/kernel/trace/trace_probe.c
>> +++ b/kernel/trace/trace_probe.c
>> @@ -554,6 +554,8 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
>>   			anon_offs = 0;
>>   			field = btf_find_struct_member(ctx->btf, type, fieldname,
>>   						       &anon_offs);
>> +			if (IS_ERR(field))
>> +				return PTR_ERR(field);
>>   			if (!field) {
>>   				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
>>   				return -ENOENT;
>> -- 
>> 2.35.3
>>
> 
> 

-- 
Carlos López
Security Engineer
SUSE Software Solutions
