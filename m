Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5627457
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C75C433C8;
	Tue, 31 Oct 2023 22:34:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
	(envelope-from <rostedt@goodmis.org>)
	id 1qxxJT-00EPgI-2v;
	Tue, 31 Oct 2023 18:34:19 -0400
Message-ID: <20231031223326.794680978@goodmis.org>
User-Agent: quilt/0.66
Date: Tue, 31 Oct 2023 18:33:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Ajay Kaher <akaher@vmware.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 0/7] eventfs: Fixing dynamic creation
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

I found an issue with using a union between the rcu list head and
the "is_freed" boolean (word). That is, rcu list is a single link
list where the last element has a NULL pointer. That means, if
the eventfs_inode is the last element (which it likely will be)
it will not have its flag set to is_free.

Instead use a bit from nr_entries to be the is_freed flag.

Changes since v4: https://lore.kernel.org/linux-trace-kernel/20231031193109.018322397@goodmis.org/

- Updated on top of the change to separate out is_freed from the union

- Add another fix to only delete the eventfs_inode after the last
  dentry has cleared its reference (there's more races there without
  doing that)

- Make the top level eventfs directory the same as the rest in
  being removed.

Steven Rostedt (Google) (7):
      eventfs: Remove "is_freed" union with rcu head
      eventfs: Have a free_ei() that just frees the eventfs_inode
      eventfs: Test for ei->is_freed when accessing ei->dentry
      eventfs: Save ownership and mode
      eventfs: Hold eventfs_mutex when calling callback functions
      eventfs: Delete eventfs_inode when the last dentry is freed
      eventfs: Remove special processing of dput() of events directory

----
 fs/tracefs/event_inode.c | 431 +++++++++++++++++++++++++++++++----------------
 fs/tracefs/internal.h    |  27 ++-
 include/linux/tracefs.h  |  43 +++++
 3 files changed, 353 insertions(+), 148 deletions(-)
