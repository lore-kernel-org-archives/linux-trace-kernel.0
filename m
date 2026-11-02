Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620728;
	b=qR/uwZwp3dDnQj3pdqx39ISPURK04rmWVkWqWmmOJgxAsLVYHQFSmzwZ4rUaKhjg4Ir7
	 lgZf0upNKWrv9+4kH+Tcw7VD7VYEr34lSoG9zO531tBq2uvGn4UdKFVLL1RZUnRg+vjqe
	 tZQ0XyXbdTSQDF+3W4RqMexeTY6z68T/qm6Av4qJX5Vr4ohKa3XtFlvnNp31NVbA+opQo
	 Oy3yjzUAHviJ3N0r/AOO8Q3PS/LInETTHuYDSLJ7Ce+QsYbGglwbXBbGJq3jWgMiJC13D
	 UzgCWPOwDUBYYRnZeVJyiEgSiWvINhf48jNRz3Tq5H3AGOkeUHlnUBi7ogbXg1a4T8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620728;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=HMxFwjFZqjOSE+xFNdq2GdyfZs+3kf8RioPk+uA4rn8=;
	b=E3DRtZlrGEjrMkIDGTWPIJCnVK6T7Usoc7yNHy85YiMhsK9nYUj5LgozssyA1//2qQqO
	 sAnVguSqU8lNVGD7O3T3J5jm03F4nA8ncw0kxuD2U96HYekFUJHRWJS6ng9/rzzCzdoFF
	 8GBmyL8hvPe9qh7jubrzkz1VqsHmQrb65r+bgBWMzHwY3DB/FVxEse02RDnGSJeflinV5
	 aItQaTiNhIK51FJjVCL0DjO7FpFr+L+h2vVAy25GANzU0FOHF5x+Z98599Sy/77IrOxia
	 p5IMF70ibEVW6G+LkVg9f0cW1yt+mVGh0oXCltv1NBepsium8996VplT6oFeCCh1qfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b="BIt+TZ/x";
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC2B60A260E;
	Mon,  2 Nov 2026 11:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC2B60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=BIt+TZ/x
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b234f;
	Mon, 2 Nov 2026 19:58:44 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071771.29269.8333068920166316746@stu.pku.edu.cn>
Subject: [PATCH 2/2] tracing/user_events: reject overflowing field offsets
In-Reply-To: <179362071771.29269.15129360535376085397@stu.pku.edu.cn>
References: <179362071771.29269.15129360535376085397@stu.pku.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c204a4703a2kunmab045f0fe84e7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0lKVh5KSEJMSkMeSUtCSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=BIt+TZ/xY7atvK1uGjPCg10TCYLu3lUd1dn4nDdzHOvfVEW4eiit+q+4jlfQ6G3oAVZIqolWZZdNG7KjED7HwgtO4Tv1CmWgu5FnE6DJyjSiydAkDL8vD7unu0WGTKtbqlKGuc5AOYSLi+iAX6sldSJ9cBGyBFtfN6fzyh9BdtU=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=HMxFwjFZqjOSE+xFNdq2GdyfZs+3kf8RioPk+uA4rn8=;
	h=date:mime-version:subject:message-id:from;

user_event_parse_field() accepts large structure sizes but accumulates
field offsets in a u32 before storing them in signed int fields.  A
declaration can wrap the recorded minimum event size while a fixed-width
field retains an offset outside the accepted record.  A short write is
then accepted and a field filter reads beyond the event buffer.

KASAN reports:

  BUG: KASAN: slab-use-after-free in filter_match_preds
  Read of size 8
  filter_match_preds
  trace_event_buffer_commit
  user_event_ftrace
  user_events_write_core

Use checked addition and reject offsets that cannot be represented by the
downstream signed fields.

The patched kernel rejects the overflowing declaration and accepts a valid
control event without a KASAN report.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into f=
trace")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 kernel/trace/trace_events_user.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_use=
r.c
index 85938b45b7618..88d384c9e101f 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1207,6 +1207,7 @@ static int user_event_parse_field(char *field, struct u=
ser_event *user,
 {
 	char *part, *type, *name;
 	u32 depth =3D 0, saved_offset =3D *offset;
+	u32 new_offset;
 	int len, size =3D -EINVAL;
 	bool is_struct =3D false;
=20
@@ -1287,7 +1288,11 @@ parse:
 	if (size < 0)
 		return size;
=20
-	*offset =3D saved_offset + size;
+	if (check_add_overflow(saved_offset, (u32)size, &new_offset) ||
+	    new_offset > INT_MAX)
+		return -E2BIG;
+
+	*offset =3D new_offset;
=20
 	return user_event_add_field(user, type, name, saved_offset, size,
 				    type[0] !=3D 'u', FILTER_OTHER);
--=20
2.39.5 (Apple Git-154)
