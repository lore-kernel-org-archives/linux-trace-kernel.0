Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5C17A303;
	Thu, 27 Mar 2025 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743100685; cv=none; b=F6MMucYCUVEqvb3saGSiPKV7Y40ORwV6/VAHQagP4arn4NXcBkpTV6rCdzKsTsMS4q43DJmKhj8a/PbqPjzxriIm0ptvwpyqKcewuXQcW/137+ADwEDPoyDy9VlL5xVXYhnXgDw0TVYYDzBXzARNJqdJZ9KR2s7Y77e60vZJGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743100685; c=relaxed/simple;
	bh=wAw/jcsuR6aATIjwYgCoNWryie/iqH38gOm+yDF5D/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGkOu7Zg+NBcQ+zelQyuHoNcYsMDzMGcjp9yN6wFTiAe18xvorCngi3AC/mh1J8lw5NsQLq49WF9EKZZKUsTXCkd/sDJXceGLdhjIQHasAvAUi0f86XqpM6g+C1bdXYENH+VnOhHJpALduIliA5fktwVvOzMPE4rUP599sZQl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A671C4CEDD;
	Thu, 27 Mar 2025 18:38:04 +0000 (UTC)
Date: Thu, 27 Mar 2025 14:38:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Verify event formats that have "%*p.."
Message-ID: <20250327143853.1cef38af@gandalf.local.home>
In-Reply-To: <856e7f9f-2a7f-4b94-b6b9-c1f7151a1f7b@oracle.com>
References: <20250327114911.2c713511@gandalf.local.home>
	<856e7f9f-2a7f-4b94-b6b9-c1f7151a1f7b@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 11:32:23 -0700
Libo Chen <libo.chen@oracle.com> wrote:

> On 3/27/25 08:49, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > The trace event verifier checks the formats of trace events to make sure
> > that they do not point at memory that is not in the trace event itself or
> > in data that will never be freed. If an event references data that was
> > allocated when the event triggered and that same data is freed before the
> > event is read, then the kernel can crash by reading freed memory.
> > 
> > The verifier runs at boot up (or module load) and scans the print formats
> > of the events and checks their arguments to make sure that dereferenced
> > pointers are safe. If the format uses "%*p.." the verifier will ignore it,
> > and that could be dangerous. Cover this case as well.
> > 
> > Also add to the sample code a use case of "%*pbl".
> > 
> > Link: https://urldefense.com/v3/__https://lore.kernel.org/all/bcba4d76-2c3f-4d11-baf0-02905db953dd@oracle.com/__;!!ACWV5N9M2RV99hQ!LTIVO1_O9wY2hBAnpNF5zcB1EFlC77zOnu4oVcM4DoD77p5ZO_m1LFZdPVJPj4spzye4JntXHOqOVxirPQ$ 
> >   
> Thanks Steve, a minor style issue below, otherwise LGTM. I have tested it, it works. 
> 
> Reviewed-by: Libo Chen <libo.chen@oracle.com>
> Tested-by: Libo Chen <libo.chen@oracle.com>

Thanks for testing.

> >  /*
> >   * Notice here the use of some helper functions. This includes:
> > @@ -370,7 +371,10 @@ TRACE_EVENT(foo_bar,
> >  
> >  		  __get_str(str), __get_str(lstr),
> >  		  __get_bitmask(cpus), __get_cpumask(cpum),
> > -		  __get_str(vstr))
> > +		  __get_str(vstr),
> > +	         __get_dynamic_array_len(cpus),
> > +	         __get_dynamic_array_len(cpus),
> > +	         __get_dynamic_array(cpus))  
> 
> __get_dynamic_array_len() calls don't seem to be aligned with the ones above
> 

Ah yeah. I'll update. Note, this isn't going to go into the kernel until at
least 6.16.

-- Steve
