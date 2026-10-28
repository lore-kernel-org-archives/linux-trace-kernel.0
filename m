Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200109;
	b=avolkDVHqe8CgBHDY79d+5E1PHapLSvwBQlDRTrc3v/FPl6wWzrPZoV6oOoAE64cTcqY
	 cDf83Kxd1p255r8ralQHlsBcVON7Fhd2r3WyvLXNaFH28Hsn5BDDy2J/Oj2urcb6pn95x
	 6it8E5cpk5Oh/I+owspDtmm/uOsHUkaFnAQxrb4zU7fqlf57L9wu/9a4IRBHNkfVD4OYE
	 P52FrxtRv0S7d9CLo9dHnq8p0hbn3OTHX4yA/UD7G8fOJiTZrbMzveiofzIM1uBQTfdO5
	 7aCN7PqPZoQmp56/8hgfRZ4eFNxvfOLXbCHWtXJE1Bpd1zVjjvIfAGcmR6Mtjtd6RUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200109;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=AV9Izra3OH9qTfxhuZXmSAF2xqmokRZ3T5Dfj3xJb44=;
	b=nDmV50dpESfTBSHOXCAhJ8P1J/YD3MlRMUYBhOKTGXXS0prxiZYSIEAj1GytCWJ+9E6a
	 aDSluT3st2s885blBnNWlnKEUsYH15MBerOeiGR45fCoPet/Jpw1NjS6BcjboOgGLV8Lj
	 TIXeJvsPFKSwbtrHfbiikpCp++9OZGUbi428t/MlckjpoNFKkqCR+FvYz0qdXafatLxcd
	 7AZ0LZY02l/62J9FlVRXAvM4UZZ94TPfMm6sPdzK3yTI0pwh+zdcIwVnls/w4lZkxUM/t
	 pVR4DOMVW2dCnsEF54pD8vRpXIS06R03U8fQ/Ppim5b6t7B7BZr4wuwVR0hDlsNlRdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WlfO4MPA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3A606A31A;
	Wed, 28 Oct 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WlfO4MPA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14061F01825;
	Wed, 28 Oct 2026 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793200108;
	bh=AV9Izra3OH9qTfxhuZXmSAF2xqmokRZ3T5Dfj3xJb44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WlfO4MPAMSt/WqYOMD4MglyspquZTUPiSWTmL2e2g6r63s+AL5rogH2i1GJW4mbg7
	 KRexbqaj0mqk9oRN5qUnfPiQn8NFCEiGuhPVaSPFyFeZVNMqPgTfRMjcxKr6sSKT4l
	 VR24hE1sIQWSLxJbGn4UF294VMt/SomRTElTL0tY=
Date: Wed, 28 Oct 2026 16:08:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>,
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
Message-ID: <2026102855-headache-salutary-5084@gregkh>
References: <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
 <at34UOuYv3NtX36R@monoceros>
 <20261026225950.GD1685504@ziepe.ca>
 <2026102849-turkey-series-ac07@gregkh>
 <auILBqh9Ccv7ztid@monoceros>
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
In-Reply-To: <auILBqh9Ccv7ztid@monoceros>

On Wed, Oct 28, 2026 at 03:50:44PM +0100, Uwe Kleine-König wrote:
> On Wed, Oct 28, 2026 at 02:45:18PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Oct 26, 2026 at 07:59:50PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Oct 25, 2026 at 01:48:04PM +0100, Uwe Kleine-König wrote:
> > > 
> > > > The more I think about this taint, the more I believe the commit should
> > > > be reverted and replaced by a some stop gaps for driver_override. (Be it
> > > > a taint or better yet
> > > > https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com/
> > > > .)
> > > 
> > > I also think this patch is way too broad and should be reverted until
> > > something better is designed.
> > 
> > Fair enough, I've sent a revert for now, will get it merged before -rc1
> > is out.
> 
> \o/, thanks
> 
> > I'll rework this for a later release, thanks.
> 
> Please look at the series behind the link above before investing time
> here. I think most of the ideas are already implemented there. If you
> voice your preferences there, I can rework accordingly and rebase on top
> of your revert.

How about rebasing now and submitting it and I can look at it that way?
That would be easier for me at least given my current workload...

thanks,

greg k-h
