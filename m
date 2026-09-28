Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C94F3EAD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613982; cv=none; b=tvK1UQUHx/+1Kal8312TcEjzOm9z4bwTb9Y/oYxr2CiImR3God1Jv8W6oFLRdkbH+QI69HRFMv2dxuVBRfPasvTgmTnz2AQMupPrmH1IWTv3FfNE+Ww+rQQbeh0MF8T14YOBxr7fUsNsisgBjHL/3zf8pbLVTLmr0AyDQHXmf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613982; c=relaxed/simple;
	bh=KpNazNXaXXTuEd6aII+wEbMTU3C6IVKFGnlCgd13K6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ShxY2mpAHGsl3Hn8cWQHyqD5VcFe188RN1oR9066lvB5b0Sm4fDzT35JVWAHZg1u+Ep/zonEBiMYHy4muOJQ6RQFMv7hucZXjeRs6WWK0t/r2ZWhGCErcg5/L2nrHfnSxy8yhSWYNRCC6aDmbU29AsZJU7jr44KU3ZyDXRm3pus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pFj0h7Wq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pFj0h7Wq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48439feca17so2494489f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790613977; x=1791218777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5GwAf+IjDhIwgqauwPEbphHUtSFV6p4EjKCFg95BcnY=;
        b=pFj0h7WqeLZCHO8C5i/eUt5n+1vn12CGLkMy9mF9vdIuR04vE/pn0llHgdmlnxCxB8
         AQgCd+VokokXI+KBCLUHD8+FgMzZDU1n7NbTMK6B7b0PUlYvrJc5GvMpy+W3qhSMK8CQ
         nKUWlQ5K4uzT75exD7+Yd3rjNsaYWjljPkPRB+qp1RYV1VUpyrZ7C2aJcMpEZdwFL5/N
         Lb4LgrbKUcSv3FeCO4o4/3/Cxn760FNnCbFYWkosweH3flIVdZ59evQ4+EcHiveQNZh7
         TrpI14Fhqk3U0qnhsqU0xXowEb+mmWkVhjY1TwsQ4Bs4YsvbSWc5TdxrKMayGZ17zD63
         qI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613977; x=1791218777;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5GwAf+IjDhIwgqauwPEbphHUtSFV6p4EjKCFg95BcnY=;
        b=bNnZQOgfCdlpQdqtsZc63AoUvWtXMf+ATs5MGcZbeW/cIkUr2f7a7PsxgTigsRZpQL
         h5zFC583syCBKn1JWehWqVvq2G4hXfmy/aQ3OlO3tdDYnX2UTyk3Zh4U96y1cRd2Z03e
         TskjBo/d5iIW0CmiT33lqQd6uPDs/BuGWtfVbaH9kWFgMlKhjO7CYJi7SC27Hhf1DgG8
         MsPFPJM6IR5gIlxwqVHKiTDxjjJpYD5nLCpimJUIh3mpGhB3XEnzk5OHGxPOkP3JmdW4
         KW2wjKNrMU8TODwzDoMCI9g8HV85Om2JxhCWQaGXUvGtn/HK0DMqgtelD6TYgSQRAOeL
         4UDA==
X-Forwarded-Encrypted: i=1; AKwUvBxv1Z/RpVKdS85Met588MV8WTCNnTzmS8UnnwwK9J4RBUgu+tKfxF4W0AoirwpG/aZL+hBaDDC0DjGWRiTDRwnlj2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNbrk3cAfGxI3BCOC52EO+njbFDgZAfPNSi7wF9dH2RdcQy/NG
	GaYOyQKjkMUx/kILzO/siq7MQ1hBoRZZkvH4+YhDzcoeyiBF9nPHjckWQx1nRf24Hlc=
X-Gm-Gg: AYBFou3JlueCIq8W/gWcCsZqrwFglLx0Xo3F/Fe29n2igrxVZP3HP6+vFw3olG0lKg+
	FSivbtlcg5ci/l4qxq39cLNAFFJqQrEqVLbzSO2B10N9ntGo3Nu/71wHlRDYl5N2HCdM2L64MrR
	9MA8NQNAmXEDgnL6EH+CzvYDBDYGhMSkeY1+sWa7z7GzVqdKzQXv+EfrBfcuehTy6jia+iuXrUC
	PGV9IvUJuAK3BtG65U0wTvE0xFmyNPQJ4WirxrAe1AwF0gFLg8vwf0kvgGEwbW1dMemLmvBCCim
	6m1XyEstT4gGtUtoJC4FSTzsBPWnUEmXAf6xX4ig+RTJAdt4aJakfo/rleG0Ag50QqajtUqUgqU
	XNf3GisvUlol2YyrOPwCG925vzmTPVVGoUzpotS3qiZYUAgD7DhYtttLPq7N2J2yL5OwB/e+bU3
	14HimbfItNbHFgqBzrvL0LzbhVwWtLGhysoTVFgoJUdv8ZKLhQjQ+EFhDp1pbtD4tzcZE+x5a4X
	/TBq3J2DYo5wUjzE9KO9mgWF7tk1FgnIC0eCr1bHpcvWQBqCU9KolrVXN91MQ==
