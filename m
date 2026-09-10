Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C730FC1C;
	Thu, 10 Sep 2026 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001150; cv=none; b=PoZVI77I55Naqf4Zttj/corzRY/y0Xba3cNQbf7cDkuLCRniXXGo5Pyf+Hjh3Vo8j/BE+rbmVgbEcDfGXohoeDy11xs1ZR/Lx9aYMyVJf+Wk43ytQpPvSpjfFmMfHID2tgMvI09KOFTifxGLjfhPjAbv3rMD3Np4kHvplUI4AZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001150; c=relaxed/simple;
	bh=e/IWYa7lKY1V/KCeU4UTZJRYQp4VmuLP4nBhJkfpgaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BaHidddCrVM6KVtJ8ErwvbvtO4ygc+O8FWwp6MISOXEnb6A7Z8I2CJRexObX9Gaa5PV7uJhNb+bHyOH5Qfv95btUZsoncZStHxQv6ATLtoZSnjVazN7wn3AVHzTWKv/1PbdKf1rzJKQeH58XF2moUEdswX1H6GcrtVQFbtOcHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/brrGQJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/brrGQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DE91F000FF;
	Thu, 10 Sep 2026 00:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789001149;
	bh=Krkq5C6gFvpTM500BJgo8DsGFDBMwVr9zcRV20t0bBw=;
	h=From:To:Cc:Subject:Date;
	b=X/brrGQJaE2n+xs9ARfGM3sya+THscJLAvMsPxxGmHph9X3/rbSPqlRj12G+OU58z
	 9nu80kgOjjX1yGFMWcVgx6sm2A1GDiETt6a0pliXWyenxl9XG8ilSuahGmL4XhSK/S
	 YVJknKulTig8GxY4/+tP/vmxtcOunUmMDtHtg2GWkoNoRTYHFkeKQ0cD6qx5+Yn6Ml
	 A+N4sGohm9EJQbIhb8hZZ98x0ht0yaPQph/65UJZn2PmljH6r2xDMqNoQ8zuOstIWO
	 Js935TtrZMARMa9r1YwNKi8/0afwdNOlxImHNMQhxgnumymXrvQ4b6TNNIH2SXDWL5
	 06swWV/2NF80g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v2] tools/bootconfig: Fix integer overflow in size check
Date: Thu, 10 Sep 2026 09:45:45 +0900
Message-ID: <178900114498.187028.9558747732041210116.stgit@devnote2>
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

Sashiko reported that on 32-bit systems, if an attacker crafts size in
the bootconfig footer such that adding BOOTCONFIG_FOOTER_SIZE wraps around
(for instance, if size is 0xFFFFFFFF), the size check in
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

Also reject size > XBC_DATA_MAX upfront in load_xbc_from_initrd() to
avoid allocating and reading oversized configurations into memory before
xbc_init() validation.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260909161113.16C691F00A3A@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Add Cc: stable.
  - Also reject if "size > XBC_DATA_MAX", that is obviously wrong.
---
 tools/bootconfig/main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7dc9fff9b637..bf6a4e216315 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -218,7 +218,8 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	csum = le32toh(csum);
 
 	/* Wrong size error  */
-	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
+	if (size > XBC_DATA_MAX ||
+	    size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}

