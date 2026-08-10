Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215B3F926D;
	Mon, 10 Aug 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786399161; cv=none; b=hZXiyx/sL9oXgndl53N1enRtEZJKnaAchC4FkE8ECAcZ0LtC433KtKhcZUPB9glopt8llWzMD9tXq3wR76ZCe3K2OZbU3hE8/CYVG71PEit3d7QZgSIUc6CU2ZMof895rhq6MWDFwx6Q5frvyjpn4IgCkA6mxIwVuL9mdqt1xHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786399161; c=relaxed/simple;
	bh=/h/1nABPWjlguKlS0Bb3x2xTwZX9AjjBTfHlyHcCgD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DgupnL5xcyx/7tABog7g7Sx5bmtEsyfvc98X2oglUrkqnFH/Yc5F51rEmhrRp/jZ0vv9x+IEqMJzIjj3Z6Yor/A1Ds6XmbISEptui9TEcHVpeZ+LvSh6dZb0odLP3y+Ui2xuxEeGaXeEqBbVosSHIBNNQ7wkU609PV69Figoz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=rOLGboi2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFnZlSFQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="rOLGboi2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFnZlSFQ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 758327A00D7;
	Mon, 10 Aug 2026 17:59:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Aug 2026 17:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1786399158; x=1786485558; bh=jw
	a1uEHTAmH/Zps+yM13QKRK4H7f98othvWFyoUIXTc=; b=rOLGboi2oE9TRasfvZ
	JrUYMb2aMOPFqmqajtwPryZUcgRuUgiPSYMLZsuuqQzKJju/ArFfzV9TPtlZxKxy
	FrAaFEyLYDG6NiZDEbnR241YDqYSlWVoNih2GmAJtSIWeIFfV7vbg943cyf+nvxL
	FhPv/wfS5oyh5CPCZh6bWUhbdx2WX1wrbbHa+g0jiOkirLCweGJ+Lr04k8raymLj
	MRMf5aTffWJHoaNaDlx1LatfdP2+okI3C8hIhNb84jlOYlX54jrdH160M3c59N0H
	9s3c74Pk++lo9LfEgZeQBG6QCj9BBpErS3HormLJbwHBY0Ium7XErjmYdd8YNSSt
	LnsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786399158; x=1786485558; bh=jwa1uEHTAmH/Zps+yM13QKRK4H7f
	98othvWFyoUIXTc=; b=CFnZlSFQPhsZPUcO5I/2P2jWswBQBUT8ymak76N3XQR9
	z2zovvzYMVWaHfjZUUN0nSLDPVKPOOqitBj5cDZLL3n72XThwaVQUnnkErgn12ij
	gjgR8/o6deT8E1049f00Aqxcdu5p3+4ZYJC1+Pwcj3Cyg6XpD0VA2Xa/SwczUsdG
	EvYO4heLdpdUps1ubj3f0Iuj4s/+kJJXbpdUAVl69Bs0DcDHVSQHbF+stCqKArbf
	ad2r8IunPDHbypaN7GuHHNkIM6M62GRyfcYxLagvo6cjZEU1DCS86YAuLFX/XT/f
	edJLxFaSSVTYvmQhAWdsU+NUsh9AzU+K0wDLwlS5Dg==
X-ME-Sender: <xms:tkl6auXZvjSBQ0fzz6QzBhxB06_sHm6T_x9PbOYVtAeR-khqXdpYWg>
    <xme:tkl6aoaSQjs7hONlrSs0dTsnnfWiYNp53NxNlT01aEr7O_X9_RxYk0LiAtI236oLd
    fCUaYRpaQHhJRq1L6TozTOjLTWZ6vqJoR-UXNyWJ3OeJmIZ7Nx6Q6NH>