X-Received: by 2002:a05:6000:26c1:b0:487:21a5:de4e with SMTP id ffacd0b85a97d-48871769a31mr26429158f8f.35.1790613976652;
        Mon, 28 Sep 2026 09:46:16 -0700 (PDT)
Received: from localhost (p200300f65f19a90433f74747aea68541.dip0.t-ipconnect.de. [2003:f6:5f19:a904:33f7:4747:aea6:8541])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4887a354c47sm30123480f8f.15.2026.09.28.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:46:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Bradley Morgan <brads@mainlining.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
Date: Mon, 28 Sep 2026 18:46:01 +0200
Message-ID: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9599; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KpNazNXaXXTuEd6aII+wEbMTU3C6IVKFGnlCgd13K6A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqupnJy8WFjGeeXx/h284c8LWplbwsrQHZAwAo5 4KoAG6ouNKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarqZyQAKCRCPgPtYfRL+ Tht+B/9YXIwGHUOguEsNGTpaKBqEciycGhPkCO6oMjLVfyXHEQ7DUm/iIzpJmNVfP90NCKaEMgG ytQQqsnYqgmv14bx3y8wgduPSr+9PjlMeYzVxdAFNVcdhZzta+ahYNkYE6KquqqTnztv/4oC6i9 KOPYuDzkR7bRjF7/tEUuOpNJYLNLN5tS1G+CvdbiLw9RjnrgF1m6Ro+OIPCPmtbZHB7b5qBOSa7 32WOcx4IqbT/rE2tOpR/oKyFweWWoWzWaCtiByyN+EsjloOsIpYIFREMNBbTXPpLwMXZx3GIcMD rOxXLl69/he4f/+/kBJF1qtIrSmfPQWpxIqVul7FLqV+56nK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series unifies two different approaches:

 - tainting the kernel on setting up a driver_override
 - disabling driver_override by default, with giving drivers the ability
   to allow themselves in.

The first is an idea that arised by Greg implementing a taint for
writing to the bind and unbind driver properties. Both Danilo and me
came up with the theory that driver_override is the real culprit if
manual binding is problematic.

The second originates from an effort by Thierry who implemented the
reverse of patch #3: Drivers could opt-out of driver_overriding. See
https://lore.kernel.org/lkml/20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com
. This patch is new compared to the v2 series with the same subject.

Note that different to Danilo's suggestion I don't differentiate between
driver_overrides setup in userspace and those setup in kernel space.
IMHO all are bad and there are alternatives for the legitimate cases.
Also I didn't make an effort to identify drivers that should continue to
be able to override a driver. This can still be done when patch #3 is
considered to be the way to go. (And I'm sure that it will be noticed
quickly if we miss a legitimate use case. Still I think forbidding
driver_override should cook in next for a while before it's merged to
catch at least the most common cases.)

