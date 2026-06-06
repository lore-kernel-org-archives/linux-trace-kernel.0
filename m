Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318F3C13E3;
	Sat,  6 Jun 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777640; cv=none; b=d5aLSgA8AwKEqha6d0x/iI42E9CJSEEK3ZqogAE2cK+iWXFeg+yyK/lhKY2ZFeLlksD8vIitxeJkETOxJSLBwXH3f+iA5/fWGMAY1Rf0wf+4qTDNgcoeJGDxcFot5jwxiED1NVLbL2wOPF9MoW817zsUApSff1TsfY+Hg/Y2rtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777640; c=relaxed/simple;
	bh=AsZxzbtwY1uS8bwGg5TrklhBtJkdF4iE4u1EWdqdsio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvPtSjoWcZxRd38D1+0OqqtotkG2W4KONu6vXIpezW1NPWq/AKz7WYx8UID0ODtBsdIzxg4Ls1iMckMlAxymubfsdF7ETpfz9GexzzBIDDp2hByia6hlXIgq1Xcneea4UE4PZNxrwo5bm4hFJ6hyvofIIeNbLiUxZo9NXtZGj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mrTNlGfL; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mrTNlGfL"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbt-007cGL-0S; Sat, 06 Jun 2026 22:27:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=sCegYZy4ZaeEUp5KE/t7AmuTsTUVBj9+y2Qhwzm3Wqg=; b=mrTNlG
	fLKxo3wrjLQp1ru9RZpugd5dFQ/1HSwGTzwEpQsxy69X3rSaWjWJyCS1d2puM8rDpyF4fAnwk+rQZ
	m9VVNLkfdUbzWkNoV96Lxqj7WFWtLXTod/5HGFUUNy6WNyxCMUhKUqsJ/s4hZ9h04PwATiqPLJ6Bx
	CPQ2i5fURx8Lqcq+wmD9QvA6JrsX6hlBlyMfDTJPhCKSluAY9iC6qQmtsVFIV0+bZpXL5eqQloz59
	f/cNk4c4ODaeKWY/vj6qNhT8HjXcM70WDrCoj35bzeJdISoPt11vRc5St1Ci4PKDp/4lG66r01cay
	s3HP0M5zp5eNNSIiSZNpyw4B9kUw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbs-0000tY-CV; Sat, 06 Jun 2026 22:27:12 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbn-006V18-79;
	Sat, 06 Jun 2026 22:27:07 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] kernel/trace/trace_printk: Use kstrdup() instead of kmalloc() and strcpy()
Date: Sat,  6 Jun 2026 21:26:28 +0100
Message-Id: <20260606202633.5018-34-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 kernel/trace/trace_printk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 3ea17af60169..98171a2398e4 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -71,10 +71,9 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
 		fmt = NULL;
 		tb_fmt = kmalloc_obj(*tb_fmt);
 		if (tb_fmt) {
-			fmt = kmalloc(strlen(*iter) + 1, GFP_KERNEL);
+			fmt = kstrdup(*iter, GFP_KERNEL);
 			if (fmt) {
 				list_add_tail(&tb_fmt->list, &trace_bprintk_fmt_list);
-				strcpy(fmt, *iter);
 				tb_fmt->fmt = fmt;
 			} else
 				kfree(tb_fmt);
-- 
2.39.5

