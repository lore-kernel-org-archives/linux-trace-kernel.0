Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB315487
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C11C433C7;
	Mon, 30 Oct 2023 14:41:28 +0000 (UTC)
Date: Mon, 30 Oct 2023 10:41:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "Naresh Kamboju <naresh.kamboju@linaro.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Ajay Kaher <akaher@vmware.com>, Andrew Morton"
 <akpm@linux-foundation.org>, lkft-triage@lists.linaro.org
Subject: Re: [PATCH v2] eventfs: Test for ei->is_freed when accessing
 ei->dentry
Message-ID: <20231030104127.6f32c932@gandalf.local.home>
In-Reply-To: <CA+G9fYu9GOEbD=rR5eMR-=HJ8H6rMsbzDC2ZY5=Y50WpWAE7_Q@mail.gmail.com>
References: <20231028164650.4f5ea18a@rorschach.local.home>
	<CA+G9fYsL=wK_rn8ovCHtn6QXrvzv0a67oj9U3u6r9i-dxjsqwQ@mail.gmail.com>
	<20231029091408.0179cee4@rorschach.local.home>
	<CA+G9fYu9GOEbD=rR5eMR-=HJ8H6rMsbzDC2ZY5=Y50WpWAE7_Q@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 12:37:08 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> 
> I have tested the linux-trace.git trace/core and run selftests ftrace
> the reported kernel panic [1] & [2] has been fixed but found

Good to know. Can I add "Tested-by" from you for that bug fix?

> "general protection fault"  at  kernel/trace/trace_events.c:2439.

Can you test with the below patch?

Also, can I ask what are you testing this on that makes it trigger so
easily? As I'm not able to trigger these in my tests, even though they are
indeed bugs.

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 7ad7496bd597..7a0b54ddda24 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -609,7 +609,13 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		entry = &ei->entries[i];
 		if (strcmp(name, entry->name) == 0) {
 			void *cdata = data;
-			r = entry->callback(name, &mode, &cdata, &fops);
+			mutex_lock(&eventfs_mutex);
+			/* If ei->is_freed, then the event itself may be too */
+			if (!ei->is_freed)
+				r = entry->callback(name, &mode, &cdata, &fops);
+			else
+				r = -1;
+			mutex_unlock(&eventfs_mutex);
 			if (r <= 0)
 				continue;
 			ret = simple_lookup(dir, dentry, flags);
@@ -743,7 +749,13 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		void *cdata = data;
 		entry = &ei->entries[i];
 		name = entry->name;
-		r = entry->callback(name, &mode, &cdata, &fops);
+		mutex_lock(&eventfs_mutex);
+		/* If ei->is_freed, then the event itself may be too */
+		if (!ei->is_freed)
+			r = entry->callback(name, &mode, &cdata, &fops);
+		else
+			r = -1;
+		mutex_unlock(&eventfs_mutex);
 		if (r <= 0)
 			continue;
 		d = create_file_dentry(ei, i, parent, name, mode, cdata, fops, false);
