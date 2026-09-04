Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8A3A7848;
	Fri,  4 Sep 2026 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551277; cv=none; b=CSeDkbAXFauJPucybOPKQIClnPlWT7woZmnUjFlB+IshVjneN1vTxI/4M2Q0qZYwPdN8NXQxqFFVtPPEfwvgyBpO+cdAJygXHzj27PKsgAzOfBt5wSx+OG2mJGHHgFoNojeLRAngTNE5ZdbaRYfZ1hKxAeXIuSNEe6JsqHAYXzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551277; c=relaxed/simple;
	bh=LSSwlAKF/qzPQ2ql2bGG3MRVkG911H+Tz84dm3Ud+TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfI7Ax5WWpO5ueBEsJhvtq/RfXTJox7byLd1UEadoM9z+HZMg9cHXrCdRKyfWNX2cPDkUanl5MazVlB2mbpTNv8kOLGBmO+zw/ux1L7QkdunIP5rx1qVccTb6NFMrUWh9AFlTyOMNRdtqO29nhPHlUyuyvfHdl8qfOd0lhSbl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=koKEfl5v; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="koKEfl5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788551225; x=1789156025; i=w_armin@gmx.de;
	bh=VvlMLNUiaD5NHCQEJ51kxMADhz5P6iO2I5jwaq2FM9U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=koKEfl5vv+tVatgTH9m0VMs1pGdNYzCB7XgkcfVd0U+al100ZNXLvcCiJcyeBESI
	 cNMYtueV9w6pges9lfVNdSeopJAx0XohIQLmpLRJxdPXyS9xHpv1xuZLqUvvuc3Xx
	 +vwfB1xPEY/HlJRUwmZ0vTmsPnJaaM+szrydqJyFhMQp7xoIOV3aH/hYZYGwjIPA2
	 H99nS5e00O2Ye9nOx7Po4YikUvymGyaDhWMwZqgmWfOwjvwGEcmOKNDuOqdyYWxFu
	 dYb+6ppKC6P9l27Qv6IcOGV355m2n3Reyv4utQGbAKzxg+j+zajhb2uMVGnt52NxL
	 V3hfuDmuAT0EBO9VLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1wSyD51giw-00bHFc; Fri, 04
 Sep 2026 21:47:05 +0200
Message-ID: <9ac44f3f-1c67-4c37-aa72-255cec1578d2@gmx.de>
Date: Fri, 4 Sep 2026 21:46:59 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Bradley Morgan <brads@mainlining.org>,
 Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ASYRctryECtTCNY4xDcz91i9GXKfWQ6OIVG3KIalEfiw78ZFGUB
 QCKXsREIBp04qpe7ZP+8SXpmnLOF9Hf1shehVVX6JzbIBYklOuFioyrawue8Za7Aco2eTzR
 3hVxsFd8c+W041CSBarsWYWwrBzklmlm9vqOTEeRfJQGW4BlGiRvPSQYG3zVwjKBokMFbwI
 ZIH335swK1TpGwRYImo0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WiTR0g+iCz8=;lWhuQud0+SyTB6j30Y2Mz9rYtNw
 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
 6JQmmT9JTGSeSPPrmp2E47Dl/A8J5/eZRHfo7w=


