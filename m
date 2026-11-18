Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046245;
	b=31Or7nFvVSbAB9n8rxxanBD7F/hixb1WHtIsJddRaUtF6cc5LboF6xVLNa9/hByy7Zdj
	 1e3qYddobBzooBAyCU4CKTxguh/U50eBu/gEypi8YAMiqBPWUkz6bA0waHasdlNKPM0Hm
	 SMRK99XpC5eZZBVBBFHRj14rskxmJQ21tFeBo4uzN1mnJQRjXVjORR1QamOs+bSKhuKsl
	 MR1GrGA0Cy64/ovc/VzdFbtVSzCPawTsAKdRJrVS8vqE3Ga2N6StH/kPu1elJ4ZlCfaOm
	 AidnhAVNF+mbDoai1vroBoSJ70DURMffVyiw11cNXSWy0yZCMVLs1n+9nHGhnmPmMdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046245;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=hGkc2X+O0aenFipJnJuCddUF3up8YjP06AEbn7gF8WU=;
	b=o5RTo1W4B6yvZRoQI9iyxddsZZXSVu7YW78+xfSXn/IYXDxT+Y6Q3tyZTxBxKcsXI21O
	 ZEqMvcpW5Ou1pCPdWfSu5hpgs0XigQEfbbdXeS+qUYTVAjDsXONbrs9szMVmqb0bu7Dca
	 pM82v4UdBmIKIQTmlL6j725PJXhl4Wcmwd4eMiXYJOqewJFC4NZoL0Ril3yrpIpsUMjo+
	 ziZ4bb1VsF0Kfs0GCpTcDlmM7g/kT9ZoKav9ZOnTGPWq4Afm7ijXB1A0AAIN1W9GbDQ6M
	 oHPNqMD+4IyiNeaG8Xvu6gme8G6IpZ9tFyLq+E1EqHdmv4gCfn8K1cLh6QswSrHMPeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=A7foanMU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3RkSpiOv;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF55606A320
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 23:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FF55606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=A7foanMU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3RkSpiOv
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8FA7B14001AF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 18:57:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 18:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795046242; x=
	1795132642; bh=hGkc2X+O0aenFipJnJuCddUF3up8YjP06AEbn7gF8WU=; b=A
	7foanMUPUfxIv3H1FmDkyuzbxOrNYzCiiZ1by2+ly7U+jwKgB8zqOVvB8DqS36ZQ
	R3qPvZIBwJKODFDu2VYsWrK7VmPWVmovNW6ZCYul36VhEfNiFfTwFZS4q556SiL5
	4pkgJFO0WYEy0L6IPx1HWyEnIaEyBR9jZnhIydDB1gv+ELprFrrGx+Y/DMGN+rFC
	USlQZqu7pIZMbDsRRWCMgA0JOYrNI3gzmFXNMWojNRsPqIINo9FXCfRTho4RP/Kn
	vB4pp9XdjdWQxG8YT8sID4mBgYbB3jvJ1JPxzkOtLv4BWE1VP+scZBYJEAqMZYQb
	sJgAS0KEmf5EMVhHEskag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795046242; x=1795132642; bh=h
	Gkc2X+O0aenFipJnJuCddUF3up8YjP06AEbn7gF8WU=; b=3RkSpiOv7+ef9rqjv
	rUUw5AIdUVO9YnKOv9jpRW3jXFfL+v5kVXGl5r6lg6DCOpT4FLTy9XvTF5Kv7+Ei
	glf0F1W9yeskG8xBGIhcZdOzNFtpbdyUJZ8+flQVYEbbCgcZkFAr/7S3DOc8inrr
	m8IY59bG+8dixNFIK+Tc9WSWv8seByDZlMc5QR+QHjDQ0GfQ6Ha9RCz0gr0OR68l
	W75Gm1m3pF0AFgYJzRp4GSm+Wj/CBrtZF0H6qIYO4Tbk45PP0XVmi+upkVgP230l
	t6YHRy47ziF3z38GE8z8Z5ohy7+mKqmgQv9he2yqpZ4ck2+KlFshq/UIRE/q10RU
	9h+KQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795046242; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jywsr0kdIFrwoINcdUT9u2Ib+Jws5RQYRRCkhCVhMyx1FvL
	6U+3Gk/jYDa+VwD44gixwberPWl6ekD67h0WHER6jtcMIDHRKBHB6I+lKBa44KUw
	IYBrFB6Ec1mjVH9KzN65sDZhlipOXdij1+xYfS+WfFstOVQG8NHLR2RYQQ3yS3Vx
	O7DXwPOQ/Bkj2kBKUraKnUzgPIRuudl8zrxgm3arvUHTQf9AfUSNUymwYHgOHk46
	jglz7VRfILDRxNS7aErYinl4Qfn7s+t9a5RBm908BvgGkvHpBCV8i6gARkBtjNth
	mE2kH2gjjGf4+G5FbUbLOivmW6zrl3sn1VAWWpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:G6j1WEbAHIq8tWmPJmZZjibdOMkBo5R3V8kRbHFfYgk=:TQvuQbnPhs7gSThCadxJaJQQTnwfP3uEZUne5G+6jaY=;
