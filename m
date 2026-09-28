Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CC4EBAD9;
	Mon, 28 Sep 2026 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616352; cv=none; b=svCd7VxTcYXN84rLf2Oc8VFw7QCzL5k2G5nMVWe/zZNjQ1ub2zqCYB++wmBh7GpnDAc/4ItOg4c0r56CFbKwhj8V8TOeof4bcT4RJfLMXKzjJ2kvkXsSVpmXUN3JYmwxMgE++CPUAdAAUnO8jK6aFU2Hln/dm07oU3PXm6Qjfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616352; c=relaxed/simple;
	bh=8H/jKcm9MHLUwwrrec6QIVB9LvvIHDB5y3MXtOEv8hg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=e5pR6hCLoUEIHHhSyoMhOwGnxPpbuoxv0x4GNYpA3a4E/9nx8ABAt1AIQmneuS3a8oSSRMgW+D1D2fdGqtwRcSde4OWzK+ROI30VP4jlSF+3OofFgVXN3Dli4EnGJJDv2icOEzDBda+8sRuGq4n8MMguDWfiB8stmgy8KHb1NkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=nlPL4BUM; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=aIbTm03v; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="nlPL4BUM";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="aIbTm03v"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790616334; bh=EjoM9+9IG4r6qRQdlcRv6CO
	INOW0oAM2Fd+22BlLYH4=; b=nlPL4BUMDKdJIbILxDUOqX1ToCSZmooJ9Sz1V6zTlV0FbnEb+F
	XfnHAUJzaUYWoGH8BXNxM4cHrXhrhJHNHjzoHtGoL1mExtAoY/wpb9djwrjc96axnCQVqByUCw9
	MdOXwUciXiQU7w2ZwEJa7Qq5qBLBEjJOMhKgjmDxP8WXKkmOwCRVCss8g2vFlHcfz1ZF/vfxdp9
	T3+QQb4uyyQdfzfpcAR0PRreMMJIlqCob/FEMpsIvpSDk9qwfNQ5RHwXMeO+3T1+Eglf1JeSbWz
	qgwe0YrF0Gx8SEe3/xUQprEpB8/8vPdXrsiLfXpvVePJX+AV/lysIau4P2cz70uTMag==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790616334; bh=EjoM9+9IG4r6qRQdlcRv6CO
	INOW0oAM2Fd+22BlLYH4=; b=aIbTm03vIj9lOJsUjw3frR+8/kW/QYSTheEring0G5WncqCXFY
	1c9YTa5Pjy/R22573iRBISC1Ok7BpZnQFVDw==;
Date: Mon, 28 Sep 2026 18:25:35 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/3=5D_Add_TAINT=5FDRIVER=5F?=
 =?US-ASCII?Q?OVERRIDE_for_usage_of_driver=5Foverride?=
In-Reply-To: <a92a69151266129e20abc4a8ec543d4f4438324e.1790612298.git.u.kleine-koenig@baylibre.com>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com> <a92a69151266129e20abc4a8ec543d4f4438324e.1790612298.git.u.kleine-koenig@baylibre.com>
Message-ID: <0D810D93-CCD7-46B0-9195-89638AA2E26D@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 28 September 2026 17:46:03 BST, "Uwe Kleine-König"
<u.kleine-koenig@baylibre.com> wrote:
>Commit fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when
>userspace manually messes with devices and drivers") introduced a taint
>for usage of bind/unbind sysfs files that manually trigger driver probe
>and remove respectively.
>
>For drivers that do their resource management correctly (which is also
>needed for module unloading) bind and unbind for matching devices are
>not critical operations. The thing that makes bind and unbind unsafe is
>that drivers can be forced on devices that originally don't match using
>driver_override. The result is that e.g. of_device_get_match_data()
>returns NULL despite all .of_match_table entries having a non-NULL
>.driver_data member which yields a NULL pointer exception for several
>drivers. And given that after setting a driver_override a manual bind is
>only one way a driver can be bound to an unexpected device, a separate
>taint for such an override is justified.
>
>Suggested-by: Danilo Krummrich <dakr@kernel.org>

From a quick scroll, I don't find anything wrong,

Reviewed-by: Bradley Morgan <brads@mainlining.org>


I just know this'll be a famous last words moment


