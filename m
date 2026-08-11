Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789D36D4E1;
	Tue, 11 Aug 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479681; cv=none; b=ayV+CnKmUS/RpiNRRz0LxWRqU+BNmEnfGf5bfLsstVcesHDrKdyXedViFSGLvUwq5/L5aw8QPacXURIqlitT/bo7mWcF3FEMhPayRJf8pNnNvAUIc8jbN7bUbYNeGJgEqLC/cz6AfJ2mgk9dgXEBaTawMRWN+tlBbOnRuUun6JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479681; c=relaxed/simple;
	bh=j5vSuUlMpsm5RdxJT6qJSOQz9ajuzeV2Y3eY8G0ywRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKtekBrBRkPe73+Edvvgrwe2Q55HyBgvNb/yX9KhHJs2iOHT722rsSozm2DFRtEJVbmaINibKRM49jPtwv0Ew5vCmbxWMqiK3PeDF+AU2sFLDTizajY9xBNga9fl0FmpmcspyzMI1/AJES1HAqTULOAkwJqv0iQryZzTzC4D7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 472ED12020D;
	Tue, 11 Aug 2026 20:21:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 2B58617;
	Tue, 11 Aug 2026 20:21:15 +0000 (UTC)
Date: Tue, 11 Aug 2026 16:21:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Baolin Liu <liubaolin12138@163.com>
Cc: almaz.alexandrovich@paragon-software.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 liubaolin12138@gmail.com, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v3 v3 5/7] ntfs3: add allocation tracepoints
Message-ID: <20260811162127.5f98eadb@gandalf.local.home>
In-Reply-To: <20260807010354.2277156-6-liubaolin12138@163.com>
References: <20260807010354.2277156-1-liubaolin12138@163.com>
	<20260807010354.2277156-6-liubaolin12138@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2B58617
X-Stat-Signature: ocjs9nwgno1du4p8cgdsbye7n7pmtnyh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/VU1IovNUTnpcMeB6DOZ3dU/YGtDrMiPc=
X-HE-Tag: 1786479675-313721
X-HE-Meta: U2FsdGVkX18Vc6VeKMEkbAlF3WmEe58w7Dt8nBcaBp42q4QsW6Nl1xAF53wEIuyX4osdtK915C/jAE7BTDU1uIQQvW0RTczlxoirvGf7cuw//knGnJKI89t7k9MISFvggTR7Jofwem9n790ur1xmHMaeVEna/rKqJd/mG3hB2u8RTTfHmK81sMLquY6XG2erVb92se9voSuA7MIRoQHslIMg0H3n1qoxvYIIWQAbioHWA2Q9JNi4XKq9len1K+ZRjg4zStkA18fRVoQSiRaKROSkIOUIXyhmg2mhd8yYALzFBiwHJUDbIw5tI2FAD7EK0xJYFApOEd5XTTviGdOm6106Un37yOB4WLXaqbDPOfgLtEY1KcijBWpdW4qd9K/FV482v3h8OMW7DK1UgS+JXQ==

Also Sashiko had something to say about this patch: https://sashiko.dev/#/patchset/20260807010354.2277156-8-liubaolin12138%40163.com

> --- Patch [5]: [PATCH v3 v3 5/7] ntfs3: add allocation tracepoints ---
> commit 0592c540bc564c346cb524c624f6ee4a5768406b
> Author: Baolin Liu <liubaolin@kylinos.cn>
> 
> ntfs3: add allocation tracepoints
> 
> This commit adds trace events for ntfs3 allocation operations. It introduces
> events for attr_allocate_clusters, attr_set_size_ex, and attr_data_get_block
> to help observe cluster allocation, size changes, and block mapping activity.
> 
> > diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
> > index 4ac05ed29e49d..d16dd127ff2e5 100644
> > --- a/include/trace/events/ntfs3.h
> > +++ b/include/trace/events/ntfs3.h
> [ ... ]
> > +TRACE_EVENT(ntfs3_attr_set_size_ex,
> > +	TP_PROTO(struct inode *inode, u32 type, u64 new_size, bool keep_prealloc,
> > +		 bool no_da),
> > +	TP_ARGS(inode, type, new_size, keep_prealloc, no_da),
> > +	TP_STRUCT__entry(
> > +		__field(loff_t, old_size)
> > +		__field(u64, new_size)
> > +		__field(unsigned long, ino)
> > +		__field(dev_t, dev)
> > +		__field(u32, type)
> > +		__field(bool, keep_prealloc)
> > +		__field(bool, no_da)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->old_size = i_size_read(inode);
> 
> Will this actually record the previous size during truncate operations?
> 
> When an application truncates a file, the VFS size is often updated before 
> calling into the filesystem. For instance, looking at how ntfs_setattr()
> handles this:
> 
> fs/ntfs3/file.c:ntfs_setattr() {
>         ...
>         truncate_setsize(inode, newsize);
>         
>         err = ntfs_set_size(inode, newsize);
>         ...
> }
> 
> Since truncate_setsize() updates the VFS inode size before attr_set_size_ex()
> and this tracepoint are reached, won't i_size_read(inode) just return the
> newly truncated size, resulting in old_size equaling new_size?
> 
> Could the actual old size be passed as an explicit parameter to the 
> tracepoint instead of sampling it here?
> 
> > +		__entry->new_size = new_size;
> > +		__entry->ino = inode->i_ino;
> > +		__entry->dev = inode->i_sb->s_dev;
> > +		__entry->type = type;
> > +		__entry->keep_prealloc = keep_prealloc;
> > +		__entry->no_da = no_da;
> > +	),
> [ ... ]

-- Steve
