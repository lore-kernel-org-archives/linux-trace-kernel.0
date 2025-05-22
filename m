Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A872980C3;
	Thu, 22 May 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929279; cv=none; b=szCq6RKsLP1Z/cqwqGxQPxE6v2HL8ttDoGaniS34kyHD9lKAZczJ+U9ITs5poQV+KglW62guLhsuU2bBC5KNYFwVjFhhBKscS+ZEqSyAKxMN1fynKbawGJDaXxbBqCELUsCJbpssPZZ+S8uVtLZ/zEjljkjR72LADfwQEMFQtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929279; c=relaxed/simple;
	bh=VJK92wDoTI+efvlTulMrxFSWMuTS7KaARrxtO3r2uI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1PJNULMD3U20yi7UuSFrQAqHabHWvqJJrR8T7Nd2fJTK4Vh7d0OdveIVtTMwoRsSBa8mL6xj2LUNwsk/f8UF7U9w7Ej0OyVNK5VvEJwDbhGJGYRpJ7LhD8q2Lm1Irmlbcnuht/IuPctWiyRNbXMjDfc9SiQcIWeEt2S1/X/rKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2cnVXW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2cnVXW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F43C4CEE4;
	Thu, 22 May 2025 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929278;
	bh=VJK92wDoTI+efvlTulMrxFSWMuTS7KaARrxtO3r2uI4=;
	h=From:To:Cc:Subject:Date:From;
	b=s2cnVXW5ZkZ7T9oP51bvgsVvMKzn6JKqH7ENv/KWSyVHnfSHrAl2gKpW9NM7S5nbn
	 1r/ZiudDrq1mm0lfF+3lGiECykbjUejxIXZw+v9zBVQDkmlyvVBKeJFMa2QEwKvs4n
	 4iqC/4qP+PsyiWiptZlLFLJgzFa+ceNEwQrOhLrKQrmqA9QK87euu1N8curfShLvjg
	 dNIx5Clk+pPVZWRqhFjkTxwKWcUKq1bUKUYgNyv8iORBTJRMivT1wpj9EoqbW1DhaX
	 KMZQWL9UJS76NWzpctaOIJXCZFI2/UXn58crgp6q7LshIWfPvglPkhgxor+JQAM1rK
	 avqL3fS+btPgw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] tracing: Rewind persistent ring buffer
Date: Fri, 23 May 2025 00:54:35 +0900
Message-ID:  <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
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

Here is the 3rd version of the persistent ring buffer rewinding
patches. I added a related patch for resetting ring buffer when
all buffers are read to this series.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing: ring_buffer: Rewind persistent ring buffer when reboot
      tracing: Reset last-boot buffers when reading out all cpu buffers


 kernel/trace/ring_buffer.c |  104 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.c       |   22 +++++++++
 2 files changed, 122 insertions(+), 4 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
