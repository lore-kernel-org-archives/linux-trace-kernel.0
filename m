Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DC213DBB1;
	Mon, 10 Feb 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202232; cv=none; b=nS3CqNFfj6vdWAT5osUNVN2ijbSrnIBu2x464bLKwbdU+N0DP3R4CwGTfCWofnJpkVW+xWyVQ4XeOuVgrWIdxawagbadfuNBUsOcbwjL8iLXiuyH9dfHccP+ho4KyjPFSoJ3TDUyY17bSnA5dYK0rH3Kjady1a/Q9nTksgThbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202232; c=relaxed/simple;
	bh=xjgCzg14LZVEzK+2FT5mM7D/kwUkrNSzvBKVRM9rv1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pCWlVLQIGsvpm2sh+4OArx2E0H0yD/OwBBNzUkFSqax+mo50/PYFQmtkA7BkL/yjN1lCHPVN6+gWwKeRpODNaNwqztbB/f1mTNmcKd46vCOMvuXEb98m1PjUB8HON/XpwEeomaSgKAUeqLbN2jUUph+yTXtDPKOynuhpA1KKZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ags9qx85; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ags9qx85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03DBC4CED1;
	Mon, 10 Feb 2025 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739202231;
	bh=xjgCzg14LZVEzK+2FT5mM7D/kwUkrNSzvBKVRM9rv1s=;
	h=From:To:Cc:Subject:Date:From;
	b=Ags9qx85VeP6lj16+NnJKJ8Ip+V40x3X8mfotUkuAPcEuQKYSqJYLVNiergps3arl
	 0C5CG3FgfvcGI59qIejAA1UgfIfs7MPxsAzgBD7QK41MXgBVwPvMho3VR/2efqLmDo
	 8ik3fviZououtDGjilZCYS/vYP0dRQ0f02STCP5atmlIKkgdtUab4XoJ731kQuQFBe
	 zFgN5gkjBhQo5qYHfUbggRHxI91QH7VH81XLPrrQDbj7l6kt5Yr1SbXuPTVuYcqlQH
	 zvHAv5UBqKbGG35yDVhUAb/A8Hmu460LeW1U5h65h8c55SoGi6AAeyQ5rR+5XS3N3u
	 aiLSVKYV1pAtQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 0/3] tracing: Improve persistent ring buffer
Date: Tue, 11 Feb 2025 00:43:47 +0900
Message-ID: <173920222697.826592.3726270716809214055.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 2nd version of the patch and additional improvement for ring
buffer on reseved memory. This depends on the series of "ring-buffer/tracing:
Save module information in persistent memory" here;

https://lore.kernel.org/all/20250205225031.799739376@goodmis.org/

In v2, I removed my first 2 patches, and fixes the 3rd patch. It also add
module LRU override feature which replaces the oldest removed module if
the module table is full.

I also added 2 patches to release the memory of persistent ring buffer
if user does not need it anymore. Currently persistent ring buffer has
to be enabled by kernel cmdline, user can not remove it without
changing the cmdline and rebooting. This feature allows user to remove
persistent ring buffer and release the memory without rebooting. Thus
user can set it up by default and remove it if it is not used anymore.

Thank you,
---

Masami Hiramatsu (Google) (3):
      tracing: Show last module text symbols in the stacktrace
      mm/memblock: Add reserved memory release function
      tracing: Freeable reserved ring buffer


 include/linux/mm.h          |    1 
 kernel/trace/trace.c        |  190 ++++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace.h        |    5 +
 kernel/trace/trace_output.c |    3 -
 mm/memblock.c               |   72 ++++++++++++++--
 5 files changed, 244 insertions(+), 27 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
