Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995D19995E;
	Tue, 19 Aug 2025 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646040; cv=none; b=HiwFpbyA/tzllSSHRiHJa9XV1vAeKOIHfT0HEeot/A9f3S8aaXGcEopqfFlTl+HXxS1pNJjmv/qKAkQbmwVyBJjiC2pJKVjHzFdYNDoY3P43ZnVcK4h7/kP2l+iLQhP9GtGuo/hx0NC8PuL57WU9NWxuvliC9T/4vND6JoJqy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646040; c=relaxed/simple;
	bh=StK7LLCIi/T78bXL7vsuBOy+1a+q7EGx/sYqS/vJ5aE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nbrs8asfaJwKKSVaTL261vefLlTFTyXQRX2w2kthi/gyLbs3USUtJdJ4WXlrqg/rsk9ZPuCI6RdeakGTXijAFQVIuL2ecSqxNt+xfsyspQNztFRdw8le7gH4tOErnviLZ8ZuTJx+vIM98OqPB+e/rXU4hQdxCtVQ5mlbuDmLb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XMJlcmKk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XMJlcmKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11860C4CEF1;
	Tue, 19 Aug 2025 23:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755646039;
	bh=StK7LLCIi/T78bXL7vsuBOy+1a+q7EGx/sYqS/vJ5aE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XMJlcmKkALFr4TudUnPWezMfy+QVDd6QTbbBn71Cl1POxmJsM2VdaIdRzwRUI4YIr
	 WHhKhSUdcEw2VbEHqGyalF53+CH0XxN2o+yBcfHc4V42Eb+ANrN7HBeY+r2g5hzxwi
	 W0aQL2en+wURxpKd1VLzhZO8UsghxyQ1+horDhmQ=
Date: Tue, 19 Aug 2025 16:27:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, LKML <linux-kernel@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org,
 x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] mm, x86/mm: Move creating the tlb_flush event back to
 x86 code
Message-Id: <20250819162718.4321299ac1e8be7973014fc0@linux-foundation.org>
In-Reply-To: <20250819184255.74307764@gandalf.local.home>
References: <20250612100313.3b9a8b80@batman.local.home>
	<65bb272d-b2d4-4d2a-9c7f-d3d5d2eba23d@lucifer.local>
	<20250616150942.789c791a@batman.local.home>
	<32c85c56-063a-40ea-b6ea-e49304447ad6@redhat.com>
	<20250616161735.26785bf45d765345b89ad0c8@linux-foundation.org>
	<20250819184255.74307764@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 18:42:55 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 16 Jun 2025 16:17:35 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Mon, 16 Jun 2025 21:19:18 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> > > >>> Fixes: 4cc79b3303f22 ("mm/migration: add trace events for base page and HugeTLB migrations")
> > > >>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> > > >>
> > > >> LGTM so:
> > > >>
> > > >> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>  
> > > > 
> > > > Thanks.
> > > > 
> > > > Should I take this or should this go through the mm tree?  
> > > 
> > > I suspect this can go through your tree. (@Andrew)
> > >   
> > 
> > Sure.
> 
> Did this fall through the cracks?

I guess so.

<elides lewd crack about "cracks">

I added it with your revised

Fixes: e73ad5ff2f76 ("mm, x86/mm: Make the batched unmap TLB flush API more gene
ric")
