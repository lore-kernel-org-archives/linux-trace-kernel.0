Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059415;
	b=NUsUqf09wfl/hiKmJHLxTrWNEGnVEdosTIVbZDN4SpQt6ZCE3RzhLL1aGGxgWQYSGTZ0
	 aGGI+G9IS/o4ANdmY9glcXT2riMlIPrJcpWnGMFYEwLmw/JULmwvSRYifmBHv61RQnPWU
	 L2aNQVxWG6a4WQN4zIxf5clymudNT1GlVjvRTlZIF3ksHWRuA46mMhxtq4We6zTKp1NPF
	 MEaNQXmE/mUPq0Envyem11ol5n/Xv8UYuAmeLFKd+yKDKugmI6NNCWWY1dDAvrXYrYZEV
	 q7vqxFz+lyG5UUiflDiWf/OOp1HFZB3Jx6Qw2W72/s9U65+Emef6IdNDSHxW4iNoMww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059415;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=UOqEbJSCaTbpPv78bpI6sjyyINP3o44BKyJzpTyl3/U=;
	b=UKJRcszilzBjsDAhD7yHpJGKFcNRwqBvzFpP7cXZpxdDfE8ij82oncT19+AVMVHlBaiS
	 52453gbivwBHWYopfuWZhX6SAyRy7v5/a594uLC1mu5+Uhr5eLupectXYST1St99FP/MK
	 JVquupo2tj9+9L+wADhGx8grYvtuENw3st7mduPUOn/l8y2ZpDn5uOgLPqh8+uUw2+ekP
	 qhtHRX78RHtLUO6Ku+s8Og0MU4lzwzNe4fb0GLQnvlcr4zpzAVnN3bz+n0cWXlnWd14J5
	 +Etc9E26NrqCtWXwZB/EWl4WP0od8M84488YnyNGbmj3iAdJRhW5tekeEew/qvT12ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=sHUH+fBI;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4460A260E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 03:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D4460A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=sHUH+fBI
DKIM2-Signature:  i=1; m=1; t=1795059412;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:FtqMIkT8ME3G/tAQiF7ZKGJWXSYw
   RtPwOSym8+Kcr3FEjcxLD5LUyYULX804xY4XVnDkirFDTT/8NDsvKaoK8hVkSqLFDHBxiprY9rS
   i4qC6/XivVLp8rEk15YCSGZGrqt8v1PQg5VuDwH8ppYxZuFYksGVYDmVu9k/+EgIaGeMsFGPQb5
   W6LaczUuNNzM6vs8lY73QC8ArOJgMuHdVBxCcqpMJvW5+w3DPpSrR8aP96RDwR2iHjFxhyL67ih
   rHJdyUPDVGgxaLciaTnYIOHQT7QfGu88bFii2c9VKV+GSUTgfEi9L32HB0mXcuNWXkeeRFnukBU
   lc/ECNlfPcg2rA==;
Message-Instance:  m=1;
 h=sha256:
   Or+MLQ9DVrPrGNvQloEu/Np+HgAYtoxM7NUH/WrDbc8=:
   GxCryZjezdKf0mqsbLPIympORssyc/tZkbKbRTiRSIU=,
  sha512:
   CXAsaopMxtJSgydk8UGdpEq3Vzs20rCXo8W3powz1DHL6aTT7pm7EYX4hxSuE9nMb3rMGZxjx2YXoJbkD46zIw==:
   RMzTwaxyGS9Et/xWXNf1wu895TBMFoP5oWeTP21nMTW/CGzER8es9aVu5SNE6OcYi2bz6PyljDMSM8dEWkNMXg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795059339; x=1795664139; i=w_armin@gmx.de;
	bh=UOqEbJSCaTbpPv78bpI6sjyyINP3o44BKyJzpTyl3/U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sHUH+fBIRQd8mwfGMyAW3Y71yNw/qPqiP8P3YwkYQi042vJSd5fUKuCR7CSVu6HA
	 BHPPkkL5WhZZBtCoJZcRCjnOur92HtFWx62bbk6b9p3IA05IQdKCaMX8GEND0Q5VQ
	 biv9nloysB2QV3w57uEO0RaoFXlvwAyfkaxTN07qOI97WycVBNz2arrQiXkdxrQXn
	 YmTB9sy3bZjOkofNxN6s8QqsDqR9rj9yIv3ue8IpAhYjUdHx2R2lrTPVECdDNB4/8
	 l5KMWS0/tfVt0jCUpP7XUVivmCgosVBt4UR62YK4MxbG076kVF95jqu/W6kS+yYcJ
	 J8Pv9cYuEPVv8zxcgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1wuY361xyN-00g1v5; Thu, 19
 Nov 2026 04:35:39 +0100
