Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CC224A16
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598B5C433CB;
	Tue, 31 Oct 2023 22:34:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
	(envelope-from <rostedt@goodmis.org>)
	id 1qxxJU-00EPhR-13;
	Tue, 31 Oct 2023 18:34:20 -0400
Message-ID: <20231031223420.141626438@goodmis.org>
User-Agent: quilt/0.66
Date: Tue, 31 Oct 2023 18:33:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Ajay Kaher <akaher@vmware.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 2/7] eventfs: Have a free_ei() that just frees the eventfs_inode
References: <20231031223326.794680978@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

As the eventfs_inode is freed in two different locations, make a helper
function free_ei() to make sure all the allocated fields of the
eventfs_inode is freed.

This requires renaming the existing free_ei() which is called by the srcu
handler to free_rcu_ei() and have free_ei() just do the freeing, where
free_rcu_ei() will call it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changse since v4: https://lore.kernel.org/all/20231031193428.133533311@goodmis.org/T/#u

- Rebased to this patch series

 fs/tracefs/event_inode.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 2c2c75b2ad73..0331d9bd568b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -129,6 +129,13 @@ static struct dentry *create_dir(const char *name, struct dentry *parent)
 	return eventfs_end_creating(dentry);
 }
 
+static void free_ei(struct eventfs_inode *ei)
+{
+	kfree_const(ei->name);
+	kfree(ei->d_children);
+	kfree(ei);
+}
+
 /**
  * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
  * @ti: the tracefs_inode of the dentry
@@ -168,9 +175,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 			eventfs_remove_dir(ei_child);
 		}
 
-		kfree_const(ei->name);
-		kfree(ei->d_children);
-		kfree(ei);
+		free_ei(ei);
 		return;
 	}
 
@@ -784,13 +789,11 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ERR_PTR(-ENOMEM);
 }
 
-static void free_ei(struct rcu_head *head)
+static void free_rcu_ei(struct rcu_head *head)
 {
 	struct eventfs_inode *ei = container_of(head, struct eventfs_inode, rcu);
 
-	kfree_const(ei->name);
-	kfree(ei->d_children);
-	kfree(ei);
+	free_ei(ei);
 }
 
 /**
@@ -883,7 +886,7 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 		for (i = 0; i < ei->nr_entries; i++)
 			unhook_dentry(&ei->d_children[i], &dentry_list);
 		unhook_dentry(&ei->dentry, &dentry_list);
-		call_srcu(&eventfs_srcu, &ei->rcu, free_ei);
+		call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
 	}
 	mutex_unlock(&eventfs_mutex);
 
-- 
2.42.0
