Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q0yqQ06D"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7EE7CF;
	Sun, 10 Dec 2023 13:35:39 -0800 (PST)
Received: from localhost.localdomain (unknown [4.155.48.117])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0B1F620B74C0;
	Sun, 10 Dec 2023 13:35:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B1F620B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702244139;
	bh=AwLPxkWSQ+xItqIkFFnflTbsJwcL70eHM305+He6/Pg=;
	h=From:To:Cc:Subject:Date:From;
	b=Q0yqQ06DL6j6eJXGiMYqLMRzH0Z35EwyGtwfYeQo39pIavtQQswP9U9W+Y2C4mnK5
	 4DOQl4iBwB/Fdjj1Twp+REAOorZvSpve6dVXFD+7rnWCyPFshu2X+bO0PC3bT60Jod
	 +u8XHr4jdJl+or4ylxmDlOSB7qLan3taIGygsXug=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] eventfs: Fix events beyond NAME_MAX blocking tasks
Date: Sun, 10 Dec 2023 21:35:34 +0000
Message-Id: <20231210213534.497-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eventfs uses simple_lookup(), however, it will fail if the name of the
entry is beyond NAME_MAX length. When this error is encountered, eventfs
still tries to create dentries instead of skipping the dentry creation.
When the dentry is attempted to be created in this state d_wait_lookup()
will loop forever, waiting for the lookup to be removed.

Fix eventfs to return the error in simple_lookup() back to the caller
instead of continuing to try to create the dentry.

Fixes: 63940449555e ("eventfs: Implement eventfs lookup, read, open functions")
Link: https://lore.kernel.org/linux-trace-kernel/20231208183601.GA46-beaub@linux.microsoft.com/
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
Please note the fixes tag is the first add of simple_lookup logic, there
have been other changes beyond that may be a better fit to targetting.

 fs/tracefs/event_inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f8a594a50ae6..d2c06ba26db4 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -561,6 +561,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
 		ret = simple_lookup(dir, dentry, flags);
+		if (IS_ERR(ret))
+			goto out;
 		create_dir_dentry(ei, ei_child, ei_dentry, true);
 		created = true;
 		break;
@@ -583,6 +585,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 			if (r <= 0)
 				continue;
 			ret = simple_lookup(dir, dentry, flags);
+			if (IS_ERR(ret))
+				goto out;
 			create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
 					   fops, true);
 			break;
-- 
2.34.1

