Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC5214235;
	Wed, 16 Apr 2025 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744836765; cv=none; b=s/HJ5qQ8kAJypd7fluMR8AYjFhalboMg4hG18UgdNuwQg6QfFrEZuvGmwqFRwVZ0V3Broex6k+aiNxkXAnlOZYNDqs1JSA21nP/vvbC6SwOE8qPYww/beqApTzzag2D0wnJ+d+NGGnluEG/8+8Df4Tiue3kOyyyw69CS8QX4KYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744836765; c=relaxed/simple;
	bh=f0OYppxEavlfyHTNKLYVKPUYMvnUbW49R6+sWigyn6U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ciupaw8Lgsty1bMAz2GH+FhkRjV2P6M9g9yepxT2liO+gOJtHRAN8+nWQYYDD1h64sF490HfiuWWbLzoO0yeYQJi6jORqfkNGa7H1T3DKWvR64nbrjTWi0ICcQoTJux7w//bdsFG1eZmjy9frYBEc0TMENj0p2K1+S3Fs94ImWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A339C4CEE2;
	Wed, 16 Apr 2025 20:52:43 +0000 (UTC)
Date: Wed, 16 Apr 2025 16:54:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ftrace: Comment that ftrace_func_mapper is freed with
 free_ftrace_hash()
Message-ID: <20250416165420.5c717420@gandalf.local.home>
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

The structure ftrace_func_mapper only contains a single field and that is
a ftrace_hash. It is used to abstract it out from a normal hash to control
users of how it gets modified.

The freeing of a ftrace_func_mapper structure is:

  free_ftrace_hash(&mapper->hash);

Without context, this looks like a bug. It should be commented that it is
not a bug and it is freed this way.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a8a02868b435..19b902b8de2b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5160,8 +5160,12 @@ struct ftrace_func_map {
 	void				*data;
 };
 
+/*
+ * Note, ftrace_func_mapper is freed by free_ftrace_hash(&mapper->hash).
+ * The hash field must be the first field.
+ */
 struct ftrace_func_mapper {
-	struct ftrace_hash		hash;
+	struct ftrace_hash		hash;	/* Must be first! */
 };
 
 /**
@@ -5296,6 +5300,7 @@ void free_ftrace_func_mapper(struct ftrace_func_mapper *mapper,
 			}
 		}
 	}
+	/* This also frees the mapper itself */
 	free_ftrace_hash(&mapper->hash);
 }
 
-- 
2.47.2

