Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D991F7060;
	Tue, 11 Feb 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285218; cv=none; b=pgDIXpcgXCm9AggN+mQgTNxiNsnx2BWQAYTwfa8qWnXPFz8HUKTRRGL64wvD/yJXDhXPKO3Zks54Y9pewHcon83rh+oGnuveYGaZGO085EWI5IdAYn7t+1aRuuwqeafyYlemmY3jsXwS7HpDb1pzq4szISO8Zq0g9ABYSZLHayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285218; c=relaxed/simple;
	bh=ABys2u+6elGmb4VHA0VAO3br8ClqlrotE6UcadWA3Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KRnRynq6HGrVjFVa5yXdJrqyNQQyNZz+H7sSF6MdcBX5RovenRJ8ychjfGE2/+/m+coXNFZunz2OQWW304GRPG347TmYiv1ktJq3uhqcOhmaA+RqHQfbfXXkk0nCBf49INa/m5/3nPXu/YX/2xrLJTR0ZxAx2E1hzR+l7WF8j2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSCGMAyx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSCGMAyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD16C4CEDD;
	Tue, 11 Feb 2025 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739285218;
	bh=ABys2u+6elGmb4VHA0VAO3br8ClqlrotE6UcadWA3Wo=;
	h=From:To:Cc:Subject:Date:From;
	b=pSCGMAyxehvIu1im+7uq0DqDHk2fMbT3TOfRGIsi29+te7B85DiIM6jg3WnppITpp
	 LCn5KaIj+Ti8OuVD/4Qu4Q3l8+GPLQheYyGCMniXNKPidqEHOp1R5n4t5PmEUmoTBA
	 HCRD08GGGqhy0UUXCuTGlA99XO0Vqbcz/X75we++zC4QNmiOsWCBSpUvGfqJ1LGi9X
	 83NZkDgTHEcx1TJMWl0ag7b5Q4R7DkhDwvGTKPH2eKh4KyQrk2bOK+HqIRDEdXSBR1
	 VBZxGCZBUv7d3Kjn6UqRem9iUSq6O2nbNHbwHcZ24pnkewa+sw2FrJUi8cwv58nLkk
	 bhli2VMCs/XpA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/2] tracing: Make persistent ring buffer freeable
Date: Tue, 11 Feb 2025 23:46:54 +0900
Message-ID: <173928521419.906035.17750338150436695675.stgit@devnote2>
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

Here is a pair of patches for making the persistent ring buffer
freeable. These were splitted from another series for improving
persistent ring buffer [1].

[1] https://lore.kernel.org/all/173920222697.826592.3726270716809214055.stgit@devnote2/

Anyway, this series allows us to release the memory for the persistent
ring buffer if it is not used anymore without changing kernel cmdline
and reboot. This allows us to enable the persistent ring buffer by
default boot, but disable it according to the user setting after boot
and recycle the memory for the persistent ring buffer.

This is important for the secure system which signs kernel cmdline with
the kernel image, because user can not change the cmdline easily
(usually, it is not possible unless changing kernel image.) Thus, to
use the persistent ring buffer, we need to enable it by default on such
system. However, in that case, some amount of memory is locked by the
persistent ring buffer even if it is not used by user setting.

This feature is useful for such case, because if user setting is
disabled the persistent tracing, we can release the persistent ring
buffer to free page pool.

Thank you,
---

Masami Hiramatsu (Google) (2):
      mm/memblock: Add reserved memory release function
      tracing: Freeable reserved ring buffer


 include/linux/mm.h   |    1 +
 kernel/trace/trace.c |   13 ++++++++-
 kernel/trace/trace.h |    1 +
 mm/memblock.c        |   72 ++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 74 insertions(+), 13 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
