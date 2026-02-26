Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0823EAA1;
	Thu, 26 Feb 2026 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113111; cv=none; b=ayOFxNsE6k4/okb0rWpEQTC7npT+evdVqsAhgmkVAxl7FBFJiQfp4iTNvyPB/5BEQfXsgUFr4WXXXOkZD4gDaPD8Zg+U+99h11fgew0RACk+UGuzWzbv/yAI+2WTz8zcNAQSPZt3fnGXiFJsnZ0HdN0VyDkqi6LqIbGAGGPIWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113111; c=relaxed/simple;
	bh=2yO+4++lQgBg+xFFqYXcUQWsny4OgT47MptSG4REwQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OuvP9/MZ/y38C3YO54DyMOfNm22NME6Wq4Ip6QCKuuhT3C4cRneNIdyFQAdoLGjQFYUicvHXSnEyVAQl8+H/1zvZRLcmRIV8EgkbDMsi+MPnEUW2TPTbVRXh/F2dH7Yl803ZkVtSiWS6YVOWb0zJryEFpHwcQPQIYtatB64Gb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoGovJ6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoGovJ6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D6AC116C6;
	Thu, 26 Feb 2026 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113110;
	bh=2yO+4++lQgBg+xFFqYXcUQWsny4OgT47MptSG4REwQc=;
	h=From:To:Cc:Subject:Date:From;
	b=VoGovJ6uK1zhjy+tI4GYZJ4Z+aL7qrgAsorI7BqzMX7NetpHN2+vkUIwEvK9lyVRQ
	 FzwXk6i9SZjTqi3B7rXGwMleYKaVk5z/oi8paBLHx1YpwzHDQ52oZpnBZ6hhL70jId
	 Z7M2r4ZPdSoRE8BJgWwO/BUpeOi+ATldqnNGXQeAf7LMwV2N393zUkgc7Dpptapw+N
	 cuC8y25J01LD+vUWuHXYsQBDF+fMDfE9W3LeN+w1q+9O9MCD/s/EeDRrraG7zQSVml
	 rbH4AvdC/ptMrmKxy1x31W40PibNZgJH2ULy32ES/SqVdrvlYA4mtWhKTXr+FsyaMX
	 b1aSKQyiQxy8A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] ring-buffer: Making persistent ring buffers robust
Date: Thu, 26 Feb 2026 22:38:25 +0900
Message-ID:  <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
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

Here is the 5th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com/

This version fixes multiple issues in the previous version.
 - [1/3] Use appropriate functions for flushing cache and
   stopping event recrod.
 - [2/3] More fixes for masking commit fields and do not move
   unrelated rb_commit_index().
 - [3/3] Show total number of discarded pages instead of
    showing errors on each page.

Thank you,

---

Masami Hiramatsu (Google) (3):
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Handle RB_MISSED_* flags on commit field correctly
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer


 kernel/trace/ring_buffer.c |   73 ++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 24 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
