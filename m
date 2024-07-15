Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541CD188CBA;
	Mon, 15 Jul 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042504; cv=none; b=uMwN0KXDA8cEM6eJavW36lKrdFmD2HYXoPODYEQwY6pNjI+ZYMniiXIT8yybyEbWNy9W5vk32VT29uedrZ/6wGT8gpNMzC4Gqq9ldZzT8whlfZ7xNJcqdPxlN/YjHAQSF3udtSnxEPzbtKJbn/ZaYZ37xyGa2PG97MaAGlPyKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042504; c=relaxed/simple;
	bh=IRk0/vec0R6/LUwHcrjmzx7PwuTA8FNwI/8qVGudhI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMAqh+wdAwpl8t1IQj3U6ItBq/d0h/koFsG3R4Dmsq5qXvDsfhA9RKPlDdNGrRPwRKmHWkh4cRpzEMV0OIEwhmfP81M4SAx7Anr+AkdZAI/5/pXTZDG1TkToinXKaUtgEEKLlLIBoYKiHH1cYgdRVIPgP7UWToEx53Q0WWvGOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W++4PKdL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W++4PKdL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KGSli2k8D5lO4ssOru+T2Av2OcO4/APPe8SHWw2Rq3A=; b=W++4PKdL6juWh+VjK3PU6RZGF3
	330o5A75NocrRoG7ewhRwDfasWb4UF//QYzv8QEzOiER3CvDjPBBYHuTKE+cEzX1u/Kp6cPF8SP4C
	yNg+0VECSbGzZmnY+58hCsYpi9KIeAce46HI6dYE7dSYyXb8RjetQ9enehFmoVg+RYOSAg++rsGP3
	b3f3GxjKOY+efnpTByOfoCW9qFFzoS48OxDsyIGMLOkFz4GQq0IFW1Kk79mYEglHtRO0B5EehOj5F
	sXPgl5dOAKHmivhn5XveDsc3c/qmbMf15NnqgttLOsbXBEEGwWZRuE7fftrLXrrsgLuolnFNS9UUH
	Y+e54Atw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTJlv-00000001mQX-2j7B;
	Mon, 15 Jul 2024 11:21:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 437A23003FF; Mon, 15 Jul 2024 13:21:35 +0200 (CEST)
Date: Mon, 15 Jul 2024 13:21:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH v2 03/11] rbtree: Provide rb_find_rcu() /
 rb_find_add_rcu()
Message-ID: <20240715112135.GC14400@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <20240711110400.529465037@infradead.org>
 <CAEf4BzZLW+Dez6-WOe1jtCEjC8n6vUqcewWAYViquT4Cc6AA0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZLW+Dez6-WOe1jtCEjC8n6vUqcewWAYViquT4Cc6AA0Q@mail.gmail.com>

On Fri, Jul 12, 2024 at 01:23:43PM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 11, 2024 at 4:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Much like latch_tree, add two RCU methods for the regular RB-tree,
> > which can be used in conjunction with a seqcount to provide lockless
> > lookups.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  include/linux/rbtree.h |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > --- a/include/linux/rbtree.h
> > +++ b/include/linux/rbtree.h
> > @@ -245,6 +245,42 @@ rb_find_add(struct rb_node *node, struct
> >  }
> >
> >  /**
> > + * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
> > + * @node: node to look-for / insert
> > + * @tree: tree to search / modify
> > + * @cmp: operator defining the node order
> > + *
> > + * Adds a Store-Release for link_node.
> > + *
> > + * Returns the rb_node matching @node, or NULL when no match is found and @node
> > + * is inserted.
> > + */
> > +static __always_inline struct rb_node *
> > +rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
> > +               int (*cmp)(struct rb_node *, const struct rb_node *))
> 
> I don't get the point of the RCU version of rb_find_add as RCU itself
> doesn't provide enough protection for modification of the tree, right?
> So in uprobes code you do rb_find_add_rcu() under uprobes_treelock +
> uprobes_seqcount locks. Wouldn't it be just as fine to do plain
> non-RCU rb_find_add() in that case? After all, you do plain rb_erase
> under the same set of locks.
> 
> So what's the point of this one?

The store-release when adding it to the tree. Without that it becomes
possible to find the entry while the entry itself is incomplete.

Eg. something like:

 entry.foo = A
 rb_find_add(&entry->node, &my_tree, my_cmp);

vs

 rcu_read_lock();
 entry = rb_find_rcu(...);
 assert(entry->foo == A);

might fail. Because there is nothing ordering the foo store and the
rb-node add.


