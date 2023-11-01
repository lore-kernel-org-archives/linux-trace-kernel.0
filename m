Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB041841
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269C5C433C8;
	Wed,  1 Nov 2023 04:17:01 +0000 (UTC)
Date: Wed, 1 Nov 2023 00:16:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ajay Kaher
 <akaher@vmware.com>
Subject: Re: [PATCH] eventfs: Process deletion of dentry more thoroughly
Message-ID: <20231101001659.1456b3d4@gandalf.local.home>
In-Reply-To: <20231101022553.GE1957730@ZenIV>
References: <20231031144703.71eef3a0@gandalf.local.home>
	<20231101022553.GE1957730@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Nov 2023 02:25:53 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Tue, Oct 31, 2023 at 02:47:03PM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Looking at how dentry is removed via the tracefs system, I found that
> > eventfs does not do everything that it did under tracefs. The tracefs
> > removal of a dentry calls simple_recursive_removal() that does a lot more
> > than a simple d_invalidate().  
> 
> Umm...  Is there any reason not to use simple_recursive_removal() there?

Hmm, I may be able to (I'm still a newbie with understanding of the vfs).

I did it this way thinking that a dentry may exist in the children but not
at a higher level, but I don't think that can be the case. This creates
dentries and inodes dynamically when they are referenced. The eventfs_inode
maps to each directory (the files of a directory are created from the
information from the eventfs_inode).

My thought process for doing it this way was if a child created a dentry
but the parent did not. But I don't think that can happen, right? So all I
may need to do is to check if the ei->dentry exists for the ei that is
being deleted, and after marking it and all its children as "freed", I can
then call simple_recursive_removal() on the top ei->dentry if it exists, as
that will guarantee to get all the dentries of any of the children that
exist. Right?

-- Steve