I think applying this complete patch set and keeping fcbfaffee51a ("driver
core: add TAINT_FORCED_BIND for when userspace manually messes with devices and
drivers") is too much, so this series serves mainly as discussion ground for
choosing a sane way to prevent fuzzing results of only mild interest and stop
patch sets harding drivers for driver_override handling.
My preference would be to revert (or drop) fcbfaffee51a and then only
apply patch #3. Maybe also keep patch #2 to taint if
"allow_driver_override" is provided.

To make it possible to let a driver allow being used in an override, the place
where the check if the override should be honered had to move, as the place
where it was checked in v2 didn't have the driver available. As this is a
relevant change I dropped the Acks I already received. Also an upside is that
this way the module is known that contains the overridden driver.

My test-case was using the tegra-pwm driver, which I could trigger using:

	cd /sys/bus/platform
	echo tegra-pwm > devices/watchdog/driver_override
	modprobe pwm-tegra

on an stm32mp135. With this patchset applied this either ends in:

	[   65.243492] Suppress driver override binding. Allow tegra_pwm_driver [pwm_tegra] to do overriding or boot with allow_driver_override on cmdline

(when the kernel parameter isn't provided) or

	[   65.440208] 8<--- cut here ---
	[   65.441886] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
	[   65.452547] [00000000] *pgd=00000000
	[   65.454748] Internal error: Oops: 5 [#1] SMP ARM
	[   65.459397] Modules linked in: pwm_tegra(Z+)
	[   65.463664] CPU: 0 UID: 0 PID: 243 Comm: modprobe Tainted: G                    Z 7.3.0-rc4-next-20260925+ #52 PREEMPT 
	[   65.474443] Tainted: [Z]=DRIVER_OVERRIDE
	[   65.478378] Hardware name: STM32 (Device Tree Support)
	[   65.483519] PC is at tegra_pwm_probe+0x20/0x224 [pwm_tegra]
	[   65.488995] LR is at _raw_spin_unlock_irqrestore+0x3c/0x68
	[   65.494555] pc : [<bf00014c>]    lr : [<c0fbb22c>]    psr: 60010013
	[   65.500803] sp : c56bbd18  ip : 00000000  fp : 0043b2f0
	[   65.506045] r10: c1d99d8c  r9 : c174c220  r8 : 00000000
	[   65.511188] r7 : bf002014  r6 : c201b000  r5 : bf002014  r4 : c201b010
	[   65.517736] r3 : 00000004  r2 : 00000018  r1 : 00000001  r0 : 00000000
	[   65.524286] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
	[   65.531441] Control: 10c5387d  Table: c525806a  DAC: 00000051
	[   65.537185] Register r0 information: NULL pointer
	[   65.541839] Register r1 information: non-paged memory
	[   65.546888] Register r2 information: non-paged memory
	[   65.551937] Register r3 information: non-paged memory
	[   65.556986] Register r4 information: slab kmalloc-1k start c201b000 pointer offset 16 size 1024
	[   65.565689] Register r5 information: 1-page vmalloc region starting at 0xbf002000 allocated at load_module+0x830/0x21fc
	[   65.576486] Register r6 information: slab kmalloc-1k start c201b000 pointer offset 0 size 1024
	[   65.585085] Register r7 information: 1-page vmalloc region starting at 0xbf002000 allocated at load_module+0x830/0x21fc
	[   65.595873] Register r8 information: NULL pointer
	[   65.600521] Register r9 information: non-slab/vmalloc memory
	[   65.606174] Register r10 information: non-slab/vmalloc memory
	[   65.611927] Register r11 information: non-paged memory
	[   65.617076] Register r12 information: NULL pointer
	[   65.621923] Process modprobe (pid: 243, stack limit = 0x6ee59a55)
	[   65.627977] Stack: (0xc56bbd18 to 0xc56bc000)
	[   65.632320] bd00:                                                       bf002014 c175d098
	[   65.640481] bd20: c201b010 bf002014 c175d098 bf002014 00000000 c0993270 c201b010 00000000
	[   65.648642] bd40: c175d098 c09904bc 0043b2f0 c0fbb128 c201b010 c175d098 bf002014 c201b010
	[   65.656903] bd60: c5183cd8 c09908a8 bf002014 c0fbb098 c5183cd8 c1db524c bf002014 00000031
	[   65.665065] bd80: c201b010 c5183cd8 c174c220 c1d99d8c 0043b2f0 c0990b10 c201b010 bf002014
	[   65.673226] bda0: c0990d08 c2174400 c5183cd8 c0990e0c c174c220 c201b07c 00000000 bf002014
	[   65.681387] bdc0: c0990d08 c098dd3c c21744e0 c21744ac c2017414 3c5c6832 00000000 c5183c80
	[   65.689548] bde0: 00000000 bf002014 c2174400 c098f3dc bf004098 bf006000 bf002014 c160805c
	[   65.697709] be00: 0043b2f0 bf006000 00000000 c0991a1c c2cbd640 c160805c c2cbd640 c0116c60
	[   65.705970] be20: c2001240 dcfb9324 00000cc0 c2cbd640 00000000 c02271d0 00000010 c0453e00
	[   65.714132] be40: 00000cc0 ffffffff c0453c74 00000000 c022999c c15d2324 c565ba80 c02271d0
	[   65.722293] be60: 00000010 00000000 00000000 3c5c6832 00002b1c 3c5c6832 c565ba80 bf002080
	[   65.730454] be80: 0043b2f0 c52f7800 00000000 c373f0f8 c1d99d8c c0227200 00000000 c52f7800
	[   65.738615] bea0: 0043b2f0 c02299c0 c56bbebc 7fffffff 00000000 00000002 c2cbd640 ddaf4000
	[   65.746776] bec0: ddaf515d ddaf4758 ddaf4000 00002b1c ddaf64dc ddaf6358 ddaf59c8 00000340
	[   65.755037] bee0: 00000480 00000cdc 0000061d 00000000 00000ccc 00000025 00000026 0000000e
	[   65.763198] bf00: 00000000 0000001d 00000000 00000000 00000000 3c5c6832 c52f7800 c1d99d10
	[   65.771359] bf20: c1d99d00 c0229dc0 c56bbfb0 c0100290 c0100290 0000001f c373f0f8 00000000
	[   65.779521] bf40: c1d99d8c 00000000 00000000 dead4ead ffffffff ffffffff c1d9a110 00000000
	[   65.787682] bf60: 00000000 c1313314 c0000200 c56bbf6c c56bbf6c fffffffc bea8191c 3c5c6832
	[   65.795843] bf80: 00000006 00000000 01f4e1f8 00000000 0000017b c0100290 c2cbd640 0000017b
	[   65.804105] bfa0: 00000000 c0100060 00000000 01f4e1f8 00000003 0043b2f0 00000000 00000000
	[   65.812266] bfc0: 00000000 01f4e1f8 00000000 0000017b 01f4d290 0043e0a8 00000001 00000000
	[   65.820427] bfe0: bea81940 bea81930 00436d83 b6ef28f2 40010030 00000003 00000000 00000000
	[   65.828581] Call trace: 
	[   65.828603]  tegra_pwm_probe [pwm_tegra] from platform_probe+0x64/0x98
	[   65.837609]  platform_probe from really_probe+0xe8/0x424
	[   65.842974]  really_probe from __driver_probe_device+0xb0/0x234
	[   65.848834]  __driver_probe_device from driver_probe_device+0x3c/0xc0
	[   65.855298]  driver_probe_device from __driver_attach+0x104/0x238
	[   65.861359]  __driver_attach from bus_for_each_dev+0x78/0xc8
	[   65.867018]  bus_for_each_dev from bus_add_driver+0xe8/0x238
	[   65.872674]  bus_add_driver from driver_register+0x8c/0x140
	[   65.878232]  driver_register from do_one_initcall+0x74/0x3f8
	[   65.883902]  do_one_initcall from do_init_module+0x58/0x24c
	[   65.889469]  do_init_module from init_module_from_file+0xf0/0x10c
	[   65.895634]  init_module_from_file from sys_finit_module+0x150/0x330
	[   65.901901]  sys_finit_module from ret_fast_syscall+0x0/0x1c
	[   65.907561] Exception stack(0xc56bbfa8 to 0xc56bbff0)
	[   65.912609] bfa0:                   00000000 01f4e1f8 00000003 0043b2f0 00000000 00000000
	[   65.920871] bfc0: 00000000 01f4e1f8 00000000 0000017b 01f4d290 0043e0a8 00000001 00000000
	[   65.929029] bfe0: bea81940 bea81930 00436d83 b6ef28f2
	[   65.934078] Code: e1a06000 e2800010 eb71038f e3a02018 (e5901000) 
	[   65.941032] ---[ end trace 0000000000000000 ]---

Also the comment in patch #2 was fixed for the off-by-one that Sashiko found,
the remaining feedback doesn't apply any more.

Best regards
Uwe

Uwe Kleine-König (3):
  docs: admin-guide: Handle TAINT_FORCED_BIND when parsing
    /proc/sys/kernel/tainted
  Add TAINT_DRIVER_OVERRIDE for usage of driver_override
  driver core: Disable driver overriding by default

 Documentation/admin-guide/tainted-kernels.rst |  6 ++-
 drivers/base/bus.c                            | 43 +++++++++++++++++++
 include/linux/device.h                        | 19 +-------
 include/linux/device/driver.h                 |  2 +
 include/linux/panic.h                         |  3 +-
 include/trace/events/module.h                 |  3 +-
 kernel/panic.c                                |  3 +-
 tools/debugging/kernel-chktaint               |  8 ++++
 8 files changed, 66 insertions(+), 21 deletions(-)


base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
-- 
2.47.3