Am 04.09.26 um 07:10 schrieb Greg Kroah-Hartman:
> The ability to add and remove devices from a driver through the sysfs
> "bind" and "unbind" files was created all those decades ago as a way
> that kernel developers can iterate faster, and provide a debugging way
> for users to attempt to add a new device to a driver without having to
> rebuild their kernel.
>
> This api over the years has been abused and recently come under a major
> fuzzing "attack" through tools like syzbot which decided that it would
> attempt to just randomly bind any driver to any type of device, causing
> loads of unneeded errors and pointless kernel patches to be generated by
> unsuspecting new developers.
>
> Handle all of this by adding a new taint flag, TAINT_FORCED_BIND, which
> will be set on the driver if the bind/unbind sysfs files are ever
> written to.  This lets kernel developers "know" that a user is
> attempting to do something that is not normal, and as such, if the
> kernel breaks they get to keep the shiny pieces laying around on the
> floor.
>
> The flag is 'Y' which was unused, and can remembered as the user is
> "yeeting" the device being operated on here (thrown with force without
> regard for the thing being thrown).
>
> Note, the taint flag gets set _BEFORE_ the bind/unbind callback happens,
> as many times crashes/oops/warnings/failures happen within the callback,
> and the taint flag needs to be there to show what was being attempted.
> If it were to be set after the callback happens, the oops report would
> not properly reflect what foolishness was being attempted.
>
> Fuzzing tools like syzbot, that doesn't have hand-crafted rules to keep
> the tool from hitting bind/unbind, should be run with panic_on_taint
> enabled so that they fall over and don't continue on, thinking that they
> actually found a real issue.
>
> Userspace operations that rely on the bind/unbind files to work around
> the lack of will to upgrade a kernel image to a newer version with
> proper support for new devices, or the lack of will to submit valid
> device ids to driver authors, will still work properly, but now the
> kernel will be flagged in a way that will show that perhaps those users
> should reconsider their behavior and work to have the drivers properly
> support these devices in a "native" manner.

What about users that use driver_override together with vfio-pci? AFAIK
they still need to write to bind/unbind.

Also i always liked the fact that the bind/unbind attributes make it very
easy in creating generic drivers. In fact, i am intending to use this feat=
ure
in order to add netlink support to the ACPI-WMI subsystem in the future.
I am planning to realize this thru a generic WMI driver that has to be man=
ually
bound to a given WMI device to make it available over netlink, so having
users be able to write bind/unbind without potentially triggering a kernel=
 panic
would be very nice.

Additionally, writing into the bind attribute still checks if the driver a=
nd the
device match:

/*
  * Manually attach a device to a driver.
  * Note: the driver must want to bind to the device,
  * it is not possible to override the driver's id table.
  */
static ssize_t bind_store(struct device_driver *drv, const char *buf, size=
_t count)

Because of this i would suggest that the taint (if at all) be added to the
driver_override attribute instead, because only with this attribute users =
can bind
random drivers to truly random devices.

Thanks,
Armin Wolf

