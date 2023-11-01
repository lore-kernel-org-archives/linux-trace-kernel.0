Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9211CAA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20062C433C7;
	Wed,  1 Nov 2023 17:26:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
	(envelope-from <rostedt@goodmis.org>)
	id 1qyEzR-00EZrW-04;
	Wed, 01 Nov 2023 13:26:49 -0400
Message-ID: <20231101172541.971928390@goodmis.org>
User-Agent: quilt/0.66
Date: Wed, 01 Nov 2023 13:25:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 0/8] eventfs: Fixing dynamic creation
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Changes since v5: https://lore.kernel.org/all/20231031223326.794680978@goodmis.org/

This was originally based on:

  [PATCH] eventfs: Process deletion of dentry more thoroughly
  https://lore.kernel.org/linux-trace-kernel/20231031144703.71eef3a0@gandalf.local.home/

But Al Viro asked why I do not use use simple_recursive_removal()?
Which at first I thought I could not, but after playing with it
more I realized I could (with a little addition of dget()'s to
balance the dput()s). This simplifies the code. But to do this, it
really needs to be done *after* these changes. Hence, I moved that
patch to after this series and to handle this rebase, I'm reposting
all the patches and including the above mentioned patch at the end
and renamed to:

  eventfs: Use simple_recursive_removal() to clean up dentries

I hope this is the last series, as this *is* for this merge window!

Steven Rostedt (Google) (8):
      eventfs: Remove "is_freed" union with rcu head
      eventfs: Have a free_ei() that just frees the eventfs_inode
      eventfs: Test for ei->is_freed when accessing ei->dentry
      eventfs: Save ownership and mode
      eventfs: Hold eventfs_mutex when calling callback functions
      eventfs: Delete eventfs_inode when the last dentry is freed
      eventfs: Remove special processing of dput() of events directory
      eventfs: Use simple_recursive_removal() to clean up dentries

----
 fs/tracefs/event_inode.c | 420 ++++++++++++++++++++++++++++++++---------------
 fs/tracefs/internal.h    |  29 +++-
 include/linux/tracefs.h  |  43 +++++
 3 files changed, 357 insertions(+), 135 deletions(-)
