Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28138134C7
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC28C433C8;
	Wed,  1 Nov 2023 14:55:55 +0000 (UTC)
Date: Wed, 1 Nov 2023 10:55:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ajay Kaher
 <akaher@vmware.com>
Subject: Re: [PATCH] eventfs: Process deletion of dentry more thoroughly
Message-ID: <20231101105554.6cd5a30f@gandalf.local.home>
In-Reply-To: <20231101001659.1456b3d4@gandalf.local.home>
References: <20231031144703.71eef3a0@gandalf.local.home>
	<20231101022553.GE1957730@ZenIV>
	<20231101001659.1456b3d4@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Nov 2023 00:16:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 1 Nov 2023 02:25:53 +0000
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Umm...  Is there any reason not to use simple_recursive_removal() there?  
> 
> Hmm, I may be able to (I'm still a newbie with understanding of the vfs).
> 
> I did it this way thinking that a dentry may exist in the children but not
> at a higher level, but I don't think that can be the case. This creates
> dentries and inodes dynamically when they are referenced. The eventfs_inode
> maps to each directory (the files of a directory are created from the
> information from the eventfs_inode).

OK, as I tried to use the simple_recursive_remove() and I failed miserably!

I think I know why. What happened was the last child would get one extra
"dput" than it needed. That's because dentry's exist without any reference
on them and they don't disappear until a reclaim happens. What I mean is,
when a file is "open()'d" a dentry is created on the fly so that the user
can access the file. When it is "close()'d" the dentry count goes to zero.

Then on memory reclaim, the dentries may be removed. If another open
happens, the dentry is created again, or the one that is still cached can
be reinstated.

It looks like the simple_recursive_remove() expects all dentries to have at
least a 1 when entering, which is not the case here.

But!

Now what I could do is to do a dget() when removing the eventfs_inodes (ei)
on any dentry that is attached to them.

/me goes and tries that...

OK, that actually seems to work. With the assumption that there will never
be dentry without a parent I think I can go this approach.

Thanks!

-- Steve