> Finally, the bind/unbind files can find real use-after-free issues with
> some drivers by forcing the process to happen virtually without having
> to rely on manual removal processes.  Those real bugs should still be
> worked on, but by adding this taint flag, developers can more easily
> determine bug reports that are actually worth looking at.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Changes in v3:
> - Fixes based on sashiko review:
>    - Fix up prototype for when CONFIG_MODULES is disabled so it will
>      build properly, AGAIN.
> - Link to v2: https://patch.msgid.link/20260831-bind_taint-v2-0-1082d631=
213b@linuxfoundation.org
>
> Changes in v2:
> - rebase on 7.3-rc1
> - Add changelog text to describe panic_on_taint and how it should be set
>    for tools like syzbot.
> - Add changelog text to describe why 'Y' was picked.
> - Fixes based on sashiko review:
>    - Make add_taint_module() handle a NULL for module pointer, fixing a
>      problem with built-in drivers.
>    - Fix up prototype for when CONFIG_MODULES is disabled so it will
>      actually build properly.
>    - rst table header fixes.
> - Link to v1: https://patch.msgid.link/20260826-bind_taint-v1-0-52b05f4a=
965c@linuxfoundation.org
>
> To: Luis Chamberlain <mcgrof@kernel.org>
> To: Petr Pavlu <petr.pavlu@suse.com>
> To: Daniel Gomez <da.gomez@kernel.org>
> To: Sami Tolvanen <samitolvanen@google.com>
> To: Aaron Tomlin <atomlin@atomlin.com>
> To: Jonathan Corbet <corbet@lwn.net>
> To: Shuah Khan <skhan@linuxfoundation.org>
> To: Randy Dunlap <rdunlap@infradead.org>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> To: "Rafael J. Wysocki" <rafael@kernel.org>
> To: Danilo Krummrich <dakr@kernel.org>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Masami Hiramatsu <mhiramat@kernel.org>
> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: driver-core@lists.linux.dev
> Cc: linux-trace-kernel@vger.kernel.org
>
> ---
> Greg Kroah-Hartman (2):
>        module: pull out add_taint_module() to be public
>        driver core: add TAINT_FORCED_BIND for when userspace manually me=
sses with devices and drivers
>
>   Documentation/admin-guide/tainted-kernels.rst | 52 ++++++++++++++-----=
=2D-------
>   drivers/base/bus.c                            |  3 ++
>   include/linux/module.h                        | 10 ++++++
>   include/linux/panic.h                         |  3 +-
>   include/trace/events/module.h                 |  3 +-
>   kernel/module/main.c                          | 16 +++++++--
>   kernel/panic.c                                |  5 +--
>   tools/debugging/kernel-chktaint               |  8 +++++
>   8 files changed, 69 insertions(+), 31 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260825-bind_taint-d4077b870bc4
>
> Best regards,
> --
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>
>  From mboxrd@z Thu Jan  1 00:00:00 1970
> Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15=
c8.ts.net [100.103.45.18])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7D415F06;
> 	Fri,  4 Sep 2026 05:12:34 +0000 (UTC)
> Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client=
-ip=3D100.103.45.18
> ARC-Seal:i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-2024011=
6;
> 	t=3D1788498755; cv=3Dnone; b=3DYVFqay1IJUVOWRhF5lbF49N9gACjWl/u/wiBGdeV=
8d9eqXk9mnp+dQ6eyjskPf1vqMRfNXCLudsRqs7s/ptpX2bQJsQ4PyAt97qclTSJBOznKuYqju=
VxufSShWBSj6iGoGnZcQw+e2Q9Ly6ixw+Q323AmyXIc+H/caHtjxakuHk=3D
> ARC-Message-Signature:i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
> 	s=3Darc-20240116; t=3D1788498755; c=3Drelaxed/simple;
> 	bh=3DpLyyPJCavNnqg1J4ue9yK5PlAmiMR++3Z8v4Ev3jR+4=3D;
> 	h=3DFrom:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
> 	 In-Reply-To:To:Cc; b=3DNoNrP4+kG51E+VUVjTQ7eZBG8DJ4QJdPSX7nXCHR7qNw1Hz=
TheBF+APlqE/yPFE/HDXCloQq6PsRH784NlK0lTDBu81Xo9PlS0QhLQkafpUGps8FcEw2pQZxb=
hT+91ISzyOG0uOnSka9ty7gwBGsyKlxA8KNYgFLv4Jpuyl3CxU=3D
> ARC-Authentication-Results:i=3D1; smtp.subspace.kernel.org; dkim=3Dpass =
(1024-bit key) header.d=3Dlinuxfoundation.org header.i=3D@linuxfoundation.=
org header.b=3Ducn4lrR/; arc=3Dnone smtp.client-ip=3D100.103.45.18
> Authentication-Results: smtp.subspace.kernel.org;
> 	dkim=3Dpass (1024-bit key) header.d=3Dlinuxfoundation.org header.i=3D@l=
inuxfoundation.org header.b=3D"ucn4lrR/"
> Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003711F00A3E;
> 	Fri,  4 Sep 2026 05:12:33 +0000 (UTC)
> DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dlinuxfou=
ndation.org;
> 	s=3Dkorg; t=3D1788498754;
> 	bh=3DKrAwo9/bReRcHGrb+EIOBXbKoLVbmnWAiqQj4hM9GR4=3D;
> 	h=3DFrom:Date:Subject:References:In-Reply-To:To:Cc;
> 	b=3Ducn4lrR/Wvs8Hzz+jBIP38JWRP4T8gs3TOfl/opgMz+qXDSpJTTmTld3GSYkHx+b1
> 	 pqksgdzktExbEkSrSC3Poy+I6JfuzXpXH199wNaRrrq4ei16vWNsuDsnGyxgiHzh0C
> 	 nbHTwZKC7lvKjyIz2vK00XrqIQLoA4eUS5NrG24U=3D
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Fri, 04 Sep 2026 07:10:41 +0200
> Subject: [PATCH v3 1/2] module: pull out add_taint_module() to be public
> Precedence: bulk
> X-Mailing-List: linux-modules@vger.kernel.org
> List-Id: <linux-modules.vger.kernel.org>
> List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
> List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3D"utf-8"
> Content-Transfer-Encoding: 7bit
> Message-Id: <20260904-bind_taint-v3-1-30025465f38a@linuxfoundation.org>
> References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
> In-Reply-To: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
> To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.co=
m>,
>   Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google=
.com>,
>   Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
>   Shuah Khan <skhan@linuxfoundation.org>,
>   Randy Dunlap <rdunlap@infradead.org>,
>   "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel=
.org>,
>   Steven Rostedt <rostedt@goodmis.org>,
>   Masami Hiramatsu <mhiramat@kernel.org>,
>   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Bradley Morgan <brads@mainlining.org>,
>   Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
>   linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
>   linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
>   linux-trace-kernel@vger.kernel.org,
>   Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
>   Johan Hovold <johan@kernel.org>
> X-Mailer: b4 0.17-dev-362b8
> X-Developer-Signature: v=3D1; a=3Dopenpgp-sha256; l=3D2682;
>   i=3Dgregkh@linuxfoundation.org; h=3Dfrom:subject:message-id;
>   bh=3DpLyyPJCavNnqg1J4ue9yK5PlAmiMR++3Z8v4Ev3jR+4=3D;
>   b=3DowGbwMvMwCRo6H6F97bub03G02pJDFmzgq4fWPbWcV/uvHnfg/ZMrU9bv71xatg7tV=
k7novmL
>   1mmFli4riOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAmosTDMIdTKWjC6aI=
HLY+P
>   emcEXORcfPbdG0mGuULdv/erqSxsnFs4z/HElrKuTU5rdAE=3D
> X-Developer-Key: i=3Dgregkh@linuxfoundation.org; a=3Dopenpgp;
>   fpr=3DF4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
>
> Other kernel code might want to call add_taint_module() so pull it out
> and make it global.  If modules are not enabled, this defaults to a call
> to add_taint(), so all is fine.
>
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Tested-by: Johan Hovold <johan@kernel.org>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   include/linux/module.h | 10 ++++++++++
>   kernel/module/main.c   | 16 +++++++++++++---
>   2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..f6f90cd88f15 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -29,6 +29,7 @@
>   #include <linux/srcu.h>
>   #include <linux/static_call_types.h>
>   #include <linux/dynamic_debug.h>
> +#include <linux/panic.h>
>  =20
>   #include <linux/percpu.h>
>   #include <asm/module.h>
> @@ -770,6 +771,9 @@ static inline bool is_livepatch_module(struct module=
 *mod)
