Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6815DBC0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812964; cv=none; b=V8CvtS2uh+zRVsLK+S7YpIdCn+MwU+fXdPpLzjuQ8EpRz95wSX8hvU8lRJ4mE8sFvYNAZFB8EUH/PyO7NSlDWyFzsBc/co+5SadJLl8gBGegdlwrSP1ebIeNAQoWfshUMfQTfj4XPyuXjGEGKiwe1Iw7pk7D+lFNbeD3nsSQtfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812964; c=relaxed/simple;
	bh=PeefpZ4YMEaZq6We0zHAHpGNCAdJO2/oxareeGrKrBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAw8rwEOQGtu+x6VTXpNJQp0Aobw2QVgrfUZWe0xJS9TNkyU2Jyh+1djN3URdPJy7B7Lp9nA+sPII2rrCoXupvlUKjNdoGffV4F+hKkp+jM+uAxBnm5iSHp7yTld4aABBnn7VqUgd+ulP2PrtTr4Vf/prxFYU/0GIb1SgMUcnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1sBZTI-00033f-OB; Mon, 27 May 2024 14:29:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1sBZTH-003BfM-Hp; Mon, 27 May 2024 14:28:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1sBZTH-00DCfv-1U;
	Mon, 27 May 2024 14:28:59 +0200
Date: Mon, 27 May 2024 14:28:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Thorsten Scherer <T.Scherer@eckelmann.de>, mark.rutland@arm.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>, 
	Doug Berger <doug.berger@broadcom.com>, mhiramat@kernel.org, kernel@pengutronix.de, ardb@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
Message-ID: <czbbd3mvqanerbcqgycy3bnvmfnbu5fhyzfujk2ijo2vnngnkn@6ldafursohkn>
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
 <z42qu35nuybho36bwjdoatqp3skwm7w2l4apd75ubzaezyvxef@f6yrdlgltlaf>
 <ZlQ8oDh/Kgkm1+WE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7xn6pigk3o4cbbv7"
Content-Disposition: inline
In-Reply-To: <ZlQ8oDh/Kgkm1+WE@shell.armlinux.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-trace-kernel@vger.kernel.org


--7xn6pigk3o4cbbv7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 08:56:16AM +0100, Russell King (Oracle) wrote:
> On Mon, May 27, 2024 at 09:43:41AM +0200, Thorsten Scherer wrote:
> > Hello,
> >=20
> > in the context of a panic on an i.MX25 based v6.9 kernel [1] Uwe pointe=
d me to
> > this thread.  With the proposed code change applied the procedure
> >=20
> >     # set to some known good (randomly guessed) filter function and ena=
ble function_graph
> >     echo mtdblock_open > set_ftrace_filter
> >     echo function_graph > current_tracer
> >=20
> >     # walk available filter funcs
> >     cat available_filter_functions | while read f; do echo $f | tee -a =
set_ftrace_filter; sleep 1; done
> >=20
> > produces the following output
> >=20
> > [  159.832173] Insufficient stack space to handle exception!
> > [  159.832241] Task stack:     [0xc8e44000..0xc8e46000]
> > [  159.842701] IRQ stack:      [0xc8800000..0xc8802000]
> > [  159.847712] Overflow stack: [0xc1934000..0xc1935000]
> > [  159.852726] Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
> > [  159.858273] Modules linked in: capture_events_imxgpt ti_ads7950 indu=
strialio_triggered_buffer kfifo_buf capture_events_irq capture_events iio_t=
rig_hrtimer industrialio_sw_trigger industrialio_configfs dm_mod
> > [  159.876948] CPU: 0 PID: 199 Comm: sh Not tainted 6.9.0 #3
> > [  159.882412] Hardware name: Freescale i.MX25 (Device Tree Support)
> > [  159.888547] PC is at prepare_ftrace_return+0x4/0x7c
> > [  159.893520] LR is at ftrace_graph_caller+0x1c/0x28
> > [  159.898376] pc : [<c010dd44>]    lr : [<c010d988>]    psr: 60000093
> > [  159.904690] sp : c8e44018  ip : c8e44018  fp : c8e4403c
> > [  159.909959] r10: c0c09e78  r9 : c35e9bc0  r8 : c010d9bc
> > [  159.915227] r7 : 00000001  r6 : 00000004  r5 : c8e44064  r4 : c8e440=
ac
> > [  159.921800] r3 : c8e44030  r2 : c8e4403c  r1 : c010eb9c  r0 : c8e440=
38
> > [  159.928376] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Se=
gment none
> > [  159.935652] Control: 0005317f  Table: 83074000  DAC: 00000051
> > [  159.941436] Register r0 information: 2-page vmalloc region starting =
at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > [  159.952253] Register r1 information: non-slab/vmalloc memory
> > [  159.957988] Register r2 information: 2-page vmalloc region starting =
at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > [  159.968791] Register r3 information: 2-page vmalloc region starting =
at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > [  159.979592] Register r4 information: 2-page vmalloc region starting =
at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > [  159.990391] Register r5 information: 2-page vmalloc region starting =
at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > [  160.001187] Register r6 information: non-paged memory
> > [  160.006303] Register r7 information: non-paged memory
> > [  160.011415] Register r8 information: non-slab/vmalloc memory
> > [  160.017139] Register r9 information: slab kmalloc-32 start c35e9bc0 =
pointer offset 0 size 32
> > [  160.025718] Register r10 information: non-slab/vmalloc memory
> > [  160.031530] Register r11 information: 2-page vmalloc region starting=
 at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > [  160.042422] Register r12 information: 2-page vmalloc region starting=
 at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > [  160.053315] Process sh (pid: 199, stack limit =3D 0x68fc3abb)
> > [  160.058955] Stack: (0xc8e44018 to 0xc8e46000)
>=20
> No backtrace? No Code: line? I'm guessing there was an attempt to ftrace
> a function involving the ftrace tracing infrastructure, which is why 8KB
> of stack has been gobbled up. It could be
> copy_from_kernel_nofault_allowed() but it would be useful to have at
> least some extract of the backtrace showing the recursive cycle to
> confirm, otherwise there is nothing in your report to confirm. As I'm
> not a ftrace user myself, this isn't something I'd test for, so having
> a full report would be useful.

Is not having a backtrace related to ftrace_return_address() returning
NULL, as Arnd pointed out in
https://lore.kernel.org/linux-arm-kernel/36cd10de-c51c-40ff-90e8-7149540601=
9d@app.fastmail.com/
?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7xn6pigk3o4cbbv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZUfIoACgkQj4D7WH0S
/k4p5QgAljQA808piqzwUZbLYhJ2bf7KvIqeB0Dwb//4m069yPbZqYhXygaUfm9e
MP7QI0+of9XXLynZpjSe11FCxBwsL5tYBCLX+a8UVusfBhFgTEiHpqpvpTC0G+7c
0mS9LqbA2J6R4iEfAV1Zrh+aQVqsCMRqzsS9GgO2g5w2nyy0tZ5p8yj9SHCjmVmZ
jCewPzj28jlE/libZ/GI1Nk76qpI9RFnp8lYFU2dJL4D/+VCJjBMUUxLiWtKpu8Y
r4DeTQAzPl092W6yb9gKHgat7bmYUoa+LaQ0pDQlhPF/MBWHQqkW/q8euq+VUyta
r6eXPdyQE+VsS4Xf09VOnpzCRg9GQg==
=ZS3A
-----END PGP SIGNATURE-----

--7xn6pigk3o4cbbv7--
