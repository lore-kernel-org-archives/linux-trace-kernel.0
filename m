Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400633C1B6;
	Thu,  3 Sep 2026 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477909; cv=none; b=JbVRACXmXd5V3VNAfvkiEsAtIgzr4W0S8Q345VWSizeP291V7YX8mFARMvPRGWCKu3tcQAQDt0ZX0e2BCa8sbc6XPKJBOmYJSfFvkVKNeSnI2CQ2qt9RhcmIC3ITWVcb94yM1unwQylg6gVEDM1cHo0wxRGHpNm1pBXvzE1op9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477909; c=relaxed/simple;
	bh=6OAuvrdzd2ZNTwj7UpXxxD0LsMcuEQ2k1hWXgR9BA4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NswfCSG0rWHsVPHZKxskTR+kXoOi4LjIi/7jB55wNK5hiA0tZRvk3vE94cnzMqL7tGrzYi0VYwDkLqHXdG9xI6IuSxUj8zHCSac9yeSMiJDBCeMzFB6mMfo3ldTPXN3cBP+8mYZP5GHUstm259+sdsvvdVGoGPS/t3eiXh/ukoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyEjKAxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyEjKAxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9311F000E9;
	Thu,  3 Sep 2026 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788477907;
	bh=C0kPI2M93Ze8THghUXdRhJZCUAdeQJlJKvwixiYVDh8=;
	h=From:To:Cc:Subject:Date;
	b=KyEjKAxCMTDKI8R+55O6pUvBC7piDhYtOnmTukmsLa6g+mojRBc0jQfHimYKpnrSS
	 C2RUlx2PmF83N3i14QKgYvjUyEczKm6YkGHDLAas8rTFoOSiW/vp35pi8/4BegkkXA
	 aXUOdkHrE0w/SWri7/s1lL8tSOZdytrPRL7Y6nrYvzGddSVD9rJlqA8pim9OERLWZ+
	 mZDiXwsaVydrNyigaeez1+eHg9ZhXM3uUookh0ebB7vy1KMiiWCIGqBtWnz5yBzyM6
	 QUtzMq75fiGjM5h1HEGL2utTD+Ii1k5OtPRVj3hyOiXApqGx8yy7aAx24Lbkmxnzjg
	 E8nGolQHttDJA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix to avoid creating trace instances with duplicate names
Date: Fri,  4 Sep 2026 08:25:04 +0900
Message-ID: <178847790399.283263.5313150997200138426.stgit@devnote2>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since commit e645535a954a ("tracing: Add option to use memmapped
memory for trace boot instance") changed trace_array_get_by_name() to
trace_array_create_systems(), enable_instances() does not reuse the
same name instance. Therefore, if an administrator mistakenly specifies
multiple `trace_instance=` options with duplicate names, all are
created but only the first is accessible via tracefs.

Check whether an instance with the same name already exists before
creating a new one, and reject duplicates with a warning.

Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a946e0183fd1..536e71f28d51 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9651,6 +9651,11 @@ __init static void enable_instances(void)
 		if (flag_delim)
 			*flag_delim++ = '\0';
 
+		if (trace_array_find(name)) {
+			pr_warn("Tracing: Instance %s already exists\n", name);
+			continue;
+		}
+
 		if (backup) {
 			if (backup_instance_area(backup, &addr, &size) < 0)
 				continue;

