Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476331581
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA214C433C7;
	Mon, 20 Nov 2023 23:51:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
	(envelope-from <rostedt@goodmis.org>)
	id 1r5E3W-00000002PmX-11ek;
	Mon, 20 Nov 2023 18:51:54 -0500
Message-ID: <20231120235105.834774147@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 20 Nov 2023 18:51:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] eventfs: Fixes for v6.7-rc2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

[ Resend to trigger my patchwork updates, and Cc linux-trace-kernel ]

A couple of fixes to eventfs:

- With the usage of simple_recursive_remove() recommended by Al Viro,
  the code should not be calling "d_invalidate()" itself. Doing so
  is causing crashes. The code was calling d_invalidate() on the race
  of trying to look up a file while the parent was being deleted.
  This was detected, and the added dentry was having d_invalidate() called
  on it, but the deletion of the directory was also calling d_invalidate()
  on that same dentry.

- A fix to not free the eventfs_inode (ei) until the last dput() was called
  on its ei->dentry made the ei->dentry exist even after it was marked
  for free by setting the ei->is_freed. But code elsewhere still was
  checking if ei->dentry was NULL if ei->is_freed is set and would
  trigger WARN_ON if that was the case. That's no longer true and there
  should not be any warnings when it is true.

Steven Rostedt (Google) (2):
      eventfs: Remove expectation that ei->is_freed means ei->dentry == NULL
      eventfs: Do not invalidate dentry in create_file/dir_dentry()

----
 fs/tracefs/event_inode.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)
