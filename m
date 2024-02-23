Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E90145B1B;
	Fri, 23 Feb 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722724; cv=none; b=lee4XBV7BmLtcBMjG6p1YdnkXkmp6xjswWrno+BEotrqX8GG7ERHlBPnPlz6/wn6rpjUV67ZBXI+XIFAYnA1C4vwqwcun+i8G6mJqQ0e/cI6ERCWl9gM8DoBaFHeF67TT4HtTzg+c5X4k4hMAUTj4WBJf6vNQ4lwA6pxS0e0exg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722724; c=relaxed/simple;
	bh=7YKVatjZtLj3Na7KbfWy5eEmG9QS3EfYU6v221BJ9nA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O+4OzPNXYwTI983af12MxfFVQ2Gppbhi7dfAIMxKIEigimNIvVdAHGR+vCYXODDwZlJ20RVLnIU/KC43mR4+6Z7YSgj7zQiYWA/EDfdMOaB7flCszuxZJisp3+bHnZyiC6Cv1qU+57MAVo7BmUu5w/ErmCuO5pOL7XfkHkeyZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55665C433F1;
	Fri, 23 Feb 2024 21:12:03 +0000 (UTC)
Date: Fri, 23 Feb 2024 16:13:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Add warning if string in __assign_str() does
 not match __string()
Message-ID: <20240223161356.63b72403@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In preparation to remove the second parameter of __assign_str(), make sure
it is really a duplicate of __string() by adding a WARN_ON_ONCE().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240223154821.77b2426d@gandalf.local.home/

- If src is NULL it is saved as NULL, no need to not test that too.

 include/trace/stages/stage6_event_callback.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 0c0f50bcdc56..935608971899 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -35,6 +35,7 @@
 	do {								\
 		char *__str__ = __get_str(dst);				\
 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
+		WARN_ON_ONCE((src) != __data_offsets.dst##_ptr_);	\
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\
 		__str__[__len__] = '\0';				\
-- 
2.43.0

