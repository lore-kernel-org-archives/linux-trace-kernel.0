Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDC36215A;
	Thu, 30 Apr 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777570445; cv=none; b=A80gbMRBT4a3jWeCneAqj4fkg9H6CsD/Hx9w0KDIR8+vtAePgPbttK7zH89cWdcx8Hi8frsYY/vqg+sebnUy0jumPhBTjJcPwx2xFZkseM8sDjgTWa8z57NCHqrwY6XJV6H6ENHiRoQhOkdy6CYkleCoYhswUurdsMYAEq6eCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777570445; c=relaxed/simple;
	bh=hGC7DsWirVwtdbfB2/+kjMuLszjNmuaE73bMqS622Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyqqZ+i2Fj9g/9gmx+FwL+p8cfH2ysuFrpzUNnB64LiJ6UJLkBuNkizsF9tCn1uH9yP0B0Mqd0oEoyFidEqdMHHrwzQyxgf3adzWaIGaDF4QYD6+I7rI18fEQv7DgQPm7gtZzurZbKJ35PJeqPq3cbPsbMXFvluCr2JRUZ03cqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C085B1C0FAB;
	Thu, 30 Apr 2026 17:33:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id E19932001B;
	Thu, 30 Apr 2026 17:33:43 +0000 (UTC)
Date: Thu, 30 Apr 2026 13:33:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees Cook
 <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>, Sam James
 <sam@gentoo.org>, Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
Message-ID: <20260430133342.65a64f53@gandalf.local.home>
In-Reply-To: <46aa63d3-0ebf-4062-aefb-86cf0f05dea1@linux.ibm.com>
References: <20260429114355.6c712e6a@gandalf.local.home>
	<ade15347-6eca-4204-9f64-9b2eed9e9aec@efficios.com>
	<20260429145512.461e09fe@gandalf.local.home>
	<20260429145815.69dcb1c0@gandalf.local.home>
	<20260429160344.7e5510e9@gandalf.local.home>
	<46aa63d3-0ebf-4062-aefb-86cf0f05dea1@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 56o4nnou1ugzr8m1xcmdbo3uohwge941
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E19932001B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/W6z6LvLTgFpqa1aFJ4SszwW/pIVPNXxs=
X-HE-Tag: 1777570423-743727
X-HE-Meta: U2FsdGVkX1/gdFZWYkOQiQQea8Rb1VLLTz0tuLPSIAUB5pjY8I1u1SYUwyQO/t5AQhDUMyQ4IJu/oNdXMQu1x1PigYZBXEhkURCNfDuTuX1xXIgQ6FJxiprm2xJ0iSDKRH5P97lX3GNWL6f56xLyNs9itKU/LyhKROSptHi2Al3Xs9AqpPwi37I/p4clEi/jWwGUJRTaWWtSyhAXpJtlBpAjVOZHBgSMNBUHrC5G+PSX2n8cIHUubcOPxAgNOEZGKDMlXUrjfVDZxs4PpjZpV7yO/dpBXlWWptC7YfkAyofc6F0BCPzXfY3WJWu+aN19SjpOqjhhWuKORu2dm7j4DBGvl0vkOXtRdd0rBEXPVVfRFmtKhVHuiTW6COrvuvYHBFxwOD+iYIPaDWbqQlIfyfSzSsD5frG+WtRunMGP+DfX071YcES5lw==

On Thu, 30 Apr 2026 18:23:19 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> On 4/29/2026 10:03 PM, Steven Rostedt wrote:
> > On Wed, 29 Apr 2026 14:58:15 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> >>> If the main executable doesn't have a sframe section, I don't see why this
> >>> shouldn't be allowed to add one.    
> >>
> >> The address is added via mtree_insert_range() which states it will return
> >> -EEXISTS if the range is occupied.  
> > 
> > I confirmed this. I changed the test program to load its own sframe section
> > again, and it errors out with -EEXISTS.  
> 
> Should an executable be allowed to remove its main executable sframe
> section?  Currently the kernel takes care of registering/unregistering
> that.

Why not? It has access to the memory. It could simply corrupt it too.

-- Steve
