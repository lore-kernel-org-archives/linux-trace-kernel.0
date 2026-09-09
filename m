Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E557F72F;
	Wed,  9 Sep 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969220; cv=none; b=J1ifTV9tQ7cAArOPiIE80kerLqvE7kBYTUhbNp7tjM9U7fnVYw3ZklNKvZyI90wo6yxTUO494UUX7rdSstjiA71NYPk4hlaCkfkaZ2ooSawq9RZysMTJwSK4kc4KWnFjPfUFwRqhmnjjvLWL69KMm78vzoR71OXndpf4/68+OQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969220; c=relaxed/simple;
	bh=L8zRsRJNdCQuF82sfb4/gKG4OlKDwibPVKr6OAMEiuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m25GokoaWV28m96XdT4q5SGWmYfeJ36i22zg2dx0ZAGO/FdL/vRmOZbjCK3CT18DH8sQRb6TUPFMeFeG+y59c5uDX+f8Hx7/ngAJd2gli8Ti1QC5PVEtKHVK0fIr4Ngn3SOn6xboVqoevqQx8bkoj8mdxQTKtipzhaLfyoDg/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxSmI8D1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxSmI8D1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6AF1F00A3D;
	Wed,  9 Sep 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969219;
	bh=AyJzWWbhLvCBH7KFbM4mj+np4Y4j6s1WN+YLEd9ozV8=;
	h=From:To:Cc:Subject:Date;
	b=PxSmI8D1exVTsE60VKoJpS6nnwt7Zsxc8T93FtFpxHjGLfcJMZMoVqvDphBibFJ5T
	 V1G6DqHEKV6B19AjjSsCyNdIXzZbf1sncG8btdNrAgiR2MzEOrUxHLnf4TSWsx+gHV
	 XBn0JE3JhKdOzEJgqSun5nOhJc5S4QRPZBBsdcYdkfuzqkpIfa5DXWwwXhCifmtlB1
	 G0kUm9et2rgyRwxSovgFygsLpLJ4w/pLhMb6cm1HdqxT37tqwnwmxFP0E/PzugQOhQ
	 NuqfGHOkkb3qrUKH8+MC/xo23fBvOgRh+YS3mzcBeit3KqoaogqmfHAZn0qUW8sfV1
	 ZOTjNPYuzQTRg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 0/3] bootconfig: Reject unexpected data after null character and cleanups
Date: Thu, 10 Sep 2026 00:53:35 +0900
Message-ID: <178896921555.177508.434402948295885560.stgit@devnote2>
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

Here are patches for bootconfig to rejects unexpected config data after null
character and other cleanups including tools/bootconfig to consolidate
bootconfig initialization with errors, and skipping internal tree sanity
check in kernel.

The last one is initially reported by Sang-Heon Jeon [1].

[1] https://lore.kernel.org/all/20260905141637.1547429-1-ekffu200098@gmail.com/

Thank you,

---
base-commit: 13e8b7707efcea3a401d242958ba0a392f227847

Masami Hiramatsu (Google) (3):
      bootconfig: Reject unexpected data after null character
      tools/bootconfig: Consolidate xbc_init() to error message wrapper
      bootconfig: Skip internal tree sanity checks in kernel


 lib/bootconfig.c                    |   45 ++++++++++----
 tools/bootconfig/main.c             |  112 +++++++++++++++++------------------
 tools/bootconfig/test-bootconfig.sh |   12 ++++
 3 files changed, 99 insertions(+), 70 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
