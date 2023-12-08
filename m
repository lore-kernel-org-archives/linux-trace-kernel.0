Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="deRMERS6"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8A2F118
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:36:06 -0800 (PST)
Received: from CPC-beaub-VBQ1L. (unknown [4.155.48.118])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2286820B74C0;
	Fri,  8 Dec 2023 10:36:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2286820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702060566;
	bh=9qiw0ud3VQ9Dax7D3Cck7ZTuYdOLgNSzI8OXY5I9+3k=;
	h=Date:From:To:Cc:Subject:From;
	b=deRMERS6hW1B6uJU7Psfzhn0gxwkDUrywl7AjojfASC52Om3wZP4nmVpIaJBZ+ik3
	 disrTu+XElu0hAJ8357Zhk1rgnPGmjVDovgFv/8T7phiXtSaH7tCMHzZN9lx3mxZOP
	 1CpNIlgBigk7r1v8lb0R8+2GlhpoSLYKVbcgKJJk=
Date: Fri, 8 Dec 2023 18:36:01 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: trace_event names with more than NAME_MAX chars
Message-ID: <20231208183601.GA46-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While developing some unrelated features I happened to create a
trace_event that was more than NAME_MAX (255) characters. When this
happened the creation worked, but tracefs would hang any task that tried
to list the directory of the trace_event or remove it.

I followed the code down to the reason being eventfs would call
simple_lookup(), and if it failed, it would still try to create the
dentry. In this case DCACHE_PAR_LOOKUP would get set and never cleared.
This caused d_wait_lookup() to loop forever, since that flag is used in
d_in_lookup().

Both tracefs and eventfs use simple_lookup() and it fails for
dentries that exceed NAME_MAX. Should we even allow trace_events to
be created that exceed this limit? Or should tracefs/eventfs allow
this but somehow represent these differently?

I have a fix that appears to work for myself, but unsure if there are
other locations (attached at the end of this mail).

Thanks,
-Beau

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f8a594a50ae6..d2c06ba26db4 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -561,6 +561,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
                if (strcmp(ei_child->name, name) != 0)
                        continue;
                ret = simple_lookup(dir, dentry, flags);
+               if (IS_ERR(ret))
+                       goto out;
                create_dir_dentry(ei, ei_child, ei_dentry, true);
                created = true;
                break;
@@ -583,6 +585,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
                        if (r <= 0)
                                continue;
                        ret = simple_lookup(dir, dentry, flags);
+                       if (IS_ERR(ret))
+                               goto out;
                        create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
                                           fops, true);
                        break;