X-ME-Sender: <xms:Xzv-aiHQ9j-S5ueg19b6lfr9ws1pGbGaGXHq0zE10VzWphYwHGk-5Q>
    <xme:Xzv-akm4VSOI6jDqluwD8uyXoVA4t5iYF3643I2IuE22ruPOAyl-OrwiLWUTZruUW
    XNuW-3qoq3jVDNoMAaLfev-2vB38C5o9ExK4Og-WH06U0C-9nWrq38>
X-ME-Received: <xmr:Xzv-apNqb9sRFzfeQ0TObntKdaVhKxHsPsSsfhYT6wfrXfbVxXxSm_4vBPDF3B7e9ZixTC2uvb0>
X-ME-Proxy-Cause: dmFkZTE0Qtik2h0LMLqrIgUWaI4CB2p93T0f1m2Kzl/l87lwNGBwuAOgQ+AfXvskrVJH2i
    p6ljHDZzG0CdtMT8T/gJ0T/Ti8sgeV3YeHpVIWrG+q0gmcN+rSNf86o5eLrSjjxw191yW8
    QIuwzR2/xbFWQj1RjX6bpXbsd5hi5tlZCTkPfY+KJY0UFP3Mvtfj1CKS2rlcsiSjEsKO6w
    cb1dgXvYDD+YDFjqo7iv6CO6NMKEUTzrEzlD1WbyPxC8PcFVxrf+LToTyWzvM6ACXwfG6h
    SY+FoWkIfjoa+LvWm3E3FkRmWzkd0723UYoRV8j3fBKkHkovoceJNgnLcDQpOIPuy/7Nqx
    ygevKGMYWzOodp2z/0YktPtXaILj/vFOCX20D35s3gJpaq9mBVH3cxqskd5V1crriXXNK6
    eEdtcVEJ1nzEs6LC/9cx8cg6p37d/t4I7m1EbbqJsLK0kC2O+eSuaR9EW1VqIwUmAlCFm4
    /GRq2UggEiJ4QZXe+/bW+PRDGg+48u60CZqg/FNZn+63LgWYsJZIw+93AHFDyYkrOg4LSG
    nAB92UkBH5u7VgvifKkxVw1/+aV0Kq7r1B9PA8G/LFV7IdgCLinBNWI9N5zCca4vKisFtW
    aeFstJ+I6b50r2tMGDdMpGqSQlLGgCG9Fq54GgbgrzWbuNVj8VkjaYbDrwwg
X-ME-Proxy: <xmx:Xzv-avF02BQ8n4g73EHJJZjI-AJeyThCD84z6V54fKZOR8AoSQdkCA>
    <xmx:Xzv-alvipkmumC-NaUJOo3495pRv7sntm5o3p2h1ZXEwlG6Path3ug>
    <xmx:Xzv-aqShcvD4y1hQxHNj8CA0rCwg-4ve_VylLntsHl7LcbLLyKFmGQ>
    <xmx:Xzv-agFZFdSGyJcdd6rw4KKEQxNavsCB5hTfO7O0NwRBN-MqZQkHFg>
    <xmx:Yjv-apYnMgJzheWFzJ63cPRZHEGj_u_5UGJwkguoka3gsS9UsFzZK2Va>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 18:57:16 -0500 (EST)
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Lechner <dlechner@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Allow untainted driver_override for PCI stub drivers
Date: Wed, 18 Nov 2026 16:56:43 -0700
Message-ID: <20261118235645.2907908-1-alex@shazbot.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the name suggests, the pci-stub driver is only a stub, it performs
no hardware access and is typically used only to prevent other drivers
from binding to the device.

Similarly, pci-pf-stub only interacts with devices through the SR-IOV
capability, and may be used to create VFs on any PF that otherwise does
not require a PF driver.

Both of these are often used with driver_override, as this is our
standard, non-racy mechanism for associating a driver to a device.
With the introduction of support_driver_override in driver core, this
use case needs to be explicitly flagged as safe or else the bind will
be denied or taint the kernel.  Declare these drivers as safe for use
with driver_override.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Alex Williamson <alex@shazbot.org>
---

Uwe, both these PCI stub drivers should allow driver_override use cases.
Thanks,

Alex

 drivers/pci/pci-pf-stub.c | 1 +
 drivers/pci/pci-stub.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
index da4db4928907..328fb4a57092 100644
--- a/drivers/pci/pci-pf-stub.c
+++ b/drivers/pci/pci-pf-stub.c
@@ -36,6 +36,7 @@ static struct pci_driver pf_stub_driver = {
 	.id_table		= pci_pf_stub_whitelist,
 	.probe			= pci_pf_stub_probe,
 	.sriov_configure	= pci_sriov_configure_simple,
+	.driver.support_driver_override = true,
 };
 module_pci_driver(pf_stub_driver);
 
diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index 9bc478df4e8f..acbd43c17adc 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -37,6 +37,7 @@ static struct pci_driver stub_driver = {
 	.id_table	= NULL,	/* only dynamic id's */
 	.probe		= pci_stub_probe,
 	.driver_managed_dma = true,
+	.driver.support_driver_override = true,
 };
 
 static int __init pci_stub_init(void)
-- 
2.54.0

