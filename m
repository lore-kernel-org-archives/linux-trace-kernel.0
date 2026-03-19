Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0236C5B2;
	Thu, 19 Mar 2026 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911541; cv=none; b=GTWa92rAR7ilm2fjpOwuDjdElV1rlujQe7lBBEw5Zi8tTvA3ShsuW9A6+7Jjjh3fxqZq5n1faVCyjd9GYTF5q4lr7SnGywAqrg60Hz//9ejbJYj08YRRoF+L+Uti/GLM4lj9zhT/AN/UM0bS5rSP7GUx87WdTUP+gNTOawsXv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911541; c=relaxed/simple;
	bh=jRGUPWOttUs6INf4Amu69T0gGubzJnky61ZBka2rRps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAHH8WTeDSWqbNrNTAO0RlwHhn45hTMovEyWXTC+NJ85zrEiIAz4y2sGntXxyBzajPLJ/84ucEZscPDkpF0eekxhsSnNW61+6BkEPS+LoFYO6FFqTH7PE949YNoN9k0PXkK08KDyWnE+7VDlbH+1liHYzdPwJmFzGMKRFeqa5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf2HbWY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf2HbWY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4ACC19424;
	Thu, 19 Mar 2026 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773911541;
	bh=jRGUPWOttUs6INf4Amu69T0gGubzJnky61ZBka2rRps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lf2HbWY+IwV6vLIjxr/XJnBQhjzCgsBDp+1NG4Plb4yGrwsaSoNphG7ms+5NcghNw
	 fvWhBxpvVqZ86mfnECzb9701aXeoUNgghOoNTLQ1EHQYlhdRRldq8/k+KbpzaThWhd
	 wTbceGp3i6Dlf4UUTl6YveYE1FTMa8ASVdZYcYaWBd2vZuF1yDl+/8djTMRuQwrLZz
	 Ap3k/AJF+JHzXjMbxsaqcepan5eJW1cCNO03oZl1X3X5RdiRWUeiztnfUaMN3Z/MTa
	 OeRyrg72FeLdIca2Z6pS+YcxPGWcxQSdeb6m6vj2gXhH4MuSXLa6qkxQ+5cLiUiAzL
	 tsktPi4ox9q6g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v11 1/5] ring-buffer: Fix to update per-subbuf entries of persistent ring buffer
Date: Thu, 19 Mar 2026 18:12:19 +0900
Message-ID:  <177391153882.193994.17158784065013676533.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To:  <177391152793.193994.8986943289250629418.stgit@mhiramat.tok.corp.google.com>
References:  <177391152793.193994.8986943289250629418.stgit@mhiramat.tok.corp.google.com>
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

Since the validation loop in rb_meta_validate_events() updates
the same cpu_buffer->head_page->entries, the other subbuf entries
are not updated.
Fix to use head_page to update the entries field, since it is the
cursor in this loop.

Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 0 files changed

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 96e0d80d492b..d6bebb782efc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2024,7 +2024,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
-		local_set(&cpu_buffer->head_page->entries, ret);
+		local_set(&head_page->entries, ret);
 
 		if (head_page == cpu_buffer->commit_page)
 			break;