>  =20
>   void module_for_each_mod(int(*func)(struct module *mod, void *data), v=
oid *data);
>  =20
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok);
> +
>   #else /* !CONFIG_MODULES... */
>  =20
>   static inline struct module *__module_address(unsigned long addr)
> @@ -877,6 +881,12 @@ static inline bool module_is_coming(struct module *=
mod)
>   static inline void module_for_each_mod(int(*func)(struct module *mod, =
void *data), void *data)
>   {
>   }
> +
> +static inline void add_taint_module(struct module *mod, unsigned flag,
> +				    enum lockdep_ok lockdep_ok)
> +{
> +	add_taint(flag, lockdep_ok);
> +}
>   #endif /* CONFIG_MODULES */
>  =20
>   #ifdef CONFIG_SYSFS
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..444d990c9983 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -191,11 +191,21 @@ static inline int strong_try_module_get(struct mod=
ule *mod)
>   		return -ENOENT;
>   }
>  =20
> -static inline void add_taint_module(struct module *mod, unsigned flag,
> -				    enum lockdep_ok lockdep_ok)
> +/**
> + * add_taint_module: add a taint flag if not already set for a specific=
 module
> + * @mod: pointer to the module that caused the problem
> + * @flag: one of the TAINT_* constants.
> + * @lockdep_ok: whether lock debugging is still OK.
> + *
> + * If something bad has gone wrong, you'll want @lockdebug_ok =3D false=
, but for
> + * some noteworthy-but-not-corrupting cases, it can be set to true.
> + */
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok)
>   {
>   	add_taint(flag, lockdep_ok);
> -	set_bit(flag, &mod->taints);
> +	if (mod)
> +		set_bit(flag, &mod->taints);
>   }
>  =20
>   /*
>
