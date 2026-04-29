Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA641B376;
	Wed, 29 Apr 2026 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489092; cv=none; b=iowN5bGjGP7vChVGDw/h8Wd6NQNtRPRYM5ChGDRRMH7RS5UMQNYP51s5X8aico+soeZVMbziTAgZY1MeCm5yHsKvtMsBZmtKHZl2rL25XRCAJZsTLrwSJI2moc/2CWmEuhZT/UHOhrcRjVjDJm5msYG3bVCXYcJIBQKEH8UDvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489092; c=relaxed/simple;
	bh=EXYSq3eb/M9eGCH9xkydk9hYRIIugYYEGIMDoKuGMek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGTVwkcFIsAcnD7JDUXoHhkTMY+eQNfM+zT2Jw4AF42o8l5eSq1S8qzHY7RBcyielJ6yCFFYtSEkaFmh3buwIMbvZ/vvAPZiPSpsGszpBki2/4gmto21M5LPl9eAyXgo3dDRbxYHrT4W94N+rLPohesKUVJ2o3F06st1uy/2MhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 236ED1C0622;
	Wed, 29 Apr 2026 18:58:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 595FE2002D;
	Wed, 29 Apr 2026 18:57:58 +0000 (UTC)
Date: Wed, 29 Apr 2026 14:58:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, Carlos
 O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
Message-ID: <20260429145815.69dcb1c0@gandalf.local.home>
In-Reply-To: <20260429145512.461e09fe@gandalf.local.home>
References: <20260429114355.6c712e6a@gandalf.local.home>
	<ade15347-6eca-4204-9f64-9b2eed9e9aec@efficios.com>
	<20260429145512.461e09fe@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kfqaa388bws9dkwpgzb69bxjr1i8y4zt
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 595FE2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+CDL54GLX4jsqANF76IoHpHRuRwRQ0SOw=
X-HE-Tag: 1777489078-919524
X-HE-Meta: U2FsdGVkX19mu+R92NgDc6fAQlTPpbkSINSlCOL43j0YXdgroAC9cMdaHVi5iB5dvw9Um4q8TWNgohALdJciE5myYwayTJWBcz1qjwavhIZEbzvHmmjplTv1NbuZONMTBab92kpGLlv2h9r2256scIyNh8JgAELd1GjQ2YHd82JuQ+eR5lUwyvkvGrg3dwwyFOBsmKHDLTB5iiSxkPh69k2T37JxLaQZHp/KFIfjhfuwUqqMVvsYN/8lUgudOwwNCQM8JDxm5FM3WZFwXPDme3MgIVl/cIMNsVNSHTfXRajIgCo/abLpPR4msPD57i50Bbp+Vy4Q4mWOSqcVMOpWXJTu31EGEr2TU48+5/ip5G8ne997WEYhLg==

On Wed, 29 Apr 2026 14:55:12 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> > > + *
> > > + * This system call is used by dynamic library utilities to inform the kernel    
> > 
> > Out of curiosity: what would happen if the application chooses to invoke
> > this system call to register sframe for the main executable ? Should it be
> > allowed ?  
> 
> I haven't tried, and should look at the code. Ideally, no two sframes
> sections should cover the same code. I think it should error out if it does.
> 
> If the main executable doesn't have a sframe section, I don't see why this
> shouldn't be allowed to add one.

The address is added via mtree_insert_range() which states it will return
-EEXISTS if the range is occupied.

-- Steve
