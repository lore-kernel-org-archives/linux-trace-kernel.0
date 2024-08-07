Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D312CDBF;
	Wed,  7 Aug 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045791; cv=none; b=RiH1eH/7/3Xit2TlUUbTawh+ElkDeb//3qrhvnbpbIDxWsWp16eueWwtbQcVj+ZKidoafhA3OW1APTXBa9S2Gp3s/306q6PR1cZH0k75mlYOyU3ka2ArmHIeS9pmOW5XFNch1Sr1E25E0IBAxds4apHed1VNDe8niBG+dv5vwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045791; c=relaxed/simple;
	bh=zSjQCmlr2o7LzRlv1gR6+tsqoni0n9y0ZEa8DcvWYsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knTOuanliThB7sPafTfKW/BbiAlVYBoz1GhBB6k17FdgOBL7r0yb1yXMgyBBnWF+WdxRy4LFoqDJrCroPKYDF5czGb+gqDZqXlu+10LTduCS6XoAdNgg/qI5AsG+iGO7ogunIX7UU1L0CpdtT/h3rfLYC1Zrmzpt9ft6+zMDhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E7FC32781;
	Wed,  7 Aug 2024 15:49:49 +0000 (UTC)
Date: Wed, 7 Aug 2024 11:49:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mathias Krause <minipli@grsecurity.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Brad Spengler <spender@grsecurity.net>
Subject: Re: [PATCH 2/2] tracefs: Don't overlay 'struct inode'
Message-ID: <20240807114948.6d57af23@gandalf.local.home>
In-Reply-To: <20240807134453.GZ5334@ZenIV>
References: <20240807115143.45927-1-minipli@grsecurity.net>
	<20240807115143.45927-3-minipli@grsecurity.net>
	<20240807093545.4ec51d61@gandalf.local.home>
	<20240807134453.GZ5334@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 14:44:53 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Aug 07, 2024 at 09:35:45AM -0400, Steven Rostedt wrote:
> 
> > Perhaps:
> > 
> > diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> > index f704d8348357..ab6d6c3d835d 100644
> > --- a/fs/tracefs/internal.h
> > +++ b/fs/tracefs/internal.h
> > @@ -10,12 +10,12 @@ enum {
> >  };
> >  
> >  struct tracefs_inode {
> > +	struct inode            vfs_inode;
> > +	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
> >  	union {
> > -		struct inode            vfs_inode;
> > +		struct list_head	list;
> >  		struct rcu_head		rcu;
> >  	};
> > -	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
> > -	struct list_head	list;
> >  	unsigned long           flags;
> >  	void                    *private;
> >  };  
> 
> 	Your current variant gives you an RCU-delayed call of
> tracefs_free_inode(), which schedules an RCU-delayed call of
> tracefs_free_inode_rcu().
> 
> 	Do you really need that double RCU delay to start with?
> Because if you do not, just do that list_del_rcu() in ->destroy_inode()
> (which is called without an RCU delay) and have kmem_cache_free()
> in ->free_inode() (which is called *with* RCU delay started after
> the call of ->destroy_inode()).

Thanks, I didn't know about these.

So I could use destroy_inode() for the removing of the link list, and then
free_inode to free it. Something like:

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1028ab6d9a74..ae2cb2221acd 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -53,15 +53,14 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	return &ti->vfs_inode;
 }
 
-static void tracefs_free_inode_rcu(struct rcu_head *rcu)
+static void tracefs_free_inode(struct inode *inode)
 {
-	struct tracefs_inode *ti;
+	struct tracefs_inode *ti = get_tracefs(inode);
 
-	ti = container_of(rcu, struct tracefs_inode, rcu);
 	kmem_cache_free(tracefs_inode_cachep, ti);
 }
 
-static void tracefs_free_inode(struct inode *inode)
+static void tracefs_destroy_inode(struct inode *inode)
 {
 	struct tracefs_inode *ti = get_tracefs(inode);
 	unsigned long flags;
@@ -69,8 +68,6 @@ static void tracefs_free_inode(struct inode *inode)
 	spin_lock_irqsave(&tracefs_inode_lock, flags);
 	list_del_rcu(&ti->list);
 	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
-
-	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
 }
 
 static ssize_t default_read_file(struct file *file, char __user *buf,
@@ -437,6 +434,7 @@ static int tracefs_drop_inode(struct inode *inode)
 static const struct super_operations tracefs_super_operations = {
 	.alloc_inode    = tracefs_alloc_inode,
 	.free_inode     = tracefs_free_inode,
+	.destroy_inode  = tracefs_destroy_inode,
 	.drop_inode     = tracefs_drop_inode,
 	.statfs		= simple_statfs,
 	.show_options	= tracefs_show_options,
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index f704d8348357..d83c2a25f288 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -10,10 +10,7 @@ enum {
 };
 
 struct tracefs_inode {
-	union {
-		struct inode            vfs_inode;
-		struct rcu_head		rcu;
-	};
+	struct inode            vfs_inode;
 	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
 	struct list_head	list;
 	unsigned long           flags;


I'll run this under some more tests and see if it doesn't crash.

I'll apply the first patch of this series too, and then probably use this
one.

-- Steve
