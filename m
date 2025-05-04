Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764128F58;
	Sun,  4 May 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746375690; cv=none; b=Yz2Q386pvcWdfSUU4cx5dciWnzRzPqL9x7rR1J18LD8ZytrPyQcGYXBUp28s05zmFMMxe/2bmSQ2baSHdxZhvpefwvR2oy+MnDUypfu/N9OgWQGe63SEkCrkpncf3/OeNoU24kNltQjyAxb0cKGI7AfIZRJ4MIYTjr0rMo8Mv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746375690; c=relaxed/simple;
	bh=KbEtVg6e3NcKxt57TJfcdFRXYXBSPk0HDdb207vqtbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoIPVnGv9gBtKZVVwaeYqOQEb3kWxIFfe3WszywnHPPIKJ/A1zSTjiBWQ3IDmTf6z554q9NleKyAkJzm1d232aYd+GVNe2m82swAyWML53lycza5M/qNiqQjIZ9KOYuzpHvcJQKPa76nZV9wJZ7+6PiJuHT8N3K7Ql0zvUh9pJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9F7C4CEE7;
	Sun,  4 May 2025 16:21:28 +0000 (UTC)
Date: Sun, 4 May 2025 12:21:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 08/17] unwind_user/deferred: Add unwind cache
Message-ID: <20250504122131.6ca0d50c@batman.local.home>
In-Reply-To: <aBc1cqWcTJmeqg3X@gmail.com>
References: <20250502164746.178864972@goodmis.org>
	<20250502165008.734340489@goodmis.org>
	<aBc1cqWcTJmeqg3X@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 May 2025 11:37:54 +0200
Ingo Molnar <mingo@kernel.org> wrote:

Hi Ingo,

> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > -struct unwind_task_info {
> > +struct unwind_cache {
> >  	unsigned long		*entries;
> > +	unsigned int		nr_entries;
> > +};
> > +
> > +struct unwind_task_info {
> > +	struct unwind_cache	cache;
> >  };  
> 
> > @@ -19,17 +20,29 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
> >  	if (current->flags & PF_EXITING)
> >  		return -EINVAL;
> >  
> > -       if (!info->entries) {
> > -               info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
> > -                                             GFP_KERNEL);
> > -               if (!info->entries)
> > -		       return -ENOMEM;
> > +	if (!cache->entries) {
> > +		cache->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
> > +					       GFP_KERNEL);
> > +		if (!cache->entries)
> > +			return -ENOMEM;
> > +        }  
> 
> That's just sloppy: why isn't the unwind_cache a pointer to begin with, 
> with the dynamically allocated object containing ::nr_entries?

Basically you want?

struct unwind_task_info {
	struct unwind_cache	*cache;
};

Then have:

struct unwind_cache {
	int			nr_entries;
	unsigned long		entries[];
};

And allocate the unwind_cache to include the size (using the dynamic
structure macro helpers)?

That makes sense to me.

> 
> Also, the code has whitespace damage.
> 
> > +
> > +	trace->entries = cache->entries;
> > +
> > +	if (cache->nr_entries) {
> > +               /*
> > +                * The user stack has already been previously
> > unwound in this
> > +                * entry context.  Skip the unwind and use the
> > cache.
> > +                */
> > +               trace->nr = cache->nr_entries;
> > +               return 0;  
> 
> Whitespace damage here too. Maybe in other patches as well.
> 
> Please don't rush this series without first reviewing it carefully ...

Hmm, For whitespace damage, I usually rely on git show to show me where
whitespace damage is. But if there's no tabs, then it doesn't show. The
whitespace damage came from when I pulled in Josh's work and rebased it
on the latest kernel. There were conflicts which was solved by having
to do some cut and paste from .rej files, and somehow it added spaces
instead of tabs.

Peter caught this is the beginning, and I thought I got all the
locations that had that white space issue. This patch hasn't been
touched much during the various versions.

I'll do a search for spaces to see if there's more in any of the other
patches.

Thanks!

-- Steve

