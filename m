Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C12BDC19
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Jan 2026 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767380293; cv=none; b=pVl3KEE4RrBw1XVu2WkpPXWyATN8bhrowFML0rV+KEEhr7kJFRxZy+QUtXUwy9+0UBR/1MZjE6R9QPPPz3bW837MTug+pBK+zb76vRfXPl4Z50Drja0l0fQTDlwhj549Une8zWM4g4Hf8RUeE91iYGLCViZL6PzX8hzghROpc+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767380293; c=relaxed/simple;
	bh=YX0kcZGxP0VsQIBhN5wsZsokz0bJ9c7VMSdBs67yhsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWZK2CF3aBRaAlhTdMpZ5T9LNEVgzApVCqxwbOxLRDgMXjx/ybjrtbPZ38g4Hw/GnxRGcK0utIr8ChrHTG0v8+2rZlBHD+1Ahecm9umU4hnIbejTAFuErmlnLkNOnTCfhOEmf53pbKKdA4K1ZDTDPnvwuFz1rVU3OVJWJZoL9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1731F8CA4A;
	Fri,  2 Jan 2026 18:58:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 8EDC16000D;
	Fri,  2 Jan 2026 18:58:08 +0000 (UTC)
Date: Fri, 2 Jan 2026 13:58:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: pengdonglin <pengdonglin@xiaomi.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20260102135823.37578148@gandalf.local.home>
In-Reply-To: <20260102135630.0a5d91fb@gandalf.local.home>
References: <aS6kGi0maWBl-MjZ@stanley.mountain>
	<20260102135630.0a5d91fb@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 8EDC16000D
X-Stat-Signature: rhquu9fdpy3e9nysguxuibk78mbptqzh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Ypi35uhYGf+OCbxSMUEvkHRJhS/RqTzA=
X-HE-Tag: 1767380288-366998
X-HE-Meta: U2FsdGVkX1965BJimWZpRYauSx02cqxO2xwABc9k1NE4thY9fOXWNFhx6hWgXz7rt9A0zSsxniDAUz9JrE/j18B/g7nOt4dT5jVGC8+Q5KevbWzfqy8PT/GjjbHTRp3wnBdhKX0rlvDIWQnAqfcm5oYa/3rYvf/RzbSSQBtElC+saQJ5wrsvyI+leGkIYeKpGd08XD3avOVQyZiS5RI86aYwTxvejdndpKcrGVmeI0e6zOhhesPscbW7Nr5wLT6XyLu1BIdfkLYCIGTU9834G+RhxQt58g7QFbtHzB5narlhreSSzX0ifWP5+IafO8NI1YNRgQFvGb0GL0IuS4oaCR4M9b5ArO4sAD2ZRA0FTnwF++RjOetcO3EQ5K+RDsXs

On Fri, 2 Jan 2026 13:56:30 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> >     1031                 /* Save this function pointer to see if the exit matches */
> >     1032                 if (call->depth < FTRACE_RETFUNC_DEPTH &&  
> > --> 1033                     !WARN_ON_ONCE(call->depth < 0))    
> >                                            ^^^^^^^^^^^^^^^
> > The patch changed call->depth from int to unsigned long.  
> 
> Yep, I'm fixing this with:
> 
> 			!WARN_ON_ONCE((long)call->depth < 0))
> 

Thinking about this more. I think it is more robust to change depth to
"long" from "unsigned long" in case there's other locations that expect
depth to be signed.

-- Steve
