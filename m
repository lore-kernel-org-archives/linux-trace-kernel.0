Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A8E571;
	Fri,  4 Apr 2025 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743728733; cv=none; b=KbW7iWP3zy0pXw1zxlycLlzwXa3xkNdKKQZar1oebgi6zDWurS2nlPFpJpSpZAvRUhcVBCEy6LgcDd5Y7l+IQ6SEpr6MBdk9AfbKZ225XPBh32IhjGGWYJEEnGrofyIv0aAAyG0DpEBuKeSI5Y1h3td6RVId0xp9mPV9YSBYikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743728733; c=relaxed/simple;
	bh=UW1f2XrhSOMw+kbYL7nyBjFEKDtP2TUxMoV5tlAU4U8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mmmhiBJ7hm5Z8y8LEhp8eZctTAJsQLld/PmN+IF5eP1EdiHdCtwAK+Iun0Zq/a9ISrhmQT+/q7qOxveSmU59/sV+BF+d6TYiUstVIkrw6mfARgIIi9BtESbTD1Y7iFOkLz6B8P6d7J30EIPmD2VIkqutHefm0ZBKtygCykYHZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0D4C4CEE7;
	Fri,  4 Apr 2025 01:05:31 +0000 (UTC)
Date: Thu, 3 Apr 2025 21:06:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>, Kees
 Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Subject: [PATCH] tracing: Always use memcpy() in histogram add_to_key()
Message-ID: <20250403210637.1c477d4a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The add_to_key() function tests if the key is a string or some data. If
it's a string it does some further calculations of the string size (still
truncating it to the max size it can be), and calls strncpy().

If the key isn't as string it calls memcpy(). The interesting point is
that both use the exact same parameters:

                strncpy(compound_key + key_field->offset, (char *)key, size);
        } else
                memcpy(compound_key + key_field->offset, key, size);

As strncpy() is being used simply as a memcpy() for a string, and since
strncpy() is deprecated, just call memcpy() for both memory and string
keys.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c1ea6aaac182..4258324219ca 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5224,10 +5224,8 @@ static inline void add_to_key(char *compound_key, void *key,
 		/* ensure NULL-termination */
 		if (size > key_field->size - 1)
 			size = key_field->size - 1;
-
-		strncpy(compound_key + key_field->offset, (char *)key, size);
-	} else
-		memcpy(compound_key + key_field->offset, key, size);
+	}
+	memcpy(compound_key + key_field->offset, key, size);
 }
 
 static void
-- 
2.47.2