>Link: https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kernel.org/
>Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>---
> Documentation/admin-guide/tainted-kernels.rst |  6 +++++-
> include/linux/device.h                        | 11 +++++++++--
> include/linux/panic.h                         |  3 ++-
> include/trace/events/module.h                 |  3 ++-
> kernel/panic.c                                |  3 ++-
> tools/debugging/kernel-chktaint               |  8 ++++++++
> 6 files changed, 28 insertions(+), 6 deletions(-)
>
>diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
>index a208811ad525..9ccac96b1f75 100644
>--- a/Documentation/admin-guide/tainted-kernels.rst
>+++ b/Documentation/admin-guide/tainted-kernels.rst
>@@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to the aforementioned
> script, but if you need something quick you can use this shell command to
> check
> which bits are set::
> 
>-	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
>+	$ for i in $(seq 0 21); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
> 
> Table for decoding tainted state
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>@@ -103,6 +103,7 @@ Bit  Log  Number   Reason that got the kernel tainted
>  18  _/N   262144  an in-kernel test has been run
>  19  _/J   524288  userspace used a mutating debug operation in fwctl
>  20  _/Y  1048576  device was manually bound or unbound from a driver
>+ 21  _/Z  2097152  a driver was forced on a non-matching device
> ===  ===  ======= 
> ========================================================
> 
> Note: The character ``_`` is representing a blank in this table to make reading
>@@ -193,3 +194,6 @@ More detailed explanation for tainting
> 
>  20) ``Y`` If userspace wrote to the `bind` or `unbind` sysfs files and
>      successfully bound or removed a device from a driver.
>+
>+ 21) ``Z`` If userspace wrote to a `driver_override` sysfs file opening the gate
>+     for unexpected driver binding.
>diff --git a/include/linux/device.h b/include/linux/device.h
>index 879eb758b5ee..4dac5e09b74c 100644
>--- a/include/linux/device.h
>+++ b/include/linux/device.h
>@@ -905,8 +905,15 @@ static inline int device_match_driver_override(struct device *dev,
> 					       const struct device_driver *drv)
> {
> 	guard(spinlock)(&dev->driver_override.lock);
>-	if (dev->driver_override.name)
>-		return !strcmp(dev->driver_override.name, drv->name);
>+	if (dev->driver_override.name) {
>+		int ret = !strcmp(dev->driver_override.name, drv->name);
>+
>+		if (ret > 0)
>+			add_taint_module(drv->owner,
>+					 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
>+
>+		return ret;
>+	}
> 	return -1;
> }
> 
>diff --git a/include/linux/panic.h b/include/linux/panic.h
>index 23976b1dfdb6..e6e24d8afcf7 100644
>--- a/include/linux/panic.h
>+++ b/include/linux/panic.h
>@@ -90,7 +90,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
> #define TAINT_TEST			18
> #define TAINT_FWCTL			19
> #define TAINT_FORCED_BIND		20
>-#define TAINT_FLAGS_COUNT		21
>+#define TAINT_DRIVER_OVERRIDE		21
>+#define TAINT_FLAGS_COUNT		22
> #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
> 
> struct taint_flag {
>diff --git a/include/trace/events/module.h b/include/trace/events/module.h
>index 19df3e39bba4..c7cdb1f53bc6 100644
>--- a/include/trace/events/module.h
>+++ b/include/trace/events/module.h
>@@ -27,7 +27,8 @@ struct module;
> 	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
> 	{ (1UL << TAINT_CRAP),			"C" },		\
> 	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
>-	{ (1UL << TAINT_FORCED_BIND),		"Y" })
>+	{ (1UL << TAINT_FORCED_BIND),		"Y" },		\
>+	{ (1UL << TAINT_DRIVER_OVERRIDE),	"Z" })
> 
> TRACE_EVENT(module_load,
> 
>diff --git a/kernel/panic.c b/kernel/panic.c
>index b824b68fcb08..a5d8743df496 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -826,6 +826,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
> 	TAINT_FLAG(TEST,			'N', ' '),
> 	TAINT_FLAG(FWCTL,			'J', ' '),
> 	TAINT_FLAG(FORCED_BIND,			'Y', ' '),
>+	TAINT_FLAG(DRIVER_OVERRIDE,		'Z', ' '),
> };
> 
> #undef TAINT_FLAG
>@@ -862,7 +863,7 @@ static void print_tainted_seq(struct seq_buf *s, bool verbose)
>  * exact size is allocated dynamically; the initial buffer remains
>  * as a fallback if allocation fails.
>  *
>- * The verbose taint string currently requires up to 344 characters.
>+ * The verbose taint string currently requires up to 365 characters.
>  */
> #define INIT_TAINT_BUF_MAX 370
> 
>diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
>index d8628be37214..14d8febd6b16 100755
>--- a/tools/debugging/kernel-chktaint
>+++ b/tools/debugging/kernel-chktaint
>@@ -219,6 +219,14 @@ else
> 	addout "Y"
> 	echo " * device was manually bound or unbound from a driver (#20)"
> fi
>+
>+T=`expr $T / 2`
>+if [ `expr $T % 2` -eq 0 ]; then
>+	addout " "
>+else
>+	addout "Z"
>+	echo " * a driver was forced on a non-matching device (#21)"
>+fi
> echo "Raw taint value as int/string: $taint/'$out'"
> 
> # report on any tainted loadable modules
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
