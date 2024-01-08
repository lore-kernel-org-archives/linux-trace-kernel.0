Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA854FA9;
	Mon,  8 Jan 2024 18:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A13CC433C9;
	Mon,  8 Jan 2024 18:36:27 +0000 (UTC)
Date: Mon, 8 Jan 2024 13:37:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Beau Belgrave <beaub@linux.microsoft.com>
Subject: [PATCH] tracing user_events: Simplify user_event_parse_field()
 parsing
Message-ID: <20240108133723.031cf322@gandalf.local.home>
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

Instead of having a bunch of if statements with:

       len = str_has_prefix(field, "__data_loc unsigned ");
       if (len)
               goto skip_next;

       len = str_has_prefix(field, "__data_loc ");
       if (len)
               goto skip_next;

       len = str_has_prefix(field, "__rel_loc unsigned ");
       if (len)
               goto skip_next;

       len = str_has_prefix(field, "__rel_loc ");
       if (len)
               goto skip_next;

	goto parse;

 skip_next:

Consolidate it into a negative check and jump to parse if all the
str_has_prefix() calls fail. If one succeeds, it will just continue with
len equal to the proper string:

       if (!(len = str_has_prefix(field, "__data_loc unsigned ")) &&
           !(len = str_has_prefix(field, "__data_loc ")) &&
           !(len = str_has_prefix(field, "__rel_loc unsigned ")) &&
           !(len = str_has_prefix(field, "__rel_loc "))) {
               goto parse;
       }

 skip_next:

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9365ce407426..ce0c5f1ded48 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1175,23 +1175,13 @@ static int user_event_parse_field(char *field, struct user_event *user,
 		goto skip_next;
 	}
 
-	len = str_has_prefix(field, "__data_loc unsigned ");
-	if (len)
-		goto skip_next;
-
-	len = str_has_prefix(field, "__data_loc ");
-	if (len)
-		goto skip_next;
-
-	len = str_has_prefix(field, "__rel_loc unsigned ");
-	if (len)
-		goto skip_next;
-
-	len = str_has_prefix(field, "__rel_loc ");
-	if (len)
-		goto skip_next;
+	if (!(len = str_has_prefix(field, "__data_loc unsigned ")) &&
+	    !(len = str_has_prefix(field, "__data_loc ")) &&
+	    !(len = str_has_prefix(field, "__rel_loc unsigned ")) &&
+	    !(len = str_has_prefix(field, "__rel_loc "))) {
+		goto parse;
+	}
 
-	goto parse;
 skip_next:
 	type = field;
 	field = strpbrk(field + len, " ");
-- 
2.43.0

