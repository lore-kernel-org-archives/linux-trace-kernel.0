Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E2EEB3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523557; cv=none; b=pM7OBkY3vnm3Hf454u9K5AiZD7yY92DItQWXlvbswgWfsDlS1ebZQqWcSJ+HYEcFGzpBgFfPMyVy6BOZ1U0FV9Lt5p9daciSnMfS2dkR3dZlDrj/gfaCXB6HY5qIG2vol6DhBYwDgJHkqHFzaMVxgiO8D1/HCsd3kNhZLF6UBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523557; c=relaxed/simple;
	bh=/7szG3PAqfXzV8t7UG4JaXhWW4TfaX18M2awcP+JgBc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Z6moezD4DeENzDlb1STaEeLhTPFfoJuBwojql+3K2MROe4XT/9go4enSBf5RntFQOdprQcPTVIDTc+Gt8to3QviCIXmQJCkj4O7vP9wkR8ZXNvC3ntJglEfldsgM2WkEDN7CS4ka3WfVSwxoKxIqHGZMc4DlCUH/mUN2CsEjXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=GhfqOiPp; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="GhfqOiPp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729523553; x=1729782753;
	bh=1F6nYZrULMrKSJtAH7AwqAAQMwKeUs78FTcF6trmiTA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GhfqOiPpwTF6iKZtesj/e98Zv11V5PN4594go76xxNq1k7Bt6SVBskgIRQkqbu+7t
	 mezXdw2xEZ+lm6En1DOYQEe0uA/NgLdpXfIsl7Wf48J4PUM7u/ntRsY0XL8QK8VgQ+
	 DYkhIWv5NAJij0grznoJJb51odRqP/3naggf15OWMJZ+Sux87dYWdd3HZFnmbToXy+
	 7SomkfI+XykW4bgvjfXk8PHDkoLHOBQ5P8FTE3HksF42GMaMAhBhQY57WhdNgp+hme
	 5sykoA1rhKRoxuJ5b9vIcdLOYIbXzQEBK3O7lZX+wdBDq4RDwoM5FZDnWYDqSwCPdJ
	 w8PvWfC54HHDw==
Date: Mon, 21 Oct 2024 15:12:30 +0000
To: Steven Rostedt <rostedt@goodmis.org>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, "jkacur@redhat.com" <jkacur@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Tomas Glozar <tglozar@redhat.com>
From: furkanonder <furkanonder@protonmail.com>
Subject: [PATCH 2/3] tools/rtla: Enhance argument parsing in timerlat_load.py
Message-ID: <QfgO7ayKD9dsLk8_ZDebkAV0OF7wla7UmasbP9CBmui_sChOeizy512t3RqCHTjvQoUBUDP8dwEOVCdHQ5KvVNEiP69CynMY94SFDERWl94=@protonmail.com>
Feedback-ID: 14203677:user:proton
X-Pm-Message-ID: 2fe6d93847a806265c7ac52074f461d0af11be54
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
