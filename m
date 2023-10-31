Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644A22318
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529B8C433C7;
	Tue, 31 Oct 2023 19:34:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
	(envelope-from <rostedt@goodmis.org>)
	id 1qxuVQ-00EK7o-0L;
	Tue, 31 Oct 2023 15:34:28 -0400
Message-ID: <20231031193109.018322397@goodmis.org>
User-Agent: quilt/0.66
Date: Tue, 31 Oct 2023 15:31:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/3] eventfs: Fixing dynamic creation
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

This is really just putting together two eventfs patches that were
stepping on each other in conflicts. I decided to rip out the free_ei()
part into its own patch (as that was what was confliciting.

This series is just a combination of:

  https://lore.kernel.org/linux-trace-kernel/20231031111325.50087cd8@gandalf.local.home/

and

 https://lore.kernel.org/linux-trace-kernel/20231031113627.2edfa83f@gandalf.local.home/

With the stripped out free_ei() patch.

Steven Rostedt (Google) (3):
      eventfs: Have a free_ei() that just frees the eventfs_inode
      eventfs: Test for ei->is_freed when accessing ei->dentry
      eventfs: Save ownership and mode

----
 fs/tracefs/event_inode.c | 217 +++++++++++++++++++++++++++++++++++++++++------
 fs/tracefs/internal.h    |  19 ++++-
 2 files changed, 208 insertions(+), 28 deletions(-)
