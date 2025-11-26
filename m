Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A23148A6;
	Wed, 26 Nov 2025 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186729; cv=none; b=drCAuajoKKo15OhaFouxR9oQJ8mFSMkWJFDkAJE72pjJxQZ93Dq2TVG6HOIhKyVA85LgvvAqud0f461X+z4olCqyj1Lg/f/THXNHQGciygTtcpftGzpPLge4JiX12MDD1uSsIQbqTwZ0teHRwfnUOQie4LA5JQZa18cu4LDMphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186729; c=relaxed/simple;
	bh=NlDZ2rH+LbKlAkfRNZz3L8fswfH0VB70Mkr1+QAxhZw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nNkpybZpltvaOhGON49upMWiq+SG/danoI/3YhDNgqOr6YWpdZ3qHxoU3FU4vBpGwrU/BHHbkMGx2EDV3+w4mjmNyb+tUHE5unk/ymOXUmxNjfLlwC59O66ghFwgV0g3eWvmdsSsHL/pGvXPZoQulAGh5yhHzsvD4HlvW8uEhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 296821A0750;
	Wed, 26 Nov 2025 19:52:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 3FA0835;
	Wed, 26 Nov 2025 19:52:03 +0000 (UTC)
Date: Wed, 26 Nov 2025 14:52:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] overflow: Introduce struct_offset() to get offset of member
Message-ID: <20251126145249.05b1770a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pax7rsgusba579mjaxc3433mg8341do7
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3FA0835
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/mm34VtAkbgLg82FU8lSjmw28+kTuy+Ps=
X-HE-Tag: 1764186723-559390
X-HE-Meta: U2FsdGVkX18aaAXOc/Dt9740Y+tJBpPHO/H6RWQ7cYAOtRwGsyyknE9zNZDMgltylD6oPVrJyvmxYEn1Yz94aOTEQK/Nx4+XWJifyIjMyRfC58E0p2FsGht/pDtDHPJCtyjqhiC6UZnSWtKfTahJTTrHaBXPrvI8Qc6uuqIVFkdm/2GQhI5YcM4Uu5KvhfY3uOtGrEAayYePROoClOHyKwFe/hKGM2BnTCFPYSodseFNckRWS1m80y678SeBw4plpz17+nIJr24+cWMC3DH6XvzFn6VawKWbMeAJZLT0cVUpaAPuB0cpHdyBLj6YzCHpw1zEmXEmXLdmdbdELBVpdTsGh3q/CnZ2PGmYdIRpk/oI90H9/cuQzfPA/Fsl7RQMRV93XpzxDSd1E/JmRddpOQYNhVl/nxSkC0KPg/EikIePi0htynms1nooFlic9ZB4W0YLPxO1HwaozsdWCurey5zuZHHhiau3biN8ys6pyUc=

From: Steven Rostedt <rostedt@goodmis.org>

The trace_marker_raw file in tracefs takes a buffer from user space that
contains an id as well as a raw data string which is usually a binary
structure. The structure used has the following:

	struct raw_data_entry {
		struct trace_entry	ent;
		unsigned int		id;
		char			buf[];
	};

Since the passed in "cnt" variable is both the size of buf as well as the
size of id, the code to allocate the location on the ring buffer had:

   size = struct_size(entry, buf, cnt - sizeof(entry->id));

Which is quite ugly and hard to understand. Instead, add a helper macro
called struct_offset() which then changes the above to a simple and easy
to understand:

   size = struct_offset(entry, id) + cnt;

This will likely come in handy for other use cases too.

Link: https://lore.kernel.org/all/CAHk-=whYZVoEdfO1PmtbirPdBMTV9Nxt9f09CK0k6S+HJD3Zmg@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/overflow.h | 12 ++++++++++++
 kernel/trace/trace.c     |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 725f95f7e416..736f633b2d5f 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -458,6 +458,18 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 #define struct_size_t(type, member, count)					\
 	struct_size((type *)NULL, member, count)
 
+/**
+ * struct_offset() - Calculate the offset of a member within a struct
+ * @p: Pointer to the struct
+ * @member: Name of the member to get the offset of
+ *
+ * Calculates the offset of a particular @member of the structure pointed
+ * to by @p.
+ *
+ * Return: number of bytes to the location of @member.
+ */
+#define struct_offset(p, member) (offsetof(typeof(*(p)), member))
+
 /**
  * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
  * Enables caller macro to pass arbitrary trailing expressions
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f59645ab5140..1f734e289368 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7649,7 +7649,7 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 	size_t size;
 
 	/* cnt includes both the entry->id and the data behind it. */
-	size = struct_size(entry, buf, cnt - sizeof(entry->id));
+	size = struct_offset(entry, id) + cnt;
 
 	buffer = tr->array_buffer.buffer;
 
-- 
2.51.0

