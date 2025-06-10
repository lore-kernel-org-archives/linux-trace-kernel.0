Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E728BAB6;
	Tue, 10 Jun 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548647; cv=none; b=l8XEKdB3P0rLk7o4n/OW44S18PMRmf2Q1dXYEIlFs+UfZ2LBr2vUfL3QkAc+9+Eav+mFzQm7XD5zUBYLYntMbnsvqzB+5G//isUPJDYqTJ+dHsWJ60Hy58C/9x0ZByE0NdR0f7HAMD+yhGhYrSuo1Te7cGEhMetOA4hPPjQzoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548647; c=relaxed/simple;
	bh=0pcIVQsnceSmD+COEwkoiVF32ZriwZ7An8h/Q2mguEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjjztDDMGPpCGyUvRq23UpjO7XvxO08GKCNA89LNL9odYzE9FubrZjPUaduwIhCAe6vwEWztuELqp3FmOxRdJmatxnJECryaxoDThL772iQ/2YFwN26L1MVjSNB5HfNXOY8An2wPkDg/CjpgQvcgugttAagQDYq7YHMko09Ex3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g4KVO2oi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E/i2/1et; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g4KVO2oi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E/i2/1et"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749548643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxC6nW71oZ3G8dVWEcIr6r3HM13C1r5lXALXmLxnAZU=;
	b=g4KVO2oipAycGbytAZT5ViUL+VIDvPAX0KkH7bSz3PVvZ9YxxAh0HVDIxg5qAOIKOxlINf
	WJj98YQ8crZYP/Mrr3ljbSm+B3DTXjt1LY01aH0a9kWR+abXfylMn6oMlgd2o7nFOdzUof
	vGMbbaLvwUKOJlm02D62fs+kA+lR8t4BEhU28Tw2+YmGyI/uYDeIdu9aYLhnvlG9+fDzKh
	RPxbyBs0eU6I+usU6xxZ4rx992fgLCVDrUv17kcpi/t0hHesHRdoOHpch7Lk312Owgf2WS
	n2nPDfgq9XjtbfPAt0PxV61RXYdzty5qsq8nhXDYJfb3IPi1zPTWzQSIqJxLRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749548643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxC6nW71oZ3G8dVWEcIr6r3HM13C1r5lXALXmLxnAZU=;
	b=E/i2/1etPM7vYxE5EANf2fUf4MlQ5+q9jqTURDJ9Nr5x4ZnvDaGuFaqkmzCBIEr30zB6LB
	NkIQarswrOl5x8CA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v10 07/19] verification/dot2k: Replace is_container() hack with subparsers
Date: Tue, 10 Jun 2025 11:43:32 +0200
Message-Id: <f2ee5eab3fd27b0f4f1bb49ff33c1d971dac78ca.1749547399.git.namcao@linutronix.de>
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

dot2k is used for both generating deterministic automaton (DA) monitor and
generating container monitor.

Generating DA monitor and generating container requires different
parameters. This is implemented by peeking at sys.argv and check whether
"--container" is specified, and use that information to make some
parameters optional or required.

This works, but is quite hacky and ugly.

Replace this hack with Python's built-in subparsers.

The old commands:

  python3 dot2/dot2k -d wip.dot -t per_cpu
  python3 dot2/dot2k -n sched --container

are equivalent to the new commands:

  python3 dot2/dot2k monitor -d wip.dot -t per_cpu
  python3 dot2/dot2k container -n sched

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/dot2/dot2k    | 37 +++++++++++++++++---------------
 tools/verification/dot2/dot2k.py |  2 +-
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 767064f415e76..133fb17d9d475 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -13,30 +13,33 @@ if __name__ =3D=3D '__main__':
     import argparse
     import sys
=20
-    def is_container():
-        """Should work even before parsing the arguments"""
-        return "-c" in sys.argv or "--container" in sys.argv
-
     parser =3D argparse.ArgumentParser(description=3D'transform .dot file =
into kernel rv monitor')
-    parser.add_argument('-d', "--dot", dest=3D"dot_file", required=3Dnot i=
s_container())
-    parser.add_argument('-t', "--monitor_type", dest=3D"monitor_type", req=
uired=3Dnot is_container(),
-                        help=3Df"Available options: {', '.join(dot2k.monit=
or_types.keys())}")
-    parser.add_argument('-n', "--model_name", dest=3D"model_name", require=
d=3Dis_container())
     parser.add_argument("-D", "--description", dest=3D"description", requi=
red=3DFalse)
     parser.add_argument("-a", "--auto_patch", dest=3D"auto_patch",
                         action=3D"store_true", required=3DFalse,
                         help=3D"Patch the kernel in place")
-    parser.add_argument("-p", "--parent", dest=3D"parent",
-                        required=3DFalse, help=3D"Create a monitor nested =
to parent")
-    parser.add_argument("-c", "--container", dest=3D"container",
-                        action=3D"store_true", required=3DFalse,
-                        help=3D"Create an empty monitor to be used as a co=
ntainer")
+
+    subparsers =3D parser.add_subparsers(dest=3D"subcmd", required=3DTrue)
+
+    monitor_parser =3D subparsers.add_parser("monitor")
+    monitor_parser.add_argument('-n', "--model_name", dest=3D"model_name")
+    monitor_parser.add_argument("-p", "--parent", dest=3D"parent",
+                                required=3DFalse, help=3D"Create a monitor=
 nested to parent")
+    monitor_parser.add_argument('-d', "--dot", dest=3D"dot_file")
+    monitor_parser.add_argument('-t', "--monitor_type", dest=3D"monitor_ty=
pe",
+                                help=3Df"Available options: {', '.join(dot=
2k.monitor_types.keys())}")
+
+    container_parser =3D subparsers.add_parser("container")
+    container_parser.add_argument('-n', "--model_name", dest=3D"model_name=
", required=3DTrue)
+
     params =3D parser.parse_args()
=20
-    if not is_container():
-        print("Opening and parsing the dot file %s" % params.dot_file)
     try:
-        monitor=3Ddot2k(params.dot_file, params.monitor_type, vars(params))
+        if params.subcmd =3D=3D "monitor":
+            print("Opening and parsing the dot file %s" % params.dot_file)
+            monitor =3D dot2k(params.dot_file, params.monitor_type, vars(p=
arams))
+        else:
+            monitor =3D dot2k(None, None, vars(params))
     except Exception as e:
         print('Error: '+ str(e))
         print("Sorry : :-(")
@@ -45,7 +48,7 @@ if __name__ =3D=3D '__main__':
     print("Writing the monitor into the directory %s" % monitor.name)
     monitor.print_files()
     print("Almost done, checklist")
-    if not is_container():
+    if params.subcmd =3D=3D "monitor":
         print("  - Edit the %s/%s.c to add the instrumentation" % (monitor=
.name, monitor.name))
         print(monitor.fill_tracepoint_tooltip())
     print(monitor.fill_makefile_tooltip())
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot=
2k.py
index 0922754454b9c..9ec99e297012a 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -19,7 +19,7 @@ class dot2k(Dot2c):
     monitor_type =3D "per_cpu"
=20
     def __init__(self, file_path, MonitorType, extra_params=3D{}):
-        self.container =3D extra_params.get("container")
+        self.container =3D extra_params.get("subcmd") =3D=3D "container"
         self.parent =3D extra_params.get("parent")
         self.__fill_rv_templates_dir()
=20
--=20
2.39.5

