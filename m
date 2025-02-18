Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0726FA5D;
	Tue, 18 Feb 2025 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907064; cv=none; b=qZflc1OdTq1LS6hJYIrDA1CfYyA8zru2NFgWVOl2O/dTKjbV7IiWHakUdWBcGewazVfktkt160ApFNB9KoPlznlFsQurvNn0PK1kx/auy13J/eraTDSgeGxqkXC5TgQaqTIomhxj29i2WaozMWrkjM+P3OSxGln4QZZhBFhqv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907064; c=relaxed/simple;
	bh=M1jr8I1XtRu/vwFBpS9PinZubsUd8YkNyv8q5TbJtHc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=GRMA7n0DVK5JX4Q8auWdrG0lgaCgbKvuG+QCNZoJqaE99LH3zsIjr1ew/BI8+lYj6K1g4b8/pRYPQ8gTDLx62rjW+2hZI/mnT5NFrUfTQlTKZrSqciv+lIPfVIZKl4+9w6YjLeHwV6uZQMJvoRU27BxubMQ5xjNNYMIIhyp4rDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA9CC4CEE2;
	Tue, 18 Feb 2025 19:31:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tkTJW-000000049yr-14ax;
	Tue, 18 Feb 2025 14:31:26 -0500
Message-ID: <20250218193033.338823920@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 18 Feb 2025 14:30:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 0/5] ftrace: Fix fprobe with function graph accounting
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Heiko Carstens reported[1] a bug when running the ftrace selftests.
After running them, he noticed that the enabled_functions file had
all functions enabled in it. That means something was registered to
ftrace that shouldn't be.

The issue was with the accounting of the new fprobe logic which was
built on top of the function graph infrastructure. Patch 3 of this
series is the fix for that bug, but while debugging that, 3 other
accounting bugs were discovered.

The bug fix for the reported bug was that fprobes would update its counter
every time a new fprobe was added, even if a new fprobe was attached to a
function that was already attached to another fprobe. But when removing the
fprobe, it would not decrement the counter of an fprobe with a duplicate.
This left the fprobe ops attached to function graph and when it removed the
last probe from the hash, it would create an empty filter hash which would
tell function graph that it wanted to trace all functions. The solution was
to always decrement the counter when a fprobe was removed.

The first of the other bugs was that when enabling a second subops to the
function graph infrastructure, it would add all functions to be called back
and not just the functions for the two subops for tracing. This was due to
the creation of the filter hash for the manager ops that controls the
subops. The first iteration where the manage ops hash was NULL was mistaken
as an "empty hash" which means to trace all functions.

The second bug was when adding a function to the hash where the hash already
had that function, it would allocate and create a new entry for it.  This
leaves duplicates and causes unnecessary overhead and memory wastage.

The third bug was when the last fprobe was removed, it would just unregister
from function graph but it did not remove the function from its own ops
hash. When adding a new fprobe, it would not only enable the function for
that new fprobe, but it would also enable the function of the last fprobe
that was removed.

Finally, a test was added to check and fail if any of the bugs were
introduced, with the exception of the duplicate hash entries, as that
was more of a memory waste and not something visible by user space.

[1] https://lore.kernel.org/all/20250217114918.10397-A-hca@linux.ibm.com/

Steven Rostedt (5):
      ftrace: Fix accounting of adding subops to a manager ops
      ftrace: Do not add duplicate entries in subops manager ops
      fprobe: Fix accounting of when to unregister from function graph
      fprobe: Always unregister fgraph function from ops
      selftests/ftrace: Update fprobe test to check enabled_functions file

----
 kernel/trace/fprobe.c                              |  8 ++--
 kernel/trace/ftrace.c                              | 33 +++++++++----
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    | 54 ++++++++++++++++++++++
 3 files changed, 81 insertions(+), 14 deletions(-)
