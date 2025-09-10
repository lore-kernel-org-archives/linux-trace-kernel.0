Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E92153E7;
	Wed, 10 Sep 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535462; cv=none; b=YEKiXZY0650+eyRFuom7W7Eg3MHH1uL49WwKFwDK/6qK77DNWJzLSO0Z+znO1iE0NVDg7aICQru53IYsCpERoFt65FwzAxKiyaqRNv8Fzp9Q6gMjY769Tll9od63pSljjKelur78ScsaCCuO1SpMnwfLKkjshlogmG07C267CC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535462; c=relaxed/simple;
	bh=Bg622m1S19EyWktcmtev4P2MwWOXN2uDsoi/cCm+VJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tes+CX4xuNVLCvA7jteLflhnov8ISmE7RIyll5qNec/TmcMwT8iL2YXvj1Xmk8Snpk2e7XG1IcNw9QhcFBz/dttzBlmksh9yLuVTvfGhYcLOVCjX7GyVAQx4PYtDAa4D8HGZcsmxTTVhNk8fepfQGwzEgJVH5n2QkLt89cnbvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 172E81401FC;
	Wed, 10 Sep 2025 20:17:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 232852000D;
	Wed, 10 Sep 2025 20:17:30 +0000 (UTC)
Date: Wed, 10 Sep 2025 16:18:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, Kees Cook
 <keescook@chromium.org>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro
 <viro@ZenIV.linux.org.uk>
Subject: [PATCH] uaccess: Comment that copy to/from inatomic requires page
 fault disabled
Message-ID: <20250910161820.247f526a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9ywychgce7jcr1kcxdk8w14ff8araiaz
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 232852000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19BBTwwLDsir0hYAEKbj0Aqi5DJnU7TB68=
X-HE-Tag: 1757535450-343880
X-HE-Meta: U2FsdGVkX1+LXnjBkhITVL/OslgiLeLF3o1a0C4PdpHYfRRE10FTK6MKYR3ixYLqwGUxK/bvqCAQl5HzSryYE/oOxu7vIsusicNrcJUGpUK131VIXs8D7QAvmoy283ZtGnIn+/+mtzcPK6Je5EgKeGZfFmo1LcSs6aQOPniQnwD3qK+Yg/MPqE25toAlQWlDFreyedHFx1LLOA/IsDDCmYdOetFOL34AsfIZjOgXaTs5NC9+Nq/P8PwnByessqsRsKPLbFbKSPgoZgKZyA34a7T9jLCpRYOP3IibmStjVINc94sXs9OTJlhxEur0H59G2HcqtZ8ESbYYHayPUXBON2JJlhMcBrJgcvFxNI5eoxX0fvAwjw3KWMDYee3eYjxsLwW9SKlRq2AOHpjH0As1wOpFsF/hppCBzRvHWhxz1Mw=

From: Steven Rostedt <rostedt@goodmis.org>

The functions __copy_from_user_inatomic() and __copy_to_user_inatomic()
both require that either the user space memory is pinned, or that page
faults are disabled when they are called. If page faults are not disabled,
and the memory is not present, the fault handling of reading or writing to
that memory may cause the kernel to schedule. That would be bad in an
atomic context.

Link: https://lore.kernel.org/all/20250819105152.2766363-1-luogengkun@huaweicloud.com/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/uaccess.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1beb5b395d81..add99fa9b656 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -86,6 +86,12 @@
  * as usual) and both source and destination can trigger faults.
  */
 
+/*
+ * __copy_from_user_inatomic() is safe to use in an atomic context but
+ * the user space memory must either be pinned in memory, or page faults
+ * must be disabled, otherwise the page fault handling may cause the function
+ * to schedule.
+ */
 static __always_inline __must_check unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
@@ -124,7 +130,8 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
  * Copy data from kernel space to user space.  Caller must check
  * the specified block with access_ok() before calling this function.
  * The caller should also make sure he pins the user space address
- * so that we don't result in page fault and sleep.
+ * or call page_fault_disable() so that we don't result in a page fault
+ * and sleep.
  */
 static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
-- 
2.50.1

