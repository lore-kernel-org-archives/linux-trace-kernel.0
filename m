Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152542A8F;
	Mon,  2 Jun 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883086; cv=none; b=hXw8nQqBiTi0ken2NIYe/k7WNjdlMXs+uwLEl8EOx67XQ+vL6qnVxhfC7MnFz4RnTSysW3qSJspb1PgOjh64M7r3EQxjDGEPebBVmV/zPKjsZdS9Kfr1OqG7LO2uRVaXeV/gUFiYLfLAa8G5uJcRYM557LcfReLWDDX9h290wfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883086; c=relaxed/simple;
	bh=QyIxyGdsJ2Ufa+VeRhRVwBrX8/HQAKmVI+M8UPFvMBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9i9AuEyVIiLwekoMkT0Uq8vGD2NRO+9JrFD1N1z5gov00U31jpzhoMDNRaoOVOiAkfE7o/P3v8d3bWY+FdP9z6D3xjq3hiW4prvR17rMLKsdSJbHg5Dp6QsjDh48e1PARjF064qxPi4AfvpXcI2KGcvtl93TMQUJcum4Fi6n0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF59C4CEEB;
	Mon,  2 Jun 2025 16:51:24 +0000 (UTC)
Date: Mon, 2 Jun 2025 12:52:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Hildenbrand <david@redhat.com>
Cc: Tal Zussman <tz2294@columbia.edu>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>, Andrew
 Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] x86/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum
Message-ID: <20250602125236.21f4aeb3@gandalf.local.home>
In-Reply-To: <876f65d0-e873-4c08-b404-db89e542e7a3@redhat.com>
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
	<20250528-tlb-trace-fix-v1-1-2e94c58f450d@columbia.edu>
	<876f65d0-e873-4c08-b404-db89e542e7a3@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 11:06:10 +0200
David Hildenbrand <david@redhat.com> wrote:

> > diff --git a/include/trace/events/tlb.h b/include/trace/events/tlb.h
> > index b4d8e7dc38f8..725a75720a23 100644
> > --- a/include/trace/events/tlb.h
> > +++ b/include/trace/events/tlb.h
> > @@ -13,7 +13,8 @@
> >   	EM(  TLB_REMOTE_SHOOTDOWN,	"remote shootdown" )		\
> >   	EM(  TLB_LOCAL_SHOOTDOWN,	"local shootdown" )		\
> >   	EM(  TLB_LOCAL_MM_SHOOTDOWN,	"local mm shootdown" )		\
> > -	EMe( TLB_REMOTE_SEND_IPI,	"remote ipi send" )
> > +	EM(  TLB_REMOTE_SEND_IPI,	"remote ipi send" )		\
> > +	EMe( TLB_REMOTE_WRONG_CPU,	"remote wrong CPU" )  
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I'm guessing this will go through the mm tree?

-- Steve
