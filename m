Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53458F9C0;
	Tue, 24 Feb 2026 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915957; cv=none; b=XTJJ2tPp0L1yYulqw1cQlpgdU3LRNk3DnQfneyC+7rgxKQH1k4IEZbiMp6+Np4grrDdgDMpR+zB815w84rhsii88V2DZM81a4hRY2YglRtcNAKz+hBG4xqdyc04ihKHGuYJR/OcGi92dzKg6SIf5e/CFKHaCsk6TFOVEBN9EqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915957; c=relaxed/simple;
	bh=IC7vDXbVClIqNJfZP90ZdCCSsxipdsKI6L1tESPBzFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j8VdmHJDIxIgb9ieQUn1+vBscVbHPKoocKcq3AJWMfveLbOzOIebSPELca5d1/2HDzmws0MXIf0r22XOb+eG9Y0G/lb08rFx0Ckr7SbN8sQfGimRx0VmGsRNm00D+gzFUdjm3x0bA/4hmEY53+zga3w9wFP9+dE/IVwXje3naQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHcwjEZY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHcwjEZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350B9C116D0;
	Tue, 24 Feb 2026 06:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771915957;
	bh=IC7vDXbVClIqNJfZP90ZdCCSsxipdsKI6L1tESPBzFU=;
	h=From:To:Cc:Subject:Date:From;
	b=SHcwjEZYnFHJvfIa099q9J5nmmnOsdI8Cb1dVZ4vKnZU6hj9NWYOcrALxukOM2iOa
	 CpItCHWeUcsGcOguqTswZmhmg/vPvtLxbZaP9+iGyq83nVAm3n7kk3f0fosNH6Yqa2
	 yf19s7pUMjuN4XGJ/zanQTcnam3fWPcOZ0vApVJ3uBlK60MnpzDagw/xWAXCZ/Hc9Z
	 rT+lqqWeCQbw1+lr1QaeajvbXypeZcCNBK77qVoldgAKgc1oOuD9UhfijIpTu6OsNO
	 9NHEM5QwNGAboa288qBFo4OEQsyqk3r1igbsRMA7nj0WaGwVhc8OWW2bpY19SIa7JT
	 Ag9VULD3Lsr6g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] ring-buffer: Making persistent ring buffers robust
Date: Tue, 24 Feb 2026 15:52:30 +0900
Message-ID:  <177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
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

Here is the 4th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/linux-trace-kernel/177186335195.133407.907308822749006594.stgit@devnote2/

In this version, I fixed to move rb_commit_index() after the
definition of ring_buffer_per_cpu[2/3].

Thank you,

---

Masami Hiramatsu (Google) (3):
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Handle RB_MISSED_* flags on commit field correctly
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer


 kernel/trace/ring_buffer.c |   72 +++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 25 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