Message-ID: <6662b50a-88fc-43a3-87ca-949989927acd@gmx.de>
Date: Thu, 19 Nov 2026 04:35:30 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Disable driver overriding by default
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Lechner <dlechner@baylibre.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Karl Mehltretter <kmehltretter@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Marco Elver <elver@google.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Bradley Morgan <brads@mainlining.org>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Pnina Feder <pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>,
 Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>
References: <20261116110853.3418077-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20261116110853.3418077-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K56bgsV9lh3Q/WdZUIszXDFbgDMOad3YBRMp42uEkvw8qFcVS8v
 oOozSIGSlPAfXBvbPUoecVbIrkgCPMVOJbQeSsnCaL6E4QNaKr4IWI3GLnsWXg03pUx4UlJ
 rBuH9WvrdfjPKJLACzzBaQtl9xtuEuryjlEUC1yZSZ9dE66GMTx14HforuGulC4R7Rcv0j5
 6HDDXqU2MEbXRKSz+CcZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AS4lDRpVi6I=;f+c4tspnp6j/GiCO0g08Mi3by/H
 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

Am 16.11.26 um 12:08 schrieb Uwe Kleine-K=C3=B6nig:

> Driver overriding is useful only in a very limited set of situations
> and then only with very few drivers that are designed to support that.
>
> Disallow matching via driver_override unless the driver explicitly
> allows it or the safe guard is disabled using the
> "allow_driver_override=3D1" kernel parameter.
>
> There are many drivers that don't expect to be force-bound and often
> doing it anyhow results in a NULL pointer exception. To make debugging
> such cases easier, add a new taint if such a forced match happens.
>
> Implementation detail: device_match_driver_override() isn't a static
> inline any more. It grew a certain complexity (e.g. a pr_info()) and so
> was made a regular exported function.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> this is a rebase to current next of the series
> https://lore.kernel.org/all/cover.1790612298.git.u.kleine-koenig@baylibr=
e.com/
> . It combines the functionality of former patches #2 and #3 (#1 was a
> fix that was already applied). I also addressed sashiko's comments. I th=
ink
> this matches what most people want in the previous discussion.
>
> As the rebase wasn't trivial and I merged the two patches, I didn't
> apply the review tags I already received for v3.
>
> If this patch is accepted, a number of drivers that are supposed to be
> force-bound need to get their .support_driver_override property set. I'm
> aware of the following:
>
>   - spidev_spi_driver in drivers/spi/spidev.c
>   - stub_driver in drivers/pci/pci-stub.c
>   - uio_dmem_genirq in drivers/uio/uio_dmem_genirq.c
>   - uio_pci_driver in drivers/uio/uio_pci_generic.c
>   - uio_pdrv_genirq in drivers/uio/uio_pdrv_genirq.c
>   - vfio_amba_driver in drivers/vfio/platform/vfio_amba.c
>   - vfio_ccw_sch_driver in drivers/s390/cio/vfio_ccw_drv.c
>   - vfio_pci_driver in drivers/vfio/pci/vfio_pci.c
>   - vfio_platform_driver in drivers/vfio/platform/vfio_platform.c
>
> This is not needed for the userspace i2c driver.
>
> As the flag to set is only introduced in this patch and assuming this
> patch is accepted, I suggest to create an immutable branch for it to
> allow setting the needed flags in driver trees. Alternatively let all
> these go together via a single tree or branch.
>
> Best regards
> Uwe
>
>   .../admin-guide/kernel-parameters.txt         |  6 +++
>   Documentation/admin-guide/tainted-kernels.rst | 54 ++++++++++---------
>   drivers/base/bus.c                            | 50 +++++++++++++++++
>   include/linux/device.h                        | 19 +------
>   include/linux/device/driver.h                 |  2 +
>   include/linux/panic.h                         |  3 +-
>   include/trace/events/module.h                 |  3 +-
>   kernel/panic.c                                |  3 +-
>   tools/debugging/kernel-chktaint               |  9 ++++
>   9 files changed, 104 insertions(+), 45 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documenta=
tion/admin-guide/kernel-parameters.txt
> index 85804cfe7ef6..aabc97feef9b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -424,6 +424,12 @@ Kernel parameters
>   			do not want to use tracing_snapshot_alloc() as it needs
>   			to be done where GFP_KERNEL allocations are allowed.
>  =20
> +	allow_driver_override=3D
> +			When set to 1 allow matching drivers without
> +			.support_driver_override =3D true to devices using
> +			driver_override. This is a dangerous operation in
> +			general allowing root to oops the kernel.
> +
>   	allow_mismatched_32bit_el0 [ARM64,EARLY]
>   			Allow execve() of 32-bit applications and setting of the
>   			PER_LINUX32 personality on systems where only a strict
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentati=
on/admin-guide/tainted-kernels.rst
> index fcb8b9734548..e6bab575ccef 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -74,35 +74,36 @@ a particular type of taint. It's best to leave that =
to the aforementioned
>   script, but if you need something quick you can use this shell command=
 to check
