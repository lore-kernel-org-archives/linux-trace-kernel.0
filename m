Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195121;
	b=X7xKENtqi91RZbRIGOHxikHOiGP4gyTCo7xYeuT2GwAw+HS3+p4BkeLnGeh0Ft8LIDxo
	 UnZsnfVrY4MBaEk0zZ6n6D1tFwTgBLDm43/8hNbi7sa11/tksgPQV6orXON5eEVmM/dT9
	 R/IOlvtpwt8+0lxfkPXgldYh1WRN9F/oHjxX1OgIBH1v+vf7pnWsfPo4jfWLuWZC5APjq
	 mHxWvzk1NqRcDNcuYjBOPQmlWTB2dBFrSFpVdo3/1cKmOTRx2kbIsrM71lhyX34vij3rc
	 Cui+Q/97vIT+dAROXeXKH//1JlnpD9vR2t4faJlUB7r+3qZh2WcZj+H4TMon5c9wgWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195121;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=BPbUskW5GkB+YFFCQWbdUTSwya3BztIU0iDu4a8e0BY=;
	b=ViOUZOFF9DFQtDF91FIZTd71Z+b3SvswfRN1Zb5t+DNtAvp3/GJGfi2kmFtAVzRwikBq
	 97+61WT8A3usN/2KhUz+Fwb/8+pBFi2TxsQ6IqhYvFxqB4ekpHgsOzpjzM41XsFIeaOGN
	 pIpdJ15Vm0cFID9g3aI4A6s5JGIKE5WAgoIxVeztnezmFwlNXzu/D3wS1wFhfMjwds4TN
	 0+j9HyqWXVcB8+TfMVydMjGnzQkhGCY3jVptv9A41MdW008EUiXDrMvMfr22N/mmBG0ui
	 ceOv5iEPNJy9gszBDN/WW66ALWaeJFcozMmzs/Vg4XCrT4SuYGiaho5PbdxTR8NIH+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AYNCMfQX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EEA606A31A;
	Wed, 28 Oct 2026 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AYNCMfQX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051FF1F01829;
	Wed, 28 Oct 2026 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793195120;
	bh=BPbUskW5GkB+YFFCQWbdUTSwya3BztIU0iDu4a8e0BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AYNCMfQXpWUvhGZFKn5xU0ZCMGAKmlspmwCeZ9ZCefMqGGnmqpuf5D3P6Td6gZC4E
	 r1swyl/vJk4OZiLWsitpItds9cilodWxb+BvrkPnf26MXQQPkJoHcPDF2DucZe0UZk
	 ELKtK3sWlmezqmOnyZd6Edp1j2zDqPRpmw0jt35o=
Date: Wed, 28 Oct 2026 14:45:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Alex Williamson <alex@shazbot.org>, Armin Wolf <W_Armin@gmx.de>,
	David Lechner <dlechner@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <2026102849-turkey-series-ac07@gregkh>
References: <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
 <at34UOuYv3NtX36R@monoceros>
 <20261026225950.GD1685504@ziepe.ca>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026225950.GD1685504@ziepe.ca>

On Mon, Oct 26, 2026 at 07:59:50PM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 25, 2026 at 01:48:04PM +0100, Uwe Kleine-König wrote:
> 
> > The more I think about this taint, the more I believe the commit should
> > be reverted and replaced by a some stop gaps for driver_override. (Be it
> > a taint or better yet
> > https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com/
> > .)
> 
> I also think this patch is way too broad and should be reverted until
> something better is designed.

Fair enough, I've sent a revert for now, will get it merged before -rc1
is out.  I'll rework this for a later release, thanks.

greg k-h
