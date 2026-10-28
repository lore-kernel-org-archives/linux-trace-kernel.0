Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194943;
	b=e2VFPAEykkgUtjiEqS/64giL/oH6NNJ0A5vu2UmcDe8J0VUaHurAbMiLTysJb6dDjzxk
	 lAwa1UQlwYj2j/4PYWsMkaSqWjfWzrP6d9htR4JPhN/D0XZhU7KwU5LBTU2cXTBx78FXP
	 6FMgzVp9GkHFhsH1A+tWswHAyWw2H9k9ZAuPSbvAy2Rfehn2V4D+fnZWGtPo7ZnOEsLvF
	 HLOiXUhgGveyQp0HWSL02wZC2yilr5EL9SI4iJhEQnkpfYnTi5AYyumlaRGG6Oj6EDcJf
	 7UEcKY+8JEr+eo3WVMC1dMTuCt+OQDTS+sLYLgrJssV3Qut2k7JA4G+mAfUJFm3TrPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194943;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vGGkmgZlyNVgmXZbc17aFcU5yqNlGUh8mJuGJ4CJ8Y4=;
	b=LqnxmQ/NcxAXAQ8qD9Zq+1w53gcPJaZwuTJQvBg/5DaJVqQJsA1K5nk+0wdgUtYJSXHX
	 0dDwFQyogSVIPWDmRa4C6r5IZ5zMEazjlxsqlZBUNaKJMIkHe4vtpYaIx1TkfNgnVviU5
	 SBHeATUwj9FqoKpn4OgWIa640E3ziMTGRoXC71vxMj3BkOaqF1HDgz82j40+S2xW8DF+3
	 DBn82PapZQHAxQYmEKq7MGHKA25+FPefeu5b+8rtEzYI7ykTs667VQF+Wo+VCGFAUTguu
	 BdZFJe5Vb6e/+gMsmzeGC/EdC0Qs7La9KCkO3dgbAkJ3Mx4BvNcNogjTb6hM+1M3cXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=R3vQli9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384F606A31C;
	Wed, 28 Oct 2026 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=R3vQli9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD601F01825;
	Wed, 28 Oct 2026 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793194942;
	bh=vGGkmgZlyNVgmXZbc17aFcU5yqNlGUh8mJuGJ4CJ8Y4=;
	h=From:Date:Subject:To:Cc;
	b=R3vQli9ZfyEM47iG/JusIyoMOVDtXvETH1TKeaU6E3ZL3msfDHQ/IV5z/3zkoW5ed
	 YjKXCamzDRHgILZzUagvqoO6heI77Hk/fmhBBAuVCgqr89pMLWnHzU7B+tdnTUOcSe
	 /O5gtTkzrOL1GA//aLTBt3nAv/Wrb9upc9Nw4C4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 14:42:15 +0100
Subject: [PATCH] Revert "driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers"
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261028-bind_taint-revert-v1-1-7c6b9cef30c9@linuxfoundation.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubaaEfIqks7m4LgYbSMl7264/
 NX3/S/w5Jg8NMkFjg72vNqILE3AzGgnEjxEg5KqzKSqhWY79AHZBhH35IKQaCo0KpdlgRB/m6O
 Rz6/Zdr/9rhcy4Q3BfT+y8ceNdQAAAA==
X-Change-ID: 20261028-bind_taint-revert-0ac7ac23064a
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michal Pecio <michal.pecio@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=9825;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=WEjDzOBuI0zhJ6U8i83hUCjPMIw/Sk9SQRDgYzrzWcw=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPf+9ZW6f+zcwxeNbNGO9tVaa2nm9/+HiZeq1+O/UXu
 5ala8u2jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIfimG+U59E5+o2nHscv7i
 6brRddMx/21pZxkW7L8YXn12FnOZmcnEa8f0dysdmxi2GwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

This reverts commit fcbfaffee51a452cc8efcbaa3b88ec4595678424.

Turns out that vfio is a crazy beast and people have been "relying" on
the bind/unbind debugging feature as a way to handle passing through
devices to guest instances.  Because of this (https://xkcd.com/1172/),
let's revert the feature for now until we can figure out a more agreable
way to handle this such that normal workflows do not taint the kernel.

Odds are something like what Uwe proposes at:
	https://lore.kernel.org/lkml/cover.1790612298.git.u.kleine-koenig@baylibre.com/
will be the best way forward and will be revisited after for after 7.4.

The feature was originally intended to stem the flow of unnecessary
fuzzing reports of "broken" drivers where random devices were being
bound to random drivers and of course things were going wrong.  The main
syzbot tool is now not doing this anymore, and hopefully no one else
starts it up again (but in this madness of LLMs these days, you can't be
sure.)

Thanks to everyone for telling me just how wrong I was to implement
this, I appreciated the feedback :)

