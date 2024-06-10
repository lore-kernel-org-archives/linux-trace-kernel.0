Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85B0210E7;
	Mon, 10 Jun 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052154; cv=none; b=iWJ7OxI7EPq2fQDRjkvBEPnXRph/10fngSb8SA1Qm5miAz3Wsf7ZEjHxMH4LqeRnTMdXNMDRspGCnlwrhvCrByqaTJ8Ooy9pw04FxLgwJu/UeMOsb8k31AZUws/plpn+RrkVCkPVM4R7VkrT1B/Iv29oGyLWXzdzow9Hl4vhwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052154; c=relaxed/simple;
	bh=cDSRUCVBEjAYGxQ/xYORJ64U3JN6qTshWZ+W7hdfAR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkjYshE6IT1DXS30mtmgYZsOj5vItOQ4MUm/QGyZNIfaMi2ZqzjTUJnf/l9VOsmRUhc8sUnRVa6TP3mN2eGEm2ZugzGOU5Ust8yp0/6meVrFOynV1/58iC8e+QP1VyFyNxf50ekvp0kvTk3OL4OIvjB1jcynugDGPhdMPfbxh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yDFRhfrY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/O5jiP+Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BcesNXaI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w9fTgI0L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yDFRhfrY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/O5jiP+Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BcesNXaI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w9fTgI0L"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D80291F837;
	Mon, 10 Jun 2024 20:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718052151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VgxtB78HGjNFkePpct4e22nV8RoDLwUOH6juCSjM86U=;
	b=yDFRhfrYJGRl3Y3smKWFduNidqeJ31w2D1TLlKqYx9T+AMvU8qTW5XiZI7Kevaq+jFW1cr
	KI4mYFUUPH/zhgoUPn5qosZQzEe4KGavkCwCKqOGKvd2mT2uABNtxYDtzbEBlTvJKjpZIT
	J4sVczW+GsPXdtZ6w8vAkhSDRdji+DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718052151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VgxtB78HGjNFkePpct4e22nV8RoDLwUOH6juCSjM86U=;
	b=/O5jiP+YiJ5Y06lpH1HPmhyLBCmfGd25fSADO2CAhkf+RIiRgxUj5JxwURjjCyZXa63bbx
	v/4h03Kc3jHp8tDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BcesNXaI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w9fTgI0L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718052150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VgxtB78HGjNFkePpct4e22nV8RoDLwUOH6juCSjM86U=;
	b=BcesNXaILY41Vt2KPd56+WB+xRmtEcX4HfdKa1fsK4zrruLWhOIyxKMRmyCcEX2m1HADVt
	Js7wQPwrfy25+UxV0YQ6kAwyedSGhnCpndjohSUZE/67bdd9N8zpSmQylMNXTFxbIo5F2r
	ZG8K49t7H+A0pD0IwO3OsPJJTDyfH2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718052150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VgxtB78HGjNFkePpct4e22nV8RoDLwUOH6juCSjM86U=;
	b=w9fTgI0LPneUEjPXHHPRmfkKQVYSsPH7jyvvKy5jXmx2AFfUYK5vm/SsrdE3RexEM0XQvU
	2NgwMEL2Pq85O+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B524113A7F;
	Mon, 10 Jun 2024 20:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mWGMKzZlZ2YyKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Jun 2024 20:42:30 +0000
Message-ID: <ce62eb86-8539-4c7f-b929-926cec94e1f0@suse.cz>
Date: Mon, 10 Jun 2024 22:42:30 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Content-Language: en-US
To: paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-6-Julia.Lawall@inria.fr>
 <20240610112223.151faf65@rorschach.local.home>
 <b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D80291F837
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 6/10/24 5:46 PM, Paul E. McKenney wrote:
> On Mon, Jun 10, 2024 at 11:22:23AM -0400, Steven Rostedt wrote:
>> On Sun,  9 Jun 2024 10:27:17 +0200
>> Julia Lawall <Julia.Lawall@inria.fr> wrote:
>> 
>> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
>> > index 7c29f4afc23d..338c52168e61 100644
>> > --- a/fs/tracefs/inode.c
>> > +++ b/fs/tracefs/inode.c
>> > @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
>> >  	return &ti->vfs_inode;
>> >  }
>> >  
>> > -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
>> > -{
>> > -	struct tracefs_inode *ti;
>> > -
>> > -	ti = container_of(rcu, struct tracefs_inode, rcu);
>> > -	kmem_cache_free(tracefs_inode_cachep, ti);
>> 
>> Does this work?
>> 
>> tracefs needs to be freed via the tracefs_inode_cachep. Does
>> kfree_rcu() handle specific frees for objects that were not allocated
>> via kmalloc()?
> 
> A recent change to kfree() allows it to correctly handle memory allocated
> via kmem_cache_alloc().  News to me as of a few weeks ago.  ;-)

Hey, I did try not to keep that a secret :)
https://lore.kernel.org/all/20230310103210.22372-8-vbabka@suse.cz/

> 							Thanx, Paul
> 
>> -- Steve
>> 
>> 
>> > -}
>> > -
>> >  static void tracefs_free_inode(struct inode *inode)
>> >  {
>> >  	struct tracefs_inode *ti = get_tracefs(inode);
>> > @@ -70,7 +62,7 @@ static void tracefs_free_inode(struct inode *inode)
>> >  	list_del_rcu(&ti->list);
>> >  	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
>> >  
>> > -	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
>> > +	kfree_rcu(ti, rcu);
>> >  }
>> >  
>> >  static ssize_t default_read_file(struct file *file, char __user *buf,
>> 

