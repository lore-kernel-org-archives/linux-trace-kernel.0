Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E432F774;
	Mon, 24 Nov 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021245; cv=none; b=hWlXngThwofaFVghsiblSw5w4gPRsGxo6bA1GP0JYrpNPLZ438wm7YVqqOdrKxVX8C+PUJPXRORMVT8bhCkjxOjSTJU8dluYjhyJSXVmBOn1hhAeN3OoTaXicWLwQIF2nWUGp9x1qPNmimzFSQdY9OTu2mIaGCV/wX9ml29ERWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021245; c=relaxed/simple;
	bh=i+y/zYMbOS3VVJbIz/zAeprIxtSZJyasGN16FPNdrI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnC0JtFJoccKMYaffhzUSx9uCk2YRetUGeVERQHNWr+YZ6cGxO6YYL49onZXBAIWmEvLxxlqbnrmXbw9IHhGIJBM5JTtJXKa4IO90loovYDpigUj7zC/Ggt24XHmsVJpciSjW1d3S/IvrdV/uZyRoSq/oANvIehvFbqZL03v1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2C2D65949D;
	Mon, 24 Nov 2025 21:54:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 4C15217;
	Mon, 24 Nov 2025 21:53:58 +0000 (UTC)
Date: Mon, 24 Nov 2025 16:54:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donglin Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251124165440.1418ed85@gandalf.local.home>
In-Reply-To: <20251124164701.1216a073@gandalf.local.home>
References: <20251114025522.2115359-1-dolinux.peng@gmail.com>
	<20251124164701.1216a073@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 31xmwz6sksy5wc6fy6atfqc4c3xjcrpo
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4C15217
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/QwB7FWvqjb6TRYNkA3mv0ofbNQj2hMDU=
X-HE-Tag: 1764021238-347696
X-HE-Meta: U2FsdGVkX18x7fS7sDaX5vbtao4JNKctv8oVctO1inzo1yBPBOiFxzPjhgKXMWctf8LHvw4t/EzlwcucHNhAGF/ABIGNIj3XJk3tnKZgjXwQfApbtRxyBpaXDLiJiWSM+GaAv7+TsvehpGAkaTB7zdWi8H8wAeaiT9NqQMKh2fdTcd3iiEU5U/i9xt6h5I/QAgP87J9zsNpstJPfOgcqriX330q+VlzbFCt1W9ndUd92weLtdkf7CpRgt1SolJt7qFrhjuoqa3hFssnwHxvIGDcpqi40dT/iNEho0PHiHpXSRNIGsjN6ZF+alD4Sf9nhfz7zcMw9YdHDYifrHBl2kggoT2qUTiPxI4fDHfRbNoC+7vKAKQCSQTGGw4LzoRkv

On Mon, 24 Nov 2025 16:47:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
> >  	TRACE_GRAPH_RETADDR_ENT,
> >  
> >  	F_STRUCT(
> > -		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
> > +		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
> >  		__field_packed(	unsigned long,	graph_ent,	func		)
> >  		__field_packed(	unsigned int,	graph_ent,	depth		)
> > -		__field_packed(	unsigned long,	graph_ent,	retaddr		)  
> 
> You can't delete the retaddr without breaking user space.
> 
> Please keep that here.

I added this, and user space works again:

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 593a74663c65..4666b6179056 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -98,6 +98,7 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
 		__field_packed(	unsigned int,	graph_ent,	depth		)
+		__field_packed(	unsigned long,	graph_ent,	retaddr		)
 		__dynamic_array(unsigned long,	args				)
 	),
 
-- Steve
