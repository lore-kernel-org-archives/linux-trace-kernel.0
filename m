Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018986;
	b=gfXRIn2b/FviYPVWHomr6FjTRG3ZAPjM38Zh2wq7OZqtKbEg/ADi8+BxGfTkdD0aLXwA
	 MFrDUSxS0/XkS3RLZHM4uJtKxlBItLEqVUmCHe7u8ScCOo66/a6ykPpsU5pmKoE9IsnPp
	 eGHMa+mQZDMeMTPHvTNu8vDpTmUO/nyfhDM1q/6NnBmwWFm7R9CXOd5pH2EQcMD85IUrb
	 oYgI8KwcBbzBRVXjDkfyCThITHoNdJJmmihs19OlD8KhxmCqh3lQGjSP2B/80Pm46PkaD
	 YUXTnOPzdQYdNuh4iA3xi8Ogl7BPwEMv2C7IKrD+bym1jS+QtaXue+n4yASMPXxgxtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018986;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=BP4fBJqiLkmGrQ8wqLuAyMRC1Gv5nQ1XGsYtwDS1hLs=;
	b=B2Szh2zliMScy0OIydfBdv2Lwp/Du9svz9Sw/xylxFmqRTxlBVInUYOB2bFqMiESNzG1
	 8s5XGGYQrTuu5uqZB6hhC/8zSaRU36dXCofsIfxfghB4O/2ntSszgUBRajuHyXoiHjnFq
	 BNDJw2Wuwp1f4YGSvR5AmtBlMpHs9JInpDB1rFiNhm/OXeR1Y4urBnr6iPhhy9or8sSIw
	 5Nc8g+92xbLRGzMM7f0CX0sQM2Kow2nhvcW/a1fkDSHpAkTJXvw+p3mp6gyaUgzTBGmwv
	 yeEH8upjKz+z8LcXB3TqsgAiQea1m31updH5SpaVYY37inD+yvx1VRELlDZ8khL7NaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+nPO2vP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFF606A31C;
	Wed, 18 Nov 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+nPO2vP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250D71F000C5;
	Wed, 18 Nov 2026 16:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018986;
	bh=BP4fBJqiLkmGrQ8wqLuAyMRC1Gv5nQ1XGsYtwDS1hLs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=k+nPO2vP+rbCWZAOmKSeMi+vhKwoLxmZxiQX94N4tMjEpvesoPZcyboBeOljIiM+/
	 baEg5EM1JJAQbpPR6A4Nmx/FT/ABvYFn4ZNf2zBm35QKIFiSTLN6ux7z4qWjh7j1FZ
	 eg3zf+fpu3KchpSihd2jccVKbIibcxerm9DZGAgxR+uEMf69biwThs6LOZlVIPzKJE
	 1qGlgEDi31eL0fL8o4CI7Bj8bOMLel+eA3LSjqi2dSr2O0kn6J/mYsLQgDrO/TWP7o
	 CRRMlbEvy0cO9O/y5aclMZCCupAiHc6PDFsDck3lbMJhPsqROmmHGXVB4h1xWOmxVp
	 d970ri4EeW8jg==
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 17:22:57 +0100
Message-Id: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
Subject: Re: [PATCH] driver core: Disable driver overriding by default
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Johan
 Hovold" <johan@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "David Lechner" <dlechner@baylibre.com>,
 "Armin Wolf" <W_Armin@gmx.de>, "Thierry Reding"
 <thierry.reding@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Karl Mehltretter"
 <kmehltretter@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, "Dapeng Mi"
 <dapeng1.mi@linux.intel.com>, "Marco Elver" <elver@google.com>, "Ethan
 Nelson-Moore" <enelsonmoore@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Bradley Morgan" <brads@mainlining.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Petr Mladek" <pmladek@suse.com>, "Pnina
 Feder" <pnina.feder@mobileye.com>, "Mete Durlu" <meted@linux.ibm.com>,
 "Aaron Tomlin" <atomlin@atomlin.com>, "Rio" <rioo.tsukatsukii@gmail.com>,
 "Feng Tang" <feng.tang@linux.alibaba.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-trace-kernel@vger.kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Alex Williamson" <alex@shazbot.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261116110853.3418077-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20261116110853.3418077-2-u.kleine-koenig@baylibre.com>

On Mon Nov 16, 2026 at 12:08 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> If this patch is accepted, a number of drivers that are supposed to be
> force-bound need to get their .support_driver_override property set. I'm
> aware of the following:
>
>  - spidev_spi_driver in drivers/spi/spidev.c
>  - stub_driver in drivers/pci/pci-stub.c
>  - uio_dmem_genirq in drivers/uio/uio_dmem_genirq.c
>  - uio_pci_driver in drivers/uio/uio_pci_generic.c
>  - uio_pdrv_genirq in drivers/uio/uio_pdrv_genirq.c
>  - vfio_amba_driver in drivers/vfio/platform/vfio_amba.c
>  - vfio_ccw_sch_driver in drivers/s390/cio/vfio_ccw_drv.c
>  - vfio_pci_driver in drivers/vfio/pci/vfio_pci.c
>  - vfio_platform_driver in drivers/vfio/platform/vfio_platform.c
>
> This is not needed for the userspace i2c driver.
>
> As the flag to set is only introduced in this patch and assuming this
> patch is accepted, I suggest to create an immutable branch for it to
> allow setting the needed flags in driver trees. Alternatively let all
> these go together via a single tree or branch.

Either is fine with me, but it's probably easier to just include the
corresponding patches in this series and merge them all together such that =
we
avoid having things broken in individual trees.

Can you please add the corresponding patches in a v2?
