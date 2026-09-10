Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8423EAAD;
	Thu, 10 Sep 2026 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000253; cv=none; b=ffLbURlX2FFqWD44kqqtNLwfl7hjKQ+9rc1z6oCrO0XITGhU+V8ZARgv2REZ7pc60ddJutsgMfQ4SZ3pbIYVGWSpo9Ig1qY6nSe9VZm2gBiOY5PRJGwVFMWs4HjEgK1k7h60U1cEqJRKBglM7vMEhL81QEqpexEo9Qf4gxA32QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000253; c=relaxed/simple;
	bh=IqnGyI4kETiwj7vUo8HxhMF+sWJkmT0jRUGRae+/GBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CN2HCHrhXJThCN3v2lJ6Ntd08r7+YMoE6VY0hvPNFipGHucO4Kq4IxdKUHq0fH3NMGiSXBiK2ebkO68ZkmcfQFlhsbG8UPOc7jJ8Qxy3LMLenuuAQYDZgkKnKGgX8VL8Ma5l6HTltdn7tsYB+bhpCI0VZ/vCw+/73wXuVkYhFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwk//jcx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwk//jcx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416801F000FF;
	Thu, 10 Sep 2026 00:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789000250;
	bh=rFkP9UpkopXJcBtutREeJmpmh/HBxk07oyFyZlOMnio=;
	h=From:To:Cc:Subject:Date;
	b=Zwk//jcxR0f5lPf3BvFiitdL0MdWK05S8/vN1N8n3TtsqzK9VfekstvgMSFRa50EU
	 yOAU6E1R6Fbc3fghqgS/8atMMGeuGsqiJK+UYIpNKG9p71A1SVxvC1ACxoMi/Svvtz
	 FN6MbSimocj6vCnC8eMpCnWeY6NHkdBZ4xHaAYRJ5hlxfJpkVCXXCsWKmLTSS0Ob+s
	 ynjBrVkpdVrNvFH3AT25eQHTV4l7yemOgGyG32mWSyMKcTIyTDratkg4b+wqF6YNSO
	 a51kGzbu0UOAvacmt7wX3VpoUgJRGC5MTbjWwgu/v8e3n7CXKWPF+nHC+wE0TwphW9
	 Hny9PxhPC8jXA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH] tools/bootconfig: Fix integer overflow in size check
Date: Thu, 10 Sep 2026 09:30:46 +0900
Message-ID: <178900024679.183840.10345859264677533824.stgit@devnote2>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko reported that on 32-bit systems, if the size in the bootconfig
footer is corrupted such that adding BOOTCONFIG_FOOTER_SIZE wraps
around (for instance, if size is 0xFFFFFFFF), the size check in
load_xbc_from_initrd() can be bypassed:

    if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
        pr_err("bootconfig size is too big\n");
        return -E2BIG;
    }

This would lead to load_xbc_fd() being called with a negative size,
resulting in an undersized allocation, heap overflow on read, and
out-of-bounds write on the terminating null byte.

Avoid the integer overflow by checking whether size is greater than
stat.st_size - BOOTCONFIG_FOOTER_SIZE. Since stat.st_size is already
verified to be at least BOOTCONFIG_FOOTER_SIZE earlier in the function,
this subtraction will never underflow.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260909161113.16C691F00A3A@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7dc9fff9b637..b380ad6777fa 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -218,7 +218,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	csum = le32toh(csum);
 
 	/* Wrong size error  */
-	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
+	if (size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}

