Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D473009C8;
	Mon, 23 Feb 2026 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863356; cv=none; b=T/tu/hmqMIB6w5KMb3bc+i85Bb1cSW+UQRyrDDZJHbj2DG5IanMC/b9PoOgO3B+SEugKe+RfXa3hJjSO35lqvoXwI7fRENjHQ/NBeTjzgc4/C7NmbOQiA2Me2lW6qFGFnRtf+JFfh5YvcoIg6RR7+1kuN0f4uhnSyMGuNZMndtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863356; c=relaxed/simple;
	bh=NtphzLcSf6iaDQ2GlD1wUZ3P78KgBsGvOprwNs4RP4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gQUkIcMgyoh4xRfc8RWsFQG5eq+b+g1GrRnrohrE6XP/5Kk2bYynUbhPlDvTRtkoPq66NocQ7IXstng5G3bMl/1Wyg8/k+E1dAQBMKOP343LD3XqnulWm2SQfyXY/jjb4QFiAM5DXpfoALNE1a0RgOcmjGUluLCBjep2egc1amU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCRMnd3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCRMnd3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C739BC116C6;
	Mon, 23 Feb 2026 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771863356;
	bh=NtphzLcSf6iaDQ2GlD1wUZ3P78KgBsGvOprwNs4RP4g=;
	h=From:To:Cc:Subject:Date:From;
	b=DCRMnd3XqmMUOhFBZWPbQwUyY1C6uSAoWmcmAV6gCsw3/G48bqnYF28VFqFQaZw9+
	 s1i30RkWoUkM8oq93ujhlOo5kHkd5ssHXRqsEbGvP8znBvf786vCl8ukm5hw5rhS+d
	 akN4CRRXDQcoUygCB5/A80AJz5Lv6F66xGKjeKAVn4k9WQ+bujDZ0ImiDEV5Bh1qsR
	 ynDl0ZYMrjffZpsTCAf8MCeZj74DVSfS97ernP4USoJ8XqA19N5JE205NPsMnTpcri
	 r+gyWsbGqKoQn/svyfEinJ8XAP+qnyBf8RCVEu5MOKX0JMNdL0jMeCb4ZoTneIkDJv
	 +Fm0KLgnToZeQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] ring-buffer: Making persistent ring buffer robust
Date: Tue, 24 Feb 2026 01:15:52 +0900
Message-ID: <177186335195.133407.907308822749006594.stgit@devnote2>
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

Hi,

Here is the 3rd version of improvement patches for making persistent
ring buffers robust to failures. This fixes some issues of persistent
ring buffer on real machines.
The previous version is here:

https://lore.kernel.org/all/177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com/

In this version, I rebased the series on top of trace/fixes
branch (thus the first patch has been merged.)

I updated the description [1/3], used RB_MISSED_EVENTS flag to
indicate the corrupted page [3/3] and I found a new bug on
using rb_data_page::commit as index. So added a new fix [2/3].

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
