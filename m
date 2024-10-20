Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558045025
	for <linux-trace-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729459198; cv=none; b=NQtCd7ZUJ3xQs51COBmML24lesc+g9jx6Xa884C40q378dJ73eB9qTa0o+xwib8SjqaksI5qo2ZRYz73mrNlTeErsiIcCGTcYXfG19Qittr3Y0IuFqP3znWGyF/QD7uNiXt1YB7fxjtUOxBrE14Z24v9RKX/mmxi3LJsNjldtHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729459198; c=relaxed/simple;
	bh=WqwyJPFrX14EIYPb8NlDkhijgJLXM1i58qlxJzwdzUI=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=nXlRx4mYVY5p1RTUCj94g5EKonP31RBwmHcQrYqtrOpbGRlwr2nWoMJeSqG3TM4E7BF/ULVR6pOK5E2EblYG3ilktqGVjjrtlotMlU5PJ6TZcJPmBB6MrvfK2kM72coqAdEXSWbFB+ZLFmI/H+e/i7npicAReM3JtWuhiKlFc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=uL+82ctX; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uL+82ctX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729459194; x=1729718394;
	bh=PVPeEX/Ul854Zb5vevT8sNbYHxTrQfiI9hsvWrSh50U=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uL+82ctXixZinCk1Z5z5cIV9NGZEnKwDwPvpjkFawest3pCl33DxXER5xQS8sYvuc
	 8Qq97wJ+2BxzerT/yaERo1HkD7OkiVP8GDVhHjln7t8I5Dz0z6xtpL7E0UkYdXjFug
	 qNcFpqJj/dO0pARiViBbfyuABNQXjZqN4WqsSNITaBs8y8dYa9n1FEpua2y7o08nF1
	 o4jmFhR4p0X6g5YHsMFiqOiuxDnSOBw8NWrru38Hbiy9V81T2SICLD7DHUYXruk55F
	 i5eDRBVjGzbC/GjakgxLbUPwW3XDmp3m5oXtzId5pnfo4hSiK1Gnv7281NfZKM6VrO
	 urO8LpPNLtW4A==
Date: Sun, 20 Oct 2024 21:19:49 +0000
To: "tglozar@redhat.com" <tglozar@redhat.com>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
From: furkanonder <furkanonder@protonmail.com>
Subject: [PATCH 3/3] tools/rtla: Improved Exception Handling in timerlat
Message-ID: <1ac8Mw1vlvKy7U6eVpy92r4StxEEWaNj1rDmQ6yj9vXPqSTaJuYGudhdDh0g6RUtPCwBwVs-K3_u2C251Ex_L1aJQHj1rFwDXxbrWKscSJI=@protonmail.com>
Feedback-ID: 14203677:user:proton
X-Pm-Message-ID: bfa7bec4539abd4309190bf630c19d9a20c4ca36
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
