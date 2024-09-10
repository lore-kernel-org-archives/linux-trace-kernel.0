Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83B1755C;
	Tue, 10 Sep 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987033; cv=none; b=pRp/zPnV8ryJc3UUchjZ11xWilwoOicSxjRrRvGlp56bo+U/jXjEv1OKxPiKBwI5FmD8RENLtbrarzxKYZgr25/7Kft1VbxMfSjdxwQCsfezWXaaE5XS6z+KObvS/oeGoLdcS/y6nhvVURkxVeFqrAr9zQyjLubTWwzulsIM9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987033; c=relaxed/simple;
	bh=wnsExEAv9F4rU9Jsc1b+G6uequLRWbDtooFkhbI7Ous=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptBNDPkgflErDfKBxGMg4CUcCJCICsq3JiEi5x8L/vId7PwXVpK2EgXg9nWsnPQ7918CcTCVnfdXCFHfUYFPj8ZCDzrZGPK+DxoLTDgQDjvdlp+DcO+y6yL13Ck9Uk5f2NT/zmzImm574sc9Pu+DR0cECFgcgNJ0k3jcPwq8UC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3614FC4CEC3;
	Tue, 10 Sep 2024 16:50:32 +0000 (UTC)
Date: Tue, 10 Sep 2024 12:50:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] function_graph: Support recording and printing the
 function return address
Message-ID: <20240910125033.0a3986fa@gandalf.local.home>
In-Reply-To: <CAErzpmtJHhZpFg0sHtffexM0Lu6y2xzbVZ1SXGxKob_Dz0+Bfw@mail.gmail.com>
References: <20240908142544.1409032-1-dolinux.peng@gmail.com>
	<20240909110415.33cb5f22@gandalf.local.home>
	<CAErzpmtJHhZpFg0sHtffexM0Lu6y2xzbVZ1SXGxKob_Dz0+Bfw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 14:15:39 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:
> > >
> > > See below logs with both funcgraph-retval and funcgraph-retaddr enabled.
> > >
> > > 4)               |  load_elf_binary() { /* A=bprm_execve+0x249/0x600 */  
> >
> > I wonder if we should make this look more like the function tracer when it
> > shows the parent. That is:
> >
> >   4)               |  load_elf_binary() { /* <-bprm_execve+0x249/0x600 */  
> 
> Nice, Is it necessary to add a prefix letter for the return value? For
> example, when
>  both funcgraph-retval and funcgraph-retaddr are enabled, like this:
> 
>          avc_policy_seqno(); /* <-selinux_file_permission+0x107/0x140 V=0x0 */

How about:

>          avc_policy_seqno(); /* <-selinux_file_permission+0x107/0x140 ret=0x0 */

As "ret" is more obvious than "V".

> 
> >  
> > > 4)               |    load_elf_phdrs() { /* A=load_elf_binary+0x84/0x1730 */
> > > 4)               |      __kmalloc_noprof() { /* A=load_elf_phdrs+0x4a/0xb0 */
> > > 4) + 47.910 us   |        __cond_resched(); /* V=0x0 A=__kmalloc_noprof+0x28c/0x390 */
> > > 4) ! 204.142 us  |      } /* __kmalloc_noprof V=0xffff888201e32c00 */
> > > 4)               |      kernel_read() { /* A=load_elf_phdrs+0x6c/0xb0 */
> > > 4)               |        rw_verify_area() { /* A=kernel_read+0x2b/0x50 */
> > > 4)               |          security_file_permission() {
> > > 4)               |            selinux_file_permission() { /* A=security_file_permission+0x26/0x40 */
> > > 4)               |              __inode_security_revalidate() { /* A=selinux_file_permission+0x6d/0x140 */
> > > 4)   1.182 us    |                __cond_resched(); /* V=0x0 A=__inode_security_revalidate+0x5f/0x80 */
> > > 4)   4.138 us    |              } /* __inode_security_revalidate V=0x0 */
> > > 4)   1.513 us    |              avc_policy_seqno(); /* V=0x0 A=selinux_file_permission+0x107/0x140 */
> > > 4) + 12.133 us   |            } /* selinux_file_permission V=0x0 */
> > > 4) + 39.834 us   |          } /* security_file_permission V=0x0 */
> > > 4) + 42.710 us   |        } /* rw_verify_area V=0x0 */
> > >

> > > +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> > >  /* Function call entry */
> > >  FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
> > >
> > > @@ -79,6 +80,7 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
> > >       F_STRUCT(
> > >               __field_struct( struct ftrace_graph_ent,        graph_ent       )
> > >               __field_packed( unsigned long,  graph_ent,      func            )
> > > +             __field_packed( unsigned long,  graph_ent,      retaddr         )
> > >               __field_packed( int,            graph_ent,      depth           )
> > >       ),
> > >  
> >
> > Let's make this a new event, so that when this option is not enabled, we
> > don't waste the ring buffer. For function tracing, every element added to
> > the event will add megabytes extra to the ring buffer.
> >
> > It should be possible to switch what event gets created at the time of the
> > trace. Even calling different functions to do it.  
> 
> Sounds good, we may create a new event as follows:
> 
> struct ftrace_graph_ent {
> unsigned long func; /* Current function */
> unsigned long retaddr;
> int depth;
> } __packed;
> 
> FTRACE_ENTRY_PACKED(funcgraph_retaddr_entry, ftrace_graph_ent_readdr_entry,
> 
> TRACE_GRAPH_RETADDR_ENT,
> 
> F_STRUCT(
> __field_struct( struct ftrace_graph_retaddr_ent, graph_retaddr_ent )
> __field_packed( unsigned long, graph_retaddr_ent, func )
> __field_packed( unsigned long, graph_retaddr_ent, retaddr )
> __field_packed( int, graph_retaddr_ent, depth )
> ),
> 
> F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)

Why not add the ret in the printk?

  F_printk("--> %ps (%d) <-%ps", (void *)__entry->func, __entry->depth, (void *)__entry->retaddr)

Then user space parsing tools could use this by default, when it doesn't
know how to parse it.

> );
> 
> If we were to introduce another new feature such as funcgraph-args which
> adds a `ftrace_regs` to the `ftrace_graph_ent`, would it be necessary to
> create yet another new event?

Probably yes.

> 
>  In the scenario where both funcgrah-retaddr and funcgraph-args are enabled,
> it is possible that an additional new event may also be required.

Yes, that would likely be another event.

-- Steve
