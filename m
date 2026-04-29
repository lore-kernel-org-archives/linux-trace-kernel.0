Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADC2727FD;
	Wed, 29 Apr 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474362; cv=none; b=PArtZ0UBGuY+P/0R46nraV9L14jq7DDmFPNs6rG/YO0ukrPHOXv3ZfnIrqh8smNakqbq3nkXb0GfiGKMq50USxHjwszhx3fog29NQqKCHUfyOQDoDW3HD1CqLfwN7/SpNk1e6E6T7ij9NaU1UyqTqGHshTXBXJqCVOfjm/XUMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474362; c=relaxed/simple;
	bh=9UoKVEVw1kIm0WZl8heNOTisVfH/IG40hANdcddrKro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVCHuQB6M5ivcNxVsXT0uc7eWvKU46whn2SkFYVoDtrx+PXzwKEEaw+E90sT050GUsSFig/NczVBZNMOmgiXdOAEMCpHPbRuCi2UKh5z9V6TFFDRvvLFEo4b2PZ7+KByX5OQ+SLzQvC3T5sYuqRq45tKfp0faFg24PU8Q/J8Ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B933C1A0313;
	Wed, 29 Apr 2026 14:52:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id A344B20011;
	Wed, 29 Apr 2026 14:52:28 +0000 (UTC)
Date: Wed, 29 Apr 2026 10:52:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SUVONOV BUNYOD <b.suvonov@sjtu.edu.cn>
Cc: akpm <akpm@linux-foundation.org>, vbabka <vbabka@kernel.org>, linux-mm
 <linux-mm@kvack.org>, mhiramat <mhiramat@kernel.org>, mathieu desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, surenb <surenb@google.com>, mhocko
 <mhocko@suse.com>, jackmanb <jackmanb@google.com>, hannes
 <hannes@cmpxchg.org>, ziy <ziy@nvidia.com>, david <david@kernel.org>,
 vishal moola <vishal.moola@gmail.com>, corbet <corbet@lwn.net>, skhan
 <skhan@linuxfoundation.org>, linux-doc <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] mm/page_alloc: trace PCP refills and PCP zone lock
 usage
Message-ID: <20260429105245.192e67a8@gandalf.local.home>
In-Reply-To: <1453063691.2584758.1777433513691.JavaMail.zimbra@sjtu.edu.cn>
References: <20260425091335.346504-1-b.suvonov@sjtu.edu.cn>
	<20260427060142.131055-1-b.suvonov@sjtu.edu.cn>
	<20260428142335.3bca0166@gandalf.local.home>
	<1453063691.2584758.1777433513691.JavaMail.zimbra@sjtu.edu.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A344B20011
X-Stat-Signature: hkat18xezybbqk5dyxadixumtmrtrta1
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/gO+H3IUx7sVHTPg/bx8A4FuIpjf3S24k=
X-HE-Tag: 1777474348-817918
X-HE-Meta: U2FsdGVkX1+bnbMuIeHV/UgJRUTOQxB6W5jOfn2Q0Tl/AkipVunZIoaSus3NWsVFId/CmDr8sy/VbnbG0pb/aIuMKsaKG1AeCyOC/v2A6T77ZyfIyT6VlTgf3ir5WFPnCzA+5p/LxM4uwNTx/t9CpfKW/bnRveONJSermvPB4/FoeRuVsFOmIgHwKUpLPtgfbLZj+FDkjYxsu7bchL/K2FcDIAq3ncdRKe8Dfc+R7VOLqVpUjNNDZEZfuuPD0rvxQsRxH0kK+nHQXABXhdOHwXmrCMyxfmtNcdCIC/XtQuEAHr5n76QSzc3c63+1BK6s

On Wed, 29 Apr 2026 11:31:53 +0800 (CST)
SUVONOV BUNYOD <b.suvonov@sjtu.edu.cn> wrote:

> Thanks for reviewing Steven,
> 
> >Why this change? It makes it much harder to understand.
> >
> >The above is not a normal macro. Ignore any checkpatch warnings about it.
> >The proper way to do the TP_STRUCT__entry() is to make it just like a struct:
> >
> >struct {
> >	unsigned long		pfn;
> >	unsigned int		order;
> >	int			migratetype;
> >};
> >
> >Thus, the macro should be:
> >
> >	TP_STRUCT__entry(
> >		__field(	unsigned long,	pfn		)
> >		__field(	unsigned int,	order		)
> >		__field(	int,		migratetype	)
> >		),  
> 
> 
> Yeah sorry for the formatting issue, will fix in v3. Any other concerns?
> What do you think about the introduction of those tracepoints themselves?
>

It's a basic tracepoint and nothing unusual about it. I only watch over how
tracepoints are created and some use cases and make sure they are done
properly. But the introduction of tracepoints in other subsystems are up to
the maintainers of those subsystems. They are the ones that know what is
useful or not.

In other words, it's up to the MM subsystem maintainers to decide.

-- Steve
 
