Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D113F2F43
	for <linux-trace-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729454514; cv=none; b=YNk2UqtzmMh5dTHNkWFmKjLuA9uLqx7tmh+BRF7mfsxtJi2QbuCJCgS1Joe17nSNhpJsFveUOdGmLLOmfr+oG+bbuGdy+53+6RVbhb5iuIvoD7XT0W67fbxCKh5gpU6EaBgJMS/Q2QwAx+tzDAt0zkUyzVoBJLKa8vMZGrYjcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729454514; c=relaxed/simple;
	bh=OAKnrF9PbQPXN2zL+sd729+YEGzaw2BAleB0dTwGd8Q=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=PN4m0mi+/RsXia+KBLW6wxIFElIk/rY9dI6HlWR4tzhTeO/LqkV5ju1DuDjnV1EyS19T/642VpfW6a0MvKGG2QYp/fQyLIlK5rSwgeVak2f1067+/saKKBOr6dcWZU04gLq3HxCFwmyop9R0uikJsrLPfCgs4G2T9/1K2Qff2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=jIfybhkc; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="jIfybhkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729454504; x=1729713704;
	bh=l+mvs6tC4XZj5bklobGjgot0p9GYS0+sFbq/olZPyME=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jIfybhkc80b29/JkxxkVeNjeRU2D965FOaKfMbeXWObmKEf4aRm4soZV0RTBrribv
	 s2HC7Bgb2BeK4yNNLsu/+YGB/ihpRtg/n39Z6aSRW1u1JzPtaLScxcxpTaYMM7bjuj
	 CtTFyLJc6E0fv8oz1KMThiwvVFsgHDfZrSjcyEYMy+1/3myovMqOYp2BWuGd5tToQD
	 YADxqBNQtPhvgWxh5yMry2aYK83WCrH+5ILuInuAmBOtP7NaBI4sXDcqbGw0j2EfiC
	 BkkhQi9yZw6VGAZxSkEqhtiJyfx72yFt4qsiUl/UfpauChwaPs3YAYVIVq3IoWPcvi
	 S9KhMDMykRpRQ==
Date: Sun, 20 Oct 2024 20:01:42 +0000
To: "tglozar@redhat.com" <tglozar@redhat.com>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
From: furkanonder <furkanonder@protonmail.com>
Subject: [PATCH 1/3] tools/rtla: Code Cleanup and Readability Improvements for timerlat
Message-ID: <I89kxpG3ElxMtO0ctkqvwK_7e-aVqnL2_bprS5snA3hgizDIw-76cJI6Vm4luKoVGwdRtAoHcYnxuYrzEPsMeqipZTYao5fGFs3b1ZTCQRY=@protonmail.com>
Feedback-ID: 14203677:user:proton
X-Pm-Message-ID: ddc41bc2ce8c440d0bc5c9291b012c49fabf967e
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
