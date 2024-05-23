Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DB2F875;
	Thu, 23 May 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716441295; cv=none; b=c32QJf40GPAEQmSGrQuWl1xjXnSF6kgGDFhP0SyCuItQPM0IHGTut2OyM7D00ouhmQ5YL33K2vNiEofbjW2spsvmMQKvZhjt7m3qq29vQhXqk/xD4ySMfS4leDALMCC+uYXb4Dfu7aTU72miCoHGAXJ2Nk8CNbk8oHQyYlsnDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716441295; c=relaxed/simple;
	bh=QHsyMPGkiEt4JyjW3qJz1Bd7mWj9q+chBqsyVWHrXk0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Cfur6q5dQKTYLXlPywP13F+9rrBOfIUYvcEIHK3okdBJtBE4sS1kLVBZ8vJgZPwezPp2GXvZnqsX4o2XcTb9R3NSmQNYndV6tEmYJLS8eds5m8yTmwA2wokJCAuoZ6ImbFUCxWYQZLx2Int/TXwza6PmrT5TqpH1E//3VvU5K1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9EAC2BD10;
	Thu, 23 May 2024 05:14:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sA0nj-00000006W5B-1hLi;
	Thu, 23 May 2024 01:15:39 -0400
Message-ID: <20240523051425.335105631@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 01:14:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 0/4] tracefs/eventfs: Fix failed second run of test_ownership
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


The test_ownership test of the kselftests was failing again.
That's because the original fix was incorrect and a fix to
a race condition showed how the original fix was broken.

Instead of using tracefs_inodes to find the eventfs_inode that
needs to be reset on remount, use the "events" directory descriptor
to descend into its files and directories to catch all changes.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240522124504.28982867@gandalf.local.home

 - Added other fixes underneath and rebased it on:
   https://lore.kernel.org/lkml/20240522164320.469785149@goodmis.org/

 - The real fix is to not use the tracefs_inodes to find the eventfs_inodes
   that need to be cleared on remount. Instead, the events descriptor
   needs to be used to descend its directories and files to update
   their attributes

 - The d_iput callback logic was misplaced. It should be done in the
   drop_inode callback.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
eventfs/urgent

Head SHA1: 41b7db11bcac4638fa489c58d35e7d2146b665ab


Steven Rostedt (Google) (4):
      eventfs: Keep the directories from having the same inode number as files
      tracefs: Update inode permissions on remount
      eventfs: Update all the eventfs_inodes from the events descriptor
      tracefs: Clear EVENT_INODE flag in tracefs_drop_inode()

----
 fs/tracefs/event_inode.c | 57 +++++++++++++++++++++++++++++++++++++-----------
 fs/tracefs/inode.c       | 48 ++++++++++++++++++++++++----------------
 2 files changed, 73 insertions(+), 32 deletions(-)
