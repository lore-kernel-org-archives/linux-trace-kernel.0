Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D647FAF3;
	Wed, 23 Sep 2026 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159419; cv=none; b=TiAMJCHaiANN6aLwA3ebbiDM8avj5VKPstVD7nLqscJqyFYRvXxEuyHzwNe2NYrhZQLG0Rm64IjA5i/xUH8ocdQxpz1JYTcU10xt9lN57gC5Je9l5X6E5p3f2xBjI2pOReKGais5Yx9nd+tOhQKTXsVEklSeZ+gHsca57ga5n6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159419; c=relaxed/simple;
	bh=4apTzgSnK41fmpqyWoxUgweK1yzL409akGVwvF+wtlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx+Z04u6+rMaU7FjWnWOG5DlT3h8jO21Wd8CosnLU/MMZ8I3Te6aqvv80Mvs2gdLD3SnZeNHo2ouT0hMML5fvqX3SSTQ4iq0CGgo0ytTTzKojaz/uArntoObWpE+EfDHEPH3KSowUD41cPul/x7Od376I0QXxFY5S7nUukSDIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+FgPbZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+FgPbZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBA41F000FF;
	Wed, 23 Sep 2026 10:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790159399;
	bh=6mPB5sAXT6Vhv1gBFH2na4lrNkRozl/FMt/dP7OxjRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I+FgPbZ4GvlC7BewOKRNZweanpyegBPw+Z7yAFipreUI0p/iDWPygp288TTzg9fNW
	 wG6Yil8IMbspsRFI6ZRrV4LujFy4JyuBlEph2Ub330vypNF3BGsVDnezRyMqqWWtxx
	 NYdOIla4kATkpDlNoDD//vIXw3e1SpHRXfpR7u/g=
Date: Wed, 23 Sep 2026 12:29:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>,
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
Message-ID: <2026092348-victory-erased-0e5a@gregkh>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arOfHEsGGglNse7T@monoceros>

On Wed, Sep 23, 2026 at 11:54:50AM +0200, Uwe Kleine-König wrote:
> > No, drivers should NOT have to do that in their .probe() function,
> > that's what we moved away from decades ago!  The match function should
> > handle all of that for you, otherwise it's contant duplication
> > everywhere that is unneeded.
> 
> Well then you have to accept that root can provoke a null pointer
> exception (e.g. by forcing the pwm-tegra driver on a device) because at
> least with today's platform bus match function such a match is ok.

Agreed, yes, root can cause a crash and can do tons of horrible things
much worse than this, that's not the issue.

That's why this taint is there, to make it obvious that this is not a
"real" bug at all.

> > Please, learn from our history, don't make the same mistakes.
> > 
> > Now I might be convinced that driver_override is the way to go here, but
> > it still feels really odd as again, bind/unbind was created as a driver
> > debugging option only, it should NOT be a normal operation that any user
> > should rely on.  The driver should "just work" properly instead, without
> > requiring manual bind work, as that's not a good model at all.
> 
> I agree in principle, but (in my case wifi) drivers are buggy sometimes
> (due to missing documentation and/or engineering effort) and being able
> to rebind the driver instead of rebooting to get a working device again
> is very useful.

Fine, use it!  Just don't expect that to be "normal".

> So yes, theoretically bind/unbind isn't needed, but theory and practise
> differ in practise.

Agreed, but again, don't rely on this as a "real" solution fo ranything.

> OK, as a compromise: Let's keep the taint (after all that's not
> destroying any functionality, just adding a hint for bug reports),
> and make driver_override opt-in, which should close an attack surface
> (mostly for fuzzers?) and so reduce the amount of bug reports instead of
> marking a part of them as tainted only.

How is that going to change anything?  Confused.

greg k-h
