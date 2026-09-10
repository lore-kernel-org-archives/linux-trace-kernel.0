Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538E4AA028;
	Thu, 10 Sep 2026 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053326; cv=none; b=hk/wYPW+457xvtk9RojcLWR2UGQ1tpA5PrE2lOtU+cs3APcjCt/5uj1F6FjEc2VI4xfw7y/bC8ljKX1KEAbp5fBLkNa6seseia9sOZVxKmuTOEMozNMPifXwMvn/PNTe10lqLd6LSUqmqkpMaYpkeOowSSnbVCidYJr4C5B51ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053326; c=relaxed/simple;
	bh=bS0iTk6y+iWy1QAqA6OGZlrz7j5cIbruQlCr8yObKrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e/BkYtXYL/Lv4GQNd4LATQVTPOSBKMp5v1QxDwcF5jnbGJRQmamY1WzUBFASDv7uhe1cJPW/Y0jxvPzyJSn5IALftETKeIaHQW/WpD3G++xm9R4xVf4/dkWZ9/QmdbQfZRN4uEoqz7iBIFsNCP1PQ7uyrTLDC96AIgTwGqPhxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/SKbX9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/SKbX9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6EF1F00893;
	Thu, 10 Sep 2026 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053318;
	bh=fVdN/IdPyKrChyTaVTrvxaC1UxDNqKSBthXzuxU3lS0=;
	h=From:To:Cc:Subject:Date;
	b=h/SKbX9AtmJDV1I72SaIwh2PHJ/VuQZUe9BPd/VhFtOFztHqu8TIOV3irEgOx0K6d
	 6OZZNPpE/I8XVXgvXjUsiRp+wL0MvI+rmV5GP4esJP1ROIfUKrrWi7A9FQmo88AJrc
	 VB8W1Ksk3EGyDz6nr4d0ihfq/8QX1G+Y8WkmvUQa1+m8XUg4rLbu/4eftzM4lC7ieO
	 qV8hC1KNgxfWUN29w9XHTK+FVfLBIYtR9ZjNHdiscyhI2hXfaAG1yyxSkTVec3tdwk
	 ToedSeJi1bIfZ8+uPuTk1izBDzHFpjYJw0O9uYG3em0RBfj/4Zhj0WSP1M3Vlu2QxU
	 viHJjEhZ2kwNw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v4 0/2] bootconfig: Fix integer overflow problems
Date: Fri, 11 Sep 2026 00:15:13 +0900
Message-ID: <178905331374.213925.295025394754459843.stgit@devnote2>
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

Here are v4 patches to fix bootconfig size overflow issue. If there is a wrong
bootconfig size is recorded, it can bypass the size check in the tool and the
kernel.

Here is the previous version.

  https://lore.kernel.org/all/178900555453.200943.4719889510443114485.stgit@devnote2/

This version removes redundant and wrong size check in setup_boot_config()
and add correct error message for size > XBC_DATA_MAX.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tools/bootconfig: Fix integer overflow and truncation in size checks
      bootconfig: Fix integer overflow in initrd size check


 init/main.c             |   25 +++++++++++++++----------
 tools/bootconfig/main.c |   13 ++++++++++++-
 2 files changed, 27 insertions(+), 11 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
