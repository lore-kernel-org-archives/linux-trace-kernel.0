Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044D3B38B8;
	Tue, 14 Apr 2026 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158084; cv=none; b=uUoJaeVBNPzdVpytzbOUMIQZYiFmeOinv1JOGheOTABdAXOxF2yuwjOnvegb+qQjCSGj+hVgmxBLJzGUPrvr/nb+cpiS0SS/TdLjEBJsnTpywWtII9nuMWnKDx41zIQkEMwSsYWWa14iRy4IEfV4VLXDJbnRGSYV2XHAsAvTpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158084; c=relaxed/simple;
	bh=WOvvNBkakyHFI+CfJ0o4VM9nzfDR+vhvtvvoA3HnBbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VEJJQQz6dcdlUEBh4AYKpb0JSCvOSk+aW6J11UlShtlFKvxZF3gAIfsW0ZQIdUx8wVZPB42d8JG356JPyLvXjyOYCeHrE1Vm2GvMYWJoo+7ueVUF6e6IyjGicvc+bzapdSdSIG03ic+ntyCitVV2vxWNcrCGnxAGrbzzowcWy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIKdqwNq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIKdqwNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBD2C19425;
	Tue, 14 Apr 2026 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158083;
	bh=WOvvNBkakyHFI+CfJ0o4VM9nzfDR+vhvtvvoA3HnBbk=;
	h=From:To:Cc:Subject:Date:From;
	b=KIKdqwNq0dTZpnZoeA00uOZdZx2gsSvhoqimGQbF1s7tBxEthlB3Y3n7s1wJ9cDRO
	 YpIvanFsEtyo45GnUaKEwVQAvUpDQy3Dct3P1KzrcCN9s3z9HoMbtDj2RBops71JFf
	 qMOzRSAdTIqotQJLl1ESPKGYCIxvzXdhaxAUnUOg91zvJI2trR6KNrdlw7/9mtqrGQ
	 dY1Xfia4JyxDvo1O7zN8gk6bXn8WFt0gw1sbeB8cn/PEOv0c6SmqTFhB5eEHob2vx6
	 h1Wgupmg6hk1HG5a32LBFHYw+vL9sHj/2+9g2Zq8uzOwbrr5e1y7FVxVtMQVf/b3f0
	 HO579tLdZgHtg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] tracing/fprobe: Fix fprobe_ip_table related bugs
Date: Tue, 14 Apr 2026 18:14:38 +0900
Message-ID:  <177615807787.1165997.921227352050738693.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
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

Here is the 6th version of fprobe bugfix series.
The previous version is here.

https://lore.kernel.org/all/177606956628.929411.17392736689322577701.stgit@devnote2/

In this version, I added yet another bugfixes for rejecting registered
fprobe correctly [1/5], and unregistering ftrace_ops if it is empty on
module unloading [5/5]. Also, add RCU synchronization for failure path
[2/5] and retry rhashtable walking outside of rhltable_walk_enter/exit
[3/5].

The [5/5] is to handle the module unloading problem I reported
previously [1]. This was handled solely within fprobe to avoid
impacting the live patch.

[1] https://lore.kernel.org/all/20260408110237.08d982fab08356bc8d48af45@kernel.org/

Thank you!

Masami Hiramatsu (Google) (5):
      tracing/fprobe: Reject registration of a registered fprobe before init
      tracing/fprobe: Remove fprobe from hash in failure path
      tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
      tracing/fprobe: Check the same type fprobe on table as the unregistered one
      tracing/fprobe: Fix to unregister ftrace_ops if it is empty on module unloading


 kernel/trace/fprobe.c |  462 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 308 insertions(+), 154 deletions(-)


base-commit: 4346be6577aaa04586167402ae87bbdbe32484a4
--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
