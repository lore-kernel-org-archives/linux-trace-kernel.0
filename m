Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A173208;
	Mon, 16 Jun 2025 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100990; cv=none; b=jjRU3mAfUc1hw93+NbbaqQGt9qki8l/CEQavwV33jJovwqgasF8sPy3VaN7KfzGBtvOYEfvZzjHHcWd8mcb0VL7MLlvKmZoy1fi2A2KJwSSLuPzpmqnEIeYKOotL4HaUEgbwPKALqDFq5Ey8k3xWXwxcenpM0SzYfgDUWKxcKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100990; c=relaxed/simple;
	bh=wnu3YbsnJ2Yf7tmNIBEoAlxCCOphEunwk6WezsjQHm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlD2anOF8LyWDXlZYS/Nu+iIFMJPmU05L3PHEim/PTs3blqHIMaSrgrxJo1QjBlOPn4xfUil/A34mMUjWZbdTfpGmG5n+8H7Dw4JABN2s77ywkNoPoK/JUUuR00tvmIn+2YUKnevhh1kdYdbcqJwuRhnHPW9nzeFsr/EB/9Jd7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 39EE6160CF3;
	Mon, 16 Jun 2025 19:09:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 591DC19;
	Mon, 16 Jun 2025 19:09:43 +0000 (UTC)
Date: Mon, 16 Jun 2025 15:09:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] mm, x86/mm: Move creating the tlb_flush event back to
 x86 code
Message-ID: <20250616150942.789c791a@batman.local.home>
In-Reply-To: <65bb272d-b2d4-4d2a-9c7f-d3d5d2eba23d@lucifer.local>
References: <20250612100313.3b9a8b80@batman.local.home>
	<65bb272d-b2d4-4d2a-9c7f-d3d5d2eba23d@lucifer.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 591DC19
X-Stat-Signature: jk7hh3u3w6trfftjeq7ppdn8swnose9c
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/VaxDIyC55AXDQ0qv+StA9ti40v4RPQ+o=
X-HE-Tag: 1750100983-599652
X-HE-Meta: U2FsdGVkX181xS3I1pAHbtGnXxJEFYKhBYA9HLRWEFe+IPDj//pnN3epLg/VnNAUhJPdPN7VepftovYDxyeBMCCW/H8QsTICb8Rl0mi4ooz+WGBO+uJ/n4RHQ6eqXUKIaEE+7prrUiBc9GbJEKS6CY4t0uRcgK9GWRpgZfeRoczoSPRbmoDsnAMFvK/OvnSUm9h7iFvfZ3HLHDiDihGwm+j51THM4tHSh176Ub8O8sNX9EV25u27WYnPcULkeO9S1rJC2Q7qKXzyzxcgICHa/+2R+yrvy9sN2/Oec8pk+uQu2BufYq3ExdvbggXGyEn1DviS/ij3u8pGsNn4UiqydTFMI9fZ3ZwCzMJgrmGIjQC5iNEq7VeI9a81htFmDoV9+vSCBtSCJKI+MUp/fQ05JA==

On Thu, 12 Jun 2025 18:24:30 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > Remove the events/tlb.h from mm/rmap.c and add the define
> > CREATE_TRACE_POINTS back in the x86 code.
> >
> > Fixes: 4cc79b3303f22 ("mm/migration: add trace events for base page and HugeTLB migrations")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks.

Should I take this or should this go through the mm tree?

-- Steve
