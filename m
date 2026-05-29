Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E83EFD0E;
	Fri, 29 May 2026 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065503; cv=none; b=I67n86bPo7nyHMs18DuUiFWNg2fFU/0t3k73s089bw8hCTfdVJ7dyrFq7RM+izz3PY3bEJxcDCkgFnbTIN+3YcC3VDHoRslv+VKCG5gYxbx73/2v+xofDniGmBUUoRcbCKAkLnAkJ6PGj9HmsbJjpjJ9Z58xgW5qRmxzkLFpnp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065503; c=relaxed/simple;
	bh=+NJqJNdqUaB25DmecAr48uBGbdsKlflV2fgmII/kV2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hO4HNzKGDF2ro5W5jfSZEH7wtw0seszlN4RMrLhyrg8IDAOe6C5xTD7/07+E88t90mhOhQ4KhxbAzEeT8AU4zOs6LhNaj+3fMrkDzEea1FDJn40AUOVOQXpLeFVkZzOcOBtcCy1rTWyM5MhEsrNRpFSqcr6nSSqt5Y+Ilc9UEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 84C1416084C;
	Fri, 29 May 2026 14:38:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 9547E8000E;
	Fri, 29 May 2026 14:38:12 +0000 (UTC)
Date: Fri, 29 May 2026 10:38:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chen Jun <chenjun102@huawei.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: Introduce a new filter_pred "caller"
Message-ID: <20260529103811.37b0e357@fedora>
In-Reply-To: <20260514131901.8c94136f6fede18c608c8a55@kernel.org>
References: <20260508122623.74290-1-chenjun102@huawei.com>
	<20260512084750.c17a93d0ccdacddfd52d3d40@kernel.org>
	<20260513124017.770e3098@gandalf.local.home>
	<20260514131901.8c94136f6fede18c608c8a55@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9547E8000E
X-Stat-Signature: e199x57jbgmmnnkyyqdqoa9nzo9ujzj9
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19SKvHt3PwHMk0eVFiTU2M0EJLxEzO0gZk=
X-HE-Tag: 1780065492-638300
X-HE-Meta: U2FsdGVkX19BmTm4pyfa48STlmGXO02ASdwLdOXPuQJtevFnxhyX64bDurZIQfvgnNEcKoHZsgT5bU+kT947Kj+8zOiZ6YFePb+u9tVLbgRoFe3UsCHj6E2vUHX3PjlbhkAL12IH/f4oa0FqXT21ZwDZwxaVK1KDOcJg61k8pERxUz9WTL5LeH3v7Ss+rk9K54Ikzz0fOcWSW/TJjQnJzWMvp9ezDY5QpA5i+H2AJts0FnmGa6doqYlIduP0ndOFl2VLzvPVV1ermsCazDxufXjjYL6y7vHkItH3+Cvk7GQqkxZH9n22Muj6VA2zIQgJ5wsSitHv1mZJLTrwdkLdLRwmthfADmKFm3dsljijMsbR46u1hO9LxEtZeL9YlJ6AMaw3oHaVduhzLK5YLbZZcAsnnAlqabL8xzU+60pU8dPlk6jLDEUFviQLem1EWSDJJRrF/x0wg58=


Hi Chen,

Do you plan on sending updates to address the comments that Masami and
I have made?

-- Steve


On Thu, 14 May 2026 13:19:01 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 13 May 2026 12:40:17 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 12 May 2026 08:47:50 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >   
> > > On Fri, 8 May 2026 20:26:23 +0800
> > > Chen Jun <chenjun102@huawei.com> wrote:
> > >   
> > > > Low-level functions have many call paths, and sometimes
> > > > we only care about the calls on a specific call path.
> > > > Add a new filter to filter based on the call stack.
> > > > 
> > > > Usage:
> > > > 1. echo 'caller=="$function_name"' > events/../filter    
> > > 
> > > Thanks for interesting idea :)
> > > 
> > > BTW, we already have "stacktrace". Since this actually checks
> > > stacktrace, not caller, so I think we should reuse it.
> > > Also, I think OP_GLOB is more suitable for this case.
> > > (and more useful)  
> > 
> > Actually, it's not a stack trace, it's a function that is called from other
> > functions. But since "caller" sounds like a direct called function (stack
> > trace of the first instance), I think perhaps it should be "called_within" or
> > something similar. :-/  
> 
> Yeah, what about "callers"?
> 
> > 
> > Also, OP_GLOB can't work because it only works for a single function. At
> > the time of parsing, it finds the function (and should probably error out
> > if there's more than one function with a given name). It then records the
> > start and end address of the function so it only needs to find if one of
> > the entries in the stack trace is between the start and end of the function.  
> 
> Ah, OK. It is just comparing address, not name.
> 
> > 
> > I don't think this is possible with GLOB. We don't want to do a search of
> > the functions when the event is triggered.  
> 
> Agreed.
> 
> Thanks,
> 
> > 
> > -- Steve  
> 
> 

