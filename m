Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF97176247;
	Tue, 11 Jun 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095352; cv=none; b=hSw9pl28n7BRxZsGu2J29JvBXu8CfapKoWLB5HgqoeMwY1rn1LrVZe4/70R5diazyG6RI/q0agDVjebdI5SxxCjt3B4+VQLTcc55ARQ9hLwGyBmJMtDQ9v1GySG6OKHzM4rYDx8vaQUpKjZ6E9/ERMa90EWRxKlid82vDACWIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095352; c=relaxed/simple;
	bh=PDPvVmNLI2KmML3eBZlAx0kSooka/PciHqCPlWK1J/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATR3KaYcuWyPeZm2EAT2vLmKnLiC2LeXaV6tC4Deoq6Uq1ymWTuBrZVAWgicj1c4Q8XSXNzNxfRjxmLSw/csdNEHRS+VqXAePr+QLh6VxOo5X2yXzuexJZTaBRhX1+gtf5ZNS21ZnKIfICZLLPv7Z93zoh/JLNvCCCYFrgYvh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tmbMfhHK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ylbu+lJk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C8YowmwT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NEeEbIWg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tmbMfhHK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ylbu+lJk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C8YowmwT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NEeEbIWg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D976722D5F;
	Tue, 11 Jun 2024 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718095349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1YGaZy/KyNbtepXJK1X5b4jkkJKA9PLqUc+mM7CUU7Q=;
	b=tmbMfhHKvX65T9osYn6tm/1asE9MSw/E6T2dzo2ZJFZs/X1OqiQdQhyCB3BUuf0PcQo/xQ
	KTHjhMHEh1T2ctJdhhMxVksP/vb3RugmbpeAYuMJj4000EqmcDPn6AF2RKepvdLFSPVkni
	1UfIOHM9swCCaTio668vrNKRZ4Z0DIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718095349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1YGaZy/KyNbtepXJK1X5b4jkkJKA9PLqUc+mM7CUU7Q=;
	b=Ylbu+lJky7kk6dVAxh3fYDuOKygl5EgKcOdtmpWOu4Er8KWEslAg/VI+hddP49xk1nG88m
	wzNp2K/33Vq9SfDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718095348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1YGaZy/KyNbtepXJK1X5b4jkkJKA9PLqUc+mM7CUU7Q=;
	b=C8YowmwTGHbdtL8+g1YWpIvb3V36YWuwrzbx2oDpZ6pMtIYaQ2WpIx+OCeTx1nJzkTPwja
	CbFArJqiJ5i79a5Xo0jlw2adVKTdW7xdpqlj7yPgQCIqMM3GF+jXBRp0+bozJWavlmpP/x
	3Vi+5yRSv/ygd0p/hhR7NWpGaiQ7kKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718095348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1YGaZy/KyNbtepXJK1X5b4jkkJKA9PLqUc+mM7CUU7Q=;
	b=NEeEbIWgZ4mJJjCO+5cRTx4FZkKiJ9dMR8zcjdSvYBPwvKAwj3eEyQKTH9NglmjHLxvOMT
	21+ax51WvMO+bnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFF05137DF;
	Tue, 11 Jun 2024 08:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 14aLLvQNaGa9YwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 11 Jun 2024 08:42:28 +0000
Message-ID: <05ec743a-c4e9-4c66-b2cd-4e89c858d7d4@suse.cz>
Date: Tue, 11 Jun 2024 10:42:28 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
 Thorsten Leemhuis <linux@leemhuis.info>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-6-Julia.Lawall@inria.fr>
 <20240610112223.151faf65@rorschach.local.home>
 <b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
 <20240610163606.069d552a@gandalf.local.home>
 <70c093a5-df9c-4665-b9c9-90345c7f2139@suse.cz>
 <2024061143-transfer-jalapeno-afa0@gregkh>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <2024061143-transfer-jalapeno-afa0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

On 6/11/24 8:23 AM, Greg KH wrote:
> On Mon, Jun 10, 2024 at 11:40:54PM +0200, Vlastimil Babka wrote:
>> On 6/10/24 10:36 PM, Steven Rostedt wrote:
>> > On Mon, 10 Jun 2024 08:46:42 -0700
>> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> > 
>> >> > > index 7c29f4afc23d..338c52168e61 100644
>> >> > > --- a/fs/tracefs/inode.c
>> >> > > +++ b/fs/tracefs/inode.c
>> >> > > @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
>> >> > >  	return &ti->vfs_inode;
>> >> > >  }
>> >> > >  
>> >> > > -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
>> >> > > -{
>> >> > > -	struct tracefs_inode *ti;
>> >> > > -
>> >> > > -	ti = container_of(rcu, struct tracefs_inode, rcu);
>> >> > > -	kmem_cache_free(tracefs_inode_cachep, ti);  
>> >> > 
>> >> > Does this work?
>> >> > 
>> >> > tracefs needs to be freed via the tracefs_inode_cachep. Does
>> >> > kfree_rcu() handle specific frees for objects that were not allocated
>> >> > via kmalloc()?  
>> >> 
>> >> A recent change to kfree() allows it to correctly handle memory allocated
>> >> via kmem_cache_alloc().  News to me as of a few weeks ago.  ;-)
>> > 
>> > If that's the case then:
>> > 
>> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> > 
>> > Do we have a way to add a "Depends-on" tag so that anyone backporting this
>> > will know that it requires the change to whatever allowed that to happen?
>> 
>> Looks like people use that tag, although no grep hits in Documentation, so
>> Cc'ing workflows@ and Thorsten.
>> 
>> In this case it would be
>> 
>> Depends-on: c9929f0e344a ("mm/slob: remove CONFIG_SLOB")
> 
> Ick, no, use the documented way of handling this as described in the
> stable kernel rules file.

AFAICS that documented way is for a different situation? I assume you mean
this part:

* Specify any additional patch prerequisites for cherry picking::

    Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle

But that would assume we actively want to backport this cleanup patch in the
first place. But as I understand Steven's intention, we want just to make
sure that if in the future this patch is backported (i.e. as a dependency of
something else) it won't be forgotten to also backport c9929f0e344a
("mm/slob: remove CONFIG_SLOB"). How to express that without actively
marking this patch for backport at the same time?

> thanks,
> 
> greg k-h

