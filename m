Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1457429014;
	Mon, 14 Sep 2026 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396980; cv=none; b=qodUr6RtKRv5OOK54EL1u3tx6AmH6YiU6UfVPa/AxPM6p+KsDD4pzW2aG69TzT2PurZhgg+QoijtxQZopyBV5uUHFOryWwLjwotpunYw4nk9DFOZiq+pfY4g0Go6j/LGXApc27AV7fkbfSmLvBQXRhmfB1WSqvaNNz18wZGJ2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396980; c=relaxed/simple;
	bh=oUfXONRmdPZZVsyxIJqYvpxibqhdMN9N5osXAb11toE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UPSWZXti2wQW1eQaZAK2npq9tPuOfyp7x6LU9iMVorx2vOwkpylrhXg+JyxiowhRUQyIIM09eA1gCbi/hmMB7xcyYg4f8yTW/bbI9KqY4K28x6iR/7eydV+LXNIfxC0k2VBKVUGgvslTO3sipZLvq4jykKx8VFvB9oW/nwGZqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Y1jHUpcR; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=v09KwDrj; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Y1jHUpcR";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="v09KwDrj"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789396956; bh=QdSMxLfH7VT3rsmMwkVtLgH
	fnAcvTNOrmWQqrtRvl/w=; b=Y1jHUpcRgLqej4D9Ctek4/1ydwQKSblW6COCRGP/XuhuoU+oT5
	WS3kiBHgYG4F+rUY/4t1wok4ojckZZd55kZbkqzM0O4llspF+cX93mFglcvTzRV9LC5wqw3GBhe
	kS4n9wqstqMxEJuTT40X3nxQ4rXzm8Td2xERtaEi4knRgZ0fOulNcY0Pawfbv/SXDoeYCWa+OMN
	qLyB7pnAcwgHttwniwJ6I42/zRYoVhhPhLIRcQSkKCLVn0wfYAobc5IVqrtwGEjsPl8Zp7LYIwT
	jAP70CCC3pl31j2osEDCoIBWbX/a9112MFeHLske98O/IRDczKhK8mTXWYDoAri8LkQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789396956; bh=QdSMxLfH7VT3rsmMwkVtLgH
	fnAcvTNOrmWQqrtRvl/w=; b=v09KwDrjF4QtwpEd+jknffYykzU6U/N8faq1ZvpZoqDPO9wh5m
	Gv/n+ge+C4GlBL7EpjkJ4mcCbWio+Av+aEBg==;
Date: Mon, 14 Sep 2026 15:42:37 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_2/3=5D_module=3A_fix_up_documenta?=
 =?US-ASCII?Q?tion_for_add=5Ftaint=28=29_and_add=5Ftaint=5Fmodule=28=29?=
In-Reply-To: <20260914-bind_taint-v4-2-eadf8a090903@linuxfoundation.org>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org> <20260914-bind_taint-v4-2-eadf8a090903@linuxfoundation.org>
Message-ID: <066AC452-108A-45B4-A008-3FF84C85EAD6@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 14 September 2026 15:30:32 BST, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>When add_taint_module() was added, the documentation for it was copied
>directly from add_taint().  But that documentation was a bit wrong
>(wrong variable name, and misleading boolean reference.)  Fix up both
>functions to have the correct documentation for how to use the
>lockdep_ok parameter to these functions.
>
>Reported-by: Petr Pavlu <petr.pavlu@suse.com>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
> kernel/module/main.c | 5 +++--
> kernel/panic.c       | 5 +++--
> 2 files changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/module/main.c b/kernel/module/main.c
>index 444d990c9983..369794876c3e 100644
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -197,8 +197,9 @@ static inline int strong_try_module_get(struct module *mod)
>  * @flag: one of the TAINT_* constants.
>  * @lockdep_ok: whether lock debugging is still OK.
>  *
>- * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
>- * some noteworthy-but-not-corrupting cases, it can be set to true.
>+ * If something bad has gone wrong, you'll want
>+ * @lockdep_ok = LOCKDEP_NOW_UNRELIABLE, but for some
>+ * noteworthy-but-not-corrupting cases, it can be set to LOCKDEP_STILL_OK.
>  */
> void add_taint_module(struct module *mod, unsigned flag,
> 		      enum lockdep_ok lockdep_ok)
>diff --git a/kernel/panic.c b/kernel/panic.c
>index 213725b612aa..892045d8409e 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -948,8 +948,9 @@ unsigned long get_taint(void)
>  * @flag: one of the TAINT_* constants.
>  * @lockdep_ok: whether lock debugging is still OK.
>  *
>- * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
>- * some notewortht-but-not-corrupting cases, it can be set to true.
>+ * If something bad has gone wrong, you'll want
>+ * @lockdep_ok = LOCKDEP_NOW_UNRELIABLE, but for some
>+ * noteworthy-but-not-corrupting cases, it can be set to LOCKDEP_STILL_OK.
>  */
> void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
> {
>
>
Reviewed-by: Bradley Morgan <brads@mainlining.org>

Thanks.
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