X-ME-Received: <xmr:tkl6as38xf8CjFA1kozUbN3XEyoaoEzU7pi_lGMDnV6yo8t55Uze4OdeMmOn1FqSuRq8r19E>
X-ME-Proxy-Cause: dmFkZTEGLOl/NxVtse1/8nPKU4ufmz8ZoTztOi1ed4RC0pZ71clEb6L2gJNAmbknbqy+Kx
    S7TGQeO3lzrvRrlERfRa7ziqOkPSl8adr97wKgLUBzHnggAbCKQ1ikw4O/h5u0aCPEq+vX
    4V2kJcVC/lAyrK+4WR6RCtqLn5E4XaFrn5x+qmj9/5gPOO8myz56vU7mGNVBqeXCYmLuI/
    5dPUw1Lp8CFtnDK6feBV14EZrvt0SBoT7Joh9pf58IZgQxiCqf5ygmghwQn4y+p6d3gz4l
    q9f1gvgKOHyQCdr7wob/GRlft7MiayXh1MC5TOw9PdPw48nraWp1vm7R+Tnwt05E0hcGI7
    rmN3s8iXtYny3j3uNm22avGaJdH+gkqlxYTX6rWE3pPITAUm7Z5ZKZ3YOSbJCV5cnKY8nI
    ZkCHGTrIh4vJnNlQ7HOvGqb+fLoF1lF4JZ7m9VhgOXMRN2GggAulg/4Z1yWHkWB039EmeV
    0JHOb4huRr11qlu5mPZVqO9hyUd5Iex5DGQ4O4DIg00HxbRyJSSC6ZrHWnMjeSEikzPSnW
    Fo5an3SDrv3sWbn0mRF6B+w1nXwV5jXcoSeIx6Ing3z6uSFJTkrbR19zsaJEp3Rz3ihckP
    L8CFax9G0085vvx3IIWJXBSKQdpqKQQ6dt/kGfgpNAUlqbtJOPjZ/GA9vZIg
X-ME-Proxy: <xmx:tkl6aigf_-lUkASKbQMxPbf5ZCyYIrOLfrGnba3F1PZwHBtBUsPn9Q>
    <xmx:tkl6aoZHachloicX91urr-tdOwVdD-kg1_FrEofpN0O9YML5bKI8pw>
    <xmx:tkl6aqS-yingntqjJ_mmAWS4DZS7dFSSTnXpm598TdSucsbUEPDWoA>
    <xmx:tkl6arQW3Yzdvo-Qi_vDemi57_bpYtiMqL8EGmyPc5WjTKCsQMWk0Q>
    <xmx:tkl6alEWskU6BOh4PZ4aUy42OOkA4hJJalqw6jh9cgvKmzxKD_uz9AqO>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 17:59:17 -0400 (EDT)
Date: Mon, 10 Aug 2026 17:59:28 -0400
From: Steven Rostedt <steven@rostedt.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] eventfs: Add warning for out of bounds pos in
 __eventfs_iterate()
Message-ID: <20260810175928.5f4d9d5c@gandalf.local.home>
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

Sashiko has complained about out of bounds issues if ctx->pos isn't what
is expected in __eventfs_iterate()[1]. This would be an issue if the logic
that calls __eventfs_iterate() didn't already prevent the code from going
out of bounds.

The issue Sashiko brings up is if a user uses lseek64() to put in a
position like 0x100000000 which will overflow the integer used to iterate
the files. This should never be an issue because both tracefs and eventfs
uses the default "maxbytes" for its superblock "s_maxbytes" field which is
defined as:

  fs/super.c:     s->s_maxbytes = MAX_NON_LFS;
  include/linux/fs.h:#define      MAX_NON_LFS     ((1UL<<31) - 1)

Where MAX_NON_LFS turns into 0x7fffffff.

Testing this with code to try to pass 0x100000000 to lseek64() to a
eventfs directory returns -EINVAL.

But relying on logic for the integrity of a function is not very robust.
Add a WARN_ON_ONCE() in case the ctx->pos is out of the expected range.

[1] https://sashiko.dev/#/patchset/20260810160708.3460a2fd%40gandalf.local.home

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index be21b8510c14..ee5d03e403ec 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -696,6 +696,10 @@ static int __eventfs_iterate(struct file *file, struct dir_context *ctx, bool ro
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
 		return -EINVAL;
 
+	/* Logic should prevent ctx->pos from going out of range */
+	if (WARN_ON_ONCE(ctx->pos < 2 || ctx->pos > 0x7fffffffULL))
+		return -EINVAL;
+
 	c = ctx->pos - 2;
 
 	guard(srcu)(&eventfs_srcu);
-- 
2.53.0

