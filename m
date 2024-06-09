Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4902C19E;
	Sun,  9 Jun 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921687; cv=none; b=IZ5Hb46i/ghjymQSfKhIw5yNFekLDMfHWyy/QFSbpIn/nBIGDfYXLuT0NzTmAq2hrgnkIebD28j+v4rJ9A/F3X7FKmrdW3R8b96cxB22BdQof4wgyeD06BOoRNseFqgoCGGLrw7YdW4zVQ7ryaVnGJRWgUokemV5RkwGNCGXyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921687; c=relaxed/simple;
	bh=NiNHIvLM53266J2UpSupU/mhEjqFwYGKpKv/PxEnfjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMvqTtc8OxJ/bcazbLB6tHWmsivPUY3XgEuxkcKHXxe4TT+0k71431dlvaB4aBHq/J08OnfiEMk4nvsheIEn16UpErARxQKTfQiFvhxzX/okbJ5rYru8wjgRg7Ht+18JtZufXWQh+l4E+pvfuL6azLqYaVl6quK7hrCZphZ6VLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=MIfxNhRD; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="MIfxNhRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZGX1+w2KuTr4rSi8N+qfCTHA1YisBmkGA0Ss7Dju5os=;
  b=MIfxNhRDBVUjuFmHXlb+sNburKUTYfbjg/5uLy1R/ywhQBlUW+zmy4Xu
   2tU+2GFyi/wU/NwekIaEysW7i7MDCEFJKzQ8LxGDPQTvwvOMtfm0mKKVZ
   Hzr8XViuT/8Vp0pCRmkFXP49qaxPROuwsqKjRs23k8XwrZq8qMHUd4FeW
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,225,1712613600"; 
   d="scan'208";a="169696900"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 10:27:49 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel-janitors@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun,  9 Jun 2024 10:27:17 +0200
Message-Id: <20240609082726.32742-6-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240609082726.32742-1-Julia.Lawall@inria.fr>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed, it is not necessary to use call_rcu
when the callback only performs kmem_cache_free. Use
kfree_rcu() directly.

The changes were done using the following Coccinelle semantic patch.
This semantic patch is designed to ignore cases where the callback
function is used in another way.

// <smpl>
@r@
expression e;
local idexpression e2;
identifier cb,f;
position p;
@@

(
call_rcu(...,e2)
|
call_rcu(&e->f,cb@p)
)

@r1@
type T;
identifier x,r.cb;
@@

 cb(...) {
(
   kmem_cache_free(...);
|
   T x = ...;
   kmem_cache_free(...,x);
|
   T x;
   x = ...;
   kmem_cache_free(...,x);
)
 }

@s depends on r1@
position p != r.p;
identifier r.cb;
@@

 cb@p

@script:ocaml@
cb << r.cb;
p << s.p;
@@

Printf.eprintf "Other use of %s at %s:%d\n"
   cb (List.hd p).file (List.hd p).line

@depends on r1 && !s@
expression e;
identifier r.cb,f;
position r.p;
@@

- call_rcu(&e->f,cb@p)
+ kfree_rcu(e,f)

@r1a depends on !s@
type T;
identifier x,r.cb;
@@

- cb(...) {
(
-  kmem_cache_free(...);
|
-  T x = ...;
-  kmem_cache_free(...,x);
|
-  T x;
-  x = ...;
-  kmem_cache_free(...,x);
)
- }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

---
 fs/tracefs/inode.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7c29f4afc23d..338c52168e61 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	return &ti->vfs_inode;
 }
 
-static void tracefs_free_inode_rcu(struct rcu_head *rcu)
-{
-	struct tracefs_inode *ti;
-
-	ti = container_of(rcu, struct tracefs_inode, rcu);
-	kmem_cache_free(tracefs_inode_cachep, ti);
-}
-
 static void tracefs_free_inode(struct inode *inode)
 {
 	struct tracefs_inode *ti = get_tracefs(inode);
@@ -70,7 +62,7 @@ static void tracefs_free_inode(struct inode *inode)
 	list_del_rcu(&ti->list);
 	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
 
-	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
+	kfree_rcu(ti, rcu);
 }
 
 static ssize_t default_read_file(struct file *file, char __user *buf,

