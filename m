Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5211C83;
	Fri, 26 Jul 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014894; cv=none; b=CcFUWFocpdhnnigAbc/W6WYaXIm9V7rSnVty1W6NC9fg67FYFLJTSMb7qcpBHyiv6F1F23MHXIGSrPxXRewCK0O9GsQr8DSs3QQUwxRgAIsJq96G98X5rbk0TaxnEM/aoMLhSEcRHgW3+wlj2aosIDXbaNKde1yeYYwQnhFX79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014894; c=relaxed/simple;
	bh=J0Pw5sFZRJoxH2M0TquNENvPd8DX7knwY3nVpOeasuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZXYMVqA0N5Yw/ns9pb02QRSAoaX159OTUX6ial8d61WaVv0CG00n8i+bc7HF4LMh6deIGAd0TIVFxZP7Vs2gNIc34Bed3kTSkZb2RxLyuZkla1uRZV5hUr6CzZp7qeG49OilES42RVUZJAPtiWCwsinDtJ9ou2WbtSSTPpUkkjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEB9C32782;
	Fri, 26 Jul 2024 17:28:12 +0000 (UTC)
Date: Fri, 26 Jul 2024 13:28:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers 
 <mathieu.desnoyers@efficios.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Mathias Krause <minipli@grsecurity.net>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
  <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
  Viro <viro@zeniv.linux.org.uk>, regressions@leemhuis.info, Dan Carpenter 
 <dan.carpenter@linaro.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Fainelli  <florian.fainelli@broadcom.com>, Alexey Makhalov  
 <alexey.makhalov@broadcom.com>, Vasavi Sirnapalli  
 <vasavi.sirnapalli@broadcom.com>
Subject: [PATCH v2] tracing: Have format file honor EVENT_FILE_FL_FREED
Message-ID: <20240726132811.306a449e@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

When eventfs was introduced, special care had to be done to coordinate the
freeing of the file meta data with the files that are exposed to user
space. The file meta data would have a ref count that is set when the file
is created and would be decremented and freed after the last user that
opened the file closed it. When the file meta data was to be freed, it
would set a flag (EVENT_FILE_FL_FREED) to denote that the file is freed,
and any new references made (like new opens or reads) would fail as it is
marked freed. This allowed other meta data to be freed after this flag was
set (under the event_mutex).

All the files that were dynamically created in the events directory had a
pointer to the file meta data and would call event_release() when the last
reference to the user space file was closed. This would be the time that it
is safe to free the file meta data.

A shortcut was made for the "format" file. It's i_private would point to
the "call" entry directly and not point to the file's meta data. This is
because all format files are the same for the same "call", so it was
thought there was no reason to differentiate them.  The other files
maintain state (like the "enable", "trigger", etc). But this meant if the
file were to disappear, the "format" file would be unaware of it.

This caused a race that could be trigger via the user_events test (that
would create dynamic events and free them), and running a loop that would
read the user_events format files:

In one console run:

 # cd tools/testing/selftests/user_events
 # while true; do ./ftrace_test; done

And in another console run:

 # cd /sys/kernel/tracing/
 # while true; do cat events/user_events/__test_event/format; done 2>/dev/null

With KASAN memory checking, it would trigger a use-after-free bug report
(which was a real bug). This was because the format file was not checking
the file's meta data flag "EVENT_FILE_FL_FREED", so it would access the
event that the file meta data pointed to after the event was freed.

Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/

Cc: stable@vger.kernel.org
Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")
Reported-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20240725201517.3c52e4b0@gandalf.local.home

- Just updated the change log. The patch is the same.

  * Explain the KASAN report a bit better

  * Removed reference of "second bug" as there was no second bug.

  * Clarify that the access was to the event after it was freed, not
    the file meta data, as it still exists while anything is open.

 kernel/trace/trace_events.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6ef29eba90ce..852643d957de 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1540,7 +1540,8 @@ enum {
 
 static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct list_head *common_head = &ftrace_common_fields;
 	struct list_head *head = trace_get_fields(call);
 	struct list_head *node = v;
@@ -1572,7 +1573,8 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 
 static int f_show(struct seq_file *m, void *v)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct ftrace_event_field *field;
 	const char *array_descriptor;
 
@@ -1627,12 +1629,14 @@ static int f_show(struct seq_file *m, void *v)
 
 static void *f_start(struct seq_file *m, loff_t *pos)
 {
+	struct trace_event_file *file;
 	void *p = (void *)FORMAT_HEADER;
 	loff_t l = 0;
 
 	/* ->stop() is called even if ->start() fails */
 	mutex_lock(&event_mutex);
-	if (!event_file_data(m->private))
+	file = event_file_data(m->private);
+	if (!file || (file->flags & EVENT_FILE_FL_FREED))
 		return ERR_PTR(-ENODEV);
 
 	while (l < *pos && p)
@@ -2485,7 +2489,6 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	if (strcmp(name, "format") == 0) {
 		*mode = TRACE_MODE_READ;
 		*fops = &ftrace_event_format_fops;
-		*data = call;
 		return 1;
 	}
 
-- 
2.43.0

