Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30131D5CDD;
	Wed, 11 Jun 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658702; cv=none; b=mTHm6qfR8D3xE5w8nKTofVCIGTKP/8Ef6ojkzNTsn8IxqN8pD2mOKeBhmVsEn+Hna59uKtrRs0pXWDvbz08NK0L20+nrPu4Zlk4ZyngsKzzLfsZLnqNItyt7hYglfcFxcsUwSMWNBsGLrrtcMrj/iVXxs2iGf4Y78bIgSWKqmy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658702; c=relaxed/simple;
	bh=iCSp5O0s2s0EfwUP1NTze5TIzcnTBSIPTs27KJTso3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PbeA62LiPkQPM57kGazM30fJfn5qDXz8PXXDlM/iKNWU6JRzIQwzO1JNBn5yU/p3z46DUvISYkuB2gWqtjO2yjZyOYnfgJatyUwJZhxKq+KPjRx/SdMJQOwS8OhF6tUgfkEyK68Ru8Rtprv297cz++kfza9kqCspLqyczCha8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 3A7681019BB;
	Wed, 11 Jun 2025 16:18:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 8968C2002B;
	Wed, 11 Jun 2025 16:18:16 +0000 (UTC)
Date: Wed, 11 Jun 2025 12:18:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracefs: Add d_delete to remove negative dentries
Message-ID: <20250611121815.409d02f8@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8968C2002B
X-Rspamd-Server: rspamout08
X-Stat-Signature: nxx4hwgkekwe4364xgixpp53aw6kig1o
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NPhW+5xNRU0Cg4dInKx8FL3ulEJKb7L0=
X-HE-Tag: 1749658696-732145
X-HE-Meta: U2FsdGVkX1+OmWEOjLpUfkUPENEyZa7Ld0ag+7o5+MLZU0bP69ABNsG3+OMyyXaIyEIVqYuLa3DrGIfi4ggMYkVHJ/POShQMYHAZHMQ/ZagrKD1eS6HdvB30YmL5X/nYiVJZ9NhBw4VG+JkarTkcxxKBXMLg7C+Pq9FDtnQpcLNBSzbZObiIy7m5Yu5ruZU96helNJGaFvrjvv2Qr7f4zgRrPuxtkJniIMkTo4rnaV8CXlOmJ2KXg55GkL9qZYJLdl2a30IknWuWFAvqkFhbE6NgBwGRRZ7ngT9ebVuUJ4FW0K1Opu/QmkydvhAbr6bU5cTG+Ruz7QjPeP8uRD6d1yWTIOvO5484kSGHtiGaMMaNBT1w8enjOiX7J+vk4QkH/ZK+Ah6DtpOoMfYwBBganJ4jHddyQwtwUwnJadpAuVA8px25vts+Cmn8XjFjiTGL

From: Steven Rostedt <rostedt@goodmis.org>

If a lookup in tracefs is done on a file that does not exist, it leaves a
dentry hanging around until memory pressure removes it. But eventfs
dentries should hang around as when their ref count goes to zero, it
requires more work to recreate it. For the rest of the tracefs dentries,
they hang around as their dentry is used as a descriptor for the tracing
system. But if a file lookup happens for a file in tracefs that does not
exist, it should be deleted.

Add a .d_delete callback that checks if dentry->fsdata is set or not. Only
eventfs dentries set fsdata so if it has content it should not be deleted
and should hang around in the cache.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index a3fd3cc591bd..43f83fc9594f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -465,9 +465,20 @@ static int tracefs_d_revalidate(struct inode *inode, const struct qstr *name,
 	return !(ei && ei->is_freed);
 }
 
+static int tracefs_d_delete(const struct dentry *dentry)
+{
+	/*
+	 * We want to keep eventfs dentries around but not tracefs
+	 * ones. eventfs dentries have content in d_fsdata.
+	 * Use d_fsdata to determine if it's a eventfs dentry or not.
+	 */
+	return dentry->d_fsdata == NULL;
+}
+
 static const struct dentry_operations tracefs_dentry_operations = {
 	.d_revalidate = tracefs_d_revalidate,
 	.d_release = tracefs_d_release,
+	.d_delete = tracefs_d_delete,
 };
 
 static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
-- 
2.47.2

