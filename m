Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203731F9A4;
	Thu, 30 Jul 2026 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414337; cv=none; b=hPSCcwkLBGz2GEBLJe35LNJ+4fav7w935z4AWWjZkv2r0PnSJTUoNkQcFSBXkRjm3d4NQPPU+173xNxus1eMNMpMU45VrR/eHUftygGdDR2gg848XnJIABdmSCeRGkERi7Ge6GmQq1qQgvaOunfm+PWCfbQei2Bo7ryIHiIVCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414337; c=relaxed/simple;
	bh=RIeZGggivArIqeKfjW6DLsQFUXw3npU6ukfuIf29naU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWq1kVNqrGYq8Pb6U4IIEeqDr+kMv8JH2j+4IpQRTTbxK/r1uusltk9QD7npRRKfLp3gMSi0wDuwdaX5nUwC2kOA1etCk8giKX+3RFHkV6l/fmp7huY0JkuPkleCGK7sm5tsDx3Yd25qn2Xpr/iMAM4BWNcB2O+qkJbTguAPk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id E1AD7A00E4;
	Thu, 30 Jul 2026 12:25:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 3AFCA20015;
	Thu, 30 Jul 2026 12:25:26 +0000 (UTC)
Date: Thu, 30 Jul 2026 08:26:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Fix subbuf_ids memory leak in
 rb_allocate_cpu_buffer() error path
Message-ID: <20260730082603.29e57f29@gandalf.local.home>
In-Reply-To: <amsHlMCNHV9JWA0l@google.com>
References: <178539491147.180138.1181424244288838594.stgit@devnote2>
	<amsHlMCNHV9JWA0l@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 47j7n44ua7idxnkd185q8wbhopc5excw
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 3AFCA20015
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VUbFaKBOtUTCOqb/1qSLcrrzwP423N3E=
X-HE-Tag: 1785414326-83465
X-HE-Meta: U2FsdGVkX19mGtzABtDtU4Zbf8UcaLFYqaLytSMbMXRTRAWn7jUHvBMIfpaGTr0VV7pOAlhkhZHotSYvz9umocywpIUFmlb5YP0iuQCBAu9EJptA88AbGfxE1z7hqcfENopNhzqtAdiRhSDUCUWwpqfYB0PBOB/QApp2vL/KPopgekshWnHB62PKhqfqNCDP+PbhBcbhtj9It8V+FqwqCqBp8DpSniarloxq7P9ZxN+BYP75Xi0rj1+vGxO9qlYHSbpntENkp3xt5UEI96kH/x4/En8uxG9eVncQlEcM+AQIVRx0TvWrwM6OnyNAia9+miaqqCqKt09afdaOHI1iRUkrB82BxTtz

On Thu, 30 Jul 2026 09:13:08 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 78d3875a47a5..03f6baf6a5f5 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2599,6 +2599,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
> >  	return_ptr(cpu_buffer);
> >  
> >   fail_free_reader:
> > +	if (cpu_buffer->remote)
> > +		kfree(cpu_buffer->subbuf_ids);  
> 
> alloc_cpu_buffer() being kzalloc, I suppose here we could just unconditionally
> call kfree(cpu_buffer->subbuf_ids) ?

Agreed. This also removes the coupling between the freeing of subbuf_ids
and it being a remote (in case something else decides to use it).

-- Steve


> 
> >  	free_buffer_page(cpu_buffer->reader_page);
> >  
> >  	return NULL;
> >   
