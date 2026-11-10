Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297636;
	b=xkpcFEusj/EAZy5rsjLFxtJnHVpC8JsxuQ59PBUBwK63cfqkvdgpNFO9BrcO6MO9bBfP
	 FcFae5KTkaradzVoJ1XLPWV9QZ4hl3nlvWeGP762aaqh3KiX4d5unjB1sX+priPndEeoK
	 yzOmIVvuftv/6fJ8KBXs7tk2/AUJXJlzIWcNsJ/UvoTBjSjs7/GL9ps4v7n4HKR4kCx2w
	 8kcY0S/sqDNBipqLkrcFy1TYLMlEbzgUAfLPAdS1Zd1/owXiFWu2Na0ld12LQto9ntz06
	 KQDyVgheR8CUhBeTfZpybvRDnsMeNw7jWownsfOymLtSIPVpXMweCkGEQlN9TkRfiow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297636;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=nTu5NUVxbSJd04O7s+0rGqa5jlkhinM8oi1X4DaM1qw=;
	b=OGBVncWWOVsiF+yoHJia2U2YcuQfnyZV8JLrujxZWNlWdG6VEEOwGdnzcTCZi/nS6pzf
	 WCLe0B/rgViqziUi0eWO7wVOhzZ2WUwnkiuk/xvrKa6FfzhTq4orDrdCUyrUawSlGCoPW
	 g9lkIa/0XXEt+IR+W7r+WYZoKtivM8Ce+6w6Q2B/aqzd9ljI3/uCILtnoMs5ChixxMMCc
	 6slrlAbbKzPXSBfu92mAM8OliJGAen4cNSTYmEpwTlYOR06fMPgrdZoXBBNvgFJblmbVX
	 OdQJ2k914QZScG04JISrhbZCvTqbFYZ+3LhBdB0nrpjZnV4GSwQO7g/1oS5pJ/5XyFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=w6oL0KVk;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0D606A702
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 08:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB0D606A702
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=w6oL0KVk
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6E0721C42C2;
	Tue, 10 Nov 2026 08:00:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id D216720025;
	Tue, 10 Nov 2026 08:00:26 +0000 (UTC)
Date: Tue, 10 Nov 2026 03:00:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: sashiko-bot@kernel.org, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ring-buffer: Do not allow reader to see unfinished
 moved head
Message-ID: <20261110030021.57a34e61@fedora>
In-Reply-To: <avHEs_umssItSLHi@gmail.com>
References: <20261109032241.55e57d26@fedora>
	<sashiko-outbox-204599@kernel.org>
	<avHEs_umssItSLHi@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D216720025
X-Stat-Signature: fauob9niowjarxcpfu7i3ehenqfpbah5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qy16ZCpb+mBvyyHfcAB6QQBvb87dyG+M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=nTu5NUVxbSJd04O7s+0rGqa5jlkhinM8oi1X4DaM1qw=; b=w6oL0KVkGwrZXKGmoj3R4IutkPAooFYt0DmPek4Z5bdsgx0q6oTq7zWEM0M0Q9QeUEYyhszCRzxhjAPZVXdXypwSoAeOSnJIy8WmJ4eEvvzEYV9ylWmgHBjk8oms04waUUmh/Y06S68sp1Mt6mvNA54seyvx3B5Qx4GurYaHmgs=
X-HE-Tag: 1794297626-295485
X-HE-Meta: U2FsdGVkX18mIf4ApEiQKIHE6g9LjKdPV19iRvd0lwuO12vhYWAEWt0DI+PRNkcBaeuICPUke1dIO3mwRThaV022ELj1tWwkLrxoIO56bsB7XE5SCPq6O9MtW1UcWfK6FhpazfFDX1S+VUetoSRJoHu6abJEdE5iOAOsz854XJ40VFU/zapxHG1ATz2ObXO3NvYuy7dRRMl06IemtFOPgQaIp28WvASXWurPe+jFY48KDJJwo1gxJU36NUUG05O/OoI7xbJTdDPeV4XlrnGyzj18G3geHXkUs0Hc8pF7Ula6GLGoAf/F4vON12xqLWJe6K4UHdkGYnMW/taFPr63B53OTfi6UDR39Q1KMKQXCxRoCZrIqodNeQ==

On Mon, 9 Nov 2026 05:04:50 -0800
Breno Leitao <leitao@debian.org> wrote:

> Steve,
> 
> Thank for the patch,
> 
> On Mon, Nov 09, 2026 at 08:39:43AM +0000, sashiko-bot@kernel.org wrote:
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index e760d2fe386fb..cf9e0dc10c88f 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -1494,7 +1494,13 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
> > >  	if (RB_WARN_ON(cpu_buffer, rb_list_head(list->prev->next) != list))
> > >  		return NULL;
> > >  
> > > -	page = head = cpu_buffer->head_page;
> > > +	/*
> > > +	 * Make sure that the start of the search of the head_page does not
> > > +	 * start between the writer adding the UPDATE and the new HEAD that it
> > > +	 * moves forward.
> > > +	 */
> > > +	/* Sync with the writer moving the HEAD in rb_handle_head_page() */
> > > +	page = head = smp_load_acquire(&cpu_buffer->head_page);  
> > 
> > [Severity: Medium]
> > Can the reader's non-atomic update of cpu_buffer->head_page in
> > __rb_get_reader_page() race with the writer's new store in
> > rb_handle_head_page() and advance cpu_buffer->head_page past the sub-buffer
> > marked for update?  
> 
> I've asked my robot to test this case, and it was still able to
> reproduce the race, even with this patch.


Are you still testing with the minimum of 7K? Can you up it to can you
echo 11 into buffer_size_kb to see if it is an issue with three
sub-buffers?

I just want to know if it you are catching issues with something that
looks like this:

                             tail
                              v
   +--HEAD--> subbuf ----> subbuf --+
   |                                |
   +--------------------------------+

Two subbufs should still be fixed but I want to make sure I'm not
looking at two different bugs.

-- Steve
