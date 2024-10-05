Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA21B813
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Oct 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728148852; cv=none; b=nPJnsRNlF93VNViXVSMmw4ecB38lNOwtjIGzK1RaLmiXS81I7XkuRT0I0QuysoLctgXP81hXh4CQThz962ewqH5SbLkTd6yiFlI9tghZj7UVUZwNRC5GiQsqXU5CqhJIDQ4JmYIyBHQdxHOl2LDWaR58k71ULOfkeet9075ZpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728148852; c=relaxed/simple;
	bh=smA2hdV1RlzKlLoJwEo3P/8mGiVh6ZQ0EM4xV42YRNE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=e8ZsxlBi/kUvpdvMCr1uV4T/M0+RrYz2P1bu70Wgm0OckzqIj+I0UiOmpWnGaFGg1727acBtb5DPmd0J5XBnTJP9rnfdbE+ERMxUXHiYFSPu6wAkKR9S9B7B6MZyLGbftFljf0L1wFlJeQ3ZjHBznlGlLh4Kd4LCl3jmSRcTbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ywkBnj5/; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ywkBnj5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1728148843; x=1728408043;
	bh=BJNISnU/2z367aZjwR4dNZ7EAu+af/4MFDjU5kVH32w=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ywkBnj5/KENKo5MailajfS+cU/hkVrzrJuV46oL7XzVg7bi4Me0a5Kyy37Esf/gIj
	 qL81X+ff8pX1ZJ/gA/807Gv8z+cWr37bQVNBnbq5GkNFF5ZGb7pWWbSogGR2igA9Or
	 PswO9GiZHeUyMAR4H5TzlBK1ksIRVMAHdIUR+pDuj5c/jjuCEC8KerTTkFumULonaG
	 SIAsor7hVsHaNWvfWizfgZjryFGz/lyKw8JHSEH58SvPoA58UaE7NrYTrhP/IVJr4i
	 PCpaxofCNZptkLO+8WhWMyuvIwqKGVX0nEgOmCGBQ8tJKrAh3PYHk1lyum1U9nqbOF
	 HDfmhhhS9iHgg==
Date: Sat, 05 Oct 2024 17:20:37 +0000
To: "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
From: furkanonder <furkanonder@protonmail.com>
Subject: [PATCH] tools/rtla: Enhance Error Handling and Readability for timerlat
Message-ID: <HAxOlk1o3vhrAUlyVMtrSLGP39PFS1TLfGT9C9pB6cXgQpGB_fiNeGSuWS_4-4zeMxunluuBnkc4Y-k_c0qrlstVpYQvgfkJN2p_VnfMO-k=@protonmail.com>
Feedback-ID: 14203677:user:proton
X-Pm-Message-ID: 82a949d8e13af8bcadd8a7b7559cc928331234eb
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The enhancements made to timerlat_load.py focus on improving error
handling, readability, and overall user experience. These changes aim to
make the script more robust and easier to maintain while providing clearer
feedback to users. Key modifications include:

Type Declaration in Argument Parsing
Added type declarations for command-line arguments in the argument parser.
This removes the need for manual type checks later in the code, improving
clarity and safety.

String Formatting
Replaced string concatenation with an f-string to enhancing readability
and conciseness.

Enhanced Exception Handling and Consistent Error Reporting
Specific exceptions are now caught and printed with clearer messages,
providing context for errors when opening file descriptors. Added
exception handling for the data file descriptor opening to ensure
uniformity across the script.

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

Changes for the read Infinite Loop
The original generic exception clause has been replaced with more
specific exception types to provide clearer feedback on errors.

Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
---
 tools/tracing/rtla/sample/timerlat_load.py | 56 +++++++++++++++++++++++---=
-----------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtl=
a/sample/timerlat_load.py
index 8cc5eb2d2e69..a819c3588073 100644
--- a/tools/tracing/rtla/sample/timerlat_load.py
+++ b/tools/tracing/rtla/sample/timerlat_load.py
@@ -25,50 +25,54 @@ import sys
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
-except:
-    print("Invalid cpu: " + args.cpu)
-    exit(1)
-
-try:
-    os.sched_setaffinity(0, affinity_mask);
-except:
-    print("Error setting affinity")
-    exit(1)
+    affinity_mask =3D {args.cpu}
+    os.sched_setaffinity(0, affinity_mask)
+except Exception as e:
+    print(f"Error setting affinity: {e}")
+    sys.exit(1)

-if (args.prio):
+if args.prio:
     try:
-        param =3D os.sched_param(int(args.prio))
+        param =3D os.sched_param(args.prio)
         os.sched_setscheduler(0, os.SCHED_FIFO, param)
-    except:
-        print("Error setting priority")
-        exit(1)
+    except Exception as e:
+        print(f"Error setting priority: {e}")
+        sys.exit(1)

 try:
-    timerlat_path =3D "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.cpu=
 + "/timerlat_fd"
+    timerlat_path =3D f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu}/=
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
-    data_fd =3D open("/dev/full", 'r');
-except:
-    print("Error opening data fd")
+    data_fd =3D open("/dev/full", 'r')
+except Exception as e:
+    print(f"Error opening data fd: {e}")
+    sys.exit(1)

 while True:
     try:
         timerlat_fd.read(1)
-        data_fd.read(20*1024*1024)
-    except:
+        data_fd.read(20 * 1024 * 1024)
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
