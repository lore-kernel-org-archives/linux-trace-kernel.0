Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA11E7677
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523398; cv=none; b=FmpQ21xd1FCeYFUCzgn7xvZWkI2xqODk20FZg+dN8bOA589lrJKy7sIgST45kCNxPvfGaok8kLtwiama9vfzzcutaHJJ9a8vNiactpfwJYA2ijt3QyWO416tS+NrSB4J1O21nlpgBkMMl783SAOXKZ1l/ApOJYpkB5fusP8CtMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523398; c=relaxed/simple;
	bh=OAKnrF9PbQPXN2zL+sd729+YEGzaw2BAleB0dTwGd8Q=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Y4g3q+Y55HUlTBUa0vtip4dN3gFV654nyis1jllFaA4WQa+OqhGz/5xGB5/pcNceLUWpIXMKY3JeS8bbwUdV10uKR0D3po7ncBQjspvXaEZGMzq2yiD+XiTnmbPHS/gSBp90pvGiPDpFjloOCwFsXnRaUZs5uOv3L7oD7A0eYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Hc/JGGax; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Hc/JGGax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729523394; x=1729782594;
	bh=l+mvs6tC4XZj5bklobGjgot0p9GYS0+sFbq/olZPyME=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Hc/JGGaxsC1Oy3viwo1hbbhkq0sDRm/xKHFwt4idGxHa+Rcig8kXkKsd0mRDUNrzS
	 x8yyZyX5pqG63HMypG+TPhgW300VdLf/4/nYNZ2rZGMOjGT9XYJcJXhA2QPQGMFZaJ
	 0j0CSD9XOwChxnq94LdYTAXL9g12BKwRY3dbKEUuHEdCaoWX5vPwmQ1gRKC3PkBAZy
	 YEvZBzTJ57ksvxX+LVrvTjgbxHGKilE+08VBmXa5ZbFd3SD2yjbpmncahzV9IDtjXe
	 TmIfJVLpFXed3ZifGBY96cElYSMulTjN9LMFcRi3pqmYIhXsmwger4eKeyaaFJ88jV
	 giudi25wKRdVQ==
Date: Mon, 21 Oct 2024 15:09:49 +0000
To: Steven Rostedt <rostedt@goodmis.org>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, "jkacur@redhat.com" <jkacur@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>
From: furkanonder <furkanonder@protonmail.com>
Subject: [PATCH 1/3] tools/rtla: Improve code readability in timerlat_load.py
Message-ID: <j2B-ted7pv3TaldTyqfIHrMmjq2fVyBFgnu3TskiQJsyRzy9loPTVVJoqHnrCWu5T88MDIFc612jUglH6Sxkdg9LN-I1XuITmoL70uECmus=@protonmail.com>
Feedback-ID: 14203677:user:proton
X-Pm-Message-ID: 7cbe195337aa8ca8787a18a32bfba264c3c7ff9c
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The enhancements made to timerlat_load.py are intended to improve the
script's robustness and readability.

Summary of the changes:
- Unnecessary semicolons at the end of lines have been removed.
- Parentheses surrounding the if statement checking args.prio have been
eliminated.
- String concatenation for constructing timerlat_path has been replaced
with an f-string.
- Spacing in a multiplication expression has been adjusted for improved
clarity.

Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
---
 tools/tracing/rtla/sample/timerlat_load.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtl=
a/sample/timerlat_load.py
index 8cc5eb2d2e69..785e9a83539a 100644
--- a/tools/tracing/rtla/sample/timerlat_load.py
+++ b/tools/tracing/rtla/sample/timerlat_load.py
@@ -37,12 +37,12 @@ except:
     exit(1)

 try:
-    os.sched_setaffinity(0, affinity_mask);
+    os.sched_setaffinity(0, affinity_mask)
 except:
     print("Error setting affinity")
     exit(1)

-if (args.prio):
+if args.prio:
     try:
         param =3D os.sched_param(int(args.prio))
         os.sched_setscheduler(0, os.SCHED_FIFO, param)
@@ -51,21 +51,21 @@ if (args.prio):
         exit(1)

 try:
-    timerlat_path =3D "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.cpu=
 + "/timerlat_fd"
+    timerlat_path =3D f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu}/=
timerlat_fd"
     timerlat_fd =3D open(timerlat_path, 'r')
 except:
     print("Error opening timerlat fd, did you run timerlat -U?")
     exit(1)

 try:
-    data_fd =3D open("/dev/full", 'r');
+    data_fd =3D open("/dev/full", 'r')
 except:
     print("Error opening data fd")

 while True:
     try:
         timerlat_fd.read(1)
-        data_fd.read(20*1024*1024)
+        data_fd.read(20 * 1024 * 1024)
     except:
         print("Leaving")
         break
--
2.46.2
