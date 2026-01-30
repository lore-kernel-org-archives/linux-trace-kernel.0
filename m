Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB481862;
	Fri, 30 Jan 2026 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783004; cv=none; b=Dy6FcHJnF3MSUADTkIWU76cluERG1z7ljzXS/cz6KKNNYooRDdgme5+l2qoHsAuz6LWruYDf3Bx2NNakAEKMlOHX1uuiSQEpvVl8em+02HzH/WAv88GD9iDmryuwrmiIRw0+tnLoTL4A7MNee6NX9z6okXlgpPu3NPx8H7KCaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783004; c=relaxed/simple;
	bh=iuw/aQuXEOB3cXe0GBBFwvB+XOda1xC+QHyRr9IZ4EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faJdzfZlFNWZbu/pTZcgkucQVp7HEkDORCosb0KTdYUki8Nz26tcAArt2EnjJjM+QrAkfZmuRpRl5ytCFCnqDoyOl02ybnlH9i+x61ERNoj+p9aopTmM2HFinuXQfDdRb/cDlYH7H/VQCm23vUKkFFl1c4evSmxQJmuBrxb9pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B0B251B113D;
	Fri, 30 Jan 2026 14:23:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id F088E2002C;
	Fri, 30 Jan 2026 14:23:13 +0000 (UTC)
Date: Fri, 30 Jan 2026 09:23:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] tracing/Documentation: Add a section about
 backup instance
Message-ID: <20260130092329.23ee13f9@gandalf.local.home>
In-Reply-To: <20260130222449.bc25b973597721b6a22e4f6d@kernel.org>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955901173.2786091.7719483008240216705.stgit@mhiramat.tok.corp.google.com>
	<20260129151900.44b6182c@gandalf.local.home>
	<20260130222449.bc25b973597721b6a22e4f6d@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F088E2002C
X-Stat-Signature: qkw13459ak9am7rubmjib5199zyf1sez
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+GSK5ccr81jNKu4c+QBHhO6J42+CWYh2Q=
X-HE-Tag: 1769782993-719458
X-HE-Meta: U2FsdGVkX1+rjZ/D22mGwKnmwy3m+LTFK5e/v9z9x1mVy1bmHDb8ZVmOcfaxmKa1S2SeK3s0PnTvqtrnPHMm3yTMWYP6R0RwNYtdlH8nhloSTEoofoibwK/ZaYZ8GVvSPpqiHxpAZZ85XQzIkghbTpLMhi8cJWVF+uAFmFXYMaQGpPj9pFTgn+qMl0v3XZHjKuRu0Ir7M5xkLMa2ZVDX4q1X+vClAcRXxpLx0Hg7TXtbol8KVyje6JrUoMJHthiRTFvaJ0/mJb8fEC1zNbIFJlB1pckiru/Epj0vhcYp5gTo5CQJV6Db50jU5u8Y7XQVptOKs3nrtCHx9QAQ5dsBKQ6XaQUFB+aA

On Fri, 30 Jan 2026 22:24:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > +
> > > +When the boot up, the previous data in the`boot_map` is copied to "backup"  
> > 
> >   s/When the boot up/On boot up/                   copied to the "backup"  
> 
> Ah, thanks,
> 
> >   
> > > +instance, and the "sched:*" and "irq:*" events for current boot are traced on  
> > 
> >                                                   for the current boot are traced in
> > 
> >   
> > > +"boot_map". Thus user can read the previous boot data from the "backup" instance  
> 
>    ^ the "boot_map".

Nope ;-)  In this case, leaving out the "the" is appropriate. Now you would
need article if it was: the "boot_map" instance

But because you left out "instance" you don't need the article, as
"boot_map" is a name of an object and doesn't need the article when used by
itself.

You wouldn't use an article with:

  The code was written by Steven.

But you would if you said:

  The code was written by the Steven person.

 ;-)

> > 
> > Definite articles are a pain ;-)  

As I said. Definite articles in English are a pain ;)

-- Steve

