Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42834D4E9;
	Fri, 11 Sep 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135982; cv=none; b=Oo6JY7MKTvf973JTtkTZbt6ii/dkTCJ72YjkfbeideUoo5xYJA4TtKgTKXaSXUkB1PVcjLy2tYiP0y4VgsmXst4aaDR2DXUIFAtals4xetlDRlVBDO+jdVG1dRcCvHUjOBshTiVhI+pqRB3hH590yx+dGJpA9p4UzWSBGYff+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135982; c=relaxed/simple;
	bh=libLL/W+0AS65TpVHI2A6XNBropOogkKSPF/KGQZCfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQ2keZIjpBGPPgFmIBLzRBA2g2swwFNeYSNI1sh0ocqoBhNx5zv3UyTQ6WXHzrVEzH6G6n/3xZuqPPxY4Vq7TXYld/tLfnCTcflSNuAaOIvWhyvS61o2dt70CjnYE6IeYA/TJD3TygmmnhEVtLQ0Qo00DYmelYOt84c1GxUU/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYLyG5Hu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYLyG5Hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA951F008A2;
	Fri, 11 Sep 2026 14:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135980;
	bh=W5Pvpuyrs9b2x0ytyjXXTSXNpN4mDwGJ5mdHSem6KBA=;
	h=From:To:Cc:Subject:Date;
	b=CYLyG5Huj2oEcgSr4F0aw1RBtXKyHHm8hHJMxOYdk6L/nF+cdgtS6dJIQBvXtzQpA
	 +7Uu6UmfDBDc716gmFW2gHBAkF3a1svZZLmJjixBkpyzNBqX6EzUItA4KFEdC83hsK
	 bbs7iNpkBYmM9GVdbvWp7HMQL0YYjqFhUaJUFkYjqlc7JuVm8hi5HyQqU8MRtIfISF
	 3wE2JjinggXpeVFFT4gxRcoQjGsydqOk5kZ6AaTZoPJ+c0DgOhUbpukZ47+VaZP6ve
	 xE1nTDJ83f4WwjFO9kc1ud1A93vPy/bTUVycgjpfLlLsln86ekVIC9ihp00z4b9xBF
	 LJR5Ej0FFx7Lw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v2 0/4] bootconfig: Reject unexpected data after null character and cleanups
Date: Fri, 11 Sep 2026 23:12:56 +0900
Message-ID: <178913597653.248794.1237187523153227751.stgit@devnote2>
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

Here are v2 patches for bootconfig to rejects unexpected config data after
null character and other cleanups including tools/bootconfig to consolidate
bootconfig initialization with errors, and skipping internal tree sanity
check in kernel.

The previous version is here:

 https://lore.kernel.org/all/178896921555.177508.434402948295885560.stgit@devnote2/

This version removes redundant buffer copy in init_xbc_with_error() [2/4]
and moves BOOTCONFIG_FOOTER_SIZE to include/linux/bootconfig.h[4/4].

Thank you,

---
base-commit: 7812d6dab0698001e50e8c2f901e17da3eb6f429

Masami Hiramatsu (Google) (4):
      bootconfig: Reject unexpected data after null character
      tools/bootconfig: Consolidate xbc_init() to error message wrapper
      bootconfig: Skip internal tree sanity checks in kernel
      bootconfig: Move BOOTCONFIG_FOOTER_SIZE to include/linux/bootconfig.h


 include/linux/bootconfig.h          |    4 +
 init/main.c                         |    2 -
 lib/bootconfig.c                    |   45 +++++++++++----
 tools/bootconfig/main.c             |  106 +++++++++++++++--------------------
 tools/bootconfig/test-bootconfig.sh |   12 ++++
 5 files changed, 95 insertions(+), 74 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
