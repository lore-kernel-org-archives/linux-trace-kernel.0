Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884FE36D4E8;
	Tue, 25 Nov 2025 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764033143; cv=none; b=b+UDGjikBQ38mHPAJpftr4Bqxe6Tt3biBRE9iPSc2tg87exAmQ9ZQuO5kXIsvXNGmgfarlegeemY0kDyIsRP9WyiFG6az2QoFsaTNNeDWeZvC/kVqd0ZUc5LYB1aCd33zWmBvpIionEddtTUsKhJonF9xWsp60edJjxp3sNBDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764033143; c=relaxed/simple;
	bh=JBKWAzFiFLxQa5ajCQQKeXXtCIduhQUWxAdAX3+RLKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgX9/oqkCZpgpG70KmXYBDNkq8gggfxvfNKGjK+9N4anbLmg7T/aNmZuNHxyfVlveiorGR+myqeo/tiaAiWZC9aDdyI/eH9nh0IiHK9zGghIgLBWvHHizErxv3imUTaXwzH0eOzbjKs4FQObfrzhBX+0GZosvxnd7P5acK0evug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 1B58C1A046A;
	Tue, 25 Nov 2025 01:12:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 4CB5E20010;
	Tue, 25 Nov 2025 01:12:17 +0000 (UTC)
Date: Mon, 24 Nov 2025 20:12:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donglin Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251124201258.0e34ac3b@gandalf.local.home>
In-Reply-To: <20251124165440.1418ed85@gandalf.local.home>
References: <20251114025522.2115359-1-dolinux.peng@gmail.com>
	<20251124164701.1216a073@gandalf.local.home>
	<20251124165440.1418ed85@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4CB5E20010
X-Stat-Signature: zzbuyjurh1et783jbxmiewyyyxw8t4mk
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18wXEzwbKBX+aX+8Jb9PHrUuBgkEq590Nw=
X-HE-Tag: 1764033137-823908
X-HE-Meta: U2FsdGVkX19gXTAWcTewWLXUIuJHGk2JwtdGWtHMzSPvl7cyelsjwkpAvvgII51Fz9lrsDSyn6nYPuOKKUw9MVbINj7bLFx3xWTrdq7AypodFfPXY+g5I/w8vKFsoNxvU3mdYiEXqK8yCmEO/xThSQeDyHC2KK7YNPIgBF+IrW6SylfJgsrwL+5TPYEx4YXRy/T03/BjENyWO/ehjuih1AKE9ApP6JWOLGhcpfB42klmW1h56V5ywPwINwdpgEVIVV/cFxHWuF4utJbbB+C7dZfXSOC3e5TmlpJd0wkCWRWLNHCXXaOLHadAtJA2kr1d0uDFmfL1O7etBE+9ystk+tAfi6PGqfDhHZ6He4A0MxYBVSkDh/t2OkwdcnAwEvKG

On Mon, 24 Nov 2025 16:54:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 24 Nov 2025 16:47:01 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > --- a/kernel/trace/trace_entries.h
> > > +++ b/kernel/trace/trace_entries.h
> > > @@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
> > >  	TRACE_GRAPH_RETADDR_ENT,
> > >  
> > >  	F_STRUCT(
> > > -		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
> > > +		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
> > >  		__field_packed(	unsigned long,	graph_ent,	func		)
> > >  		__field_packed(	unsigned int,	graph_ent,	depth		)
> > > -		__field_packed(	unsigned long,	graph_ent,	retaddr		)    
> > 
> > You can't delete the retaddr without breaking user space.
> > 
> > Please keep that here.  
> 
> I added this, and user space works again:
> 
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index 593a74663c65..4666b6179056 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -98,6 +98,7 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
>  		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
>  		__field_packed(	unsigned long,	graph_ent,	func		)
>  		__field_packed(	unsigned int,	graph_ent,	depth		)
> +		__field_packed(	unsigned long,	graph_ent,	retaddr		)
>  		__dynamic_array(unsigned long,	args				)
>  	),
>  

Nope, this wasn't enough. I got garbage from this. The following patch
appears to make it all work though (this is against your patch that was
forward ported to my for-next branch):

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 88cb54d73bdb..ba180d19423e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1121,12 +1121,10 @@ static inline void ftrace_init(void) { }
 
 /*
  * Structure that defines an entry function trace.
- * It's already packed but the attribute "packed" is needed
- * to remove extra padding at the end.
  */
 struct ftrace_graph_ent {
 	unsigned long func; /* Current function */
-	int depth;
+	unsigned long depth;
 } __packed;
 
 /*
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 05fb6c9279e3..d509a5041d38 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -60,6 +60,13 @@ enum trace_type {
 	__TRACE_LAST_TYPE,
 };
 
+/*
+ * Structure that defines an entry function trace with retaddr.
+ */
+struct fgraph_retaddr_ent {
+	struct ftrace_graph_ent		ent;
+	unsigned long retaddr;  /* Return address */
+} __packed;
 
 #undef __field
 #define __field(type, item)		type	item;
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 593a74663c65..87f4228374cd 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -80,11 +80,11 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	unsigned int,	graph_ent,	depth		)
+		__field_packed(	unsigned long,	graph_ent,	depth		)
 		__dynamic_array(unsigned long,	args				)
 	),
 
-	F_printk("--> %ps (%u)", (void *)__entry->func, __entry->depth)
+	F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
 );
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
@@ -95,13 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
 	TRACE_GRAPH_RETADDR_ENT,
 
 	F_STRUCT(
-		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
-		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	unsigned int,	graph_ent,	depth		)
+		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
+		__field_packed(	unsigned long,	graph_ent.ent,	func		)
+		__field_packed(	unsigned long,	graph_ent.ent,	depth		)
+		__field_packed(	unsigned long,	graph_ent,	retaddr		)
 		__dynamic_array(unsigned long,	args				)
 	),
 
-	F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->depth,
+	F_printk("--> %ps (%lu) <- %ps", (void *)__entry->func, __entry->depth,
 		(void *)__entry->args[0])
 );
 
-- Steve