>   which bits are set::
>  =20
> -	$ for i in $(seq 0 19); do echo $i $(($(cat /proc/sys/kernel/tainted)>=
>$i&1));done
> +	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>=
>$i&1));done
>  =20
>   Table for decoding tainted state
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  =20
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Bit  Log  Number  Reason that got the kernel tainted
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  0  G/P       1  proprietary module was loaded
> -  1  _/F       2  module was force loaded
> -  2  _/S       4  kernel running on an out of specification system
> -  3  _/R       8  module was force unloaded
> -  4  _/M      16  processor reported a Machine Check Exception (MCE)
> -  5  _/B      32  bad page referenced or some unexpected page flags
> -  6  _/U      64  taint requested by userspace application
> -  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
> -  8  _/A     256  ACPI table overridden by user
> -  9  _/W     512  kernel issued warning
> - 10  _/C    1024  staging driver was loaded
> - 11  _/I    2048  workaround for bug in platform firmware applied
> - 12  _/O    4096  externally-built ("out-of-tree") module was loaded
> - 13  _/E    8192  unsigned module was loaded
> - 14  _/L   16384  soft lockup occurred
> - 15  _/K   32768  kernel has been live patched
> - 16  _/X   65536  auxiliary taint, defined for and used by distros
> - 17  _/T  131072  kernel was built with the struct randomization plugin
> - 18  _/N  262144  an in-kernel test has been run
> - 19  _/J  524288  userspace used a mutating debug operation in fwctl
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Bit  Log   Number  Reason that got the kernel tainted
> +=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  0  G/P        1  proprietary module was loaded
> +  1  _/F        2  module was force loaded
> +  2  _/S        4  kernel running on an out of specification system
> +  3  _/R        8  module was force unloaded
> +  4  _/M       16  processor reported a Machine Check Exception (MCE)
> +  5  _/B       32  bad page referenced or some unexpected page flags
> +  6  _/U       64  taint requested by userspace application
> +  7  _/D      128  kernel died recently, i.e. there was an OOPS or BUG
> +  8  _/A      256  ACPI table overridden by user
> +  9  _/W      512  kernel issued warning
> + 10  _/C     1024  staging driver was loaded
> + 11  _/I     2048  workaround for bug in platform firmware applied
> + 12  _/O     4096  externally-built ("out-of-tree") module was loaded
> + 13  _/E     8192  unsigned module was loaded
> + 14  _/L    16384  soft lockup occurred
> + 15  _/K    32768  kernel has been live patched
> + 16  _/X    65536  auxiliary taint, defined for and used by distros
> + 17  _/T   131072  kernel was built with the struct randomization plugi=
n
> + 18  _/N   262144  an in-kernel test has been run
> + 19  _/J   524288  userspace used a mutating debug operation in fwctl
> + 20  _/Z  1048576  a driver was forced on a non-matching device
> +=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =20
>   Note: The character ``_`` is representing a blank in this table to mak=
e reading
>   easier.
> @@ -189,3 +190,6 @@ More detailed explanation for tainting
>    19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_=
DEBUG_WRITE
>        to use the devices debugging features. Device debugging features =
could
>        cause the device to malfunction in undefined ways.
> +
> + 20) ``Z`` if a device was matched using the `driver_override` sysfs pr=
operty
> +     to a driver that didn't explicitly allow that.
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 396097fdb316..5344b20488fd 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -603,6 +603,56 @@ int bus_add_device(struct device *dev)
>   	return error;
>   }
>  =20
> +static bool __read_mostly allow_driver_override;
> +
> +static int __init allow_driver_override_setup(char *str)
> +{
> +	if (!str || kstrtobool(str, &allow_driver_override) < 0)
> +		allow_driver_override =3D true;
> +
> +	return 1;
> +}
> +__setup("allow_driver_override=3D", allow_driver_override_setup);
> +
> +/**
> + * device_match_driver_override() - Match a driver against the device's=
 driver_override.
> + * @dev: device to check
> + * @drv: driver to match against
> + *
> + * Returns > 0 if a driver override is set and matches the given driver=
, 0 if a
> + * driver override is set but does not match, or < 0 if a driver overri=
de is not
> + * set at all.
> + */
> +int device_match_driver_override(struct device *dev,
> +				 const struct device_driver *drv)
> +{
> +	guard(spinlock)(&dev->driver_override.lock);
> +	if (dev->driver_override.name) {
> +		int ret =3D !strcmp(dev->driver_override.name, drv->name);
> +
> +		if (ret > 0 && !drv->support_driver_override) {
> +			if (allow_driver_override) {
> +				add_taint_module(drv->owner,
> +						 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
> +			} else {
> +				/*
> +				 * If you hit this warning and you need to
> +				 * quickly workaround this check, boot with
> +				 * allow_driver_override=3D1 on the kernel
> +				 * commandline. The right fix is to set the
> +				 * driver's .support_driver_override property.
> +				 */
> +				dev_warn(dev, "Suppressed driver override binding to %s.\n", drv->n=
ame);
> +				return -1;
> +			}
> +		}
> +
> +		return ret;
> +	}
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(device_match_driver_override);
> +
>   static void __bus_probe_device(struct device *dev)
>   {
>   	struct subsys_private *sp =3D bus_to_subsys(dev->bus);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6b082c638d45..05413c1a9454 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -907,23 +907,8 @@ static inline bool device_has_driver_override(struc=
t device *dev)
>   	return !!dev->driver_override.name;
>   }
>  =20
> -/**
> - * device_match_driver_override() - Match a driver against the device's=
 driver_override.
> - * @dev: device to check
> - * @drv: driver to match against
> - *
> - * Returns > 0 if a driver override is set and matches the given driver=
, 0 if a
> - * driver override is set but does not match, or < 0 if a driver overri=
de is not
> - * set at all.
> - */
> -static inline int device_match_driver_override(struct device *dev,
> -					       const struct device_driver *drv)
> -{
> -	guard(spinlock)(&dev->driver_override.lock);
> -	if (dev->driver_override.name)
> -		return !strcmp(dev->driver_override.name, drv->name);
> -	return -1;
> -}
> +int device_match_driver_override(struct device *dev,
> +				 const struct device_driver *drv);
>  =20
>   /**
>    * device_iommu_mapped - Returns true when the device DMA is translate=
d
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver=
.h
> index 29fbc01ef06f..0153cfcbe1b9 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -56,6 +56,7 @@ enum probe_type {
>    * @bus:	The bus which the device of this driver belongs to.
>    * @owner:	The module owner.
>    * @mod_name:	Used for built-in modules.
> + * @support_driver_override: driver_override only works if this is true=
.
>    * @suppress_bind_attrs: Disables bind/unbind via sysfs.
>    * @probe_type:	Type of the probe (synchronous or asynchronous) to use=
.
>    * @of_match_table: The open firmware table.
> @@ -104,6 +105,7 @@ struct device_driver {
>   	struct module		*owner;
>   	const char		*mod_name;	/* used for built-in modules */
>  =20
> +	bool support_driver_override;
>   	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
>   	enum probe_type probe_type;
>  =20
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 17e61b61c45f..009232511cc7 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -89,7 +89,8 @@ static inline void set_arch_panic_timeout(int timeout,=
 int arch_default_timeout)
>   #define TAINT_RANDSTRUCT		17
>   #define TAINT_TEST			18
>   #define TAINT_FWCTL			19
> -#define TAINT_FLAGS_COUNT		20
> +#define TAINT_DRIVER_OVERRIDE		20
> +#define TAINT_FLAGS_COUNT		21
>   #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
>  =20
>   struct taint_flag {
> diff --git a/include/trace/events/module.h b/include/trace/events/module=
.h
> index e5a006be9dc6..d54ce3c7572b 100644
> --- a/include/trace/events/module.h
> +++ b/include/trace/events/module.h
> @@ -26,7 +26,8 @@ struct module;
>   	{ (1UL << TAINT_OOT_MODULE),		"O" },		\
>   	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
>   	{ (1UL << TAINT_CRAP),			"C" },		\
> -	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" })
> +	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
> +	{ (1UL << TAINT_DRIVER_OVERRIDE),	"Z" })
>  =20
>   TRACE_EVENT(module_load,
>  =20
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 91e48d33b7db..81ea9ef9afb0 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -825,6 +825,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUN=
T] =3D {
>   	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
>   	TAINT_FLAG(TEST,			'N', ' '),
>   	TAINT_FLAG(FWCTL,			'J', ' '),
> +	TAINT_FLAG(DRIVER_OVERRIDE,		'Z', ' '),
>   };
>  =20
>   #undef TAINT_FLAG
> @@ -861,7 +862,7 @@ static void print_tainted_seq(struct seq_buf *s, boo=
l verbose)
>    * exact size is allocated dynamically; the initial buffer remains
>    * as a fallback if allocation fails.
>    *
> - * The verbose taint string currently requires up to 327 characters.
> + * The verbose taint string currently requires up to 348 characters.
>    */
>   #define INIT_TAINT_BUF_MAX 350
>  =20
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-ch=
ktaint
> index e1571c04afb5..56215e0f5112 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -211,6 +211,15 @@ else
>   	addout "J"
>   	echo " * fwctl's mutating debug interface was used (#19)"
>   fi
> +
> +T=3D`expr $T / 2`
> +if [ `expr $T % 2` -eq 0 ]; then
> +	addout " "
> +else
> +	addout "Z"
> +	echo " * A device was matched using driver_override to a driver not su=
pporting that (#20)"
> +fi
> +
>   echo "Raw taint value as int/string: $taint/'$out'"
>  =20
>   # report on any tainted loadable modules
>
> base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