Link: https://lore.kernel.org/all/DLIL9H50MALI.3JROXYEEUM3KU@kernel.org/
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
To: Johan Hovold <johan@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Leon Romanovsky <leon@kernel.org>
Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Reported-by: Michal Pecio <michal.pecio@gmail.com>
Reported-by: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/tainted-kernels.rst | 52 +++++++++++++--------------
 drivers/base/bus.c                            |  3 --
 include/linux/panic.h                         |  3 +-
 include/trace/events/module.h                 |  3 +-
 kernel/panic.c                                |  5 ++-
 tools/debugging/kernel-chktaint               |  8 -----
 6 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index a208811ad525..3d312bc17942 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -79,31 +79,30 @@ which bits are set::
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-===  ===  =======  ========================================================
-Bit  Log  Number   Reason that got the kernel tainted
-===  ===  =======  ========================================================
-  0  G/P        1  proprietary module was loaded
-  1  _/F        2  module was force loaded
-  2  _/S        4  kernel running on an out of specification system
-  3  _/R        8  module was force unloaded
-  4  _/M       16  processor reported a Machine Check Exception (MCE)
-  5  _/B       32  bad page referenced or some unexpected page flags
-  6  _/U       64  taint requested by userspace application
-  7  _/D      128  kernel died recently, i.e. there was an OOPS or BUG
-  8  _/A      256  ACPI table overridden by user
-  9  _/W      512  kernel issued warning
- 10  _/C     1024  staging driver was loaded
- 11  _/I     2048  workaround for bug in platform firmware applied
- 12  _/O     4096  externally-built ("out-of-tree") module was loaded
- 13  _/E     8192  unsigned module was loaded
- 14  _/L    16384  soft lockup occurred
- 15  _/K    32768  kernel has been live patched
- 16  _/X    65536  auxiliary taint, defined for and used by distros
- 17  _/T   131072  kernel was built with the struct randomization plugin
- 18  _/N   262144  an in-kernel test has been run
- 19  _/J   524288  userspace used a mutating debug operation in fwctl
- 20  _/Y  1048576  device was manually bound or unbound from a driver
-===  ===  =======  ========================================================
+===  ===  ======  ========================================================
+Bit  Log  Number  Reason that got the kernel tainted
+===  ===  ======  ========================================================
+  0  G/P       1  proprietary module was loaded
+  1  _/F       2  module was force loaded
+  2  _/S       4  kernel running on an out of specification system
+  3  _/R       8  module was force unloaded
+  4  _/M      16  processor reported a Machine Check Exception (MCE)
+  5  _/B      32  bad page referenced or some unexpected page flags
+  6  _/U      64  taint requested by userspace application
+  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
+  8  _/A     256  ACPI table overridden by user
+  9  _/W     512  kernel issued warning
+ 10  _/C    1024  staging driver was loaded
+ 11  _/I    2048  workaround for bug in platform firmware applied
+ 12  _/O    4096  externally-built ("out-of-tree") module was loaded
+ 13  _/E    8192  unsigned module was loaded
+ 14  _/L   16384  soft lockup occurred
+ 15  _/K   32768  kernel has been live patched
+ 16  _/X   65536  auxiliary taint, defined for and used by distros
+ 17  _/T  131072  kernel was built with the struct randomization plugin
+ 18  _/N  262144  an in-kernel test has been run
+ 19  _/J  524288  userspace used a mutating debug operation in fwctl
+===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
 easier.
@@ -190,6 +189,3 @@ More detailed explanation for tainting
  19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
      to use the devices debugging features. Device debugging features could
      cause the device to malfunction in undefined ways.
-
- 20) ``Y`` If userspace wrote to the `bind` or `unbind` sysfs files and
-     successfully bound or removed a device from a driver.
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index f8759d5c9056..396097fdb316 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -19,7 +19,6 @@
 #include <linux/string.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
-#include <linux/panic.h>
 #include "base.h"
 #include "power/power.h"
 
@@ -242,7 +241,6 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == drv) {
-		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
 		device_driver_detach(dev);
 		err = count;
 	}
@@ -266,7 +264,6 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && driver_match_device(drv, dev)) {
-		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
 		err = device_driver_attach(drv, dev);
 		if (!err) {
 			/* success */
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 23976b1dfdb6..17e61b61c45f 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -89,8 +89,7 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
 #define TAINT_FWCTL			19
-#define TAINT_FORCED_BIND		20
-#define TAINT_FLAGS_COUNT		21
+#define TAINT_FLAGS_COUNT		20
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/include/trace/events/module.h b/include/trace/events/module.h
index 19df3e39bba4..e5a006be9dc6 100644
--- a/include/trace/events/module.h
+++ b/include/trace/events/module.h
@@ -26,8 +26,7 @@ struct module;
 	{ (1UL << TAINT_OOT_MODULE),		"O" },		\
 	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
 	{ (1UL << TAINT_CRAP),			"C" },		\
-	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
-	{ (1UL << TAINT_FORCED_BIND),		"Y" })
+	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" })
 
 TRACE_EVENT(module_load,
 
diff --git a/kernel/panic.c b/kernel/panic.c
index b824b68fcb08..574ee5a12f92 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -825,7 +825,6 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
 	TAINT_FLAG(TEST,			'N', ' '),
 	TAINT_FLAG(FWCTL,			'J', ' '),
-	TAINT_FLAG(FORCED_BIND,			'Y', ' '),
 };
 
 #undef TAINT_FLAG
@@ -862,9 +861,9 @@ static void print_tainted_seq(struct seq_buf *s, bool verbose)
  * exact size is allocated dynamically; the initial buffer remains
  * as a fallback if allocation fails.
  *
- * The verbose taint string currently requires up to 344 characters.
+ * The verbose taint string currently requires up to 327 characters.
  */
-#define INIT_TAINT_BUF_MAX 370
+#define INIT_TAINT_BUF_MAX 350
 
 static char init_taint_buf[INIT_TAINT_BUF_MAX] __initdata;
 static char *taint_buf __refdata = init_taint_buf;
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index d8628be37214..e1571c04afb5 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -211,14 +211,6 @@ else
 	addout "J"
 	echo " * fwctl's mutating debug interface was used (#19)"
 fi
-
-T=`expr $T / 2`
-if [ `expr $T % 2` -eq 0 ]; then
-	addout " "
-else
-	addout "Y"
-	echo " * device was manually bound or unbound from a driver (#20)"
-fi
 echo "Raw taint value as int/string: $taint/'$out'"
 
 # report on any tainted loadable modules

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261028-bind_taint-revert-0ac7ac23064a

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>

