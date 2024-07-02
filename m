Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B676E5ED;
	Tue,  2 Jul 2024 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948837; cv=none; b=J53PIw2EqiIgHzbdPUL6ODz16lSUfCi8Gg0/kf1ST1olfP9Hu8X9MBWueN+oQSYn17JpD9HzNdB3JEiv+K9YQRm0albBoTOS43MPmc4zw7RVE4rujrvDSkOx0a5/Y1oLTl0Rf8r+nCLVwIMIsHZ+6zPwtQSG9GysUeGLfJA08L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948837; c=relaxed/simple;
	bh=BSoQXcEkIVVku/MTyTc3Nu0S/1SsP+ErNDDqvBvByL4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SeZUj9klppUSe0I/LGt1Zg/2cjoRiR7xdou73puQ+deP1zbjk4MvX5yP7MY6+VqCr6Vdvgr3vQXqCelfMD7dpe0tb8T/uKrv6uN9nRbObTO0Zh7N83XG8atN2ZiBs5fIsHV2urDWVwcCJIU1oCr54ZpvoOyNQ6LGN3i2Rs7JBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F1FC116B1;
	Tue,  2 Jul 2024 19:33:55 +0000 (UTC)
Date: Tue, 2 Jul 2024 15:33:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Dmitry V. Levin" <ldv@strace.io>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] tracing: Have memmapped ring buffer use ioctl of "R" range
 0x20-2F
Message-ID: <20240702153354.367861db@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

To prevent conflicts with other ioctl numbers to allow strace to have an
idea of what is happening, add the rang of ioctls for the trace buffer
mapping from _IO("T", 0x1) to the range of "R" 0x20 - 0x2F.

Link: https://lore.kernel.org/linux-trace-kernel/20240630105322.GA17573@altlinux.org/

Reported-by: "Dmitry V. Levin" <ldv@strace.io>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 include/uapi/linux/trace_mmap.h                    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d..9a97030c6c8d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -186,6 +186,7 @@ Code  Seq#    Include File                                           Comments
 'Q'   all    linux/soundcard.h
 'R'   00-1F  linux/random.h                                          conflict!
 'R'   01     linux/rfkill.h                                          conflict!
+'R'   20-2F  linux/trace_mmap.h
 'R'   C0-DF  net/bluetooth/rfcomm.h
 'R'   E0     uapi/linux/fsl_mc.h
 'S'   all    linux/cdrom.h                                           conflict!
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index bd1066754220..c102ef35d11e 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -43,6 +43,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
-#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('R', 0x20)
 
 #endif /* _TRACE_MMAP_H_ */
-- 
2.43.0

