Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DE20CCFF;
	Tue, 18 Mar 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305149; cv=none; b=NZ2YeZN3OC1sbfQR2mwN2wohNil4aaadlqyXGdQUXUyD68NU555LqIVz5QQwEZcn5OzcJRRPNGyZTt5SAwyhHm9C458ng27GmzYQ1/xHtXf0KNwq7lLKNbSMBmWQuC9pO5Bf4hHKCjELBlQMZvOT1zs/Aa4dYNKS+ESA8g5jqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305149; c=relaxed/simple;
	bh=k0Gp/EPdwLJ4MJjqR1cSdDOKuDvwrrC0kmF/2DPeYKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tB0BT3hCDB7UJa6a56R2hECtHWVqWhCcz1lv5YRRzP2b36A3jgfFunAUM2ERr0MDOwSCVjJ/XUr13iJkvCYoA0CeUtdOjR7EhZ9dbJQ8kwLs/+lSNdlIuaXhfvqvQgsXzpX/TFJSKkVluRKh0aTt99nOijQPO+B4y6ToX75LczQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSLu0Jhh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSLu0Jhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96780C4CEDD;
	Tue, 18 Mar 2025 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742305148;
	bh=k0Gp/EPdwLJ4MJjqR1cSdDOKuDvwrrC0kmF/2DPeYKw=;
	h=From:To:Cc:Subject:Date:From;
	b=bSLu0Jhhpew39olxz+5unmpuDcD5VSlMziQA+0l8PeFWOtSABfhOTureTICJBuFLA
	 WYfPu7LzquF6mik5NbhHhcpGeqwWd3LdIhGa9LWyFull379q4z86gqy/ZcSja1URsC
	 ylpS6znMQ3pzZ4AAmctEXPwUF6M/aThYdEiI+IN5k25TnIzELSAe8I1IoYUWVJ0aOJ
	 ig3Tlk2/PoRpl8QyMsFX0oaQ3xiv5Lq7tgQhWuLZ35mIySybOrSQgha5RH6OIQknus
	 Wu9P7bM+QGHrZNDp+8XJwhWA+nvvVlpWoAfL/00MWHqHIZETb7ofanHLejDO6Sjv9C
	 UfjiC2uNDJIIw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] tracing: Show last boot module symbols
Date: Tue, 18 Mar 2025 22:39:04 +0900
Message-ID:  <174230514441.2909896.16487286892751735867.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
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

Here is v5 of showing last boot module symbols. The previous series
is here[1] and this just update the CONFIG_MODULES=n case patch.

[1] https://lore.kernel.org/all/174188320269.3845006.11920186078507571954.stgit@mhiramat.tok.corp.google.com/

Thanks,


---

Masami Hiramatsu (Google) (2):
      tracing: Fix a compilation error without CONFIG_MODULES
      tracing: Show last module text symbols in the stacktrace


 kernel/trace/trace.c        |  135 +++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h        |    3 +
 kernel/trace/trace_output.c |    4 +
 3 files changed, 135 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
