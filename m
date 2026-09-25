Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45633672BD;
	Fri, 25 Sep 2026 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361766; cv=none; b=AWY557D2J65jykFShD7tI3tSAKp3bD35levRK88SsMt8dSo+os3zGD5O51qUrQgLhTGye9st0/xnfZrbsrE7ldALIxNHnjbmtmFarvMEP5JhSheRJ1v5tAfjVZdDW9Rr9ugsXz8P/z46TCrfV98dSoZZmjWO7MTZAYXjrjXAtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361766; c=relaxed/simple;
	bh=gVe5Dqj5kGF+QMoYW7jGRPpUqOiZfc93w8cD/uGHXx4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HzA4kYpT43J17k8tzb7cdtHYr559KFkbSGRBzaSgZa+PQRQ6wpqdSNH1bJQ0MB1TLhj3FZdpBBfSC56My/UA0RnlrDcZnL9oCzi5hjWMz6sWedexxcoTjAdMhw9Qi/Gpr4iYTWAZN5+uSARxSxl0BD7NZ36pjJNqkQ+ezjkXQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=r5m1Z/F5; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=3I2XqBa5; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="r5m1Z/F5";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="3I2XqBa5"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790361744; bh=35vQAHdO64Nk1a0T+biHwYP
	apDIz6FTP0CKPnrXV4iA=; b=r5m1Z/F5eKRaxpfPbktIJUZ1RTdzn+5V9QcqbnQLK2MxIwJvZ2
	OdRa5IBnzo9imqj+7+PUFXUscMtfFMYFEvqR7atPejv0e2/X/qOtCcYRKtfV0+L5ccGQ/r+4r1y
	DUu2Q9tqd1HSzEgOznitobJtUTsoIrBE490ck8LqQamKf3MeKI0/2OQBGA614GkMifO829eJC/p
	qYaqR1s3R9l+Sht4Vyuxq7P/Hai0FVlyFk48PLwlGRBNA+WzPLhRddOLbPnirSoqXs6plM9w6lK
	qiD49WM6xUsqleKkYmhlqrtADVhZ3vrxq11kyvW/qlEUMAV63c7cfHYzif/VFOVeb3w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790361744; bh=35vQAHdO64Nk1a0T+biHwYP
	apDIz6FTP0CKPnrXV4iA=; b=3I2XqBa5Yp0hdint0QiEwe+dVcwoEE1EXvv208uNNaMXD6m64g
	/eoLjrX6av1QXf3SebjUwHiLhZRvxx+hGMDQ==;
Date: Fri, 25 Sep 2026 19:42:25 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
In-Reply-To: <20260925182041.1025371-2-u.kleine-koenig@baylibre.com>
References: <20260925182041.1025371-2-u.kleine-koenig@baylibre.com>
Message-ID: <E7B71661-74B0-42A9-9FC2-2AFCC7A3532D@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 25 September 2026 19:20:40 BST, "Uwe Kleine-König"
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

LGTM, thanks!

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>---
>Hello,
>
>I first considered to just set TAINT_FORCED_BIND when driver_override is
>written to. But IMHO it's very useful to differentiate for reported bugs
>if bind/unbind was used in combination with driver_override or not.
>
>Also if only bind/unbind was used and driver_override not, a resulting
>problem is worth fixing (opposed to what is considered for
>bind+driver_override).
>
>IMHO it would also be fine to drop TAINT_FORCED_BIND, but let time prove
>how many reports we get with TAINT_FORCED_BIND but without
>TAINT_DRIVER_OVERRIDE.
>
>Best regards
>Uwe
>
> Documentation/admin-guide/tainted-kernels.rst | 6 +++++-
> drivers/base/bus.c                            | 1 +
> include/linux/panic.h                         | 3 ++-
> include/trace/events/module.h                 | 3 ++-
> kernel/panic.c                                | 3 ++-
> tools/debugging/kernel-chktaint               | 8 ++++++++
> 6 files changed, 20 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
>index abbf5e3dd749..75750a9533e9 100644
>--- a/Documentation/admin-guide/tainted-kernels.rst
>+++ b/Documentation/admin-guide/tainted-kernels.rst
>@@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to the aforementioned
> script, but if you need something quick you can use this shell command to
> check
> which bits are set::
> 
>-	$ for i in $(seq 20); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
>+	$ for i in $(seq 21); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
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
>diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>index c51ad96d4de4..6e91210aab45 100644
>--- a/drivers/base/bus.c
>+++ b/drivers/base/bus.c
>@@ -513,6 +513,7 @@ static ssize_t driver_override_store(struct device *dev,
> {
> 	int ret;
> 
>+	add_taint_module(drv->owner, TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
> 	ret = __device_set_driver_override(dev, buf, count);
> 	if (ret)
> 		return ret;
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
>index b824b68fcb08..f5476a61f6f3 100644
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
>+ * The verbose taint string currently requires up to 364 characters.
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
