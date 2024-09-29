Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D842ABE
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Sep 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727652080; cv=none; b=VKjjf9oGmJ4CzrTlggjOefITa1ommudTuguJJopQCjLv8ejgi1KBjh+K6tivEek1TUWtwYW9Zw6ac+9q4qFpO4Z915+IvC5jVUYE2VZhIo6KqCuWxGtcdsgsMQOYNz9wkAJcoM0svb48Qtlll1goVZ7ZatKKDzktenB8gyHvkyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727652080; c=relaxed/simple;
	bh=ymwwRgXT4oQJMx69geWnjROK2VhUXrJ05WAGWG0+Zt4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+SE8nsj5vvjOgogzJGNEG7lg2h2qVYgrYlc+YOoFQRpCBJuh0XrbFScN0+zMJwUls5KwJ1y4v6IpVspiDKyssB24Cxv4OkcvHa/t6RBivzB+kTUrIdxkOenB5IkSbV4P8nh5DUTZYZgyidfz94Xe3HgC7yR0as39fDlOr6DMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=laMIpfWR; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="laMIpfWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1727652069; x=1727911269;
	bh=5S7PebxuxcRBc+TOHlQptl9ryHj/Ku9TXvH1jMtuDfk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=laMIpfWR8/AzEmimUG5kmdBnxJO6K78yax8ywpP8fm937JgVv2GvcgN20sGZJgupU
	 mGJv8o6wXC5V2T+s0aqWLiTBh4EHCTFcZ+nT0g/KBeTkygUqIUEs8peIwj0ZdvMTSk
	 7n3ycns7SLXk3FE6x8if33fRDmwgz6+u0hHJPTHDJ0OSilbIRMYcHKiLqWVJIRJkpJ
	 LCZBLdk5NxkO6+GmYBP2FQ/f7fIUg147Kw3Z/yCvcrHp/UaLqlLJEfLiljO7oZT+UL
	 JsHBu4Lm+jSAkdUFnQ14xEoMXjVoOfkOjagKUAWWIYV2YPdiycLY0MpYlRcAKBPHVX
	 qNCAju8mAmKZA==
Date: Sun, 29 Sep 2024 23:21:05 +0000
To: Steven Rostedt <rostedt@goodmis.org>
From: furkanonder <furkanonder@protonmail.com>
Cc: Clark Williams <williams@redhat.com>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/timerlat: Enhance Error Handling and Readability for timerlat_load.py
Message-ID: <NPl8CXZesS-2Yga8ePwiOTlriUFANh7fZqkSvuHS4wL7AOEGoQ7OYcm-QozD4jffDJ68Bd11N9GQBaOnhT4Iq55T4hWEML-kvNbHMkUlfc8=@protonmail.com>
In-Reply-To: <20240926003823.50a14245@rorschach.local.home>
References: <2eV3oMRbTimO2AnpsTNrv5qQFnWBqljnkXxLciVNWDGDWP4rTQS1nfvRZAsJ9-Mx9U9GsxMyQZ5UZ94FSBjZrFeuJHKloPzE45D3k-3LnIA=@protonmail.com> <20240926003823.50a14245@rorschach.local.home>
Feedback-ID: 14203677:user:proton
X-Pm-Message-ID: 22648f4ee4ceea6a6d464dff3467b4a1eee51969
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I=E2=80=99m sorry; I included the patch as an attachment in the email witho=
ut noticing.

--- tools/tracing/rtla/sample/timerlat_load.py.orig=092024-09-22 02:37:14.7=
67832391 +0300
+++ tools/tracing/rtla/sample/timerlat_load.py=092024-09-22 02:37:05.721215=
367 +0300
@@ -25,50 +25,54 @@ import sys
 import os
=20
 parser =3D argparse.ArgumentParser(description=3D'user-space timerlat thre=
ad in Python')
-parser.add_argument("cpu", help=3D'CPU to run timerlat thread')
-parser.add_argument("-p", "--prio", help=3D'FIFO priority')
-
+parser.add_argument("cpu", type=3Dint, help=3D'CPU to run timerlat thread'=
)
+parser.add_argument("-p", "--prio", type=3Dint, help=3D'FIFO priority')
 args =3D parser.parse_args()
=20
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
=20
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
=20
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
=20
 try:
-    data_fd =3D open("/dev/full", 'r');
-except:
-    print("Error opening data fd")
+    data_fd =3D open("/dev/full", 'r')
+except Exception as e:
+    print(f"Error opening data fd: {e}")
+    sys.exit(1)
=20
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
=20
 timerlat_fd.close()
 data_fd.close()


Sent with Proton Mail secure email.

On Thursday, September 26th, 2024 at 7:38 AM, Steven Rostedt <rostedt@goodm=
is.org> wrote:

> Hi,
>=20
> Thank you for your patch. First, Daniel is unfortunately no longer the
> maintainer of this code:
>=20
> https://lwn.net/Articles/979912/
>=20
> This patch is not formatted correctly, so it can not even be reviewed.
> Please take a look at Submitting Patches:
>=20
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
>=20
> -- Steve
>=20
>=20
> On Sat, 21 Sep 2024 23:43:02 +0000
> furkanonder furkanonder@protonmail.com wrote:
>=20
> > The enhancements made to timerlat_load.py focus on improving error hand=
ling, readability, and overall user experience. These changes aim to make t=
he script more robust and easier to maintain while providing clearer feedba=
ck to users.
> > Key modifications include:
> >=20
> > Type Declaration in Argument Parsing:
> > Added type declarations for command-line arguments in the argument pars=
er. This removes the need for manual type checks later in the code, improvi=
ng clarity and safety.
> > Before:
> > parser.add_argument("cpu", help=3D'CPU to run timerlat thread')
> > parser.add_argument("-p", "--prio", help=3D'FIFO priority')
> > After:
> > parser.add_argument("cpu", type=3Dint, help=3D'CPU to run timerlat thre=
ad')
> > parser.add_argument("-p", "--prio", type=3Dint, help=3D'FIFO priority')
> >=20
> > String Formatting:
> > Replaced string concatenation with an f-string to enhancing readability=
 and conciseness.
> > Before:
> > timerlat_path =3D "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.cpu =
+ "/timerlat_fd"
> > After:
> > timerlat_path =3D f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu}/t=
imerlat_fd"
> >=20
> > Enhanced Exception Handling and Consistent Error Reporting:
> > Specific exceptions are now caught and printed with clearer messages, p=
roviding context for errors when opening file descriptors. Added exception
> > handling for the data file descriptor opening to ensure uniformity acro=
ss the script.
> >=20
> > Before:
> > $ sudo python timerlat_load.py 122
> > Error setting affinity
> > After:
> > $ sudo python timerlat_load.py 122
> > Error setting affinity: [Errno 22] Invalid argument
> >=20
> > Before:
> > $ sudo python timerlat_load.py 1 -p 950
> > Error setting priority
> > After:
> > $ sudo python timerlat_load.py 1 -p 950
> > Error setting priority: [Errno 22] Invalid argument
> >=20
> > Before:
> > $ python timerlat_load.py 1
> > Error opening timerlat fd, did you run timerlat -U?
> > After:
> > $ python timerlat_load.py 1
> > Permission denied. Please check your access rights.
> >=20
> > Changes for the read Infinite Loop:
> > The original generic exception clause has been replaced with more speci=
fic exception types to provide clearer feedback on errors.
