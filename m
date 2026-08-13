Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9C49483F;
	Thu, 13 Aug 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637773; cv=none; b=RSoESLVEs5ZvCm3CSD9MYHqE5G4eoZQkXI73uFlAR0skL+0IQtgH40X9iCeZqepWcleH8hps/KwU6tYiuzRRMdSMihN9OVaIxPH55ywuAwSCAcCSCeYhzkV++DyjkpHvrO8seK1RHu01AUv7ya1RQTfEL53+uUaMfxbDrbTUhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637773; c=relaxed/simple;
	bh=pqqmZZ6deRh+BDfJTUV3UZWzWTfjHadmOgnzEcJK+SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=keAbYd+AEQxZ185wXjlTh8e7DyyqATb9kwqMTUgQXnG3Do6Cq1V3BskOoDSs2n2r2atcsJc16aDUAYChg2m6OJrDg3h5vaqnb34xVH8jWXnjGEPPybwULSk0lAFxNkjAB7ofJCI5qBDMSFzb6nBmnyZdes/rGOB0nQX7IEvYkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ2KfbAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ2KfbAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3801F000E9;
	Thu, 13 Aug 2026 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786637767;
	bh=KknxDTLPmSc/DwBYymorFrffLss6qj1EZdZVl4Oq7l4=;
	h=From:To:Cc:Subject:Date;
	b=JZ2KfbAd5MyujUDRZsbCTSNudXpb1vvvI9jlKVfpp9xnoRMyzLxnO0M5s451FlTsC
	 G4G9QMW07ljyfUo9J74SwhOY9+uYk+bmXiZLwf4Y9+zkKEmhYsnaEQbrh3ZnlR/IZn
	 ++Yvybg8b4PK8pKv9NQEfMdT3axBzSnaWR8KVhw4yVhlkIpjgkChDAlqvZu8MD/RUU
	 RmHUGdH1yt4b0Z6dkStuCMZ/+azWNPfw+LgH/4OP0+r6rUmwvbdR/qDWLULjtKbNVu
	 4iwq81Z+4HxZf15/dQQ1m/2/c03eeLbiOmLHdEPWdWB+zX/NK8/X29UK6pyjT80eSf
	 R7Ayp5/HABX8w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: [PATCH 0/1] ring-buffer: Fix sub-buffer order updates and free_page leaks
Date: Fri, 14 Aug 2026 01:16:03 +0900
Message-ID: <178663776361.475864.7685868697103378735.stgit@devnote2>
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

Hi Vincent,

Here is my patch to fix the race and free_page problem.
Let's see what Sashiko says for this.

Thank you,

---
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13

Masami Hiramatsu (Google) (1):
      ring-buffer: Fix race between ring_buffer_subbuf_order_set() and readers


 kernel/trace/ring_buffer.c |   35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
