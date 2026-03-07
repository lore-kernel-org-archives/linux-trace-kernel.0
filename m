Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633526B764;
	Sat,  7 Mar 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772893584; cv=none; b=ObzuoZ0XdF0t1LR+ykme5K28bNy72nPx0RVXQCOtn41ResXUOJPxBIE0lPLNVOzsJKbUICQJ6fpdmX7RRr4hKNP7+c1codDMY0nYnBsQvkeoTyXPQHSb87DppMK7WfZap2BY4UrIQM1bgd3kxRPWTeGNIAMbU92+yhp9Stg0gpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772893584; c=relaxed/simple;
	bh=M8P1MJE3OssGDg3BtKFShzmB3F3pAvGnCTG3mGYCf60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JqZ14xoOGT5PZWS57jMof0DGcLB4IFqwoOwxHCsi9UOEwfyx2pNx8wGlEoK7nA+8Ru+7CyZj5jwkIB8aV/aKR9siFhoGBicGpwZBevInAC/p1U1FuXRPt2YkXHHKHY+c++oHJv65IcG7YtT9WJUyveG4u3asb6FdxZONC0cgSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8s34AwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8s34AwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6325CC19422;
	Sat,  7 Mar 2026 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772893584;
	bh=M8P1MJE3OssGDg3BtKFShzmB3F3pAvGnCTG3mGYCf60=;
	h=From:To:Cc:Subject:Date:From;
	b=E8s34AwYsjI1B2aiavGlBn5TNeZTGRFJw8C/xW4ILs5VBYIwpH378qrMqC28gVv6x
	 Rl0mWkwyLo4/sjnzU39rIEzpZ8kYNeRPP9J8TXTKu8F6TGcD5euwtoGClkRSemXmV8
	 iYYRUSNHTaSJsyHkUBXaEpLVjdNdCRM8TkUz97d8aZ2In6ajvtHAIm2UVpCtHN6xst
	 vKauwJOrlfwVGxZ1tXuBmZ3u9tfos8U62qLfBtZk/C0xR4F4OU7S/f7hN8OQwK34dy
	 8UiWZdy+ORY3JhlNlUj7VMStnhsYIulC+PR0zHI3Tn/km9YFGG6M4XpCuWoOjIQX0L
	 vHDlSqIpk/4kw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] ring-buffer: Making persistent ring buffers robust
Date: Sat,  7 Mar 2026 23:26:20 +0900
Message-ID: <177289358078.248514.14947007976699929481.stgit@devnote2>
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

Here is the 7th version of improvement patches for making persistent
ring buffers robust to failures. The previous version is here:

https://lore.kernel.org/all/177218401821.1988514.5579163042147205021.stgit@mhiramat.tok.corp.google.com/

In this version, I dropped Handle RB_MISSED_* flags patch and partially
include required change to the last one[2/2], it also removes a redundant
subbuffer data check in per-cpu metadata validation and do NOT mark
RB_MISSED_EVENTS bit on discarded pages.

Thank you,

---

Masami Hiramatsu (Google) (2):
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer


 arch/alpha/include/asm/Kbuild        |    1 
 arch/arc/include/asm/Kbuild          |    1 
 arch/arm/include/asm/Kbuild          |    1 
 arch/arm64/include/asm/ring_buffer.h |   10 ++++
 arch/csky/include/asm/Kbuild         |    1 
 arch/hexagon/include/asm/Kbuild      |    1 
 arch/loongarch/include/asm/Kbuild    |    1 
 arch/m68k/include/asm/Kbuild         |    1 
 arch/microblaze/include/asm/Kbuild   |    1 
 arch/mips/include/asm/Kbuild         |    1 
 arch/nios2/include/asm/Kbuild        |    1 
 arch/openrisc/include/asm/Kbuild     |    1 
 arch/parisc/include/asm/Kbuild       |    1 
 arch/powerpc/include/asm/Kbuild      |    1 
 arch/riscv/include/asm/Kbuild        |    1 
 arch/s390/include/asm/Kbuild         |    1 
 arch/sh/include/asm/Kbuild           |    1 
 arch/sparc/include/asm/Kbuild        |    1 
 arch/um/include/asm/Kbuild           |    1 
 arch/x86/include/asm/Kbuild          |    1 
 arch/xtensa/include/asm/Kbuild       |    1 
 include/asm-generic/ring_buffer.h    |   13 +++++
 kernel/trace/ring_buffer.c           |   85 ++++++++++++++++++++++------------
 23 files changed, 98 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
