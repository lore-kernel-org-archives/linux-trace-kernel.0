Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E562246783;
	Thu,  9 Apr 2026 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730952; cv=none; b=soVm1OlTamxVXHS18t3ZzTUa3SKXEnvnSchKZ4toGMYKn5VRS5FlvMELBNcwFsYW8m4HWUgDPP65fe03WTJD6V6/ulp1NEZSLwOg8h6/yNF+dcMLVtOh6D0E41DgrLN7/na7gWZd1xxHPEfn3zqB2Mh6WDThZIeuX7ss1dOzHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730952; c=relaxed/simple;
	bh=0fxDCd1XxybLS2JKmQ1NAmTb6pz9qkXLQAWvhYmdZEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sFJtN5ap0eUOpg/+bhD15/3PLZccpSMmLQHHTxhZmTsvy8DdhZKMO4WXwVJIVHasYShqD9mEsK5zSFk7fp62lisnPef2d4EOvWX0Jz05nmyyBguNHhNU6oh71qsNh3Va9Zs3icg9KGDD1ti8OLuJCzA794BXm7AzYp0qprfIUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZmHkmC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZmHkmC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8AFC4CEF7;
	Thu,  9 Apr 2026 10:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775730951;
	bh=0fxDCd1XxybLS2JKmQ1NAmTb6pz9qkXLQAWvhYmdZEg=;
	h=From:To:Cc:Subject:Date:From;
	b=mZmHkmC55bQ8U5uLr/HWbJyDd7kpHYqGh0+ZdDEhOU14osO+/IaqlVsURhxYBzLsU
	 DlcVM7yYEQusrMwrr5zV4DMV/w0kUGH0Ol9/7EYC40uXwuVeOyHkdotwljsVSEhydA
	 FA5MrJZUCV+r5L00kTgDIJ/tWcIq+nM+ZpSl6QLIPLOAp6SOJdPab73Tr+/cfdWhUU
	 8cKWg6qG0t2+v4meFEz+QZT5UYaK25gVmdCtEcACOgM97KFQrqkxKvISRdomlVlDFK
	 6k4vg1tK4m3igaBvBd0cTOIoPyhX8DxiU1Lk1U1MaoRJZAp1QtvOiWmnmjY9Fqi0oG
	 U1Fcw7KacUeVg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tracing/fprobe: Fix fprobe_ip_table related bugs
Date: Thu,  9 Apr 2026 19:35:48 +0900
Message-ID:  <177573094819.3666478.11900825120958856397.stgit@mhiramat.tok.corp.google.com>
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

Here are patches to fix bugs in fprobe.

The previous version is here.

https://lore.kernel.org/all/177555745233.1441308.6535024692186959381.stgit@mhiramat.tok.corp.google.com/

In this version, I added another bug in module callback
which calls kcalloc() in rcu_read_lock() section[1/2] which
is reported by Sashiko[1].

[1] https://sashiko.dev/#/patchset/177555745233.1441308.6535024692186959381.stgit%40mhiramat.tok.corp.google.com

Thank you!

---

Masami Hiramatsu (Google) (2):
      tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
      tracing/fprobe: Check the same type fprobe on table as the unregistered one


 kernel/trace/fprobe.c |  122 +++++++++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 44 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
