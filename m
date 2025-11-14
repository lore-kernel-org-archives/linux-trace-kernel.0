Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8332144A;
	Fri, 14 Nov 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140420; cv=none; b=ZYI0lwbRwmIJNUZ0QyMy3n1ViVX4NhbLUM6KGzJ99fNtEOtW3SWOeMYIOakXrzqFmN7Nk+gy7gQY+BKFnmROi2l6eJeC30ixKR7FxGx66ScB/b4axVpP+ZWj/hOYcUFKuoWNjzL7QClnhVdGyPwOxOaHTK6LKU1YgDZ2sslqRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140420; c=relaxed/simple;
	bh=kqeulIjEeCWkPAaXgtf6XIYKNW2Kt3wRk3ISkyyJZ64=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GCijfhj5mUUXLBKjMMzEncUIn2CoiwBn6AT77DwG7qH6WddfBBYsUC2WSs55ZKCI8jlpHmIWn4IPZJ5L0EE55DkTlL8+5JOMBGpNNtWaZ5mKaoCFfbaV99sX5QVXZ/43/zXblw5JZtTBbQiK1erUjx6UPfrDzr/0LC7Y+A8nx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id F333116042E;
	Fri, 14 Nov 2025 17:13:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 0C87945;
	Fri, 14 Nov 2025 17:13:33 +0000 (UTC)
Date: Fri, 14 Nov 2025 12:13:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, David
 Laight <david.laight.linux@gmail.com>
Subject: [PATCH] unwind: Show that entries of struct unwind_cache is not
 bound by nr_entries
Message-ID: <20251114121352.35108fb8@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gi551kyuxsh6rqyjq8yarid3eierre6a
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0C87945
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+XWqw1ekXKilKkUbkXwluqNYFQvM41xK4=
X-HE-Tag: 1763140413-112568
X-HE-Meta: U2FsdGVkX195nCPf9zWFddlfK+FkogLjoOueg7YnKCStKpEnv4fvl34zgJr+QL/giZ5UmbBDWrjUcmxDZlaqBSunk3qIlpt/pZ0WhgSE6u8YIyg/65viDS6zI2Y6UI5zlxHfs8abZL6ncWNsl8rsRS980Feh9OIFewRY8tj0M/dKbOQ5VOuj4eTFYAhGZbc70Yw8KO9Am59B2NY94la8bg9Gy5stE9oJmM4PNTvc47oG+KnI3PLD/I2r60S/TzvydJVOGYdPLlzDm+OrTyULdkMacLE79gAFh0GqnY5abaGP+9uNHXWfKP8SzGkaCmJl9BlVyqcAysxiaow0cExnUfJXkkgwtnl1sY85SHYW9aTmNtXKeAvY0MHVUfLIv0kjsvVuWPcRLiCI+FbHbw77Ew==

From: Steven Rostedt <rostedt@goodmis.org>

The structure unwind_cache has:

struct unwind_cache {
	unsigned long		unwind_completed;
	unsigned int		nr_entries;
	unsigned long		entries[];
};

Which triggers lots of scripts to convert this to:

struct unwind_cache {
	unsigned long		unwind_completed;
	unsigned int		nr_entries;
	unsigned long		entries[] __counted_by(nr_entries);
};

But that is incorrect. The structure is created via:

 #define UNWIND_MAX_ENTRIES					\
	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))

 info->cache = kzalloc(struct_size(cache, entries, UNWIND_MAX_ENTRIES), GFP_KERNEL);

Where the size of entries is determined by the size of the rest of the
structure subtracted from 4K. But because the size of entries has a
dependency on the structure itself, it can't be used to define it.

The entries are filled by another function that returns how many entries it
added and that is what nr_entries gets set to. This would most definitely
trigger a false-positive out-of-bounds bug if the __counted_by() was added.

To stop scripts from thinking this needs a counted_by(), move the
UNWIND_MAX_ENTRIES macro to the header, and add a comment in the entries
size:

	unsigned long		entries[ /* UNWIND_MAX_ENTRIES */ ];

Link: https://lore.kernel.org/all/20251114122748.222833-1-thorsten.blum@linux.dev/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred_types.h | 6 +++++-
 kernel/unwind/deferred.c              | 4 ----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 33b62ac25c86..61496397b0f9 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,10 +2,14 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+/* Make the cache fit in a 4K page */
+#define UNWIND_MAX_ENTRIES					\
+	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
+
 struct unwind_cache {
 	unsigned long		unwind_completed;
 	unsigned int		nr_entries;
-	unsigned long		entries[];
+	unsigned long		entries[ /* UNWIND_MAX_ENTRIES */ ];
 };
 
 /*
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index dc6040aae3ee..3284bec6d04b 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -37,10 +37,6 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 }
 #endif
 
-/* Make the cache fit in a 4K page */
-#define UNWIND_MAX_ENTRIES					\
-	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
-
 /* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
-- 
2.51.0

