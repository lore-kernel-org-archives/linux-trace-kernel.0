Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1BE3563FA;
	Sun, 27 Sep 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790527838; cv=none; b=rM5JuyNvR7FAdfKsAR99SVtVHCd+Oq5JC8ZlkmYzlVa3arGg1o8hWFDOV1Rw9DgobgJLrihNLPUNZ0r2o9KGdfKLpJRtDg7X8Y9O+RWoYh0lcgwE1BHb7zvedFwxuWJV+NSyEihU0miEJi55qF488D3exYKKs+pv3hPmUTFDa9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790527838; c=relaxed/simple;
	bh=P6jO0/dH/krInycGqZ4EXuopL9fWo85OEF9L80C6B+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsjC8Q4NDGRiu+bahG5OL57ETRUeaPAf9XS3/dCasBkr4CICDERF8YE1iKBZddEwgxhR05Gjzok0tx/A5oOdmukZys/w2tbQCqf0/Wuc2eCcfad6OqIe7EjARYBIdxX0s5yI/w5WW2L7TWupQedabDlwCTkHhel9fOLRkAU3+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMqs0mGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMqs0mGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC71E1F000FF;
	Sun, 27 Sep 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790527837;
	bh=zZmMyFXXoKqbhYyiYzTmGKu6inh6YzFvzMS87lBBNu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GMqs0mGlfqLjzE3sqF72YLfF+uBfrBC7DSmXT4OAp8B4+P11DZQLoXo1M+LbXUV0q
	 CT55ZY1/q/hCyXUJSEHsG4gK08EsdAP0uqTjzs02HM+kP12J35M1DWibxofa2q8GzR
	 VbtG0pO+PoHipkxxkXvc4WLKAXQlgR4pLd5MK1fo=
Date: Sun, 27 Sep 2026 18:50:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
	Bradley Morgan <brads@mainlining.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Message-ID: <2026092702-negation-stoppable-b86e@gregkh>
References: <cover.1790495516.git.u.kleine-koenig@baylibre.com>
 <01d7a085e56b860e83b65c96ff3dd86c4498804b.1790495516.git.u.kleine-koenig@baylibre.com>
 <DLQ0BIYP96RN.Z0L5I17RQMRQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DLQ0BIYP96RN.Z0L5I17RQMRQ@kernel.org>

On Sun, Sep 27, 2026 at 11:55:39AM +0200, Danilo Krummrich wrote:
> On Sun Sep 27, 2026 at 10:03 AM CEST, Uwe Kleine-König wrote:
> > Commit fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when
> > userspace manually messes with devices and drivers") introduced a taint
> > for usage of bind/unbind sysfs files that manually trigger driver probe
> > and remove respectively.
> >
> > For drivers that do their resource management correctly (which is also
> > needed for module unloading) bind and unbind for matching devices are
> > not critical operations. The thing that makes bind and unbind unsafe is
> > that drivers can be forced on devices that originally don't match using
> > driver_override. The result is that e.g. of_device_get_match_data()
> > returns NULL despite all .of_match_table entries having a non-NULL
> > .driver_data member which yields a NULL pointer exception for several
> > drivers. And given that after setting a driver_override a manual bind is
> > only one way a driver can be bound to an unexpected device, a separate
> > taint for such an override is justified.
> >
> > Reviewed-by: Bradley Morgan <brads@mainlining.org>
> > Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Link: https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kernel.org/
> 
> > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > index c51ad96d4de4..7d5dc016a457 100644
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -513,6 +513,7 @@ static ssize_t driver_override_store(struct device *dev,
> >  {
> >  	int ret;
> >  
> > +	add_taint_module(NULL, TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
> >  	ret = __device_set_driver_override(dev, buf, count);
> 
> There are buses (such as SPI) which unfortunately have to call
> __device_set_driver_override() directly.

Huh?  That feels wrong, can't we fix s390 and spi instead?  Ok, maybe
not s390, but why is spi doing that?

thanks,

greg k-h
