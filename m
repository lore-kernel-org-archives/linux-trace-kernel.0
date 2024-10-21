Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FD1F9AAA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523644; cv=none; b=qOZskcJTxcg2CDWPU50pqoJTDU4makfUBwSGjcJKc+1Tfc/K4fEbnsscU7xKtquQz9wVTiJxnhm7WZp9Vgt2J+rl8lQhFPA6T+MAdvUQHWddF7kwDC5rHzhReJxpPgRbYgSRvlwk92E7TjcrRrHdFt6n94ji2d+WoOvB2WucsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523644; c=relaxed/simple;
	bh=WqwyJPFrX14EIYPb8NlDkhijgJLXM1i58qlxJzwdzUI=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Hp8RcWImTaXMKhL1rFQ1HoE+VcmmWbeUe++EBV82OuJBxAvlofCzdNpa2g2bVw9m9e4xENJAmJtRSRoggOegetyNqzFPPO2PLGpEA5f4Ch/6oTd8gFCLiISKXNDRM6k2c/bPPVg3xdCACZWIIHiS0zw3ONO+sHTei+GY4ruIWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LM42rcxd; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LM42rcxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729523641; x=1729782841;
	bh=PVPeEX/Ul854Zb5vevT8sNbYHxTrQfiI9hsvWrSh50U=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LM42rcxdqSbt1ZMdTDHIa/ea9frAWDq/1bwYrFGoyUZ5I1k1aTC8UPQqEeQaBFydz
	 SbN9jJlJP4Y+8eF5s+vOXJIs6FkT9CEp8bgZStO8fCAlX7YgQXCJqvEXgbwFiWbei7
	 OErSlyrgvmQzUgzvfUzUH6vnqIjDOTFXYlI+6w5YNbm7QG/cUXrT/0N/wE5OqsAF+q
	 ixWowGhxOJCjpFeDFHF3O3EasqNjl9t3dbQapCB0sCP3ZWFbIjVYOzQuFcoag8nMhh
	 eStAkeXFASJzu1hXAYitee7f6xkYAQuFct+BEXWEmCWppah3WaVB8NVA2W4vFu28Xg
	 Wwb2q9uUmsKKw==
Date: Mon, 21 Oct 2024 15:13:57 +0000
To: Tomas Glozar <tglozar@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, "jkacur@redhat.com" <jkacur@redhat.com>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
From: furkanonder <furkanonder@protonmail.com>
Subject: [PATCH 3/3] tools/rtla: Improve exception handling in timerlat_load.py
Message-ID: <Q_k1s4hBtUy2px8ou0QKenjEK2_T_LoV8IxAE79aBakBogb-7uHp2fpET3oWtI1t3dy8uKjWeRzQOdKNzIzOOpyM4OjutJOriZ9TrGY6b-g=@protonmail.com>
Feedback-ID: 14203677:user:proton
X-Pm-Message-ID: 7be97eec64c3fdebc1d45f9ab1d692f0aa8623d1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The enhancements made to timerlat_load.py are intended to improve the scrip=
t's exception handling.

Summary of the changes:
  - Specific exceptions are now caught for CPU affinity and priority
    settings, with clearer error messages provided.
  - The timerlat file descriptor opening now includes handling for
    PermissionError and OSError, with informative messages.
  - In the infinite loop, generic exceptions have been replaced with
    specific types like KeyboardInterrupt and IOError, improving feedback.

 Before:
    $ sudo python timerlat_load.py 122
    Error setting affinity
 After:
    $ sudo python timerlat_load.py 122
    Error setting affinity: [Errno 22] Invalid argument

 Before:
    $ sudo python timerlat_load.py 1 -p 950
    Error setting priority
 After:
    $ sudo python timerlat_load.py 1 -p 950
    Error setting priority: [Errno 22] Invalid argument

 Before:
    $ python timerlat_load.py 1
    Error opening timerlat fd, did you run timerlat -U?
 After:
    $ python timerlat_load.py 1
    Permission denied. Please check your access rights.

Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
---
 tools/tracing/rtla/sample/timerlat_load.py | 37 +++++++++++++++++++++-----=
-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtl=
a/sample/timerlat_load.py
index d7341ed5127a..a819c3588073 100644
--- a/tools/tracing/rtla/sample/timerlat_load.py
+++ b/tools/tracing/rtla/sample/timerlat_load.py
@@ -31,43 +31,48 @@ args =3D parser.parse_args()

 try:
     affinity_mask =3D {args.cpu}
-except:
-    print("Invalid cpu: " + args.cpu)
-    exit(1)
-
-try:
     os.sched_setaffinity(0, affinity_mask)
-except:
-    print("Error setting affinity")
-    exit(1)
+except Exception as e:
+    print(f"Error setting affinity: {e}")
+    sys.exit(1)

 if args.prio:
     try:
         param =3D os.sched_param(args.prio)
         os.sched_setscheduler(0, os.SCHED_FIFO, param)
-    except:
-        print("Error setting priority")
-        exit(1)
+    except Exception as e:
+        print(f"Error setting priority: {e}")
+        sys.exit(1)

 try:
     timerlat_path =3D f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu}/=
timerlat_fd"
     timerlat_fd =3D open(timerlat_path, 'r')
-except:
+except PermissionError:
+    print("Permission denied. Please check your access rights.")
+    sys.exit(1)
+except OSError:
     print("Error opening timerlat fd, did you run timerlat -U?")
-    exit(1)
+    sys.exit(1)

 try:
     data_fd =3D open("/dev/full", 'r')
-except:
-    print("Error opening data fd")
+except Exception as e:
+    print(f"Error opening data fd: {e}")
+    sys.exit(1)

 while True:
     try:
         timerlat_fd.read(1)
         data_fd.read(20 * 1024 * 1024)
-    except:
+    except KeyboardInterrupt:
         print("Leaving")
         break
+    except IOError as e:
+        print(f"I/O error occurred: {e}")
+        break
+    except Exception as e:
+        print(f"Unexpected error: {e}")
+        break

 timerlat_fd.close()
 data_fd.close()
--
2.46.2
