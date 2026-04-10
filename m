Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81143E0229;
	Fri, 10 Apr 2026 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841094; cv=none; b=cT23eGi5ZGLFoNE5Z8NCXBlRSzdjYl3CgyfRqCnRg9dlYDbJR3R4mUReyuIkWj5Y/kfsLWQTZKID3Go/P/I9Ae2MF2AWYmrrqcl7g/3OenQFOOy8Z4oKIgkCGe8WiggLRhuLUKQ1F+o4ex7K62p0460AgLXaZY4Rs71K5xm1H4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841094; c=relaxed/simple;
	bh=lBEM8P+ejxxe1A1d15WFdE5LbRIxGKuI9vPerw29dG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QDlLz3+iGwRY4qUaQqXujtCEBU59c8pkmng5ir7yI6UCimv8uGVe48/4hl/29FCVLjCWx5zxLeOZMydkY1h+kOYAWTGHGDZSl2jw/m6kRknXD052gRlXedTyzJpuR7EfBdUVtFCVfhvwutjycriE+iBGX4UHAIUubK2Z6QzVJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgm9cvSU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgm9cvSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE75C19421;
	Fri, 10 Apr 2026 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775841093;
	bh=lBEM8P+ejxxe1A1d15WFdE5LbRIxGKuI9vPerw29dG0=;
	h=From:To:Cc:Subject:Date:From;
	b=fgm9cvSUuBXLAHP1JahxHlx30Y0vdxma8O5Mf5HOuweYIav9QM8SWy+0zJJPxm21N
	 ogaZHmDUC0AO7cAxmGS9A2Se5FACBkTnNoDqbgELfrc9VUgdVHsGNIDKxE1vku0Bv9
	 1oc4BDaoScBmK6aayHR8RRJmRSPSEvJqyqhk+7T0L/AKQUlnGyT6uX3h/Ea5POiogp
	 c4Des2akwVO3IyvnR/xGAYLIPDmQ50EYBHeYB/4Z4IyJUEdg9dD3aVanNC6cSuLJFO
	 p2uOg5HOYwKpgd/VWTTwN37OhEB4C0aj/c3VJRuHBshxoDgr2a4WkiBONtC+MxNlgM
	 brW/wMi9D9i4g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] tracing/fprobe: Fix fprobe_ip_table related bugs
Date: Sat, 11 Apr 2026 02:11:29 +0900
Message-ID: <177584108931.388483.11311214679686745474.stgit@devnote2>
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

Here are patches to fix bugs in fprobe.

The previous version is here.

https://lore.kernel.org/all/177581370903.617881.3002655215679528157.stgit@mhiramat.tok.corp.google.com/

In this version, I fixed some issues on the previous version.

Patch 1/3 updates:
      - Remove short-cut case because we always need to upadte ftrace_ops.
      - Use guard(mutex) in register_fprobe_ips() to unlock it correctly.
      - Remove redundant !ret check in register_fprobe_ips().
      - Do not set hlist_array->size in failure case, instead,
        hlist_array->array[i].fp is set only when insertion is succeeded.
Patch 2/3 updates:
      - fix a build error typo in case of CONFIG_DYNAMIC_FTRACE=n.

Thank you!


---

Masami Hiramatsu (Google) (3):
      tracing/fprobe: Remove fprobe from hash in failure path
      tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
      tracing/fprobe: Check the same type fprobe on table as the unregistered one


 kernel/trace/fprobe.c |  236 ++++++++++++++++++++++++++++---------------------
 1 file changed, 135 insertions(+), 101 deletions(-)

--
Signature
