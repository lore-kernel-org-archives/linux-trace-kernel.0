Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D61946B3
	for <linux-trace-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729455931; cv=none; b=LnUNiTnLMA7IgTcsv0LypWikrlZlZLFeYG1LsqUUzTVp+TGZE66conmBjRH6AMCS6Zq0miPuq5Dt1IZvgZxxm/Y1YJIyyzNlRomG2i9CUz3BRXfv9hoq1CoHLERWQA8NGLaZxPoqWdMxnPZWDUVidsClfFlgrcNWWSEILtGAeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729455931; c=relaxed/simple;
	bh=/7szG3PAqfXzV8t7UG4JaXhWW4TfaX18M2awcP+JgBc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=HJV684GvO7mZSLjB8CycKWvCsDQZZ1P0FK+u9C74Pkt2VWsqqvouM71LfM64zc0VLCzIbbWLvWyGXnCsmXSOd9CMxltYGR3ziSPTol1aZZPGv+hnZqdWK6cmfSA0QD0XLaT+UbF4VX21Lj9DYpDn4/ktNPGLjzGq7Eq4n8VBSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=UyQs0tzQ; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="UyQs0tzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729455923; x=1729715123;
	bh=1F6nYZrULMrKSJtAH7AwqAAQMwKeUs78FTcF6trmiTA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UyQs0tzQrZ3yQt8yG4DDccXbjqbcVGq4L8lT4r1ccgD28kw/kTMaSwIbMt8ZAs0Af
	 oZZv/4TmMAoWW/ZN6dZ4sfJWKh/Sl7JmShpCaPAptHggiSK+V4sRst85r9nvu0+yvI
	 FY16AtL97oaIfav4zWgX4LqCFFaNxgnfJqTFkz5ZBz+2Bt7njCBI7phFpBkpRkOXRZ
	 Z0Fkpp0qJg83e+7yWhaNuuG6X/dztqQ7NJ8V5FBktwmnKn5Hm8BSZJ565v7ZPaa6d5
	 3xCjHjwMWus9TBH1iGVT8w637KWIHccROtlVNJL01fQfNkLn3hD1xe6v9HIl+ZJiKe
	 Gekh7HL4j3imQ==
Date: Sun, 20 Oct 2024 20:25:19 +0000
To: "tglozar@redhat.com" <tglozar@redhat.com>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
From: furkanonder <furkanonder@protonmail.com>
Subject: [PATCH 2/3] tools/rtla: Argument Parsing Improvements for timerlat
Message-ID: <x_30GAsXDRTJKsHZH73UXZcUTDzw9ZbtJr5PIgWHPE4S0tgExDPkI5iffNaVdyJNs3P9g3ss8h4shs196FGeu03akbDtC8M9G2ii4mPhzW8=@protonmail.com>
Feedback-ID: 14203677:user:proton
X-Pm-Message-ID: d8ea6ad2adff6d910e252f16f35351b81e918b3c
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The enhancements made to timerlat_load.py are aimed at improving the clarit=
y of argument parsing.

Summary of Changes:
- The cpu argument is now specified as an integer type in the argument
  parser to enforce input validation, and the construction of affinity_mask
  has been simplified to directly use the integer value of args.cpu.
- The prio argument is similarly updated to be of integer type for
  consistency and validation, eliminating the need for the conversion of
  args.prio to an integer, as this is now handled by the argument parser.

Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
---
 tools/tracing/rtla/sample/timerlat_load.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtl=
a/sample/timerlat_load.py
index 785e9a83539a..d7341ed5127a 100644
--- a/tools/tracing/rtla/sample/timerlat_load.py
+++ b/tools/tracing/rtla/sample/timerlat_load.py
@@ -25,13 +25,12 @@ import sys
 import os

 parser =3D argparse.ArgumentParser(description=3D'user-space timerlat thre=
ad in Python')
-parser.add_argument("cpu", help=3D'CPU to run timerlat thread')
-parser.add_argument("-p", "--prio", help=3D'FIFO priority')
-
+parser.add_argument("cpu", type=3Dint, help=3D'CPU to run timerlat thread'=
)
+parser.add_argument("-p", "--prio", type=3Dint, help=3D'FIFO priority')
 args =3D parser.parse_args()

 try:
-    affinity_mask =3D { int(args.cpu) }
+    affinity_mask =3D {args.cpu}
 except:
     print("Invalid cpu: " + args.cpu)
     exit(1)
@@ -44,7 +43,7 @@ except:

 if args.prio:
     try:
-        param =3D os.sched_param(int(args.prio))
+        param =3D os.sched_param(args.prio)
         os.sched_setscheduler(0, os.SCHED_FIFO, param)
     except:
         print("Error setting priority")
--
2.46.2

