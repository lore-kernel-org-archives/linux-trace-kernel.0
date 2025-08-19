Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648079CD;
	Tue, 19 Aug 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643383; cv=none; b=M41aJBQiZsYntuzvkhnmqUmWIb/F3nMoRMWyaKgmKfT2IXMLHYhkKGpiWV7aO8XuVBGG2MLVoyDYgKEPWf8dAmHrzM7B/9ytqAkqufEMSIZRH1VOoBwniM1QRklNDwyNV4MCeAicqTL7svNyoocTqvvpZofif1Y9g/T66JOyXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643383; c=relaxed/simple;
	bh=YxxQh56XYjuJeZ+LNjVC3VN9AhApCabHJc1Zw/0xoEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pX8F0z3tRg5snM55lihvEHxs/ni6NLL57GcuOzYHRgH/y9iNozxut0ygVxEuzu1/KGpYcWR/S1j7kGiOWHR9B+UEuayn10jmkyRIPrC8HNPgmN/uZPoXSFLraJLluo8ZnPj8pFfke15/fiTTC3i4CfUwnrWof/MD0hm5NdMhmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 125551A0258;
	Tue, 19 Aug 2025 22:42:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 0F88017;
	Tue, 19 Aug 2025 22:42:54 +0000 (UTC)
Date: Tue, 19 Aug 2025 18:42:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
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
Message-ID: <20250819184255.74307764@gandalf.local.home>
In-Reply-To: <20250616161735.26785bf45d765345b89ad0c8@linux-foundation.org>
References: <20250612100313.3b9a8b80@batman.local.home>
	<65bb272d-b2d4-4d2a-9c7f-d3d5d2eba23d@lucifer.local>
	<20250616150942.789c791a@batman.local.home>
	<32c85c56-063a-40ea-b6ea-e49304447ad6@redhat.com>
	<20250616161735.26785bf45d765345b89ad0c8@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: i7oyefsqr63gfx4sqsubj64pjz3cojhk
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0F88017
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18mWXyQu4Tn6IbBk4CIsgvZXl26siHqgvk=
X-HE-Tag: 1755643374-223974
X-HE-Meta: U2FsdGVkX1+XndIv08WfvOQd4OZSE8G4SatZ6QNgHrKoQ9zOhRvDzdKX12BhM8tq/bTPj5QEFZZ1F9RABD0EBaHPj1Nnic3VyWpt4i141OrIyjHebhrDW5+Psoct2mFgNkGvHAwKuOVd9foy60hKP5P51BQo01itiwQ89ELlUE9LTSVPRUikxLHdNvNqR9PStiWct9sWgOcDqre5nwRUUkYoNR/i908naDSVk+TJ4jtFQEBBce1hoaBqAXm2rufGsuwGDKtFyryKpxKHPjnfuk2g0SRDNXDaNgKnz4F+Rm6N/8v3pNNJHYqJW7ZblvXbAlj/n+1lM8h4fCYI3g0y/RP5V3LJCdqTI2roayC7ZP6oUIBYkGOYNVV9V7gUDNE5GTPLRAeGuI69kLFlv0QCKrNsfUVYH7P4chWHYwb2cgkOn8U9ln0Sl8ji+Zc5f9gEa7PXovzU8PjGaRuLTugxVL4moSZORbxUNdXTJd8066w=

On Mon, 16 Jun 2025 16:17:35 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 16 Jun 2025 21:19:18 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > >>> Fixes: 4cc79b3303f22 ("mm/migration: add trace events for base page and HugeTLB migrations")
> > >>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> > >>
> > >> LGTM so:
> > >>
> > >> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>  
> > > 
> > > Thanks.
> > > 
> > > Should I take this or should this go through the mm tree?  
> > 
> > I suspect this can go through your tree. (@Andrew)
> >   
> 
> Sure.

Did this fall through the cracks?

-- Steve
