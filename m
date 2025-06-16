Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA2224220;
	Mon, 16 Jun 2025 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750115856; cv=none; b=pxV2jmtvI4+Gi+J15eEHQlQ98s7yYfQa2V4EGA5xwN1OTWhIXpnM9Ig+3yTUGA0d9bCxCEikCp/3+y7XhObju4SGXwodANZ5cOWaXcUogjUM0Hp87kS/7ni+HbXCEQDEMKdAOQcfEVv4kMWS08X80My7NhEK1pTTut45/ioprkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750115856; c=relaxed/simple;
	bh=pXipBkzqPpWFfLYGxvff5bCpfr/MseDQEAxz0VdKj20=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ddN3c16GHIG7OCCO4wtlD5BO7j39yXNpkHk5QgBSFu4eM4OT0K0EQLGrhQmBl8JQcqv6UAjtsGFOPh9OfVXZIE1TNtjxMLXcUsko7Jgf1HVrvwl8vLMO53Qi8wmrIPmbvv8T5PgDTdGjMmb7swC9ztvLDmCkKpO9rNs9hpW8MEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gWTaREBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gWTaREBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D22C4CEEA;
	Mon, 16 Jun 2025 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750115856;
	bh=pXipBkzqPpWFfLYGxvff5bCpfr/MseDQEAxz0VdKj20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gWTaREBvDqaqK+694z40cmWUuro7uBYzjnFRdB8/5NPX8zTu2yMjmUB2fJgXd3MAT
	 zi/WdVsU69wXqEMblZ8wEhGN1ujQqhDSwIVd6xaS5CuShCRv0kbgtBzj2i0daMCeag
	 64c2FE2lxQ5YkB7jXrKwK8tgaVrdLEk+rcp4CzNg=
Date: Mon, 16 Jun 2025 16:17:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, LKML <linux-kernel@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org,
 x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] mm, x86/mm: Move creating the tlb_flush event back to
 x86 code
Message-Id: <20250616161735.26785bf45d765345b89ad0c8@linux-foundation.org>
In-Reply-To: <32c85c56-063a-40ea-b6ea-e49304447ad6@redhat.com>
References: <20250612100313.3b9a8b80@batman.local.home>
	<65bb272d-b2d4-4d2a-9c7f-d3d5d2eba23d@lucifer.local>
	<20250616150942.789c791a@batman.local.home>
	<32c85c56-063a-40ea-b6ea-e49304447ad6@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 21:19:18 +0200 David Hildenbrand <david@redhat.com> wrote:

> >>> Fixes: 4cc79b3303f22 ("mm/migration: add trace events for base page and HugeTLB migrations")
> >>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >>
> >> LGTM so:
> >>
> >> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > 
> > Thanks.
> > 
> > Should I take this or should this go through the mm tree?
> 
> I suspect this can go through your tree. (@Andrew)
> 

Sure.
