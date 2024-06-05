Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F13D6D;
	Wed,  5 Jun 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610646; cv=none; b=X9roJ8w4N9CKD11Ku+eDSNUBa0sKbyvmo6tUmkjleI44m0Qrl6/6tHN6w3MSsyOcGqGJuFDIlzGsPYfAVW3zwbX2rRlwkV1pVaFQjtdt3xQfaD9nBriyfxpMGdZAWSPwUQEcLXkDZ6MIeFRQGOz5Ew8hfS9uKOkGPiwtK5ktn08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610646; c=relaxed/simple;
	bh=9yR0XEQQEdf4s5ZmU8jszCt8FZnCPOcIQqw773lKx6c=;
	h=Message-ID:Date:From:To:Cc:Subject; b=fsO1ozGolUiucMLrBFOSxOUC4TxyVjUZ3gXXolGGCJbxKqUghhCZar9AXthZH9kmgeEIkWRPZmTjLGH08gI1OdwQCkvoplaxTgOBbRubbmeY/BP4b1pGxg7I89fOsGYY+mv5tJSH+dRX9BTfrnKxe0ukBixEBHqqD0lU2we73MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AA3C32781;
	Wed,  5 Jun 2024 18:04:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEuzY-00000000hWW-283G;
	Wed, 05 Jun 2024 14:04:08 -0400
Message-ID: <20240605180334.090848865@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 14:03:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/5] ftrace: Clean up and comment code
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

While working on the function_graph multiple users code, I realized
that I was struggling with how the ftrace code worked. Being the
author of such code meant that it wasn't very intuitive. Namely, the
function names were not descriptive enough, or at least, they needed
comments.

This series moves to solve some of that via changing a couple function
names and parameters and adding comments to many of them.

There's more to do, but this at least moves it in the right direction.

Changes since v1: https://lore.kernel.org/all/20240604212817.384103202@goodmis.org/

- While working on v1 and responding to a comment from Mark Rutland about
  the usage of "ftrace_hash" in the __ftrace_hash_rec_update() code,
  I realized that the function does pretty much the same thing if
  it is set or not set (but slightly differently). It turns out that
  it isn't needed and that parameter can be removed, making the code
  simpler.

- Fixed some wording and typos suggested by Mark Rutland.

Steven Rostedt (Google) (5):
      ftrace: Rename dup_hash() and comment it
      ftrace: Remove "ftrace_hash" parameter from __ftrace_hash_rec_update()
      ftrace: Add comments to ftrace_hash_rec_disable/enable()
      ftrace: Convert "inc" parameter to bool in ftrace_hash_rec_update_modify()
      ftrace: Add comments to ftrace_hash_move() and friends

----
 kernel/trace/ftrace.c | 161 +++++++++++++++++++++++++++++---------------------
 1 file changed, 94 insertions(+), 67 deletions(-)
