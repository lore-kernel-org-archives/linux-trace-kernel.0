Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A2143751;
	Tue,  4 Jun 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536534; cv=none; b=SuVQq2o5ucM3Dc636Buykdju1JkBFlWxXGAYhTnYhFH1ch5a8LMSdKz6eN+ClEiXksqW96G9EaFf6XsE1/quy7DZu5ha/rddHjgTG8Qa5xxQPTjC0Kbfe1RN/eMg4GhQ89nGqcpQ++N6iRG++W3yaL8Oh1qlqJtWRJ3kYtSMWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536534; c=relaxed/simple;
	bh=xCn7OmgsUX4Rqky5+7K3tAsdls0KrNgqlPwatU7slSQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=mJ0nuZFT5WTIwJVUmIrxhaSUl2GmZfIAAp/vmCaZVPqdorsC0ITdgmUxEQED1uP54lpeLvNtFK5byfH11tK1ZkSauHYO7n8UTSYRuXqf84DrdpWyxuDlDSUf6QNFuzRbgXzSFBDNa+JFUnqpiyQ4dTZyA8yPbPXJPEfBpXJAqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D04C3277B;
	Tue,  4 Jun 2024 21:28:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEbiA-00000000bCq-2Eth;
	Tue, 04 Jun 2024 17:28:54 -0400
Message-ID: <20240604212817.384103202@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 17:28:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] ftrace: Clean up and comment code
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


Steven Rostedt (Google) (5):
      ftrace: Rename dup_hash() and comment it
      ftrace: Comment __ftrace_hash_rec_update() and make filter_hash bool
      ftrace: Remove "filter_hash" parameter from ftrace_hash_rec_disable/enable()
      ftrace: Convert "filter_hash" and "inc" to bool in ftrace_hash_rec_update_modify()
      ftrace: Add comments to ftrace_hash_move() and friends

----
 kernel/trace/ftrace.c | 103 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 86 insertions(+), 17 deletions(-)
